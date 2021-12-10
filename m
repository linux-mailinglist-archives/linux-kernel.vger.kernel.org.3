Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8B9470C84
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 22:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344345AbhLJV3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 16:29:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237368AbhLJV3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 16:29:52 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD4FC061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 13:26:16 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id w1so33677662edc.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 13:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ryfLc1EQbyTN/vJfmdFFLtUk4bkKFOnbLuSFDjSGlrg=;
        b=STebUV9D2Pk2uurxTkIPSo3WV9pH24tZEFCZEZsMAr8E/o4LEnEjSkWpoVNZGgVHIF
         p6nrmLxOVmpzCLJ+H623Q1NcHFKy5awD3ahSUouxQ/IRyu+XP0vSzQvAdl+VSVW6KQ31
         nCb5mz1BtW+5DxKR9pTThv8C49Duc7sOH9XIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ryfLc1EQbyTN/vJfmdFFLtUk4bkKFOnbLuSFDjSGlrg=;
        b=t+yAKA70q30BsuBStqO9vDgc7lqzWhD66zuGIGtZdYab6z2/zvnZH0acpdDmK/aa9X
         YpKfZ2txX2+bn6bo46KWQBGNV4K0to4uppCxcbCiuUSM9RNx7mRObcDHFT/0y+xAlANF
         xNV2PDzqvXWY1vwNEkbHd9PJFc5/abvhb/yMaBRTP17sDVz0AE5zmObQace0oGoWJYjj
         7BD1s8Vi7VmEVky/5ikBElxv3IcGu1B98+zqOxKSjYOfXlITNPMsYTbbYG93HvkHfLRZ
         Uhpjs0/26lDTHyjuatfLylNDQVTPKZC/nGH/ZLvna5o+CUSWaoYqqXGjdFEuy4pET42W
         cpQQ==
X-Gm-Message-State: AOAM5333JRn4utUGoLXXbjRrN/nB9bgmH2PQ/kdPM0nxlWVFBB7w4bK3
        6wLlRlZXlHgl37gdhkV+KzVhncxE7ntS8KKmy1U=
X-Google-Smtp-Source: ABdhPJzrrIdg2bn8WE8dRbJ0g31NDW/2UAD8/um3qd8+uG0t+mJgSoxKUcOv2ffE6zObWVico1W+sw==
X-Received: by 2002:a05:6402:3594:: with SMTP id y20mr41682735edc.328.1639171574240;
        Fri, 10 Dec 2021 13:26:14 -0800 (PST)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id cs15sm1906395ejc.31.2021.12.10.13.26.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 13:26:12 -0800 (PST)
Received: by mail-wr1-f44.google.com with SMTP id d9so17139006wrw.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 13:26:12 -0800 (PST)
X-Received: by 2002:adf:8b0e:: with SMTP id n14mr15509425wra.281.1639171572401;
 Fri, 10 Dec 2021 13:26:12 -0800 (PST)
MIME-Version: 1.0
References: <20211210053743.GA36420@xsang-OptiPlex-9020> <CAHk-=wgxd2DqzM3PAsFmzJDHFggxg7ODTQxfJoGCRDbjgMm8nA@mail.gmail.com>
 <CAG48ez1pnatAB095dnbrn9LbuQe4+ENwh-WEW36pM40ozhpruw@mail.gmail.com>
In-Reply-To: <CAG48ez1pnatAB095dnbrn9LbuQe4+ENwh-WEW36pM40ozhpruw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Dec 2021 13:25:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg1uxUTmdEYgTcxWGQ-s6vb_V_Jux+Z+qwoAcVGkCTDYA@mail.gmail.com>
Message-ID: <CAHk-=wg1uxUTmdEYgTcxWGQ-s6vb_V_Jux+Z+qwoAcVGkCTDYA@mail.gmail.com>
Subject: Re: [fget] 054aa8d439: will-it-scale.per_thread_ops -5.7% regression
To:     Jann Horn <jannh@google.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 12:30 PM Jann Horn <jannh@google.com> wrote:
>
> Oh, and I just realized that your patch probably actually also fixes
> an issue entirely unrelated to unix sockets. __fdget_pos() does this:

Hmm. I was going to say that you're wrong, because that case doesn't
actually have that "offset" thing that the unix domain GC code has,
and a "true zero" reference count is special and will never come back
to life.

But I think you're right - the "close and resurrect" situation wrt the
file count can happen _after_ the __fdget() in __fdget_pos() (where we
have that implicit offset of our own ref), and thus show a false case
of "we're the only user".

So I think you've convinced me - doing it in __fget_files() was the
right thing to do, but I really don't like that 5% regression.

Maybe it's purely on that artificial benchmark, but a multi-threaded
poll loop doesn't sound super-unusual (I think a single-threaded one
is already protected from this all by our "__fget_light()" logic).

Sadly, looking at my gcc code generation, adding that "unlikely()"
does move the "fput_many()" call out to it's own out-of-line code
section, but gcc will still end up doing the stack frame around the
whole function.

So if it's all due to just extra code and stack references due to the
now necessary stack-frame, it doesn't look obvious how to improve on
that.

We could make a special light-weight version of files_lookup_fd_raw(),
I guess. We don't need the *whole* "look it up again".  We don't need
to re-check the array bounds, and we don't need to do the nospec
lookup - we would have triggered a NULL file pointer if that happened
the first time around.

So all we'd need to do is "check that fdt is the same, and check that
fdt->fd[fd] is the same".

                 Linus
