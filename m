Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060A453EEDB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 21:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbiFFTsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 15:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbiFFTsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 15:48:16 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71374186D8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 12:48:15 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id h23so19890941ejj.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 12:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DT6839JbDy2yIdEYMFoTCSnqwzHXVdWj4aG9+gbEJ94=;
        b=TD3VNjXXe98Co3b86I6MMAPvAqs7GFH9zK5G2EFMl80w/4jTsLDTJTlvJaPlCJ165s
         hN2+7BnMlwCh8SH5aG2nXEF9n5Jn6LQtN4zAVq5mmshHyYzYyDJZcnSBlQSMRFduucv2
         UlPhDYoxVlqwIbAP7DMLZrAx/ovYm8t7HBN8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DT6839JbDy2yIdEYMFoTCSnqwzHXVdWj4aG9+gbEJ94=;
        b=xljy6gZ6iwpA6JxEO6sfq7RhfgdTp6gbIToXpqXtv+ioJKl7U2LnhmVWzV+HwuvE4G
         lItTAIz06smGcpZspJsZ409IPt9VM0+psg/IuQH/tMtqnXAjIevIohOP0VP7VtXLcFU7
         V0Y2yCeiWZRQGLLw7hpwYkr6bIJL8vgscZihpsHeGc3MgG8iri7DBbP52w0hZP79iiT6
         CTkQ92XfDy8QoCT3XFevRxM5/MbMEgQKyUalCs0OkiaJ4T826ozJAKkUoSdPZLbSSd+i
         n9KklLszgut7VEBBAReqKPNJy53IlPlRL815yWXeYSGsX16wsZx+6G3pimtMbdhFMJ4o
         yrGA==
X-Gm-Message-State: AOAM532mipxCBnWWc0u94/EAlyc2W6nSFnX3qwirAmaDfSh39MekDW2E
        SvgIra6ukgpociiU86uR+HI1SwrnzuXtLfEmJTE=
X-Google-Smtp-Source: ABdhPJw4DyFmFQHx1tALMYVI4FHkHsRHeSmLt9XIPMFM83fe0+QcEtTChXoOTM9RDSo3RWJrOBw89g==
X-Received: by 2002:a17:906:3ed5:b0:6f5:108c:a45 with SMTP id d21-20020a1709063ed500b006f5108c0a45mr22834264ejj.623.1654544893703;
        Mon, 06 Jun 2022 12:48:13 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id a14-20020a170906368e00b006fec5cef701sm6663428ejc.197.2022.06.06.12.48.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 12:48:11 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id u3so21227571wrg.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 12:48:11 -0700 (PDT)
X-Received: by 2002:a05:6000:16c4:b0:20f:cd5d:4797 with SMTP id
 h4-20020a05600016c400b0020fcd5d4797mr23878066wrf.193.1654544891292; Mon, 06
 Jun 2022 12:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whmtHMzjaVUF9bS+7vE_rrRctcCTvsAeB8fuLYcyYLN-g@mail.gmail.com>
 <226cee6a-6ca1-b603-db08-8500cd8f77b7@gnuweeb.org> <CAHk-=whayT+o58FrPCXVVJ3Bn-3SeoDkMA77TOd9jg4yMGNExw@mail.gmail.com>
 <87r1414y5v.fsf@email.froward.int.ebiederm.org> <CAHk-=wijAnOcC2qQEAvFtRD_xpPbG+aSUXkfM-nFTHuMmPbZGA@mail.gmail.com>
 <266e648a-c537-66bc-455b-37105567c942@canonical.com>
In-Reply-To: <266e648a-c537-66bc-455b-37105567c942@canonical.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Jun 2022 12:47:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi+C9XYbu59vuBv1Z9KHd7_tQN_Skd6xzrM512hFJq5aw@mail.gmail.com>
Message-ID: <CAHk-=wi+C9XYbu59vuBv1Z9KHd7_tQN_Skd6xzrM512hFJq5aw@mail.gmail.com>
Subject: Re: Linux 5.18-rc4
To:     John Johansen <john.johansen@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, gwml@vger.gnuweeb.org
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

On Mon, Jun 6, 2022 at 12:19 PM John Johansen
<john.johansen@canonical.com> wrote:
>
> > I suspect that part is that both Apparmor and IPC use the idr local lock.
>
> bingo,
>
> apparmor moved its secids allocation from a custom radix tree to idr in
>
>   99cc45e48678 apparmor: Use an IDR to allocate apparmor secids
>
> and ipc is using the idr for its id allocation as well

The thing is, I'm not entirely convinced you can deadlock on a local lock.

A local lock is per-cpu, so one CPU holding that lock won't actually
block another CPU holding it. Even on RT, I think.

I *think* local locks are useful for lockdep not because of any lock
chains they introduce, but because of how lockdep catches irq mis-use
(where they *can* deadlock).

But I may be entirely wrong, and maybe that lock chain through the
local lock actually does matter.

Let's bring in people who actually know what they are doing, rather
than my wild speculation. Thomas?

                    Linus
