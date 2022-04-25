Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC3750E77C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244033AbiDYRui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244019AbiDYRuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:50:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C1061C901
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650908850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3D/48VQENOnSlSpNLDthc2JNrwKESJgr2gi9ea5PG60=;
        b=OcBjCD6MSGM2q7IjdXWBumqNP2jPy2A/uIlMJUvbAUZ6zFO/QaAMHG3hWShFrGNM9r1c0g
        yWVV3g4g/r4sc1YY3SN+BCwxk5ALRwQgn4rE2OJGadeM6Nk4ljBZQ+VUQEkhMoJkTvaj0w
        wR7RwH6/ytBq7q7/ZJBnYEJuLCWzq/Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-656-pFzPbk9MO0m3sVwH1Ss_MA-1; Mon, 25 Apr 2022 13:47:25 -0400
X-MC-Unique: pFzPbk9MO0m3sVwH1Ss_MA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 35DEE800B28;
        Mon, 25 Apr 2022 17:47:24 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.193.11])
        by smtp.corp.redhat.com (Postfix) with SMTP id 272C540CF910;
        Mon, 25 Apr 2022 17:47:20 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 25 Apr 2022 19:47:23 +0200 (CEST)
Date:   Mon, 25 Apr 2022 19:47:20 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        ebiederm@xmission.com, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/5] sched,ptrace: Fix ptrace_check_attach() vs
 PREEMPT_RT
Message-ID: <20220425174719.GB12412@redhat.com>
References: <20220421150248.667412396@infradead.org>
 <20220421150654.817117821@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421150654.817117821@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/21, Peter Zijlstra wrote:
>
> @@ -2225,7 +2238,7 @@ static int ptrace_stop(int exit_code, in
>  	 * schedule() will not sleep if there is a pending signal that
>  	 * can awaken the task.
>  	 */
> -	current->jobctl |= JOBCTL_TRACED;
> +	current->jobctl |= JOBCTL_TRACED | JOBCTL_TRACED_QUIESCE;
>  	set_special_state(TASK_TRACED);

OK, this looks wrong. I actually mean the previous patch which sets
JOBCTL_TRACED.

The problem is that the tracee can be already killed, so that
fatal_signal_pending(current) is true. In this case we can't rely on
signal_wake_up_state() which should clear JOBCTL_TRACED, or the
callers of ptrace_signal_wake_up/etc which clear this flag by hand.

In this case schedule() won't block and ptrace_stop() will leak
JOBCTL_TRACED. Unless I missed something.

We could check fatal_signal_pending() and damn! this is what I think
ptrace_stop() should have done from the very beginning. But for now
I'd suggest to simply clear this flag before return, along with
DELAY_WAKEKILL and LISTENING.

>  	current->jobctl &= ~JOBCTL_LISTENING;
> +	current->jobctl &= ~JOBCTL_DELAY_WAKEKILL;

	current->jobctl &=
		~(~JOBCTL_TRACED | JOBCTL_DELAY_WAKEKILL | JOBCTL_LISTENING);

Oleg.

