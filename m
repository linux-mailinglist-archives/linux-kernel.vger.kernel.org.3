Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C885A325F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 01:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241517AbiHZXKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 19:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiHZXKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 19:10:25 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE8B8B992
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 16:10:23 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id p16so2593591ejb.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 16:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=EchSFCFNESRMpkzf6LgfeMPqX9NRcEuB71WzS8HN7D8=;
        b=fFXxOFb4I403xbhy531yXT8u8qnCT6hOkiP/2jM4Zv81TC1p+0O50xRLVE70Gx9IHM
         rhSK1nbeWZ6V5/dxPLrsNIOpSsYF/cqSQcTjDQ92IZLO6kOp9BtiQqMDOigyGgxxuu5l
         NwuJw5OyNX1rmomXFegiTMi05iNP/gTP6eKhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=EchSFCFNESRMpkzf6LgfeMPqX9NRcEuB71WzS8HN7D8=;
        b=VlzmMXKaq/jxPvPCjdHopQAiF3NpbrO2t5efPxNNhsQzDPpAiYQL03+2wcYj+E8rL0
         YSVVkn4CFR7n445nFMzcjZqG/++2/xjP+5UpxlHJAJ4TA8Ee6Ds4NC/8b2lGD87lJ7A7
         WHeqvXfWRvKToxWkDPUrjJsXOm96Q4XmNxbHnavBk6c0oj88l2XHRLK7uZKGOppggbIu
         Vbw+LsVvOj1lqM32wQHDh5PuzfjMsZFjJ4H8BwJHfeA0/NMiiWWv9GSPDV8uIPXEe2mi
         HTLcNdkqJyNiHR86eqp3QeV7l/OrWuzBWgMm3hHb2POlPmcjvviL6loFjuOJsDdPIiQ7
         u9bw==
X-Gm-Message-State: ACgBeo29iGBZhpwgfNM5S7SEkDQfvPl7jItYzIT94lj1N9vFqMqjnx7C
        BkwjX6FMnvB3KUGlPvYLGMJesfIxO56jId5impk=
X-Google-Smtp-Source: AA6agR7LeixXgXrwH0YtKQoPgfAc357ok61kst7Vy61G8xjd/C0A7NokuzQ0CLKhP5FZhFONJY3B7A==
X-Received: by 2002:a17:906:cc16:b0:73d:d16c:609f with SMTP id ml22-20020a170906cc1600b0073dd16c609fmr6055608ejb.691.1661555421756;
        Fri, 26 Aug 2022 16:10:21 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090604c200b0073c1e339a37sm1422437eja.149.2022.08.26.16.10.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 16:10:19 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id k18-20020a05600c0b5200b003a5dab49d0bso1538839wmr.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 16:10:18 -0700 (PDT)
X-Received: by 2002:a05:600c:2195:b0:3a6:b3c:c100 with SMTP id
 e21-20020a05600c219500b003a60b3cc100mr852564wme.8.1661555418236; Fri, 26 Aug
 2022 16:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2208220530050.32093@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wh-6RJQWxdVaZSsntyXJWJhivVX8JFH4MqkXv12AHm_=Q@mail.gmail.com>
 <CAHk-=whfZSEc40wtq5H51JcsBdB50ctZPtM3rS3E+xUNvadLog@mail.gmail.com>
 <alpine.LRH.2.02.2208251501200.31977@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wh7ystLBs7r=KrgFhuYpNULoTY1FFPgq=a=Kr2mxc3jdg@mail.gmail.com>
 <alpine.LRH.2.02.2208260508360.26588@file01.intranet.prod.int.rdu2.redhat.com>
 <CAMuHMdWQXqi__8q66R7cL4VVgr4r7WwqNmDExFFsi4aC=K3NPw@mail.gmail.com>
 <CAHk-=wh91FqN2sNSRFZPxfGnqAbJ1o66ew8TXh+neM9hW0xZiA@mail.gmail.com> <alpine.LRH.2.02.2208261620210.9648@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2208261620210.9648@file01.intranet.prod.int.rdu2.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 Aug 2022 16:10:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=whO2sd233T8AXNMhYztPiF9hae+1ePOX1fEMEu6Ow1CQQ@mail.gmail.com>
Message-ID: <CAHk-=whO2sd233T8AXNMhYztPiF9hae+1ePOX1fEMEu6Ow1CQQ@mail.gmail.com>
Subject: Re: [PATCH] provide arch_test_bit_acquire for architectures that
 define test_bit
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>
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

On Fri, Aug 26, 2022 at 1:43 PM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> I'm wondering why do the architectures redefine test_bit, if their
> definition is equivalent to the generic one? We could just delete
> arch_test_bit and use "#define arch_test_bit generic_test_bit" as well.

I think generic_test_bit() came after many of them, and when it
didn't, people copied earlier architectures where they had already
done their own.

> Another untested patch ... tomorrow, I'll try to compile it, at least for
> architectures where Debian provides cross-compiling gcc.

Looks good to me, except I'd just do

#define arch_test_bit_acquire arch_test_bit

on hexagon rather than duplicate that function.

From my reading, Hexagon doesn't have any fancy memory ordering, it's
just the usual UP with barriers basically for instruction cache
coherence etc.

                 Linus
