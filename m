Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920DF5AFFED
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 11:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiIGJJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 05:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiIGJI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 05:08:59 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9177080B7C
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 02:08:58 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id c198so4113409pfc.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 02:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=fZi8xk14qdvCnSe+bTllJkC7m9kpYQekS0msFxL7vdg=;
        b=BH1nALltpxTGGFeLZp+r/vzweyPc9OO4yC0Wxjd8S7Cg3fulsF9jsabX1zximOvd9F
         QYRrDJeyiqhlzXyfYOyYi3hEiLENCYAd8ZXkuO4oXNi/3gv3XnPVDH4+UkPfqMz4SiLb
         t9ZJM0VMQkZG0tapsBCIucXRHQ4C1pFTxWfybP1ZgX4HX8hVwASwSUmwn9JfpkllrYhj
         g7F8fNdwCPTOlvPHaJ/4D64dQPrxKteaT/X3HfULi2N9Odv4WfGcmBDouzBCA7n5iyAV
         pzJjZ0Ej0DBXofzUZ1FQMAvses1sK8W7BriDEBH4DUd4fBzy5dwziok97Q/kmkFwxJHH
         VfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=fZi8xk14qdvCnSe+bTllJkC7m9kpYQekS0msFxL7vdg=;
        b=0a1UDp4pJLM2WuPG7dAl5VNnOmJ8cdXZSNS9x2HiAA4qy4CgVlk4ebqUS0F3vuR5kc
         5XZAVEhgYPEhXOFxJlhr7sZad2ZzQBqSwASul2XZf8BKXKj5iGw3dhHY0ZOdTdergeFS
         XD/GF4fFoRgSo3ETeQXOwlQY31yTmR3iQx+jN8aa6595o43altixH8YgIe8UIxNRW/jo
         zd2XOfEUlJfax7SsI9M/QOWa0rbxVRdI0J36JmI/YyZZ3WQ4YKPpdJJOxwJ8ais1XZdt
         134aNrbiNcAOxZ56HIYq5BRZQ1pnXecg6BLn9pa4hQMWc5cm/+DSx7W5JsGgVY6euZTO
         EUzA==
X-Gm-Message-State: ACgBeo11GhvDMN8dM8iWLNVXImftMZbz/pVf1dFSWgqs/BSyeI8H97/N
        Eg5f4vojr7+5tXKUjJtDpQZO4A==
X-Google-Smtp-Source: AA6agR48HQ44pjDDTNd0mPqY+oHEdnlv2N+SNZGQu84o7oOwXpRKT2oKY1rMK32QzGw2H/P3hAblPA==
X-Received: by 2002:a63:84c6:0:b0:42b:e461:348a with SMTP id k189-20020a6384c6000000b0042be461348amr2590176pgd.87.1662541738109;
        Wed, 07 Sep 2022 02:08:58 -0700 (PDT)
Received: from [10.254.68.181] ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id p8-20020a1709027ec800b001768db880c4sm8918952plb.275.2022.09.07.02.08.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 02:08:57 -0700 (PDT)
Message-ID: <a0298563-bc74-65db-275e-94bd461e5bcd@bytedance.com>
Date:   Wed, 7 Sep 2022 17:08:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.1
Subject: Re: [peterz-queue:sched/psi 11/11]
 include/linux/cgroup-defs.h:432:38: error: 'NR_PSI_RESOURCES' undeclared here
 (not in a function)
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kernel test robot <lkp@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
References: <202209070242.7EuRnstk-lkp@intel.com>
 <e95c6e55-a023-b6f7-1dce-4195dc22114a@bytedance.com>
 <YxhQ7U0HggaWTmEm@hirez.programming.kicks-ass.net>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <YxhQ7U0HggaWTmEm@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/7 16:06, Peter Zijlstra wrote:
> On Wed, Sep 07, 2022 at 10:45:55AM +0800, Chengming Zhou wrote:
>> On 2022/9/7 02:33, kernel test robot wrote:
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/psi
>>> head:   51beb408c569e516780c84a2020920432ad4c5ed
>>> commit: 51beb408c569e516780c84a2020920432ad4c5ed [11/11] sched/psi: Per-cgroup PSI accounting disable/re-enable interface
>>> config: i386-randconfig-a001
>>> compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
>>> reproduce (this is a W=1 build):
>>>         # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=51beb408c569e516780c84a2020920432ad4c5ed
>>>         git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
>>>         git fetch --no-tags peterz-queue sched/psi
>>>         git checkout 51beb408c569e516780c84a2020920432ad4c5ed
>>>         # save the config file
>>>         mkdir build_dir && cp config build_dir/.config
>>>         make W=1 O=build_dir ARCH=i386 prepare
>>>
>>> If you fix the issue, kindly add following tag where applicable
>>> Reported-by: kernel test robot <lkp@intel.com>
>>>
>>> All errors (new ones prefixed by >>):
>>>
>>>    In file included from include/linux/cgroup.h:28,
>>>                     from include/linux/memcontrol.h:13,
>>>                     from include/linux/swap.h:9,
>>>                     from include/linux/suspend.h:5,
>>>                     from arch/x86/kernel/asm-offsets.c:13:
>>>>> include/linux/cgroup-defs.h:432:38: error: 'NR_PSI_RESOURCES' undeclared here (not in a function)
>>>      432 |         struct cgroup_file psi_files[NR_PSI_RESOURCES];
>>
>> Sorry, looks like there are two problems here:
>>
>> 1. NR_PSI_RESOURCES is undeclared when !CONFIG_PSI
>>
>>    Should I send the below diff as a separate patch?
> 
> Please reply to the original patch with an updated version and I'll
> replace it.

Ok, I just sent. Thanks!

