Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B966501DAF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 23:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237142AbiDNVu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 17:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbiDNVu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 17:50:56 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BD995485
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 14:48:29 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id mm4-20020a17090b358400b001cb93d8b137so10423474pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 14:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:date:message-id:mime-version;
        bh=waPudPlVhHtHMA9moxAZ6Byzf/Q9LiHGndFwnvJTw84=;
        b=sq26syXLy4lhHszxXm4VE59PlRWIiN0fJq/WC5AsgDkzVY+FMzC6W8M4G+c9XhxJ7M
         RPa8qQV3RjWQEkANg49pLuYOPJbqHWpDom/qBhXcNiTU2x/EUP7vMzD8EaTfWnWQopXg
         6RzI1HzBPjwsvZa5bVcRJlJkLO3FFHQYq5GbP/A+l8WjhxU64qfiE5ATq+qhBzIoJa+p
         5piiW3jrqQXYxkj6b2iWx54liMxXtnSnkXoh5h0JG+ag9jvbyNIOEYFHQ2xS5N2VzCEQ
         m0x0W90S9aYJ86OUJVnVBt19ASYxD+EqdjdzGQfCt2UusLeecEGN9+WyVUK2leOCsIpM
         wlJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:date:message-id
         :mime-version;
        bh=waPudPlVhHtHMA9moxAZ6Byzf/Q9LiHGndFwnvJTw84=;
        b=wiW7YXnsC1UcV+jntpjp2WJQ/rivM8ehiNZ1oGYJmmVv/h5diyKMVeImqgxg24TjxM
         x56E07OTmSqmLUmUXIkBqSGcya7pQflaE332ct8OPG4OjkhW6rqX1HoW+22Gojh/p7z+
         81YSLxK+H3fMez7FqIdYDE7jctfmKi2C6eOtubYoGcD9ujc74aGiPLJIQrwC633AOufH
         PmvB8A53I/S05wymVnBKcsMthVErYGhxmuwg0PXcn80WpHRSr/7ESSsciavLIzoRByLz
         nOMx/OifX/SJiLfHbwnXjQBBTrImc+c60L57aqGaApoaohySW/9lQedN49SSx+fnJdM/
         sI2g==
X-Gm-Message-State: AOAM533BX5Tv17jRn7vKyyyNtrGYSZ0DSdT6BSxG6Tl0Kj23o/0fa6M7
        fVvlmK0tjOoT4tbMLu6A6WnAsg==
X-Google-Smtp-Source: ABdhPJzrSS547mp4Ducl8jVLogQ25Z5tF6TpXhzlX/3f9wSauuf4/iNhSVnZHTPi6dTUidziqtR1IA==
X-Received: by 2002:a17:90b:4c45:b0:1cd:4fa3:6ee4 with SMTP id np5-20020a17090b4c4500b001cd4fa36ee4mr663031pjb.96.1649972908766;
        Thu, 14 Apr 2022 14:48:28 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id k4-20020a17090a3e8400b001cd37f6c0b7sm2717486pjc.46.2022.04.14.14.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 14:48:28 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org
Cc:     matthias.bgg@gmail.com, jia-wei.chang@mediatek.com,
        roger.lu@mediatek.com, hsinyi@google.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH V2 13/15] cpufreq: mediatek: Link CCI device to CPU
In-Reply-To: <12c630946ce9d7b8c80143615496238759323981.camel@mediatek.com>
Date:   Thu, 14 Apr 2022 14:48:27 -0700
Message-ID: <7hbkx3fiac.fsf@baylibre.com>
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

Rex-BC Chen <rex-bc.chen@mediatek.com> writes:

> On Wed, 2022-04-13 at 14:41 -0700, Kevin Hilman wrote:
>> Rex-BC Chen <rex-bc.chen@mediatek.com> writes:
>> 
>> [...]
>> 
>> > From the Chanwoo's devfreq passive govonor series, it's impossible
>> > to
>> > let cci devreq probed done before cpufreq because the passive
>> > govonor
>> > will search for cpufreq node and use it.
>> > 
>> > Ref: function: cpufreq_passive_register_notifier()
>> > 
>> > 
> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/commit/?h=devfreq-testing&id=b670978ddc43eb0c60735c3af6e4a370603ab673__;!!CTRNKA9wMg0ARbw!z58Lc1p9REo88oHn-NkxroN_fBd0TsHYmhscNZwnWwT71ecRkTeqZ6vFl5l7HpkTdM6t$
>> >  
>> 
>> Well this is a problem, because CCI depends on CPUfreq, but CPUfreq
>> depends on CCI, so one of them has to load and then wait for the
>> other.
>> 
>> > After I discuss with Angelo and Jia-wei, we think we are keeping
>> > the
>> > function in target_index and if the cci is not ready we will use
>> > the
>> > voltage which is set by bootloader to prevent high freqeuncy low
>> > voltage crash. And then we can keep seting the target frequency.
>> > 
>> 
>>  > We assume the setting of bootloader is correct and we can do this.
>> 
>> I'm still not crazy about this because you're lying to the CPUfreq
>> framework.  It's requesting one OPP, but you're not setting that,
>> you're
>> just keeping the bootloader frequency.
>> 
>> In my earlier reply, I gave two other options for handling this.
>> 
>> 1) set a (temporary) constraint on the voltage regulator so that it
>> cannot change.
>> 
>> or more clean, IMO:
>> 
>> 2) set a CPUfreq policy that restricts available OPPs to ones that
>> will
>> not break CCI.
>> 
>> Either of these solutions allow you to load the CPUfreq driver early,
>> and then wait for the CCI driver to be ready before removing the
>> restrictions.
>
> Hello Kevin,
>
> I think I do not describe this clearly.
> The proposal is:
>
> In cpufreq probe:
> we record the voltage value which is set by bootloader.
>
> In mtk_cpufreq_set_target():
> We do NOT directly return 0.
> Instead, we will find the voltage of target cpufreq and use the value
> max(booting voltage, target cpufreq voltage)
>
> mtk_cpufreq_set_target() {
> 	/* NOT return 0 if !is_ccifreq_ready */
> 	....
> 	vproc = get voltage of target cpufreq from opp.
>
> 	if (ccifreq_supported && !is_ccifreq_ready)
> 		vproc = max(vproc, vproc_on_boot)
>
> 	//setting voltage and target frequency
> 	....
> }

You explained this well, but it's still not an appropriate solution IMO,
because you're still not setting the target that is requested by the
CPUfreq core.

The job of ->set_target() is to set the frequency *requested by CPUfreq
core*.  If you cannot do that, you should return failure.  What you posted
in the original patch and what you're proposing here is to ignore the
frequency passed to ->set_target() and do something else.  In the
orignal patch, you propose do to nothing.  Now, you're ignoring the 
target passed in and setting something else.  In both cases, the CPUfreq
core things you have successfuly set the frequency requested, but you
have not.  This means there's a mismatch between what the CPUfreq core &
governer things the frequency is and what is actually set.  *This* is
the part that I think is wrong.

Instead, the proper way of restricting available frequencies is to use
governors or policies.  This ensures that the core & governors are
aligned with what the platform driver actually does.

As I proposed earlier, I think a clean solution to this problem is to
create a temporary policy at probe time that restricts the available
OPPs based on what the current CCI freq/voltage are.  Once CCI driver is
loaded and working, this policy can be removed.

Kevin


