Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B572502C18
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 16:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354656AbiDOOqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 10:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349655AbiDOOqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 10:46:00 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DC3A6E34
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 07:43:32 -0700 (PDT)
Received: from [192.168.88.87] (unknown [36.80.217.41])
        by gnuweeb.org (Postfix) with ESMTPSA id 561D17E39E;
        Fri, 15 Apr 2022 14:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1650033811;
        bh=JVo0hjyg1hSKX87XfbS3BPrkSnnFNAJbNMwabt4e32c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AcrCB7JNhXYp/CnkBXkBWxY1+dEzyO6LSipAEl47LtHKAa5MJBHNdvLW/dHjFRx6a
         KMDEoS94WwkbqrwTtD/5tqzMf4uKss1Fr93cq8l9mg9opUwyVCdLPoczYTIdwc1QPc
         452lFjQ1Qx3wavC5QKmWXvRYR2XXhLVkILRJdaITwJD/dyrJmthygFmK0Nq1OZMAcB
         yvULNjMKmaEeQNpfmUw8j+vOzaCwaG0OX8Ie9UEvgPS8ohAEeMedzvXin7MVW92lKT
         C+RzUgJ5nOo3WofuuBD9NyZYT2fHJ1ywj61S8AFjQGGy5wMOK+vHG1NKtntugrJmRF
         aCEC0rRC5EofA==
Message-ID: <b6136c05-5ce8-c475-989c-083933226bca@gnuweeb.org>
Date:   Fri, 15 Apr 2022 21:43:13 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Linux 5.18-rc1] WARNING: CPU: 1 PID: 0 at
 kernel/sched/fair.c:3355 update_blocked_averages
Content-Language: en-US
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <b86541ea-7d96-5a24-1b65-37c24c70d3ff@gnuweeb.org>
 <f71d132d-02a0-918c-ab2b-3234d0d492a4@arm.com>
 <675544de-3369-e26e-65ba-3b28fff5c126@gnuweeb.org>
 <000457c2-57af-95e3-7dff-2cbd99f0de5f@arm.com>
 <7f4b3fbf-c7c6-22cb-019b-520ad6a663aa@gnuweeb.org>
 <786190b3-b2cb-464d-9808-325d774c62a5@arm.com>
 <e1f9421d-e9dd-589c-bf88-407533e40797@gnuweeb.org>
 <457e1f88-4eb0-53c4-a750-c8930c803272@arm.com>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
In-Reply-To: <457e1f88-4eb0-53c4-a750-c8930c803272@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/22 4:38 PM, Dietmar Eggemann wrote:
> Looks like you saw the same issue which got fixed here:
> 
> https://lkml.kernel.org/r/20220414015940.9537-1-kuyo.chang@mediatek.com
> 
> So nothing to do with CFS BW control. It's triggered by a task with very
> low nice value and load_avg=1 during cfs_rq attach.

Yeah, it looks like I hit the same SCHED_WARN_ON() with what is explained
in that patch. As such, I assume it's fixed then. I didn't manage to
reproduce the bug, but I am moving on from this now.

Thanks for the update!

-- 
Ammar Faizi
