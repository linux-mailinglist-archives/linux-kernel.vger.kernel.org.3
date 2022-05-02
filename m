Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0E1516DE5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 12:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243948AbiEBKM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 06:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiEBKMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 06:12:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E5B236;
        Mon,  2 May 2022 03:08:54 -0700 (PDT)
Date:   Mon, 2 May 2022 12:08:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651486133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=63m7IFpyJnFKOQ8AnvnEPCTLSco6sTiRbyuaAdNF4fs=;
        b=u4DzhGvBvgeEmjdmbffbpoosHxFATqBRLbiYdCD0732eDPLRY3F6uEifkO/Ctq9STnUgqq
        Im6/rOVsJm7QDR6CzQDSNbYGXmpDxdMG3B4pYMJV7cJt08yvyI8Q4+6YAiezkpIXL+U2kc
        NS6H37pqDryfADNo40x1qtYo0NfKDmqTf98B2UouiJj/gfu9EzeD0AygrBRPM4/Hzmi87y
        0nttQrWACAnA6M1c5KXwddN5X8upHGJlf1jFJEs8ks91k+oZpEwIsijZ9ozTzTduhpzlDS
        roiBQC4D40e2IXy/86w4pwoxFhnTzdXHxT/pk0CdjxTOS8lh6pdIPaHgR0oZBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651486133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=63m7IFpyJnFKOQ8AnvnEPCTLSco6sTiRbyuaAdNF4fs=;
        b=DcKvs7WVaRfSQxdISGO1hUYCOUpk5mwoqI5/iZDWPsVEDcfKxJTA79vGQkcz2cFv4Kltke
        cJCO5nJ05LfE5GDA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        Oleg Nesterov <oleg@redhat.com>, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de,
        Will Deacon <will@kernel.org>, tj@kernel.org,
        linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, linux-ia64@vger.kernel.org
Subject: Re: [PATCH v2 10/12] ptrace: Only return signr from ptrace_stop if
 it was provided
Message-ID: <Ym+tsRcP2TQLcpJF@linutronix.de>
References: <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
 <20220429214837.386518-10-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220429214837.386518-10-ebiederm@xmission.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-29 16:48:35 [-0500], Eric W. Biederman wrote:
> In ptrace_stop a ptrace_unlink or SIGKILL can occur either after
> siglock is dropped or after tasklist_lock is dropped.  At either point
> the result can be that ptrace will continue and not stop at schedule.
> 
> This means that there are cases where the current logic fails to handle
> the fact that ptrace_stop did not actually stop, and can potentially
> cause ptrace_report_syscall to attempt to deliver a signal.
> 
> Instead of attempting to detect in ptrace_stop when it fails to
> stop update ptrace_resume and ptrace_detach to set a flag to indicate
      ,
> that the signal to continue with has be set.   Use that
                                       been
> new flag to decided how to set return signal.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Sebastian
