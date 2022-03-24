Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4144E6066
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 09:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348937AbiCXIfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 04:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244857AbiCXIfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 04:35:43 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDA29BB94
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 01:34:12 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
        by gnuweeb.org (Postfix) with ESMTPSA id 3A88E7E70E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 08:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1648110851;
        bh=TSeBThyR27cR0wXvkrlR2MNOHO4p/zPPjfVaKmUn8DY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nGS8rAeDB87coxni8HOPl+4umCInNVqMmzVg6ERZaZtdXELz2zsC7H8R2wPTm8gin
         2vUAB36goaX3frdpDfGi4G0BYwqNycNHWeJfcc6zl3tFNZz8kF47OtyNQBYTpblH+7
         DVbfIw51LEDj8rlkbqVcLS+7IiBUHrmHaCJdY3r/EzuYS97Ds2m4qB0J1K8lVdvBEW
         NtDGUHIo9HwpI+sFTanyKiZ+5koyN4smPxVZepx9HCgLOIeB/WW80yQSC9lMCR8UDX
         PQZfbgRs9G/Qq38n+P0G1OCoXWjaI+Vo89/A2YMLSXCnRI3pkE8JKXQeSc5lKJ3mEs
         EWRbmAVmKBmzw==
Received: by mail-lf1-f43.google.com with SMTP id p10so924683lfa.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 01:34:11 -0700 (PDT)
X-Gm-Message-State: AOAM5303ZP7v2aT4i4Z5Au8MBypqVSjnth18xfhj543Rth9yuFGULise
        B7CeIlelJMzJ6Ayt5TFpzCH/yiQFc3ngiSII114=
X-Google-Smtp-Source: ABdhPJx2muH6RwyzO+bv39vRMGEcdwHNBDP6x2XXTA7g2lwLJiJBRFDj5/HNfwsw6iNge0P4fSEFyp669PZqHPHlB50=
X-Received: by 2002:a05:6512:3f90:b0:446:6b95:24aa with SMTP id
 x16-20020a0565123f9000b004466b9524aamr3030514lfa.610.1648110849139; Thu, 24
 Mar 2022 01:34:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220324073039.140946-1-ammarfaizi2@gnuweeb.org>
 <20220324073039.140946-5-ammarfaizi2@gnuweeb.org> <20220324075728.GC18586@1wt.eu>
In-Reply-To: <20220324075728.GC18586@1wt.eu>
From:   Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Date:   Thu, 24 Mar 2022 15:33:57 +0700
X-Gmail-Original-Message-ID: <CAOG64qMwKYHLrUVro1gFhYqHvm8wq5DUdO7QfK5gG2TKhfnNhA@mail.gmail.com>
Message-ID: <CAOG64qMwKYHLrUVro1gFhYqHvm8wq5DUdO7QfK5gG2TKhfnNhA@mail.gmail.com>
Subject: Re: [PATCH v1 04/11] tools/nolibc: x86-64: Use appropriate register
 constraints if exist
To:     Willy Tarreau <w@1wt.eu>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "GNU/Weeb Mailing List" <gwml@vger.gnuweeb.org>,
        David Laight <David.Laight@aculab.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 2:57 PM Willy Tarreau <w@1wt.eu> wrote:
> On Thu, Mar 24, 2022 at 02:30:32PM +0700, Ammar Faizi wrote:
> > Use appropriate register constraints if exist. Don't use register
> > variables for all inputs.
> >
> > Register variables with "r" constraint should be used when we need to
> > pass data through a specific register to extended inline assembly that
> > doesn't have a specific register constraint associated with it (anything
> > outside %rax, %rbx, %rcx, %rdx, %rsi, %rdi).
> >
> > It also simplifies the macro definition.
>
> I'm a bit bothered by this one because I went the exact opposite route
> in the early design precisely because I found that the current one was
> simpler. [...]
[...]
> I'd say that if there is any technical benefit in doing this (occasional
> code improvement or better support for older or exotic compilers), I'd say
> "ok go for it", but if it's only a matter of taste, I'm not convinced at
> all and am rather seeing this as a regression. Now if there's rough
> consensus around this approach I'll abide, but then I'd request that other
> archs are adapted as well so that we don't keep a different approach only
> for these two ones.

I don't see any technical benefit for x86-64, so I don't think there
is a need in doing this. Though I personally prefer to use register
constraints if they exist instead of register variables for everything
(oh yeah, matter of taste since I don't have any technical argument to
say it's better respecting the resulting codegen). The only real issue
is for the syscall6() implementation on i386 as we've been bitten by a
real compiler issue. In short, I am neutral on this change.

Regards~~
-- Viro
