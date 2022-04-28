Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A205A513CFC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 23:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351967AbiD1VD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 17:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241199AbiD1VDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 17:03:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 156DDA19C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 14:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651179608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gd89wvyW0TX+SL1HQ733QRou6AZK6t/EmbFHHPi83OU=;
        b=PteJiCDzL2RC5CDSP6P2obQnYwlWml2ciwT1q+wyNNR8VlPM/c/nZFvI6+fIIVoEF+dY7d
        9f6LUmnAiCeaZRl7WFFFPVLN0k64E0deoxBp0I5YX5AWV5B0hrnx/3WqAVtxRKvjECP1PQ
        0WZkhiDKCzBlZWYzdnlSX72JYSaJz8w=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-359-eina1oP_NISjhB_PkFm6kg-1; Thu, 28 Apr 2022 17:00:02 -0400
X-MC-Unique: eina1oP_NISjhB_PkFm6kg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D94763C10AAA;
        Thu, 28 Apr 2022 21:00:01 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.151])
        by smtp.corp.redhat.com (Postfix) with SMTP id C2CD1407E243;
        Thu, 28 Apr 2022 20:59:58 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 28 Apr 2022 23:00:01 +0200 (CEST)
Date:   Thu, 28 Apr 2022 22:59:57 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>, rjw@rjwysocki.net,
        mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        bigeasy@linutronix.de, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/5] sched,ptrace: Fix ptrace_check_attach() vs
 PREEMPT_RT
Message-ID: <20220428205956.GG15485@redhat.com>
References: <20220421150248.667412396@infradead.org>
 <20220421150654.817117821@infradead.org>
 <20220425174719.GB12412@redhat.com>
 <8735hzcr18.fsf@email.froward.int.ebiederm.org>
 <Ymr5Ga3gcqG4ZAMt@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ymr5Ga3gcqG4ZAMt@hirez.programming.kicks-ass.net>
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

On 04/28, Peter Zijlstra wrote:
>
> Oleg pointed out that the tracee can already be killed such that
> fatal_signal_pending() is true. In that case signal_wake_up_state()
> cannot be relied upon to be responsible for the wakeup -- something
> we're going to want to rely on.

Peter, I am all confused...

If this patch is against the current tree, we don't need it.

If it is on top of JOBCTL_TRACED/DELAY_WAKEKILL changes (yours or Eric's),
then it can't help - SIGKILL can come right after the tracee drops siglock
and calls schedule().

Perhaps I missed something, but let me repeat the 3rd time: I'd suggest
to simply clear JOBCTL_TRACED along with LISTENING/DELAY_WAKEKILL before
return to close this race.

Oleg.

> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2226,6 +2226,10 @@ static int ptrace_stop(int exit_code, in
>  		spin_lock_irq(&current->sighand->siglock);
>  	}
>  
> +	/* Don't stop if the task is dying. */
> +	if (unlikely(__fatal_signal_pending(current)))
> +		return exit_code;
> +
>  	/*
>  	 * schedule() will not sleep if there is a pending signal that
>  	 * can awaken the task.
> 

