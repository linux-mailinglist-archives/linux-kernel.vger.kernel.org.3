Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4E45855F1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 22:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239111AbiG2UMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 16:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239023AbiG2UME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 16:12:04 -0400
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F92684EC6;
        Fri, 29 Jul 2022 13:12:04 -0700 (PDT)
Received: by mail-pf1-f176.google.com with SMTP id k79so1320650pfd.8;
        Fri, 29 Jul 2022 13:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=WqEsTmzo4i5fSlXYqdazJ4mWkRbar+SoV/KUVTSJNWs=;
        b=wQHXFNyXsTJWyHy8Es7Wc+FPEkRLvliewTYhZLHZfVTDk2FCi739eXGLRNRd067+XX
         axXk18E4R8M8mAMwvo4WTQmA+oR2I0SLacgoOZZ5d1OMIZX/xnes5/rPW8Eln0PJB2Wt
         gh/zq8MGJoB6yDM4xhVpc3ya5bMW0rGU00RwyuDwCpyA3WzCZn09pvO4CrrkWzdrNapE
         k7cJUVUv7p2udLmvmGuHWHffI8bZLo7CLk4/4EP7CbVQa3Uydy5FxU+5CeGOyTlZ32/3
         A21C8uvKlvpSX7H059f5AZzt7+4evgsXygMOcQWxve+QjHNTJ/LfPeUCdpBRZDlD3kJk
         El7A==
X-Gm-Message-State: ACgBeo0f6ZNX6etzdunuuJq/P9ETjvLa96lFaShN3bwWWo9gy3W6fqnn
        rQ43DT6Z0+Q3Hmm3NhxUkjE=
X-Google-Smtp-Source: AA6agR6iI8nn5Vcvd08VLRPwuWa8rIn7Kk4foThZXSwlQ5u9RHtvmZKSHYJvGz2KRhxKOklgT7jDBg==
X-Received: by 2002:a63:4407:0:b0:41b:b1df:cf6e with SMTP id r7-20020a634407000000b0041bb1dfcf6emr1509227pga.605.1659125523637;
        Fri, 29 Jul 2022 13:12:03 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:f090:7a49:3465:6a5? ([2620:15c:211:201:f090:7a49:3465:6a5])
        by smtp.gmail.com with ESMTPSA id e64-20020a621e43000000b0052ab42ea0c5sm3376910pfe.147.2022.07.29.13.12.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jul 2022 13:12:02 -0700 (PDT)
Message-ID: <7e8c58cf-64c1-8426-bf22-97d3df85ed38@acm.org>
Date:   Fri, 29 Jul 2022 13:11:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1] scsi: ufs: Fix ufshcd_scale_clks decision in recovery
 flow
Content-Language: en-US
To:     Stanley Chu <stanley.chu@mediatek.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        avri.altman@wdc.com, alim.akhtar@samsung.com, jejb@linux.ibm.com
Cc:     peter.wang@mediatek.com, chun-hung.wu@mediatek.com,
        alice.chao@mediatek.com, powen.kao@mediatek.com,
        mason.zhang@mediatek.com, qilin.tan@mediatek.com,
        lin.gui@mediatek.com, eddie.huang@mediatek.com,
        tun-yu.yu@mediatek.com, cc.chou@mediatek.com,
        chaotian.jing@mediatek.com, jiajie.hao@mediatek.com
References: <20220729075519.4665-1-stanley.chu@mediatek.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220729075519.4665-1-stanley.chu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/22 00:55, Stanley Chu wrote:
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 581d88af07ab..dc57a7988023 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -1574,8 +1574,6 @@ static ssize_t ufshcd_clkscale_enable_store(struct device *dev,
>   	ufshcd_rpm_get_sync(hba);
>   	ufshcd_hold(hba, false);
>   
> -	hba->clk_scaling.is_enabled = value;
> -
>   	if (value) {
>   		ufshcd_resume_clkscaling(hba);
>   	} else {
> @@ -1586,6 +1584,8 @@ static ssize_t ufshcd_clkscale_enable_store(struct device *dev,
>   					__func__, err);
>   	}
>   
> +	hba->clk_scaling.is_enabled = value;
> +
>   	ufshcd_release(hba);
>   	ufshcd_rpm_put_sync(hba);
>   out:
> @@ -7259,7 +7259,8 @@ static int ufshcd_host_reset_and_restore(struct ufs_hba *hba)
>   	hba->silence_err_logs = false;
>   
>   	/* scale up clocks to max frequency before full reinitialization */
> -	ufshcd_scale_clks(hba, true);
> +	if (ufshcd_is_clkscaling_supported(hba) && hba->clk_scaling.is_enabled)
> +		ufshcd_scale_clks(hba, true);
>   
>   	err = ufshcd_hba_enable(hba);

I see a race condition between the hba->clk_scaling.is_enabled check in 
ufshcd_host_reset_and_restore() and the code that sets 
ufshcd_clkscale_enable_store(). Shouldn't the code in 
ufshcd_host_reset_and_restore() that scales up the clocks be serialized 
against ufshcd_clkscale_enable_store()?

Thanks,

Bart.
