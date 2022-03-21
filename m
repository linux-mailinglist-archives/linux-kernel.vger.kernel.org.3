Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183194E2444
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 11:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346299AbiCUK0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 06:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344141AbiCUK0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 06:26:13 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B597A6E2C;
        Mon, 21 Mar 2022 03:24:47 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id m67so27144099ybm.4;
        Mon, 21 Mar 2022 03:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rcSdYfrZipf0SiXPcMUPLDzYkml4NkmAOteqrH8oRIU=;
        b=pdGPCE9rMxprzcwHkfgN1nZRLdf1NVd8snc47dTsJiwNi0TAVOnfNlrtRmAJiKTw9z
         KkZVbX2+FhFm8QCI0jEFc+bbahlOpAsMFbWkigBhi4+ZcmWbD5WKRjbKKrFDYnNWusGY
         4MH8MO+ZCdpjh79X62oxbm6BEU4nGo7Tl3W2Sy7Sp4Xn/8hBv/Bhxdv8v2A2QbU0fJq4
         ibbehPBecwauFe2rmIuXvlm2y7N0uMS23kIoWIDzw5kU7W2JYCfM05yHaajBc8Y/gi7Y
         mkC0EkW8QKehgePWpZwRi+ez/s5nwz3kU47Us8j8eyqiYNPen+/5Z1aaoOXv/OxlazSa
         RTGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rcSdYfrZipf0SiXPcMUPLDzYkml4NkmAOteqrH8oRIU=;
        b=1eBsa0Oy+K7mrLFtws7+PbMC3VdyxDH89cuE4RmraopX5oxg8m4jrVLArnzAgzdf8X
         biqtRqsyepXH6E8GGlD/v3WnJf9NxBHNWFaELGd0q4w/soDSDKZ1klLyz2eiylYax7Iu
         k4hpKMJtBF+4IRPsUjP3MDjsdKjHZqXdRIb2HsgE+QdOKWPVXKkMrFTQfNAL3Q0o1U3P
         hBjnc3NzzBFjE0/Q/vS8PwjPbAr+/jbkTc6aTCAKOcoRlt1R/8OFSTGSXBPfA88HttFL
         ssQiXNL1PAfD4JJ46hPFGbjamFbntO6DzuSpZ9qdH8npCrcAlk+UryKnKVbQ5b7ukffw
         Hd4w==
X-Gm-Message-State: AOAM532yvFCNTf1T0hc9dtAjf+fa8RdYl3Dbvl7vjQ91qEMCxzJp17eY
        dl/Of0F+p1PyJWppDGG7RnMN1Mjb635+HMvQIn4=
X-Google-Smtp-Source: ABdhPJxgUBIURe7xfrXiN5/KftAEruWBQao0JAX7qRWDX0d/XbLm4sIsVuBKGVndPZOm5/Z+rPZHmanGbS0I/vZt2vM=
X-Received: by 2002:a25:8289:0:b0:623:dc4d:28e5 with SMTP id
 r9-20020a258289000000b00623dc4d28e5mr20763276ybk.182.1647858286512; Mon, 21
 Mar 2022 03:24:46 -0700 (PDT)
MIME-Version: 1.0
References: <b409ea3fae4a6778fd6b44815ad17c9e8e10df87.1647512831.git.geert+renesas@glider.be>
In-Reply-To: <b409ea3fae4a6778fd6b44815ad17c9e8e10df87.1647512831.git.geert+renesas@glider.be>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 21 Mar 2022 10:24:20 +0000
Message-ID: <CA+V-a8uXR=doVFr-yAFQphpqa175jD=1ncRbhDr5xzh6e=LAKQ@mail.gmail.com>
Subject: Re: [PATCH v2] memory: renesas-rpc-if: Fix HF/OSPI data transfer in
 Manual mode
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Dung Nguyen <dung.nguyen.zy@renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Mark Brown <broonie@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Thu, Mar 17, 2022 at 12:54 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> HyperFlash devices fail to probe:
>
>     rpc-if-hyperflash rpc-if-hyperflash: probing of hyperbus device failed
>
> In HyperFLASH or Octal-SPI Flash mode, the Transfer Data Enable bits
> (SPIDE) in the Manual Mode Enable Setting Register (SMENR) are derived
> from half of the transfer size, cfr. the rpcif_bits_set() helper
> function.  However, rpcif_reg_{read,write}() does not take the bus size
> into account, and does not double all Manual Mode Data Register access
> sizes when communicating with a HyperFLASH or Octal-SPI Flash device.
>
> Fix this, and avoid the back-and-forth conversion between transfer size
> and Transfer Data Enable bits, by explicitly storing the transfer size
> in struct rpcif, and using that value to determine access size in
> rpcif_reg_{read,write}().
>
> Enforce that the "high" Manual Mode Read/Write Data Registers
> (SM[RW]DR1) are only used for 8-byte data accesses.
> While at it, forbid writing to the Manual Mode Read Data Registers,
> as they are read-only.
>
> Fixes: fff53a551db50f5e ("memory: renesas-rpc-if: Correct QSPI data transfer in Manual mode")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Lightly (read-only) tested on:
>   - Salvator-XS with R-Car M3-W ES1.0 with HyperFLASH,
>   - Falcon with R-Car V3U ES1.0 with QSPI.
>
> v2:
>   - Use rpc->xfer_size instead of SPIDE register reads and
>     rpc->bus_size.
>       Note: Alternatively, rpcif_manual_xfer() could bypass regmap and
>       use {read,write}[bwl]() directly, cfr. commit 0d37f69cacb33435
>       ("memory: renesas-rpc-if: Correct QSPI data transfer in Manual
>       mode") in the BSP.
>   - HF dirmap reads are confirmed to work on R-Car M3-W,
>   - Drop RFC.
>
> On Salvator-XS with unlocked HyperFlash, the HyperFlash is now detected
> again, cfr. (with DEBUG_CFI enabled):
>
>     Number of erase regions: 1
>     Primary Vendor Command Set: 0002 (AMD/Fujitsu Standard)
>     Primary Algorithm Table at 0040
>     Alternative Vendor Command Set: 0000 (None)
>     No Alternate Algorithm Table
>     Vcc Minimum:  1.7 V
>     Vcc Maximum:  1.9 V
>     No Vpp line
>     Typical byte/word write timeout: 512 \xc2\xb5s
>     Maximum byte/word write timeout: 2048 \xc2\xb5s
>     Typical full buffer write timeout: 512 \xc2\xb5s
>     Maximum full buffer write timeout: 2048 \xc2\xb5s
>     Typical block erase timeout: 1024 ms
>     Maximum block erase timeout: 4096 ms
>     Typical chip erase timeout: 262144 ms
>     Maximum chip erase timeout: 1048576 ms
>     Device size: 0x4000000 bytes (64 MiB)
>     Flash Device Interface description: 0x0000
>       - x8-only asynchronous interface
>     Max. bytes in buffer write: 0x200
>     Number of Erase Block Regions: 1
>       Erase Region #0: BlockSize 0x40000 bytes, 256 blocks
>     rpc-if-hyperflash: Found 1 x16 devices at 0x0 in 16-bit bank. Manufacturer ID 0x000001 Chip ID 0x007000
>     Amd/Fujitsu Extended Query Table at 0x0040
>       Amd/Fujitsu Extended Query version 1.5.
>     rpc-if-hyperflash: CFI contains unrecognised boot bank location (0). Assuming bottom.
>     number of CFI chips: 1
>
> v1: https://lore.kernel.org/r/27107f2d578b198078df841ee2e4d7b71b183898.1647017136.git.geert+renesas@glider.be/
> ---
>  drivers/memory/renesas-rpc-if.c | 56 ++++++++++++++++++++++++++-------
>  include/memory/renesas-rpc-if.h |  1 +
>  2 files changed, 45 insertions(+), 12 deletions(-)
>
I did some testing on RZ/G2L SMARC EVK. My read/write test case is
passing [0] for QSPI flash.

Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

[0] https://paste.debian.net/1235083/

Cheers,
Prabhakar

> diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
> index e4cc64f560196d55..a8c7abe1cf00be65 100644
> --- a/drivers/memory/renesas-rpc-if.c
> +++ b/drivers/memory/renesas-rpc-if.c
> @@ -171,18 +171,32 @@ static int rpcif_reg_read(void *context, unsigned int reg, unsigned int *val)
>  {
>         struct rpcif *rpc = context;
>
> -       if (reg == RPCIF_SMRDR0 || reg == RPCIF_SMWDR0) {
> -               u32 spide = readl(rpc->base + RPCIF_SMENR) & RPCIF_SMENR_SPIDE(0xF);
> -
> -               if (spide == 0x8) {
> +       switch (reg) {
> +       case RPCIF_SMRDR0:
> +       case RPCIF_SMWDR0:
> +               switch (rpc->xfer_size) {
> +               case 1:
>                         *val = readb(rpc->base + reg);
>                         return 0;
> -               } else if (spide == 0xC) {
> +
> +               case 2:
>                         *val = readw(rpc->base + reg);
>                         return 0;
> -               } else if (spide != 0xF) {
> +
> +               case 4:
> +               case 8:
> +                       break;
> +
> +               default:
>                         return -EILSEQ;
>                 }
> +               break;
> +
> +       case RPCIF_SMRDR1:
> +       case RPCIF_SMWDR1:
> +               if (rpc->xfer_size != 8)
> +                       return -EILSEQ;
> +               break;
>         }
>
>         *val = readl(rpc->base + reg);
> @@ -193,18 +207,34 @@ static int rpcif_reg_write(void *context, unsigned int reg, unsigned int val)
>  {
>         struct rpcif *rpc = context;
>
> -       if (reg == RPCIF_SMRDR0 || reg == RPCIF_SMWDR0) {
> -               u32 spide = readl(rpc->base + RPCIF_SMENR) & RPCIF_SMENR_SPIDE(0xF);
> -
> -               if (spide == 0x8) {
> +       switch (reg) {
> +       case RPCIF_SMWDR0:
> +               switch (rpc->xfer_size) {
> +               case 1:
>                         writeb(val, rpc->base + reg);
>                         return 0;
> -               } else if (spide == 0xC) {
> +
> +               case 2:
>                         writew(val, rpc->base + reg);
>                         return 0;
> -               } else if (spide != 0xF) {
> +
> +               case 4:
> +               case 8:
> +                       break;
> +
> +               default:
>                         return -EILSEQ;
>                 }
> +               break;
> +
> +       case RPCIF_SMWDR1:
> +               if (rpc->xfer_size != 8)
> +                       return -EILSEQ;
> +               break;
> +
> +       case RPCIF_SMRDR0:
> +       case RPCIF_SMRDR1:
> +               return -EPERM;
>         }
>
>         writel(val, rpc->base + reg);
> @@ -469,6 +499,7 @@ int rpcif_manual_xfer(struct rpcif *rpc)
>
>                         smenr |= RPCIF_SMENR_SPIDE(rpcif_bits_set(rpc, nbytes));
>                         regmap_write(rpc->regmap, RPCIF_SMENR, smenr);
> +                       rpc->xfer_size = nbytes;
>
>                         memcpy(data, rpc->buffer + pos, nbytes);
>                         if (nbytes == 8) {
> @@ -533,6 +564,7 @@ int rpcif_manual_xfer(struct rpcif *rpc)
>                         regmap_write(rpc->regmap, RPCIF_SMENR, smenr);
>                         regmap_write(rpc->regmap, RPCIF_SMCR,
>                                      rpc->smcr | RPCIF_SMCR_SPIE);
> +                       rpc->xfer_size = nbytes;
>                         ret = wait_msg_xfer_end(rpc);
>                         if (ret)
>                                 goto err_out;
> diff --git a/include/memory/renesas-rpc-if.h b/include/memory/renesas-rpc-if.h
> index 7c93f5177532f187..9c0ad64b8d292d49 100644
> --- a/include/memory/renesas-rpc-if.h
> +++ b/include/memory/renesas-rpc-if.h
> @@ -72,6 +72,7 @@ struct rpcif {
>         enum rpcif_type type;
>         enum rpcif_data_dir dir;
>         u8 bus_size;
> +       u8 xfer_size;
>         void *buffer;
>         u32 xferlen;
>         u32 smcr;
> --
> 2.25.1
>
