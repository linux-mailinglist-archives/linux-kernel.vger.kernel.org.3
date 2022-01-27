Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6566F49EA59
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 19:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245056AbiA0S1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 13:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245031AbiA0S13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 13:27:29 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69337C06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 10:27:29 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id s16so2863967pgs.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 10:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MNivNvUnaKSgwbpns2UVVvnIdkdqtYkTnr6WB2iM4KA=;
        b=gllWnbpFTXspZZKWYL6D48c9RKSRla76rbNqeiKJIyMWso3urPfaXYf5mlKmhLEPv3
         jQwCpWjIxNGi0Z9FulEM0RO5iOavTe4RxwN54bCywkhSZWBTe/tb94ihD2e3PHT7TKUd
         heFlTy9zaEA+v/ID6Ehh6ShWwd1yysTdneZvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MNivNvUnaKSgwbpns2UVVvnIdkdqtYkTnr6WB2iM4KA=;
        b=G9y8oK4lacwrM5WKx7aN4fFv3RReVIYj8O1t+QRHSYCkhpmJJ2XY+NsKbBdkfunZk+
         SLn+q/9LCGYQpnsxuuB5R9+QaLcXzckhX2a5FXJb+lhS3HW8RHcP8ENcL2/DVVlwtzD9
         L3k/W8Ngc6/CkEFM7OpyjUkSq8jQH+zk3zZC+GX6KdOMBCDjXDBM7sxVKwax0O0OIU4w
         X5OOz8sxOfht/sa8hYUbp9UKWcFEr5uF7XmVEgMefWBLRAVQ+qkR79uEdKgHQoO/Qymf
         5T+zq0FqeDKUzcGzTxYI9SRMCyLwpQaVLuv2J3dMNiB8AXh0SFvHmE+q4+J6fNDnwm3+
         kH3Q==
X-Gm-Message-State: AOAM5331ESKfxD6fIo+cvjMcVNYab5BTcRUA1gqhaQ9rn6l/zwqvW32O
        gyYz4plaurOXvupm98j2FI9a9vQaploTcCTk/QqjMA==
X-Google-Smtp-Source: ABdhPJyvr4XXBdjJYE2+bPzEi7tzwtlCduA2yyQMlSEcrrOWF+pcjcs4b1mo2C1oHfWzkn1FHwI3cX8JzQl+5Sbuxvs=
X-Received: by 2002:a05:6a00:7ce:: with SMTP id n14mr4408175pfu.11.1643308048948;
 Thu, 27 Jan 2022 10:27:28 -0800 (PST)
MIME-Version: 1.0
References: <20220126073227.3401275-1-chentsung@chromium.org>
 <8625876c695685fc5409997403130194@walle.cc> <CAMu4cy5onQ2JNKhoLVmR4Nb7Cqv2L59SoE=2Q9CK8bhfPvvHTQ@mail.gmail.com>
 <ea37e84c8c83350d089c6c9ed4474851@walle.cc>
In-Reply-To: <ea37e84c8c83350d089c6c9ed4474851@walle.cc>
From:   Chen-Tsung Hsieh <chentsung@chromium.org>
Date:   Fri, 28 Jan 2022 02:27:17 +0800
Message-ID: <CAMu4cy5qkxuXnPnS5TsLYp3ME0jruaUWLt1QOSmZR78BzYVQzw@mail.gmail.com>
Subject: Re: [RESEND PATCH] mtd: spi-nor: core: Check written SR value in spi_nor_write_16bit_sr_and_check()
To:     Michael Walle <michael@walle.cc>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 5:18 PM Michael Walle <michael@walle.cc> wrote:
> Ah that ring a bell... Anyway, could you dump the SFDP data please?
> See [1], you'll find the files in sysfs. I wonder why that flash is
> using the 16bit write at all.
>
> [1]
> https://lore.kernel.org/linux-mtd/4304e19f3399a0a6e856119d01ccabe0@walle.cc/

Dump SFDP data:
# xxd -p /sys/class/mtd/mtd0/device/spi-nor/sfdp
53464450060101ff00060110800000ff84000102d00000ffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffe520f9ffffffff0344eb086b083b42bbfeffffffffff
0000ffff40eb0c200f5210d800003602a60082ea14c4e96376337a757a75
f7bdd55c19f75dffe930f880ffffffffffffffffffffffffffffffff0000
f0ffffffffff
# md5sum /sys/class/mtd/mtd0/device/spi-nor/sfdp
5294c4d4eb2b1c89c6fd8573d8ceaa2d  /sys/class/mtd/mtd0/device/spi-nor/sfdp
# cat /sys/class/mtd/mtd0/device/spi-nor/jedec_id
ef8017
# cat /sys/class/mtd/mtd0/device/spi-nor/partname
w25q64jwm
# cat /sys/class/mtd/mtd0/device/spi-nor/manufacturer
winbond

"bfpt.dwords[BFPT_DWORD(15)]" is 0xff5df719, and flag
SNOR_F_HAS_16BIT_SR is set here:
        case BFPT_DWORD15_QER_SR2_BIT1:
                /*
                 * JESD216 rev B or later does not specify if writing only one
                 * byte to the Status Register clears or not the Status
                 * Register 2, so let's be cautious and keep the default
                 * assumption of a 16-bit Write Status (01h) command.
                 */
                nor->flags |= SNOR_F_HAS_16BIT_SR;
                params->quad_enable = spi_nor_sr2_bit1_quad_enable;
                break;
