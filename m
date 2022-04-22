Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442A250AD3C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 03:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443085AbiDVBfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 21:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443057AbiDVBfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 21:35:07 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F04849F2C;
        Thu, 21 Apr 2022 18:32:16 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id n18so7550981plg.5;
        Thu, 21 Apr 2022 18:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=tqPDRS4nUWLBZ4JoPctO88qdw7Y1CafvutU8eDymN/U=;
        b=kFtNcHZTf2FKloMVXOAzRxo+H41+Xtg7jWHH1Xf1l0W9zZJlqMfeJgjHhC9+crPjM6
         N+t4E36meUhTeGrgL5Y3r4eTI+uCHhJ/Swsu9Nib0nqJOpYzUs9Fik8YeDyDtozYjXxx
         9+zeSAcM2IM20NqSgPP7SzBQHXf7C8hxCoYrR64aphYUIbo5E/BNCjPVA90OK/qFJGUk
         oiR8Xw/93AHSf7YTumh3NcrLbMnSU2E5mf/iF/SVHJSjJsdyWr6G/mlF17XvJHCkQf6l
         P7TlvBKMJkntE8NjnzcQdu5JnCnXwyIGsf1746TFUO1Rf4MJJhodaFZ69B01KpotA0l8
         HoCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tqPDRS4nUWLBZ4JoPctO88qdw7Y1CafvutU8eDymN/U=;
        b=CHs6U0ewurQX5vriGWfJwbkVNJ8TcoR1ZQ+1FBfF3dyFO+U2MTVsshCi2eMQ8F0ym3
         QXPpWi95jphUymHJo0XMqET+GM3zfRkEVlS+SdVyhN0WqmYKuj/gxgnEEKGeEyeEJJ4A
         eoBPXD0bdONvfpjy3eOgFVPC/D3sTGq1Ujd0slK2cChMV5xxMWIBiJ86ENiedmewTI6p
         XrvQSUtKT/bjU5QltTjIuMyGfi1QGxI+xREZ4E59+RYIeQ9d5Lu0YmDzTI6zOG1v5/Vh
         Jeyw/PCHXDg07xLIaao0VTqu8Be8vqBwQRG43jdI2gpYJ6DUTCOAlH6J9w73HhYTjhQn
         dPYQ==
X-Gm-Message-State: AOAM531Ed/igIeZkVG51qtYL2aFCEsVZPvJX/vJrHmmfZ/X0j/CwJGGN
        rCs4ZG6Z4bNErlYQgSWA50g=
X-Google-Smtp-Source: ABdhPJxFJnOIJNpFTRlL010JQMDVFmMgl+P7c+HrY3I81Q3POTN8/7Xmgyz+jXP4oA+FC3ZSAk1k0Q==
X-Received: by 2002:a17:902:6b0b:b0:158:f889:edd9 with SMTP id o11-20020a1709026b0b00b00158f889edd9mr1993953plk.122.1650591135627;
        Thu, 21 Apr 2022 18:32:15 -0700 (PDT)
Received: from [192.168.1.100] ([159.226.95.33])
        by smtp.gmail.com with ESMTPSA id r9-20020aa79889000000b0050a6fbc0c6bsm367159pfl.105.2022.04.21.18.32.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 18:32:15 -0700 (PDT)
Message-ID: <40b90933-a881-3bd8-4533-3ded023a3e95@gmail.com>
Date:   Fri, 22 Apr 2022 09:32:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] clk: imx: scu: Fix pm_runtime_get_sync() error checking
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
References: <20220412065719.17735-1-linmq006@gmail.com>
 <20220422012059.52267C385A5@smtp.kernel.org>
From:   Miaoqian Lin <linmq006@gmail.com>
In-Reply-To: <20220422012059.52267C385A5@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/4/22 9:20, Stephen Boyd wrote:
> Quoting Miaoqian Lin (2022-04-11 23:57:18)
>> If the device is already in a runtime PM enabled state
>> pm_runtime_get_sync() will return 1, so a test for negative
>> value should be used to check for errors.
> Maybe it should use pm_runtime_resume_and_get() instead?
Fair enough，I will send patch v2.
>> Fixes: 78edeb080330 ("clk: imx: scu: add runtime pm support")
>> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
>> ---
>>  drivers/clk/imx/clk-scu.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
>> index 083da31dc3ea..18c6190eeffd 100644
>> --- a/drivers/clk/imx/clk-scu.c
>> +++ b/drivers/clk/imx/clk-scu.c
>> @@ -529,7 +529,7 @@ static int imx_clk_scu_probe(struct platform_device *pdev)
>>                 pm_runtime_enable(dev);
>>  
>>                 ret = pm_runtime_get_sync(dev);
>> -               if (ret) {
>> +               if (ret < 0) {
>>                         pm_genpd_remove_device(dev);
>>                         pm_runtime_disable(dev);
>>                         return ret;
>> -- 
>> 2.17.1
>>
