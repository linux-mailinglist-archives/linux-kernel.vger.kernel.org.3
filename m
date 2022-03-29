Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F564EA923
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 10:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbiC2I0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 04:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233868AbiC2IZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 04:25:59 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79AA1F89D9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 01:24:14 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d7so23639358wrb.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 01:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=4q7utA2N5uBdT/Hk7/7TmYG0IOBace6qzAeWlAkbf9o=;
        b=1CpE15dMw2nEkW4YYCMic9aIKN2w3BNoDfSIkhBuAqCEEzczO2Y6fdOfXW+XelLTAQ
         A7SdjqBc4nxPzuMKdFd6vSMl88516biNL7AhFjZIpwaFRyBqAegNsblBNLlF/Rjmh4+k
         TjeLLdIUxio9O2iohXtFhvi2sTzYoZTU6HfRyUHmk+sYvImqH+oMggNAoVV0R7FsUE44
         npiH/sfKMS/F5I7QcO6RvJiM538xhyb6SEVfA2GHJVOyK/cb293haK2W8D5xbuOtBYiD
         gCOn3lZgrE2no/rDri5oQCiz8jZuyRFRL+lRphFsdaAp1WczDBU4ecRlplWu+7Eh+wiE
         lFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=4q7utA2N5uBdT/Hk7/7TmYG0IOBace6qzAeWlAkbf9o=;
        b=4p5DrxlZjmIalvuSW6nmp9znJBsjhC4I6Bl2rUTrPKsVcvDYQXU+EKglsDLT/z9d+0
         p4iRun1UachDuNq1wXhKLEQUFA+vx0xNEqqxlEzru4F5zUgYeOKlZAh7qzH858eDxu/+
         ZEYH2k4KbXPnVRxrNbigqGCyhZ4ksG9uCwlt/Li2cQCXNUAxxIhd+4pzQJA6p1Mv6fYH
         W8s6NXgQSWbwTzl5xZZJWy56NfnwEiAL75X4cZvmEnlhMAVWp2L/3nNf8it1SQcr4xYi
         Rq/1vy9Nm3oKoIQ8Gy6HJzvIHR6pDSwWotKTZhqjftfL1ycAUuqWSPcQDKE57tQ+6pCT
         aBIQ==
X-Gm-Message-State: AOAM530gCvY/1aDA5yqA4+iifo2N+AyfwHf85GiYg3h9/PVECGoU9wst
        SY5rbQ1zLHsQO8b0ppZwNDUF5w==
X-Google-Smtp-Source: ABdhPJzKxD/KLU6iWPF6ZxbUV+9xxFwOzMdCAGFHX4ig6YXgf4XhA3i6zqnXEY8LtnifQ8Zuyx/LWQ==
X-Received: by 2002:a05:6000:1568:b0:1f0:250a:d3ef with SMTP id 8-20020a056000156800b001f0250ad3efmr7916035wrz.402.1648542253218;
        Tue, 29 Mar 2022 01:24:13 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id l20-20020a05600c1d1400b0038cba2f88c0sm2000306wms.26.2022.03.29.01.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 01:24:12 -0700 (PDT)
References: <20220329060821.15251-1-qianggui.song@amlogic.com>
User-agent: mu4e 1.6.10; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Qianggui Song <qianggui.song@amlogic.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: meson: fix unused variable warning
Date:   Tue, 29 Mar 2022 10:21:42 +0200
In-reply-to: <20220329060821.15251-1-qianggui.song@amlogic.com>
Message-ID: <1j8rstjhec.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue 29 Mar 2022 at 14:08, Qianggui Song <qianggui.song@amlogic.com> wrote:

> The kernel test robot reported a warning as below:
>>> drivers/pinctrl/meson/pinctrl-meson-s4.c:178:27: warning: unused variable 'tdm_sclk1_c_pins' [-Wunused-const-variable]
>    static const unsigned int tdm_sclk1_c_pins[]            = { GPIOC_3 };
>
> Fix it by adding missing description about this pins
>
> Fixes: 775214d389c2 ("pinctrl: meson: add pinctrl driver support for Meson-S4 Soc")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Qianggui Song <qianggui.song@amlogic.com>
> ---
>  drivers/pinctrl/meson/pinctrl-meson-s4.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/pinctrl/meson/pinctrl-meson-s4.c b/drivers/pinctrl/meson/pinctrl-meson-s4.c
> index 3c7358f53302..067c6749c849 100644
> --- a/drivers/pinctrl/meson/pinctrl-meson-s4.c
> +++ b/drivers/pinctrl/meson/pinctrl-meson-s4.c
> @@ -575,6 +575,7 @@ static struct meson_pmx_group meson_s4_periphs_groups[] = {
>  	GROUP(tdm_d2_c,			4),
>  	GROUP(tdm_d3_c,			4),
>  	GROUP(tdm_fs1_c,		4),
> +	GROUP(tdm_sclk1_c,		4),
>  	GROUP(mclk_1_c,			4),
>  	GROUP(tdm_d4_c,			4),
>  	GROUP(tdm_d5_c,			4),
> @@ -937,6 +938,7 @@ static const char * const iso7816_groups[] = {
>  
>  static const char * const tdm_groups[] = {
>  	"tdm_d2_c", "tdm_d3_c", "tdm_fs1_c", "tdm_d4_c", "tdm_d5_c",
> +	"tdm_sclk1_c",

Thanks for fixing this.
Could you please try to keep this list somehow ordered a bit ?
Here you are adding a new line in the middle with single entry ... it
looks weird. 

>  	"tdm_fs1_d", "tdm_d4_d", "tdm_d3_d", "tdm_d2_d", "tdm_sclk1_d",
>  	"tdm_sclk1_h", "tdm_fs1_h", "tdm_d2_h", "tdm_d3_h", "tdm_d4_h",
>  	"tdm_d1", "tdm_d0", "tdm_fs0", "tdm_sclk0", "tdm_fs2", "tdm_sclk2",

