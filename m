Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E619958EEEE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 17:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbiHJPEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 11:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiHJPEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 11:04:52 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82D6760CA
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 08:04:50 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id b24so4897573qka.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 08:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=vJD+sienGxL+pDFjZnaL1Ryzy+jjnXLpZikfuPHWtKI=;
        b=kYv3B/76NFsCpT0gcCAFbksvtwpcKr2nmB2X8YFBm3Xrgh0LNs2hnbFT0sSpJPaJwR
         teWRA0C24llbBVP9doAx723cbojq/0sU6AH1Fao0/ZBhTK0L8l649AjNfmHUoXt8r7u/
         s/uJmaDEV/x+q0wGmaVX7X6FJ46LDgxwYoW22hlqDa3oyaq9QQxIFjS2p7CPVGZefWJ+
         /zQ7BoZMuGRuq8+czc0LWKXVMc0rVJJSw0RSMndh5b/hJJdQXvLTP+gErzYAWxnNqN2a
         s3K7YEJKHVJcwu5tNuU6lOplgmPQeRjGRPQ3pn6DrgkirqpOTXQqAf2BUD7/Kd5vyE98
         W5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=vJD+sienGxL+pDFjZnaL1Ryzy+jjnXLpZikfuPHWtKI=;
        b=CAKxbLmoL53jdbqw31r/ieR8DwlcDQfT3eQ8QEuwQSIc2Ml34oMkvRDsQTUJbxkTFV
         H0pdLIwDGdOET5tuXz8t7ixXo+bvnlXfcp0eLakn+mwFmPmSB5cZ2CV2Vo8BJotNT1Hv
         K6MW1Fv0AY4Wm2jrwplH+sA8hreUa2tZ5+od9Hp/RVUiiDESAfoI8/yaSBK7lpYAOMTF
         FskkddgL86d5DiPLUot62lLvZ3UjV/RXil4u5j+cDELO1YuyTXgWWebdC2mRvK3nQJ0i
         Cw5AAiEPnygjaLOgfKId58Q4rkCJ4WUFNpqZY8b2cd6BPqStDgcDxhSZDD67LbJpNVLQ
         5/nA==
X-Gm-Message-State: ACgBeo09rLRm+d4+kKIwFExCPzM6/Om+Zvj6QZ7P4AlwIzSeIyHaK4l4
        MCFn4Fb7BHGUik7Hoc1FfXhA3w==
X-Google-Smtp-Source: AA6agR7DNklCEh0iBdY/fpZAHrGjrxm+1CHt/v25PX9ro0B10Rl+I+06M8qNHz1xtfB56VJMWYWG/A==
X-Received: by 2002:a05:620a:27cf:b0:6b5:473d:44eb with SMTP id i15-20020a05620a27cf00b006b5473d44ebmr20845572qkp.282.1660143890099;
        Wed, 10 Aug 2022 08:04:50 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-00ea-7f88-5fd9-01cd.res6.spectrum.com. [2603:7000:c01:2716:ea:7f88:5fd9:1cd])
        by smtp.gmail.com with ESMTPSA id y8-20020ac87088000000b00342fdc4004fsm4951149qto.52.2022.08.10.08.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 08:04:49 -0700 (PDT)
Date:   Wed, 10 Aug 2022 11:04:48 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Hao Jia <jiahao.os@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] sched/psi: Zero the memory of struct psi_group
Message-ID: <YvPJEDHfOmX90UOz@cmpxchg.org>
References: <20220806120510.96131-1-jiahao.os@bytedance.com>
 <20220806120510.96131-2-jiahao.os@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220806120510.96131-2-jiahao.os@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 06, 2022 at 08:05:08PM +0800, Hao Jia wrote:
> After commit 5f69a6577bc3 ("psi: dont alloc memory for psi by default"),
> the memory used by struct psi_group is no longer allocated and zeroed
> in cgroup_create().
>
> Since the memory of struct psi_group is not zeroed, the data in this
> memory is random, which will lead to inaccurate psi statistics when
> creating a new cgroup.
> 
> So we use kzlloc() to allocate and zero the struct psi_group and
> remove the redundant zeroing in group_init().
> 
> Steps to reproduce:
> 1. Use cgroup v2 and enable CONFIG_PSI
> 2. Create a new cgroup, and query psi statistics
> mkdir /sys/fs/cgroup/test
> cat /sys/fs/cgroup/test/cpu.pressure
> some avg10=0.00 avg60=0.00 avg300=47927752200.00 total=12884901
> full avg10=561815124.00 avg60=125835394188.00 avg300=1077090462000.00 total=10273561772
> 
> cat /sys/fs/cgroup/test/io.pressure
> some avg10=1040093132823.95 avg60=1203770351379.21 avg300=3862252669559.46 total=4294967296
> full avg10=921884564601.39 avg60=0.00 avg300=1984507298.35 total=442381631
> 
> cat /sys/fs/cgroup/test/memory.pressure
> some avg10=232476085778.11 avg60=0.00 avg300=0.00 total=0
> full avg10=0.00 avg60=0.00 avg300=2585658472280.57 total=12884901
> 
> Fixes: commit 5f69a6577bc3 ("psi: dont alloc memory for psi by default")
> 
> Signed-off-by: Hao Jia <jiahao.os@bytedance.com>

Yikes! Yes, we relied on the embedding cgroup being kzalloc'd, or, in
the case of psi_system, on the psi_group being in NULLed static mem.
The partial zeroing in group_init() obscured that. Thanks for the fix.

Cc: stable@vger.kernel.org # 5.19
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
