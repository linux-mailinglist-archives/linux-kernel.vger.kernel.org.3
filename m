Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB02A52C396
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 21:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242052AbiERTkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 15:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242011AbiERTkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 15:40:15 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5825820525F;
        Wed, 18 May 2022 12:40:14 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id q135so5422800ybg.10;
        Wed, 18 May 2022 12:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pWihXAvvokb63lRHFBwEFtBM3oG0TOH/jy6GaWAKaNk=;
        b=aangM02hOI6k4JUIXM7QyVITNJbqFw5uXNxGTYT0gErGGi/welG83qxKbo0oPRj950
         R5KwuqLstFiYwkYxzIGo04fsYI+wmYSi5Mi4GuaPddmJiV8Z/DgFWBGn9v75fcx5njfH
         hluYFlJ6kcuEWfskMAhvfduXRv0XEAsAV9Jw6xJKOxioST7N9cmgGqLWTkO88JLyPbnd
         2VALJ773Pd+oRnpZhhFxdcH9v3ZA6eQbxOTWhnDuj6tHQ+IhpXP1DgJiVrGWWZfSVeI8
         BmQE3ZADjo4G7sPz7KTmA6yzttJNuG1hxy5VS7LVcy6qOvK7Ufp6RAwsRjL0zUYk9dn1
         PAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pWihXAvvokb63lRHFBwEFtBM3oG0TOH/jy6GaWAKaNk=;
        b=jD52MvIu/2RiLnHtUFaM0BEPOIWUVTtTrlpeWlSlkeqDw4I7vlDIIkZ9SFliZX2d+L
         5NBmoFlQvYBNLS0chKWKQkW0TOIVUtMnAnsJucC8UEcW0ExHsQDH8PNmlmHdwItNdRSn
         /SVgnAIvnh8QEM1FAqLiyrxMA8xLX6kqPTzxccKex2MShCyfU1QGsRqzNafWQ68wefTf
         XDQO2ackI9urruZenaC1qPi/t2c8b+Mbmeg6y2p9LXAfakojm3hx6pSeDjCzA4FHymJw
         U8lAxIaVI/FqEDgOqMiX0q/cdnRoPb7ZS8eIzi9WfRtRpIQqrO9hWbFM00jULtihyGzo
         mO2Q==
X-Gm-Message-State: AOAM530q+GF+7aCpxbif/FhpfhLhoSu7e/Ex/uBN2neiaXki1IdsEJI9
        lvIo9d7IKP+MqrwNrgl1k8hkAEmdVKXo4jhn5Vw=
X-Google-Smtp-Source: ABdhPJw+8sthiuueQJELDt318XozuyqFGVUPjcYy3+oRUfUXdqW4kApcPAv9h0qxg/k4EGrxA9Ny2grWUeFn/qaHQQk=
X-Received: by 2002:a5b:246:0:b0:619:5651:3907 with SMTP id
 g6-20020a5b0246000000b0061956513907mr1211573ybp.190.1652902813551; Wed, 18
 May 2022 12:40:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220511065548.3402408-1-yangyingliang@huawei.com>
In-Reply-To: <20220511065548.3402408-1-yangyingliang@huawei.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 18 May 2022 20:39:47 +0100
Message-ID: <CA+V-a8vE5UHnEQRKNEnfbnFtZ=Zj1BWdh9YxpL60nsjSnJJ89Q@mail.gmail.com>
Subject: Re: [PATCH] media: davinci: vpif: add missing of_node_put() in vpif_probe()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
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

On Wed, May 11, 2022 at 7:44 AM Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> of_graph_get_next_endpoint() returns an 'endpoint' node pointer
> with refcount incremented. The refcount should be decremented
> before returning from vpif_probe().
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/media/platform/ti/davinci/vpif.c | 1 +
>  1 file changed, 1 insertion(+)
>
Reviewed-by: Lad Prabhakar <prabhakar.csengg@gmail.com>

Cheers,
Prabhakar

> diff --git a/drivers/media/platform/ti/davinci/vpif.c b/drivers/media/platform/ti/davinci/vpif.c
> index 97ef770266af..da27da4c165a 100644
> --- a/drivers/media/platform/ti/davinci/vpif.c
> +++ b/drivers/media/platform/ti/davinci/vpif.c
> @@ -469,6 +469,7 @@ static int vpif_probe(struct platform_device *pdev)
>                                               endpoint);
>         if (!endpoint)
>                 return 0;
> +       of_node_put(endpoint);
>
>         /*
>          * For DT platforms, manually create platform_devices for
> --
> 2.25.1
>
