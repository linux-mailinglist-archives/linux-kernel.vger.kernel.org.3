Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D053F4C2167
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 02:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiBXByH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 20:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiBXByB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 20:54:01 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02EC1ADA0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 17:53:31 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id l25so961160oic.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 17:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uguiin8hqj3JoNBkgb0eMr70jISc6FMAupA0t7mvm1o=;
        b=IlOu7IMOqx73TO7dDuzfNPmAqJSZqLKO4OlP+mtkpMIbjaEDsvu3XcsE87Anyov+DP
         8uDUqpmoKnczLwJR2bfWpvpsV3o/SCjDh1R63xwkYiuxT5kMdw3RExyzVtN7vGtjqhsB
         qtA01Xm1njDxUn5Tk1J4lQpPUzFN5SV3g2tpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uguiin8hqj3JoNBkgb0eMr70jISc6FMAupA0t7mvm1o=;
        b=bQr/V3OHbMQJ09phCNg7Ro4WhLLfPhuWsru9cKYXhObjUHCLsO17LjPp27IluKAHXb
         hkzwdQefcw7xfYgYh95FrtIqKYOu8wcjx+U2vfdVy7s1QS7LuG0rd2tnq49Wlx7BFN1Z
         VOPu1R26ovEMfVZzHADjLb9tWFLI602XxLZPJNeXubbDW3snGzXV/bWTuSAod2D5vdTF
         UhoIkGA1vkQClKKZ6zb3bLcSALmYa4qhdoroGygTuFTOMeEc0n4O7y8RKFR+3w7k58/3
         M3sRYjsQdesb7y/nqaMMEX6EJBUHWETll4AH6RS1ygp79MzACdJwYzs+7QyAqFRshbNE
         d/7Q==
X-Gm-Message-State: AOAM531Qk8a3doh40q/2scOSI9Wp7MrMJNWyrMlFBfoKqORVdr0E3J1V
        7piv6g2eES3BEHvCQEfHfWGhWMKcTvYeVw==
X-Google-Smtp-Source: ABdhPJyvnyS3vf4avP768zNV+lGSkU5aQSVUwCfNTPsgPVcLSbs1p2u52XorksQxgu/bzRJqFwqUHA==
X-Received: by 2002:aca:643:0:b0:2d3:fce2:d82e with SMTP id 64-20020aca0643000000b002d3fce2d82emr5869068oig.209.1645664124020;
        Wed, 23 Feb 2022 16:55:24 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id em32sm716001oab.28.2022.02.23.16.55.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 16:55:23 -0800 (PST)
Subject: Re: [PATCH v7 10/10] cpupower: Add "perf" option to print AMD P-State
 information
To:     Huang Rui <ray.huang@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc:     "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220222153426.2216974-1-ray.huang@amd.com>
 <20220222153426.2216974-11-ray.huang@amd.com> <YhWsBivPabbGoWr0@amd.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <9308042e-d820-551e-0f6f-b3f26a8a9bc8@linuxfoundation.org>
Date:   Wed, 23 Feb 2022 17:55:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YhWsBivPabbGoWr0@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/22 8:37 PM, Huang Rui wrote:
> On Tue, Feb 22, 2022 at 11:34:26PM +0800, Huang, Ray wrote:
>> Add "-r --perf" option in cpupower-frequency-info to get the performance
> 
> Thanks Shuah! There is one typo ("-r --perf" --> "-c --perf") here. Because
> "r" is occupied by option character. Would you mind to correct it in the
> commit log?
> 

Done. Commit amended in
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git
cpupower branch for Linux 5.18-rc1

thanks,
-- Shuah
