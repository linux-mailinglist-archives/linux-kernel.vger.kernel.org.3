Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0674C7817
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 19:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbiB1SlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 13:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240546AbiB1Sk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 13:40:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578D7FDE;
        Mon, 28 Feb 2022 10:34:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 08697B81626;
        Mon, 28 Feb 2022 18:34:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DADC340E7;
        Mon, 28 Feb 2022 18:34:36 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="oGJGxbfO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1646073274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/FdY4NAiU1tX9KqAY5+mN5z4QxIC3RkhBmSJSjqB4AI=;
        b=oGJGxbfOARcAlVZiJzVzpZNt2+8dVPKBfchCynJss6e2v/UZpaSL1iTm9H0F2bvGI1EGmi
        yUUB7uQSkxQbxQxijFs2qW6I4Wwur8nVpAk9n7A6HAngODF/C/gPj8y4Lf1RAmzIjaxUat
        Ejj1SzHLRtFZJFpzLr0OMtUvpuYCO7E=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 19209f25 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 28 Feb 2022 18:34:33 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-acpi@vger.kernel.org, Alexander Graf <graf@amazon.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH 2/3 v6] ACPI: allow longer device IDs
Date:   Mon, 28 Feb 2022 19:33:55 +0100
Message-Id: <20220228183355.9090-1-Jason@zx2c4.com>
In-Reply-To: <CAHmME9qHnvwrxEue4Pdm_E1qZQGXFuR9orJSKCWj8fH5TSh6fA@mail.gmail.com>
References: <CAHmME9qHnvwrxEue4Pdm_E1qZQGXFuR9orJSKCWj8fH5TSh6fA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Graf <graf@amazon.com>

We create a list of ACPI "PNP" IDs which contains _HID, _CID, and CLS
entries of the respective devices. However, when making structs for
matching, we squeeze those IDs into acpi_device_id, which only has 9
bytes space to store the identifier. The subsystem actually captures the
full length of the IDs, and the modalias has the full length, but this
struct we use for matching is limited. It originally had 16 bytes, but
was changed to only have 9 in 6543becf26ff ("mod/file2alias: make
modalias generation safe for cross compiling"), presumably on the theory
that it would match the ACPI spec so it didn't matter.

Unfortunately, while most people adhere to the ACPI specs, Microsoft
decided that its VM Generation Counter device [1] should only be
identifiable by _CID with a value of "VM_Gen_Counter", which is longer
than 9 characters.

To allow device drivers to match identifiers that exceed the 9 byte
limit, this simply ups the length to 16, just like it was before the
aforementioned commit. Empirical testing indicates that this
doesn't actually increase vmlinux size on 64-bit, because the ulong in
the same struct caused there to be 7 bytes of padding anyway, and when
doing a s/M/Y/g i386_defconfig build, the bzImage only increased by
0.0055%, so negligible.

This patch is a prerequisite to add support for VMGenID in Linux, the
subsequent patch in this series. It has been confirmed to also work on
the udev/modalias side in userspace.

[1] https://download.microsoft.com/download/3/1/C/31CFC307-98CA-4CA5-914C-D9772691E214/VirtualMachineGenerationID.docx

Signed-off-by: Alexander Graf <graf@amazon.com>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Len Brown <lenb@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Co-authored-by: Jason A. Donenfeld <Jason@zx2c4.com>
[Jason: reworked commit message a bit, went with len=16 approach.]
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Hi Rafael,

This patch is directed toward you specifically. The first and last patch
of the series this is part of have been through the ringer of review a
bit already and do not specifically require your attention, but we wound
up getting hung up on an ACPI ID matching API limitation. This patch
fixes that limitation with this patch that you see here, with a trivial
one line fix, which does require your attention.

The other patches will go through my random.git tree naturally, but
because those patches depend on this one here, in order to compile
without warnings (and be functional at all), it would be nice if you
would provide an "Acked-by" on it and permit me to /also/ take it
through my random.git tree (if it looks like a correct patch to you, of
course). This would make the merge logistics a lot easier. Plus it's a
small +1/-1 line change.

This v6 updates the commit message.

Please have a look and let me know what you think.

Thanks,
Jason

 include/linux/mod_devicetable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 4bb71979a8fd..5da5d990ff58 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -211,7 +211,7 @@ struct css_device_id {
 	kernel_ulong_t driver_data;
 };
 
-#define ACPI_ID_LEN	9
+#define ACPI_ID_LEN	16
 
 struct acpi_device_id {
 	__u8 id[ACPI_ID_LEN];
-- 
2.35.1

