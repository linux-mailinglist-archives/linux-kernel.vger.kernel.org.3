Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9605F58910D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 19:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236342AbiHCRMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 13:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236093AbiHCRMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 13:12:42 -0400
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858841583D;
        Wed,  3 Aug 2022 10:12:41 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 123so29343071ybv.7;
        Wed, 03 Aug 2022 10:12:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=uXqPyifGf2g6fzwiKxX735xGdy+40PhrDFCF5Jej0qU=;
        b=znznT03HscwMxx15CpnnF8P22G5/jK5Z6YfY9yqzSCjNd+HR5K+DMWqvU8G8uL34Pc
         khQBeZ2sbzQZiUrzZoLwia0pHL9WRGhiH5+EjCiyGsxM66WtA3/ui/gRJpw/x4kYrwlu
         D7FnxBT5o8bm6205CJiqAVI0w3VRLcEA9vuggu2er6bh0OJq6fppWwm2ZX2Wp9sqDAxb
         HKa2flXwPzxDTHBIzD/M3sZTcoqefnG/2yDwXLVBpVhaKrEakljMcXejR3S6tcS9ruzo
         +x997JEoXmqbcrbG/VLpekyIPGjBBmrarLMa3NU9fmdQ+irfYjKZqIkci+WJJPh4GVvM
         pNHg==
X-Gm-Message-State: ACgBeo3Vam+7G0vuIWYT8rK6MaKpE2fuis48relt0WlsuLqidWEiuTro
        IvJlwcU5WStKwtRhodoEtyuPo4TFxBZp5kqr05E=
X-Google-Smtp-Source: AA6agR5PZvfHa4/715v3L5kZBOovhDJBVAzrw9B2iGtwJ/UXYi7UqOrD6Jz1bd/0NM8zxSuYI8WVrPawFxSLcCn9HbQ=
X-Received: by 2002:a25:cc51:0:b0:676:ccba:875 with SMTP id
 l78-20020a25cc51000000b00676ccba0875mr19460787ybf.137.1659546760741; Wed, 03
 Aug 2022 10:12:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220728175456.2796-1-sumeet.r.pawnikar@intel.com> <9c1937c1d7ab7687412c15c26532aea258aec078.camel@intel.com>
In-Reply-To: <9c1937c1d7ab7687412c15c26532aea258aec078.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 3 Aug 2022 19:12:29 +0200
Message-ID: <CAJZ5v0j2dRah+xsGZO2V2g3pnByV9CPoMxDEOzs_Oq2bSvuQpQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel: Add TCC cooling support for Alder Lake-N
 and Raptor Lake-P
To:     Zhang Rui <rui.zhang@intel.com>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 30, 2022 at 5:09 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> On Thu, 2022-07-28 at 23:24 +0530, Sumeet Pawnikar wrote:
> > Add Alder Lake-N and Raptor Lake-P to the list of processor models
> > supported by the Intel TCC cooling driver.
> >
> > Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
>
> Acked-by: Zhang Rui <rui.zhang@intel.com>
>
> > ---
> >  drivers/thermal/intel/intel_tcc_cooling.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/thermal/intel/intel_tcc_cooling.c
> > b/drivers/thermal/intel/intel_tcc_cooling.c
> > index a9596e7562ea..95adac427b6f 100644
> > --- a/drivers/thermal/intel/intel_tcc_cooling.c
> > +++ b/drivers/thermal/intel/intel_tcc_cooling.c
> > @@ -81,7 +81,9 @@ static const struct x86_cpu_id tcc_ids[]
> > __initconst = {
> >         X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE, NULL),
> >         X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE, NULL),
> >         X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L, NULL),
> > +       X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N, NULL),
> >         X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE, NULL),
> > +       X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P, NULL),
> >         {}
> >  };
> >

Applied as 5.20-rc material, thanks!
