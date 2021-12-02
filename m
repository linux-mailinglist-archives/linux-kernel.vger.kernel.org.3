Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D810466159
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 11:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356903AbhLBKXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 05:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240883AbhLBKX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 05:23:28 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59BAC06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 02:20:05 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id r26so54458686oiw.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 02:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tGFdOsPHZbg5ZrN3mTG563B5p/8mDhvFf9ZIRnX08E0=;
        b=ZeYS9d2OygJnhsv2FYlogJyJkqhwA4k5l7mBOQWW8i1x3UeuO35zBAtNQbjkFFWONC
         cPMbhy1GX08aSFaqVkxg3EBWgaNOzkdmct3LgB2zJexHPYNK1up1QNW5dyd9fnlUIp0L
         b5gcZVG0Dof2IMvsP5RfwDCB0jeNGM1h9GBeydhmb4ytJNikt9Q546XKEUNrZ1qJzmFs
         JoSbFtYRC3sgohVbSc8R7FFe87ePq8H11NybKRjSJYnRAcTyoadOffN8lS+QZQuMWLSr
         s+EHRjJL9DVBByHVjTVMjKDVVN/hJzFUPNmzMnC/v/4eJz3hMNMEsAmx5t6PymKv1Wq9
         h/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tGFdOsPHZbg5ZrN3mTG563B5p/8mDhvFf9ZIRnX08E0=;
        b=bc0KRTRulB2fRRfXhasTzOmNB9EkE1NeuK6+gbeL/Cw0DOOMAzT5eWAPeuhRE+Qm2u
         0KDvoqd4AxX4MPixQk+Q+4gXZgBIyQB2e/nmh3ZrFHJE1p6TF6j39kvGfprWYCRsLehl
         EMNmdbSvea27qcXdYjARViIjON/bmKW06593azGyh2gNe/KE5hqvHlG+eixFKc2MUxtU
         TzQ4J31QDK815PDu9r9lI2Rtf4ZKwKQ6BBogW+jWbfz/Q1W1E5nCx01CCCCJL24aVTpB
         vHFdYSPp9WcUjGxWwjNyMalf+U95nz5AMnigTnI++KHOg2GO5BTBhLdSFd23/dEaGsHZ
         bFpA==
X-Gm-Message-State: AOAM530uQFf024hi1LMqNzTscxP9LE41sYFuCPrG42hFQUdAnMpqokua
        Czwjco6pcKeCC57HcIYE8bLqoJfzinhRf92g7fX4CA==
X-Google-Smtp-Source: ABdhPJwa1yVCgKcC6MV/TyO3EMTg46+Swe5XhTdhQHJt+UoIGdOS6EqlW08isu7+R5XRSKEGsLWl1rk/kql7xJsZmKM=
X-Received: by 2002:aca:af50:: with SMTP id y77mr3803774oie.134.1638440405007;
 Thu, 02 Dec 2021 02:20:05 -0800 (PST)
MIME-Version: 1.0
References: <20211129145732.27000-1-wangkefeng.wang@huawei.com>
 <YadiUPpJ0gADbiHQ@FVFF77S0Q05N> <811af0bc-0c99-37f6-a39a-095418b10661@huawei.com>
 <Yaic31SbYFJ4zAl0@elver.google.com>
In-Reply-To: <Yaic31SbYFJ4zAl0@elver.google.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 2 Dec 2021 11:19:52 +0100
Message-ID: <CANpmjNNe3rnc6MvWi_GvngQYX2Qb-gEkDR081_L++Sz62XXmSg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: Enable KCSAN
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        joey.gouly@arm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Dec 2021 at 11:16, Marco Elver <elver@google.com> wrote:
[...]
> > Reported by Kernel Concurrency Sanitizer on:
> > CPU: 7 PID: 2530 Comm: syz-executor.11 Not tainted 5.10.0+ #113
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.104/01/2014
> > ==================================================================
> > BUG: KCSAN: data-race in rwsem_spin_on_owner+0xf4/0x180
> >
> > race at unknown origin, with read to 0xffff9767d3becfac of 4 bytes by task 18119 on cpu 0:
> >  rwsem_spin_on_owner+0xf4/0x180
> >  rwsem_optimistic_spin+0x48/0x480
> >  rwsem_down_read_slowpath+0x4a0/0x670
> >  down_read+0x69/0x190
> >  process_vm_rw+0x41e/0x840
> >  __x64_sys_process_vm_writev+0x76/0x90
> >  do_syscall_64+0x37/0x50
> >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[...]
> I actually have a "fix" for the data race in rwsem_spin_on_owner, that
> also shows where the other racing access comes from... which reminds me:
> https://lkml.kernel.org/r/20211202101238.33546-1-elver@google.com

Reading be hard ... that patch is for mutex_spin_on_owner. But the
other racing access is the same.

Thanks,
-- Marco
