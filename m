Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B620E5A23FA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 11:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245227AbiHZJRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 05:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343497AbiHZJRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 05:17:24 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A16D741B
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 02:17:20 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id q16so994692ljp.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 02:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=yxr0Qd86necJLeODbFUrhjcBFjoAd3uXBhNlcIXoPwA=;
        b=T7Nuduru6zJHRRXE+O8aAOqpJYu7JZcaH8MVxpYFVbyhndtPkIWJ+PXUeeIWWQ+urc
         VXnj9BHHuJGwEaDUvuKjwZEDfGlQCL2w7tPSa2NhRK9pY+AyHNtlzjkPe0D/Gwd2lSjg
         8TS7/EjK9t3tV5j8SHh8FjT2jAoMz9eEqqcNIfNot9ScBM3WzyPBlM8L65FKCodry4qC
         TghT2eXyYDQsjIYiAP5yg2Phv4/EPNGdGPEaxI1QWM1p5PQgECuCRvevWkGAuQM8uhWb
         m3cJHKCgtr20++kuCJl8t5ViDAcYBEKBRNMhBCMbucwVq8YMmCclALI7BhxPbUccj/Ru
         yiJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=yxr0Qd86necJLeODbFUrhjcBFjoAd3uXBhNlcIXoPwA=;
        b=1uANILibrqGkGQy4VNFG5aOIJVnpGgvVeC40sM52inKQMKN3WhMx9IT8UJCq7E5y+O
         IPZdmUGPESZ9M/UQR3YYkoA/ZvWrKALHes8fAYk2yoch/L00POubu8NkyS92fWrGciIG
         UEnufwpOtdPRwxQFTciT7JBh0nOW8I7C00riG6YPuhF2b09xZcpqb9KSDqlVmRA7+k/X
         x01WdAzo9NkDztndetxHDVZpq+aAoGgpXZdTgXBb0FRZpTuFkx+YBQPTF6uDqkuHptR2
         tKIICEAh6saDak6Y9wz07gFaap1fWL7cHfe7j7I4c3A+PdQgho1BXyM71FTBHwuDpIol
         Tk+w==
X-Gm-Message-State: ACgBeo01mxroE/xXbem2wTf6PXOAke6VQdIjiX6ejfaLLdvmMxnjUu7q
        6yJXBstdx+G3LpsUCKaypg4hkz+F/S/Fg79zrsQOLw==
X-Google-Smtp-Source: AA6agR4FQXQ7vnpLnj3X7fRAmWQuLdRJrDKoAbK/JRm6muzl7lWnOItItBR6YENWPhKATqMHJ9UhBRsW+dG2laoBPbA=
X-Received: by 2002:a2e:884c:0:b0:261:ca69:6023 with SMTP id
 z12-20020a2e884c000000b00261ca696023mr1925180ljj.300.1661505439069; Fri, 26
 Aug 2022 02:17:19 -0700 (PDT)
MIME-Version: 1.0
References: <21d99886d07fa7fcbec74992657dabad98c935c4.1661412818.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <21d99886d07fa7fcbec74992657dabad98c935c4.1661412818.git.christophe.jaillet@wanadoo.fr>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 26 Aug 2022 11:16:42 +0200
Message-ID: <CAPDyKFqF+gFD8dw7swZ5pu6jf6kt7xkXHs8BHYSQ1Ue2e8eRsw@mail.gmail.com>
Subject: Re: [PATCH] mmc: au1xmmc: Fix an error handling path in au1xmmc_probe()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Aug 2022 at 09:34, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> If clk_prepare_enable() fails, there is no point in calling
> clk_disable_unprepare() in the error handling path.
>
> Move the out_clk label at the right place.
>
> Fixes: b6507596dfd6 ("MIPS: Alchemy: au1xmmc: use clk framework")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/au1xmmc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
> index a9a0837153d8..c88b039dc9fb 100644
> --- a/drivers/mmc/host/au1xmmc.c
> +++ b/drivers/mmc/host/au1xmmc.c
> @@ -1097,8 +1097,9 @@ static int au1xmmc_probe(struct platform_device *pdev)
>         if (host->platdata && host->platdata->cd_setup &&
>             !(mmc->caps & MMC_CAP_NEEDS_POLL))
>                 host->platdata->cd_setup(mmc, 0);
> -out_clk:
> +
>         clk_disable_unprepare(host->clk);
> +out_clk:
>         clk_put(host->clk);
>  out_irq:
>         free_irq(host->irq, host);
> --
> 2.34.1
>
