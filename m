Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598E251D1B3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 08:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387197AbiEFG7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 02:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387156AbiEFG7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 02:59:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A47DBF41;
        Thu,  5 May 2022 23:55:30 -0700 (PDT)
Date:   Fri, 6 May 2022 08:55:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651820126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QAH3FcCKKDUB8BwaUIjAj1fmKsKfS9SL945xR8vnlTc=;
        b=p1Ai83vwTZgyqAE/iwJdRqd+fgohNQWA7vHMnIYdnbQX0DbrL46TUGTFS0g6pfHu4Pk7Gf
        4+pa0Y+9Z+O0xzSq1rTZJrvVS5sMZQrfTPaZyB5THNGchD6NSZZruLmPLIjtmxfbD1Z5fh
        N1cG7yFFKA78WxawduwxoEukfdq/l60wMFtdUkjffURvMl1RbZPvuWi0JNyGjxXjtFOogI
        9oGj+2AEuXWdA8Yyyp/VgCLZnz/zPgzBe/vGPHlcTMTjnN8zyEVHbrTLswnP1XEpyx2+rI
        B7uiZWVY102NhOaW+Sb5s7kojxAO2Jtdmvid9e9wAggJPtiFMOns4kobQhGN1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651820126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QAH3FcCKKDUB8BwaUIjAj1fmKsKfS9SL945xR8vnlTc=;
        b=MORZRFt4aT5cGysspLl+1u4glVgym6sLZTmRP/lsqFBHtslaKnTzdNby1vSOhIqZzsds36
        CBl0YSd+fTBtweBw==
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
Subject: Re: [PATCH v4 08/12] ptrace: Document that wait_task_inactive can't
 fail
Message-ID: <YnTGXGabf9UDoZyn@linutronix.de>
References: <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
 <20220505182645.497868-8-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220505182645.497868-8-ebiederm@xmission.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-05 13:26:41 [-0500], Eric W. Biederman wrote:
> After ptrace_freeze_traced succeeds it is known that the the tracee
                                                       the

> has a __state value of __TASK_TRACED and that no __ptrace_unlink will
> happen because the tracer is waiting for the tracee, and the tracee is
> in ptrace_stop.

Sebastian
