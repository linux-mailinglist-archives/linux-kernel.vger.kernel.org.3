Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4214CD112
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 10:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236997AbiCDJdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 04:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbiCDJda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 04:33:30 -0500
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB1A6A01E;
        Fri,  4 Mar 2022 01:32:42 -0800 (PST)
Received: by mail-vs1-f51.google.com with SMTP id d26so8464090vsh.0;
        Fri, 04 Mar 2022 01:32:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ooFzD/Zgy8aaH59VqXsWWoXXOIgPIQerNlb108cZa4c=;
        b=Ko47ToAlGZECEA0bM2hGkOuML0WyiGUbff5nIvFG3ovJkGfpcZSHllWI1kvHvvagaP
         Y6QeJB3BfNJeL/q3lBJYT0XAF8Pdi8nnGfkiwqmEkd9B/9OgCuErpsGwT4MRrBDnuyed
         2xz+Ar9eNd7P2Gm2IfDHxgdxJuMdWwXxWHgQTWdkC657PoPzl3BxD8hbH6acvizmQi5l
         YzW7/dRufI+b9znBOZvVbl3yp/bnSoeTrlR4s+4g4AAFaXdqH7rKil14kGhKmwvcIPwq
         2kPdc6eXlkZa+8YxeyxqSHj5K7oH7j/4NJyviwXqpjb3MHU/NC8Ogl06ZgD9H8jWVWZK
         lmcA==
X-Gm-Message-State: AOAM531BuozZBMrLCwNR0pAmiWkJ/A0X+Va/1Eb6VExxKkbU5fFFlHZG
        IVpCJMsI1lrqX4tvue1tEMhXgDfdTILLCg==
X-Google-Smtp-Source: ABdhPJyAnDJLZywIMLUvE75WGOJyPsJFmmpfRjco0SwoRe28K3ah3MXJYRhc7boXgGpHm9P3G4UqtQ==
X-Received: by 2002:a05:6102:300b:b0:31c:35a4:a503 with SMTP id s11-20020a056102300b00b0031c35a4a503mr17887670vsa.35.1646386361913;
        Fri, 04 Mar 2022 01:32:41 -0800 (PST)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id q9-20020ab02649000000b0034a4433fe82sm713589uao.36.2022.03.04.01.32.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 01:32:41 -0800 (PST)
Received: by mail-vs1-f42.google.com with SMTP id q9so8434017vsg.2;
        Fri, 04 Mar 2022 01:32:41 -0800 (PST)
X-Received: by 2002:a05:6102:2922:b0:31e:bd90:f1c3 with SMTP id
 cz34-20020a056102292200b0031ebd90f1c3mr6640361vsb.77.1646386360899; Fri, 04
 Mar 2022 01:32:40 -0800 (PST)
MIME-Version: 1.0
References: <20220303224237.2497570-1-robh@kernel.org> <20220303224237.2497570-2-robh@kernel.org>
In-Reply-To: <20220303224237.2497570-2-robh@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 4 Mar 2022 10:32:29 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU6g7c9YX0mBAGWbCWgA8exkUSfqn8ZGi_2N+Nz1WT+BA@mail.gmail.com>
Message-ID: <CAMuHMdU6g7c9YX0mBAGWbCWgA8exkUSfqn8ZGi_2N+Nz1WT+BA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: kbuild: Pass DT_SCHEMA_FILES to dt-validate
To:     Rob Herring <robh@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
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

On Thu, Mar 3, 2022 at 11:43 PM Rob Herring <robh@kernel.org> wrote:
> In preparation for supporting validation of DTB files, the full
> processed schema will always be needed in order to extract type
> information from it. Therefore, the processed schema containing only
> what DT_SCHEMA_FILES specifies won't work. Instead, dt-validate has
> gained an option, -l or --limit, to specify which schema(s) to use for
> validation.
>
> As the command line option is new, we the minimum dtschema version must be
> updated.
>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Rob Herring <robh@kernel.org>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/Makefile
> +++ b/Documentation/devicetree/bindings/Makefile
> @@ -6,7 +6,7 @@ DT_MK_SCHEMA ?= dt-mk-schema
>  DT_SCHEMA_LINT := $(shell which yamllint || \
>    echo "warning: yamllint not installed, skipping. To install, run 'pip install yamllint'" >&2)
>
> -DT_SCHEMA_MIN_VERSION = 2021.2.1
> +DT_SCHEMA_MIN_VERSION = 2022.3

This doesn't work as-is, as that version hasn't been tagged yet ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
