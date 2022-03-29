Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A261C4EB0D5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 17:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238904AbiC2Pjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 11:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238893AbiC2Pjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 11:39:31 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017D225279F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 08:37:47 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-2e5757b57caso187859217b3.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 08:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=cdiQn4MDYBZT4MD+COiiujM149rg5cmUvhmDH4fWhAI=;
        b=b0FFvlB+8/wM/+w8iI8lE3ZS1QMXytKOW4Cd8OhonyTCVfrB84LSEiNtPADXgnwKgl
         N+ZiZJwyZfFo12Ku19vtLdM8bGKMUoBbqeZfKMl00u5tCdsmeS7yK9jciIMY65MA5Leh
         wi7Vi6n17nHUdocZtBuEF0AfuX37TtK3WKvQjR3nmDnEsDi+Sr4TAxOEamyJ1xSBSmCe
         4Pwh7A+3X82yrIM0K7qQjp/6hfecVXgWXVdpSDFEju9zKhESv8854khenVmLUnxFipPo
         Buzkkyx8o6TwydErWCWb7snbfCJa755Z52eELhBcDUkvsuMykgHRWeBQ2eiFPsbGrvz3
         PeAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=cdiQn4MDYBZT4MD+COiiujM149rg5cmUvhmDH4fWhAI=;
        b=F/LIvyTOQPnnM0etq5ve9Er3cwXw71SkafNR+AmDUPaMyrJ1O+9F9wcPgkkUj+GDD1
         xak1HEq/c6Yjkz3CD0zbwt8fP7SoZpNjrWBPtTP3sDxU/9nQi3SMuDTXpbRX4/coW+8e
         cd2HKr3ecuM+8SeTHcaiANb66WruU358oof9K7CRtdd2LoKhuGHvBwMWul/iXJt6q+fk
         V9f4BFfGtAFybaHovtjo0qkPbsLlHZWG+rkTsCD1eko4g0a5KtZ+yHbJgpzLnFfqICe8
         s5KiGCvGwb8hdU0k/YrOGdLBF6nmmMmRZm6ttmFDUnvNfWFl46tV5e3cBb2Gb+lym//C
         V/CA==
X-Gm-Message-State: AOAM530TsglzB28k2k8dGuPtRlHXAq+ATiF6xbaQ7RIW5KZfXaNMfZbE
        TRDC821wdVnUdihDB4NfvxMKxSu5Dhi645W9ROPqOI+pYMfrpw==
X-Google-Smtp-Source: ABdhPJy264N9elL1uOkqTXbYsKQktV0xNWVZwrTTKjVZDqGQCViM7C+xgfzXs+Ws9tjYbgAAQVu8W3L5CmwVqLyLbVo=
X-Received: by 2002:a0d:ccca:0:b0:2e6:2b53:3f16 with SMTP id
 o193-20020a0dccca000000b002e62b533f16mr32560002ywd.35.1648568266768; Tue, 29
 Mar 2022 08:37:46 -0700 (PDT)
MIME-Version: 1.0
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 29 Mar 2022 23:37:10 +0800
Message-ID: <CAMZfGtU1sbsrnCbCKi_By8VTGN1CA1s4A=s1NcHzRunDUpGXgQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] mm: hugetlb_vmemmap: introduce STRUCT_PAGE_SIZE_IS_POWER_OF_2
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Muchun Song <smuchun@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 1:11 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Wed, Mar 23, 2022 at 9:57 PM Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > If the size of "struct page" is not the power of two and this
> > feature is enabled, then the vmemmap pages of HugeTLB will be
> > corrupted after remapping (panic is about to happen in theory).
> > But this only exists when !CONFIG_MEMCG && !CONFIG_SLUB on
> > x86_64.  However, it is not a conventional configuration nowadays.
> > So it is not a real word issue, just the result of a code review.
> > But we have to prevent anyone from configuring that combined
> > configuration.  In order to avoid many checks like "is_power_of_2
> > (sizeof(struct page))" through mm/hugetlb_vmemmap.c.  Introduce
> > STRUCT_PAGE_SIZE_IS_POWER_OF_2 to detect if the size of struct
> > page is power of 2 and make this feature depends on this new
> > config.  Then we could prevent anyone do any unexpected
> > configuration.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> > ---
> >  Kbuild                           | 14 ++++++++++++++
> >  fs/Kconfig                       |  1 +
> >  include/linux/mm_types.h         |  2 ++
> >  mm/Kconfig                       |  3 +++
> >  mm/hugetlb_vmemmap.c             |  6 ------
> >  mm/struct_page_size.c            | 19 +++++++++++++++++++
> >  scripts/check_struct_page_po2.sh |  9 +++++++++
> >  7 files changed, 48 insertions(+), 6 deletions(-)
> >  create mode 100644 mm/struct_page_size.c
> >  create mode 100755 scripts/check_struct_page_po2.sh
> >
> > diff --git a/Kbuild b/Kbuild
> > index fa441b98c9f6..21415c3b2728 100644
> > --- a/Kbuild
> > +++ b/Kbuild
> > @@ -37,6 +37,20 @@ $(offsets-file): arch/$(SRCARCH)/kernel/asm-offsets.s FORCE
> >         $(call filechk,offsets,__ASM_OFFSETS_H__)
> >
> >  #####
> > +# Generate struct_page_size.h.
> > +
> > +struct_page_size-file := include/generated/struct_page_size.h
> > +
> > +always-y := $(struct_page_size-file)
> > +targets := mm/struct_page_size.s
> > +
> > +mm/struct_page_size.s: $(timeconst-file) $(bounds-file)
> > +
> > +$(struct_page_size-file): mm/struct_page_size.s FORCE
> > +       $(call filechk,offsets,__LINUX_STRUCT_PAGE_SIZE_H__)
> > +       $(Q)$(MAKE) -f $(srctree)/Makefile syncconfig
>
>
> No, please do not do this.
> It is terrible to feed back this to Kconfig again.

OK. I'll remove syncconfig.

>
> If you know this happens on !CONFIG_MEMCG && !CONFIG_SLUB on x86_64,
> why don't you add this dependency directly?

It is not enough since the size of the struct page also depends on
LAST_CPUPID_NOT_IN_PAGE_FLAGS && CONFIG_SLAB.
We cannot know the result of LAST_CPUPID_NOT_IN_PAGE_FLAGS in
Kconfig.

>
>
> If you want to avoid the run-time check,
> why don't you use  BUILD_BUG_ON() ?
>

Now I have another solution to avoid the run-time check.
We could use macro STRUCT_PAGE_SIZE_IS_POWER_OF_2
to do that like the following.

#ifdef STRUCT_PAGE_SIZE_IS_POWER_OF_2
/* code */
#endif

Thanks.
