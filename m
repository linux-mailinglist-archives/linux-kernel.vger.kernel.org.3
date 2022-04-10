Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA3E4FB0B5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 00:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239371AbiDJWsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 18:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiDJWsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 18:48:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D48428997
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 15:46:25 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649630782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HjdZfT7WqnIC22o70UU22jzUxzyX3V0wtwEU6gK+14Q=;
        b=geKPgMsqcZFq1Lqo8IMRQLrxz/Zu/oVnmI3NYpt7F3m1AG4FDv9sFKjnAX+kcTq8R0qh2w
        V4QkCx4/OuSv7jZIETDobOb0CzEewpfYS41Mf0gHHzxL7TNOdx3r4yWFD9qdWgRfbpBi3k
        yQO5VZs8kxtWC/hPPCvrw0NNbBT29inyAqZbpzVth9SvPn+An9kxbdxY38LqJWz1ifRCo2
        5Jl698C5EsrfhOn2PeGB5hw8qsKFlCMm/JkLO70YTNpHKmzBNo+LQT4mye8SLvJTyFM4zD
        0QJdaISR6i0NkToKywHefB3mbEWnp2lLqYdr561Z8Yu1ptLaAmmVABPiAd3IAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649630782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HjdZfT7WqnIC22o70UU22jzUxzyX3V0wtwEU6gK+14Q=;
        b=qfqmXB+dLy4upeEnx0KEGUlS+U1irnHXATCTxNOW6FuJvmDPr6lZ6XmY+e9oW8pKd9ddtM
        NXC8YfwNAQfHFTDQ==
To:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Radoslaw Burny <rburny@google.com>
Subject: Re: [PATCH 03/12] timer: Protect lockdep functions with #ifdef
In-Reply-To: <20220208194324.85333-4-namhyung@kernel.org>
References: <20220208194324.85333-1-namhyung@kernel.org>
 <20220208194324.85333-4-namhyung@kernel.org>
Date:   Mon, 11 Apr 2022 00:46:22 +0200
Message-ID: <871qy4h801.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08 2022 at 11:43, Namhyung Kim wrote:
> With upcoming lock tracepoints config, it'd define some of lockdep
> functions without enabling CONFIG_LOCKDEP actually.  The existing code
> assumes those functions will be removed by the preprocessor but it's
> not the case anymore.  Let's protect the code with #ifdef's
> explicitly.

This is lame. It's certainly possible to come up with replacement macros
which are compiled out when LOCKDEP is off for these use cases which are
not involved in lock tracepoint magic. Then just change these places
over to the new macros and keep the code free from this #ifdef ugliness.

Thanks,

        tglx


