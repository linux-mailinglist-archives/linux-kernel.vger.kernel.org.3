Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3035A9B05
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiIAO7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234459AbiIAO6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:58:54 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C447A533
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 07:58:53 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id j26so9183025wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 07:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc;
        bh=l3pN9WTLDzQ+8KlJCzXudDXCI9w3a6U/8FEdLZWkej4=;
        b=t+yRLYgFAfpYbsBsNZOMWvUa+LWldRxgBE7fvUhpUuVzNEGpITBxg7Tlr5Zry9aMX8
         Y93d//8aL++EZLaQkezBtD2T19ybIJm2DvG3BTRVMiRrUnOjFtruZU1gO0LD6xr/22Az
         x2khOiJ1T1ffUU4ouAzRCY2FW8hbhe+My9hIxFz1DsEhPG/UZ2srIXqgtx0WM36Lmf+L
         nOG+zyUHRCZD1byF3R7yiLjLcuyHA/R7pMJyFgyIpeLTGvY/ZlMUYWcagKpnRS18c7XH
         hirgSXStTeYhe/ozeOr7L8BlOvPb4B4Q96A7QR+cZMeIugzz8o1TRjpdxBqA5v0iIGku
         GR8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=l3pN9WTLDzQ+8KlJCzXudDXCI9w3a6U/8FEdLZWkej4=;
        b=dLJjhVqZWObnRYZr88FoQ+DCO98mK5+NYzMoP/25/5uWxCOPHY9ZxBQq+PZquNxtoU
         1KQwBhy7Wx3CV018LRolAl+Ul74Bsse0QVaWYcAuHDQ16sK530eEjK+RDcbw+n3qIP8h
         fjEfJdnLcYGQeMCtT3mUxLpKHVaVLj01OvezvUfEqo99JdfQhRbackzKaBAytAqLtFbB
         UbCV621whLIsRWPmrVYQnvoQZ7EB1ltTJcKiiQTpgT/frOZVrUErqs3gcRNNqOtOTnqz
         /00Z5SkV9g3DXoqJOteUAXAvHCEH7rcQ1mFHkr6BBZ+579iIssIZbqBJCb6KnjyeJR5t
         Xmmg==
X-Gm-Message-State: ACgBeo3LmjSYKnFPrUF8ZiOW/Pzj1IWyH9fngNObYvy+1GTaQZAi5oi4
        w1h4VRvXGDbszvI84G/E/+FsQQ==
X-Google-Smtp-Source: AA6agR40O+tmrN/8P8ot5nar8rBJAIDfzuJMk9lDEruG3cNSKjK9L5xlXYjGdR/2prsmMv8+9Kj0sQ==
X-Received: by 2002:a05:600c:2909:b0:3a6:2ef5:772e with SMTP id i9-20020a05600c290900b003a62ef5772emr5414445wmd.16.1662044332316;
        Thu, 01 Sep 2022 07:58:52 -0700 (PDT)
Received: from localhost ([95.148.15.66])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c3b8500b003a319b67f64sm12398970wms.0.2022.09.01.07.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 07:58:51 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@bytedance.com>
To:     "Yuan, Perry" <Perry.Yuan@amd.com>
Cc:     Punit Agrawal <punit.agrawal@bytedance.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 4/7] cpufreq: amd_pstate: fix wrong lowest perf fetch
References: <20220814163548.326686-1-Perry.Yuan@amd.com>
        <20220814163548.326686-5-Perry.Yuan@amd.com> <87edxhim3j.fsf@stealth>
        <DM4PR12MB52786384C0BFEFF5E0A381079C789@DM4PR12MB5278.namprd12.prod.outlook.com>
Date:   Thu, 01 Sep 2022 15:58:50 +0100
In-Reply-To: <DM4PR12MB52786384C0BFEFF5E0A381079C789@DM4PR12MB5278.namprd12.prod.outlook.com>
        (Perry Yuan's message of "Wed, 31 Aug 2022 08:53:29 +0000")
Message-ID: <87pmgfcf9x.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Yuan, Perry" <Perry.Yuan@amd.com> writes:

[...]

>> Perry Yuan <Perry.Yuan@amd.com> writes:
>> 
>> > Fix the wrong lowest perf value reading which is used for new des_perf
>> > calculation by governor requested, the incorrect min_perf will get
>> > incorrect des_perf to be set , that will cause the system frequency
>> > changing unexpectedly.
>> >
>> > Reviewed-by: Huang Rui <ray.huang@amd.com>
>> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>> > Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
>> > Signed-off-by: Su Jinzhou <jinzhou.su@amd.com>
>> > ---
>> >  drivers/cpufreq/amd-pstate.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/cpufreq/amd-pstate.c
>> > b/drivers/cpufreq/amd-pstate.c index 5cdef6638681..183cdd4ba00e 100644
>> > --- a/drivers/cpufreq/amd-pstate.c
>> > +++ b/drivers/cpufreq/amd-pstate.c
>> > @@ -307,7 +307,7 @@ static int amd_pstate_target(struct cpufreq_policy
>> *policy,
>> >               return -ENODEV;
>> >
>> >       cap_perf = READ_ONCE(cpudata->highest_perf);
>> > -     min_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
>> > +     min_perf = READ_ONCE(cpudata->lowest_perf);
>> >       max_perf = cap_perf;
>> >
>> >       freqs.old = policy->cur;
>> 
>> This looks to be a pretty big change (lowest nonlinear vs lowest). Does the patch
>> need to be backported to older kernels?
>
> The patch fixes the min perf initial value, the correct min perf is lowest_perf which is captured through MSR_AMD_CPPC_CAP1 register or the cppc_get_perf_caps().
> Yes, the patch will need to be backported to other kernel branch as issue fix.

Great, thanks for confirming!

[...]

