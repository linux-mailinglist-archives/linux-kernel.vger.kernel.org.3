Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3926513163
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 12:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241391AbiD1Kln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 06:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238851AbiD1Klk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 06:41:40 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85586A410;
        Thu, 28 Apr 2022 03:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AhbgCqd7BwFlFPAKluXkLDE2fbuPOLW8BZP+83SCshw=; b=l3v//duEcO+RAy1rHKqKk/42N0
        F9QSzG5+uLtUycqoNrYxD5YjchOb96Z/44n5Gv9NHciZfZXvt6EXsJ6pdaUapRb4eTsA3U7Zg2Cc/
        yYnGDsOIyG4Zv5yvxP6TqhzFpu530iCkMZZswEugAIO3P93SdG1HNT0iViDrNiJ/gTzuiNg1a8RUb
        VGI5fyQOb1/Ak1qlbdBglhHzmuzMcXEKUGaJza2YLsZod+FT8aK9IlV87j1zt118M0DqfNK3uh+ZK
        qFRBNB/WtTMCpV1AyoxvfpJdb74tBHXM4hlWQrAF+lp9IXHA3PDrF/TjeQNDDzuPACDtHiaun52k3
        eT4DZpLA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nk1XE-009K05-7g; Thu, 28 Apr 2022 10:38:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9745A3001EA;
        Thu, 28 Apr 2022 12:38:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7ABEE2029F872; Thu, 28 Apr 2022 12:38:07 +0200 (CEST)
Date:   Thu, 28 Apr 2022 12:38:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        Oleg Nesterov <oleg@redhat.com>, mingo@kernel.org,
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
Subject: Re: [PATCH 6/9] signal: Always call do_notify_parent_cldstop with
 siglock held
Message-ID: <YmpujwzYW/l3RB6O@hirez.programming.kicks-ass.net>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
 <20220426225211.308418-6-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426225211.308418-6-ebiederm@xmission.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 05:52:08PM -0500, Eric W. Biederman wrote:
> Now that siglock keeps tsk->parent and tsk->real_parent constant
> require that do_notify_parent_cldstop is called with tsk->siglock held
> instead of the tasklist_lock.
> 
> As all of the callers of do_notify_parent_cldstop had to drop the
> siglock and take tasklist_lock this simplifies all of it's callers.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  kernel/signal.c | 156 +++++++++++++++++-------------------------------
>  1 file changed, 55 insertions(+), 101 deletions(-)
> 
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 72d96614effc..584d67deb3cb 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2121,11 +2121,13 @@ static void do_notify_parent_cldstop(struct task_struct *tsk,
>  				     bool for_ptracer, int why)
>  {
>  	struct kernel_siginfo info;
> -	unsigned long flags;
>  	struct task_struct *parent;
>  	struct sighand_struct *sighand;
> +	bool lock;
>  	u64 utime, stime;
>  
> +	assert_spin_locked(&tsk->sighand->siglock);

lockdep_assert_held() please...
