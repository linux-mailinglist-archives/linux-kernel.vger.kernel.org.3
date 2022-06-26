Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8355855B414
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 22:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbiFZUzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 16:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiFZUzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 16:55:51 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32612DF3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 13:55:50 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id mf9so15243582ejb.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 13:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OJgI0r/OP80N9dcPFjCLZLQisBcOF18myzMX4U+o7vY=;
        b=TqtTYTG1IxT0ubMo+gmUVYoa8uQ/KV90cCN6x8dihdGcq4c4m3JhdQfBdZiaB9c38W
         6ji4Xh3GrVCWwS6EUkhuhilYtLLJeOl0H/BCci+5nOlRTRLdjU2PimbT5UY2ArhRfFpA
         JTbUB7StCoA9mrGxGCHyGp85ujKOBB0yR1XPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OJgI0r/OP80N9dcPFjCLZLQisBcOF18myzMX4U+o7vY=;
        b=GvOM8ISbMY7UtGuaw8tyqJ6X9NwHd823mOZ1FfPBT/bjGKnP/SG2+BZuikQOghrrsr
         I5ejI21z7gUoP3/WDgSrCNCP7SCZzzalBQIep8WBh4VT43rNPACsS6VGUzRlDdlaUR2B
         f4W77JhgBIx3PVMgrs4wlBjcivWQiawDOLTLXquhhAKVYb0ZLRkqm0o8xbLs6YZXaYup
         /4w50KQ73yskI3CLZGgp+08vLuWkKzgH99a4MEqknlTTTZW2V2NkWy24OOMFYkUyQi9y
         lHfjVQ8occmVFoshSN+ljleXapyMgrchlxpZTaf6fapGdXQZ+MD/UvqP6CS8y7bEJUzJ
         Ekkg==
X-Gm-Message-State: AJIora9AwWCX/DuR9q6cGiRKx4kC3S1suvIBkW94aLe+DoOO24KbkMCF
        +vau/mJ7oIw67AwIRcHkUQ3zSDUjz6yzaaEx
X-Google-Smtp-Source: AGRyM1t/+0EU5SzPDp4T9EaQt3rFHxLf1hNsJuJ2Q0kpYhW0f8FMvH0xouQ9/YjoCjBsniPq1rXFcQ==
X-Received: by 2002:a17:906:9f0c:b0:712:1b55:37e1 with SMTP id fy12-20020a1709069f0c00b007121b5537e1mr9604827ejc.69.1656276949132;
        Sun, 26 Jun 2022 13:55:49 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id l2-20020a170906078200b006fe89cafc42sm4192435ejc.172.2022.06.26.13.55.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 13:55:47 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id w17so10367681wrg.7
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 13:55:46 -0700 (PDT)
X-Received: by 2002:a05:6000:1f8d:b0:21b:aaec:ebae with SMTP id
 bw13-20020a0560001f8d00b0021baaecebaemr9680616wrb.274.1656276946496; Sun, 26
 Jun 2022 13:55:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiC7rj1o7vTnYUPfD7YxAu09MZiZbahHqvLm9+Cgg1dFw@mail.gmail.com>
 <874k0863x8.fsf@email.froward.int.ebiederm.org> <CAHk-=wgTG2K3erROP19320zBN6BHVf0hRfXGdawkGR4gzrJN6w@mail.gmail.com>
 <CAHk-=whLsaRKaFKS0UffeCYYCVyP0bbiB4BTYTaXtScgu6R9yA@mail.gmail.com>
 <87pmiw1fy6.fsf@email.froward.int.ebiederm.org> <CAHk-=wiutNT47oNhyk_WvMj2qp4pehYFptXCUzW=u_2STLQiww@mail.gmail.com>
 <CAHk-=whX_=BNZ4kVEAu2NV3CMnhwsuYTyE65FQXUMx8VPNOAOA@mail.gmail.com>
 <87ilonuti2.fsf_-_@email.froward.int.ebiederm.org> <871qvbutex.fsf_-_@email.froward.int.ebiederm.org>
 <CAHk-=wg9eqtrpYrjJ=yobkwkTimWFtiDd_JOfADttG0fyAJrqg@mail.gmail.com> <YrjAJN7dDJ9R7Ocu@mtj.duckdns.org>
In-Reply-To: <YrjAJN7dDJ9R7Ocu@mtj.duckdns.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 26 Jun 2022 13:55:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgNxL17-bsKM8qcrK+mGSpgeBVkWu00pQgnypOOgqTF9Q@mail.gmail.com>
Message-ID: <CAHk-=wgNxL17-bsKM8qcrK+mGSpgeBVkWu00pQgnypOOgqTF9Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] kthread: Stop abusing TASK_UNINTERRUPTIBLE (INCOMPLETE)
To:     Tejun Heo <tj@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <brauner@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
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

On Sun, Jun 26, 2022 at 1:23 PM Tejun Heo <tj@kernel.org> wrote:
>
> Would it be a reasonable tradeoff to have a kthread wrapper -
> kthread_start() or whatever - which ensures that it is actually called
> once on a new task? That way, we can keep the init code inline and
> bugs on both sides (not starting and starting incorrectly) are
> obvious.

Yeah, that sounds reasonable to me.

                Linus
