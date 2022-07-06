Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572E3569553
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 00:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbiGFW3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 18:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233999AbiGFW3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 18:29:42 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11803165A1
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 15:29:40 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id g1so13348165edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 15:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OGUR4OSSACdoQGymUgb58rO3deGhSo3mmc2zAbWJQeE=;
        b=MLVtEo7K97RJCHXIRkkYHN7vXWU9zIKn6VxhLksoxNPEadsQYtKR+BmrwV3VaoDKLv
         sx4xCnoRvDoQA53p4/HfB0RftG9w3QApDYJXuyoRt1iFTSCv93YfmPG3LyZCDFZtMb3b
         WX5YNtO5QMw081AJgzdbHuJnOdl9ZuSGhb47Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OGUR4OSSACdoQGymUgb58rO3deGhSo3mmc2zAbWJQeE=;
        b=zjV/CnhMaU8zLoP01uSjMBh50CAyeqfNHkyBBF4n5wmYo0jir0OnkoT9zVLM/bKqCl
         F6Kh+XxeVuqoyFpirXYKpWDrHIrtMJVaDH3FtHQ52cTXcF9tCPyVG1a7PbXjCmYnuwOQ
         a/BP3Gtbq8P617i1dtID5uZIqGZr4Z5YcGD0+iCg2OvHqMrIxsb34MHf0LgGZ3jH2qF9
         Yvm1d3fp3N9wrz5R9iKM/kWbOHEp53pNuAI1LsGQPO2FALPwdcTPUyJ5AsxU1odmt4sJ
         ACa1zpJ1/KATvNzE7R2QBQhb3+dzAKbfrP8OZVwJkfwMHKQMAbmxwnFz9/tDoHVL5Z/j
         +Tfg==
X-Gm-Message-State: AJIora9ZxKjNkMJ4o+hqZTnj8O4I8mhr/Ssgyj9KURnFgJ/pmHR2CM4v
        6rNn0tiMQQ3arPj95XXTwKGxR3iqNLbsq3E6
X-Google-Smtp-Source: AGRyM1voCJyvN+Q1aqx7rCTIjo75ZK2LrbmJF2oXC/EjIhm7jZNLId7LCz0MelOf7f/myTBteIBROg==
X-Received: by 2002:a05:6402:240a:b0:437:d2b6:3dde with SMTP id t10-20020a056402240a00b00437d2b63ddemr57323134eda.62.1657146579354;
        Wed, 06 Jul 2022 15:29:39 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id i21-20020a17090639d500b006fe98fb9523sm18056303eje.129.2022.07.06.15.29.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 15:29:38 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id b26so23921039wrc.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 15:29:38 -0700 (PDT)
X-Received: by 2002:adf:f90d:0:b0:20c:de32:4d35 with SMTP id
 b13-20020adff90d000000b0020cde324d35mr38500441wrr.583.1657146577575; Wed, 06
 Jul 2022 15:29:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1656759988.git.mchehab@kernel.org> <0ae8251f97c642cfd618f2e32eb1e66339e5dfde.1656759989.git.mchehab@kernel.org>
 <CAD=FV=W7gzG4xSsR3HxOv96ytzyNvT5a1oQnmy4F0BqpCOChOw@mail.gmail.com>
In-Reply-To: <CAD=FV=W7gzG4xSsR3HxOv96ytzyNvT5a1oQnmy4F0BqpCOChOw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 6 Jul 2022 15:29:25 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XdiDANmGsSmb1RNYyKxcbtZORyDbJFvhKpQG=dbvG14Q@mail.gmail.com>
Message-ID: <CAD=FV=XdiDANmGsSmb1RNYyKxcbtZORyDbJFvhKpQG=dbvG14Q@mail.gmail.com>
Subject: Re: [PATCH 11/12] docs: arm: index.rst: add google/chromebook-boot-flow
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 6, 2022 at 9:34 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Sat, Jul 2, 2022 at 4:07 AM Mauro Carvalho Chehab <mchehab@kernel.org> wrote:
> >
> > This document was added without placing it at arm book.
> >
> > Fixes: 59228d3b9060 ("dt-bindings: Document how Chromebooks with depthcharge boot")
> > Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> > ---
> >
> > To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> > See [PATCH 00/12] at: https://lore.kernel.org/all/cover.1656759988.git.mchehab@kernel.org/
> >
> >  Documentation/arm/index.rst | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/arm/index.rst b/Documentation/arm/index.rst
> > index 2bda5461a80b..495ada7915e1 100644
> > --- a/Documentation/arm/index.rst
> > +++ b/Documentation/arm/index.rst
> > @@ -31,6 +31,8 @@ SoC-specific documents
> >  .. toctree::
> >     :maxdepth: 1
> >
> > +   google/chromebook-boot-flow
> > +
>
> Sure, seems reasonable. It's not truly SoC-specific but I guess
> there's no better place for it.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Just to be clear, this probably should go into the Qualcomm tree.

-Doug
