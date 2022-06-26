Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6559A55B449
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 00:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbiFZWPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 18:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiFZWPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 18:15:04 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C7E2DC1;
        Sun, 26 Jun 2022 15:15:03 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id a4so2305lfm.0;
        Sun, 26 Jun 2022 15:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XHCbllkBeLeSjH8vK0GpVgCRiCwSLLCr2jMYejhftaU=;
        b=ZE0PLd6l+It8dLl4j2n+JmT2JwuQgVzYexXvyObyR1qap9PLYIaruYuhbqDVr8sImp
         cumwYN+jY6+msbvyY3iMDMlYLtk2zS6ktEOV13LCWXwUH8umnm+y5GvdJZfc9MH5bR4N
         pCalbqA8BTOyyQmIHBMYD7+/A4frglOPOqjzTBRkVSTwTO7qSyaqIZpEbi5sjcs9kXUa
         O/Tu0Nb+FR1zivFm5858rD9htf6J95OrnsQZ+p0ryEn33sQEQc0Q2fsOPnaXvd9HW0Lt
         avqEwy2idiVMD9/YE6K4z3KJjhIPnv4ZD1Gdy14T60MZF8e2RT1qy/l0ksZnJqiahyuN
         zWeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XHCbllkBeLeSjH8vK0GpVgCRiCwSLLCr2jMYejhftaU=;
        b=MOi8lFN3rfAgPC7DIhZsVZe7U+TLp969SmPgUbGwTYoaBwyF8c2mmGPPAIcZqlvTzK
         /CY73Czu4ZH91st3cXBlYs0ZTViop0Kimp+VbJUrk+cuszrzjH/aYr469AS4KNq3GvuQ
         PK02f84gqCNYzW8SsZ69cBTNnjBpd3TOt+Qp7TRPRXQla6cKLzF5UU/eglhI7MZ+jg4U
         NQRAkbPVnbQWaT4FJ3CVDp5sRWLw6QnTGAycwenyAqoR+pLsiJBZmoLmDJ4Qo5fz8t4v
         +LtWJl0UBqvYww1CRkY9g63t7v79wcaNEQQArcAE6yjEZwhTdmGEXaP4cM2YIexPoFk9
         QrzQ==
X-Gm-Message-State: AJIora8GSWTEnSeDaqm1ByjKDExztUf+2aXndGdCeUzZbXjh81ShrIhP
        Y6X0dNkEBppI2BMhTv3TUlU=
X-Google-Smtp-Source: AGRyM1ttJa7fcjrbvFQtIejHinelD+5+3JfCeRzS/Y6MzAL2ZVVQ9HYfV3+Dp+3KNEfsjtZmJ1rUXQ==
X-Received: by 2002:a05:6512:793:b0:47f:82d0:fadb with SMTP id x19-20020a056512079300b0047f82d0fadbmr6578789lfr.545.1656281701212;
        Sun, 26 Jun 2022 15:15:01 -0700 (PDT)
Received: from [192.168.2.145] ([109.252.118.164])
        by smtp.googlemail.com with ESMTPSA id s13-20020a05651c200d00b0025a928f3d63sm1117650ljo.61.2022.06.26.15.15.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 15:15:00 -0700 (PDT)
Message-ID: <73d39022-c6fc-0c21-cb68-9714846f02bf@gmail.com>
Date:   Mon, 27 Jun 2022 01:14:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 22/31] soc/tegra: Migrate to dev_pm_opp_set_config()
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1653564321.git.viresh.kumar@linaro.org>
 <449b344f037c7ef1970bc84d31e0d4c4cb4d2951.1653564321.git.viresh.kumar@linaro.org>
 <20220624004831.po35sowzfo4c47b3@vireshk-i7>
 <20220624005700.oj4etaajbutvsym7@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220624005700.oj4etaajbutvsym7@vireshk-i7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

24.06.2022 03:57, Viresh Kumar пишет:
> On 24-06-22, 06:18, Viresh Kumar wrote:
>> +       struct dev_pm_opp_config config = {
>> +               /*
>> +                * For some devices we don't have any OPP table in the DT, and
>> +                * in order to use the same code path for all the devices, we
>> +                * create a dummy OPP table for them via this. The dummy OPP
>> +                * table is only capable of doing clk_set_rate() on invocation
>> +                * of dev_pm_opp_set_rate() and doesn't provide any other
>> +                * functionality.
>> +                */
>> +               .clk_names = NULL,
>> +               .clk_count = 1,
>> +       };
> 
> Slight modification here, sorry about that. We just need to set the
> name as NULL and not the array itself.
> 
> diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
> index cd53e46c4058..6a099d764cce 100644
> --- a/drivers/soc/tegra/common.c
> +++ b/drivers/soc/tegra/common.c
> @@ -116,7 +116,7 @@ int devm_tegra_core_dev_init_opp_table(struct device *dev,
>                  * of dev_pm_opp_set_rate() and doesn't provide any other
>                  * functionality.
>                  */
> -               .clk_names = NULL,
> +               .clk_names = (const char *[]){ NULL },
>                 .clk_count = 1,
>         };
> 

Looks okay. If you'll solve the cpufreq problem where OPP config is set
by two drivers for the same cpu device and will keep the set_opp()
helper that is needed by the Tegra 3d driver, then it all should work
for Tegra. Looking forward to the next update of the OPP patches, thank you.
