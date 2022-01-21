Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09576496533
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 19:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352025AbiAUSkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 13:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352056AbiAUSjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 13:39:39 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448BBC06173B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 10:39:39 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id d13so1449391ljl.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 10:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/csbtbwr+UycBIZvysJGcSyJ7kB4nwbtuLHgr5dlbas=;
        b=ky4H6BVOIXfnLZsKRTtz85EaXhqvqbg2DSL4mdvpRNaUOQ12HXkFqg93dfsl2CLB0h
         bfpeBv3DBW7LTucOX/PdN9yM+fCrG4Jbb58HHnPxpwMiTpkc1I9p3PLhlWm4qaCNQOO3
         izjrL5LXb+CYFZZ1Q6cTDL4zF3hWMLs2oz58Bub+3zo+TsxoOg6yPWy/q5g4zge5CiUU
         yZxOiWOs1BG8loNDC05Ud8U3j3vbIHSQncdNX+O+kZlHr455hSB7Mu+vFkRzByNVzrDX
         4TFMtEUn7cQjp8qauoxTkqband0frUhqYFLr+O5EqAdi4H8AA16PgWFs3VPkWE7Adtb0
         Z5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/csbtbwr+UycBIZvysJGcSyJ7kB4nwbtuLHgr5dlbas=;
        b=L924+REl+rmR1gZ6fKkYgepKzMy072bWwQd9DAigUlsuGQMjstNneykqmuzxq83nsl
         nlYhyEFIjhkaX6/wuEALgb5V/bZlmHDgzVrF5sS7ZyIRFOhqKCoJC/iFn+GZOI56ZiSP
         6Dx+08vTAyUNHJ9gitZ7jX3YpH9UszPEfolmQEw+sxyUobMQT8bMsr8/7qg05h2s8hYE
         r8xv2r6eZqvKGPxj/OZkyGFj9XuvikbZfjC1cyzFIe2P8f4WC4HkJ0KCPpfaIw9EQpvp
         WB3bsXJOB2x+oRPUVQWTfC6Ch+hsL8gnVDLt8gTRsHIRGTm8sj3Igypi1X81eCpwUQWY
         XxYA==
X-Gm-Message-State: AOAM532afpdMpwe/TdrXkkcbEqxSNROYzLAz3zPDO99F5yhApcj3uUaa
        zv8CcxXrBnBmE+EywGvJGGJmAAPAoWcu6o4CrrvY/8M9V4Q=
X-Google-Smtp-Source: ABdhPJwaZUHdbpD1khoRuwNuPeRXYC51K0xYCTVUdNEqZQQvi92fvsCgAklLSMGLgaSQgwHgUvWlE1knhCQMCuCCA4c=
X-Received: by 2002:a2e:9e98:: with SMTP id f24mr4009337ljk.347.1642790377454;
 Fri, 21 Jan 2022 10:39:37 -0800 (PST)
MIME-Version: 1.0
References: <SJ0PR21MB13117BB925ABFD8857CAA5B5C45B9@SJ0PR21MB1311.namprd21.prod.outlook.com>
 <2e7a440f-b942-2794-6c15-66baf81801ae@infradead.org>
In-Reply-To: <2e7a440f-b942-2794-6c15-66baf81801ae@infradead.org>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 21 Jan 2022 19:39:11 +0100
Message-ID: <CAG48ez0Om2MD9nn-NSPjtNvQ4DCX=Xakk+A2CqgXcOwxPzPNKQ@mail.gmail.com>
Subject: Re: Issue With Kernel Changes To Core Dump Collection (Kernel Bug...?)
To:     Bill Messmer <wmessmer@microsoft.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 7:18 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 1/20/22 17:31, Bill Messmer wrote:
> > Hello,
> >
> > It has been my understanding for some time that the kernel config optio=
n CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS (and the corresponding bit 4 of the =
coredump filter) was, at one point, added for the purpose of ensuring that =
the GNU build-id of ELF objects was included in core dumps.  The config des=
cription in Kconfig.binfmt even alludes to this in its description.
> >
> > I am trying to understand why in the 5.10+ kernels, there was a change =
in the kernel that, instead of checking whether a given memory mapping had =
an ELF header in order to determine whether to include the page to checking=
 whether the inode is executable.  The change in question:
> >
> >       github.com/torvalds/linux/commit/429a22e776a2b9f85a2b9c53d8e64759=
8b553dd1

As the commit message says, it was an attempt to avoid a deadlock
without making the code overly complicated. Clearly that didn't go as
planned...

> > In many distributions (e.g.: Ubuntu), the shared objects in /usr/lib an=
d elsewhere are not marked as executable.

Urgh, crap. I'm looking around on my Debian box now, and I also see
that some libraries (like ld.so and libc) are marked executable, but
many others are not...

[...]
> > Was the change here really the intent...?  or is this a kernel bug?

Yeah, that's a bug. Linus suggested it as a way to simplify my
original patch (https://lore.kernel.org/all/CAHk-=3DwiOqR-4jXpPe-5PBKSCwQQF=
DaiJwkJr6ULwhcN8DJoG0A@mail.gmail.com/)
and it seemed like a good idea to me...

I guess the good news is that the original patch
https://lore.kernel.org/all/20200818061239.29091-5-jannh@google.com/
already has the code for doing it properly, so it should be pretty
straightforward to fix this by just pasting over some bits from the
old patch... I'll try to get around to that soon.

This would be so much nicer if the kernel actually knew what is a
library mapping and what isn't... oh well.
