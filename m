Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D7B5321BD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 05:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbiEXDte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 23:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiEXDtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 23:49:25 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8EF6C0FB
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 20:49:23 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id j4so17006586edq.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 20:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HrSaLFBv+wFUHGHP931GMzrLFNO3Q02iw48W8VHUISo=;
        b=FhE+2La7sDO8tvvWjLC8PJ1eUNbTwgikvbSV2bpx3bGlrcQsgeMwE9whBrTEizoiZt
         S2l2SWj8I8nqbsDGcPiulfIybMrCbJgoempKOYL4W4Xa3ZNoJit6QBG37pzgdLRtiDUH
         Zeb5+9b/+xITqlFLojbmAb/wAJ23VTwu4nuZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HrSaLFBv+wFUHGHP931GMzrLFNO3Q02iw48W8VHUISo=;
        b=Fdh/RZNTRtNSpy+Kqofy5lWdUhKiqg5MsVxkYurA4WflI6DM3o461MHX331cym34nu
         NzsQpf9awF/IFmNPfdbIIjMhSoz78AJ60tvKgextUafGPBAh8S2UNz1rKmi+GrA2HkUZ
         4iAZ2GpwJJSVBmnj8aCSWeHaa9bbnL3YoIChseLR/va7/5q4TRR0ULnBtCFCe8/BPFKP
         v9dEINxF6DKZpFWc8B9aKVWxDuYPn+IkfPtb1UyGnbp+qGJ/wkPBbWyl5Ip0EbpCFRlF
         2wO9spTtMaBSJ1kHRslCTBNPUIEKq7bFqtDh+lvPuiqlbQF7ZK3J1H+3Yq/EAeMCgs5R
         b4JA==
X-Gm-Message-State: AOAM531OA4k2FIdRpM+kbsS8jL/PV4PwbtN7MtttdPCoJyiRbAfcv7o2
        dKFzlntPt6VMRnqf1BM4W/2LEWpR/VMc5OsnIWc=
X-Google-Smtp-Source: ABdhPJzDPRUeypXR2zA3fZWdEkT5iuu2fBhzmGtPg2w71cp4lkiSHVb8eLKWQapzUVosd9zoZ0CQSw==
X-Received: by 2002:a05:6402:1654:b0:42a:c4c7:e85e with SMTP id s20-20020a056402165400b0042ac4c7e85emr26513629edx.181.1653364161513;
        Mon, 23 May 2022 20:49:21 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id w5-20020a170906b18500b006fecf74395bsm2264778ejy.8.2022.05.23.20.49.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 20:49:20 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id u27so23037849wru.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 20:49:20 -0700 (PDT)
X-Received: by 2002:a5d:59ac:0:b0:20e:6fd6:88c1 with SMTP id
 p12-20020a5d59ac000000b0020e6fd688c1mr18980311wrr.442.1653364160189; Mon, 23
 May 2022 20:49:20 -0700 (PDT)
MIME-Version: 1.0
References: <13e61c61-0d4b-5f48-6373-f056bf8b603f@redhat.com>
In-Reply-To: <13e61c61-0d4b-5f48-6373-f056bf8b603f@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 May 2022 20:49:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgV8zqiLi5p-SNZ2zSi95CkkFXqPZJjtneVXeobgAohJg@mail.gmail.com>
Message-ID: <CAHk-=wgV8zqiLi5p-SNZ2zSi95CkkFXqPZJjtneVXeobgAohJg@mail.gmail.com>
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.19-1
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mark.gross@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
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

On Sun, May 22, 2022 at 1:00 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.19-1

Hmm.

Your diffstat doesn't match what I get, and it seems to be because
you've generated the diffstat based off v5.18-rc1, but you already
sent me two pull requests with fixes since.

So your diffstat contained the diffs from those fixes I had already gotten.

If  you just do "git fetch origin" (replace 'origin' with whatever you
call the upstream tree) before doing the pull request, git would have
figured that out.

                Linus
