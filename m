Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659414F72AF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 05:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbiDGDLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 23:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239823AbiDGDLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 23:11:17 -0400
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D173D21A0DB;
        Wed,  6 Apr 2022 20:08:46 -0700 (PDT)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 23738PKt004818;
        Thu, 7 Apr 2022 12:08:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 23738PKt004818
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1649300905;
        bh=lz12cTiaDiO+TL8jlSZOZjXEzJZWXC8B9X7PhEBLIlA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GNfTfySCJG4XngQ3SggY+S2KlsuVAu7ItuQwAE5SoPrOWgwAG2wO7O4A7tN6Wv0BU
         h7hlBues3HGCt6N/vmCJJrVgFbCas5ZzxHK43tah4c7hZOWsoGRTd4buwp2W+JguEn
         /UKWsIuGt/NJbN1Ov2Sbnbx8MbjKDRgUAbTrmxdHgahksxS30f0sYdYhmNRBjYS+/C
         jLV7ILFMxriRXZvNNSwLC7n7qo++rnsmNIa4w6pjhdPJqGjsNkixkyMi4O4/IQqpBb
         r06m0cKuqoHfdh+OMCFEP7my3FlqCcUIA6EeUf2LeDZIoqnJBfTMcAsshxObPmaC/8
         PpjVSlpV2s/uw==
X-Nifty-SrcIP: [209.85.216.41]
Received: by mail-pj1-f41.google.com with SMTP id n6-20020a17090a670600b001caa71a9c4aso4888666pjj.1;
        Wed, 06 Apr 2022 20:08:25 -0700 (PDT)
X-Gm-Message-State: AOAM530wXYeg46U0lxZ5GuoQU+3TMwydDurQAGqGaGiK5KLWD8km2eue
        ECgeSaoBBJLVu+fzKy7XUGaFFayH5Oo8edJEZcY=
X-Google-Smtp-Source: ABdhPJzlZRKhkwV5MU4RvXfPq8Vhv48IcrBcAga8kUFYVd3Fi1XSyXb3I+RYsY89ZiFO5wu2RkhRHOSSXCpJKw0IcXM=
X-Received: by 2002:a17:902:b183:b0:14f:c266:20d5 with SMTP id
 s3-20020a170902b18300b0014fc26620d5mr11858079plr.136.1649300904628; Wed, 06
 Apr 2022 20:08:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220406153023.500847-1-masahiroy@kernel.org> <20220406153023.500847-8-masahiroy@kernel.org>
 <960102bb-2944-4be0-ab09-7cd2eb0c2cf9@quicinc.com>
In-Reply-To: <960102bb-2944-4be0-ab09-7cd2eb0c2cf9@quicinc.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 7 Apr 2022 12:07:34 +0900
X-Gmail-Original-Message-ID: <CAK7LNAStLCBCur3QnfMnBrOUkixYbJK+C6TZVKYcGX9R3M=ANQ@mail.gmail.com>
Message-ID: <CAK7LNAStLCBCur3QnfMnBrOUkixYbJK+C6TZVKYcGX9R3M=ANQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] kbuild: read *.mod to get objects passed to $(LD) or $(AR)
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 7, 2022 at 3:13 AM Jeff Johnson <quic_jjohnson@quicinc.com> wrote:
>
> On 4/6/2022 8:30 AM, Masahiro Yamada wrote:
> > ld and ar support @file, which command-line options are read from.
> >
> > Now that *.mod lists the member objects in the correct order, without
> > duplication, it is ready to be passed to ld and ar.
> >
> > By using the @file syntax, people will not be worried about the pitfall
> > described in the NOTE.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >   scripts/Makefile.build | 10 +++-------
> >   1 file changed, 3 insertions(+), 7 deletions(-)
> >
> > diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> > index 3da731cf6978..f6a506318795 100644
> > --- a/scripts/Makefile.build
> > +++ b/scripts/Makefile.build
> > @@ -450,22 +450,18 @@ quiet_cmd_ar_lib = AR      $@
> >   $(obj)/lib.a: $(lib-y) FORCE
> >       $(call if_changed,ar_lib)
> >
> > -# NOTE:
> > -# Do not replace $(filter %.o,^) with $(real-prereqs). When a single object
> > -# module is turned into a multi object module, $^ will contain header file
> > -# dependencies recorded in the .*.cmd file.
> >   ifneq ($(CONFIG_LTO_CLANG)$(CONFIG_X86_KERNEL_IBT),)
> >   quiet_cmd_link_multi-m = AR [M]  $@
> >   cmd_link_multi-m =                                          \
> >       $(cmd_update_lto_symversions);                          \
> >       rm -f $@;                                               \
> > -     $(AR) cDPrsT $@ $(filter %.o,$^)
> > +     $(AR) cDPrsT $@ @$(patsubst %.o,%.mod,$@)
> >   else
> >   quiet_cmd_link_multi-m = LD [M]  $@
> > -      cmd_link_multi-m = $(LD) $(ld_flags) -r -o $@ $(filter %.o,$^)
> > +      cmd_link_multi-m = $(LD) $(ld_flags) -r -o $@ @$(patsubst %.o,%.mod,$@)
> >   endif
> >
> > -$(multi-obj-m): FORCE
> > +$(multi-obj-m): %.o: %.mod FORCE
> >       $(call if_changed,link_multi-m)
> >   $(call multi_depend, $(multi-obj-m), .o, -objs -y -m)
> >
>
> Looks like this also addresses the out-of-tree issue described in
> <https://lore.kernel.org/linux-kbuild/1610500731-30960-2-git-send-email-jjohnson@codeaurora.org/>
>
> :)
>
> /jeff

But, not perfectly.

This patch fixed the linker part, but the same issue is remaining in cmd_mod.

The following patch is an easy fix-up.



diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index f6a506318795..468f9e646370 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -303,8 +303,8 @@ $(obj)/%.prelink.o: $(obj)/%.o FORCE
        $(call if_changed,cc_prelink_modules)
 endif

-cmd_mod = echo $(addprefix $(obj)/, $(call real-search, $*.o, .o,
-objs -y -m)) | \
-       $(AWK) -v RS='( |\n)' '!x[$$0]++' > $@
+cmd_mod = echo $(call real-search, $*.o, .o, -objs -y -m) | \
+       $(AWK) -v RS='( |\n)' '!x[$$0]++ { print("$(obj)/"$$0) }' > $@

 $(obj)/%.mod: FORCE
        $(call if_changed,mod)





But, please do not submit a patch yet.


This patch series is just preparation for yet another
bigger clean-up.

One of my big goals is to clean up Clang LTO builds.

Clang LTO made Kbuild really ugly.

I am re-implementing various parts, but I have not
completed the work yet.

Meanwhile, I incrementally submit prerequisite
refactoring patches.

The issues of external module builds _might_ be fixed
as a side-effect of other refactoring, but I am more
interested in what the final code will look like.

--
Best Regards
Masahiro Yamada
