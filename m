Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C5C56D243
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 02:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiGKAqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 20:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiGKAqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 20:46:50 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E86B879
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 17:46:49 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id c13so3161023pla.6
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 17:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jy+u2/Orkw5KmxP7WWAAr+h35zqqzgNFiJmE5176PKs=;
        b=FKr76hKbqTHdXaZzcQk1JcbTd4xuSqOxQDHNWsg9ayDudMqqReoSZ9z5QmGGwMFK6S
         dlFfuOyqGl71Bl5zPoaiYh/JYKPihW/xDoCmV0Up3twQrSU6cLI9zOefwxA9dSMbxhf0
         kZ5NObhrk1+w6DieyXHAGPwqI95jn+lqRn34dPf+571/gtjAxv2l+RnoeOe1TmqaS6cq
         701Se9xvjjzjHCEAMytfoLPCUhjaeF6YQ95sji2Aa41KGdmnX+rlXhVqWJTw/UQKC6Bw
         q18kqUPqiLKJG4VA8SyuGe2jEKBO/BAB6QS5HZY3WEaFIv6UxxJu1UNvLixrRep5TMSh
         TtSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jy+u2/Orkw5KmxP7WWAAr+h35zqqzgNFiJmE5176PKs=;
        b=2L9z96oEK1xgfNlarT5Ua7GTw51mXPS7Vlt2iehqVi15PItxVKcFaGchUH7lwVFRC/
         YtbMJK2ukuVeSXGQBnkxiWyNa3XpUFPZbrf9Esh3yZMYePtLiK8ckp2DbFfoU0hNJujd
         ZqPSPbmwghYa4yDgJ52gW/5E02VZiggv+wxntvLmohpMchYwO+6OFrRXOo14RxD737RD
         2uDA34JqyICR4GVylxk8ZNu+PPPyyD9g/0uKUXzD4gWo5ajIGPUKCvQF59Fq96s8Q8cV
         nJLQ5ReVondzCAS3ORMLuLS8u2OD4GyFqoPMQXFTto8C5FyNBH8lrsNrtdA4Ku5OtkY/
         qoWw==
X-Gm-Message-State: AJIora8LPrRZBUi2Qn2+06N61WSToiCQyWdQL2fFOqB4LTog6IZL/HeK
        MsNSWfM5sHeGw6El/XGu+Y64PQ==
X-Google-Smtp-Source: AGRyM1uNhy5evo7SwlchejT3g9GtNUWQV4wZlNyCE2q8RGYdxI34ybn5w9nncvXTYD1BAA5bxfIXQg==
X-Received: by 2002:a17:902:da88:b0:16c:27f9:8762 with SMTP id j8-20020a170902da8800b0016c27f98762mr13845419plx.85.1657500408674;
        Sun, 10 Jul 2022 17:46:48 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id y12-20020a17090322cc00b0016bd16f8acbsm2490732plg.114.2022.07.10.17.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 17:46:48 -0700 (PDT)
Date:   Mon, 11 Jul 2022 06:16:39 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org, Ionela.Voinescu@arm.com,
        Dietmar.Eggemann@arm.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 0/4] qcom-cpufreq-hw LMH irq/hotplug interractions
Message-ID: <20220711004639.fpppw7gcv5lkyghs@vireshk-i7>
References: <20220704112739.3020516-1-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704112739.3020516-1-pierre.gondois@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-07-22, 13:27, Pierre Gondois wrote:
> v2:
> - Rebased on v5.19-rc5
> - Changed irq checks from '< 0' to '<= 0' to be aligned
> 
> The patch-set was tested on a rb5 with an old firmware version:
> UEFI Ver    : 5.0.210817.BOOT.XF.3.2-00354-SM8250-1
> Build Info  : 64b Aug 17 2021 23:35:39
> 
> commit ffd6cc92ab9c ("arm64: dts: qcom: sm8250: add description of dcvsh
> interrupts")
> enables DCVS (Dynamic Clock and Voltage Scaling) for sm8250 chips
> (so rb5 included). As no LMH (Limits Management Hardware) interrupts
> were seen, the firmware used for testing should not be able support
> them.
> 
> This patch-set should still contain relevant modifications regarding
> LMH interrupts and CPU hotplug. Still, it would be good to test
> it on a platform which actually uses LMH interrupts.
> 
> Pierre Gondois (4):
>   cpufreq: qcom-hw: Reset cancel_throttle when policy is re-enabled
>   cpufreq: qcom-hw: Disable LMH irq when disabling policy
>   cpufreq: qcom-hw: Remove deprecated irq_set_affinity_hint() call
>   cpufreq: Change order of online() CB and policy->cpus modification
> 
>  drivers/cpufreq/cpufreq.c         |  6 +++---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 11 ++++++++---
>  2 files changed, 11 insertions(+), 6 deletions(-)

Applied. Thanks.

-- 
viresh
