Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9ED550572
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 16:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbiFROKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 10:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235386AbiFROKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 10:10:45 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124246371;
        Sat, 18 Jun 2022 07:10:44 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id z14so6419540pgh.0;
        Sat, 18 Jun 2022 07:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=ow8g3o4z79Y5Cr2CRU5IK8a4Nx81Y5TgND6Vb+EHq2A=;
        b=I2mm4Rlo4JbRzZncPQX5K+A6VfD1WPz4umBSLloPa2vNlBf5n7u5e5Q8ck/n8xAcgT
         SBsy6yUmq4Nv/ftAlSnchjoAmeca+Hii490/4yQu/Q5CplEQnBwBbj1zpv4KDgJ/Xp0N
         qm0029PtaHAO1cp6pQf2xUdNQPQYXnSXdC/ivYthGppz2aHagL+qstK4OTw7siJoPBLI
         6BTuTLNHMRMV/+e69E6JqGJov0BVUOHahFc31t6rDcW7tnFdboAtvd1pF+ySSVvyNXlI
         i0MkFeVBXo6cMdKv3b0tjXXRJKHMGNXdLBNNYjqUuiNQ/UVfzNsBQqCV1kaJSgYF+j9R
         sPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ow8g3o4z79Y5Cr2CRU5IK8a4Nx81Y5TgND6Vb+EHq2A=;
        b=4d+3IRIjr1aoDcuj2Ctg9ESv+tV0Y2GUZtZREv2l8COeahBTri8iXXSct4u6LC9l1z
         HPeREMYarbP3WzppjyBYuBpmHp+fg2JfJFfpJnNMATfvmBMAOhLNm2IjOlgvxQSp40K7
         NivVkWm7DFjqEs/idkAnq8ENNfQBeThO/u3vLX/8VzdTS5qXCZiAXL0MV0i+xtuuaAhK
         0OZlXPx3B1mo4/VCD4n152vorxC7vWFZUENZ7kmZwAxLnGbkcabL4eNhXkBVhSi4C58T
         5E5/zfX3vZGbVzAoHOaj0+/TQ7qY1jZyt8dJcB2IL/GC+NHl1Ha2NSpQL9TujLiA+LLn
         Gmjg==
X-Gm-Message-State: AJIora8OLND9aARDZcWJtiVafE/gXW5mYZ7novV0vZPTztnmYepZkzFa
        D3lBpCCRboy+VNzlZKSXxFA=
X-Google-Smtp-Source: AGRyM1uBDBheUIBa3LF5ThEugEca5LdgbPgylYXdAbfL/ChjXdHKb3W7RxpttWO98MxnzMb+JkAjJQ==
X-Received: by 2002:a05:6a00:21c2:b0:4fa:914c:2c2b with SMTP id t2-20020a056a0021c200b004fa914c2c2bmr12088578pfj.56.1655561443391;
        Sat, 18 Jun 2022 07:10:43 -0700 (PDT)
Received: from [172.30.1.37] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id j4-20020a62c504000000b00518a473265csm997780pfg.217.2022.06.18.07.10.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jun 2022 07:10:42 -0700 (PDT)
Message-ID: <1c9e0697-ff02-d678-f231-8a3bc2e6be6e@gmail.com>
Date:   Sat, 18 Jun 2022 23:10:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] devfreq: exynos-ppmu: Fix refcount leak in
 of_get_devfreq_events
Content-Language: en-US
To:     Miaoqian Lin <linmq006@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220526082856.37594-1-linmq006@gmail.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20220526082856.37594-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 5. 26. 17:28, Miaoqian Lin wrote:
> of_get_child_by_name() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when done.
> This function only calls of_node_put() in normal path,
> missing it in error paths.
> Add missing of_node_put() to avoid refcount leak.
> 
> Fixes: f262f28c1470 ("PM / devfreq: event: Add devfreq_event class")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/devfreq/event/exynos-ppmu.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
> index 9b849d781116..a443e7c42daf 100644
> --- a/drivers/devfreq/event/exynos-ppmu.c
> +++ b/drivers/devfreq/event/exynos-ppmu.c
> @@ -519,15 +519,19 @@ static int of_get_devfreq_events(struct device_node *np,
>  
>  	count = of_get_child_count(events_np);
>  	desc = devm_kcalloc(dev, count, sizeof(*desc), GFP_KERNEL);
> -	if (!desc)
> +	if (!desc) {
> +		of_node_put(events_np);
>  		return -ENOMEM;
> +	}
>  	info->num_events = count;
>  
>  	of_id = of_match_device(exynos_ppmu_id_match, dev);
>  	if (of_id)
>  		info->ppmu_type = (enum exynos_ppmu_type)of_id->data;
> -	else
> +	else {
> +		of_node_put(events_np);
>  		return -EINVAL;
> +	}
>  
>  	j = 0;
>  	for_each_child_of_node(events_np, node) {


Applied it. Thanks.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
