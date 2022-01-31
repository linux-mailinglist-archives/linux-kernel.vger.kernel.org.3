Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98A034A5072
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 21:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379237AbiAaUpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 15:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350866AbiAaUpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 15:45:34 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6579DC061741
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 12:45:34 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id t7so21111310ljc.10
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 12:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OP8lq+CNNstsD6MdqxQkt/+Qf2pjO5hiMrphojuZwoU=;
        b=N1MCHAoWUOlYLJDlA8wsBKE17FbxUlNpj1KofdDJGYesdQY9l1rVYYgINrRkUaFZBf
         KZNoHtazLOFrvgO9HPbhkQGgMOkNa9WzmFHFsFTH/M9qA1u3o9csud+Tm3UjgZ2VXRRD
         MBJdqlKmhqMj9/7feMzK7v3gFyZRAULTAPFyDEKazMIngNZsWxfMaLlpzKLS16prACCB
         asGdmQF+SIIfQ7UskfAH9aJ7LdR7aWz737U8q97afIlghe20cwOmwee5S9cmVI84d7ND
         wNXe1uIhJrSlDO6Uso3Aw5t0JLY2/d0ne0JionMT8Xtu2qOll51EJMY/rmU8W8unvURw
         tMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OP8lq+CNNstsD6MdqxQkt/+Qf2pjO5hiMrphojuZwoU=;
        b=zSmzH3nYSa4O7CD5AKsZ4hMUexbaVYRsIoBCGR0jkCzrq38k08Q6SFClDZ1Vv03Syj
         46f/fFK1ujJw2GrQs3DVS42NA7jgbBvV9YUt9ZNdUlUE8az4bSXPfvYC5iKqy66jfET7
         3hFQUXh6+2xHkR3g8auwbPowOTnndGK0btGAK16c4LEUNBLE9mtOhDArOhMzbM4YF0we
         cIBUrCw+UDLaLo1gE48BS7+8hfopA+kJO+4zJOku+ZEHXQw+TeDes/HCqmcLyxOgwtVZ
         8zBfFSc8lJm6nBNZhenM0rWsi+ge9nvY659bPC82NY8zhoWv4l/MKWAnkAT8g77kNm8Q
         t5jQ==
X-Gm-Message-State: AOAM530x/MWQ00QEAe5eBwk4eFqfaCe28CcB+upFJHo4MSzy351tVBbJ
        bxsV3jE99pVMZesHudAi3j4XmDzhkcK1IRtGyuv3+w==
X-Google-Smtp-Source: ABdhPJyUGs/IuSxxzyGQxz64BV96QhIOuwlW+Oh1fnhj7wrQYLrrNl3HYHpoA3JpS27Xsbp+jya9RNlM8rpDYvQ9TSo=
X-Received: by 2002:a2e:954:: with SMTP id 81mr5661437ljj.198.1643661932405;
 Mon, 31 Jan 2022 12:45:32 -0800 (PST)
MIME-Version: 1.0
References: <20220114010526.1776605-1-ndesaulniers@google.com>
 <YeQei0xNzMq7bFdg@zn.tnic> <20220118192256.jzk5dnceeusq7x7u@treble>
 <20220118230120.pivvson7qekfiqic@treble> <CAKwvOdmLzwz=02ypt0_1324_5-7i3Az7HizFaDMqZv__-D99uA@mail.gmail.com>
 <20220125233128.GT614@gate.crashing.org>
In-Reply-To: <20220125233128.GT614@gate.crashing.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 31 Jan 2022 12:45:20 -0800
Message-ID: <CAKwvOdnB=OfCc_31b=PMjxKewvb3CV2WDwhMWrigviWaHrGMhw@mail.gmail.com>
Subject: Re: [PATCH] objtool: prefer memory clobber & %= to volatile & __COUNTER__
To:     Segher Boessenkool <segher@kernel.crashing.org>,
        apinski@marvell.com
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
        linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 3:34 PM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> Hi!
>
> On Mon, Jan 24, 2022 at 03:26:36PM -0800, Nick Desaulniers wrote:
> > I'm more confident that we can remove the `volatile` keyword (I was
> > thinking about adding a new diagnostic to clang to warn that volatile
> > is redundate+implied for asm goto or inline asm that doesn't have
> > outputs) though that's not the problem here and will probably generate
> > some kernel wide cleanup before we could enable such a flag.
>
> Its main value is that it would discourage users from thinking volatile
> is magic.  Seriously worth some pain!

https://reviews.llvm.org/D118297
PTAL
-- 
Thanks,
~Nick Desaulniers
