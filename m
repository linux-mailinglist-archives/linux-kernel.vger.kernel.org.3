Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9DD4C4D38
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 19:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbiBYSEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 13:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbiBYSE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 13:04:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0F92782B2;
        Fri, 25 Feb 2022 10:03:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3961B832FF;
        Fri, 25 Feb 2022 18:03:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7175C340E7;
        Fri, 25 Feb 2022 18:03:51 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="eARxTiEQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1645812230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0JwnluJWh9ISVuCRz/Wj75ot5Xs+z8IJLVRCYYQrux4=;
        b=eARxTiEQyoIuonpY6208HwR1fpAqO34IWhfQ8EI1ngd1X9p3yHCJILxhu31ItaHKHTCvCd
        BD8oKak7n+UC6S5iy4W2NcYAjHEuWMy487QbYoQc70e4V/3ohd6LZNYQRrzhnjBc2YQAWO
        Dsc27R2RUNY1SNtofKZ9DRLXiv/CF24=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 718e1f96 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 25 Feb 2022 18:03:50 +0000 (UTC)
Date:   Fri, 25 Feb 2022 19:03:45 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Alexander Graf <graf@amazon.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>
Subject: Re: [PATCH] ACPI: bus: Match first 9 bytes of device IDs
Message-ID: <YhkaAUQ/5ChlKlXt@zx2c4.com>
References: <20220225155552.30636-1-graf@amazon.com>
 <CAMj1kXGtANm3SMoREymDSyx+wpn3L=Ex5q5mpgQigOwmEp33Lg@mail.gmail.com>
 <YhkQKfE8ErtFBmSB@zx2c4.com>
 <CAMj1kXEtUUod8Hp6VhS6k7iDKYkFj_t_J=qS2XF1p2X_SFdTvg@mail.gmail.com>
 <CAHmME9oJpL_y4bDaLwrZZZ54p5_C0YF9=vW7Zz1iUhpBHx2TvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHmME9oJpL_y4bDaLwrZZZ54p5_C0YF9=vW7Zz1iUhpBHx2TvA@mail.gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 06:33:42PM +0100, Jason A. Donenfeld wrote:
> Either way is fine by me. Looking at all the current users of
> ACPI_ID_LEN, none of them really mind if it's >9. I can't see where
> it'd change any behavior or performance or really anything at all,
> anywhere. So I'm inclined to go with my original simpler solution. But
> again, either way is fine.
> 
> Alex, do you want to pick one of these and submit a v2 based on it? Or
> do you see a shortcoming in that approach?

I can confirm from testing that the below trivial diff fixes the issue.
I believe Ard is looking into the userspace/udev ramifications.

diff --git a/drivers/virt/vmgenid.c b/drivers/virt/vmgenid.c
index b503c210c2d7..4542ebb68ae0 100644
--- a/drivers/virt/vmgenid.c
+++ b/drivers/virt/vmgenid.c
@@ -78,8 +78,7 @@ static void vmgenid_acpi_notify(struct acpi_device *device, u32 event)
 }

 static const struct acpi_device_id vmgenid_ids[] = {
-	{ "QEMUVGID", 0 },	/* QEMU */
-	{ "VMGENID", 0 },	/* Firecracker */
+	{ "VM_GEN_COUNTER", 0 },
 	{ },
 };

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

