Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E854C5872
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 23:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiBZWHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 17:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiBZWHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 17:07:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA0A2BA9D9;
        Sat, 26 Feb 2022 14:07:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA640B80B23;
        Sat, 26 Feb 2022 22:07:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F933C340F1;
        Sat, 26 Feb 2022 22:07:03 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="hVhDgdre"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1645913222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rJ7OlRCsSS8WuKwouw4P6E2HpFGNT8cQ0NpTG5KRx9U=;
        b=hVhDgdre7bjlMbXXbSOSSAq6teSp7bYMMbtGrCAEtg11r6jGCLmYJoAdq3KtDb8QhRJar+
        gkKIa77ExzrSJZX6eU1xV72g4pZ4sM86Bm04B+K6Fq6StIqvxgJsz0qDUHYdBbu1ODFRKj
        Tgtp68wJFRqJBnKCnc74Z/EBu0F0xd8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id af55e8a1 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 26 Feb 2022 22:07:02 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-crypto@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v5 2/3] ACPI: allow longer device IDs
Date:   Sat, 26 Feb 2022 23:06:38 +0100
Message-Id: <20220226220639.1173594-3-Jason@zx2c4.com>
In-Reply-To: <20220226220639.1173594-1-Jason@zx2c4.com>
References: <20220226220639.1173594-1-Jason@zx2c4.com>
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
entries of the respective devices. However, we squeeze them into struct
acpi_device_id, which only has 9 bytes space to store the identifier. It
originally had 16 bytes, but was changed to only have 9 in 6543becf26ff
("mod/file2alias: make modalias generation safe for cross compiling"),
presumably on the theory that it would match the ACPI spec so it didn't
matter.

Unfortunately, while most people adhere to the ACPI specs, Microsoft
decided that its VM Generation Counter device [1] should only be
identifiable by _CID with a value of "VM_Gen_Counter", which is longer
than 9 characters.

To allow device drivers to match identifiers that exceed the 9 byte
limit, this simply ups the length to 16, just like it was before the
aforementioned commit. Empirical testing indicates that this
doesn't actually increase vmlinux size, because the ulong in the same
struct caused there to be 7 bytes of padding anyway.

This patch is a prerequisite to add support for VMGenID in Linux, the
subsequent patch in this series. It has been confirmed to also work on
the udev/modalias side in userspace.

[1] https://download.microsoft.com/download/3/1/C/31CFC307-98CA-4CA5-914C-D9772691E214/VirtualMachineGenerationID.docx

Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Co-authored-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Alexander Graf <graf@amazon.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Hi Rafael & Len,

This patchset is directed toward you two specifically. Patches 1/3 and
3/3 have been through the ringer of review a bit already and do not
specifically require your attention, but in v4 we wound up getting hung
up on an ACPI API limitation. This v5 fixes that limitation with this
2/3 patch that you see here, with a trivial one line fix, which does
require your attention.

Patches 1/3 and 3/3 will go through my random.git tree. However, 3/3
actually depends on this one here, 2/3, in order to compile without
warnings (and be functional at all). Therefore, it would be nice if you
would provide an "Acked-by" on it and permit me to /also/ take it
through my random.git tree (if it looks like a correct patch to you, of
course). This would make the merge logistics a lot easier. Plus it's a
small +1/-1 line change.

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

