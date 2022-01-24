Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 257BC49AB3E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S254832AbiAYEqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 23:46:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S246215AbiAYDqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 22:46:10 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57395C075945
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 15:38:53 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id j14so12569970lja.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 15:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FIP6niwFiCcE5eTqnTDWmb/wrXropuAeXBH8bjmRfkM=;
        b=VrwRqbW7mgBywTPgKBmLBf5J1mchIOr7JqxAATJJaO2MOs9YuCVpjjVNXEzsBml+wp
         ado8O/B5hhh9+WaOXej80757SD6Mzhj0G7C9BhHFXNvvFWjgiuy15dPxWN9LkKSG3U+6
         gpE+me8Rw51avTJbIfG4JbHAU8GoEKfJyjejlkHSYuh6vLn6mpXNjFiANAPJrwEoxGwG
         4pZ3FS3eS7llLKrv/WOiSSLxAyUYewvLJ1UbGnehniTPMJrS/per8DLCYHyAVFn10Dcp
         0zR68towoUo99m4ogkP8Pl1ssg2Dnq6HhdFZ0vu0iKYz6Qr7WmpUyHrojf5yKD7d03V8
         fGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FIP6niwFiCcE5eTqnTDWmb/wrXropuAeXBH8bjmRfkM=;
        b=UH6cWyVQ3txWibNvGsPoz4zlNJio3O45X8gQ/Ko6KqOVwjDxMQEdYfLxRmzQpUdYdR
         rLmWm0b0+D5VjqMeOKo0iJOJZf2pBtZJUFB+At9FSww4+6Cu65QyH/Ygu/WaNvLh5qVH
         eU1RdiEtTvaC66HMDesFxo3hZyOSFHK2qAu796HTn959vHMHkb8JCe0gig52SNP3cTdB
         eo/AU4r5vlg7Xyz+hZ6S+rMvGtbj/llbCsOMaAlIWpmUM11H36EE62OX6H/d/cSjtLuk
         qfuad1rfNc7sELZS/Hr/t8zGHJaL9NriEJAREz22OqrKyCDfQipaXeH4iNLHVB5tjf+B
         dbgQ==
X-Gm-Message-State: AOAM533EmMA2lfG24mWkBAgQYP0snkcqUJlAZETxQO7oLAfVtyB/vClB
        E1ozJvVN8w397XH4edFYAAzEbHcJAhICcPPEXo3BWVauRPV8jw==
X-Google-Smtp-Source: ABdhPJxzHN2oG34NI+OLkIh9cUsniM7MENh8SCt8InminhPjzFucnqpWLiy0Rn4gHwCa+ALqvnw7k5IqoQt/rLjLGHg=
X-Received: by 2002:a2e:9654:: with SMTP id z20mr12950862ljh.526.1643067531477;
 Mon, 24 Jan 2022 15:38:51 -0800 (PST)
MIME-Version: 1.0
References: <20220114010526.1776605-1-ndesaulniers@google.com>
 <YeQei0xNzMq7bFdg@zn.tnic> <20220118192256.jzk5dnceeusq7x7u@treble>
 <20220118230120.pivvson7qekfiqic@treble> <CAKwvOdmLzwz=02ypt0_1324_5-7i3Az7HizFaDMqZv__-D99uA@mail.gmail.com>
In-Reply-To: <CAKwvOdmLzwz=02ypt0_1324_5-7i3Az7HizFaDMqZv__-D99uA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 24 Jan 2022 15:38:38 -0800
Message-ID: <CAKwvOdm+pnKb2PU7H5W1ks8eFd3DPEtN5kzjhnz5TLLwpBLOsA@mail.gmail.com>
Subject: Re: [PATCH] objtool: prefer memory clobber & %= to volatile & __COUNTER__
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
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

On Mon, Jan 24, 2022 at 3:26 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Jan 18, 2022 at 3:01 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > Apparently this patch isn't going to work after all :-(
> >
> >   https://lkml.kernel.org/r/202201190632.lhlaiCBk-lkp@intel.com
>
> I noticed in that report and
> https://lore.kernel.org/lkml/202201190702.XNSXrMTK-lkp@intel.com/
> that gcc-9 was used.  I wonder if %= has been fixed in gcc-10+? Have
> there been other reports with gcc-10+ for my patch?
>
> Boris' case of xfrm_output_resume is yet a third case; Boris, what
> version of gcc did you spot that with?
>
> If this is fixed in gcc-10, then we can probably add a comment with a
> FIXME link to the issue or commit to replace __COUNTER__ with %= one
> day.  If not, then we can probably come up with a reduced test case
> for the GCC devs to take a look at, then add the FIXME comment to
> kernel sources.


$ wget https://download.01.org/0day-ci/archive/20220119/202201190702.XNSXrMTK-lkp@intel.com/config
-O .config
$ make -j72 -s olddefconfig drivers/net/wireless/mac80211_hwsim.o
drivers/net/wireless/mac80211_hwsim.o: warning: objtool:
mac80211_hwsim_tx()+0x9aa: unreachable instruction
$ gcc --version
gcc (Debian 11.2.0-12) 11.2.0

:(

Let me see if I can come up with a reduced test case that I will
report upstream to https://gcc.gnu.org/bugzilla/.
-- 
Thanks,
~Nick Desaulniers
