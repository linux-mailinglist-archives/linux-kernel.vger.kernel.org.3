Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26227502639
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 09:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351089AbiDOHbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 03:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiDOHbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 03:31:37 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBC0B821B
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 00:29:09 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id w127so7728448oig.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 00:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sbIMr271cmn6ZzuRI3nbnuj6zILsFRiHoTF1eSBmRpw=;
        b=elnI+MJOSQ5Wt24HDoGCPEMZBOHoUtiIh10WHeUIbcFcUFKnrkRfMcEZbwaF/MSdX1
         SxhO2zN79ttE0loQ0LadOaXj0AZxzBSJk69gwex8gOVAPEtYTgQuCvYO8uDN3Hze0SS7
         UeolHwVgMH9YghMWrHVYWXm28KZ9h9jt9MGh1jezZYKUEIIWsrnKFedrOtWj07XJrS2L
         79tsLPePCIRqMqBPmx9Bb/eJUF8BBghPfgp0clU5Z0BG6kBsDqvVGLX+SAw6Xq7uE/Oy
         HjrHkgzTSd3Q9gIyKJWrXKkgiYnL5Z/uqoZ72UuHvkW5n7GUEggJgd7BxJgThfuHyR0M
         UQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sbIMr271cmn6ZzuRI3nbnuj6zILsFRiHoTF1eSBmRpw=;
        b=eKtcf26HT+0gEOugBvMIG8x9KipRdUu1E3xE1lQm/fpsPiokM0/U6eNBgP24V26ePa
         nGUv/K95XOSq7V3IGbGVRqUZTu3llYcGoWVtRysD0BLXGmZO0OAgIzaDYJKwRnV9LH+X
         +UwuKuSPcho2u5LDBZNGU+xxrpsHxANQOeYAC6XGfJLqHh1CF606eKr443fDat5Uck4H
         69Fh3qNmCqtoTIK7+SJL7j3J/uxqv2z5NsxZqZdUROLTJg9r7UW+pGCOKpHGaGvh1Rir
         reswrSeVH++uV9UjqF55vNdDUtEGqeBJYPjcBzxUO1X9Ly/risQ6jYSHD9QA2jOq6DvR
         S7Mw==
X-Gm-Message-State: AOAM532kAdcwNx4xAPzjaQsyg1FxP5QOV+Rqh/ZOp83PJKnGmiWkelRw
        +17MCRb6BptoWrM6ZPHtBR9ldNgEDsA/YcZNXPc=
X-Google-Smtp-Source: ABdhPJyDql2TgAh6NQrOzqQCNI9XwI3L2UDtGcp6OXunw6CeCHJ4ZwFCHWXsK5cHYTcJiZzal6Zl9nsxwJjkmSJuA9c=
X-Received: by 2002:a05:6808:10d4:b0:322:2f79:bd2c with SMTP id
 s20-20020a05680810d400b003222f79bd2cmr1085461ois.53.1650007749099; Fri, 15
 Apr 2022 00:29:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220415034844.1024538-1-gch981213@gmail.com> <20220415034844.1024538-3-gch981213@gmail.com>
 <20220415090058.5044ae17@collabora.com>
In-Reply-To: <20220415090058.5044ae17@collabora.com>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Fri, 15 Apr 2022 15:28:57 +0800
Message-ID: <CAJsYDVKbm+X8ARkgH6z9T0JaZ=cYkG+_3m-dtsbgAwWCrZeO8A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mtd: spinand: add support for detection with param page
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Palmer <daniel@0x0f.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Fri, Apr 15, 2022 at 3:01 PM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
> +#define SPINAND_IDR_EN BIT(6)

Looks like you're redefining CFG_OTP_ENABLE, why not use that
definition directly?

Oh. I didn't know that was available. I'll use it.
(IDR_EN comes from a toshiba datasheet if I remember correctly.)

>
> On Fri, 15 Apr 2022 11:48:43 +0800
> Chuanhong Guo <gch981213@gmail.com> wrote:
>
> > +
> > +static const struct spinand_manufacturer *spinand_onfi_manufacturers[] = {};
>
> Do we really need a separate manufacturer array? Looks like we could
> re-use the one we have in core.c and do the matching against it (we
> just need an extra NULL sentinel to detect the end of this array).

I'll do it.
I'll also add a onfi_nchips to spinand_manufacturer to share the same
manufacturer entry between two types of ID list.

>
> > +
> > +static const struct spinand_onfi_info *
> > +spinand_onfi_chip_match(struct nand_onfi_params *p,
> > +                     const struct spinand_manufacturer *m)
> > +{
> > +     size_t i, j;
> > +
> > +     for (i = 0; i < m->nchips; i++)
> > +             for (j = 0; m->onfi_chips[i].models[j]; j++)
> > +                     if (!strcasecmp(m->onfi_chips[i].models[j], p->model))
> > +                             return &m->onfi_chips[i];
> > +     return NULL;
> > +}
>
> > +/**
> > + * struct spinand_onfi_info - Structure used to describe SPI NAND with ONFI
> > + *                         parameter page
> > + * @models: Model name array. Null terminated.
> > + * @flags: OR-ing of the SPINAND_XXX flags
> > + * @eccinfo: on-die ECC info
> > + * @op_variants: operations variants
> > + * @op_variants.read_cache: variants of the read-cache operation
> > + * @op_variants.write_cache: variants of the write-cache operation
> > + * @op_variants.update_cache: variants of the update-cache operation
> > + * @select_target: function used to select a target/die. Required only for
> > + *              multi-die chips
> > + *
> > + * Each SPI NAND manufacturer driver should have a spinand_onfi_info table
> > + * describing all the chips supported by the driver.
> > + */
> > +struct spinand_onfi_info {
> > +     const char **const models;
> > +     u32 flags;
> > +     struct spinand_ecc_info eccinfo;
> > +     struct {
> > +             const struct spinand_op_variants *read_cache;
> > +             const struct spinand_op_variants *write_cache;
> > +             const struct spinand_op_variants *update_cache;
> > +     } op_variants;
> > +     int (*select_target)(struct spinand_device *spinand,
> > +                          unsigned int target);
> > +};
>
> Can't we just extend spinand_info instead of defining a new struct.

Yeah, that's better. I'll do it.

> AFAICT, the only difference is that model is replaced by a model array,
> and devid is dropped, and I think we can rework the existing ID-based
> matching logic to return ->models[0] instead of ->model.

In fact we don't even use this model string anywhere at the moment.

-- 
Regards,
Chuanhong Guo
