Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD967588934
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 11:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235597AbiHCJSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 05:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234284AbiHCJSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 05:18:32 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DC620BE3
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 02:18:31 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso614608wma.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 02:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Tu5Rjm9YUzMsrXkU1Im8ttCQvcJ0mxBS+97HvYdI1IY=;
        b=CWdr8BzjJ8oNBhmDZEORgFQdquBb/74+bsnrjpu1gRiw23jk2rQgA/WB7PEx5bFoCt
         E+cfmGCV8Exs1H8xp8B86VYqjpFUZxegdDY8WPBtzJVBhDnvfufbzhSmYotc1AAAzsIj
         mJwjYhZ0CbyC4UBromVSAEyV9e+W8vkE75xSJmKRxfiyN3syrxoAgRS7adI32ORGC4Uk
         7qQmU6gE/ZX736L8WTq/GRBZ0s6arTC/a3cWYPlOvVR8t/gT4gtbMx1gUr7qSrEDusAU
         Dfw+MUyHD2VIgoFtu6hpAON1N1R+s1VPAg6JInp/LyjLloHhIzQYXa2YdcGWV/yMxcaw
         HOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Tu5Rjm9YUzMsrXkU1Im8ttCQvcJ0mxBS+97HvYdI1IY=;
        b=rhlIiz1kVUXBAcOxiT5P2Ry9PLewvr8wzlgE96rW7DvpPBoSQCqQpPOZ6abndHSRmQ
         zTJr3Dj8YTnQQAiTpalcmgP52CHSnek40aLtKnuHU7E0ZMe0HyqYtWE/cy7k7rBJ31OD
         hpjwAf1hEse8mCnfAodt2uJdwynATz6pWYjg3tHm+LCqdn0aU6hMmLiiux+8NwksE//z
         0ar3dtpPTjciJ2Xf8TKv2bT47iUNJnAMoZ5veBnY3W59H4/R/04V11Xad8PIk03Tbah5
         bxbjEgyggAYxcVWx/rJQuX6+WF3ACmCai+ivmfOolv/cenCL7gOe9wHoA1gKW/SSr6/R
         J+oA==
X-Gm-Message-State: ACgBeo30I2phizaPD+vsh9GIeoIQIK76g2s2ynWJ5Gn9so0KizOszn7x
        OL4Enhp7CsJpKmj/9quNm9Y=
X-Google-Smtp-Source: AA6agR5ZlPT6ihCvz7ujYfQaDW1jUgVtZKcW/aZYDJbmWgDyz0CDB6X0DQixVoWY4cohdgdJ8fXB/A==
X-Received: by 2002:a05:600c:3549:b0:3a3:16af:d280 with SMTP id i9-20020a05600c354900b003a316afd280mr2058269wmq.142.1659518310241;
        Wed, 03 Aug 2022 02:18:30 -0700 (PDT)
Received: from gmail.com (84-236-113-167.pool.digikabel.hu. [84.236.113.167])
        by smtp.gmail.com with ESMTPSA id g9-20020a7bc4c9000000b003a2fde6ef62sm1732144wmk.7.2022.08.03.02.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 02:18:29 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 3 Aug 2022 11:18:27 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Libo Chen <libo.chen@oracle.com>
Cc:     K Prateek Nayak <kprateek.nayak@amd.com>, peterz@infradead.org,
        vincent.guittot@linaro.org, mgorman@suse.de,
        tim.c.chen@linux.intel.com, 21cnbao@gmail.com,
        dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: [PATCH] sched/fair: no sync wakeup from interrupt context
Message-ID: <Yuo9Y4KvQQvvLC/r@gmail.com>
References: <20220711224704.1672831-1-libo.chen@oracle.com>
 <c50bdbfe-02ce-c1bc-c761-c95f8e216ca0@amd.com>
 <YufUj4klPKmKNj26@gmail.com>
 <82620137-5aa5-6cf1-f7aa-6a298e2f7856@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82620137-5aa5-6cf1-f7aa-6a298e2f7856@oracle.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Libo Chen <libo.chen@oracle.com> wrote:

> 
> 
> On 8/1/22 06:26, Ingo Molnar wrote:
> > * K Prateek Nayak <kprateek.nayak@amd.com> wrote:
> > 
> > > Hello Libo and Peter,
> > > 
> > > tl;dr
> > > 
> > > - We observed a major regression with tbench when testing the latest tip
> > >    sched/core at:
> > >    commit 14b3f2d9ee8d "sched/fair: Disallow sync wakeup from interrupt context"
> > >    Reason for the regression are the fewer affine wakeups that leaves the
> > >    client farther away from the data it needs to consume next primed in the
> > >    waker's LLC.
> > >    Such regressions can be expected from tasks that use sockets to communicate
> > >    significant amount of data especially on system with multiple LLCs.
> > > 
> > > - Other benchmarks have a comparable behavior to the tip at previous commit
> > >    commit : 91caa5ae2424 "sched/core: Fix the bug that task won't enqueue
> > >    into core tree when update cookie"
> > > 
> > > I'll leave more details below.
> > Mel Gorman also warned about this negative side-effect in:
> > 
> >     Subject: Re: [PATCH] sched/fair: no sync wakeup from interrupt context
> >     Date: Fri, 15 Jul 2022 11:07:38 +0100
> >     Message-ID: <20220715100738.GD3493@suse.de>
> > 
> >     https://urldefense.com/v3/__https://lore.kernel.org/all/20220715100738.GD3493@suse.de/__;!!ACWV5N9M2RV99hQ!PQsIeuK0UwII-A0xS-B3plepNniNeyw14OJowT1cYL-tnuN99MkWfg9C8P60tVFFrnxj0NEanUmEkA$
> ?? Mel was talking about a completely different thing, I brought up a
> different patch that I wanted to revert and Mel thought it would hurt other
> workloads which don't benefit from pulling but
> as you can see, tbench somehow benefits from it, at least according to one
> metric from one workload.

Yeah - but nevertheless the discussion with Mel was open-ended AFAICS, and 
the 'major tbench regression' report by K Prateek Nayak above still stands 
and needs to be investigated/understood, right?

Thanks,

	Ingo
