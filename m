Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3685150D457
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 21:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237415AbiDXTDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 15:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237392AbiDXTDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 15:03:11 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CB06339
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 12:00:09 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id z18so5602739lfu.9
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 12:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zla2zVKXSR9tXq7fUNDfoz9ZW2bLv1gELl/OWlC1KGI=;
        b=W7j2Ucv5G/jsL5ekGRTlHbi3/4qFCgNeMCUDvPxHuh5xPAmExx9eqX+y5xC1w0yQ0p
         iuzRsqeyycxHAAcPRjZ1Er03RJxqL2iGcX7ojo4h8VYLVBw7hZVkudVgC8xOREDKMfnF
         ayW3Y+u7EQoEVAOIPx9gwoKvFAIFb3drU4e9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zla2zVKXSR9tXq7fUNDfoz9ZW2bLv1gELl/OWlC1KGI=;
        b=rmh2mUSUFPj+goHZTdpPlZ8sZ4ggPgaTuAmBao6biNAtIh7pHA9aA/DbERaGR79nKg
         bQgQ27XwR0M0Ii1ABKnPsasg3wuIGzUMBcJYUvwrUOJhSnvWFaU1uSzLKE2Ze4UQKCgU
         RhP9H1WWbaiutPqOWmxM89oWP79VLk9J4z8bHsZslFAdU+ElA3FGE/VaJ/cspso64Jbq
         fobCIiUWRInQh7e8VJyXXgdR9CXH+IEhI1ufPX7PWcNP4KSKrG9MgJiRj4qImPeWYt55
         YvImwz8bcdbJF4jTsndcRmLwPf37lvUF/JODEG/2PDmrtcsUO77Qm7ySIw2C03AMaSwZ
         2nTw==
X-Gm-Message-State: AOAM532cNv+aiRCgJ/hMeaxcCXi14WCOeHBPcsrfc3IikVw9RccQHsdO
        RQZ3CsJqgZiIsBU7cWUBWtENZR9gx7ee2PVo
X-Google-Smtp-Source: ABdhPJwstemhjGFbK22jRuc5BiPlpNmmcmjCNT8X6/WeraQVLjEQwRaLgZ3BKpm6aCGTnm7Md8bItg==
X-Received: by 2002:a05:6512:12d4:b0:471:c36c:e42a with SMTP id p20-20020a05651212d400b00471c36ce42amr10299621lfg.39.1650826807358;
        Sun, 24 Apr 2022 12:00:07 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id t7-20020a199107000000b00471d641e8d6sm1106151lfd.281.2022.04.24.12.00.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Apr 2022 12:00:06 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id y19so4159720ljd.4
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 12:00:06 -0700 (PDT)
X-Received: by 2002:a2e:b8cb:0:b0:24f:fa2:5496 with SMTP id
 s11-20020a2eb8cb000000b0024f0fa25496mr1780696ljp.176.1650826805713; Sun, 24
 Apr 2022 12:00:05 -0700 (PDT)
MIME-Version: 1.0
References: <YmUekOVjdFIi3FBw@zn.tnic>
In-Reply-To: <YmUekOVjdFIi3FBw@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 24 Apr 2022 11:59:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjccVKAcK7JmpPpOrqR3fXrfza6dCbCLr9BmTyTasJ2GA@mail.gmail.com>
Message-ID: <CAHk-=wjccVKAcK7JmpPpOrqR3fXrfza6dCbCLr9BmTyTasJ2GA@mail.gmail.com>
Subject: Re: [GIT PULL] sched/urgent for 5.18-rc4
To:     Borislav Petkov <bp@suse.de>, kuyo chang <kuyo.chang@mediatek.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2022 at 2:55 AM Borislav Petkov <bp@suse.de> wrote:
>
> - Fix a corner case when calculating sched runqueue variables

This worries me.

It now does:

+       if (se_weight(se) < se->avg.load_sum)
+               se->avg.load_sum = div_u64(se->avg.load_sum, se_weight(se));

and at no point does it check if se_weight(se) is zero.

It *used* to check for that divide-by-zero issue, so from what I can
tell, a zero se_weight() is actually possible.

Now, it's entirely possible that no, se_weight() can never go down to
zero. But it's not obvious,. and the commit message doesn't mention
this change at all.

So I pulled, but then after looking at it I unpulled again in the
hopes that somebody will clarify the issue for me.

And scale_load_down() (in se_weight()) does try to make the result be
at least 2 on 64-bit, but only if the original wasn't zero. Very
confusing.

So can somebody please tell me why se_weight() cannot be 0, and why we
_used_ to check for zero? Because that commit sure as heck doesn't
explain it.

And - as usual with the -tip tree - the "Link:" thing is almost
entirely pointless. It doesn't actually point to any discussion of the
problems, it only points to the patch submission.

I realize that is convenient for automation, but it's really not
generally a very useful link. It would be much more useful to link to
whatever problem report that actually *causes* the submission, not to
the submission itself. We already see the end result in the commit,
it's the "how did we get here" that is the most interesting part.

And no, I don't see any explanation for "why se_weight() cannot be
zero" in that submission thread either.

Somebody please hit me over the head with a clue bat.

                 Linus
