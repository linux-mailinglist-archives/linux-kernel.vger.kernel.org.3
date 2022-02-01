Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECE34A6861
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 00:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242750AbiBAXK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 18:10:26 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45046 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiBAXKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 18:10:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ABBCBB82FD8;
        Tue,  1 Feb 2022 23:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C993C340F1;
        Tue,  1 Feb 2022 23:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643757022;
        bh=gi5o6dpz7na3yVLbzTMfa4s0kn8nCEfsUwJHFYwxi08=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pU7qVWUbnSynUPL1v+Dmhh4lCiROtG51BOLCypsP8S6aI6bg6hIX2YGrwlRxA4zGb
         Hh3U5MqfBXbMyH2Pl6Rgthp6D7f8MgFQywGRlWdHdqLWCfLZyF5iHYAFCk/2VBVqJ2
         DBn7fEtt1d48Wuo57V9srRF/qmepxT3PoM5DNz+1eMweK3odHSFA53ILeBKuiaUnYt
         /mepOV0uWAqgwJA2JYHH08ArVI6paf5O4XdkThlE13a7dmG5jry9Jg4yMO21x6fq9g
         HLPT61Ev8j56c4pDlQlRGZ5S6K2qQHQMZrhInbHmDgXMbUzMrUkleOoDhR1xpIMiQ3
         b1gXg/kpW/iQg==
Received: by mail-oi1-f179.google.com with SMTP id r27so14262340oiw.4;
        Tue, 01 Feb 2022 15:10:22 -0800 (PST)
X-Gm-Message-State: AOAM531ELpD+uskS5uvpAJtOeJ64Zvcia5L0mgnYM/f2dmsvs5ayX87y
        99130h7pGPg9F6Bv11TBsItWpormcXTY4fN4glU=
X-Google-Smtp-Source: ABdhPJx5g206As8cpZBYqv6w80xI5VEhOIz0J1a+u8x+FqaOVX3lKBBdEl3+H731tsMzyLepBKrMl7KGoCBuHXlv4bg=
X-Received: by 2002:aca:2b16:: with SMTP id i22mr2545030oik.128.1643757021480;
 Tue, 01 Feb 2022 15:10:21 -0800 (PST)
MIME-Version: 1.0
References: <20220201150339.1028032-1-arnd@kernel.org> <90333cef-9ad1-bbf5-5c46-86083c1f5b24@arm.com>
 <YflyZytGG49kbvV9@shell.armlinux.org.uk>
In-Reply-To: <YflyZytGG49kbvV9@shell.armlinux.org.uk>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 2 Feb 2022 00:10:04 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0jFMhtajAA9L6u56fbFRxBXhhsfMrfGisHdoP8qCFKMg@mail.gmail.com>
Message-ID: <CAK8P3a0jFMhtajAA9L6u56fbFRxBXhhsfMrfGisHdoP8qCFKMg@mail.gmail.com>
Subject: Re: [RFC] ARM: sa1100/assabet: move dmabounce hack to ohci driver
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        USB list <linux-usb@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 1, 2022 at 6:48 PM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
> On Tue, Feb 01, 2022 at 05:10:38PM +0000, Robin Murphy wrote:
> >
> > Hmm, my reading of it was different. AFAICS it should affect all platforms
> > with CONFIG_ARCH_SA1100 + CONFIG_SA1111 - the bus notifier from
> > sa1111_init() will initialise dmabounce for everything where
> > sa1111_configure_smc() has punched a hole in the DMA mask to handle the
> > addressing erratum. sa1111_needs_bounce() looks to be a further
> > consideration for platforms where DMA *additionally* cannot target an entire
> > bank of memory at all.
>
> Correct. The SA1111 companion can only access one SDRAM bank, whereas
> the SA1110 SoC can address up to four SDRAM banks. On platforms where
> there is only one bank of SDRAM, there is no issue. However, on the
> Assabet there is one SDRAM bank, and on the Neponset daughter board
> with the SA1111, there is a second bank. As explained in the commentry,
> the SA1111 can be hardware-configured via resistive jumpers to access
> either bank, but we only support the factory-shipped configuration,
> which is bank 0 (the lowest addressable bank.)

Ok, so this is the part that I think my patch gets right.

> The SA1111 also has an issue that one of its address lines doesn't
> behave correctly, and depending on the SDRAM columns/rows, this
> punches multiple holes in the SDRAM address space it can access,
> which is what the sa1111_dma_mask[] array is about, and we end up
> with every alternate megabyte of physical address space being
> inaccessible.
>
> The DMA mask, along with the logic in dmabounce (which truely uses the
> DMA mask as, erm, a *mask* rather than the misnamed *limit* that it
> has been) know about both of these issues.

while this part would not work if dma_alloc_flags() ends up getting
memory that is not accessible. At the minimum I need to drop the
machine_is_assabet() check and always allocate a safe buffer to
back hcd->local_mem regardless of the machine.

After reading through the dmabounce code again, my interpretation
is that the safe buffer it uses for bounces ultimately relies on
dma_alloc_coherent() allocating physical pages using GFP_DMA,
which in turn is sized to 1MB on the machines that need it.

If I'm not missing something else, using dmam_alloc_flags() in the
local_mem code should work with the same address restrictions, so
I hope I only need to update the changelog text plus the trivial change
below.

         Arnd

@@ -207,6 +207,14 @@ static int ohci_hcd_sa1111_probe(struct sa1111_dev *dev)
        }

        /*
+        * According to the "Intel StrongARM SA-1111 Microprocessor Companion
+        * Chip Specification Update" (June 2000), erratum #7, there is a
+        * significant bug in the SA1111 SDRAM shared memory controller.  If
+        * an access to a region of memory above 1MB relative to the bank base,
+        * it is important that address bit 10 _NOT_ be asserted. Depending
+        * on the configuration of the RAM, bit 10 may correspond to one
+        * of several different (processor-relative) address bits.
+        *
         * Section 4.6 of the "Intel StrongARM SA-1111 Development Module
         * User's Guide" mentions that jumpers R51 and R52 control the
         * target of SA-1111 DMA (either SDRAM bank 0 on Assabet, or
@@ -214,13 +222,14 @@ static int ohci_hcd_sa1111_probe(struct sa1111_dev *dev)
         * Assabet, so any address in bank 1 is necessarily invalid.
         *
         * As a workaround, use a bounce buffer in addressable memory
-        * as local_mem.
+        * as local_mem, relying on ZONE_DMA to provide an area that
+        * fits within the above constraints.
+        *
+        * SZ_64K is an estimate for what size this might need.
         */
-       if (machine_is_assabet()) {
-               ret = usb_hcd_setup_local_mem(hcd, 0, 0, SZ_64K);
-               if (ret)
-                       goto out_err1;
-       }
+       ret = usb_hcd_setup_local_mem(hcd, 0, 0, SZ_64K);
+       if (ret)
+               goto out_err1;

        if (!request_mem_region(hcd->rsrc_start, hcd->rsrc_len, hcd_name)) {
                dev_dbg(&dev->dev, "request_mem_region failed\n");
