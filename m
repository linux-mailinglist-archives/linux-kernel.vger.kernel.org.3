Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A0551065B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 20:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350231AbiDZSPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 14:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343490AbiDZSPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 14:15:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F0F2A6B0A7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 11:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650996712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=txVrQMYQgYiYutdkcOsERCtHa88Far59A/ryTs+r9MU=;
        b=aYj4eqe7+hP1KEaLyyh4mIbuVXHCW968yLvIvShxcXiFTNn2Ef98jtG3e2uUFOIp2YxH9l
        +j9TFEO2KTG1OOjFJwOa1JWm93UmbzyERJPz6HFzfh5hOU44wIvqoX5pyYGQqclCtuOy8U
        T5I9oi+zcwVymfXwuhqS9jwaiGgTE2s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-507-c_2q4GpbPIOZ2YVlToctkA-1; Tue, 26 Apr 2022 14:11:47 -0400
X-MC-Unique: c_2q4GpbPIOZ2YVlToctkA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6EFA185A5A8;
        Tue, 26 Apr 2022 18:11:46 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.74])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5945954F41E;
        Tue, 26 Apr 2022 18:11:43 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 26 Apr 2022 20:11:45 +0200 (CEST)
Date:   Tue, 26 Apr 2022 20:11:42 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, rjw@rjwysocki.net,
        mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        bigeasy@linutronix.de, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/5] sched,ptrace: Fix ptrace_check_attach() vs
 PREEMPT_RT
Message-ID: <20220426181141.GA13647@redhat.com>
References: <20220421150248.667412396@infradead.org>
 <20220421150654.817117821@infradead.org>
 <20220425143537.GA12412@redhat.com>
 <20220425183343.GM2731@worktop.programming.kicks-ass.net>
 <87pml4llvm.fsf@email.froward.int.ebiederm.org>
 <20220426055122.GA29684@redhat.com>
 <878rrrkbjb.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878rrrkbjb.fsf@email.froward.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/26, Eric W. Biederman wrote:
>
> Relying on __ptrace_unlink assumes the __ptrace_unlink happens after
> siglock is taken before calling ptrace_stop.  Especially with the
> ptrace_notify in signal_delivered that does not look guaranteed.
>
> The __ptrace_unlink could also happen during arch_ptrace_stop.
>
> Relying on siglock is sufficient because __ptrace_unlink holds siglock
> over clearing task->ptrace.  Which means that the simple fix for this is
> to just test task->ptrace before we set JOBCTL_TRACED_QUEIESCE.

Or simply clear _QUEIESCE along with _TRACED/DELAY_WAKEKILL before return?

Oleg.

