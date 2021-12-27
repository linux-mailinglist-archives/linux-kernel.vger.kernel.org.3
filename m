Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA02847FA5E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 06:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235238AbhL0Fgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 00:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbhL0Fge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 00:36:34 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F75C061401
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 21:36:33 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id x7so32583950lfu.8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 21:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EF+jmTyvegw5LQ6AgqSKm6/snzft5eQBIQojLd8N8v8=;
        b=F+PdweTyPAgk8X2RpoCfcdyPXddhm/T+/VQlHU50jPyhjtP9wXFSrVmuj/qGVEBtnW
         2QkCF3oX8bWs0rqHAKwV5WvtDS+1fSq5aFawTroC7uAZKWnSh0rHm6NMElsYZwP0W42n
         UgvmTvCA7D3FjrpQ4X1TzNJ9xhmlup7SlF8mc/ZNbTF2qLsAyirhPXVVJ7T61bw9JJp6
         ZrVldFM62Km0RUtK/SijYLvy06LDMC4+IugMqvvMOD3fV0VHLWwFhenw/ejrmXOazyH4
         Oo8Zmgreg6G9wEKKFTSIMk6+YWL78e5HlKNhkdmDo8fTlsFwJGCmRjyzNg4mWVaX4Tlx
         0TnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EF+jmTyvegw5LQ6AgqSKm6/snzft5eQBIQojLd8N8v8=;
        b=2ev588ABcrcB51gr/Z4alPBNYFEA4YyD7GkfiDRc26liK9h1BWAJFN4PzR4Xs7+IhM
         klo42IDVzep/r1Sv+wWw2nhT9JSQP9hRDZVAXqmKAGLwi8xyl4Q1G3fFoJLx67nTCKeW
         ovQjdvQo6mNWFbCOOGz7QwYHksMAR/usNdurWh9cxqFGjQajpoNsjYAhb3TuN32tpyzy
         yXsq85LUMUzicnkZvyCtNEnMlzqukYAqZzjCbYroY2hEyyEJLYR4MJ306xZH1kzjYxxY
         8/APoNvrZCwMZV7ScPcQTgcnK2zX+o1oQzwG1U2GNBO+q+eIrPJ1N/vsNzjhm6P8LOJz
         WVAw==
X-Gm-Message-State: AOAM531fOewbTNLMQA+sXMOqrtq9exzqzJfFKw6BfGsOrqaArSpOpZ5f
        MFji5oqGSEV6nV6XhjOLZGdBnkwvijjq1+yALAxUZw==
X-Google-Smtp-Source: ABdhPJyufeH1AWueioCp4YOhlMH2oH9Z8gPmbMp3bV8dLO7KqY7RilFi05M8mSEsfnqmp/ap9/w2ps3tQXkmEAT9oQE=
X-Received: by 2002:a05:6512:1116:: with SMTP id l22mr14145774lfg.253.1640583391499;
 Sun, 26 Dec 2021 21:36:31 -0800 (PST)
MIME-Version: 1.0
References: <0e30e1f1bde74bc95085093fb0289007d510a68c.1640529121.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <0e30e1f1bde74bc95085093fb0289007d510a68c.1640529121.git.christophe.jaillet@wanadoo.fr>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 27 Dec 2021 11:06:17 +0530
Message-ID: <CAFA6WYOZtMW7bq98JXm8AqgajaYmythiDQ53k-zgew6zE63YCg@mail.gmail.com>
Subject: Re: [PATCH] optee: Use bitmap_free() to free bitmap
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     jens.wiklander@linaro.org, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Dec 2021 at 20:02, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> kfree() and bitmap_free() are the same. But using the latter is more
> consistent when freeing memory allocated with bitmap_zalloc().
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/tee/optee/notif.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Looks reasonable to me.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/tee/optee/notif.c b/drivers/tee/optee/notif.c
> index a28fa03dcd0e..05212842b0a5 100644
> --- a/drivers/tee/optee/notif.c
> +++ b/drivers/tee/optee/notif.c
> @@ -121,5 +121,5 @@ int optee_notif_init(struct optee *optee, u_int max_key)
>
>  void optee_notif_uninit(struct optee *optee)
>  {
> -       kfree(optee->notif.bitmap);
> +       bitmap_free(optee->notif.bitmap);
>  }
> --
> 2.32.0
>
