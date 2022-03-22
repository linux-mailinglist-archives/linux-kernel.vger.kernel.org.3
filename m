Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D184E35DB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 02:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbiCVBJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 21:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234503AbiCVBJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 21:09:51 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8752C326E3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 18:08:24 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id e16so13148041lfc.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 18:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o7yH1N6bykKRjzWg6oyTeuwepWWp/goED5PPpUMzQ9E=;
        b=WrQCEtaAcmLw7HHta3xhGEwyQLWBmp7QkoBHN0zxhkKlObDo9AVKeWaj2VrWYQATCP
         qgCaDokY76AeSSD4JJJmK2u0JL9NXvM6Gx0r/lp7V3w8n75xIE3UUdHUhGVamCHg9Bi0
         LshiXVFb1y2ae8HAaqoxkFqLoawZKQw3F9IcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o7yH1N6bykKRjzWg6oyTeuwepWWp/goED5PPpUMzQ9E=;
        b=hFLGUrL5EF9qvyLVEBSG0rEMGmda0kaV0cYQQgOP0BApdFMIXJDY7olSpQGtNl054y
         4CppmPtTfRSQ8OD5Rfah0Lzs9K7llYSOL2dAHeVMrLdH7Pu2JHPxQ4ijfkcjLTLakgTk
         CJuUi89sflsYAR+CmgL8pUP/TsH3Tk/hfdv+Z/R/h6lrdxHZjgmcWW3bPI74ltqvluZk
         HSv/nwoN+iL4++52b2n6j3metwIb0uqsXCxvF4JA9IGUEgVwSe9IDow7SwJF0hC3XPx5
         DpxkvyKW2Pzf3gbrLqwSwPe0RFnF+Yiy0QwKXu0gmuf04/hF1n7g67JUA+x8eexCH7OI
         EFEQ==
X-Gm-Message-State: AOAM533dSwfRhe1ENOvhJxBBR6YjcZu7wWnZ/qz+vbkCr/B63KRT6TkH
        8QbLShU1z9fMvUciBnw9Xqlq9QBqY6Tb7tTyo5k=
X-Google-Smtp-Source: ABdhPJx70ATw6JfrRwWfaFoynB+eXZ/Btpvblp86MEzLZZ0skSa3P+ia5u80pTRx+184lB+mOKtyjQ==
X-Received: by 2002:a05:6512:2294:b0:448:6c86:3c78 with SMTP id f20-20020a056512229400b004486c863c78mr15899751lfu.531.1647911302322;
        Mon, 21 Mar 2022 18:08:22 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id o15-20020a2e730f000000b00247eae1ebe7sm2275155ljc.75.2022.03.21.18.08.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 18:08:21 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 5so9164448lfp.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 18:08:21 -0700 (PDT)
X-Received: by 2002:ac2:4f92:0:b0:448:7eab:c004 with SMTP id
 z18-20020ac24f92000000b004487eabc004mr16180797lfs.27.1647911300965; Mon, 21
 Mar 2022 18:08:20 -0700 (PDT)
MIME-Version: 1.0
References: <YjhZUezhnamHAl0H@gmail.com> <Yjh58h8cpcPERVZA@qian>
 <CAHk-=whrqeX-8yHEdSCGFUyyC2sj=OLyeFR9civUiswR=A+PwA@mail.gmail.com> <875yo6ajsa.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <875yo6ajsa.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Mar 2022 18:08:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjSR0xJOdkEDcJ6pGHMOLupghu-ZNUHSuUa5ET_nGaZOQ@mail.gmail.com>
Message-ID: <CAHk-=wjSR0xJOdkEDcJ6pGHMOLupghu-ZNUHSuUa5ET_nGaZOQ@mail.gmail.com>
Subject: Re: [GIT PULL] scheduler updates for v5.18
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Qian Cai <quic_qiancai@quicinc.com>,
        Ingo Molnar <mingo@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 5:54 PM Huang, Ying <ying.huang@intel.com> wrote:
>
> >
> > Ok, dropped from my queue. Thanks,
>
> Can you just drop the last one, that is,
>
>   sched/numa: Avoid migrating task to CPU-less node

I will need a new pull request - that commit isn't actually the last
in there, so it's not just a "do a pull but don't take the last
commit" (which I've done once or twice, but it also loses the tag
signature in the process).

                     Linus
