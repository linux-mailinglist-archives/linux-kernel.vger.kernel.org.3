Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321054EDF5D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 19:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240481AbiCaRJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 13:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234189AbiCaRI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 13:08:58 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5FC23213D
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 10:07:09 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id a30so561745ljq.13
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 10:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fdSyI71UrcYnS9PD8/kYWAhaxlCUy9rY5QWg9D495Js=;
        b=UMiK2/ok9F3Y1Vp/549u0DOVZzjViy3UwowNqil5I+8duJSK5VCjRULxz4DWNeqgZF
         6LWHeeo8vrJHlW3B/3K4hzUWWJUG743p45kFw9pVv4k4JnBNVekIlq5NErSBvjU4WBCB
         QBoZrq1eVRM/sDhtQi08Q0aeugFk2iLHm9a89lv0lHSOn/ZUatgl8TbFYqVxQjft6Vzu
         YZEW0k6VyXfaLqJuQRIA6G5aLzK/iBpbDAc7gKNXoH1s2y4u8bk7OlBJTeCWPfMR3AEM
         4Wnii3Vn49DrVPkfReZaI6eDJL4MhyJXiu4LzSZ653tkbAPZ0ct8tRQXLiWVX/YmHneu
         netw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fdSyI71UrcYnS9PD8/kYWAhaxlCUy9rY5QWg9D495Js=;
        b=KRI7SwUQzMxZo4ZDrmjMsbujZvU3kdzbSrXoiHi0qlookUkH7U8M95aVt1zfeBdb26
         FLMr8+5sFO2Nd3b3ZLVDEp3tklq8zaXJfN4ZBmfaOXqa0G5NFIzyNNcT6+M3WPBKiCAA
         YXE7HENh03C6nbDqKObanHQlzyn6NCGGUvgO2xops62tiGkfLdvlLUZFNgGQzIdw3Xkl
         L0y7fMdEEV5vvs0TsbOOVLlXLbcdPxUXHyrQtn0qRFP7QB1wWBxq87u0KoYsFgJXrMTg
         RFFa+667CB6zRs8dTinEygnDm/ynfJLZFXsx0iMWXNWbjbDKxRYSRhUWDBmdrsf/uZYU
         M46w==
X-Gm-Message-State: AOAM530LekPrHuclr/DumzQwjENOL5iJ2FbnAXbyWzvmytZtYvX+eKzw
        sh7GzPma9dpeXWoOt+xtKYw9YdFcLS7c7sIDaf+6SA==
X-Google-Smtp-Source: ABdhPJw8Q/b4RlaadBwVkJ1YfXzyuHazNx9rPS5OzaHjywsX8MEzE4ECP5Xy/jh7hykLR2YuO0IcIF80exL3DqZ36as=
X-Received: by 2002:a2e:818f:0:b0:24a:7c17:7226 with SMTP id
 e15-20020a2e818f000000b0024a7c177226mr11014901ljg.472.1648746423660; Thu, 31
 Mar 2022 10:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <202203301412.MZ7wQvQz-lkp@intel.com> <YkTP/+jhhAX6xlAQ@carbon.dhcp.thefacebook.com>
 <YkV3bCqtLaVH+mC7@linux.ibm.com> <YkXSv8exRRUbT/oM@dev-arch.thelio-3990X>
In-Reply-To: <YkXSv8exRRUbT/oM@dev-arch.thelio-3990X>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 31 Mar 2022 10:06:52 -0700
Message-ID: <CAKwvOdksByffbydecdy_buXSmzM6Fx9T90Jse+84dOYX=QQZgA@mail.gmail.com>
Subject: Re: [ammarfaizi2-block:google/android/kernel/common/android12-trusty-5.10
 4036/5872] WARNING: modpost: vmlinux.o(.text+0x4111c4): Section mismatch in
 reference from the function memblock_bottom_up() to the variable .meminit.data:memblock
To:     Tri Vo <trong@google.com>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@google.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        kernel test robot <lkp@intel.com>,
        Roman Gushchin <guro@fb.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org,
        "GNU/Weeb Mailing List" <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Minchan Kim <minchan@google.com>,
        Nathan Chancellor <nathan@kernel.org>
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

On Thu, Mar 31, 2022 at 9:11 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Thu, Mar 31, 2022 at 12:42:04PM +0300, Mike Rapoport wrote:
> > (added llvm folks)
> >
> > Hi,
> >
> > On Wed, Mar 30, 2022 at 02:47:43PM -0700, Roman Gushchin wrote:
> > > On Wed, Mar 30, 2022 at 02:53:14PM +0800, kbuild test robot wrote:
> > > > Hi Roman,
> > > >
> > > > FYI, the error/warning still remains.
> > > >
> > > > tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-trusty-5.10
> > > > head:   07055bfd3d810d41a38354693dfaa55a6f8c0025
> > > > commit: 0e0bfc41fdf4d79d39ebe929844cdee44f97366d [4036/5872] UPSTREAM: mm: cma: allocate cma areas bottom-up
> > > > config: x86_64-randconfig-a005 (https://download.01.org/0day-ci/archive/20220330/202203301412.MZ7wQvQz-lkp@intel.com/config)
> > > > compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
> > > > reproduce (this is a W=1 build):
> > > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > > >         chmod +x ~/bin/make.cross
> > > >         # https://github.com/ammarfaizi2/linux-block/commit/0e0bfc41fdf4d79d39ebe929844cdee44f97366d
> > > >         git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
> > > >         git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android12-trusty-5.10
> > > >         git checkout 0e0bfc41fdf4d79d39ebe929844cdee44f97366d
> > > >         # save the config file to linux build tree
> > > >         mkdir build_dir
> > > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> > > >
> > > > If you fix the issue, kindly add following tag as appropriate
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > >
> > > > All warnings (new ones prefixed by >>, old ones prefixed by <<):
> > > >
> > > > >> WARNING: modpost: vmlinux.o(.text+0x4111c4): Section mismatch in reference from the function memblock_bottom_up() to the variable .meminit.data:memblock
> > > > The function memblock_bottom_up() references
> > > > the variable __meminitdata memblock.
> > > > This is often because memblock_bottom_up lacks a __meminitdata
> > > > annotation or the annotation of memblock is wrong.
> > >
> > > I guess this patch should fix it, however I fail to reproduce the original issue.
> > > Maybe it's up to the specific compiler version.
> > >
> > > --
> > >
> > > From b55a8dd19f4156d7e24ec39b18ede06965ce1c4f Mon Sep 17 00:00:00 2001
> > > From: Roman Gushchin <roman.gushchin@linux.dev>
> > > Date: Wed, 30 Mar 2022 14:42:12 -0700
> > > Subject: [PATCH] memblock: fix memblock_bottom_up() and
> > >  memblock_set_bottom_up() annotations
> > >
> > > memblock_bottom_up() and memblock_set_bottom_up() lack __meminitdata
> > > annotations causing compiler warnings like:
> > >   WARNING: modpost: vmlinux.o(.text+0x4111c4): Section mismatch in reference from the function memblock_bottom_up() to the
> > >   variable .meminit.data:memblock
> > >
> > > Fix it by adding the missing annotation and removing the wrong
> > > __meminit annotation.
> > >
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> > > ---
> > >  include/linux/memblock.h | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> > > index 50ad19662a32..536bc2fc31e6 100644
> > > --- a/include/linux/memblock.h
> > > +++ b/include/linux/memblock.h
> > > @@ -460,7 +460,7 @@ static inline void *memblock_alloc_node(phys_addr_t size,
> > >  /*
> > >   * Set the allocation direction to bottom-up or top-down.
> > >   */
> > > -static inline __init_memblock void memblock_set_bottom_up(bool enable)
> > > +static inline __initdata_memblock void memblock_set_bottom_up(bool enable)
> >
> > I think putting __initdata_memlock won't help here, because there should be
> > nothing wrong with __meminit function accessing __meminitdata data.
> >
> > My guesstimate would be that the compiler decided not to inline this and
> > still dropped section attribute because of 'inline'.
> >
> > If this is the case we I think we should
> >
> >       s/inline __init_memblock/__always_inline/
> >
> > >  {
> > >     memblock.bottom_up = enable;
> > >  }
> > > @@ -470,7 +470,7 @@ static inline __init_memblock void memblock_set_bottom_up(bool enable)
> > >   * if this is true, that said, memblock will allocate memory
> > >   * in bottom-up direction.
> > >   */
> > > -static inline __init_memblock bool memblock_bottom_up(void)
> > > +static inline __initdata_memblock bool memblock_bottom_up(void)
> > >  {
> > >     return memblock.bottom_up;
> > >  }
> > > --
> > > 2.30.2
> > >
> >
>
> For the record, I cannot reproduce this on mainline, which has commits
> 34dc2efb39a2 ("memblock: fix section mismatch warning") and a024b7c2850d
> ("mm: memblock: fix section mismatch warning again"). That first commit
> has the same exact warning as this report, which is against an Android
> tree (android12-trusty-5.10).
>
> While I do not see the commit that 34dc2efb39a2 claims to fix in
> android12-trusty-5.10, I do see the three commits in android12-5.10:
>
> a46e3fa13968 ("UPSTREAM: mm: memblock: drop __init from memblock functions to make it inline")
> 5f7ec0f4c383 ("UPSTREAM: memblock: fix section mismatch warning")
> 8cf5bb6946a2 ("UPSTREAM: mm: memblock: fix section mismatch warning again")

It sounds like trusty just needs to pull down from (or rebase onto)
android12-5.10 into android12-trusty-5.10.

>
> I think we can just discard this report for now, unless someone from
> Google's trusty team wants to address it in that branch.
>
> Cheers,
> Nathan



-- 
Thanks,
~Nick Desaulniers
