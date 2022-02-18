Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615A84BAF59
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 02:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiBRB6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 20:58:54 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiBRB6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 20:58:51 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921381BBF62
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 17:58:36 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id v5-20020a17090a4ec500b001b8b702df57so11074865pjl.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 17:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZDSkUfp9toni5mt9GhqILhie8mR19f4SRKJDHSNLJMQ=;
        b=egfIW48oBvJ/rLtSDNSipUVlWRgNK8wpWktEAmc/Pz+571EuPH93FuvLqvVMByQ5db
         HxtZ13ltXoICHbkwOBttZaBYSeCuox2CL3P4RAqZvDgpbPpaFuIF8QcVfmp9p+Y4VQpc
         mzA0G2mDcmnDkdl51jrsYO9slg6f8xE9971Xjsbuy4/LKM55y/CrCEgq2tbneTD/xBeK
         3lC2cASpiz/4y7xNjRZljYqX0sfxnLI5TUGW/8WBeVgqCZoMhU1ieMHZSNWxYpx/+TzN
         St8Bj0xwfe32lJ1e+goTg/5mMQlIuZ4oZj8OJMq3iXzKrs2n9g7/mu280HPU3j2r6lV5
         0Yaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZDSkUfp9toni5mt9GhqILhie8mR19f4SRKJDHSNLJMQ=;
        b=H60m1F2gDCIlce07chtx0tTYMn//IXBi6bU15nkXoNafAZij6/DYVcJK/q9eXjtM/b
         FotCm75ms2cE1qS4COlo/fubH2F5OOeOD6q2m5Hoi8D8dSScJtfg6+xwWaOZ5O0Mq/G8
         pupIy0Q5P1V2oU1Ctn6vE1Fdg8Ojh9rN9aM7XNBOEe4NGP3yho56TfiSivUNBx1mpQdI
         FcdpwnxocYJ3PkmA7cLT0hYZw/Mtjidchf6vTMKPeZEnVyHKww1y+8lXdBXNA5eTcKqY
         CaxXnqZMlZnjjtfb9mE3PAr5XHeKc++4AdMPanCBJ3zDgydj4CW5VbsJHPzOY0X21+Pj
         4Yqg==
X-Gm-Message-State: AOAM532jZI84kTWx+yNfR5tK88cuC2mOwzc+3br5+A4xW/D/0gFrsD91
        U+kyTkVLi6j4EYgCTNRB5daHfQ==
X-Google-Smtp-Source: ABdhPJy2k7pnPPA0dR19XFlkrV9I2LgB9Fmjp0AzFRXaw08FvPFHy9T2UllkCBD/Je9vr200hAGEwA==
X-Received: by 2002:a17:90b:250f:b0:1b8:f257:c39 with SMTP id ns15-20020a17090b250f00b001b8f2570c39mr5924833pjb.135.1645149515932;
        Thu, 17 Feb 2022 17:58:35 -0800 (PST)
Received: from leoy-ThinkPad-X240s (104.225.159.78.16clouds.com. [104.225.159.78])
        by smtp.gmail.com with ESMTPSA id t15sm8956290pgu.13.2022.02.17.17.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 17:58:35 -0800 (PST)
Date:   Fri, 18 Feb 2022 09:58:28 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Marco Elver <elver@google.com>
Cc:     John Garry <john.garry@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        jolsa@kernel.org, namhyung@kernel.org, dvyukov@google.com,
        will@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux@armlinux.org.uk, irogers@google.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: Re: [PATCH] perf test: Skip Sigtrap test for arm+aarch64
Message-ID: <20220218015828.GA925833@leoy-ThinkPad-X240s>
References: <1645114959-119064-1-git-send-email-john.garry@huawei.com>
 <CANpmjNOO6yxF+xXoatR==uvSaEwsWyZ=n7ExEM_=OJaDYBCeSw@mail.gmail.com>
 <f7782f09-7f12-b957-a1b2-d0673ec1304c@huawei.com>
 <CANpmjNOO-fsU7PP_PqeT53_N=xmNruiT3mvE0e1y=EtKJUfFGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNOO-fsU7PP_PqeT53_N=xmNruiT3mvE0e1y=EtKJUfFGg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 06:40:45PM +0100, Marco Elver wrote:
> On Thu, 17 Feb 2022 at 18:34, John Garry <john.garry@huawei.com> wrote:
> [...]
> > >> -#if defined(__powerpc__) || defined(__s390x__)
> > >> +#if defined(__powerpc__) || defined(__s390x__) || \
> > >> +       defined(__arm__) || defined(__aarch64__)
> > >>   #define BP_ACCOUNT_IS_SUPPORTED 0
> > >>   #else
> > >>   #define BP_ACCOUNT_IS_SUPPORTED 1
> > >
> > > This is now equivalent to BP_SIGNAL_IS_SUPPORTED
> > > tools/perf/tests/tests.h -- and different from the original
> > > BP_ACCOUNT_IS_SUPPORTED (and makes me wonder why
> > > BP_SIGNAL_IS_SUPPORTED wasn't just used from the beginning). Perhaps
> > > just use BP_SIGNAL_IS_SUPPORTED.
> > >
> >
> > We currently have BP_ACCOUNT_IS_SUPPORTED defined now in 2x locations:
> >
> > tests/sigtrap.c
> > tests/bp_account.c
> >
> > bp_account works for arm64, and we don't want to skip that test. So, as
> > long as the macro meaning is appropriate, we can reuse
> > BP_SIGNAL_IS_SUPPORTED for sigtrap.c
> 
> BP_ACCOUNT seems to say something about the "breakpoint accounting /
> measuring" test. BP_SIGNAL is about the tests that want to use
> breakpoints to generate signals.

More general speaking, I think "BP_ACCOUNT_IS_SUPPORTED = 1" means an
architecture can support breakpoint with perf_event.

"BP_SIGNAL_IS_SUPPORTED = 1" means an architecture can support
breakpoint to generate signals with using perf_event.  So
"BP_SIGNAL_IS_SUPPORTED = 1" is subset of "BP_ACCOUNT_IS_SUPPORTED = 1".

> So it's very much appropriate to use BP_SIGNAL here if, as we have
> discovered regardless how they're generated in response to
> breakpoints, are broken on arm/arm64. On the day arm/arm64 decides to
> fix signals, I'm assuming all tests being skipped with
> BP_SIGNAL_IS_SUPPORTED can be re-enabled (or so we hope).

Yeah, I agree that BP_SIGNAL_IS_SUPPORTED is better choice for sigtrap.c.

Thanks,
Leo
