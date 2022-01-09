Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B856488BF8
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 20:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236673AbiAITVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 14:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236466AbiAITUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 14:20:55 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0391CC06173F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 11:20:55 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id c71so33541097edf.6
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jan 2022 11:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VWWFkIhkFDieoIAt51lsGMTCATR8BiITQDIvsBDfn9E=;
        b=Msv53R/QNphspQKxQKHE0fOtUUofGqL2OLP4z/ir4My1RjKQSPb5XfqmCQgWZAC4Gs
         Bwjvt96AZNZfJYq1Vpoa4Eh4cCQc9tZ/7chCsAMlxYWz+SI2bvvFmgG3YqB7M5GEESG8
         uqerig2JIhLuCCxNRaGFnvWTAaUOYLMdgSAKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VWWFkIhkFDieoIAt51lsGMTCATR8BiITQDIvsBDfn9E=;
        b=xNVzTos+/Gk/iAVd1yH4YsBk/opdQvQJBxF5gFSw7GmppdJEXf1o4meD6q8shnNLrm
         MhSR2Lb1iq8mKshlxyrzDMwpeLNe1ZwGJOiYD6dVlopkwXwAoZly5RD3LHqPTV1s4Zw1
         fnkVC43hjp2qsG8KdqF3bsqE/t+L6PiQRdwosidKvlTSL4gZRt+nh3Iw1i5K+6ueR7gg
         d3ysXeqnYk8VIlPRNCFgClq6beC008zeIBPa32Co9A+3STBW7NcbapbkWbN809AtXnqd
         JcV94FnGEqgd4Fm4nB2Pjg3M1nTUMN6gTDZjAn+gDujzIKj8yoRnxNwoPSQvyABq4umP
         LV9g==
X-Gm-Message-State: AOAM533dqr30ZVFEcC6vh0KrOw3CvjK4r7EQxqoUfayhFkmDFx0wWzmz
        XOLnt0FYi4emNhxo372opCB9jP5/U+2McUGuHDI=
X-Google-Smtp-Source: ABdhPJyJwd3EbI2EgQK6Z65nXjFIJ/ayGBSKHdz3HqmY2AHBH06ogScYq/cK1JBCB162c1Zh4+HEdA==
X-Received: by 2002:a17:906:713:: with SMTP id y19mr12158865ejb.723.1641756053407;
        Sun, 09 Jan 2022 11:20:53 -0800 (PST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id v16sm2440640edc.4.2022.01.09.11.20.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jan 2022 11:20:53 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id p18so660952wmg.4
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jan 2022 11:20:52 -0800 (PST)
X-Received: by 2002:a05:600c:4c94:: with SMTP id g20mr2575626wmp.26.1641756052725;
 Sun, 09 Jan 2022 11:20:52 -0800 (PST)
MIME-Version: 1.0
References: <164175418046.1037107.9730034714816887497@leemhuis.info>
In-Reply-To: <164175418046.1037107.9730034714816887497@leemhuis.info>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 9 Jan 2022 11:20:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi8gSsM7-+fx-iSoKGHtgrgN==NcQtRikYfiFmv8gjbnQ@mail.gmail.com>
Message-ID: <CAHk-=wi8gSsM7-+fx-iSoKGHtgrgN==NcQtRikYfiFmv8gjbnQ@mail.gmail.com>
Subject: Re: Linux regressions report for mainline [2022-01-09]
To:     "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 9, 2022 at 10:51 AM Regzbot (on behalf of Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> 5-10% increase in IO latencies with nohz balance patch

This one is clearly not rootcaused, but even the reporter isn't sure
what triggered it.  It was bisected to that mentioned patch, but even
that bisection result isn't really entirely certain.

So this one will remain pending, I'm afraid.

> pm: laptop totally freezes when going to hibernation
> drm: amdgpu: s0ix suspend stopped working

Something clearly not great in amdgpu suspend/resume land. The reports
are not fully clear, with even the bisection being questionable.

But from the previous cycle reports:

> =========================================================================================
> previous cycle (v5.14..v5.15), culprit identified, with activity in the past three months
> =========================================================================================
>
> drm: amdgpu: NUC8i7HVKVA crashes during system suspend

This one isn't questionable, and Len sent me the revert he's been
using on his system for a long time. So I applied it.

Maybe it's related, maybe it's not.

             Linus
