Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF028507650
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243663AbiDSRRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237020AbiDSRRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:17:00 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458893BF8F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:14:17 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id g19so16718456lfv.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+1FbhUJ13/d5jViflUqKrILMNkRDHhazhSlSx9G+RWM=;
        b=RZPbNt14y8bWWVSYkvvbeNaYI48BvO0giUKr6TeRPBkJvdlJ0XH0ZTQ/RM4tapZ91l
         n3iMdAtDj7nch5EN3MYycL85/GqlldbKNbusFFiuJBAIf8ciSQIE9URZ+51NF+UPKfRx
         7sCLEfq4DIrIU45LzdD84ri9EtHVfldzcDH6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+1FbhUJ13/d5jViflUqKrILMNkRDHhazhSlSx9G+RWM=;
        b=dc+UxxSsoz0sMBQa+Kem2jNmKtjPv8beyBbe6v0pEOlhOJH9YCT1IJXsMN1JeZ9ryy
         iFY455N+G5DDgEHpjJnCelKEGBE84ba2LpZNheFOcTk3pO0h0suk3SG0udZ4sy8iZGhZ
         yxPa+LYwrOo2/EoOZ0BsgsAboiBXlLGusfQFN/Audlly0QkhYLgpKpyi3/A/tCk1Zh2G
         v8LNfM4cYphpCnhK8leJ9qaqzZdZ+e/FjyQdCbpgwCOGtb15zXxoUdeCn3DiukoSt/Ar
         /CYDi45iJ1waBeiYdjGHf64YGyUtqwTm97P7QCnieYVtlcmiTpOamtfQSdi1UoHDdrUR
         Z6YA==
X-Gm-Message-State: AOAM530BNQJDx8g0/QucHWr4g34h2mYyHD6Yy6JtjXTrDXQNgTtUb/4o
        z2MOpho7P3L8XtaN8VdWjfLSLcBQ+ncF3klOItE=
X-Google-Smtp-Source: ABdhPJxcypx1gpkZ9hJ1Swno3g2H/wZX2Ggnjk5A9sOb6bhqsDGEigzKjrqJQnc3ynGRK7EqKx8hyw==
X-Received: by 2002:a05:6512:260a:b0:43d:909a:50cf with SMTP id bt10-20020a056512260a00b0043d909a50cfmr11625994lfb.195.1650388455144;
        Tue, 19 Apr 2022 10:14:15 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id x40-20020a056512132800b004489691436esm1568210lfu.146.2022.04.19.10.14.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 10:14:13 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id y32so30560788lfa.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:14:12 -0700 (PDT)
X-Received: by 2002:ac2:4203:0:b0:448:8053:d402 with SMTP id
 y3-20020ac24203000000b004488053d402mr11406381lfh.687.1650388452530; Tue, 19
 Apr 2022 10:14:12 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2204190948080.18399@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2204190948080.18399@file01.intranet.prod.int.rdu2.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 19 Apr 2022 10:13:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjNHZ1_sT4iN_TVu+2cmd_n2W+EYfd9vSL3L82kNJTmPg@mail.gmail.com>
Message-ID: <CAHk-=wjNHZ1_sT4iN_TVu+2cmd_n2W+EYfd9vSL3L82kNJTmPg@mail.gmail.com>
Subject: Re: [PATCH] x86: __memcpy_flushcache: fix wrong alignment if size > 2^32
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Tue, Apr 19, 2022 at 6:56 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> The first "if" condition in __memcpy_flushcache is supposed to align the
> "dest" variable to 8 bytes and copy data up to this alignment. However,
> this condition may misbehave if "size" is greater than 4GiB.

You're not wrong, but I also don't think it would be wrong to just have a

        if (WARN_ON_ONCE(size > MAX_INT))
                return;

in there instead.

It' not like "> 2**32" should ever really be a valid thing for any
kind of copy in the kernel. Even if that were to be what you actually
wanted to do (which sounds very unlikely), you'd need to split it up
with cond_resched() just for latency reasons.

             Linus
