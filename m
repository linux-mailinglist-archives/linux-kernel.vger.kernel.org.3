Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90FF754BE27
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 01:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358200AbiFNXHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 19:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358411AbiFNXGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 19:06:46 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8C55372A;
        Tue, 14 Jun 2022 16:06:40 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id f65so9816655pgc.7;
        Tue, 14 Jun 2022 16:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=42av7YccJZwfJfbLS94o0cmZvyb3OSKawVNa38bn1Nw=;
        b=QJdJD1/xomxo4MujjvIdxEpf8Yi6xAgTBdHfwKLfwLZ1YciE11z6yWkCw5+yuuJ0N+
         TiOU97D2IuAKalPEI7q+rJR0SLmwqtQ8WAJOWwUzcHPXBz4k5nI+MF8V9HMtzEwjitbv
         I+aWIp0O/NtWPIei/Zv2f59PsTXRQRhjg3usiqgWsBZmOcsxp3xhfgQ+nVQ6zdyJlr1a
         rSgac4dz1E/Lodd4q0b8EAg2x2PMgO4L+BM2sMCOAOl8WvxhGkWMfd7+3tZIQWwTBAYR
         1BqY0eiRnyVZbG2RjFXRNL/8O3Z+SPAERQoYPGTiULSrD+cJpVoWX/pfk7t0G5akV3Z4
         xC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=42av7YccJZwfJfbLS94o0cmZvyb3OSKawVNa38bn1Nw=;
        b=aRSJs93TbhivFNx/NbfbyxYooJoET4SR7+DehPMNUihqoGjfxncYqe6Bor8e572Ga3
         am1KbrEhZbXVFTB9VBjzpEZCYDnZU9lSbYm3F4oDQtg6yojP/UeqivvcXNkbHlxH3IlD
         o5Tc/vDcswjfxn3C7/+9S4gGfhNZVcFDmUncWlh/Mjg7R6JavixQimcBk5qcNOIFjiTn
         tytdm3EezFGbecrpFBgT7vq+IqN9/tjgecktk8bylVSjR9mrUxhFjS16gk0bAm9M11B2
         McYuJzo/yYUMLfQGwSyw9NP6hSQT8KIhfuYbeXmdNtyTw4uCRBsiK8hdhIrwzx5fh50Z
         StZg==
X-Gm-Message-State: AOAM533fbmQQiXkxYanePTvelMRpk25lQBOAf3hnL2cmE9N2SJg+YlwO
        86F64KoZprw6+EXmRCk1fMPKHzoBVTE=
X-Google-Smtp-Source: ABdhPJzU5RacWF1n4c/IE6489r/hNvE5yfir9PjcH0+N2/H5ip/eJyEH42vwxVUUTjvNgmSlwHZUog==
X-Received: by 2002:a63:2a47:0:b0:3fe:2437:5d25 with SMTP id q68-20020a632a47000000b003fe24375d25mr6580177pgq.539.1655248000184;
        Tue, 14 Jun 2022 16:06:40 -0700 (PDT)
Received: from [172.30.1.37] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id n89-20020a17090a5ae200b001e880972840sm131881pji.29.2022.06.14.16.06.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 16:06:39 -0700 (PDT)
Message-ID: <95e3a5ff-3f41-d7bf-fac5-2dbd2832f767@gmail.com>
Date:   Wed, 15 Jun 2022 08:06:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 3/5] PM / devfreq: Fix kernel panic with cpu based
 scaling to passive gov
Content-Language: en-US
To:     Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220614110701.31240-1-ansuelsmth@gmail.com>
 <20220614110701.31240-4-ansuelsmth@gmail.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20220614110701.31240-4-ansuelsmth@gmail.com>
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

On 22. 6. 14. 20:06, Christian 'Ansuel' Marangi wrote:
> The cpufreq passive register notifier can PROBE_DEFER and the devfreq
> struct is freed and then reallocaed on probe retry.
> The current logic assume that the code can't PROBE_DEFER so the devfreq
> struct in the this variable in devfreq_passive_data is assumed to be
> (if already set) always correct.
> This cause kernel panic as the code try to access the wrong address.
> To correctly handle this, update the this variable in
> devfreq_passive_data to the devfreq reallocated struct.
> 
> Fixes: a03dacb0316f ("PM / devfreq: Add cpu based scaling support to passive governor")
> Signed-off-by: Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/devfreq/governor_passive.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
> index 3c3322adea03..be8aa6830413 100644
> --- a/drivers/devfreq/governor_passive.c
> +++ b/drivers/devfreq/governor_passive.c
> @@ -395,8 +395,7 @@ static int devfreq_passive_event_handler(struct devfreq *devfreq,
>  	if (!p_data)
>  		return -EINVAL;
>  
> -	if (!p_data->this)
> -		p_data->this = devfreq;
> +	p_data->this = devfreq;
>  
>  	switch (event) {
>  	case DEVFREQ_GOV_START:

Applied it to devfreq-fixes. Thanks.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
