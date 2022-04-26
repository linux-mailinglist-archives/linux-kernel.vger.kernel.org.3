Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165CA50FC0E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 13:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346149AbiDZLlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 07:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238202AbiDZLld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 07:41:33 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4355A1EEF5;
        Tue, 26 Apr 2022 04:38:23 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id ay36-20020a05600c1e2400b0038ebc885115so953782wmb.1;
        Tue, 26 Apr 2022 04:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=l7SZN+gn+w67vIMUfY98UKAbA7uOnpDqNzGrHL+gC5c=;
        b=eoStLUnb7CeMxd9hbZy/U6QAaT5n5EugAremR3+IdPRp5H5amqgs/NWJ65/XbyxCiV
         tA/Ghtpc2H3RiqPHoA155YmW+UXiIZtbvlw1Qn7HAk7cBCEY85vBckZprdXODtn72NX4
         yFLxdwDX1l8JJnRUAroTga4EF3mIaMWj8lgpS9FEPmd6KtD+dFgOQ2khtMwoZ64h3mXr
         ponXh4dwjbuGcQah0m5tJJK++QdejeORxZin/gto1x9Wsk0WTEOyaXZsO26r9WCErmcC
         xy93F4s3SEn4/EJNvs//LAEHVpxT2SgHLGIv2xMV6+P5Cq+OsZfeDfHJbHkJtZ/rU+dF
         zGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=l7SZN+gn+w67vIMUfY98UKAbA7uOnpDqNzGrHL+gC5c=;
        b=T8e1Ex1Ma2OazIOVWcznyUlRDADg/JyXHgEk2W3ne9ofSQ48Ok/Uv5oy6qJzv+/hR+
         7/fgbs58hSLIvuHnI2ZPWyOCQRNtArqdx9alyuZs82wTyoWlrOXBauizBEj8eQ8eMiSl
         HZw0OYDCOmvezPi8PdqCuxrj+kxGiyJJhbRcXjO37QG60PvvS2ktI3O07UJLrDZvuMvZ
         CSCQuto61k1C5iCZl/yRsqAplsr6VG+XZ2fAgupiJVIvPLl8xV65mMZMgeG7z3Uwndlu
         lImTpTUE6wVuUAVzrqahNz9S82BybG61NqLc/+kdhV0sGoPtj4gg3o+BfwEBcE71z4Sb
         ykVQ==
X-Gm-Message-State: AOAM533u6+PTvvKbleOJ4fg4O+5UKugIPGpXkPtj8zcu4kBfg423ZYR4
        2ERbPmyodPfA1MFPAQIAeyo=
X-Google-Smtp-Source: ABdhPJzlJ/ygsvmUV/0F3Ng+ZTbfSop588wEeRpKx1ZJ5wlB2aCBxL7+8NSqY0vDH3NutnV/DdmyJA==
X-Received: by 2002:a1c:5401:0:b0:38e:bf1c:d25c with SMTP id i1-20020a1c5401000000b0038ebf1cd25cmr20730810wmb.119.1650973101751;
        Tue, 26 Apr 2022 04:38:21 -0700 (PDT)
Received: from [192.168.0.43] (static-35-180-85-188.ipcom.comunitel.net. [188.85.180.35])
        by smtp.gmail.com with ESMTPSA id e17-20020adfa451000000b0020ada1a7c82sm5508369wra.11.2022.04.26.04.38.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 04:38:21 -0700 (PDT)
Message-ID: <1e951bad-1f26-6de2-43be-b1b5dc384794@gmail.com>
Date:   Tue, 26 Apr 2022 13:38:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] cpufreq: mediatek: Fix NULL pointer dereference in
 mediatek-cpufreq
Content-Language: en-US
To:     Wan Jiabing <wanjiabing@vivo.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220426111715.627609-1-wanjiabing@vivo.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220426111715.627609-1-wanjiabing@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/04/2022 13:17, Wan Jiabing wrote:
> Fix following coccicheck error:
> drivers/cpufreq/mediatek-cpufreq.c:464:16-23: ERROR: info is NULL but dereferenced.
> 
> Use pr_err instead of dev_err to avoid dereferring a NULL pointer.
> 
> Fixes: f52b16ba9fe4 ("cpufreq: mediatek: Use device print to show logs")
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/cpufreq/mediatek-cpufreq.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index bcabb3726a5b..901042e9a240 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -461,8 +461,8 @@ static int mtk_cpufreq_init(struct cpufreq_policy *policy)
>   
>   	info = mtk_cpu_dvfs_info_lookup(policy->cpu);
>   	if (!info) {
> -		dev_err(info->cpu_dev,
> -			"dvfs info for cpu%d is not initialized.\n", policy->cpu);
> +		pr_err("dvfs info for cpu%d is not initialized.\n",
> +			policy->cpu);
>   		return -EINVAL;
>   	}
>   
