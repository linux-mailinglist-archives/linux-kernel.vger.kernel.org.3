Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D6357A520
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 19:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238994AbiGSRXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 13:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236334AbiGSRXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 13:23:41 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FAE3193C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 10:23:40 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id s18-20020a17090aa11200b001f1e9e2438cso3669664pjp.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 10:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bAiLUuK8Bq5hIETk8lqqf2Q67ovEHYEybgII//G+Ou0=;
        b=NaLJNnDwqstqWtZI50GxaooyDe4DrPodHzy9M38TEXRLTpqb3+Y34EoxYEhxs24wzt
         gES+yG0Yrutr0+AGM45Oxj1wM1w5drz1TsYOXAX0Ipezii4TEAU3B+cTpswF5jnwcoLn
         mwZROAX0SLKvSpKAiZfHJmm0/5korON8LxWGO3/306tfVrp6CLSjbs5hL+cHeASYglbV
         1nup0P6kUY9Yd2rDTl3f9xpM5/ovyJG6wvaJ5c8FywS1OY+7R0o4YSvVZXJUhiWzAMUw
         i/TonRWPv0mg658yqQNpGSQu/bdzBCXrBd+a9KUdemiJCRk+Ij4LxFZLMhpQKxG7qVxk
         yqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bAiLUuK8Bq5hIETk8lqqf2Q67ovEHYEybgII//G+Ou0=;
        b=tKqAW1XyqcJjqmnlgLeAVzwK6BSB76QvAXJlBOjdS4k6f7Zc0hZsB4nbDOL618Rk2m
         OA2c1lE48juyk0NYUwHnCm730/SlCfuTrAHEyhH08Ry+Q70U961au71Qbh5WBA/WayPd
         ajZc702iXrPGcrCvM+Fk9b+URSeOByIodnrFN+aZifWm8vXS62PW8b2tieK/QfXk2qoY
         IHqdm57yPU+KZZTrCvz0Xr67EK7sfmf8DIq/Z4cHWhKg1WQWCPtOJ6OOx9VV1AuyXGwI
         KbNNRKZ1BK4cRDZkMb1Ncm0abFxWI/BVDAcK/2O/9E55FleXtc8foIQqXzd4gsFwSs5G
         iQoA==
X-Gm-Message-State: AJIora+RPdobNVMicSz8W/rDYmpBM++Jl+1Q5NvbhUgtJzJv6Jyd1YC1
        mCpCEDNKxTYzSCz0Zo3weaJjnhmxN9TB21+9
X-Google-Smtp-Source: AGRyM1uRIgn3gm8Adb0xUkAJIs49+RQOE8/lS+LG2QSrglQnMTgydW+VzS6kfrU+0p9y4dhx1xEsEg==
X-Received: by 2002:a17:90b:3807:b0:1f0:a86:6875 with SMTP id mq7-20020a17090b380700b001f00a866875mr409039pjb.103.1658251419481;
        Tue, 19 Jul 2022 10:23:39 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:893a:f024:99b0:7299])
        by smtp.gmail.com with ESMTPSA id j14-20020a170903024e00b0016a33177d3csm12035839plh.160.2022.07.19.10.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 10:23:39 -0700 (PDT)
Date:   Tue, 19 Jul 2022 10:23:32 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Laight <David.Laight@aculab.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joao Moreira <joao@overdrivepizza.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Cooper, Andrew" <andrew.cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "Nuzman, Joseph" <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Gross, Jurgen" <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Collingbourne <pcc@google.com>
Subject: Re: [patch 00/38] x86/retbleed: Call depth tracking mitigation
Message-ID: <YtbolH9YegJWUmHT@google.com>
References: <YtXOMPpmx8TcFtOX@worktop.programming.kicks-ass.net>
 <87lesqukm5.ffs@tglx>
 <2f7f899cb75b79b08b0662ff4d2cb877@overdrivepizza.com>
 <CABCJKudvSv9bAOrDLHki5XPYNJK6=PS-x8v=E08es8w4LJpxBw@mail.gmail.com>
 <87fsiyuhyz.ffs@tglx>
 <CAHk-=wjEDJ4+xg0CWR7CaCKnO6Nhzn+vjJy7CjaVmf9R+g_3ag@mail.gmail.com>
 <CAHk-=wj6U3UamfLLV+rPu1WmKG_w3p0Bg=YbQcG1DxHpmP40Ag@mail.gmail.com>
 <CAHk-=wiYHXeWnF8Ea5xb735ehJ8FbjTT6UCvHYjX=Ooc7Z5sOw@mail.gmail.com>
 <0e038c2795784b7eb4de52f77b67206a@AcuMS.aculab.com>
 <CAHk-=whycTCSPwqV53ybUX=fDKMDk_Y8JaLug3KfUSiMF2TOQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whycTCSPwqV53ybUX=fDKMDk_Y8JaLug3KfUSiMF2TOQg@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 09:27:02AM -0700, Linus Torvalds wrote:
> On Tue, Jul 19, 2022 at 1:26 AM David Laight <David.Laight@aculab.com> wrote:
> >
> > Shouldn't it be testing the value the caller supplied?
> 
> Actually, I'm just all confused.
> 
> All that verification code is *in* the caller, before the call - to
> verify that the target looks fine.
> 
> I think I was confused by the hash thunk above the function also being
> generated with a "cmpl $hash". And I don't even know why that is, and
> why it wasn't just the bare constant.

The preamble hash is encoded into an instruction just to avoid special
casing objtool, which would otherwise get confused about the random
bytes. On arm64, we just emit a bare constant before the function.

Sami
