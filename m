Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385DE5170B1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 15:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385342AbiEBNmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 09:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384036AbiEBNmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 09:42:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11293DE9B;
        Mon,  2 May 2022 06:38:44 -0700 (PDT)
Date:   Mon, 2 May 2022 15:38:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651498723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rCK70YCIekd+wr/DbuX1bEqSok0FDuC7B7kL2Dida9Q=;
        b=4no3pu+Wyxofhs7LZK9RoECmU958FPN+Uepm/pk0UPnouutOfcuxkug2w4O0nHZVxkUS1j
        DUhoIdfTRq5Ci0BDqtaN2s2rpkYq7mSGh3gxMXn89TI6RrsUETT12irAV/sAityfH2nI+T
        mtUnLPY79AWT/gwjMfHq/DJq4YjruFZwpE6pyonCT0XzRXL56bILYdg+PSilOfEBIkuEcL
        EbPvUdJipBsq8ONbUjq6mwzB0uy1v6v1isV1IiwxK4vWCSowdohS1LO3Yk0RhlYmKHYt6R
        D3KVZyla2BqIi28HT1EffA73HloLCU7Dh7/wjoSs5JkLVIOuOnQc2zuc5O3tqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651498723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rCK70YCIekd+wr/DbuX1bEqSok0FDuC7B7kL2Dida9Q=;
        b=uxpoBt/FPixZPlqItwmphRlmPiv34Wlmv4nFQwSTcymj6Tww5UrT8L0LKzZ3XYVume+84v
        gJw9eymNDzwkMyBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net, oleg@redhat.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        Will Deacon <will@kernel.org>, tj@kernel.org,
        linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>, linux-ia64@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: [PATCH 0/12] ptrace: cleaning up ptrace_stop
Message-ID: <Ym/e4CrxwV3HlsJj@linutronix.de>
References: <20220421150248.667412396@infradead.org>
 <20220421150654.817117821@infradead.org>
 <87czhap9dy.fsf@email.froward.int.ebiederm.org>
 <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
 <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-29 16:46:59 [-0500], Eric W. Biederman wrote:
> 
> The states TASK_STOPPED and TASK_TRACE are special in they can not
> handle spurious wake-ups.  This plus actively depending upon and
> changing the value of tsk->__state causes problems for PREEMPT_RT and
> Peter's freezer rewrite.

PREEMPT_RT wise, I had to duct tape wait_task_inactive() and remove the
preempt-disable section in ptrace_stop() (like previously). This reduces
the amount of __state + saved_state checks and looks otherwise stable in
light testing.

Sebastian
