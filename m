Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F13568446
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 11:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiGFJvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 05:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbiGFJvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 05:51:10 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF979237C5
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 02:51:09 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id s27so13580237pga.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 02:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=r1faCCbpwuJs+63ct9VRdewdZst2dG8crzL/4+J76wA=;
        b=ScEMHaRsijt3hSkxJi+SScwnSzfFtNtijtg4hYFEFOSjWvcvugBwq9J3hy5/jJw41O
         R1a6Gg7VXg8+KbWjKDjtknrm7r2Rd4e/251eF+XlRbvoiFuIMEyfaEfhk7bu25hHZVgg
         SrHnfI0ZfIsIlrlKPnb+fXQsGrU/vZ+CJKsnhG9VbdCwog1ZSXR326rVb/jFdTLveVQv
         u3C4/twG9vAt+MaZTFlUJlzDZhyRAadX1GQSwRv58ZmkXhVEjWrFM2UP3MnKr5MZ3c0J
         5ZDeosOFQDql3UvmDDiF5p0djCjmVkUKnncezVBeWRDeCYfoN0MSd/R8ADw5/I74nCWi
         wXlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=r1faCCbpwuJs+63ct9VRdewdZst2dG8crzL/4+J76wA=;
        b=S1Mi+fw2TgvZQ4zIXsF/WpravfMvORMhRld5l7VfA27m5UdtslE8aZjSEQn0jfc1N8
         VTxqSRgAehY/xkDOhV9gMPSRDMNq5m0g3JlI3r8MuN1E927GfMvSXfocm3SHjEGseWAW
         ZXsSGyeDjJGIbaEm4u4Js1h1aWC/jSpLyspZHAXiakrQhtTycejT13N+FyPHz5EGBvzT
         SmvHPC7LxMjPuhGFHlgQ6gdGbfeQFoMMEgVJ+Bzlw1HkFoYYgFOyVSa81Nad8NfvdbJA
         LIMLzV7ltiOvYn7lr5TmOfxXufczxjtE31NbSZvjIy12lTadV9YuDZV2E6MzO2wAJ8cQ
         gvRw==
X-Gm-Message-State: AJIora8CT7jAPp2Qdqs1m+6FviSizt3ew1ll7HMVbz0Q2xauY1+XYAs4
        cqs6WBq8tIoPkpwfPiGXRwqsYw==
X-Google-Smtp-Source: AGRyM1vlBGjG3PomDfm+yHSHvdBrg4Wi1oxEpywq8Yk8TM7elOdauLD++YSIPhMkFToiNvol649yfw==
X-Received: by 2002:a05:6a00:1819:b0:528:a43a:9ea8 with SMTP id y25-20020a056a00181900b00528a43a9ea8mr3172504pfa.70.1657101069274;
        Wed, 06 Jul 2022 02:51:09 -0700 (PDT)
Received: from [10.4.115.37] ([139.177.225.250])
        by smtp.gmail.com with ESMTPSA id 123-20020a621481000000b00527bb6fff6csm17254820pfu.119.2022.07.06.02.51.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 02:51:08 -0700 (PDT)
Message-ID: <f3c045a6-2ed9-c948-04c9-325649b1dfe0@bytedance.com>
Date:   Wed, 6 Jul 2022 17:51:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v4 0/7] sched/fair: improve scan efficiency of SIS
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org
References: <20220619120451.95251-1-wuyun.abel@bytedance.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20220619120451.95251-1-wuyun.abel@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle ping

On 6/19/22 8:04 PM, Abel Wu Wrote:
> The wakeup fastpath (select_idle_sibling or SIS) plays an important role
> in maximizing the usage of cpu resources and can greatly affect overall
> performance of the system.
> 
> The SIS tries to find an idle cpu inside that LLC to place the woken-up
> task. The cache hot cpus will be checked first, then other cpus of that
> LLC (domain scan) if the hot ones are not idle.
> 
> The domain scan works well under light workload by simply traversing
> the cpus of the LLC due to lots of idle cpus can be available. But this
> doesn’t scale well once the LLC gets bigger and the load increases, so
> SIS_PROP was born to limit the scan cost. For now SIS_PROP just limits
> the number of cpus to be scanned, but the way of how it scans is not
> changed.
> 
> This patchset introduces the SIS filter to help improving scan efficiency
> when scan depth is limited. The filter only contains the unoccupied cpus,
> and is updated during SMT level load balancing. It is expected that the
> more overloaded the system is, the less cpus will be scanned.
> 
> ...
> 
