Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F034F6152
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbiDFOLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234359AbiDFOJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:09:19 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1BF4ED0C5;
        Wed,  6 Apr 2022 03:05:49 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id t7so3377653qta.10;
        Wed, 06 Apr 2022 03:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2VSAsL2CXxrE77kXFBa8TcwGi/LVtFh7YwP75sQ1TkA=;
        b=nFH8nSv8u2z2VrycbL7jcP3CAcHZjP/EULtXO9QHdvJOZEKn1TCzlLXc86GXCi7Mmd
         6OT7TIZ2Q7dJ0U6hVtjdLAIGIQDv9QeeBRJZ4FoPsPOuwqpWlhUW0SSa9GGQZrBK1pSC
         SYrltpIS39/4lZyqixcMZsrTh/rNTPis01lrBX7rikZlN7xLrQ1986ikQmhJ/rWGmZ/i
         q+YH4DqQcEtmG5icR7TWQd/CXEexRIXvNFTL1J5v1ODkMCUZVLPhrhO/0kRTVsreKJJV
         reLzEOgygvOshNCTIsLmubVYawMMiKqMdP/5krBi5ySqz8xGYXe+w52VPQkOPGli3U07
         GGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2VSAsL2CXxrE77kXFBa8TcwGi/LVtFh7YwP75sQ1TkA=;
        b=5etS1P1jT0bCPZT+g4mIKsotL5ijQXTWGOcH/V9aghMHSOCm9BaDq2DIB1l7KTYQr4
         TM4gXbZQTCvYPjYwJtqdsP+d3/2SZ+XqWw5CWGOueKhv3I2e3mGfUTQf5IzFKArpmw4u
         8IKBHiFRulTmHq0x1hFSpbBIuUPuJwjmJ/T9Mamu0WZBTLjPqm4hqqcPaiESiVl7uB7C
         OERTnbUc5dSgAU9i+k5PCZFFKcNwNYYmRx0je5qjLvvdimbtGmIIKhiOsBETSqcw3XgU
         mjkq65DJHByYcZXSY7zispF7MwH+Ps7OIyTrp05LEhWmt0vWs1vUlPJaSuU7x0EGsibd
         lOrQ==
X-Gm-Message-State: AOAM532K/Ez3B6HWirwEd+Fh0LHyQHdLJv2ZTJSpqfYZlh9tWR9qmGtB
        NJtzjL3sz69Qwy/wM7cAgNIq7bJQKM2zS27n6Fs=
X-Google-Smtp-Source: ABdhPJzJ51LUKgHNsZSqfo2DF9g+oizaRLxeUSLiFI7JUgaZgBlMXR+GkcR82KzMkbYV3Pw7dmxC8tAPKSbyI0Y+ZMA=
X-Received: by 2002:a05:622a:82:b0:2e1:d61d:81ec with SMTP id
 o2-20020a05622a008200b002e1d61d81ecmr6628223qtw.674.1649239528097; Wed, 06
 Apr 2022 03:05:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220323064944.1351923-1-peng.fan@oss.nxp.com> <20220323064944.1351923-3-peng.fan@oss.nxp.com>
In-Reply-To: <20220323064944.1351923-3-peng.fan@oss.nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Wed, 6 Apr 2022 13:05:16 +0300
Message-ID: <CAEnQRZB1LL=d3SBCgNomPErBvzEgTVtbBE_PH=V60v-_9UObEg@mail.gmail.com>
Subject: Re: [PATCH 2/2] remoteproc: imx_dsp_rproc: use common rproc_elf_load_segments
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     bjorn.andersson@linaro.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        linux-remoteproc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Peng Fan <peng.fan@nxp.com>
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

On Thu, Mar 24, 2022 at 1:34 AM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> remoteproc elf loader supports the specific case that segments
> have PT_LOAD and memsz/filesz set to zero, so no duplicate
> code.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

I think this change OK, but we have a case with the DSP were
reads/writes should be done in multiples of 32/64.

We need a way to provide our own "memcpy" function to be used by
rproc_elf_load_segments.

> ---
>  drivers/remoteproc/imx_dsp_rproc.c | 95 +-----------------------------
>  1 file changed, 1 insertion(+), 94 deletions(-)
>
> diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
> index 2abee78df96e..eee3c44c2146 100644
> --- a/drivers/remoteproc/imx_dsp_rproc.c
> +++ b/drivers/remoteproc/imx_dsp_rproc.c
> @@ -649,99 +649,6 @@ static int imx_dsp_rproc_add_carveout(struct imx_dsp_rproc *priv)
>         return 0;
>  }
>
> -/**
> - * imx_dsp_rproc_elf_load_segments() - load firmware segments to memory
> - * @rproc: remote processor which will be booted using these fw segments
> - * @fw: the ELF firmware image
> - *
> - * This function specially checks if memsz is zero or not, otherwise it
> - * is mostly same as rproc_elf_load_segments().
> - */
> -static int imx_dsp_rproc_elf_load_segments(struct rproc *rproc,
> -                                          const struct firmware *fw)
> -{
> -       struct device *dev = &rproc->dev;
> -       u8 class = fw_elf_get_class(fw);
> -       u32 elf_phdr_get_size = elf_size_of_phdr(class);
> -       const u8 *elf_data = fw->data;
> -       const void *ehdr, *phdr;
> -       int i, ret = 0;
> -       u16 phnum;
> -
> -       ehdr = elf_data;
> -       phnum = elf_hdr_get_e_phnum(class, ehdr);
> -       phdr = elf_data + elf_hdr_get_e_phoff(class, ehdr);
> -
> -       /* go through the available ELF segments */
> -       for (i = 0; i < phnum; i++, phdr += elf_phdr_get_size) {
> -               u64 da = elf_phdr_get_p_paddr(class, phdr);
> -               u64 memsz = elf_phdr_get_p_memsz(class, phdr);
> -               u64 filesz = elf_phdr_get_p_filesz(class, phdr);
> -               u64 offset = elf_phdr_get_p_offset(class, phdr);
> -               u32 type = elf_phdr_get_p_type(class, phdr);
> -               void *ptr;
> -
> -               /*
> -                *  There is a case that with PT_LOAD type, the
> -                *  filesz = memsz = 0. If memsz = 0, rproc_da_to_va
> -                *  should return NULL ptr, then error is returned.
> -                *  So this case should be skipped from the loop.
> -                *  Add !memsz checking here.
> -                */
> -               if (type != PT_LOAD || !memsz)
> -                       continue;
> -
> -               dev_dbg(dev, "phdr: type %d da 0x%llx memsz 0x%llx filesz 0x%llx\n",
> -                       type, da, memsz, filesz);
> -
> -               if (filesz > memsz) {
> -                       dev_err(dev, "bad phdr filesz 0x%llx memsz 0x%llx\n",
> -                               filesz, memsz);
> -                       ret = -EINVAL;
> -                       break;
> -               }
> -
> -               if (offset + filesz > fw->size) {
> -                       dev_err(dev, "truncated fw: need 0x%llx avail 0x%zx\n",
> -                               offset + filesz, fw->size);
> -                       ret = -EINVAL;
> -                       break;
> -               }
> -
> -               if (!rproc_u64_fit_in_size_t(memsz)) {
> -                       dev_err(dev, "size (%llx) does not fit in size_t type\n",
> -                               memsz);
> -                       ret = -EOVERFLOW;
> -                       break;
> -               }
> -
> -               /* grab the kernel address for this device address */
> -               ptr = rproc_da_to_va(rproc, da, memsz, NULL);
> -               if (!ptr) {
> -                       dev_err(dev, "bad phdr da 0x%llx mem 0x%llx\n", da,
> -                               memsz);
> -                       ret = -EINVAL;
> -                       break;
> -               }
> -
> -               /* put the segment where the remote processor expects it */
> -               if (filesz)
> -                       memcpy(ptr, elf_data + offset, filesz);
> -
> -               /*
> -                * Zero out remaining memory for this segment.
> -                *
> -                * This isn't strictly required since dma_alloc_coherent already
> -                * did this for us. albeit harmless, we may consider removing
> -                * this.
> -                */
> -               if (memsz > filesz)
> -                       memset(ptr + filesz, 0, memsz - filesz);
> -       }
> -
> -       return ret;
> -}
> -
>  /* Prepare function for rproc_ops */
>  static int imx_dsp_rproc_prepare(struct rproc *rproc)
>  {
> @@ -808,7 +715,7 @@ static const struct rproc_ops imx_dsp_rproc_ops = {
>         .start          = imx_dsp_rproc_start,
>         .stop           = imx_dsp_rproc_stop,
>         .kick           = imx_dsp_rproc_kick,
> -       .load           = imx_dsp_rproc_elf_load_segments,
> +       .load           = rproc_elf_load_segments,
>         .parse_fw       = rproc_elf_load_rsc_table,
>         .sanity_check   = rproc_elf_sanity_check,
>         .get_boot_addr  = rproc_elf_get_boot_addr,
> --
> 2.25.1
>
