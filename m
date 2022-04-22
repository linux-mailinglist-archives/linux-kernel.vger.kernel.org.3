Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925FF50AD93
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 04:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443257AbiDVCDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 22:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443361AbiDVCDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 22:03:08 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEE621806;
        Thu, 21 Apr 2022 19:00:16 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id bg9so6156718pgb.9;
        Thu, 21 Apr 2022 19:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=64m28fBryaa/0LokFVk4B8cMevkIz2gMYP82HTmvutw=;
        b=Rcr/31RNS0r5SCKGGMwWmIxQv8IW1Y4db6TclnbUeN0Kw20gfWTdHHjDvJZ7SFnvXB
         IUXtYwmFCB/ovV8mGOj1s+xXqA7SDoW74lU5hEGBAFLklRFInVbUeRWJTRPlNzBOwUE4
         gjH1CyHoRSz10/6qCb3H0QnuyorJ+ozpBg42jdEWaxAKAf9yMtu7Ch8pX1tZ6vRYlX3p
         utR+xraG0gjPS5q7+SxccJq0L0xA5B2gOe/FsM5vFq+riSDUf/OZf9RncPAwKiM2ITtV
         5RiGkTT37O03nvst0BlN9CLoHOEmBoi3SVLMLr38nsBzPkJpyBFVzk6O+lRUfxo6lxll
         6uVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=64m28fBryaa/0LokFVk4B8cMevkIz2gMYP82HTmvutw=;
        b=idet9FAtTJMcsi6ceVDwLZkdIdKX+IUK3PlibVVa88XoFflKqIWvncClfznip0hpGa
         DxUvue6iKLx2tV9MSCHSlSJfpDF7GEBWoZZMk6v0xL7n0/f9Rv/TunQ+qLpCfGQHpwey
         bxSvauPDMzw5+QAkTmY2PSzQQvmgfqx8nBBM1Y/zDStVKSo6NF/dxMyQJl0WRmhaQhx9
         hMDkgutkyNf4QqG4u8Eh8bDjRnRl7KSQmBCUHgn0zYEJt4OxeAOVlxIZDcUOmEo/tidX
         sZegpCqf1hz9WkncdgN/H0mSmm5GqbX6Ja8IlPVyYYMjhcQj0gN9D9IBWRml+cKSUe2i
         B5nw==
X-Gm-Message-State: AOAM53369GeCBBeHwBbvSTZAS8DHKgFMwyfaybxUuNTOsZ8NbAbpeCdI
        bOLqKC3boniA+Q9WWjwN55I=
X-Google-Smtp-Source: ABdhPJzFAWyBCdn951bBPGFgOuZyTdWDZQBjgBFBLLXESwJ8SnJjeDwVU119HyzOasnAI4M2loDWdA==
X-Received: by 2002:a63:a551:0:b0:3aa:5150:a94a with SMTP id r17-20020a63a551000000b003aa5150a94amr1987597pgu.144.1650592816370;
        Thu, 21 Apr 2022 19:00:16 -0700 (PDT)
Received: from [192.168.1.100] ([159.226.95.33])
        by smtp.gmail.com with ESMTPSA id y9-20020aa79429000000b0050ad02027d9sm396208pfo.197.2022.04.21.19.00.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 19:00:16 -0700 (PDT)
Message-ID: <8e893363-3e47-2abe-7111-b3fb0888d4fc@gmail.com>
Date:   Fri, 22 Apr 2022 09:59:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2] clk: imx: scu: Use pm_runtime_resume_and_get to fix
 pm_runtime_get_sync() usage
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, Abel Vesa <abel.vesa@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220422012059.52267C385A5@smtp.kernel.org>
 <20220422013317.30362-1-linmq006@gmail.com>
 <20220422014411.4F96BC385A7@smtp.kernel.org>
From:   Miaoqian Lin <linmq006@gmail.com>
In-Reply-To: <20220422014411.4F96BC385A7@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/4/22 9:44, Stephen Boyd wrote:
> Quoting Miaoqian Lin (2022-04-21 18:33:16)
>> If the device is already in a runtime PM enabled state
>> pm_runtime_get_sync() will return 1.
>>
>> Also, we need to call pm_runtime_put_noidle() when pm_runtime_get_sync()
>> fails, so use pm_runtime_resume_and_get() instead. this function
>> will handle this.
>>
>> Fixes: 78edeb080330 ("clk: imx: scu: add runtime pm support")
>> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
>> ---
> Please don't send patches as replies to previous versions of the patch.

Sorry, I thought I should keep them in one thread, to provide the context

for other people to follow up. Am I suppose to resend it?

>>  drivers/clk/imx/clk-scu.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
>> index 083da31dc3ea..2044e62980e3 100644
>> --- a/drivers/clk/imx/clk-scu.c
>> +++ b/drivers/clk/imx/clk-scu.c
>> @@ -528,7 +528,7 @@ static int imx_clk_scu_probe(struct platform_device *pdev)
>>                 pm_runtime_use_autosuspend(&pdev->dev);
>>                 pm_runtime_enable(dev);
>>  
>> -               ret = pm_runtime_get_sync(dev);
>> +               ret = pm_runtime_resume_and_get(dev);
>>                 if (ret) {
>>                         pm_genpd_remove_device(dev);
>>                         pm_runtime_disable(dev);
>> -- 
>> 2.17.1
>>
