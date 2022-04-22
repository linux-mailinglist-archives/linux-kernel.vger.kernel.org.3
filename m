Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368E450B571
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446809AbiDVKpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446805AbiDVKpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:45:16 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071DF25E6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 03:42:23 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2f16645872fso80978747b3.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 03:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sP8JvrZInBak3AnrSA3yrnJGI9uRamz0KMh5AUQsofQ=;
        b=mxaV6FRRNknnsY7+E9ykC3IUZCerphaQNqbeakR5XX75pUdnHgcJJUsRJ3aXY80yJ9
         HktNrl7JztZV1ZWvWCc1if3I9Ost6qcIY13XFooCfXXscYXOh122ddiLA9zXubk6clOK
         Pmlpju9qsubHxSspDtaLqWbNUAVKqYnqX0P0h9eEiLyxBKvOeIEL9txSEe6wKokO3Xcx
         ZseIJJFtqjjxN4me2HSBYwtgVXmW4BszQiTWFy6eb9aoZFhLzZZCnUWrVso2JZ4LixRr
         ujKw/Jfyw6S0id3WlCZ+Fxy1DYCS/YjBsPgfaS7+Js25+QrYAZem9tlZZ8MtG7MuhcPM
         fEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sP8JvrZInBak3AnrSA3yrnJGI9uRamz0KMh5AUQsofQ=;
        b=ZgtTTzldH6iyJ+EMjUotfhNIN5NkD/NH9I9xcEpbY5euucdDmRvcgZCKBv33+oFapR
         Svx9KDskgriYaslDaDYgaZi+Zy0TrnQzh+Obm3G1txqujjyGHSZtooBiZlXzkGqUY5J6
         6xHCeuOik6UaklQqm6ZAxGB5qwGw6O0lamGUfvr92MUiOKNskoczJOB/vAP20dCjbc1h
         2N5hdkZpY/sZVXg66xSxoXwLaLAto4DEekQA99Ud6XgvjajHwBoIebcH+NaRHhdMLJva
         kH0T5C5OHp6InY4/WpPKsnw3unXF7pqddTLpEqz56CRMZSw4N9AEA3LlGbfCqBtceJHd
         adpQ==
X-Gm-Message-State: AOAM531ie0uBMB5yZgtL241Vf+80AFlDbHyetYZF1pDBWqIHUvtaLUkI
        2OJJLg+oW5Vao1G6dRb6KswWgUAKoFvT6m8ded+lgQ==
X-Google-Smtp-Source: ABdhPJz2tiFNiuWE0RHaKofgV7Ha+x3z1t8YOpPiDzl8uQ8X2u6bN2PirRLEPFpKZHLnbUVDQq7E3Ml0rr2qadl/3mE=
X-Received: by 2002:a81:4c11:0:b0:2d1:1925:cd70 with SMTP id
 z17-20020a814c11000000b002d11925cd70mr3926695ywa.101.1650624142869; Fri, 22
 Apr 2022 03:42:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220422085211.2776419-1-lv.ruyi@zte.com.cn>
In-Reply-To: <20220422085211.2776419-1-lv.ruyi@zte.com.cn>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 22 Apr 2022 13:42:12 +0300
Message-ID: <CAA8EJpoAeCp-=k2o+C4E4jHBAv7f3eKrV5FZiYjVZ8hcRGYLVA@mail.gmail.com>
Subject: Re: [PATCH] drm: msm: fix error check return value of irq_of_parse_and_map()
To:     cgel.zte@gmail.com
Cc:     robdclark@gmail.com, sean@poorly.run, quic_abhinavk@quicinc.com,
        airlied@linux.ie, daniel@ffwll.ch, swboyd@chromium.org,
        quic_mkrishn@quicinc.com, angelogioacchino.delregno@collabora.com,
        vulab@iscas.ac.cn, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Lv Ruyi <lv.ruyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Apr 2022 at 11:52, <cgel.zte@gmail.com> wrote:
>
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
>
> The irq_of_parse_and_map() function returns 0 on failure, and does not
> return an negative value.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
> index 3b92372e7bdf..1fb1ed9e95d9 100644
> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
> @@ -570,7 +570,7 @@ struct msm_kms *mdp5_kms_init(struct drm_device *dev)
>         }
>
>         irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
> -       if (irq < 0) {
> +       if (!irq) {
>                 ret = irq;
>                 DRM_DEV_ERROR(&pdev->dev, "failed to get irq: %d\n", ret);
>                 goto fail;
> --
> 2.25.1
>


-- 
With best wishes
Dmitry
