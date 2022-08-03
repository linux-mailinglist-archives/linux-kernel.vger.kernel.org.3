Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DF058891C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 11:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235876AbiHCJK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 05:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235533AbiHCJKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 05:10:25 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6ABA9FF8
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 02:10:21 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id z17so16072643wrq.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 02:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Din84Xua8YUTz3YvbosqFh2HrAdrjgEomUIfjR4Kxig=;
        b=Vogr/xspLodM4nmDajE9Q4R8OgkcJlob508gHX1caSAx6vFJaR+3LZAS9JLKl5Ubdl
         e2Q+NyJe5Ifz8IAdkuKGuH090iYMeUW6LZtHBbEmnpKzk5t0gH2720G7nfj6CrSkBq6N
         1hCjbFSZ+KL6Lp9S8kzR6v7xzEoM4g3fYXgYPxanf01TxkkYnVrCHzk67RhEKIr/lchh
         cEOh9+mUwX3oXRQAuWWumdkJObocbdO9djhvGtrlklul0UihdpqwlwlA44Sl8QbNCz1r
         0fvu1O58PiwTzx/HYDu6afddILeJI6OQ8pOXmUyXLt9glRDDPx1n0jNzeASVCi2SmQ51
         OlqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Din84Xua8YUTz3YvbosqFh2HrAdrjgEomUIfjR4Kxig=;
        b=YZifX/biCZ90gDxibKYYHpHrZCA6kEoGl1OyUVB4OHVXXFAuFrgVU7voDL2GhunlhP
         5tznJhP3QWOjTbO/u3TLg520XBY8gc50tbOrxu9Sc5ilxuyW8e6gSopThDCX2xnAGo+J
         LSiyOffASxVQknbQ66bhl8+0isGUDklGDnWvyn07pM+FQGPWiYR7HALZuDpyODpBvEuD
         Tm8s0lDj9uEHHjLXSfbYWKGE84c5/m3hlEjWswizGP0GpGJ1hFUhVVpc9xxwLkULV8nB
         cLp9I8KpqtoWTybq9lQZucM7RTcTdEs8HMrYvM2+jSPZpHpiIvtGZ7p3Rxa5M3asY/OA
         amEw==
X-Gm-Message-State: ACgBeo0yfze12693JhMTlOfVNKmsetlPKC5+fywoZk4wvJZLiqImlJhw
        xjDfAJTBCCzvfcAqBvTQ4N0=
X-Google-Smtp-Source: AA6agR7TvE3N0da1429IRlXGV73Do98M7ivC1ouFCaF3AoN7R8OEOfnI8SbgK0ALFfhCWGZfWCwajg==
X-Received: by 2002:a5d:6b12:0:b0:21f:1568:c7e1 with SMTP id v18-20020a5d6b12000000b0021f1568c7e1mr14019585wrw.532.1659517819551;
        Wed, 03 Aug 2022 02:10:19 -0700 (PDT)
Received: from gmail.com (84-236-113-167.pool.digikabel.hu. [84.236.113.167])
        by smtp.gmail.com with ESMTPSA id b1-20020a05600c4e0100b003a2e89d1fb5sm1762168wmq.42.2022.08.03.02.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 02:10:18 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 3 Aug 2022 11:10:17 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Liu Song <liusong@linux.alibaba.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/debug: avoid executing show_state and causing rcu
 stall warning
Message-ID: <Yuo7eYzQnzqx4u7F@gmail.com>
References: <1659489525-82994-1-git-send-email-liusong@linux.alibaba.com>
 <Yuo0U2aWUZRLBAsA@gmail.com>
 <c4058896-947d-c802-ac57-bf03eb986378@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4058896-947d-c802-ac57-bf03eb986378@linux.alibaba.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Liu Song <liusong@linux.alibaba.com> wrote:

> 
> > * Liu Song <liusong@linux.alibaba.com> wrote:
> > 
> > > From: Liu Song <liusong@linux.alibaba.com>
> > > 
> > > If the number of CPUs is large, "sysrq_sched_debug_show" will execute for
> > > a long time. Every time I execute "echo t > /proc/sysrq-trigger" on my
> > > 128-core machine, the rcu stall warning will be triggered. Moreover,
> > > sysrq_sched_debug_show does not need to be protected by rcu_read_lock,
> >    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > and no rcu stall warning will appear after adjustment.
> > > 
> > That doesn't mean it doesn't have to be protected by *any* lock - which
> > your patch implements AFAICS.
> > 
> > There's a couple of lines such as:
> > 
> >          for_each_online_cpu(cpu) {
> 
> Hi,
> 
> Here I refer to the implementation of "sysrq_timer_list_show", and I don't
> see any lock.
> 
> Maybe there is a problem with the implementation of "sysrq_timer_list_show".

But we are talking about sysrq_sched_debug_show(), which your patch tries 
to relax the RCU locking of.

Thanks,

	Ingo
