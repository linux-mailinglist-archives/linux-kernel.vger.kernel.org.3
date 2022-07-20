Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A144357B9A9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235047AbiGTPbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234599AbiGTPbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:31:40 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1075F9B4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:31:39 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id e69so32673012ybh.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0pTlSpxv4exsrmTqfZ5kdf5cK1c62hSiqFaA91m5Jlw=;
        b=xbg0a6l0ukJ3gm2QUsZry1N+T2uDbJ/t7gM35DtyK8xTwFDEpJ/CgaTrBLNuywvIMt
         pP+csdQ/uRRtgFptpuw3mbGa/vOp7ZPSXHoSMLr1HUGJjx7HE16iNslKTXta6yTN2xij
         gVWjbZaU1ras9rxmiQackODz5Jw3gZiVrCsKXtrHpif0qkkMDISghcv7Ih1DSDvS1OVd
         n7uf/aLgJ/LmpG58pkynXgEGzTLhz20S33olOx59J442bSKcQqfO06KLa4gMlo4P6CeW
         9F9usiuamLUU5f3IbTpegEO1DE5cSKjGEvgLc1rivPX4M8DtNmdicV04een+Cd1Q0Aur
         bZsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0pTlSpxv4exsrmTqfZ5kdf5cK1c62hSiqFaA91m5Jlw=;
        b=zGkjk/MnfW0C/soorfHeTLhOKtS8FQnmMn6Qr6Bw+ZWbJMjwXSM4MHDov+VyzfBEmD
         qAr6nwQV4AqngJEqawyHr14Ej924g/CvicpoZC0idLXcbMyTTGNJdFKnX5ojS9Ybqq2H
         UbgRNS9az+Rsn+DbH57KDdtVejabLsBj9TrH2CMLHOapY5Gvv1YVl8Oe35KQktue+EXl
         Z+H0p+tkxe8ttRqBfcr2rEh+MfmW9FnYlRXNwnN4JQzrPlmB4NM50BJcJ8M3j/k4FjRi
         MeF6M0gqW2VWRkbXwhIlhNmDth8BgVT+1oACOhUoxSl35kZ8W8bnYfmQKG5vEHMphlNP
         XECA==
X-Gm-Message-State: AJIora96sQpIqrBi4MUOCHoqRyHpTtTo61cgfgmBO1Pp3DSN+eUsbxPq
        4VCGK5Zis3U023t7sZY3jGsqi5OLVsQDV4NwdWcl0A==
X-Google-Smtp-Source: AGRyM1vfgKge2FP7ohRgsJX8BJYOJrEA9DPEsIsss1QJmRkXI8cZ1gaM01fvHf0F/QwRgwy8mu7jGiFHrGguCjBgySw=
X-Received: by 2002:a25:dd0:0:b0:670:85ee:166a with SMTP id
 199-20020a250dd0000000b0067085ee166amr6849957ybn.539.1658331098621; Wed, 20
 Jul 2022 08:31:38 -0700 (PDT)
MIME-Version: 1.0
References: <f47cdaa7067af0ae2eeeca52cee2176cdc449a22.1658323697.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <f47cdaa7067af0ae2eeeca52cee2176cdc449a22.1658323697.git.christophe.jaillet@wanadoo.fr>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Wed, 20 Jul 2022 18:31:27 +0300
Message-ID: <CAOtvUMe3AFbKUCR4L3=Zm9_UxVJNRqxjcU+CR5LHG3B=y839fg@mail.gmail.com>
Subject: Re: [PATCH v2] crypto: ccree - Remove a useless dma_supported() call
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On Wed, Jul 20, 2022 at 4:29 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> There is no point in calling dma_supported() before calling
> dma_set_coherent_mask(). This function already calls dma_supported() and
> returns an error (-EIO) if it fails.
>
> So remove the superfluous dma_supported() call.
>
> Moreover, setting a larger DMA mask will never fail when setting a smalle=
r
> one will succeed, so the whole "while" loop can be removed as well. (see
> [1])
>
> While at it, fix the name of the function reported in a dev_err().
>
> [1]: https://lore.kernel.org/all/YteQ6Vx2C03UtCkG@infradead.org/
>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/crypto/ccree/cc_driver.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)

Acked-by: Gilad Ben-Yossef <gilad@benyossef.com>

Thank you,
Gilad

>
> diff --git a/drivers/crypto/ccree/cc_driver.c b/drivers/crypto/ccree/cc_d=
river.c
> index 7d1bee86d581..cadead18b59e 100644
> --- a/drivers/crypto/ccree/cc_driver.c
> +++ b/drivers/crypto/ccree/cc_driver.c
> @@ -372,17 +372,10 @@ static int init_cc_resources(struct platform_device=
 *plat_dev)
>                 dev->dma_mask =3D &dev->coherent_dma_mask;
>
>         dma_mask =3D DMA_BIT_MASK(DMA_BIT_MASK_LEN);
> -       while (dma_mask > 0x7fffffffUL) {
> -               if (dma_supported(dev, dma_mask)) {
> -                       rc =3D dma_set_coherent_mask(dev, dma_mask);
> -                       if (!rc)
> -                               break;
> -               }
> -               dma_mask >>=3D 1;
> -       }
> -
> +       rc =3D dma_set_coherent_mask(dev, dma_mask);
>         if (rc) {
> -               dev_err(dev, "Failed in dma_set_mask, mask=3D%llx\n", dma=
_mask);
> +               dev_err(dev, "Failed in dma_set_coherent_mask, mask=3D%ll=
x\n",
> +                       dma_mask);
>                 return rc;
>         }
>
> --
> 2.34.1
>


--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
