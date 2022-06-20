Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C33551809
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 14:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241947AbiFTMCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 08:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241274AbiFTMCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 08:02:17 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6540018374
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 05:02:14 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id s14so4911868ljs.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 05:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BLIpOQctpgnjuRGoLORv+IdWppOjSjpJpZ0mv6ogIJE=;
        b=sXqeUBSqOL43Vh8bHlb9rMEuFx7rlgS62oKqDWhZLaubCkID368lLVMDzc/zJiZ2FL
         voUeNxWRn/PgWnkQpB+dg3eE1Ee20BYjRrTnOun/bP2s6Tf1i1LWNSYAeJ69wcTBi38s
         MC8sl2u+S9TsCBRrPA+y6jCcbleXwPCUsxW0bP5Hx5lww+ct6el9W7+tdfNTsuwLX4+g
         8dPmAvGZQn7gAUBZy9pKvO8amGfDkenAgdDm4avBdJw0nxiFUPPVSFxEi0VZiuqbovXs
         jwCD1voo1i4hV6frJPLJO59aAZo69S5mvcXTjj2YYGAjWbmVddHCD0d7qazot+7rMuay
         FtOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BLIpOQctpgnjuRGoLORv+IdWppOjSjpJpZ0mv6ogIJE=;
        b=g2A9qX1BHc1YFUEv5zPT6Q9ds+A3X3ZdFKj0AG8nXy0eR9oDgnVu8qPbNNO2VtiMz/
         Y/Wr7TGtEET3Mly0L4niXvLVkcWvDm7VQz6442NIk4w35fTcHIY5l/SSqPd3yM9CrTr5
         k5WdzNqB3xlTMXdm5eXTDqnSJpzrGNU27fwdTY0OXXcMDB+/0nVkfXZfM+K1GPUNudJv
         R//mBwPb7EFTHjHfFU4GduSko8fVsfzr/7BfOKw6sY0d7IInSCl6NZjOOz5ahWH8AiUp
         4nqPt71MlkMfKXozdMosuNwZ1BeUzm/LFT2OLFJkXFHC4k7wFE0RNomEpgpd5uFPkoKa
         ygqw==
X-Gm-Message-State: AJIora8isLUwaEctpWMSqgqNUB1Ii7C0ugGDaI5T4ESO4gbdDpc6PAY+
        jPNImGBvSwuxvmodVZENlwUmb918QWus3eQ7cwTgLw==
X-Google-Smtp-Source: AGRyM1tpR/fkd1caq35uMR9/85+YZunSAOI/2g68DexLZBss9W59Y+WfG/aG/kjjiNwlTTCtM0B9GAN5MGA6phRY04Q=
X-Received: by 2002:a2e:808e:0:b0:255:be23:1372 with SMTP id
 i14-20020a2e808e000000b00255be231372mr11347409ljg.4.1655726532388; Mon, 20
 Jun 2022 05:02:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220527113706.24870-1-vbabka@suse.cz> <20220527113706.24870-2-vbabka@suse.cz>
 <CACT4Y+Y4GZfXOru2z5tFPzFdaSUd+GFc6KVL=bsa0+1m197cQQ@mail.gmail.com> <93bf8148-ecc1-75fb-423b-2a76c7252c4e@suse.cz>
In-Reply-To: <93bf8148-ecc1-75fb-423b-2a76c7252c4e@suse.cz>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 20 Jun 2022 14:02:00 +0200
Message-ID: <CACT4Y+ZOaVz_EUa-KuMU392Q_TokCpQLv7schd1kXQ_bB_02nA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] lib/stackdepot: replace CONFIG_STACK_HASH_ORDER
 with automatic sizing
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@gmail.com>,
        kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jun 2022 at 14:00, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 5/27/22 14:02, Dmitry Vyukov wrote:
> > On Fri, 27 May 2022 at 13:37, Vlastimil Babka <vbabka@suse.cz> wrote:
> >>
> >> As Linus explained [1], setting the stackdepot hash table size as a
> >> config option is suboptimal, especially as stackdepot becomes a
> >> dependency of less specialized subsystems than initially (e.g. DRM,
> >> networking, SLUB_DEBUG):
> >>
> >> : (a) it introduces a new compile-time question that isn't sane to ask
> >> : a regular user, but is now exposed to regular users.
> >>
> >> : (b) this by default uses 1MB of memory for a feature that didn't in
> >> : the past, so now if you have small machines you need to make sure you
> >> : make a special kernel config for them.
> >>
> >> Ideally we would employ rhashtable for fully automatic resizing, which
> >> should be feasible for many of the new users, but problematic for the
> >> original users with restricted context that call __stack_depot_save()
> >> with can_alloc == false, i.e. KASAN.
> >>
> >> However we can easily remove the config option and scale the hash table
> >> automatically with system memory. The STACK_HASH_MASK constant becomes
> >> stack_hash_mask variable and is used only in one mask operation, so the
> >> overhead should be negligible to none. For early allocation we can
> >> employ the existing alloc_large_system_hash() function and perform
> >> similar scaling for the late allocation.
> >>
> >> The existing limits of the config option (between 4k and 1M buckets)
> >> are preserved, and scaling factor is set to one bucket per 16kB memory
> >> so on 64bit the max 1M buckets (8MB memory) is achieved with 16GB
> >> system, while a 1GB system will use 512kB.
> >
> > Hi Vlastimil,
> >
> > We use KASAN with VMs with 2GB of memory.
> > If I did the math correctly this will result in 128K entries, while
> > currently we have CONFIG_STACK_HASH_ORDER=20 even for arm32.
> > I am actually not sure how full the table gets, but we can fuzz a
> > large kernel for up to an hour, so we can get lots of stacks (we were
> > the only known users who routinely overflowed default LOCKDEP tables
> > :)).
>
> Aha, good to know the order of 20 has some real use case then :)
>
> > I am not opposed to this in general. And I understand that KASAN Is
> > different from the other users.
> > What do you think re allowing CONFIG_STACK_HASH_ORDER=0/is not set
> > which will mean auto-size, but keeping ability to set exact size as
> > well?
> > Or alternatively auto-size if KASAN is not enabled and use a large
> > table otherwise? But I am not sure if anybody used
> > CONFIG_STACK_HASH_ORDER to reduce the default size with KASAN...
>
> Well if you're unsure and nobody else requested it so far, we could try
> setting it to 20 when KASAN is enabled, and autosize otherwise. If somebody
> comes up with a use-case for the boot-time parameter override (instead of
> CONFIG_), we can add it then?
> >> If needed, the automatic scaling could be complemented with a boot-time
> >> kernel parameter, but it feels pointless to add it without a specific
> >> use case.

Works for me.
