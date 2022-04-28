Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF10C51378D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 16:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348679AbiD1PBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 11:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243847AbiD1PBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 11:01:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D702A5DA29
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 07:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651157887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MckBjl6pEvKZdqgy2wFZthz2dfKSJ3UYla219JW17Jw=;
        b=iyVvcK+P+xYwYTLIHDDwkv7sB/bFOp/uhpUG7TdTAoG2DexPmSdKbvKPL8dpKBSAx3/XyA
        vsAJTUKHKmOM7CXfw3T5XrLz4v4oCB3pLp0OQLG6oNiUbwN4/Udsso6WTPPgvkHQybN3jF
        CNNvYvPb/6hNBdxHWWzUQshhplOsocc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-157-LcUp97UwMqOoyRBIonnmcQ-1; Thu, 28 Apr 2022 10:57:58 -0400
X-MC-Unique: LcUp97UwMqOoyRBIonnmcQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8E7103811F24;
        Thu, 28 Apr 2022 14:57:57 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.151])
        by smtp.corp.redhat.com (Postfix) with SMTP id A59CD407E1C0;
        Thu, 28 Apr 2022 14:57:52 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 28 Apr 2022 16:57:56 +0200 (CEST)
Date:   Thu, 28 Apr 2022 16:57:50 +0200
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
Message-ID: <20220428145750.GA15485@redhat.com>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
 <20220426225211.308418-7-ebiederm@xmission.com>
 <20220427151455.GE17421@redhat.com>
 <Ympvf1Pam1ckX+EA@hirez.programming.kicks-ass.net>
 <20220428111911.GA3804@redhat.com>
 <YmqckaB+xB6azP1d@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmqckaB+xB6azP1d@hirez.programming.kicks-ass.net>
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
> On Thu, Apr 28, 2022 at 01:19:11PM +0200, Oleg Nesterov wrote:
> > > That is also the reason I couldn't do wait_task_inactive(task, 0)
> >
> > Ah, I din't notice this patch uses wait_task_inactive(child, 0),
> > I think it should do wait_task_inactive(child, __TASK_TRACED).
>
> Shouldn't we then switch wait_task_inactive() so have & matching instead
> of the current ==.

Sorry, I don't understand the context...

As long as ptrace_freeze_traced() sets __state == __TASK_TRACED (as it
currently does) wait_task_inactive(__TASK_TRACED) is what we need ?

After we change it to use JOBCTL_DELAY_WAKEKILL and not abuse __state,
ptrace_attach() should use wait_task_inactive(TASK_TRACED), but this
depends on what exactly we are going to do...

Oleg.

