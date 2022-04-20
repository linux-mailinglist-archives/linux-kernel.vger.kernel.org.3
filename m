Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18535508F03
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 20:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381367AbiDTSG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 14:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355250AbiDTSGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 14:06:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 03FD347078
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 11:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650477815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CIL7ig4ne/h1LgZxz8/JxhT2oGMYZ2VjyaHLoNy0IU4=;
        b=OcckWkju5hhzK2qA0GCXlSubk9aXmyT/0ERpESlO3wuKqiuE6y+FRqbGvKS+4DXEWMU+j2
        Y83I5zQN6djZKPuvMU4A3hqLxfleOXeYvIotXQCJsVseZD9ZhNB+wYYn+Zolqbxgse6UPG
        ojFfEpWmzeCpPecnhulmiTkAC4pcRSI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-rjH9If2oMhOJ4NqgafTknw-1; Wed, 20 Apr 2022 14:03:29 -0400
X-MC-Unique: rjH9If2oMhOJ4NqgafTknw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B11D08002BF;
        Wed, 20 Apr 2022 18:03:28 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.37])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9AEC140D0166;
        Wed, 20 Apr 2022 18:03:25 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 20 Apr 2022 20:03:27 +0200 (CEST)
Date:   Wed, 20 Apr 2022 20:03:23 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        ebiederm@xmission.com, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/5] sched,ptrace: Fix ptrace_check_attach() vs PREEMPT_RT
Message-ID: <20220420180323.GA14947@redhat.com>
References: <20220413192053.GY2731@worktop.programming.kicks-ass.net>
 <20220413195612.GC2762@worktop.programming.kicks-ass.net>
 <20220414115410.GA32752@redhat.com>
 <20220414183433.GC32752@redhat.com>
 <YlikBjA3kL3XEQP5@hirez.programming.kicks-ass.net>
 <20220415101644.GA10421@redhat.com>
 <20220415105755.GA15217@redhat.com>
 <Yllep6B8eva2VURJ@hirez.programming.kicks-ass.net>
 <20220418170104.GA16199@redhat.com>
 <20220420131731.GF2731@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420131731.GF2731@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
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
> Does something like:
>
> #define JOBCTL_TRACED_BIT		25
> #define JOBCTL_TRACED_QUIESCE_BIT	26
>
> work?

Agreed! ;)

> >  	} else {
> >  		/*
> >  		 * By the time we got the lock, our tracer went away.
> > -		 * Don't drop the lock yet, another tracer may come.
> > -		 *
> > +		 * Don't drop the lock yet, another tracer may come,
> > +		 * tasklist protects us from ptrace_freeze_traced().
> > +		 */
> > +		__set_current_state(TASK_RUNNING);
> > +		clear_traced_xxx();
> > +		/*
> >  		 * If @gstop_done, the ptracer went away between group stop
> >  		 * completion and here.  During detach, it would have set
> >  		 * JOBCTL_STOP_PENDING on us and we'll re-enter
>
> This is that same else clause again; perhaps make signal_wake_up_state()
> also clear TRACED_XXX instead?

I swear, I too thought about this after my last email. Yes, I think this
makes sense. Thanks,

Oleg.

