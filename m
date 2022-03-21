Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D334E2F68
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 18:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349660AbiCURxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 13:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234522AbiCURxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 13:53:30 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398BBD95F5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 10:52:04 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id o6so20963827ljp.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 10:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3BE6bYGLCLJdnmSIk/pG3ylIgMiIXOfw1b4Ed4FiK8c=;
        b=buzFfFr6Infssq4+DIvB7vF8ftWwjtXcRjRRImI1I+isJ2p/iWAuP1P8oA6xTL9LDA
         xybA81Ra66wwoiBSZa5lQ9uzHK1H2LTslQP7gntsAUUAPdlJMwd8iEurdFu29DhIfvrj
         qIoxeOy7mCnC2yojqhdQh2HSUVCmpaMbz0d5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3BE6bYGLCLJdnmSIk/pG3ylIgMiIXOfw1b4Ed4FiK8c=;
        b=Gz9bQ00yrijjdxfsnDJmaRW7Si5A066N8riwhkgehpODPZZ49ER2wEHyU4NnARKlnY
         i9LR5WmG6nDlq0hmUk8tKI+F7ZoPLEmCHhRJfZF9cqNWmu9ctjYXYOPOqe3GtD21Fnn3
         SBmN2kifwCXplv7W6P+R58eb5x/1gEp80Xsao0ZiFe+i/evdZklbWGl98KF+uh9gewXP
         tnSJ8Vt5NIFU+PIe/HC6T9UREd2hpqiLaCairZxOFiq318YvfrdfQLfUkyi+keZmxxWf
         YezmyVy1fFYA5S681xcTYtj1C6piGV7/3Chr/X+ViSlaqO3sdbDGD3gGaNai2U7cdW22
         4bRw==
X-Gm-Message-State: AOAM533k3y+xqLAEO9NQxjeGbbEzcydTllVUFKIpu8E05Wm6KlJx1r0S
        x5OHbX4emdHEnBI4ivGTc4ikRmG6wpcW9PxkyGk=
X-Google-Smtp-Source: ABdhPJwqW+3MyhcyRy0DTp0aPLsgrtftGd/ZXd46BVcZ9c+71xwwFamCL2w8/QGIXzdLVV5MkRknLA==
X-Received: by 2002:a2e:9847:0:b0:244:bbdf:8f72 with SMTP id e7-20020a2e9847000000b00244bbdf8f72mr16393331ljj.69.1647885121282;
        Mon, 21 Mar 2022 10:52:01 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id o7-20020ac24c47000000b0044a15c4e0aesm892479lfk.272.2022.03.21.10.51.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 10:51:59 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id q14so7650368ljc.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 10:51:59 -0700 (PDT)
X-Received: by 2002:a2e:a78f:0:b0:249:21ce:6d53 with SMTP id
 c15-20020a2ea78f000000b0024921ce6d53mr16416072ljf.164.1647885119192; Mon, 21
 Mar 2022 10:51:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220314220726.GA5585@willie-the-truck>
In-Reply-To: <20220314220726.GA5585@willie-the-truck>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Mar 2022 10:51:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wibMfM6-D7t6ZG5fPDbGXW5hi_pyDix=RAKJCu4rBtQCA@mail.gmail.com>
Message-ID: <CAHk-=wibMfM6-D7t6ZG5fPDbGXW5hi_pyDix=RAKJCu4rBtQCA@mail.gmail.com>
Subject: Re: [GIT PULL] arm64 updates for 5.18
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Marc Zyngier <maz@kernel.org>
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

On Mon, Mar 14, 2022 at 3:07 PM Will Deacon <will@kernel.org> wrote:
>
> I'm off for the rest of the week, so here is an early pull containing
> the arm64 changes for 5.18. Summary in the tag, but there are some other
> points worthy of note:

Thanks, I just wanted to say that I appreciate that you explain the
weirder parts of your pull request. Very thoughtful,

             Linus
