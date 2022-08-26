Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564425A2595
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 12:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245069AbiHZKMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 06:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiHZKMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 06:12:22 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F021EA9C10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:12:20 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id s6so1361259lfo.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Qvdys5dN+I9LUJHbK/6/No5KAdnIwq9CjmDCgjRtEK4=;
        b=qIIieiaXoC5YiikqGgeEJZ3Tej8dv40luO2+mNsojGpHrOqCMligsPfkpU0/dmBSav
         a2r7l9eXfPiJrTPymQcPszvHOfTscqbaU4NDP0Sw8oY9X+e8NHUCJCx1VmzFv+yGFGcy
         zppzzUrkE4x02ADCI4FBHNkZSSiDS+FIOS1jme/7jgzR0/7xdRSrFp/JnODlqiFY7Rs0
         jB9G3J9TSyAgYAgZFxAIe1sPsah/yJB1Pzgln7YiS5U6MMPcX49vpmE9CVel3rRm790o
         DP0w0bDy2ByNdMnyj4mYjFIhqBXlLI5hCQNCO+VbwGzB6lEAXuR1Vp6oeSQDPJj0tu5s
         IO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Qvdys5dN+I9LUJHbK/6/No5KAdnIwq9CjmDCgjRtEK4=;
        b=1u5lf5dBJW4nFWyy58DvcnU7U7nujEYZJkFO/COncmVPLm6SsUNd21S64F91A4c4Yv
         5O+LvmPXQPG67VRSAxuK5pNpxMC+eSGzg+JQQAJcBBfcv3dd9kY6ijXW/yBesjApInsT
         cfqyBLYdzpbRVi8KeGze7ZQ8MaR3eQoOFj85tUMFqwHnBWLnFHrFUscoILvuWET6QU5w
         yFj+CliXo1wkcA3wnoXX4CTinulkTQlvyR60cK5/9SRO6DNkM/2xqVOxEPaM+Qo7EpjL
         0/lsx4OSA/Mc2dgQauGDNfR4o1mubUYRm7CEdiYsrmik0aPac4BQO0uNhseh1Flg+Oqq
         CtfQ==
X-Gm-Message-State: ACgBeo1bukaMuK1r6N/5/YH+atmWnvFeBaJPxLXGugkTVOoR+oAzmm1z
        Yiowrm8LJi4m0EOTQtarzVdkhLKsZCnZ3Q==
X-Google-Smtp-Source: AA6agR6Ltpi7l0Rgxs/vwz5K1n21dO7YyWaBFrO/NCQdw9rAlL17n3agYbkSNTrnrYz0RdTIQw71kg==
X-Received: by 2002:a05:6512:304c:b0:492:cd69:6cb8 with SMTP id b12-20020a056512304c00b00492cd696cb8mr2547841lfb.551.1661508739349;
        Fri, 26 Aug 2022 03:12:19 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id c5-20020ac25f65000000b00492c627cab5sm323446lfc.254.2022.08.26.03.12.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 03:12:18 -0700 (PDT)
Message-ID: <941ddc17-87d3-aa3c-e6bb-46ecf4a7dfca@linaro.org>
Date:   Fri, 26 Aug 2022 13:12:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH -next] drm/msm/adreno: Switch to memdup_user_nul() helper
Content-Language: en-GB
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Cc:     robdclark@gmail.com, quic_abhinavk@quicinc.com
References: <20220826084524.2217022-1-yangyingliang@huawei.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220826084524.2217022-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/08/2022 11:45, Yang Yingliang wrote:
> Use memdup_user_nul() helper instead of open-coding to
> simplify the code.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/adreno/adreno_gpu.c | 14 +++-----------
>   1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> index 382fb7f9e497..50b33e14237b 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -339,17 +339,9 @@ int adreno_set_param(struct msm_gpu *gpu, struct msm_file_private *ctx,
>   	case MSM_PARAM_CMDLINE: {
>   		char *str, **paramp;
>   
> -		str = kmalloc(len + 1, GFP_KERNEL);
> -		if (!str)
> -			return -ENOMEM;
> -
> -		if (copy_from_user(str, u64_to_user_ptr(value), len)) {
> -			kfree(str);
> -			return -EFAULT;
> -		}
> -
> -		/* Ensure string is null terminated: */
> -		str[len] = '\0';
> +		str = memdup_user_nul(u64_to_user_ptr(value), len);
> +		if (IS_ERR(str))
> +			return PTR_ERR(str);
>   
>   		if (param == MSM_PARAM_COMM) {
>   			paramp = &ctx->comm;

-- 
With best wishes
Dmitry

