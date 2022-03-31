Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567084ED191
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 04:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243451AbiCaCQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 22:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbiCaCQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 22:16:44 -0400
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7256D673D7;
        Wed, 30 Mar 2022 19:14:57 -0700 (PDT)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 22V2EQMo007232;
        Thu, 31 Mar 2022 11:14:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 22V2EQMo007232
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1648692866;
        bh=BaRp588wc7dVUEEVQWMHZfUjZMtEZadbAHPcQ/hMAkU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xXyuTg2uoeV2iCeOmdsJ3N8arzhbN9bqVGxPbQZuLke8JuBeDl25ey6+I8Bhiup2r
         bEp8nhzKYiQezWa6jVAxTf3/309UtXKzwfo9CNoQp14fsutq7RFxcixfgSbMm9B8qd
         8G1ybyjJoPcvmMGUvmPxKOzmD8Fhf+lrPcbZJOAsBe1T95qk1lfGa0l0AM+BCm1H0W
         XXAU0Gux3QsatzGQJFZLe55zYZRqPyHPqgDdLLlkN+5BMMKed8zrXRgajttGAmEA5D
         oLzcqSs0RRzWhgh+7F0p0Q6zjZAJ5x6b/j9mziA/5FBsP49FVnLFWJQAz9q8NU1IQm
         fbBpsRPTRCZ+w==
X-Nifty-SrcIP: [209.85.216.54]
Received: by mail-pj1-f54.google.com with SMTP id y16so9871898pju.4;
        Wed, 30 Mar 2022 19:14:26 -0700 (PDT)
X-Gm-Message-State: AOAM531H/KWHfUOq0La8l1fC3z549m2ck16alUUZKLP5VD1gamLJfYUK
        RPdWWeR0myUdsfQJB5n3y2kbdb50mjMPaTXyoxw=
X-Google-Smtp-Source: ABdhPJy4I4mU1PAohqgbK9L5D4+YKEnUO4wM8Bl+1FwbZgKiyiaUdcBZngVQ9P62sngmvcBIIuH8+cw4h4/oOZGLhrU=
X-Received: by 2002:a17:902:b68c:b0:153:bd06:85ad with SMTP id
 c12-20020a170902b68c00b00153bd0685admr2957565pls.99.1648692865835; Wed, 30
 Mar 2022 19:14:25 -0700 (PDT)
MIME-Version: 1.0
References: <164847778869.3060675.8115416881394543419.stgit@devnote2>
 <CAKwvOdmAYQZtzGudBjmiRZNjT+VixTdNbJmYmxc7-gQNCsHfrA@mail.gmail.com> <20220331104531.81d0edf9a85a4f69020a9f13@kernel.org>
In-Reply-To: <20220331104531.81d0edf9a85a4f69020a9f13@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 31 Mar 2022 11:13:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQU4-CNUJGzsO_kx4SrwNWrd=vnObWkuyV063imZcGFsw@mail.gmail.com>
Message-ID: <CAK7LNAQU4-CNUJGzsO_kx4SrwNWrd=vnObWkuyV063imZcGFsw@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] bootconfig: Support embedding a bootconfig in
 kernel for non initrd boot
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Padmanabha Srinivasaiah <treasure4paddy@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 10:45 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Hi Nick,
>
> On Wed, 30 Mar 2022 11:04:50 -0700
> Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> > On Mon, Mar 28, 2022 at 7:29 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > >
> > > KNOWN ISSUE:
> > >
> > > According to the report from Padmanabha[3] and my analysis [4], the embedded
> > > bootconfig data may not be updated if you do incremental build the kernel
> > > with CONFIG_LTO_CLANG_THIN.
> > >
> > > [3] https://lore.kernel.org/all/20220321183500.GA4065@pswork/T/#u
> > > [4] https://lore.kernel.org/all/20220327115526.cc4b0ff55fc53c97683c3e4d@kernel.org/
> > >
> > > This seems like clang's LTO Thin mode issue. It may not detect the inline
> > > asm depends on external files.
> > >
> > > I think the possible workaround is to split the inline asm which includes
> > > '.incbin' directive into an asm file. But this should be done in another
> > > seires because there are other features which uses '.incbin'. (e.g.
> > > /proc/config.gz)
> >
> > Hi Masami,
> > I saw Padmanabha's report (thanks for the report); sorry for not
> > responding sooner, I've been traveling recently for a funeral.
>
> Oh, sorry about that. I think this is not so hurry.
>
> >
> > Any chance we can use
> >
> > CFLAGS_REMOVE_<file>.o := $(CC_FLAGS_LTO)
> >
> > a la
> > commit d2dcd3e37475 ("x86, cpu: disable LTO for cpu.c")
>
> Hm, this looks good to me. Let me confirm that works.
> (Does this mean the bootconfig.o will be compiled to elf binary?)


Why are you using  ".incbin" in the C file in the first place?


You might have mimicked  kernel/configs.c
but there was a reason;  kernel/configs.c can be a module,
but we cannot put MODULE_LICENSE() in *.S  file.
(commit 13610aa908dcfce77135bb799c0a10d0172da6ba)


In this case, CONFIG_EMBED_BOOT_CONFIG is a bool
option.

Why don't you simply move the asm() part to a separate
bootconfig-data.S ?

Clang lto flags are only passed to *.c files,
so we do not need to be worried about  .incbin in *.S files.


Then, Makefile will be even cleaner (no ifeq-block)


lib-$(CONFIG_BOOT_CONFIG) += bootconfig.o
obj-$(CONFIG_EMBED_BOOT_CONFIG) += bootconfig-data.o

$(obj)/bootconfig-data.o: $(obj)/default.bconf

targets += default.bconf
filechk_defbconf = cat $(or $(real-prereqs), /dev/null)
$(obj)/default.bconf: $(CONFIG_EMBED_BOOT_CONFIG_FILE) FORCE
        $(call filechk,defbconf)





BTW, why lib-$(CONFIG_BOOT_CONFIG),
instead of obj-$(CONFIG_BOOT_CONFIG)  ?



>
> >
> > with a comment linking to
> > https://github.com/ClangBuiltLinux/linux/issues/1618
>
> Thanks for reporting!
>
> >
> > for the Translation Units using .incbin, until we have had more time
> > to triage+fix?
>
> Yes. For this series, I can update with above one, but it doesn't cover the
> other parts. And since this issue is independent from the bootconfig,
> I think we need a wider patch series to mitigate this issue on config.gz
> (and other .incbin users) too.
>
> Thank you,
>
> >
> > --
> > Thanks,
> > ~Nick Desaulniers
>
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>




--
Best Regards
Masahiro Yamada
