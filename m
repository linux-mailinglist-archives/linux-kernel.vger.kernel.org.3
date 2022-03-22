Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2630D4E48DC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 23:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237377AbiCVWH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 18:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbiCVWH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 18:07:28 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459CD205D5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 15:06:00 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 17so25875999lji.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 15:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mo9nrzC4utr4Lj6m+SO58UKnHjjArzCtEgT1/nm/Ujg=;
        b=DdnoVd7jEU46qjxkbh+MEnUxjlamfuJPz2v96LhjPJDa0HhUdTuHgLFZ6Q0ogDvpcj
         TGS9jDr80wE5dk35U/9QUzvzSOnIL9sCItXsw2fcGQuJT+5Qb9HYboVucn/OU2X85GUi
         2VlBJAan5lew+LPH0nFNUHWUBcAv9kViOAEQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mo9nrzC4utr4Lj6m+SO58UKnHjjArzCtEgT1/nm/Ujg=;
        b=WlMGvy22DiGzpThF9NE4JxF36/CFvwek8m454wM7QGT2nCflUKGKn0oPkeMzBYPuJ/
         xvl4pJ1P1ZGz+yR40L4zWYpem9d5om+jzMp5SDgJmb5sasTwl+efaz4pmIgJ9NNCe5pg
         7/27HbZIiFJvVCyKU3M3wMXNS6B45Mzatvc+OAeFJemDAHwf/BYefUZqMkQ7bq+X/fhq
         n0EapDXvCD4WpmgcYEz8Xo57SVIK+5/BAri5LTmCwVU9n2RVFktUauievp8NrS7Jxlg4
         cPoXQbB6xku/shXXKfIRsy6Q6qmY4c2zIvixcVLgBvlrm9puioA+D5uonnScqcvihMZ8
         Vthg==
X-Gm-Message-State: AOAM5338a57Q2ATVI4tVJsxLuL7Wda7Ds58CNvLZDpnW7vph6EuweJ6X
        LlI8pIgG7M6GMP7UGFhN+viWh8q1pGaXPr6eqqo=
X-Google-Smtp-Source: ABdhPJz2LXm310UPPq8eVGbr1g8AVrYBbVLb+uWHBEYzYHH+7cumxqkt9TEzh6glLO+g7toQaNXWYg==
X-Received: by 2002:a05:651c:179c:b0:247:e1b4:92aa with SMTP id bn28-20020a05651c179c00b00247e1b492aamr21149641ljb.55.1647986758278;
        Tue, 22 Mar 2022 15:05:58 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id a8-20020a19ca08000000b0044a2d9a3ecasm759992lfg.155.2022.03.22.15.05.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 15:05:56 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id d5so12912092lfj.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 15:05:55 -0700 (PDT)
X-Received: by 2002:a05:6512:b13:b0:448:90c6:dc49 with SMTP id
 w19-20020a0565120b1300b0044890c6dc49mr20306532lfu.542.1647986755710; Tue, 22
 Mar 2022 15:05:55 -0700 (PDT)
MIME-Version: 1.0
References: <YjhdcJB4FaLfsoyO@gmail.com>
In-Reply-To: <YjhdcJB4FaLfsoyO@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 22 Mar 2022 15:05:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjS6ptr5=JqmmyEb_qTjDz_68+S=h1o1bL1fEyArVOymA@mail.gmail.com>
Message-ID: <CAHk-=wjS6ptr5=JqmmyEb_qTjDz_68+S=h1o1bL1fEyArVOymA@mail.gmail.com>
Subject: Re: [GIT PULL] locking changes for v5.18
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
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

On Mon, Mar 21, 2022 at 4:11 AM Ingo Molnar <mingo@kernel.org> wrote:
>
> Sebastian Andrzej Siewior (2):
>       locking/local_lock: Make the empty local_lock_*() function a macro.

Grr. I noticed this too late, but this one actually breaks the build with clang.

Why?

Because it's now a macro, it doesn't use the argument at all, and you get:

    mm/page_alloc.c:131:40: error: variable 'pagesets' is not needed
and will not be emitted [-Werror,-Wunneeded-internal-declaration]
    static DEFINE_PER_CPU(struct pagesets, pagesets) = {
                                           ^

and I'm not sure why this doesn't show up with gcc, but apparently gcc
only warns about unused static functions, not unused static data.

Or maybe gcc considers it used just because somebody did a typeof on it.

I thought -tip had started checking with clang, but apparently not.

I see that the -mm tree has a fix for this, but I'm rather unhappy
that the -tip tree build checking has deteriorated so much, and clang
builds will now have a pointless build error that will cause issues
for bisect.

                   LInus
