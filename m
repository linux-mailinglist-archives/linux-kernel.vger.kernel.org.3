Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9E04E39BF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 08:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiCVHmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 03:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbiCVHls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 03:41:48 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AD936339
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 00:35:16 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id bi12so34398685ejb.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 00:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FbnaYhRpXdbMvHzD7Q9oaWu58ozq+IP6nJU3yVjsu04=;
        b=fHr0SqWeMLwcA4n+KEzr8WaEy+8DoRiENHZ1U/KbTJnX9orgay3CTyZZwe9q4uSGM6
         RWxiP/sJxeLFKdXowD+2Vt2+a/5HyMprVn7RZz+iAO5KK+/F8tDxFKi+fAzEi5avOjAt
         lz0hEJAdV0yWR8ZntN/nBXlcril/I0Xs5lLHtWvEPKbE5gtODjsB25vFPACtI8f7CzCf
         /IY9KHJjeEwiKfOYCkW5FrxpaOIMj7cbWX+z/aHZZPvjXs+4cf2u+JyNoVCJL1xcVKQh
         Yw9vjmRujL58xpJ/GchYnDN7QsxraH/HctE7v494F7d3s9a4M6YUJzSikgmtPTDitx6O
         PRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=FbnaYhRpXdbMvHzD7Q9oaWu58ozq+IP6nJU3yVjsu04=;
        b=4onpWau8VNDkYGyvNSmGRcrUzoHjSi2fMMN7ocdoy6qybNMeRVH4XuY763xVyu3uk1
         2bH2fDiujOFtyMJGFTIKmLbKOPVPRki1foDSHBORm+hUbvCwWSf8EkeSw7kSwIxNMmaz
         S/Uhs/IIrjof7GKFPJDA9u26345T5sQ/pwH1Vz1HnkKaWcJfVUsqnIP4oH/rpPHSBKob
         6B0w8LRPsOQ+MYjMBIzhut5Vg5jw5nLiSpsLAQoZiITuoe33fTlvzmoBZDJQlmNash//
         gg3ZdprIsQpvV8NpAMdi1kt0A4IQcLRgxe1RJ+tyhtivStjGFEjl0UlSohhSjK8NxhKs
         3Y/A==
X-Gm-Message-State: AOAM533MLJv3C2QMrhHevHzN82eaLqNGRB2Hr7f5NsGWzhJw2OMPOUSB
        CSPxxqXACX5p9k/+yuwO2u0=
X-Google-Smtp-Source: ABdhPJwV9IRcbjSkzVj6Q6c27oK+Z+OCttRSkMiMkZDz+08rijECoFYul5WjEvTlicxzlddVs2Pcyg==
X-Received: by 2002:a17:906:2a50:b0:6da:ed06:b029 with SMTP id k16-20020a1709062a5000b006daed06b029mr24071754eje.506.1647934514572;
        Tue, 22 Mar 2022 00:35:14 -0700 (PDT)
Received: from gmail.com (0526ECD0.dsl.pool.telekom.hu. [5.38.236.208])
        by smtp.gmail.com with ESMTPSA id g1-20020a056402424100b00416c6cbfa4csm8912624edb.54.2022.03.22.00.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 00:35:13 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 22 Mar 2022 08:35:10 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Qian Cai <quic_qiancai@quicinc.com>,
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
        Thomas Gleixner <tglx@linutronix.de>,
        "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [GIT PULL] scheduler updates for v5.18
Message-ID: <Yjl8Lk2uPiZkXoM9@gmail.com>
References: <YjhZUezhnamHAl0H@gmail.com>
 <Yjh58h8cpcPERVZA@qian>
 <CAHk-=whrqeX-8yHEdSCGFUyyC2sj=OLyeFR9civUiswR=A+PwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whrqeX-8yHEdSCGFUyyC2sj=OLyeFR9civUiswR=A+PwA@mail.gmail.com>
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


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, Mar 21, 2022 at 6:13 AM Qian Cai <quic_qiancai@quicinc.com> wrote:
> >
> > On Mon, Mar 21, 2022 at 11:54:09AM +0100, Ingo Molnar wrote:
> > > Huang Ying (3):
> > >       sched/numa-balancing: Move some document to make it consistent with the code
> > >       sched/numa: Fix NUMA topology for systems with CPU-less nodes
> > >       sched/numa: Avoid migrating task to CPU-less node
> >
> > Linus, I don't think you want to merge this as-is. This will introduce a
> > kernel crash on arm64 NUMA as mentioned in this thread,
> 
> Ok, dropped from my queue. Thanks,

I've reverted the broken commit & will send another pull request after some 
testing. Sorry about that!

Thanks,

	Ingo
