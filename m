Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008AA55B42C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 23:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbiFZVVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 17:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiFZVVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 17:21:07 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A222729
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 14:21:04 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id e40so10529608eda.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 14:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bbJojmI8xjJtQIB9zYw+MqLEwyRtrNfWto0156iR2fY=;
        b=KbSa/eU4a+soRfSbrfd0diz5c+o7BU66TeU7NXALVYrzjGRWCURXKgzIG/YJoEd5Wf
         W4FOvEe/PPZDjkcXA7gTBZjSZSa22Xgr+foAR6m3UIEu9dnP2RD1Nf1+GpoguXMshCsp
         63BMzSIWWCvb49d9F8mK5SXiU0cBJnLvzT12o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bbJojmI8xjJtQIB9zYw+MqLEwyRtrNfWto0156iR2fY=;
        b=1g0ZMI5c0t9p6RMo9QgGKQM8md44jurAGOqhP0LjH/RuvTT9edmyN4b85o8/+Cu0zm
         Gey2YzdfrtQbuUKDPoLHICd8FMSiCIUKl4V+z8B3xGorrt9dNpX4Lf6bHVRZDZ52e5Ep
         yJvH8eLEFUBi5RUwrLNafR9oPU06905sErFo9DmN4eZwM9ThMMJczOqEyj/WkEzvYxXB
         wjL8carrCM2shUBqMSCJb+wr+11iQVWmO9EvXQ0tD/6kR4lvXtdbRLAwUrJ2E64eU3ia
         7PPMJ2h9zZX7LnMjFCxv2t/s47giO2/V21ca4hVeIouby3GzaHhGsPxdsLffRgxjLvJl
         /rkQ==
X-Gm-Message-State: AJIora/4hkasWqQLA2p9olruneTn//HGhxtPNo7erx13X4nMMxfwEVAy
        iEEnLOtgIcc7EKlVUgNL2DBJPS0gGxRAA5UP
X-Google-Smtp-Source: AGRyM1u3kxp+QFaKudVWwMWqXjrr0PTB9aqt8aiRHjxt+MAQaz0BaEiyIZ1GvYLQOG4pxR3j1jy2ow==
X-Received: by 2002:a05:6402:189:b0:437:8a8a:d08a with SMTP id r9-20020a056402018900b004378a8ad08amr4747036edv.241.1656278462453;
        Sun, 26 Jun 2022 14:21:02 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id q4-20020a1709064cc400b006fec4ee28d0sm4147289ejt.189.2022.06.26.14.21.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 14:21:01 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id r20so10458408wra.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 14:21:01 -0700 (PDT)
X-Received: by 2002:a05:6000:1f8d:b0:21b:aaec:ebae with SMTP id
 bw13-20020a0560001f8d00b0021baaecebaemr9748530wrb.274.1656278460708; Sun, 26
 Jun 2022 14:21:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220622140853.31383-1-pmladek@suse.com> <YraWWl+Go17uPOgR@mtj.duckdns.org>
 <CAHk-=wiC7rj1o7vTnYUPfD7YxAu09MZiZbahHqvLm9+Cgg1dFw@mail.gmail.com>
 <874k0863x8.fsf@email.froward.int.ebiederm.org> <CAHk-=wgTG2K3erROP19320zBN6BHVf0hRfXGdawkGR4gzrJN6w@mail.gmail.com>
 <CAHk-=whLsaRKaFKS0UffeCYYCVyP0bbiB4BTYTaXtScgu6R9yA@mail.gmail.com>
 <87pmiw1fy6.fsf@email.froward.int.ebiederm.org> <CAHk-=wiutNT47oNhyk_WvMj2qp4pehYFptXCUzW=u_2STLQiww@mail.gmail.com>
 <CAHk-=whX_=BNZ4kVEAu2NV3CMnhwsuYTyE65FQXUMx8VPNOAOA@mail.gmail.com>
 <87ilonuti2.fsf_-_@email.froward.int.ebiederm.org> <87czevutgb.fsf_-_@email.froward.int.ebiederm.org>
In-Reply-To: <87czevutgb.fsf_-_@email.froward.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 26 Jun 2022 14:20:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg2t3D4CjdMiNR6Bs6DESgxf2nVwdX-Cv4G4Uhig2isPg@mail.gmail.com>
Message-ID: <CAHk-=wg2t3D4CjdMiNR6Bs6DESgxf2nVwdX-Cv4G4Uhig2isPg@mail.gmail.com>
Subject: Re: [PATCH 1/3] kthread: Remove the flags argument from kernel_thread
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Christian Brauner <brauner@kernel.org>, Tejun Heo <tj@kernel.org>,
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

On Sun, Jun 26, 2022 at 12:15 PM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> As kthreadd never exists it simply does not matter what kind of exit
> it has.  So for simplicity make it look like everything else and use
> SIGCHLD.

That "never exists" should be "never exits" ;)

But:

> +pid_t kernel_thread(int (*fn)(void *), void *arg)
>  {
> +       unsigned long flags = CLONE_FS | CLONE_FILES | SIGCHLD;
>         struct kernel_clone_args args = {
>                 .flags          = ((lower_32_bits(flags) | CLONE_VM |
>                                     CLONE_UNTRACED) & ~CSIGNAL),

Please just get rid of that 'flags' thing, and the lower_32_bits()
games and write this all as

    pid_t kernel_thread(int (*fn)(void *), void *arg)
    {
        struct kernel_clone_args args = {
                .flags          = CLONE_FS | CLONE_FILES |
                                  CLONE_VM | CLONE_UNTRACED,
                .exit_signal    = SIGCHLD,
                ...

which does that whole thing much more clearly.

              Linus
