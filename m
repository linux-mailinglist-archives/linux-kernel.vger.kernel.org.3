Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0087502893
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 12:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352523AbiDOLAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 07:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352521AbiDOLAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 07:00:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 385E6BD7F7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 03:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650020285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5ThSLI7nx7rxQ8d59zPwwwgM5v5aW7Mmh+04G/MvnKs=;
        b=P39HqjpVrtu2dms2w/VjVfS3TZ1V49g8lbwoHA4zL625QvPHNQJHqgLAMITk2NelsQOwAj
        paVVl3DWuc1xKPENPDTFAcUkO7wRLar1ZhN40Imu+e06h9bJpRu2Dnwm1bJBMgtKFETB5x
        wLYZfRTKx6clSng0PDuov1shw/5QX5E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-111-ELIWFouHNTmTyeWYcu8vRQ-1; Fri, 15 Apr 2022 06:58:01 -0400
X-MC-Unique: ELIWFouHNTmTyeWYcu8vRQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A37185A5BE;
        Fri, 15 Apr 2022 10:58:00 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.163])
        by smtp.corp.redhat.com (Postfix) with SMTP id 047AA2167D68;
        Fri, 15 Apr 2022 10:57:56 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 15 Apr 2022 12:57:59 +0200 (CEST)
Date:   Fri, 15 Apr 2022 12:57:56 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        ebiederm@xmission.com, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/5] sched,ptrace: Fix ptrace_check_attach() vs PREEMPT_RT
Message-ID: <20220415105755.GA15217@redhat.com>
References: <20220412114853.842942162@infradead.org>
 <20220413132451.GA27281@redhat.com>
 <20220413185704.GA30360@redhat.com>
 <20220413185909.GB30360@redhat.com>
 <20220413192053.GY2731@worktop.programming.kicks-ass.net>
 <20220413195612.GC2762@worktop.programming.kicks-ass.net>
 <20220414115410.GA32752@redhat.com>
 <20220414183433.GC32752@redhat.com>
 <YlikBjA3kL3XEQP5@hirez.programming.kicks-ass.net>
 <20220415101644.GA10421@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415101644.GA10421@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/15, Oleg Nesterov wrote:
>
> OK, so far it seems that this patch needs a couple of simple fixes you
> pointed out, but before I send V2:
>
> 	- do you agree we can avoid JOBCTL_TRACED_FROZEN in 1-2 ?
>
> 	- will you agree if I change ptrace_freeze_traced() to rely
> 	  on __state == TASK_TRACED rather than task_is_traced() ?
>

Forgot to say, I think 1/5 needs some changes in any case...

ptrace_resume() does  wake_up_state(child, __TASK_TRACED) but doesn't
clear JOBCTL_TRACED. The "else" branch in ptrace_stop() leaks this flag
too. Perhaps I missed something, I'll reread 1/5 again, but the main
question to me is whether 1-2 actually need the JOBCTL_TRACED_FROZEN flag.

Oleg.

