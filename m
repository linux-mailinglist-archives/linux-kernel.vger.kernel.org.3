Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699EA524126
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 01:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344439AbiEKXlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 19:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349451AbiEKXlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 19:41:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699792CC98
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 16:40:59 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652312457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kH9OohPfXgK2fOqvMs876VLdS4ytX/lNxe9AdFrucOE=;
        b=veojJr+RXkl7uopde/STRTEdqzrV3J3lqr+LLlfBb0FLHamC6kQ2Ywghn6j1N0twONog8h
        +tHD1pQLnUSFRJxK2kEGRe63rVVnioRqX9DrVXtSQ+sQDgEwfos0LvWiG0/xCp4gZUmX+/
        UT2Yh0GdlZqBJTPcXsyxxAgM9vbZuHcPTVm+tueiHYzpWxGzXxUCwDTcyVbOhMFHITXS6k
        iahSA8yHj4reSmqmRdqlsvkGPvyJtLA9KwoI0zg6pveC9lMKCaeUeS/yTiQWW7y0KOE8CN
        t7R0vimhhtoby8PGCU/9ZNqK4TxQmK2DLZ2FJtf8N4FLv1h0wfY255bNgwpk2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652312457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kH9OohPfXgK2fOqvMs876VLdS4ytX/lNxe9AdFrucOE=;
        b=gpFs+rwcRqxzTdGGf+UKbSVg2pfrmnuNGIdFmZc0pnr+RN1vxwkpwSJD6koI080l9zIDY7
        MyjGv8K9tkszMLAg==
To:     Delyan Kratunov <delyank@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>
Cc:     "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "qais.yousef@arm.com" <qais.yousef@arm.com>,
        Delyan Kratunov <delyank@fb.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "adharmap@quicinc.com" <adharmap@quicinc.com>,
        "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>,
        "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "Kenta.Tada@sony.com" <Kenta.Tada@sony.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "ed.tsai@mediatek.com" <ed.tsai@mediatek.com>,
        "legion@kernel.org" <legion@kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH v2] sched/tracing: append prev_state to tp args instead
In-Reply-To: <c8a6930dfdd58a4a5755fc01732675472979732b.camel@fb.com>
References: <20220510082940.GA100765@worktop.programming.kicks-ass.net>
 <c8a6930dfdd58a4a5755fc01732675472979732b.camel@fb.com>
Date:   Thu, 12 May 2022 01:40:57 +0200
Message-ID: <8735hfy6wm.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11 2022 at 18:28, Delyan Kratunov wrote:
> Commit fa2c3254d7cf (sched/tracing: Don't re-read p->state when emitting
> sched_switch event, 2022-01-20) added a new prev_state argument to the
> sched_switch tracepoint, before the prev task_struct pointer.
>
> This reordering of arguments broke BPF programs that use the raw
> tracepoint (e.g. tp_btf programs). The type of the second argument has
> changed and existing programs that assume a task_struct* argument
> (e.g. for bpf_task_storage access) will now fail to verify.
>
> If we instead append the new argument to the end, all existing programs
> would continue to work and can conditionally extract the prev_state
> argument on supported kernel versions.

If we instead? ... would continue to work?

  https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#changelog
  https://www.kernel.org/doc/html/latest/process/submitting-patches.html#submittingpatches

It's not too hard to actually follow documented rules. Something like
this:

  "Undo the reordering and move the new argument last, which ensures
   that all existing programs continue to work."

Hmm?

What's worse is that the changelog is missing a clear statement that
this is a one-time change which cannot be abused to turn tracepoints
into unmodifiable ABI as you stated in:

 https://lore.kernel.org/lkml/CAEf4BzaEo+dxSRJZHQiXYrj-a3_B-eODZUxGh3HrnPjquMYFXQ@mail.gmail.com

Thanks,

        tglx



