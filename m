Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8819589F73
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 18:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236503AbiHDQew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 12:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbiHDQet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 12:34:49 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D695713DD4;
        Thu,  4 Aug 2022 09:34:48 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id s7so143196ioa.0;
        Thu, 04 Aug 2022 09:34:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=kCx9JdWdancCYSGcllxZfjVPNoWqqE8En1+spKcWJ1E=;
        b=IgmGhACQ7qhdF7vDfMadKt6RsyHtkico3JrPK8M3a+QbtlNrVXoTR03yK/1WxVernf
         c7jN0GJLSBZyZn5Vt6N0fhjeRT1bwfgyx8QLvjXuBE9+UNephQpnpvSK4KOjSEPRtUgt
         QR3K+jPfqoSNa8HZeF9gi/AP7tSCSAI/6yIHD5vBwpT54IZkf/SGb4IMokzeodbsHxwC
         XLF8GRJklq2lLU5QwbuGqx5u02vR6GkyO751HXNmdO/5WzitnhOE1m/egfCUVNCtXhMz
         5rCFlCuIcvF4VLtZJTQfqhF48nMcZngbETOrnphP2r0dnUFku5A+hcNvdo1Lp9/x9USo
         4ysQ==
X-Gm-Message-State: ACgBeo3dNSON8bbWiJuAVJ/e/DTcjGa4954iyqQpsf4b0UtwqxzfCdnL
        rptLhDY3IK0TkzV3K5zGfAhTK1nXcA==
X-Google-Smtp-Source: AA6agR50sVE/RzsezlgaQpb9JEYlwzuYKGSeXvtQrGkKoTuogjdIQ0YFlbrp7JhZhaVRTLIEHkKczQ==
X-Received: by 2002:a6b:3f43:0:b0:681:8ab4:508a with SMTP id m64-20020a6b3f43000000b006818ab4508amr1098418ioa.213.1659630887984;
        Thu, 04 Aug 2022 09:34:47 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id g10-20020a02850a000000b00339e42c3e2fsm630198jai.80.2022.08.04.09.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 09:34:47 -0700 (PDT)
Received: (nullmailer pid 4141 invoked by uid 1000);
        Thu, 04 Aug 2022 16:34:45 -0000
Date:   Thu, 4 Aug 2022 10:34:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Tom Rini <trini@konsulko.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH v3] kbuild: Enable DT schema checks for %.dtb targets
Message-ID: <20220804163445.GA4145453-robh@kernel.org>
References: <20220623144357.297252-1-dmitry.baryshkov@linaro.org>
 <CAL_JsqLi31FPBdYPzEW__UmfMTur-0428okopFYVaCbwm045gg@mail.gmail.com>
 <CAK7LNASMUoPh8sBWWjenf8p6R1kv80ar17-qN-wH9zjNMtnfrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASMUoPh8sBWWjenf8p6R1kv80ar17-qN-wH9zjNMtnfrQ@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 16, 2022 at 05:12:38PM +0900, Masahiro Yamada wrote:
> On Sat, Jul 16, 2022 at 8:02 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Thu, Jun 23, 2022 at 8:44 AM Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > >
> > > It is possible to build a single dtb, but not with DT schema validation
> > > enabled. Enable the schema validation to run for %.dtb and %.dtbo
> > > targets. Anyone building a dtb for a specific platform *should* pay
> > > attention to schema warnings.
> > >
> > > This could be supported with a separate %.dt.yaml target instead.
> > > However, the .dt.yaml format is considered an intermediate format and
> > > could possibly go away at some point if schema checking is integrated
> > > into dtc. Also, the plan is to enable the schema checks by default once
> > > platforms are free of warnings, and this is a move in that direction.
> > >
> > > This patch differs from the previous one ([1]) in the fact that it
> > > requires specifying VALIDATE_DT=1 to run the checks while doing the
> > > build. Thus default build procedures would not obtain additional build
> > > dependency, while maintainers can still build a single DTB file an get
> > > only corresponding warnings.
> >
> > I'd rather this be a kconfig option, so that eventually 'make
> > allmodconfig; make dtbs' also runs the schema checks. If something can
> > be enabled for allmodconfig, then builders will automatically start
> > testing it. Though the extra dependency is a problem here.
> 
> 
> The dependency on libyaml is gone.
> 
> As for the dependency on dt-schema, is it a good idea to
> pull it into the kernel tree somewhere,
> like we periodically sync scripts/dtc/ with its upstream?

I don't want that. We want DT stuff less coupled to the kernel. Doing 
that also means the person syncing dtschema into the kernel is the one 
stuck fixing any new warnings. That mostly ends up being me anyways, but 
I don't want to guarantee that. Also, that would only shift the 
dependencies to json-schema, ruamel.yaml, pylibfdt, etc. python 
packages.

For dtc, I'd actually like to remove it from the kernel.

Rob
