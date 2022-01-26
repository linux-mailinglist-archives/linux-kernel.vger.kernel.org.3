Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E822749C114
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 03:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236173AbiAZCMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 21:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236160AbiAZCMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 21:12:35 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197D7C061744
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 18:12:35 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id a28so30146375lfl.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 18:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bddl5zJdvIpRDv67hFhNPIFJF2EsWzz+rWzL2YtGbis=;
        b=WV88Mu2IYWreQ+WiCxBelZUJuTKAVWWEgH3YCtPtNnx6tnPxQgSzuSZobST9MpDmjb
         wA5DDI/36Kw0RyGu3tPuYilQX3CVnUSb5nR1+wo4Zmj3j4WY1jp2oD8kPuGpbW4llu4R
         UPbnBBSspuBe33Pq4EFjRQPpR6AcyqpQOXYyr3WK/aNitUSB5kl/oIWC0jyvPzLwcAiI
         mfSAiYFn7Y2zuc6UzG4zk5Xo+W1QGNMIqMzsPlBs3BrbWKpQzJ4r7ziryknf4Qs3J1sq
         AQKtkHJC6Qs20zQirJzKp+sMEcT69CV3B9NXGe0MCHitX7Hw3S7q5Ng6JjYpwOt571o6
         jA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bddl5zJdvIpRDv67hFhNPIFJF2EsWzz+rWzL2YtGbis=;
        b=hd0peA+HjpnMXw4K+tlEunzImWdmHxcBtV6ExEZO2njfb0EzQR93LECxfkkVUVhK+Z
         K9ISoHgW9993h+U3mD2zOIhNnvhkeU6rUDUQxWL971PHEvbjKURItMPedK/i5AysC6bg
         502kEVwUj1hKZDtAOtIpodLW2OEIFgeD54ZFQszWiNJTzwin3jGy9W8gBBulbj4Z+vvI
         aCPeqoKDOB1jNe2zaO+ZekBBTEYk1BsLV3maubuNX6P+cp77s+6c9mozwZaorTzwR4d8
         AbY1nFSx/UaTJqxuClyRLQ4jIZb+G+zX8uER+kfX/Jr8a707BvORPnYo2p2KE5T1R9tb
         vL8A==
X-Gm-Message-State: AOAM531W8ESnM2/xIsHBD8QQylgSzgYnljc7UmMuj0E1s9QhcDVafjOo
        QAZjtBJIzWvp2uTN5SnpvoGsuQmMMTUCt3XHlaLiyQ==
X-Google-Smtp-Source: ABdhPJwkGzNsZfC5qAtJ6gy53n6DA6VFZJWqbX+rbm2fF9UbQE/mgQ4QVgvYw/wKk4iYIG/ovBQUQ5wd6JihKJ3ZFOc=
X-Received: by 2002:a05:6512:3c8e:: with SMTP id h14mr9770534lfv.489.1643163152731;
 Tue, 25 Jan 2022 18:12:32 -0800 (PST)
MIME-Version: 1.0
References: <20220114010526.1776605-1-ndesaulniers@google.com>
 <YeQei0xNzMq7bFdg@zn.tnic> <20220118192256.jzk5dnceeusq7x7u@treble>
 <20220118230120.pivvson7qekfiqic@treble> <CAKwvOdmLzwz=02ypt0_1324_5-7i3Az7HizFaDMqZv__-D99uA@mail.gmail.com>
 <20220125233128.GT614@gate.crashing.org> <CAKwvOd=P0VAFrrUXV0z5dES9hYP2b8-KwTzyG5=ezeUve=K3QA@mail.gmail.com>
In-Reply-To: <CAKwvOd=P0VAFrrUXV0z5dES9hYP2b8-KwTzyG5=ezeUve=K3QA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 25 Jan 2022 18:12:20 -0800
Message-ID: <CAKwvOdnBT74081nCw2hcm2dxCacV0ume_noZ0=Q6e0UiBDF7wg@mail.gmail.com>
Subject: Re: [PATCH] objtool: prefer memory clobber & %= to volatile & __COUNTER__
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        x86@kernel.org, llvm@lists.linux.dev, linux-sparse@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-toolchains@vger.kernel.org, apinski@marvell.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 4:59 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Jan 25, 2022 at 3:34 PM Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
> >
> > Hi!
> >
> > On Mon, Jan 24, 2022 at 03:26:36PM -0800, Nick Desaulniers wrote:
> >
> > > If this is fixed in gcc-10, then we can probably add a comment with a
> > > FIXME link to the issue or commit to replace __COUNTER__ with %= one
> > > day.  If not, then we can probably come up with a reduced test case
> > > for the GCC devs to take a look at, then add the FIXME comment to
> > > kernel sources.
> >
> > Please open a PR?
>
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=104236

Andrew clarified (thanks Andrew!) that %= can't be used as I imagined
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=104236#c4
and that I think was alluded to in
commit 3d1e236022cc ("objtool: Prevent GCC from merging annotate_unreachable()")
which is fine, so I'll just need to keep usage of __COUNTER__. I'll
try out a revised approach for this patch tomorrow.
-- 
Thanks,
~Nick Desaulniers
