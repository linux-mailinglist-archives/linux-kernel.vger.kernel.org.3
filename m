Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8941D586BED
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 15:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbiHAN0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 09:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbiHAN0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 09:26:45 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB503C8C0
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 06:26:43 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id e15so13711351edj.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 06:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eFCO67CpyQ/ZoV+dmJNx2L2eUcdu4y5M0dyI0OTIEDY=;
        b=UhDkpJjAC4BCDAq74QHc1BiI0XDgJ17/KMUeveF/ZZz7SRmKlNeg9vtLTLyujrkxKH
         GF6db9PuaIHeAR5MAakqw2dFIWs/OZO2UFxrRIsCRk1WS4uSMdPRzRLEMBPx9iExAgXa
         j2Ceb8VcmmtpZoV+L0kx2Dbo/UoERRcbzbBO/SmDBCj+3/5derJ/XadOtSkmgSWQn7sO
         DcExW7Slr50teMWJ2GApCuBr/nlYv8WNXGGOCrcFUZPnou3M5kU0Fn0qGdfB8wCEx/7m
         znl84YUATJbUP1xupKhhpvf0lOXThBVdnxxphAr1HI5XWvIU3PFb6Km36c3dTD82tYtc
         3TZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=eFCO67CpyQ/ZoV+dmJNx2L2eUcdu4y5M0dyI0OTIEDY=;
        b=zzXfpF4NJerRqUxUn6riMKwTpi2KVRmMvlbhSrsrOP86LxX7/cxsrBCzHQ/3b3cFdj
         gwB0zPfz/57e7uxRlGK9ForhnFLQFcMiN0HIGITY2cXsX23ioi16i96fpPPqdFi/Uhls
         Zj7lDVbsJRIVXhNGxWC0zESBFrB8UCdcxQBOzQKqI60cWO8uqpvtOXm+O+qD+AmHKYT/
         qEw8c6/t8Umk5jxs9nknvhWQGSZ0yDdLtr+BIRk1OlHtYQOpSa9iI+WDteVBMPp9FTeC
         UOj/FxCDYu6vKJuoAdtEdriDYvu73FEeHKPZKE7edxRzF6UN4sH4ClVd+rK7Q7jR5klW
         KJow==
X-Gm-Message-State: AJIora/XHzFaLCvreWJZsRWmkAbwk+POC1/xy3VnVT/7jLjG81zMoIWz
        ZVmj42DaN90zgKof5TaednY=
X-Google-Smtp-Source: AGRyM1t6dzKgKfq+Y2k9dzSbNjAPihFk4OlSQkX0WKngVL/mVAo4Ix7juuIjJKrGYTjbfqtzwwxFeg==
X-Received: by 2002:aa7:dc12:0:b0:43b:5d77:f0b with SMTP id b18-20020aa7dc12000000b0043b5d770f0bmr16015672edu.37.1659360402178;
        Mon, 01 Aug 2022 06:26:42 -0700 (PDT)
Received: from gmail.com (84-236-113-167.pool.digikabel.hu. [84.236.113.167])
        by smtp.gmail.com with ESMTPSA id o17-20020a170906769100b007308bdef04bsm970959ejm.103.2022.08.01.06.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 06:26:41 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 1 Aug 2022 15:26:39 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     Libo Chen <libo.chen@oracle.com>, peterz@infradead.org,
        vincent.guittot@linaro.org, mgorman@suse.de,
        tim.c.chen@linux.intel.com, 21cnbao@gmail.com,
        dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: [PATCH] sched/fair: no sync wakeup from interrupt context
Message-ID: <YufUj4klPKmKNj26@gmail.com>
References: <20220711224704.1672831-1-libo.chen@oracle.com>
 <c50bdbfe-02ce-c1bc-c761-c95f8e216ca0@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c50bdbfe-02ce-c1bc-c761-c95f8e216ca0@amd.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* K Prateek Nayak <kprateek.nayak@amd.com> wrote:

> Hello Libo and Peter,
> 
> tl;dr
> 
> - We observed a major regression with tbench when testing the latest tip
>   sched/core at:
>   commit 14b3f2d9ee8d "sched/fair: Disallow sync wakeup from interrupt context"
>   Reason for the regression are the fewer affine wakeups that leaves the
>   client farther away from the data it needs to consume next primed in the
>   waker's LLC.
>   Such regressions can be expected from tasks that use sockets to communicate
>   significant amount of data especially on system with multiple LLCs.
> 
> - Other benchmarks have a comparable behavior to the tip at previous commit
>   commit : 91caa5ae2424 "sched/core: Fix the bug that task won't enqueue
>   into core tree when update cookie"
> 
> I'll leave more details below.

Mel Gorman also warned about this negative side-effect in:

   Subject: Re: [PATCH] sched/fair: no sync wakeup from interrupt context
   Date: Fri, 15 Jul 2022 11:07:38 +0100
   Message-ID: <20220715100738.GD3493@suse.de>

   https://lore.kernel.org/all/20220715100738.GD3493@suse.de/

I've reverted this commit (14b3f2d9ee8df3b) for the time being from 
tip:sched/core.

Thanks for the heads-up!

Thanks,

	Ingo
