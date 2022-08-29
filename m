Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D215A4089
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 03:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiH2BHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 21:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiH2BHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 21:07:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2532B21258;
        Sun, 28 Aug 2022 18:07:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5971B80BA6;
        Mon, 29 Aug 2022 01:07:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70022C4347C;
        Mon, 29 Aug 2022 01:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661735228;
        bh=j8/zqgqNyC238z42ZPV1ON5xd+ITJAITq0g3ep8McsM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YRvCl4g4oGgxKzPA836qQYoF4bx5v6YEuiyvBYTijOE2fyi+U0il9dMvuXdDcWP7v
         4n4ji8GRNc578a+4stpuFiEGdjwtxLqHiMWrptl87wx+L+2kVm3ZV5VO+qhpn/6ijD
         Xd/3dc7nsKMmEEovFvTvhCmWNcn5DkHP+6KxxDWR4Sa7t4GyeaKFZNQleglq4rmTS4
         cCprnhMPZsN7yur1bdLcrVo0npS6a7EqAv1tjeFpU/k0f9kAduLV72mY97+tnER1Lw
         /DRz7/JPR/y5O0yn8asC04oRF/YA7GKiUIY9gTG3VuyIT98jJVNAxiKeHMnRuoZf6e
         AUdEkc9OeAn8A==
Received: by mail-vs1-f43.google.com with SMTP id m66so6898384vsm.12;
        Sun, 28 Aug 2022 18:07:08 -0700 (PDT)
X-Gm-Message-State: ACgBeo3nJ3h48FAv1p16bcsh+mNAS3kX+BEfVyLM5XF9mbcsRUYHjsgi
        YfZhHJdxkFAPANuVhVhKKnBmlArCtUVWWXhIOw==
X-Google-Smtp-Source: AA6agR4fQb9xrIurzt54N3Y2edfUMuKjgVXXkR09se9ZwVek3NCyjgznD4ZHMdHxJO8T40Gr1zdCrEOKkKvjzLB8zP0=
X-Received: by 2002:a05:6102:3353:b0:38c:9170:a96b with SMTP id
 j19-20020a056102335300b0038c9170a96bmr2915159vse.26.1661735227313; Sun, 28
 Aug 2022 18:07:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220824203934.2855320-1-robh@kernel.org> <CAK7LNAS8nH+9HnfhV8yEtxShBbSYGQdOyVxbNJmbQJjEiqHPzA@mail.gmail.com>
In-Reply-To: <CAK7LNAS8nH+9HnfhV8yEtxShBbSYGQdOyVxbNJmbQJjEiqHPzA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Sun, 28 Aug 2022 20:06:56 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKA7gLF=FkzMbiH6NyDo6M7=i2LLSAYFw5sETwszZY5zw@mail.gmail.com>
Message-ID: <CAL_JsqKA7gLF=FkzMbiH6NyDo6M7=i2LLSAYFw5sETwszZY5zw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Split up DT binding build targets
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 2:31 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Thu, Aug 25, 2022 at 5:39 AM Rob Herring <robh@kernel.org> wrote:
> >
> > The DT binding validation target, dt_binding_check, is composed of
> > multiple steps which can't be run individually. This resulted in
> > the passing of make variables to control which steps were run for
> > 'dtbs_check'. Some steps are also doing multiple things in a single rule
> > which is error prone[1].
> >
> > Rework the build to split each of the steps into its own make target.
> > This allows users more fine grained control over what's run and makes
> > for easier make dependencies.
>
>
> I do not think it makes the code easier.
>
>
> A tricky case is that multiple targets run in parallel.
>
>
> "make  -j$(nproc)  dtbs_check  dt_binding_examples"
>
>
> Two different threads dive into Documentation/devicetree/bindings/Makefile,
> and try to build the same file simultaneously.
>
> If you run the command above, you will see two lines of
>
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>
> processed-schema.json may result in a corrupted file.

Indeed... :(

>
> > The new targets are:
> >
> > dt_binding_lint - Runs yamllint on the bindings
> > dt_binding_schemas - Validates the binding schemas
> > dt_binding_examples - Builds and validates the binding examples
>
>
> I still do not understand why so many phony targets are necessary.

I thought that's what you were suggesting, but I guess you meant just
separate internal targets. Separate targets exposed to the user are
useful as well. I've had some requests to be able to skip running
yamllint for example. The processed schema can be used for a few other
tools now, so being able to just build it is useful.

Rob
