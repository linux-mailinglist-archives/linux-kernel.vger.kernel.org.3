Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E9B51DA45
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 16:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442129AbiEFOSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 10:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442131AbiEFOS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 10:18:28 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A48A68FA3
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 07:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651846480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4WPQviVmMjemjYUh4b8U2LA9qSLoIcn96jpyEFtsl+k=;
        b=B6VQbqonCrNVPu4maDA8g14VdJ4wLv5qbnYvb3tifRiQkubIPqGJVWJPDvoVaeTzMIn8uI
        0CWGeYMbLL5a8qYJjiE8eEdC3gLrFd7+OjXG+wVniRA9lVsKA83qbJsfZZf7ZDjcw0GqML
        uA95HqV2lh72YIa5pJPCUyLJQ/y/jWA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-dni0LC3cNe2LSghfsbJBpw-1; Fri, 06 May 2022 10:14:37 -0400
X-MC-Unique: dni0LC3cNe2LSghfsbJBpw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EEAEE1C06903;
        Fri,  6 May 2022 14:14:35 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.95])
        by smtp.corp.redhat.com (Postfix) with SMTP id 85DF840CF8E8;
        Fri,  6 May 2022 14:14:31 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri,  6 May 2022 16:14:35 +0200 (CEST)
Date:   Fri, 6 May 2022 16:14:30 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, tj@kernel.org,
        linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>, linux-ia64@vger.kernel.org
Subject: Re: [PATCH v4 0/12] ptrace: cleaning up ptrace_stop
Message-ID: <20220506141403.GA16084@redhat.com>
References: <20220421150248.667412396@infradead.org>
 <20220421150654.817117821@infradead.org>
 <87czhap9dy.fsf@email.froward.int.ebiederm.org>
 <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
 <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
 <87k0b0apne.fsf_-_@email.froward.int.ebiederm.org>
 <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05, Eric W. Biederman wrote:
>
> Eric W. Biederman (11):
>       signal: Rename send_signal send_signal_locked
>       signal: Replace __group_send_sig_info with send_signal_locked
>       ptrace/um: Replace PT_DTRACE with TIF_SINGLESTEP
>       ptrace/xtensa: Replace PT_SINGLESTEP with TIF_SINGLESTEP
>       ptrace: Remove arch_ptrace_attach
>       signal: Use lockdep_assert_held instead of assert_spin_locked
>       ptrace: Reimplement PTRACE_KILL by always sending SIGKILL
>       ptrace: Document that wait_task_inactive can't fail
>       ptrace: Admit ptrace_stop can generate spuriuos SIGTRAPs
>       ptrace: Don't change __state
>       ptrace: Always take siglock in ptrace_resume
>
> Peter Zijlstra (1):
>       sched,signal,ptrace: Rework TASK_TRACED, TASK_STOPPED state

I can't comment 5/12. to be honest I didn't even try to look into
arch/ia64/.

But other than that I see no problems in this version. However, I'd
like to actually apply the whole series and read the changed code
carefully, but sorry, I don't think I can do this before Monday.

Oleg.

