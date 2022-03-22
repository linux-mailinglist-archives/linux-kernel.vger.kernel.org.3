Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB164E3D3A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 12:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbiCVLJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 07:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbiCVLIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 07:08:47 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADB78022F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 04:07:18 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id bi12so35451254ejb.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 04:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S6/4un/xAGRvWe3wYtxvyEE03qJte1803Enq//eWIzM=;
        b=B/Y56Fq+twYdKEoYHyCGmtTHsWIlZ8hk3Vig3e074KLnfLutoFGVVwPKmRclyc/pAq
         jdFBmZQq/CI1gTPZQvNWvZ1FC0ScopMtYQc650a+oPYURVRR1NmRB23vLDtN580mxnKg
         VDvcxxjABIAe53BY0FhYT38JDy1pTt5UMQfxHvhlUDgTxFVckNrCA1IWuv01u+HwLD9P
         fKgZ7+xg+/yV5vvyrlzXLrLqy0Z9lfGFRcf7Eg+nVKC5DZAkbkvQGJNAFUCCrSmXARGN
         QigoDI35ZZvSCmhYJhNubMbeHUlETJcATb8xuvTLtj01bgspPL8ZXxo8eks/GfTW3BG3
         ncMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=S6/4un/xAGRvWe3wYtxvyEE03qJte1803Enq//eWIzM=;
        b=zKZuJEuJeHqqW3iDuL1DhtuqH6MXt8hBFKaxroPMLWiKbTL4KlDXpI44tnAEiBgYub
         LqZJkKukqJ6e18ipIwlTojOoFW8DAg6TjmJ89sMBN4hnYwPEm1n66nfKpTuAGkOQZIJh
         MBGMlT60vpdHwLlpOSLHuHF+Qm93Zic50UQxTnVzdRpAtOE9QBL03VRM+mTIwHhJayGD
         3C7/SN/MTiTqYQ2XpJ2JVL+bshlkIG3LwIZyu6yayvnfQErK99SYTCTlklZEc6bR08FP
         yWu+YDabFJSMg7q/ygr3SPEpGZqmjQrPa8Pj26bsBJg7zt8ltsKOJ0emzOFwQuv7H8t2
         kibA==
X-Gm-Message-State: AOAM533hNlUydQ/4Q+MV92AS+NyLTvm46lAP570C3oARTzJuQGzJmJJW
        M89ffCIy5ZwGssKGD6qUpUk=
X-Google-Smtp-Source: ABdhPJxtZijyRRU8uS3RNvZqdAwAkHMjkh800c3zWMTZI4tjZ9bcbTxQXRyjnVCxTt6AIjuyL9do4w==
X-Received: by 2002:a17:907:94c4:b0:6da:c28c:3f44 with SMTP id dn4-20020a17090794c400b006dac28c3f44mr26381118ejc.722.1647947237306;
        Tue, 22 Mar 2022 04:07:17 -0700 (PDT)
Received: from gmail.com (0526ECD0.dsl.pool.telekom.hu. [5.38.236.208])
        by smtp.gmail.com with ESMTPSA id k12-20020aa7c38c000000b0041939d9ccd0sm3057841edq.81.2022.03.22.04.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 04:07:16 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 22 Mar 2022 12:07:13 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [GIT PULL] scheduler updates for v5.18
Message-ID: <Yjmt4SYBRh8bMVas@gmail.com>
References: <YjhZUezhnamHAl0H@gmail.com>
 <Yjh58h8cpcPERVZA@qian>
 <CAHk-=whrqeX-8yHEdSCGFUyyC2sj=OLyeFR9civUiswR=A+PwA@mail.gmail.com>
 <Yjl8Lk2uPiZkXoM9@gmail.com>
 <Yjl/T0SBCo1zfkkS@gmail.com>
 <871qyu5rim.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871qyu5rim.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Huang, Ying <ying.huang@intel.com> wrote:

> Hi, Ingo,
> 
> Ingo Molnar <mingo@kernel.org> writes:
> 
> > * Ingo Molnar <mingo@kernel.org> wrote:
> >
> >> 
> >> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >> 
> >> > On Mon, Mar 21, 2022 at 6:13 AM Qian Cai <quic_qiancai@quicinc.com> wrote:
> >> > >
> >> > > On Mon, Mar 21, 2022 at 11:54:09AM +0100, Ingo Molnar wrote:
> >> > > > Huang Ying (3):
> >> > > >       sched/numa-balancing: Move some document to make it consistent with the code
> >> > > >       sched/numa: Fix NUMA topology for systems with CPU-less nodes
> >> > > >       sched/numa: Avoid migrating task to CPU-less node
> >> > >
> >> > > Linus, I don't think you want to merge this as-is. This will introduce a
> >> > > kernel crash on arm64 NUMA as mentioned in this thread,
> >> > 
> >> > Ok, dropped from my queue. Thanks,
> >> 
> >> I've reverted the broken commit & will send another pull request after 
> >> some testing. Sorry about that!
> >
> > Ended up using the fix below instead - it's tested already on the affected 
> > system.
> >
> 
> Thanks a lot for your help!
> 
> Is it a general rule to send a fixing patch for the bug of a patch
> merged by tip tree?  Or a new version of the patch is acceptable too?

Depends on how recently it got merged. This one was merged a few weeks ago, 
and the fix patch is simple enough, so I went for that approach.

Thanks,

	Ingo
