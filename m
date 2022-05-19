Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498B052DB60
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239169AbiESReN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235659AbiESReK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:34:10 -0400
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13A210B2;
        Thu, 19 May 2022 10:34:09 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id a3so10248286ybg.5;
        Thu, 19 May 2022 10:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kH6mdZHcauvR1rm6YJx0iNHcSRrO1wDBdLaqG9hKgFA=;
        b=4jgBfBvM3ro3XWCAndC6N2m7pQsxAONjmZQvN5YgirltnpJkb1/n4XTafYALlEYdUa
         sZqpXOlcq97js29yRLzJwoYonr8x0MtjWZ+OxmQkkqClj6fDxslnJA1OiUPmH5emubXi
         TCVYOtM2QqIDXO1wlUsj4eCxva5WClYCFixCh22pLtx1JE7653amJ+I6H1TuVgd0NbyQ
         HJcnj1aGms61KUjB3Lcl5/6KjzJQCL4tT5I3ffbf+qB/lzAA4R50NO3Jrtcka2GA9mzo
         AmBYUUY1uBD9XEMpFp0ag8ddafVqz94SgehCjxyzLSXKXAnc8MM8SOgBGFso++Uwa2CP
         wZlQ==
X-Gm-Message-State: AOAM532zlxqTCyi+v6T+dWoBBzcJuzYN7kvIowA0bLB3Ipuz3CqPK2gW
        6YK5rfBGspmEWZ8Av4JizkjrbenN39bnSqR/lmE=
X-Google-Smtp-Source: ABdhPJxmhNl0iusaWcmhEooDHwjFOgOQgsn5yZ72wOk0t0IDsP82H5W5RAGQ7Pb1vH2tID2gLBHPpVAJciBsK5O+ErA=
X-Received: by 2002:a25:7717:0:b0:64d:854f:2da4 with SMTP id
 s23-20020a257717000000b0064d854f2da4mr5200324ybc.633.1652981649007; Thu, 19
 May 2022 10:34:09 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20220519004138epcas1p1cb026c559dacbf3f8525910293b2de89@epcas1p1.samsung.com>
 <20220519010753.32228-1-cw00.choi@samsung.com>
In-Reply-To: <20220519010753.32228-1-cw00.choi@samsung.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 19 May 2022 19:33:58 +0200
Message-ID: <CAJZ5v0iDuoRj6iw6ooi8EutpjYbeE6UeTys1QE=PHFapc+FPuQ@mail.gmail.com>
Subject: Re: [PATCH] PM / devfreq: passive: Return non-error when
 not-supported event is required
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Chanwoo Choi (samsung.com)" <chanwoo@kernel.org>,
        Myungjoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 2:42 AM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>
> Each devfreq governor specifies the supported governor event
> such as GOV_START and GOV_STOP. When not-supported event is required,
> just return non-error. But, commit ce9a0d88d97a ("PM / devfreq: Add
> cpu based scaling support to passive governor") returned the error
> value. So that return non-error value when not-supported event is required.
>
> Fixes: ce9a0d88d97a ("PM / devfreq: Add cpu based scaling support to passive governor")
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
> Dear Rafael,
>
> This patch fixes the issue of the pull request[1].
> I'd like you to apply it to linux-pm.git direclty.
> [1] https://patchwork.kernel.org/project/linux-pm/patch/3acd6c32-6e78-dfc2-3e45-84f69a7d5f36@samsung.com/
>
> Best Regards,
> Chanwoo Choi
>
>  drivers/devfreq/governor_passive.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
> index 7306e943a234..72c67979ebe1 100644
> --- a/drivers/devfreq/governor_passive.c
> +++ b/drivers/devfreq/governor_passive.c
> @@ -402,7 +402,7 @@ static int devfreq_passive_event_handler(struct devfreq *devfreq,
>  {
>         struct devfreq_passive_data *p_data
>                         = (struct devfreq_passive_data *)devfreq->data;
> -       int ret = -EINVAL;
> +       int ret = 0;
>
>         if (!p_data)
>                 return -EINVAL;
> --

Applied, thanks!
