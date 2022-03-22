Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2384E496C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 23:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238669AbiCVXAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 19:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbiCVXAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 19:00:36 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5DB5F4D7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 15:59:07 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id bn33so25977328ljb.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 15:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pqP04qIKJnHF0DNSAx4RwsPe+k0JAKx/+uvdmrcHoYQ=;
        b=eOh5HFeqMAFa3uRc4BnUxUY/rEnmvLMhibsB5fiJhHmTyn81E2hTS7FyP9WGSdc7qN
         13PO6tAUbJSh6igUH1m2oK68kS2szKvHCSi6Zw4TcUZ9+ORQDJ9BxlNFRN3AY4JYtbNN
         0PN00ifuVXdjyG+1T/u48Mc9FLjzdcuYsRDEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pqP04qIKJnHF0DNSAx4RwsPe+k0JAKx/+uvdmrcHoYQ=;
        b=Ch9JW6odGjkTgzQaRW3+aLf1wybnbt+oJDPL9m+yGH25YU/qCz2CSyT2vmF8eh/tBo
         0SEf3RTswIAxStuMAn+M5Dhb9hyWp3Ksc8xQ1Mubc0+rQ4iimeW4AlJS8qlBRlH9doJz
         bcOKYEzIbi1wSF1VxlelsN1XQeVMYmQ/mMa/YFFwiAaH/lwbB0jA7h8TLV6VM6Xb04Y6
         9QNUHoc827WGeIRnLIEgmWA6iKDo8TMkMSFkU1NdS95v0Qq5Sv+GFrDJmIofyGbgfVwY
         94CPtldzjY7Spb+DCJcoKXB/TPNBeaDFPlh6lCCGDKc5ZNX7Phd726LxKeN6k6EjpONg
         lf9g==
X-Gm-Message-State: AOAM532U2xRGTNOS9Xl8wWbP7WUobMypybYIDoiUUd+qGxXonLVK3CXP
        W7jC0wMpmwbSDd3li168D/XFtNlT7ida6G9l28U=
X-Google-Smtp-Source: ABdhPJxzGI1JmJmHlxSWjramxL4E1Ap4qYo+mOJLJNJQXgfeP21yqbgDY4fjmxt6HblWEbkRa1FNFQ==
X-Received: by 2002:a2e:740e:0:b0:244:c716:159b with SMTP id p14-20020a2e740e000000b00244c716159bmr20779762ljc.95.1647989945401;
        Tue, 22 Mar 2022 15:59:05 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id v21-20020a2e5055000000b00249605be289sm2347608ljd.96.2022.03.22.15.59.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 15:59:04 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id k21so15749799lfe.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 15:59:04 -0700 (PDT)
X-Received: by 2002:a19:e048:0:b0:448:2caa:7ed2 with SMTP id
 g8-20020a19e048000000b004482caa7ed2mr20131891lfj.449.1647989943834; Tue, 22
 Mar 2022 15:59:03 -0700 (PDT)
MIME-Version: 1.0
References: <YjhdcJB4FaLfsoyO@gmail.com> <CAHk-=wjS6ptr5=JqmmyEb_qTjDz_68+S=h1o1bL1fEyArVOymA@mail.gmail.com>
 <YjpLiKRUIB4TGJm0@zn.tnic>
In-Reply-To: <YjpLiKRUIB4TGJm0@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 22 Mar 2022 15:58:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wifoM9VOp-55OZCRcO9MnqQ109UTuCiXeZ-eyX_JcNVGg@mail.gmail.com>
Message-ID: <CAHk-=wifoM9VOp-55OZCRcO9MnqQ109UTuCiXeZ-eyX_JcNVGg@mail.gmail.com>
Subject: Re: [GIT PULL] locking changes for v5.18
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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

On Tue, Mar 22, 2022 at 3:20 PM Borislav Petkov <bp@alien8.de> wrote:
>
> Ah, you say build error because you have CONFIG_WERROR=y.

EVERYBODY should have CONFIG_WERROR=y on at least x86-64 and other
serious architectures, unless you have some completely random
experimental (and broken) compiler.

New compiler warnings are not acceptable.

             Linus
