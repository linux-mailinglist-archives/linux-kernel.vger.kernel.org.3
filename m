Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9CC4D1263
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 09:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345012AbiCHIjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 03:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344998AbiCHIjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 03:39:09 -0500
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5371D302;
        Tue,  8 Mar 2022 00:38:13 -0800 (PST)
Received: by mail-qk1-f170.google.com with SMTP id q4so14197036qki.11;
        Tue, 08 Mar 2022 00:38:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EOwxd04/4/kj/T/nPio4Op2b4/YeB/0jSlIXRERfWek=;
        b=LPvxndiY9l/5RkNBuH8/DoxmR9I6zM7geWY5o6arqTD34v/V5KDky2rPAhCjmE+dvP
         dW56yazmC+BPHJpPNCp8Sz7hNPMi8ZLr6UocQ+JZG6G9r3QA0ipOFyPSaJMLyY+sQUy4
         FdB4tcM8rnptwfG1eUbbaiPTCmg2U2BypC8cZ79XtADYwJJjU24D5I8aOZFEIIWi88Kv
         TLjpXb+NAgfZYWvUQSb1tpDjb5iBUOlXFi7ih6MJFEYP+DurPORrI1hhFF5v+Pmnacw1
         kGn+YER6ZyYYpQqo38VEsElqL+xkG3t5Cn3j41WPA8iXv79uXBtN1cj+tnMgCwrhCmC4
         V8jA==
X-Gm-Message-State: AOAM532m2ZV0lZMBW6aFgZDpTznrS688j7OTRm0htzNnDdxlFHjKARhP
        3FW6kyLLvZlu1TTR699iBMQhyiE86D85/A==
X-Google-Smtp-Source: ABdhPJyLmyzT9hM9zAtxOObKTPjX7TSXf3yXBppxCtaZbVg+yw9x/E9uTBnv4dqyaCVC3okUyFZr0w==
X-Received: by 2002:a37:acb:0:b0:67b:15f9:55b8 with SMTP id 194-20020a370acb000000b0067b15f955b8mr6346717qkk.694.1646728691864;
        Tue, 08 Mar 2022 00:38:11 -0800 (PST)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id k125-20020a378883000000b006491db6dbb1sm7568185qkd.84.2022.03.08.00.38.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 00:38:11 -0800 (PST)
Received: by mail-yb1-f174.google.com with SMTP id g1so36294662ybe.4;
        Tue, 08 Mar 2022 00:38:11 -0800 (PST)
X-Received: by 2002:a25:bc8f:0:b0:628:8649:5c4b with SMTP id
 e15-20020a25bc8f000000b0062886495c4bmr10892276ybk.207.1646728690920; Tue, 08
 Mar 2022 00:38:10 -0800 (PST)
MIME-Version: 1.0
References: <20220303224237.2497570-1-robh@kernel.org> <20220303224237.2497570-3-robh@kernel.org>
 <CAMuHMdUzu2PMN7ZerX=D0KsiqKZFDW5dVe3BY77wR=H-grrPVA@mail.gmail.com> <YiY6LNfEGhz1hSYg@robh.at.kernel.org>
In-Reply-To: <YiY6LNfEGhz1hSYg@robh.at.kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Mar 2022 09:37:58 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVFexJ=NT4wX4v2s3K--znQCiahskbGtEci3xwgsyEQWA@mail.gmail.com>
Message-ID: <CAMuHMdVFexJ=NT4wX4v2s3K--znQCiahskbGtEci3xwgsyEQWA@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: kbuild: Use DTB files for validation
To:     Rob Herring <robh@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Mon, Mar 7, 2022 at 6:00 PM Rob Herring <robh@kernel.org> wrote:
> On Mon, Mar 07, 2022 at 01:20:29PM +0100, Geert Uytterhoeven wrote:
> > On Thu, Mar 3, 2022 at 11:43 PM Rob Herring <robh@kernel.org> wrote:
> > > Switch the DT validation to use DTB files directly instead of a DTS to
> > > YAML conversion.
> > >
> > > The original motivation for supporting validation on DTB files was to
> > > enable running validation on a running system (e.g. 'dt-validate
> > > /sys/firmware/fdt') or other cases where the original source DTS is not
> > > available.
> > >
> > > The YAML format was not without issues. Using DTBs with the schema type
> > > information solves some of those problems. The YAML format relies on the
> > > DTS source level information including bracketing of properties, size
> > > directives, and phandle tags all of which are lost in a DTB file. While
> > > standardizing the bracketing is a good thing, it does cause a lot of
> > > extra warnings and churn to fix them.
> > >
> > > Another issue has been signed types are not validated correctly as sign
> > > information is not propagated to YAML. Using the schema type information
> > > allows for proper handling of signed types. YAML also can't represent
> > > the full range of 64-bit integers as numbers are stored as floats by
> > > most/all parsers.
> > >
> > > The DTB validation works by decoding property values using the type
> > > information in the schemas themselves. The main corner case this does
> > > not work for is matrix types where neither dimension is fixed. For
> > > now, checking the dimensions in these cases are skipped.
> > >
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> >
> > Thanks for your patch!
> >
> > While investigating why a newly added device node to DTS was not
> > instantiated as a platform device, I discovered an issue with this
> > patch: "make dtbs" no longer rebuilds DTB files that need a rebuild.
> >
> > How to reproduce:
> >
> >     $ git checkout next-20220307
> >     # apply this series and its dependency:
> >     # dt-bindings: kbuild: Support partial matches with DT_SCHEMA_FILES
> >     # dt-bindings: kbuild: Pass DT_SCHEMA_FILES to dt-validate
> >     # dt-bindings: kbuild: Use DTB files for validation
> >     $ make ARCH=arm shmobile_defconfig
> >     $ make ARCH=arm dtbs
> >     $ touch arch/arm/boot/dts/r8a7791.dtsi
> >     $ make ARCH=arm dtbs
> >     # The above command does NOT cause:
> >     # DTC     arch/arm/boot/dts/r8a7791-koelsch.dtb
> >     # DTC     arch/arm/boot/dts/r8a7791-porter.dtb
> >
> > I don't see anything wrong with this patch at first sight, though.
>
> Was this a clean tree?

The above was a clean tree.

> I think I reproduced it, but then couldn't... But then after a 'make
> clean', 'make dtbs' would error out. I think the issue in both cases was
> processed-schema.json always a dependency when it should be conditional
> on 'dtbs_check'. The patch below fixes that. Can you give it a try too.

I first saw the issue in my normal work tree.
However, I cannot reproduce it in that tree anymore :-(

I can reproduce it in the clean tree after following the instructions
above, and your patch fixes that, so
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -349,12 +349,12 @@ $(multi-dtb-y): FORCE
>         $(call if_changed,fdtoverlay)
>  $(call multi_depend, $(multi-dtb-y), .dtb, -dtbs)
>
> +ifneq ($(CHECK_DTBS)$(CHECK_DT_BINDING),)
>  DT_CHECKER ?= dt-validate
>  DT_CHECKER_FLAGS ?= $(if $(DT_SCHEMA_FILES),-l $(DT_SCHEMA_FILES),-m)
>  DT_BINDING_DIR := Documentation/devicetree/bindings
> -DT_TMP_SCHEMA ?= $(objtree)/$(DT_BINDING_DIR)/processed-schema.json
> +DT_TMP_SCHEMA := $(objtree)/$(DT_BINDING_DIR)/processed-schema.json
>
> -ifneq ($(CHECK_DTBS)$(CHECK_DT_BINDING),)
>  quiet_cmd_dtb_check =  CHECK   $@
>        cmd_dtb_check =  $(DT_CHECKER) $(DT_CHECKER_FLAGS) -u $(srctree)/$(DT_BINDING_DIR) -p $(DT_TMP_SCHEMA) $@ || true
>  endif

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
