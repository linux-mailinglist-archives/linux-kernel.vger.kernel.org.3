Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFADD4BC356
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 01:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240360AbiBSA2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 19:28:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240127AbiBSA2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 19:28:01 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C037B715D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 16:27:43 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id f13so5905499ilq.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 16:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JYKbon0sjmC8OdB1+pUCylkGlnV+3knb0QnDCySZnIw=;
        b=UyDeiKgG7MnwJIirmRh8gakUGCKk++DgSMZTiEg1ZLGKiNBJO+MtrMz1tBlDXU//AF
         cWHFPrIohCu/AOHoKZUR+Wm2PiTCit8e1W5/wmMe0Bvj3u7Wmpcu2NkGpMdqlEPLG/bu
         XPJvxbgaIxjAT6SW7sZpv87qAv4gNN/gYZDMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JYKbon0sjmC8OdB1+pUCylkGlnV+3knb0QnDCySZnIw=;
        b=ZQvU/LQgmB1OSj9MW+UmwXp1+XZG8nelDxXMvHHzQlIkeD2Um010MD61QwxkyLzVYz
         MwxuEuv84BESipUqoIJoapk6NePI5u6OcVCfLPa+RS2ZpaIpaD/mClA4wdvrUDB2EjYi
         eNrAwVDdyFRtTkyq5TwtB3Y45Px0Px7233Uva+5dN3jf513PWQXHPpr9CgL12KY7C7iq
         PCF+foQo5wtXv8Rncg+c/hrxJLuRf/I2MfRe3Da7fbAxbY5DmcfuWrPO0P7NNwy0FCR2
         IAQyIYnDPhk2f8Io2RzrfyvXgBqtPTQEH77lLOubVEE217aZcRPlqgHE5NJXC8Gbh2oI
         yDyQ==
X-Gm-Message-State: AOAM533KS9CJYWS9kFfeMwTs+Ao/A7omLEOIdEHIugACuoTadMxVvvzO
        c34q0tslP2k2Me3+2vZm08hiJw==
X-Google-Smtp-Source: ABdhPJy6ZAFBwwp1IZSsSBg89VsTeKSYTj8aPKKyHGlR/AMvlPzX0pNDp8Mern6FI6wjY9MdXr1drA==
X-Received: by 2002:a05:6e02:1be5:b0:2c1:efb6:9698 with SMTP id y5-20020a056e021be500b002c1efb69698mr393555ilv.131.1645230463021;
        Fri, 18 Feb 2022 16:27:43 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id h6sm3516174ilj.58.2022.02.18.16.27.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 16:27:42 -0800 (PST)
Subject: Re: [PATCH RESEND v6 0/9] cpupower: Add AMD P-State Support
To:     Huang Rui <ray.huang@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org
Cc:     Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Jassmine Meng <li.meng@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220216073558.751071-1-ray.huang@amd.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8aafb93a-772c-1806-e087-cd285694aa74@linuxfoundation.org>
Date:   Fri, 18 Feb 2022 17:27:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220216073558.751071-1-ray.huang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/16/22 12:35 AM, Huang Rui wrote:
> Hi Shuah,
> 
> Since AMD P-State kernel is merged into 5.17-rc1, I would like to continue
> revising the AMD P-State support for the CPUPower tool. These series are
> rebased on latest bleeding-edge, any comments are warm for me.
> 
> See patch series of CPUPower in below git repo:
> V1: https://git.kernel.org/pub/scm/linux/kernel/git/rui/linux.git/log/?h=amd-pstate-dev-v1
> V2: https://git.kernel.org/pub/scm/linux/kernel/git/rui/linux.git/log/?h=amd-pstate-dev-v2
> V3: https://git.kernel.org/pub/scm/linux/kernel/git/rui/linux.git/log/?h=amd-pstate-dev-v3
> V4: https://git.kernel.org/pub/scm/linux/kernel/git/rui/linux.git/log/?h=amd-pstate-dev-v4
> V5: https://git.kernel.org/pub/scm/linux/kernel/git/rui/linux.git/log/?h=amd-pstate-dev-v5
> V6: https://git.kernel.org/pub/scm/linux/kernel/git/rui/linux.git/log/?h=cpupower-amd-pstate
> 

A few checkpatch warns to fix. I usually ignore CHECK from checkpatch,
but a few of them found on this series could improve the code.

Also is there a need to add/update manpages and documentation.

I tested these my AMD Ryzen 7 4700G system. I didn't play with set commands
and just the info ones.

cpupower info gave me this output. The first message is fine, but the
second one is a bit odd. Should it just bail out right after the first
message about "not support"

cpupower info

System does not support Intel's performance bias setting
analyzing CPU 0:

Go ahead send me v7 for these and add any mapages/doc if necessary.
I will get them into Linux 5.18-rc1

thanks,
-- Shuah

