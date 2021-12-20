Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F92547B10E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 17:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237693AbhLTQZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 11:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbhLTQZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 11:25:56 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFCCC061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 08:25:56 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id z29so40473291edl.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 08:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XvWrfQmxo92Vk35K9itPrk+v2drQqqMQXDgOVumXc0M=;
        b=IQjsD21Pybi9GJfj8nuGID8c+mf9ejkusWwXaVWIkOWbq4mOETiVhbADSFAS5NHU2d
         O7PTnLOuP1DMsk3SD/odO+cK9Ld+cYQXuJYvZbiBFZiR42ecGEe/orQVZ4Zd+MGn2fiS
         mjI3dLibvSQJj9rAUjaCC7AUSrbs+HrbIDIGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XvWrfQmxo92Vk35K9itPrk+v2drQqqMQXDgOVumXc0M=;
        b=n0K0JKqATA+CNLo5iGkhNfT5VeOWCBCkB2WoW2a7E1rKbsLoDx+bafou3b8vBfCF5F
         P+eD1b3OVJsnb2kFnj5XsNt1mSJwTpyuq6dKYHtuT7QG7o9IteMzYjKjUZLDYsqf6HXN
         +kN6S13mhSQ8VpEwYjR5xVh2M3852gyj4sxMRnHjxDvODwUvlgqDKcjXdD04Sc2yjRcq
         Jmr4ny/8SqO/FUVC8SPOJir00xNs0sajfJ/3C+cb+xTxj1WOSJQGcLm/3tZGr5lss0Cl
         qrkfnktEGYTBzfzZAFgx0flJ83VplyWfCmeDVn/i/0N/BZpNaccyBkUZSrz/Yqxx4ikF
         ssXA==
X-Gm-Message-State: AOAM5335ZyafoRFDoQQKR9q+LSuxKGz/SMhCplrmAaBdmCKyyZ0Kr9KI
        D5JZ7gBTaQ760Y4VI1ixyskhNm8GmdAKSzRe1Zg=
X-Google-Smtp-Source: ABdhPJy12kvUn4Ffj26/tAxYcz/rP33sWjWOBjSaFDzvs2YSsqgpyA6x3MztqjUT7FJ9on5tdMlPbA==
X-Received: by 2002:a05:6402:268a:: with SMTP id w10mr1628606edd.257.1640017554704;
        Mon, 20 Dec 2021 08:25:54 -0800 (PST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id 3sm5466063ejq.159.2021.12.20.08.25.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 08:25:54 -0800 (PST)
Received: by mail-wr1-f42.google.com with SMTP id j18so21290066wrd.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 08:25:54 -0800 (PST)
X-Received: by 2002:adf:8b0e:: with SMTP id n14mr13295335wra.281.1640017553811;
 Mon, 20 Dec 2021 08:25:53 -0800 (PST)
MIME-Version: 1.0
References: <Yb82O5i2DVcK9nAJ@zn.tnic> <CAHk-=wiNMghi=nZc432_Sj4QwG+BtxGUtovnpVQk-LpDj8r3ZA@mail.gmail.com>
 <15b1a9af-f8ff-c3e2-ba3e-cdbd29ae38db@intel.com> <CAHk-=wgMEnZqKcUEH9ADg38ifSJa_Mui7FF=-L1-8=_MQfNFAw@mail.gmail.com>
In-Reply-To: <CAHk-=wgMEnZqKcUEH9ADg38ifSJa_Mui7FF=-L1-8=_MQfNFAw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Dec 2021 08:25:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgC3Q4+3Dc4FhQ6WopwZxoMMVxaA2TSJm-CH1CQ4hQWfw@mail.gmail.com>
Message-ID: <CAHk-=wgC3Q4+3Dc4FhQ6WopwZxoMMVxaA2TSJm-CH1CQ4hQWfw@mail.gmail.com>
Subject: Re: [GIT PULL] core/urgent for v5.16-rc6
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Borislav Petkov <bp@suse.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 8:20 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Whatever. I don't care that much, but this all smells like you just
> dug your own hole for very questionable causes, and instead of a
> "don't do that then" this all is doubling down on a bad idea.

It further looks like it's really only the sas_ss_size that is
checked, so if people wan tto have a lock, make it clear that's the
only thing that the lock is about.

So the actual "do I even need to lock" condition should likely just be

        if (ss_size < t->sas_ss_size)
                .. don't bother locking ..

but as mentioned, I don't really see much of a point in being so
careful even about the growing case.

If somebody is changing xstate features concurrently with another
thread setting up their altstack, they can keep both pieces.

                 Linus
