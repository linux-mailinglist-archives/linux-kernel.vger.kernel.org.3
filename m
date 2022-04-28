Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2752151310D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 12:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238863AbiD1KRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 06:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238568AbiD1KQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 06:16:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067A533898;
        Thu, 28 Apr 2022 03:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0hAD2TvAOIWLHlJzzIV1W5Ntb/AneBoQ7gA0EhNRMB4=; b=Yd4l882RZ59I/9Pp2tdng5bTdm
        9V8Vgio3Lp0j1G7ughnktXJFE91D5GHMBUq6ALxMgdRL9ZJmU4Abwp3tvGFGKaXgOatfXZKb/oQdD
        x3wiZ1rDf7PZBL6Onj7DkhqOHeCTYN1lX5P7AbwfTBySWC/8LrYFqNnvMZFncuxJ5yoBMOlgCbjAK
        EJ4XAQ0xF/4hvOAU9OZmiEMqt1YwLvYB9s1eE3AsuCNoyVBnie16J9czUCUpgrtf/Rz049giD49BM
        DrqbF6I+/Y9rUJpxscic27P0yHmEC+DqiQsP5qWYw2oSdEPE3HXIAgndMJf9YOeVL6tx+sk3dHTKG
        MWc/s6qg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nk13j-00BP3P-DL; Thu, 28 Apr 2022 10:07:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D59BB3001AD;
        Thu, 28 Apr 2022 12:07:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BB55D2029F872; Thu, 28 Apr 2022 12:07:36 +0200 (CEST)
Date:   Thu, 28 Apr 2022 12:07:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net, oleg@redhat.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        bigeasy@linutronix.de, Will Deacon <will@kernel.org>,
        tj@kernel.org, linux-pm@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 0/9] ptrace: cleaning up ptrace_stop
Message-ID: <YmpnaNIzudsk7JLI@hirez.programming.kicks-ass.net>
References: <20220421150248.667412396@infradead.org>
 <20220421150654.817117821@infradead.org>
 <87czhap9dy.fsf@email.froward.int.ebiederm.org>
 <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 05:50:21PM -0500, Eric W. Biederman wrote:
> ....  Peter Zijlstra has
> been rewriting the classic freezer and in earlier parts of this
> discussion so I presume it is also a problem for PREEMPT_RT.

Ah, the freezer thing is in fact a sched/arm64 issue, the common issue
between these two issues is ptrace though.

Specifically, on recent arm64 chips only a subset of CPUs can execute
arm32 code and 32bit processes are restricted to that subset. If by some
mishap you try and execute a 32bit task on a non-capable CPU it gets
terminated without prejudice.

Now, the current freezer has this problem that tasks can spuriously thaw
too soon (where too soon is before SMP is restored) which leads to these
32bit tasks being killed dead.

That, and it was a good excuse to fix up the current freezer :-)
