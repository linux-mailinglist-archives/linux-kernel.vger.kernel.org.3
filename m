Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BB8513252
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 13:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345519AbiD1LWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 07:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbiD1LWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 07:22:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A755EA94F2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 04:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651144769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qr2DOGB0z6K0qePNKw8JJPlRt9jZnLNpgbFm3MJ8HzE=;
        b=eNKVgpbvjOSnx86OScTqbuZpid+U+vejq4zFJTjH0smxRRL+mTTkBGmqPkfl77+KfMAvI9
        VFKhWaLgnZicHcYoaC9/SlNuqNMB0kfmNExnHU6M/q9dWl5AhH3/TiMpTw0aqfAT2PZLS/
        hjqts5K8zKjZNx30sP3KAJtsUfREpN8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-416-PeK0j-6rMlibt-Yq8wehuw-1; Thu, 28 Apr 2022 07:19:24 -0400
X-MC-Unique: PeK0j-6rMlibt-Yq8wehuw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD7BE1815CFC;
        Thu, 28 Apr 2022 11:19:17 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.193.96])
        by smtp.corp.redhat.com (Postfix) with SMTP id C6B052166B18;
        Thu, 28 Apr 2022 11:19:12 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 28 Apr 2022 13:19:17 +0200 (CEST)
Date:   Thu, 28 Apr 2022 13:19:11 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, tj@kernel.org,
        linux-pm@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        inux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 7/9] ptrace: Simplify the wait_task_inactive call in
 ptrace_check_attach
Message-ID: <20220428111911.GA3804@redhat.com>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
 <20220426225211.308418-7-ebiederm@xmission.com>
 <20220427151455.GE17421@redhat.com>
 <Ympvf1Pam1ckX+EA@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ympvf1Pam1ckX+EA@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/28, Peter Zijlstra wrote:
>
> On Wed, Apr 27, 2022 at 05:14:57PM +0200, Oleg Nesterov wrote:
> > On 04/26, Eric W. Biederman wrote:
> > >
> > > Asking wait_task_inactive to verify that tsk->__state == __TASK_TRACED
> > > was needed to detect the when ptrace_stop would decide not to stop
> > > after calling "set_special_state(TASK_TRACED)".  With the recent
> > > cleanups ptrace_stop will always stop after calling set_special_state.
> > >
> > > Take advatnage of this by no longer asking wait_task_inactive to
> > > verify the state.  If a bug is hit and wait_task_inactive does not
> > > succeed warn and return -ESRCH.
> >
> > ACK, but I think that the changelog is wrong.
> >
> > We could do this right after may_ptrace_stop() has gone. This doesn't
> > depend on the previous changes in this series.
>
> It very much does rely on there not being any blocking between
> set_special_state() and schedule() tho. So all those PREEMPT_RT
> spinlock->rt_mutex things need to be gone.

Yes sure. But this patch doesn't add the new problems, imo.

Yes we can hit the WARN_ON_ONCE(!wait_task_inactive()), but this is
correct in that it should not fail, and this is what we need to fix.

> That is also the reason I couldn't do wait_task_inactive(task, 0)

Ah, I din't notice this patch uses wait_task_inactive(child, 0),
I think it should do wait_task_inactive(child, __TASK_TRACED).

Oleg.

