Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2270511D40
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240419AbiD0P5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240474AbiD0P5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:57:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF68573781
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651074840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fdXdyruG2mNABegzus1OI0l/dvVuZJQv9Fw0QN0j5EU=;
        b=Hbk2oEHgsB/TK5kopilW1Egn140i+fCEKwgWLQi/ZvQO3De5rA8CeoUyTzmBR0k0JgIwrX
        eoD8qpwt3PEx+5lpDTrPPdP4L80nVg4af6ylTteibODEiymYGOpq6RffeaVB3IGis9e/g7
        2F7B6tJsflt35VDybKCnM/t8TjEx4Sg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648-7t3OQgjoNreZbo7V5a8a2w-1; Wed, 27 Apr 2022 11:53:57 -0400
X-MC-Unique: 7t3OQgjoNreZbo7V5a8a2w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 274971C04B7E;
        Wed, 27 Apr 2022 15:53:41 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.128])
        by smtp.corp.redhat.com (Postfix) with SMTP id 139915E2C06;
        Wed, 27 Apr 2022 15:53:37 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 27 Apr 2022 17:53:40 +0200 (CEST)
Date:   Wed, 27 Apr 2022 17:53:37 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        ebiederm@xmission.com, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/5] sched,ptrace: Fix ptrace_check_attach() vs
 PREEMPT_RT
Message-ID: <20220427155335.GH17421@redhat.com>
References: <20220421150248.667412396@infradead.org>
 <20220421150654.817117821@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421150654.817117821@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
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
> @@ -1329,8 +1337,7 @@ SYSCALL_DEFINE4(ptrace, long, request, l
>  		goto out_put_task_struct;
>  
>  	ret = arch_ptrace(child, request, addr, data);
> -	if (ret || request != PTRACE_DETACH)
> -		ptrace_unfreeze_traced(child);
> +	ptrace_unfreeze_traced(child);

Forgot to mention... whatever we do this doesn't look right.

ptrace_unfreeze_traced() must not be called if the tracee was untraced,
anothet debugger can come after that. I agree, the current code looks
a bit confusing, perhaps it makes sense to re-write it:

	if (request == PTRACE_DETACH && ret == 0)
		; /* nothing to do, no longer traced by us */
	else
		ptrace_unfreeze_traced(child);

Oleg.

