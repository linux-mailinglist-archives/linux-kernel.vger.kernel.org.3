Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B78153A721
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 15:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354060AbiFAN6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 09:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353974AbiFAN5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 09:57:22 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAA435872
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 06:55:10 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 7so1177532pga.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 06:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:cc:in-reply-to:content-transfer-encoding;
        bh=PsjGVD7Reui31MSU63J1iKeBMkxXWeZ9AfTgcc/uvGU=;
        b=EofRlN3aikEIZe7XJgJdxUetgONlsRYqQ+CdJWrpshBMKh/5Sd7EQYaHQWlUsqvvsR
         MMKRKp3aJwZegCTkrdOaHxbghtM5sMsnw5aIJ+B9per/10MowIfH1O4zr7I1hhmujMai
         az5Xdd0o5izj69JoVEeRPg5CEVdgr2krgefWbjthsccc1oeHG/zZEE5Lr+VIc3+WkBvZ
         puocbIQTPL6k1rp7jmEJ8OhdyvEW/xXMYZoecAJ1tn3ALAnfwR4OWukKHEmHmA2mkNfY
         DxTniy+hqsgtJedVQM4wipaBS+4WnD9c2+HG9CWacHoyiT6hediVsnlA8qcyjL+uZIm0
         7LAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:cc:in-reply-to
         :content-transfer-encoding;
        bh=PsjGVD7Reui31MSU63J1iKeBMkxXWeZ9AfTgcc/uvGU=;
        b=P+gZvMtCOd1hcvBLI8LK5CvabtS/32AajsEdFKba7lVE0fpkpDNxzlweP7zoPWqJQX
         Fgp9T1Jvtf0wOPCwF3+KGtIrVmmVb4uvbWvekh+bM3l3v0fI9z63Ec032yS/ez+gy4+h
         4dEtoCgryKiwdQszsz2QOVkhnH88oCm/oxDKYkfKJKFMjLgDrhHiX7yei5xa8UdgMc+j
         M0Xzvsc/Nlx+m+NYvQxGTKkUCGW4pygIvsWFTHGLYTXhmatKw1xCm8VPHf8pY4xFPxzl
         ggP0X8FZymqreHlLJuzJWT986ZXJ25Xzrhu/GpR8VJAFnKrGkoDjs9DhU3olRqglNOxl
         gQvw==
X-Gm-Message-State: AOAM530ShiN0l2xh3izpiCdNefKuxSDoqhCqFcDYW27DUGHDomj59ZjW
        I427PvMzYpzDXaWaC/pPEhk=
X-Google-Smtp-Source: ABdhPJx2kdH3EDLTWxxIZsf/SsRb2I8+HWu52bGvOlOTcxSZcRVI+7y/n58AnL2/Lz/6jyUB9+xjYA==
X-Received: by 2002:a05:6a00:1690:b0:517:cc9e:3e2d with SMTP id k16-20020a056a00169000b00517cc9e3e2dmr46548pfc.0.1654091709025;
        Wed, 01 Jun 2022 06:55:09 -0700 (PDT)
Received: from [172.16.4.4] ([219.142.146.177])
        by smtp.gmail.com with ESMTPSA id c9-20020a631c49000000b003fc600628a7sm1378030pgm.31.2022.06.01.06.55.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 06:55:08 -0700 (PDT)
Message-ID: <55d99105-8492-e020-bed6-82e52b5fc8a1@gmail.com>
Date:   Wed, 1 Jun 2022 21:55:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3] drm/v3d/v3d_drv: Fix PM disable depth imbalance
Content-Language: en-US
To:     Emma Anholt <emma@anholt.net>, David Airlie <airlied@linux.ie>,
        Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20220601122050.1822-1-linmq006@gmail.com>
 <YpdpCWW9+igsVydr@phenom.ffwll.local>
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     Miaoqian Lin <linmq006@gmail.com>
In-Reply-To: <YpdpCWW9+igsVydr@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Daniel

On 2022/6/1 21:26, Daniel Vetter wrote:
> On Wed, Jun 01, 2022 at 04:20:50PM +0400, Miaoqian Lin wrote:
>> The pm_runtime_enable will increase power disable depth.
>> If the probe fails, we should use pm_runtime_disable() to balance
>> pm_runtime_enable().
>> Also call disable function in remove function.
>>
>> Fixes: 57692c94dcbe ("drm/v3d: Introduce a new DRM driver for Broadcom V3D V3.x+")
>> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
>> ---
>> Changes in v3:
>> - call pm_runtime_disable() in v3d_platform_drm_remove
>> - update commit message
>>
>> Changes in v2
>> - put pm_runtime_disable before dma_free_wc
>> - rename dma_free to pm_disable
>>
>> v1: https://lore.kernel.org/r/20220105120442.14418-1-linmq006@gmail.com
>> v2: https://lore.kernel.org/r/20220106124657.32737-1-linmq006@gmail.com
> Maybe a bit late since we're at v3 already, but are there no devm_
> functions here that would dtrt automatically? 

Sorry I don't see one, or we can use devm_add_action_or_reset() to add handling

action. something like disp_cc_sm8250_probe() in drivers/clk/qcom/dispcc-sm8250.c

How do you think?

> Or is there another reason
> we can't use them?
> -Daniel
>> ---
>>  drivers/gpu/drm/v3d/v3d_drv.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
>> index 1afcd54fbbd5..f3380399fe17 100644
>> --- a/drivers/gpu/drm/v3d/v3d_drv.c
>> +++ b/drivers/gpu/drm/v3d/v3d_drv.c
>> @@ -286,7 +286,7 @@ static int v3d_platform_drm_probe(struct platform_device *pdev)
>>  
>>  	ret = v3d_gem_init(drm);
>>  	if (ret)
>> -		goto dma_free;
>> +		goto pm_disable;
>>  
>>  	ret = v3d_irq_init(v3d);
>>  	if (ret)
>> @@ -302,7 +302,8 @@ static int v3d_platform_drm_probe(struct platform_device *pdev)
>>  	v3d_irq_disable(v3d);
>>  gem_destroy:
>>  	v3d_gem_destroy(drm);
>> -dma_free:
>> +pm_disable:
>> +	pm_runtime_disable(dev);
>>  	dma_free_wc(dev, 4096, v3d->mmu_scratch, v3d->mmu_scratch_paddr);
>>  	return ret;
>>  }
>> @@ -316,6 +317,7 @@ static int v3d_platform_drm_remove(struct platform_device *pdev)
>>  
>>  	v3d_gem_destroy(drm);
>>  
>> +	pm_runtime_disable(&pdev->dev);
>>  	dma_free_wc(v3d->drm.dev, 4096, v3d->mmu_scratch,
>>  		    v3d->mmu_scratch_paddr);
>>  
>> -- 
>> 2.25.1
>>
