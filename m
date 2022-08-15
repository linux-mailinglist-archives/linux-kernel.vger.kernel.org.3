Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D513459381C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 21:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244063AbiHOSw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 14:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244252AbiHOSqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 14:46:51 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1523A41D06
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 11:28:23 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id q6-20020a05683033c600b0061d2f64df5dso5969534ott.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 11:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=8qfZVni2XH/RI/iesjrLRRQFFIAGyvbqRIgbTF4s4BE=;
        b=a5C1taQFB89b3AGnirAiIEdh+mu154yh0pHMjrTR7a/ROQ50/2Lu0mzkBsSm+G3LIt
         6AXpOP3h0N8XN76HDDoSQi3D7W/hRC+r+O11vnife9kmOk1a1mCQ26T5s85O+dZ7ef1p
         rrue1CkSdJux/05RskCFW63R8f7ogddm0j4uYa4/90h+8370/txJlqYbuaEPUh4OW+kR
         mgEN9GfbPGGb3jLAtZGekSZL70Rha+HyiuPtzaTwfLbZX+IqUsAoiE7gZm3iLAC+QpCO
         98UMtucYlPM70Ennas7ZDE2YcyW3k3dUF2IT7LawoM6p1bEA6Q5Vh//CzZbAWazQzsta
         5xdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=8qfZVni2XH/RI/iesjrLRRQFFIAGyvbqRIgbTF4s4BE=;
        b=aeRjHCQKk2T4Aro3u9kjwt8SleW5ZgF0w5yE9bTYZfgRTuUf2E9Z97IpQES3AENvFN
         qgKs+vW9ZemDcZzQodQ4PIEVwdI8rkIfC3dOEPpuTXgz8OUDGNgOCisYUhG4+iG3/Kc9
         VeSv+CFHVF57i+1PxoExxU123kNcyRC5e+ji6a5hYr7tQGoypu5uMSgDeRzqkh5yOerd
         sDUlSRXpm/z7qfpdmSQq8xUS7aBwGNYFU0qOPxM2COt927Cx4Q+5o0HqcjX++znJPVD9
         HNxuYQQc8BQp9OVpDyE2Eq+t13G3IX7J2909D7H8DwMTG3Mpo2aJlOMlTWY6PENxrHJn
         GshQ==
X-Gm-Message-State: ACgBeo2tG0eFUipO9wzOrK+wJ5Kilbz7N+GybPgaJMOE7gta3t/sXVDe
        2mTjkNih7Vd1U2ZEyFjHErHjYHExSAvTS1AInuiGsVy+cRI=
X-Google-Smtp-Source: AA6agR4WPkhmsptGd1XOB3Vh54cIr8wHdsrg+jtjRu9m6lduQwI838vBMBxq5N7FsgKfD3Gal982Qyqm+XiwE3ef/Io=
X-Received: by 2002:a05:6830:25c4:b0:637:2a66:1dfd with SMTP id
 d4-20020a05683025c400b006372a661dfdmr6294714otu.383.1660588103082; Mon, 15
 Aug 2022 11:28:23 -0700 (PDT)
MIME-Version: 1.0
References: <6d75855ad4e2470e9ed99e0df21bc30f0c925a29.1658862932.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <6d75855ad4e2470e9ed99e0df21bc30f0c925a29.1658862932.git.christophe.jaillet@wanadoo.fr>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 15 Aug 2022 20:27:46 +0200
Message-ID: <CAPDyKFoZ-kzFPM88TCdgL7LLzB144oiEfCpofafLvTz51y3Hng@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: pxamci: Fix an error handling path in pxamci_probe()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jul 2022 at 21:15, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> The commit in Fixes: has moved some code around without updating gotos to
> the error handling path.
>
> Update it now and release some resources if pxamci_of_init() fails.
>
> Fixes: fa3a5115469c ("mmc: pxamci: call mmc_of_parse()")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied for fixes and by adding stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/pxamci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
> index 0db9490dc659..37bf362a0ed5 100644
> --- a/drivers/mmc/host/pxamci.c
> +++ b/drivers/mmc/host/pxamci.c
> @@ -648,7 +648,7 @@ static int pxamci_probe(struct platform_device *pdev)
>
>         ret = pxamci_of_init(pdev, mmc);
>         if (ret)
> -               return ret;
> +               goto out;
>
>         host = mmc_priv(mmc);
>         host->mmc = mmc;
> --
> 2.34.1
>
