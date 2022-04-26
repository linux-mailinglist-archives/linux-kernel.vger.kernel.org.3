Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE1451068E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 20:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350929AbiDZSTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 14:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350927AbiDZSTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 14:19:17 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683C68CDA6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 11:16:08 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id j2so34539485ybu.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 11:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NHalnczSrgV7nsCOyAK5ppIla2Ja271UVepo2Mtht40=;
        b=LMed7+3WdnbUqx53fGaZH7cklJ8mcbKUzxQ4vWrUD0JhVhD1z/0yPBo188RqR3Mqfy
         dRyraF6qUYiCKCr1DnJcAJXCyDB6E9df6SrzG41rsWsnrr3r8wwaIVWMq/5cYclFqhEK
         GiiXXU0PxM7lNxYyCZ6shfw3CGtEdBWheNRhRxkcQjtnpkvT2BenoTRFPM116SKAYtjW
         0s/aBVHnq+CV5f7KQ8F/lmtQB4kveuTKNTJN6xFggsEIutTZQYd3nboIlT8g83JmccaH
         SNvK/Hki8bM33pIsSbfYVi7/06kDHS/6O19532LA9rRIhEHWeOr/xL6R+z0/e0Od6olT
         fIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NHalnczSrgV7nsCOyAK5ppIla2Ja271UVepo2Mtht40=;
        b=gh+zgOeeo15fyED6RZBQZW/DRzwLcGoMOcjOVFmCnMTK2iXqOmvt2M4UlItddEkoiW
         RXIM7/gKhe9CyXa5sPQfD4AbaZuDgY60JyAJh8cJAzGobt44+5xXKcnrsMNf1SrGrdv7
         iJC0n8cwVoSOSkryzDClX7KBljHafwr4YEGP1WF/MJeMYsOrBhUW12Xxa72FZZgsq9/x
         oIEKRGcVyt+tNBx4ULt5shM3yaSqx+CoTeTwRahMnPu5z6eco6v9TkHG7CcxPg2PdNu8
         TQR4BCJdeG/ZcBjHv7Rfd/suEPI7qaoZ1bQb2bBasG1P70CNWrHRibJT4tpnKm92/Uac
         bMRw==
X-Gm-Message-State: AOAM533OasSVUmSRC7DPqkNEIm8mqHjtGnsDu918r2bADPjD/8yykvGZ
        xR+o1mszKEfoWAweamuoZFS62bmhrLlk+gNL83vnPw==
X-Google-Smtp-Source: ABdhPJz7V55S2LOXdb5KVVyv7qUZE5R5SmXc4kGPxdfbTmt31xyPMidCAhKnIhA50wcC6/lGYgkY4q2l0A1ifTcm4bA=
X-Received: by 2002:a25:b3c7:0:b0:623:e9fe:e108 with SMTP id
 x7-20020a25b3c7000000b00623e9fee108mr21492504ybf.335.1650996967408; Tue, 26
 Apr 2022 11:16:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220422201830.288018-1-pcc@google.com> <202204251346.WbwgrNZw-lkp@intel.com>
 <147b11c3-dbce-ccd3-3b0c-c5971135f949@suse.cz>
In-Reply-To: <147b11c3-dbce-ccd3-3b0c-c5971135f949@suse.cz>
From:   Peter Collingbourne <pcc@google.com>
Date:   Tue, 26 Apr 2022 11:15:56 -0700
Message-ID: <CAMn1gO7=PEz=TbDqBV+NnjyZ6pjOgYjAhfdcp4feSTX7W=B2ZA@mail.gmail.com>
Subject: Re: [PATCH v3] mm: make minimum slab alignment a runtime property
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     kernel test robot <lkp@intel.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pekka Enberg <penberg@kernel.org>, roman.gushchin@linux.dev,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 8:12 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 4/25/22 07:12, kernel test robot wrote:
> > Hi Peter,
> >
> > Thank you for the patch! Yet something to improve:
> >
> > [auto build test ERROR on hnaz-mm/master]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Peter-Collingbourne/mm-make-minimum-slab-alignment-a-runtime-property/20220423-042024
> > base:   https://github.com/hnaz/linux-mm master
> > config: arm64-buildonly-randconfig-r002-20220425 (https://download.01.org/0day-ci/archive/20220425/202204251346.WbwgrNZw-lkp@intel.com/config)
> > compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 1cddcfdc3c683b393df1a5c9063252eb60e52818)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install arm64 cross compiling tool for clang build
> >         # apt-get install binutils-aarch64-linux-gnu
> >         # https://github.com/intel-lab-lkp/linux/commit/3aef97055dd4a480e05dff758164f153aaddbb49
> >         git remote add linux-review https://github.com/intel-lab-lkp/linux
> >         git fetch --no-tags linux-review Peter-Collingbourne/mm-make-minimum-slab-alignment-a-runtime-property/20220423-042024
> >         git checkout 3aef97055dd4a480e05dff758164f153aaddbb49
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 prepare
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> >    In file included from kernel/bounds.c:10:
> >    In file included from include/linux/page-flags.h:10:
> >    In file included from include/linux/bug.h:5:
> >    In file included from arch/arm64/include/asm/bug.h:26:
> >    In file included from include/asm-generic/bug.h:22:
> >    In file included from include/linux/printk.h:9:
> >    In file included from include/linux/cache.h:6:
> >    In file included from arch/arm64/include/asm/cache.h:56:
> >    In file included from include/linux/kasan-enabled.h:5:
> >    In file included from include/linux/static_key.h:1:
>
> Hmm looks like a circular include, cache.h is too "low-level" in the
> hierarchy to bring in kasan->static_key->jump_label.h definitions?
> jump_label.h does include bug.h, but we have it above already and have
> already passed #define _LINUX_BUG_H.
>
> So, a different kind of header with arm64-specific variant?

The fix that I'm pursuing starts with:

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 1522df223c0f..8e8d74edf121 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -6,7 +6,6 @@
 #include <linux/init.h>
 #include <linux/kern_levels.h>
 #include <linux/linkage.h>
-#include <linux/cache.h>
 #include <linux/ratelimit_types.h>
 #include <linux/once_lite.h>

and fixing the fallout from code that was including printk.h and
depending on something from cache.h. So far I haven't found much, only
3 fixups required for an arm64 defconfig kernel but I'm trying some
more configs as well.

Peter
