Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FDC59B2F9
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 11:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiHUJoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 05:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiHUJoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 05:44:07 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49181F63A
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 02:44:06 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-3376851fe13so189355747b3.6
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 02:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=rfaarergVMrMl3NP6R0UIJ/QHp9PlmI7CbyryyVn/mY=;
        b=WNuD54w44DxS1q3kAVQPvjMhgckkSdsAJJzgBEgvWP62ubjGTv+bvpHq6jfWJkgLH/
         MIPgZv+WCdKnt8LOEFNQPyRU1vprRqwzVLxi7IAL7qeSvXsXTQQD+FAp2KAyaY3n3XZc
         q07aJ5Iq7d1MyxAzuwZx9iFn6Mmj818n9awwKxelY1yjTsFepUpujUArk7niDGAdi4uO
         WTDlNegSimUoJX0WbpDFZ9Pp33uLNJZcf7PSJfDmzSkjuGAhtGd3NG3F4AhhxKvlgJtw
         LT4vhsAPVrxfFv9VEAbPtNIE1mRrnlNdaxY9rkdIbNRk9EIcOvHCAGYLotvoVgf9cCB8
         QTFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=rfaarergVMrMl3NP6R0UIJ/QHp9PlmI7CbyryyVn/mY=;
        b=CKylkm4QwwEW+3GR4mw2VsA8oSWV69w9SQyLA5I6dybFESQM6VXdYWIsrISLwLhdYw
         3HgF5KLa+2gMIAlyFHzJpigGiuhU7ahcCM16FeSTWHudHhxqpQ3k4n+CqZSe0c/bmOdc
         9MQ69/x+amQ3t498Tag3Dk7/uDV5WoIyIEPYBbD53I0PPkWkjiYtvfbJxXhq68knDu+u
         a3y5Rkooi+EJPgTmR6r6DKvBELsIY7E+rTRJ8oWTpIRFkLCUIp6KCJ8Dg9DOdVKAxzrD
         TyUBv3XBky5dHDsFZ/oCvL/7okmcOc5Dyhu6TS4/eGBnVEKRidjAc38UKI4lVscNJx6e
         pnQQ==
X-Gm-Message-State: ACgBeo3snXNr5wMdvDfgG52C25iQIoLPrh0MFfLBuA2769P84NNALM62
        523Ydj/z4x8eSmgA2BpTnCnkbH6sLeRF7zzygaccoQ==
X-Google-Smtp-Source: AA6agR6EAI9iuAA6jEwlBFw2M1Gb42C8VCn2s3ZiokOlYtzeBCM/YYRmIwGo8+EMKwrNuc7/+QpMX8Gh1Rs7dQjn0fQ=
X-Received: by 2002:a0d:cd43:0:b0:329:febf:8c25 with SMTP id
 p64-20020a0dcd43000000b00329febf8c25mr14948896ywd.90.1661075045780; Sun, 21
 Aug 2022 02:44:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220819060801.10443-1-jinpu.wang@ionos.com> <20220819060801.10443-13-jinpu.wang@ionos.com>
In-Reply-To: <20220819060801.10443-13-jinpu.wang@ionos.com>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Sun, 21 Aug 2022 12:44:04 +0300
Message-ID: <CAOtvUMdRvb_sQHW21MDXj3faUjOTTzCcwFDvnuCq7W_j0hyskg@mail.gmail.com>
Subject: Re: [PATCH v1 12/19] crypto: ccree: Fix dma_map_sg error check
To:     Jack Wang <jinpu.wang@ionos.com>
Cc:     Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jack,

On Fri, Aug 19, 2022 at 9:08 AM Jack Wang <jinpu.wang@ionos.com> wrote:
>
> dma_map_sg return 0 on error, and dma_map_error is not supposed to use
> here.
>
> Cc: Gilad Ben-Yossef <gilad@benyossef.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: linux-crypto@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
>
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/crypto/ccree/cc_buffer_mgr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/crypto/ccree/cc_buffer_mgr.c b/drivers/crypto/ccree/=
cc_buffer_mgr.c
> index 6140e4927322..9efd88f871d1 100644
> --- a/drivers/crypto/ccree/cc_buffer_mgr.c
> +++ b/drivers/crypto/ccree/cc_buffer_mgr.c
> @@ -274,7 +274,7 @@ static int cc_map_sg(struct device *dev, struct scatt=
erlist *sg,
>         }
>
>         ret =3D dma_map_sg(dev, sg, *nents, direction);
> -       if (dma_mapping_error(dev, ret)) {
> +       if (!ret) {
>                 *nents =3D 0;
>                 dev_err(dev, "dma_map_sg() sg buffer failed %d\n", ret);
>                 return -ENOMEM;
> --
> 2.34.1
>

Good catch!

Thank you for the patch.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>

Gilad

--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
