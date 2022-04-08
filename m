Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190A14F8B43
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 02:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbiDHAKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 20:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbiDHAKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 20:10:38 -0400
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7192BE947;
        Thu,  7 Apr 2022 17:08:33 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 238089EW029103;
        Fri, 8 Apr 2022 09:08:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 238089EW029103
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1649376491;
        bh=3ILE9JjEnGHo6rfpgFl4AXhrp2l7GfDIN7jxy6B5b/M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lbFhIYT+/fptE5yUWn+pDOgRM7CMCQawW3yqw4/loG5V6ZGHQRRrvJbXRPaIv4IW/
         w/xVZq9D4QT+DavM13yRuIBLxI7YqTcwJ1eqsMAF23bbuvCVhZNK8zv0GDSXKKODNJ
         KRIebOVC0E5sa+6PEPjpio+bEPUvuph2k+nP2AMQaUP14icavp6h5it71D9Zj01WbO
         Ny5Pb0o8vgpzV3lsT7RzHT+NfHZb5Q9z9VuARYJ7JmY+B38uX0X7T8xmIwcXqryPHJ
         dT3y7msDAKmfvHGbIycLxtZiauPK48so15R+sOCIYqi+5uE44Gp8RLCijMYUeSKIZv
         alK/ivHmUe/bg==
X-Nifty-SrcIP: [209.85.167.41]
Received: by mail-lf1-f41.google.com with SMTP id b21so12355894lfb.5;
        Thu, 07 Apr 2022 17:08:10 -0700 (PDT)
X-Gm-Message-State: AOAM530WXU+VIA8TmsAEzI/h+q8Xh6fejtcuwsvYIGL1whUbS8CSvMMc
        kKHGyouLGPdcssjOmXthO2mKkH7pYgVv0LZmWcU=
X-Google-Smtp-Source: ABdhPJz/1J7aUgUB5l1O2+Oj11/+4pVPmBB5llgfuikmpnjBemMRE3oeyBbB6mGCOkdTBOH8bhzYtTEyrY7n4dzDj+c=
X-Received: by 2002:a05:6512:33cb:b0:464:f5f4:22cb with SMTP id
 d11-20020a05651233cb00b00464f5f422cbmr3647801lfg.186.1649376489197; Thu, 07
 Apr 2022 17:08:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220406153023.500847-1-masahiroy@kernel.org> <20220406153023.500847-6-masahiroy@kernel.org>
 <CAKwvOdnHneCy6YeanmvDrabYMWysfQ=WMopsT_gRyrruT8=1Dw@mail.gmail.com>
In-Reply-To: <CAKwvOdnHneCy6YeanmvDrabYMWysfQ=WMopsT_gRyrruT8=1Dw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 8 Apr 2022 09:07:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNATUv2YqGLGMTjzoCWf2tVkeYe6O9xa==wdDr0pgvSnnLQ@mail.gmail.com>
Message-ID: <CAK7LNATUv2YqGLGMTjzoCWf2tVkeYe6O9xa==wdDr0pgvSnnLQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] kbuild: get rid of duplication in *.mod files
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
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

On Fri, Apr 8, 2022 at 2:55 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Wed, Apr 6, 2022 at 8:31 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > It is allowed to add the same objects multiple times to obj-y / obj-m:
> >
> >   obj-y += foo.o foo.o foo.o
> >   obj-m += bar.o bar.o bar.o
> >
> > It is also allowed to add the same objects multiple times to a composite
> > module:
> >
> >   obj-m    += foo.o
> >   foo-objs := foo1.o foo2.o foo2.o foo1.o
> >
> > This flexibility is useful because the same object might be selected by
> > different CONFIG options, like this:
> >
> >   obj-m               += foo.o
> >   foo-y               := foo1.o
> >   foo-$(CONFIG_FOO_X) += foo2.o
> >   foo-$(CONFIG_FOO_Y) += foo2.o
> >
> > The duplicated objects are omitted at link time. It works naturally in
> > Makefiles because GNU Make removes duplication in $^ without changing
> > the order.
> >
> > It is working well, almost...
> >
> > A small flaw I notice is, *.mod contains duplication in such a case.
> >
> > This is probably not a big deal. As far as I know, the only small
> > problem is scripts/mod/sumversion.c parses the same file multiple
> > times.
> >
> > I am fixing this because I plan to reuse *.mod for other purposes,
> > where the duplication can be problematic.
> >
> > The code change is quite simple. We already use awk to drop duplicated
> > lines in modules.order (see cmd_modules_order in the same file).
>
> Why does the top level Makefile reassign cmd_modules_order rather than
> use the original value in scripts/Makefile.build?


Because the top level Makefile does not include scripts/Makefile.build



> > I copied the code, but changed RS to use spaces as record separators.
> >
> > I also changed the file format to list one object per line.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  scripts/Makefile.build   | 3 ++-
> >  scripts/mod/sumversion.c | 2 +-
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> > index 6ae92d119dfa..f7a30f378e20 100644
> > --- a/scripts/Makefile.build
> > +++ b/scripts/Makefile.build
> > @@ -303,7 +303,8 @@ $(obj)/%.prelink.o: $(obj)/%.o FORCE
> >         $(call if_changed,cc_prelink_modules)
> >  endif
> >
> > -cmd_mod = echo $(addprefix $(obj)/, $(call real-search, $*.o, .o, -objs -y -m)) > $@
> > +cmd_mod = echo $(addprefix $(obj)/, $(call real-search, $*.o, .o, -objs -y -m)) | \
> > +       $(AWK) -v RS='( |\n)' '!x[$$0]++' > $@
>
> God AWK is unreadable. Any reason we can't use GNU make's sort builtin?
> https://www.gnu.org/software/make/manual/html_node/Text-Functions.html


I did that in the previous submission.
https://lore.kernel.org/lkml/20220405113359.2880241-8-masahiroy@kernel.org/


After some thoughts, I decided to drop duplicates without sorting.

If I alphabetically sorted the object list,
7/7 of this series would be impossible.


I am not a big fan of AWK, but I do not know a cleaner way.
If you know a better idea, please tell me.


-- 
Best Regards
Masahiro Yamada
