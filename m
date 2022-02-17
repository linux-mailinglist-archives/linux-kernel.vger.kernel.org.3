Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943AF4BA034
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 13:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240455AbiBQMdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 07:33:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240447AbiBQMdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 07:33:20 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B4029C131
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 04:33:05 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id c192so3070472wma.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 04:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=A4ihWqAWL7//p3iQK7YSrjmSgIx/TozBvgFAto3VfAQ=;
        b=GRRRiTCv8hnisiN6ONs5tg3v4oOGWeum3t6YczSfOgdpj32PYEEQ3pgnZHAzmHMl2j
         9boNdFP3Ytw5MPqHAQR09XKakYJQlbNnAKRJXHXet7dN9YYx0WAMV91BinoBkraGbD4n
         JulGmRM1LGwObP99Znw7L0m4svYFJIf3AjqenZVQF4k2st7439nWOsrBfvoB2CVu5Gh2
         72BPoGHOEUmp1I6LCQ+kmR7C0M3B80ZM7Aa1ICxJ60F5JOYi6bI/hh4P8Gm3pl0o+uaw
         aBYaxe5IJzzbzbuJvrhl4yHEAiziqsiIJSd8LMB+QJ0AWgr8yOmsS7HyB6abT2XMUebj
         1TQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=A4ihWqAWL7//p3iQK7YSrjmSgIx/TozBvgFAto3VfAQ=;
        b=F6dDXcprZtnBlzJtSXBU3vfpv7JYgUl2PNhwhf2R067K0gy67BWQ1KrypKJxynNK/t
         lEIMlfYFkqcOVZBxbAlk+m02HoDcmzIuFqhCTWNo1DRUIQe5XmfvbLittWqpN4UOLsOh
         XRABteAsqKhO1ci1ybQ0Icw79cpzmeKnJpJbVw2XLX8HncxzCMe3bj+5AFHAaDUjQgv0
         Gk4s6odimhKUsyFYE2ssopYc8+VYYDMmnNUn4JZdelHUJq81Ppb0ZfbvX/c++E8RGiK8
         ws6QMNpn1UOUsmiOBCphta1mxNdoyl5arIxxJF8WdnY/xgSVCNk9kL4/xG9MFEUI+Nvi
         1zDQ==
X-Gm-Message-State: AOAM532QucarnuhTI9+eZ+hACEUvKg8u75aROsIKltnKcgY08OGb4xX2
        KY3UBA6Scl2JfDFzJCCd7yu9jYYlMGbdIA==
X-Google-Smtp-Source: ABdhPJxvbN6HhDAxUcts16g8LubGTeE4b5UaecyshENrZUvfY7vE8uQXOBVGVSEd04+4ProFuDJACw==
X-Received: by 2002:a05:600c:4e46:b0:37b:ea0d:35f0 with SMTP id e6-20020a05600c4e4600b0037bea0d35f0mr5804146wmq.181.1645101183622;
        Thu, 17 Feb 2022 04:33:03 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:6165:d98a:b553:c3c1? ([2a01:e34:ed2f:f020:6165:d98a:b553:c3c1])
        by smtp.googlemail.com with ESMTPSA id ay38sm1779946wmb.3.2022.02.17.04.33.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 04:33:03 -0800 (PST)
Message-ID: <1812eadf-7924-5abd-857b-22b7dfdf8f7d@linaro.org>
Date:   Thu, 17 Feb 2022 13:33:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] thermal: cooling: Check Energy Model type in
 cpufreq_cooling and devfreq_cooling
Content-Language: en-US
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        amit daniel kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Pierre.Gondois@arm.com, Stephen Boyd <swboyd@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <20220207073036.14901-1-lukasz.luba@arm.com>
 <20220207073036.14901-2-lukasz.luba@arm.com> <YgG+TmLrCSXX4Bvt@google.com>
 <4a7d4e94-1461-5bac-5798-29998af9793a@arm.com> <YgKnnFl7Gp8AS30X@google.com>
 <e4532f65-7f8a-7e89-97c1-85cc61462040@arm.com> <YgQ9XLcto9v0fyTf@google.com>
 <d120110a-7d01-0cfd-f7eb-d160e17ec2a8@arm.com>
 <CAD=FV=VntGw1_AzJPpdOk0zSpOVZRH2X1JNg84JX+zCeU1jvXg@mail.gmail.com>
 <7c059f4f-7439-0cad-c398-96dbde4e49c1@linaro.org>
 <5b8ca53e-3595-85fd-5ae9-a5e8285e8513@arm.com>
 <53bc13ca-998f-ff83-d9f7-9a83d35b24fd@linaro.org>
 <97ecc29b-13a9-fa15-4e88-21c8612ebb7f@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <97ecc29b-13a9-fa15-4e88-21c8612ebb7f@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/02/2022 13:11, Lukasz Luba wrote:

[ ... ]

>> Why not make it more generic and replace the frequency by a 
>> performance index, so it can be used by any kind of perf limiter?
> 
> For that DT array, yes, it can be an index, so effectively it could be
> a simple 1d array.
> 
> something like:
> 
> msm_gpu_energy_model: msm-gpu-energy-model {
>      compatible = "energy-model"
>      /* Values are sorted micro-Watts which correspond to each OPP
>         or performance state. The total amount of them must match
>         number of OPPs. */
>      power-microwatt = <100000>,
>              <230000>,
>              <380000>,
>              <600000>;
> };
> 
> then in gpu node instead of having 'dynamic-power-coefficient',
> which is useless because voltage is missing, we would have
> 'energy-model', like:
> 
>      energy-model = <&msm_gpu_energy_model>;
> 
> 
> If you agree to continue this topic. I will send an RFC so we could
> further discuss this idea. This $subject doesn't fit well.

Yes, definitively I agree to continue on this topic.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
