Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F7D4E52AC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 13:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244122AbiCWM76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 08:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244092AbiCWM7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 08:59:43 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D34A13F7B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 05:58:13 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id x2so1444027plm.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 05:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=d7xbP64xjZhWxyyC9DGfTISrsVyNh9EM/3khYQoSQPQ=;
        b=fFzN+rwWRCKB+LB3MO0RWMXvqX5j03z9CzGfY/zREENLq7VAYPKjAgaTfX+/w/0Y+Y
         2cXNWHbzXIdQOHfZwloWhQxdd2H2/pthkIdFtZS8QWG6NSkVDl93FjeSAbHErZ1ACRjb
         PqUhHAMlqJFN84oEAGa+SWkWA4n0X27cei5gprv82iW7Iy+5AgXTcTfuwZh1FT0Iy4Vr
         TIwqjasUaAkCAALWXYwS/s+rrtBRocAZsv1nxB1airx7ST3SAHEOosQ9kiLGWnlErwul
         nJlEWXirwjKTxg+W7PUkFNsVId+eZKf2stLGM+GDWn51oHhhAXfmLK9zA0l3a1ndKs1w
         EudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=d7xbP64xjZhWxyyC9DGfTISrsVyNh9EM/3khYQoSQPQ=;
        b=jzmYPWCqcoLi18ZmOR91DjOHWPVgKa7KrsubWTm+FreKqdTbubRhskJtDOJKh37o7e
         6tway45JTrfbMTZxzVwHo2EfhJHvzK6UZzeNTNrb1mKIN6u/JvaKfRZIKztwDddN5xwb
         IBBZClRMPLrUQvB3cBQzaW34FNoKQydmGE/d2zZy1boK4FFzwJ6VyK+U77utHSlbx7We
         yHbDis1Gq9lG03idb2rtfhErXFbD9nLHTfbNDBSV7Q/3M65ppENQ/tv9lLzrvS/G2Cg5
         FIRJyDA+/pQZ0PSBf+Bq9bYYHObtpkY1mGTY9bXZj2YPP9OjbA4vfNL3PJuv8adcY56I
         gz3w==
X-Gm-Message-State: AOAM532IQmhaiMTteWwLLrU/ho7oPOEvu3DvFXP9ZO8KuXtWZI/hnYN/
        U0jL4CC0FU17xGakuVP1GT2bYw==
X-Google-Smtp-Source: ABdhPJzT0kM27TyYyXZjeJzcnD9KpjyNzMq6DUwpOBhbjlNHcsvxcGvaoTKV9AzjczD/Y/XP7RpN4g==
X-Received: by 2002:a17:902:ecd1:b0:154:5393:aa7e with SMTP id a17-20020a170902ecd100b001545393aa7emr16351618plh.79.1648040292894;
        Wed, 23 Mar 2022 05:58:12 -0700 (PDT)
Received: from ?IPV6:2409:8a28:e62:3990:1de6:b89c:5d2d:b2d6? ([2409:8a28:e62:3990:1de6:b89c:5d2d:b2d6])
        by smtp.gmail.com with ESMTPSA id q20-20020a056a00151400b004fa99ba6654sm13314782pfu.115.2022.03.23.05.58.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 05:58:12 -0700 (PDT)
Message-ID: <bd9f8db0-64d3-433b-502a-f83845f932fe@bytedance.com>
Date:   Wed, 23 Mar 2022 20:58:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [External] Re: [PATCH v2 2/6] perf/core: Introduce percpu
 perf_cgroup
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, eranian@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com
References: <20220322120834.98637-1-zhouchengming@bytedance.com>
 <20220322120834.98637-3-zhouchengming@bytedance.com>
 <YjnIpn/PCM6wKpOC@hirez.programming.kicks-ass.net>
 <0a7ebd49-cfdd-911e-3982-44f594320b0f@bytedance.com>
 <YjrWxnnIZvn3PWoX@hirez.programming.kicks-ass.net>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <YjrWxnnIZvn3PWoX@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/23 4:13 下午, Peter Zijlstra wrote:
> On Wed, Mar 23, 2022 at 12:33:51AM +0800, Chengming Zhou wrote:
>> On 2022/3/22 9:01 下午, Peter Zijlstra wrote:
>>> On Tue, Mar 22, 2022 at 08:08:30PM +0800, Chengming Zhou wrote:
>>>> Although we don't have incosistency problem any more, we can
>>>> have other problem like:
>>>>
>>>> CPU1					CPU2
>>>> (in context_switch)			(attach running task)
>>>> 					prev->cgroups = cgrp2
>>>> perf_cgroup_sched_switch(prev, next)
>>>> 	cgrp2 == cgrp2 is True
>>>>
>>>
>>> Again, I'm not following, how can you attach to a running task from
>>> another CPU ?
>>
>> Hi Peter, I make a little testcase which can reproduce the race
>> problem, on system with PSI disabled. Because when PSI enabled,
>> cgroup_move_task() will hold rq lock to assign task->cgroups.
> 
> No, the problem is that you're talking about cgroup attach while I'm
> thinking of attaching a event to a task. And your picture has nothing to
> clarify.
> 
> Those pictures of yours could really do with a few more function names
> in them, otherwise it's absolutely unclear what code is running where.

Sorry for the confusion ;-)
I will draw a better picture including more function names in the next version.

Thanks.
