Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCD257A518
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 19:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238096AbiGSRVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 13:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238936AbiGSRVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 13:21:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D817E46D8E;
        Tue, 19 Jul 2022 10:21:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90B67B81C76;
        Tue, 19 Jul 2022 17:21:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4080CC341C6;
        Tue, 19 Jul 2022 17:21:31 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="cK15E3aO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1658251289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+DdIaGBIWAy9ehfPzceJ7R4AOuJB01GP/jeXzjkuNW0=;
        b=cK15E3aOfaYau/qzxYk1kkloBH9BwEizkRXRjeOPTGsrd1mKfY82Kg1qZdllepCJQ2YA2k
        fzNWjrS/HIE5R7Py/BIl5qdxvxCsI+Ux9KlI6kAV+efUUjUTirU5j++IWs+BmBjsFNOVnJ
        v2OhDxkIxgbw1o/2PcJl+mMgqee/XUI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 27e8b8f4 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 19 Jul 2022 17:21:29 +0000 (UTC)
Date:   Tue, 19 Jul 2022 19:21:24 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     Kalle Valo <kvalo@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        Gregory Erwin <gregerwin256@gmail.com>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Rui Salvaterra <rsalvaterra@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v8] ath9k: let sleep be interrupted when unregistering
 hwrng
Message-ID: <YtboFNL+YsHxTHrN@zx2c4.com>
References: <Yrw5f8GN2fh2orid@zx2c4.com>
 <20220629114240.946411-1-Jason@zx2c4.com>
 <87v8s8ubws.fsf@kernel.org>
 <xhsmho7xv512f.mognet@vschneid.remote.csb>
 <CAHmME9q8-1vpV9zFsKkawk+XFm96S6fmug7v-NPJNpQmRoe6-Q@mail.gmail.com>
 <xhsmhcze16snd.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xhsmhcze16snd.mognet@vschneid.remote.csb>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin,

On Tue, Jul 19, 2022 at 04:15:02PM +0100, Valentin Schneider wrote:
> On 11/07/22 13:53, Jason A. Donenfeld wrote:
> > Hi Valentin,
> >
> > On 7/11/22, Valentin Schneider <vschneid@redhat.com> wrote:
> >> Thanks for the Cc.
> >>
> >> I'm not hot on the export of wake_up_state(), IMO any wakeup with
> >> !(state & TASK_NORMAL) should be reserved to kernel internals. Now, here
> >> IIUC the problem is that the patch uses an inline invoking
> >>
> >>   wake_up_state(p, TASK_INTERRUPTIBLE)
> >>
> >> so this isn't playing with any 'exotic' task state, thus it shouldn't
> >> actually need the export.
> >>
> >> I've been trying to figure out if this could work with just a
> >> wake_up_process(), but the sleeping pattern here is not very conforming
> >> (cf. 'wait loop' pattern in sched/core.c), AFAICT the signal is used to
> >> circumvent that :/
> >
> > I don't intend to work on this patch more. If you'd like to ack the
> > trivial scheduler change (adding EXPORT_SYMBOL), that'd help, and then
> > this can move forward as planned. Otherwise, if you have particular
> > opinions about this patch that you want to happen, feel free to pick
> > up the patch and send your own revisions (though I don't intend to do
> > further review). Alternatively, I'll just send a patch to remove the
> > driver entirely. Hopefully you do find this ack-able, though.
> >
> 
> I'm not for a blanket wake_up_state() export, however if we *really* need
> it then I suppose we could have a wake_up_process_interruptible() exported
> and used by __set_notify_signal().
> 
Thanks for keeping this thread alive. I'll do what you suggest and send
a v+1. I think I understand the idea. Let's see how it goes.

Jason
