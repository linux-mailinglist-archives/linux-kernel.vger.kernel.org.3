Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347C2508726
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 13:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356819AbiDTLiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 07:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357055AbiDTLit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 07:38:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 15C0D4160D
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 04:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650454561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d4N4aySfLdtOlqYeiwulC0vSXKCn/tdHTX38ZaFwcP8=;
        b=RYytNF6ym+Mu9tpYHnT+7Sl3aTydfzAZ/mTJvTScsGRYjbLR8BtsZXRTuq0nWfEHe1DOBC
        +9+1+ij6U+HX2bht8cfLHm9GXNHkKC8xnd88vEEce/EoEbCdZyLn6b7HLKb5Vv/NwHM5f8
        RdZo4+FqiqlGamavCI1A4DBVnuavw7k=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-21-ohOHLoVhNe-LFcUl1gEhqw-1; Wed, 20 Apr 2022 07:35:53 -0400
X-MC-Unique: ohOHLoVhNe-LFcUl1gEhqw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 245711C0512A;
        Wed, 20 Apr 2022 11:35:53 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.193.5])
        by smtp.corp.redhat.com (Postfix) with SMTP id 282534639F6;
        Wed, 20 Apr 2022 11:35:49 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 20 Apr 2022 13:35:52 +0200 (CEST)
Date:   Wed, 20 Apr 2022 13:35:48 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        ebiederm@xmission.com, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/5] sched,ptrace: Fix ptrace_check_attach() vs PREEMPT_RT
Message-ID: <20220420113547.GA16575@redhat.com>
References: <20220413185704.GA30360@redhat.com>
 <20220413185909.GB30360@redhat.com>
 <20220413192053.GY2731@worktop.programming.kicks-ass.net>
 <20220413195612.GC2762@worktop.programming.kicks-ass.net>
 <20220414115410.GA32752@redhat.com>
 <20220414183433.GC32752@redhat.com>
 <YlikBjA3kL3XEQP5@hirez.programming.kicks-ass.net>
 <20220415101644.GA10421@redhat.com>
 <20220415105755.GA15217@redhat.com>
 <20220420102006.GD2731@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420102006.GD2731@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/20, Peter Zijlstra wrote:
>
> On Fri, Apr 15, 2022 at 12:57:56PM +0200, Oleg Nesterov wrote:
> >
> > ptrace_resume() does  wake_up_state(child, __TASK_TRACED) but doesn't
> > clear JOBCTL_TRACED. The "else" branch in ptrace_stop() leaks this flag
> > too. Perhaps I missed something, I'll reread 1/5 again, but the main
> > question to me is whether 1-2 actually need the JOBCTL_TRACED_FROZEN flag.
>
> Ok, getting back to this. So I did the change to ptrace_resume(), but
> I'm not entirely sure I understand the issue with the else branch of
> ptrace_stop().
>
> My understanding is that if we hit that else branch, we've raced wth
> __ptrace_unlink(), and that will have done:

Yes, thanks for correcting me, I forgot that may_ptrace_stop() has gone.

Oleg.

