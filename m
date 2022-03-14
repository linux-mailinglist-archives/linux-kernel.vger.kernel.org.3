Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E18A4D8E05
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 21:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244928AbiCNUSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 16:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237075AbiCNUSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 16:18:45 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909FD33EB4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 13:17:33 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id s25so23632403lji.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 13:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=llWQpUugVIez20+golvS85g3cCvwC31DD0QwwK3Qx28=;
        b=DkZTTgDSXMSP8ycn8g7aDVO7MMxXsfSAxTIeaYTtorLLanSxli2WnOx6QwAcxXK3NF
         DjAQXDoP0lfFrOsJ6MD3CHiG2wbXFclPK0VJxS+dFWsr6OJd6vtkNet+rH6UzNggFVPE
         KpMHTjuGBhE7vD1SxpFm2Q6UBy+aKunBko6AY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=llWQpUugVIez20+golvS85g3cCvwC31DD0QwwK3Qx28=;
        b=F+kmGP1fj9AEMBMBZzEQFq3v3YrMtZacr0pQGIg2XrL0VmDUSbQfn/nwNfNZfGJxaW
         Ti+YiA1djID4ZP4qVUxI68VIfFkt55C6aRGidf23ccqs7Zkvp+MOvEta9Ug5Z6Z5qP9K
         ebsJD9U6XzEIBDwZNneWplMXx28X91n7Mq5xPrfPmfbEpJ7eVnUBCmFNExj67LASdj/p
         alavE152n2z6BXC13+NVZBw2hbljDPOq5QZNTdIZL5dSWGzHr3n12u7pd1rxa5F5K2Dy
         qALuNSJ52c76GME00I8AQL5wiSoY9ObCVxhDK18mJHFtBFQm2QT8Y19fMUiCnclYOr01
         pXNw==
X-Gm-Message-State: AOAM531XkRJIjQoHMbV+5+RVyQEc5L6Y0aWaCl3C7dU2XEIA4jLbQrkZ
        2muNkEmyiUmkHMVPhJ3da06rwzGLYP7jQXhq
X-Google-Smtp-Source: ABdhPJxEm+p+aMFOtphVqGUs9KxlmrmQUnq3jId0k9EWM1oJx/qqL7o/So6OT81poc+t7R09W42Wpw==
X-Received: by 2002:a2e:9bc6:0:b0:246:440d:b273 with SMTP id w6-20020a2e9bc6000000b00246440db273mr15004685ljj.121.1647289050525;
        Mon, 14 Mar 2022 13:17:30 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id n5-20020a196f45000000b004487ff4c12esm1698815lfk.105.2022.03.14.13.17.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 13:17:29 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id bn33so23617123ljb.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 13:17:29 -0700 (PDT)
X-Received: by 2002:a05:651c:1213:b0:247:e2d9:cdda with SMTP id
 i19-20020a05651c121300b00247e2d9cddamr14977824lja.443.1647289049378; Mon, 14
 Mar 2022 13:17:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220314032823.GA2593360@paulmck-ThinkPad-P17-Gen-1> <20220314154857.GA2637810@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220314154857.GA2637810@paulmck-ThinkPad-P17-Gen-1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 14 Mar 2022 13:17:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjEVLfoypyZHwdLjh3vX_BSJO1JJBjha2XgcghSX=sdgw@mail.gmail.com>
Message-ID: <CAHk-=wjEVLfoypyZHwdLjh3vX_BSJO1JJBjha2XgcghSX=sdgw@mail.gmail.com>
Subject: Re: [GIT PULL] RCU changes for v5.18
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        rcu <rcu@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
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

On Mon, Mar 14, 2022 at 8:49 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> OK, I was apparently unable to distinguish v5.17-rc8 from v5.18 yesterday
> evening.  :-/
>
> I will resent both pull requests next week, and please accept my apologies
> for the bother.

"resent" and "resend" are very different ;)

Anyway, no bother - I just assumed this meant that you sent your pull
request for 5.18 early. Which is very much ok, and no bother at all.
In fact, if things are ready, early pull requests are generally good
things.

But since you resent them, I'll just archive this email (and the LKMM
one), and am now expecting a new set of pull requests that you don't
hate that much later..

               Linus
