Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D29F51DF71
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 21:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389428AbiEFTGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 15:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388686AbiEFTGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 15:06:15 -0400
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66086832F;
        Fri,  6 May 2022 12:02:31 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-2f7d19cac0bso91102047b3.13;
        Fri, 06 May 2022 12:02:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sP74p2Ho2Emb3VKHw1EnwOCOMVgioz5LH941HCHgdUw=;
        b=HtYTZ8ae4GUQSvjdwxwFeDygLipJ07+W3JimKqp9w2qOtonQK5/YdcAhrBqQphRvj/
         FEVr0U2H2BVZocX8+XPNyuY8AUEqiAL6cWzrGv1KwcmiJifpuqoVTHFHMb9hmugRUlkB
         LexHwYSA2P3Ryx0qE9JNxj/pwPOPnP4CdtmraQtqRBVIcoqsYnET8Ota8zEhg2gGsdPt
         A2VP1a7EEEIfrKfa86q/CxLPKdmypvguRXCO4RDXhtwO6C373DqeY6pReiS108TXJJu4
         VWYEdjgxTRLZn7whWy1ZhnzP1aiHCVZdHwAaqVFDx9KLOmKTr6jgkRsWxyG8bxRqXGgj
         puxg==
X-Gm-Message-State: AOAM532OD1GeTOqPvaQJJbOqUKtnZHn9rYSPjsvZ2dkK369LAiw7PSIn
        Nav//rNfRgoEe2MXMIt6Rt714CCbyC9aIRgklLUeoj+K
X-Google-Smtp-Source: ABdhPJzymxnQ4N9mwBwTyRpS7swhira7YdkePOJWgvnxZeBgAFxVnMazO5jgb+kFXq2d4xeD1dXRySBi2mglQTOoaJA=
X-Received: by 2002:a0d:ddce:0:b0:2f8:c9f7:8f7c with SMTP id
 g197-20020a0dddce000000b002f8c9f78f7cmr4128496ywe.301.1651863751019; Fri, 06
 May 2022 12:02:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220425123819.137735-1-pierre.gondois@arm.com>
 <20220426030810.wj7mdhjhzs2s6y7h@vireshk-i7> <20220426063739.6ljxtr6hpz7tber5@vireshk-i7>
 <6765104a-761c-4586-502c-2b98ee6016a1@arm.com> <20220426071231.zfdrok3ulgewomib@vireshk-i7>
In-Reply-To: <20220426071231.zfdrok3ulgewomib@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 6 May 2022 21:02:20 +0200
Message-ID: <CAJZ5v0jEQ0E4YUpj24igC0PKOebs_mM1p4zAH4wSy3DEBFXZjg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Enable EAS for CPPC/ACPI based systems
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Pierre Gondois <pierre.gondois@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ionela Voinescu <Ionela.Voinescu@arm.com>,
        Lukasz Luba <Lukasz.Luba@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Fuad Tabba <tabba@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Rob Herring <robh@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>
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

On Tue, Apr 26, 2022 at 9:12 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 26-04-22, 09:10, Pierre Gondois wrote:
> > Hello Viresh,
> > The 2 patches are relying on Lukasz' patch-set at:
> > https://lkml.org/lkml/2022/3/21/282
> > The serie was accepted by Rafael (cf. https://lkml.org/lkml/2022/4/13/701) and
> > is currently in linux-next. More specifically, the missing patch causing the
> > build failure is: 'PM: EM: Add .get_cost() callback'
> >
> > From what I see, the branch cpufreq/arm/linux-next (from your repo) that was
> > used in the CI is based on v5.18-rc1 and doesn't have Lukasz' patches. Should
> > we wait for the patches to be in a rc version, or is there a process for this
> > kind of case ?
>
> Ok.
>
> Rafael: Please pick these patches directly.
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Done, thanks!
