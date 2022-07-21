Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B1757D60C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 23:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbiGUVeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 17:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbiGUVeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 17:34:00 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2EA93608
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 14:33:56 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id b11so5297815eju.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 14:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6xUsjVHY4IFcGnNL3OHzfi3JB5gT58E2JC8oUj6p4aw=;
        b=QK5KgP4Pw8Qhd81Gt7Q/YqCKFqcFaVIzeAogVjNZziqjSL7qGMk8SdNI4JGDbn4bG4
         f/n92TTgYo5Ji0MoMMclGV2jdemeszTxbjdfb4GuMmsC3s7S0gEDqRG2tyCN7GMHTdPA
         T1CW8NeOhwjlVhZ0ZIH+S7SIAattFW6Yll0JijutGeeLAGACCjbKmgr6tdy/5lpz7+nr
         tH/RDM60E/w2cxzUNrP9EWsZ0dAO+aEQY407TAQ7YSoobmY1I3J97lupDeF8iz3sUSP+
         YXLaZzd0iBkiWDFshO4NbIzrrYpCQbae6bpb30mzGdx0FB/wT1V4jkXDoXE3VSOaKMYR
         ALww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6xUsjVHY4IFcGnNL3OHzfi3JB5gT58E2JC8oUj6p4aw=;
        b=H63RnOP5Pd/B+sOJeTst7XyzQHzqspBIjxRbKQLU3JlOL/GDIXwAPGXYDAbLvaB4r1
         FTrKz1qqrwdGD1PlbfulLvVZm5OPNLi3F6dWK8NChii+yxVR8Fz6AeFvymhEFWXpOPi8
         lkhkwJID7s/EuTPItQWL5kDzIaa5SpH+s6+KnpYJ2Y8itIR5hvxmyLxcG7c7AyJAyeUf
         iK/uTYswcStCSIQmkTj5FGk2YvJ3CIluy5QEGE+T7zc3K/FPTQ0MTsfRAJHoQzKkqPGP
         dXZiSOgGKkgg6GIb8bzGDgkqzvBv3oKGS7Q7do7W5Z44nNp2xs9u+D6YT9R2wrVeRo1/
         W9TQ==
X-Gm-Message-State: AJIora9EVB9dv+A4L84pTQZDjJ/1KWeC88+K/L7UVSJ4m1xKjro1hF86
        fC79huIka8VzQLZhGsWxi2GdwPL8kVQABgjB7fBCtw==
X-Google-Smtp-Source: AGRyM1t+5Z1ri6oq59SvaDNCDL7Tqss8HA7T2eDkmR3PEXwm6aUMQ9ZPJ5JCeCC5LfviidyjdZnUI3NCNtMK7CwGFTc=
X-Received: by 2002:a17:906:5a67:b0:72b:610d:4aa4 with SMTP id
 my39-20020a1709065a6700b0072b610d4aa4mr501939ejc.294.1658439234626; Thu, 21
 Jul 2022 14:33:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220720232332.2720091-1-justinstitt@google.com>
 <CAKwvOdnSjyOdCZZ9AegCyfns3bvH3fbtbVgdThO2+rJAE=1bag@mail.gmail.com>
 <YtlsY2A2ZWK97Y8O@dev-arch.thelio-3990X> <YtmrCJjQrSbv8Aj1@dev-arch.thelio-3990X>
In-Reply-To: <YtmrCJjQrSbv8Aj1@dev-arch.thelio-3990X>
From:   Justin Stitt <justinstitt@google.com>
Date:   Thu, 21 Jul 2022 14:33:43 -0700
Message-ID: <CAFhGd8pk+0XEz0tMiJcwMM7B3NYF=yF4cHW8A-6-81SgpKFPNw@mail.gmail.com>
Subject: Re: [PATCH] Makefile.extrawarn: re-enable -Wformat for clang
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
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

On Thu, Jul 21, 2022 at 12:37 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Thu, Jul 21, 2022 at 08:10:27AM -0700, Nathan Chancellor wrote:
> > On Thu, Jul 21, 2022 at 07:27:34AM -0700, Nick Desaulniers wrote:
> > > On Wed, Jul 20, 2022 at 4:23 PM Justin Stitt <justinstitt@google.com> wrote:
> > > >
> > > > There's been an ongoing mission to re-enable the -Wformat warning for
> > > > Clang. A previous attempt at enabling the warning showed that there were
> > > > many instances of this warning throughout the codebase. The sheer amount
> > > > of these warnings really polluted builds and thus -Wno-format was added
> > > > to _temporarily_ toggle them off.
> > > >
> > > > After many patches the warning has largely been eradicated for x86,
> > > > x86_64, arm, and arm64 on a variety of configs. The time to enable the
> > > > warning has never been better as it seems for the first time we are
> > > > ahead of them and can now solve them as they appear rather than tackling
> > > > from a backlog.
> > > >
> > > > As to the root cause of this large backlog of warnings, Clang seems to
> > > > pickup on some more nuanced cases of format warnings caused by implicit
> > > > integer conversion as well as default argument promotions from
> > > > printf-like functions.
> > > >
> > > >
> > > > Link: https://github.com/ClangBuiltLinux/linux/issues/378
> > > > Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> > > > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > > > ---
> > > > Previous attempt: (https://patchwork.kernel.org/project/linux-kbuild/patch/20190201210853.244043-1-jflat@chromium.org/)
> > > >
> > > > Note:
> > > > For this patch to land on its feet, the plethora of supporting patches that
> > > > fixed various -Wformat warnings need to be picked up. Thanfully, a lot
> > > > of them have!
> > > >
> > > > Here are the patches still waiting to be picked up:
> > > > * https://lore.kernel.org/all/20220718230626.1029318-1-justinstitt@google.com/
> > > > * https://lore.kernel.org/all/20220711222919.2043613-1-justinstitt@google.com/
> > >
> > > Hi Masahiro, Nathan, and Tom,
> > > What are your thoughts for _when_ in the release cycle this should be
> > > picked up?  I worry that if we don't remove this soon, we will
> > > backslide, and more -Wformat issues will crop up making removing this
> > > in the future like digging in sand.  Justin has chased down many
> > > instances of this warning, and I'm happy to help clean up fallout from
> > > landing this.
> >
> > Let me do a series of builds with the two patches above against
> > next-20220721 to see if there are any instances of this warning across
> > the less frequently tested architectures then I will review/ack this.
>
> Alright, against next-20220721, I applied:
>
> * https://lore.kernel.org/20220712204900.660569-1-justinstitt@google.com/ (applied to net-next, just not in this -next release)
> * https://lore.kernel.org/20220718230626.1029318-1-justinstitt@google.com/ (not picked up)
> * https://lore.kernel.org/20220711222919.2043613-1-justinstitt@google.com/ (not picked up)
>
> I still see the following warnings. I have suggested fixes, which I am happy to
> send unless Justin wants to.

Thanks for reporting these. I got the patches sent out!

I added bookkeeping below each warning.

>
> ========================================================================
>
> ARCH=arm allmodconfig:
>
> ../drivers/iommu/msm_iommu.c:603:6: error: format specifies type 'unsigned short' but the argument has type 'int' [-Werror,-Wformat]
>                                  sid);
>                                  ^~~
> ../include/linux/dev_printk.h:146:70: note: expanded from macro 'dev_warn'
>         dev_printk_index_wrap(_dev_warn, KERN_WARNING, dev, dev_fmt(fmt), ##__VA_ARGS__)
>                                                                     ~~~     ^~~~~~~~~~~
> ../include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
>                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
>                              ~~~    ^~~~~~~~~~~
> 1 error generated.
>
> Introduced by commit f78ebca8ff3d ("iommu/msm: Add support for generic master
> bindings").
>
> diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
> index 428919a474c1..6a24aa804ea3 100644
> --- a/drivers/iommu/msm_iommu.c
> +++ b/drivers/iommu/msm_iommu.c
> @@ -599,7 +599,7 @@ static int insert_iommu_master(struct device *dev,
>
>         for (sid = 0; sid < master->num_mids; sid++)
>                 if (master->mids[sid] == spec->args[0]) {
> -                       dev_warn(dev, "Stream ID 0x%hx repeated; ignoring\n",
> +                       dev_warn(dev, "Stream ID 0x%x repeated; ignoring\n",
>                                  sid);
>                         return 0;
>                 }
>

Patch: https://lore.kernel.org/all/20220721210331.4012015-1-justinstitt@google.com/

> ========================================================================
>
> ARCH=hexagon allmodconfig + CONFIG_FRAME_WARN=0:
>
> ../drivers/misc/lkdtm/bugs.c:107:3: error: format specifies type 'unsigned long' but the argument has type 'int' [-Werror,-Wformat]
>                 REC_STACK_SIZE, recur_count);
>                 ^~~~~~~~~~~~~~
> ../include/linux/printk.h:537:34: note: expanded from macro 'pr_info'
>         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
>                                 ~~~     ^~~~~~~~~~~
> ../include/linux/printk.h:464:60: note: expanded from macro 'printk'
> #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
>                                                     ~~~    ^~~~~~~~~~~
> ../include/linux/printk.h:436:19: note: expanded from macro 'printk_index_wrap'
>                 _p_func(_fmt, ##__VA_ARGS__);                           \
>                         ~~~~    ^~~~~~~~~~~
> ../drivers/misc/lkdtm/bugs.c:32:24: note: expanded from macro 'REC_STACK_SIZE'
> #define REC_STACK_SIZE (THREAD_SIZE / 8)
>                        ^~~~~~~~~~~~~~~~~
> 1 error generated.
>
> Introduced by commit 24cccab42c41 ("lkdtm/bugs: Adjust recursion test to avoid
> elision").
>
> diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
> index 009239ad1d8a..6381255aaecc 100644
> --- a/drivers/misc/lkdtm/bugs.c
> +++ b/drivers/misc/lkdtm/bugs.c
> @@ -29,7 +29,7 @@ struct lkdtm_list {
>  #if defined(CONFIG_FRAME_WARN) && (CONFIG_FRAME_WARN > 0)
>  #define REC_STACK_SIZE (_AC(CONFIG_FRAME_WARN, UL) / 2)
>  #else
> -#define REC_STACK_SIZE (THREAD_SIZE / 8)
> +#define REC_STACK_SIZE ((unsigned long)(THREAD_SIZE / 8))
>  #endif
>  #define REC_NUM_DEFAULT ((THREAD_SIZE / REC_STACK_SIZE) * 2)
>
>

Patch: https://lore.kernel.org/all/20220721212012.4060328-1-justinstitt@google.com/

> ========================================================================
>
> ARCH=arm allmodconfig:
>
> ../drivers/nvme/target/auth.c:492:18: error: format specifies type 'unsigned long' but the argument has type 'size_t' (aka 'unsigned int') [-Werror,-Wformat]
>                         ctrl->cntlid, ctrl->dh_keysize, buf_size);
>                                       ^~~~~~~~~~~~~~~~
> ../include/linux/printk.h:517:37: note: expanded from macro 'pr_warn'
>         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
>                                    ~~~     ^~~~~~~~~~~
> ../include/linux/printk.h:464:60: note: expanded from macro 'printk'
> #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
>                                                     ~~~    ^~~~~~~~~~~
> ../include/linux/printk.h:436:19: note: expanded from macro 'printk_index_wrap'
>                 _p_func(_fmt, ##__VA_ARGS__);                           \
>                         ~~~~    ^~~~~~~~~~~
> 1 error generated.
>
> Introduced by commit 71ebe3842ebe ("nvmet-auth: Diffie-Hellman key exchange
> support").
>
> This one is not clang specific and already has a fix pending:
>
> https://lore.kernel.org/20220718050356.227647-1-hch@lst.de/
Patch: ^^^^^^^^^
>
> ========================================================================
>
> Pretty much every allmodconfig:
>
> ../sound/soc/sof/ipc3-topology.c:2343:4: error: format specifies type 'unsigned char' but the argument has type 'int' [-Werror,-Wformat]
>                  SOF_ABI_MAJOR, SOF_ABI_MINOR, SOF_ABI_PATCH);
>                  ^~~~~~~~~~~~~
> ../include/linux/dev_printk.h:150:67: note: expanded from macro 'dev_info'
>         dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
>                                                                  ~~~     ^~~~~~~~~~~
> ../include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
>                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
>                              ~~~    ^~~~~~~~~~~
> ../include/uapi/sound/sof/abi.h:30:23: note: expanded from macro 'SOF_ABI_MAJOR'
> #define SOF_ABI_MAJOR 3
>                       ^
> ../sound/soc/sof/ipc3-topology.c:2343:19: error: format specifies type 'unsigned char' but the argument has type 'int' [-Werror,-Wformat]
>                  SOF_ABI_MAJOR, SOF_ABI_MINOR, SOF_ABI_PATCH);
>                                 ^~~~~~~~~~~~~
> ../include/linux/dev_printk.h:150:67: note: expanded from macro 'dev_info'
>         dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
>                                                                  ~~~     ^~~~~~~~~~~
> ../include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
>                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
>                              ~~~    ^~~~~~~~~~~
> ../include/uapi/sound/sof/abi.h:31:23: note: expanded from macro 'SOF_ABI_MINOR'
> #define SOF_ABI_MINOR 22
>                       ^~
> ../sound/soc/sof/ipc3-topology.c:2343:34: error: format specifies type 'unsigned char' but the argument has type 'int' [-Werror,-Wformat]
>                  SOF_ABI_MAJOR, SOF_ABI_MINOR, SOF_ABI_PATCH);
>                                                ^~~~~~~~~~~~~
> ../include/linux/dev_printk.h:150:67: note: expanded from macro 'dev_info'
>         dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
>                                                                  ~~~     ^~~~~~~~~~~
> ../include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
>                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
>                              ~~~    ^~~~~~~~~~~
> ../include/uapi/sound/sof/abi.h:32:23: note: expanded from macro 'SOF_ABI_PATCH'
> #define SOF_ABI_PATCH 0
>                       ^
> 3 errors generated.
>
> Introduced by commit 323aa1f093e6 ("ASoC: SOF: Add a new IPC op for parsing
> topology manifest") for little reason it seems?
>
> diff --git a/sound/soc/sof/ipc3-topology.c b/sound/soc/sof/ipc3-topology.c
> index b2cc046b9f60..65923e7a5976 100644
> --- a/sound/soc/sof/ipc3-topology.c
> +++ b/sound/soc/sof/ipc3-topology.c
> @@ -2338,7 +2338,7 @@ static int sof_ipc3_parse_manifest(struct snd_soc_component *scomp, int index,
>         }
>
>         dev_info(scomp->dev,
> -                "Topology: ABI %d:%d:%d Kernel ABI %hhu:%hhu:%hhu\n",
> +                "Topology: ABI %d:%d:%d Kernel ABI %d:%d:%d\n",
>                  man->priv.data[0], man->priv.data[1], man->priv.data[2],
>                  SOF_ABI_MAJOR, SOF_ABI_MINOR, SOF_ABI_PATCH);
>
>

Patch: https://lore.kernel.org/all/20220721211218.4039288-1-justinstitt@google.com/

> ========================================================================
>
> I would really like to see patches in flight for these before this patch
> is accepted but it is really awesome to see how close we are :)
>
> Cheers,
> Nathan

-Justin
