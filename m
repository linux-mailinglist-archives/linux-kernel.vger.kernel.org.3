Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9AFE52DB79
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242530AbiESRil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbiESRif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:38:35 -0400
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9BE64737;
        Thu, 19 May 2022 10:38:35 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id o80so10303537ybg.1;
        Thu, 19 May 2022 10:38:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y/4Y5SexZH4Q61j2eqy5fN+0Vz4/ulgakGP6fRmNC5Y=;
        b=Ejw+c19P9qbdlGU0q4b0Ic025vtXoNqlIV4P63InmlstZ8g3Fyi6Xjt0XdiLd4tYpA
         fFtnPDDv0NEPb66kA9C7DfK8YQW9NAYeGiRXIs/ay5tDP+6efEByVRIm8hmAyK9Yjh4m
         nRMxvDE6UsCwamtocIlc/ANB/Ie6oxtAL2qaCSV/aZn6LNhP9M0+Fa1ij2YqeKMO1646
         oHE4GxwAQvL51YyxZ2DbdPyzyFnMkPrxFszFVA7W0tJuHH+qzX+t8hxVHlvta67qLT7Y
         aiX6TnLcM1UIGypOEbZ+ebuJoE/Vuu27cJWKxErDQTNknAMA2BxRWKFu8BYMMmsv7i3l
         Jzug==
X-Gm-Message-State: AOAM5315ABfhq5l9NVXYvNKKvFxEPIyWCi9eX3uNSJCYUYw0iUNVJuSX
        wLBtrYWyuqfwZWejYdDHm5yac8XZkRbTtYnGAmI=
X-Google-Smtp-Source: ABdhPJxHYFAlbY4jjEvyBbq9j4RtDnQblrvomR9PFYZ1UexBxXux8tAij6JeBGq/iQ5vj9VW43XCIneKGjxsk0rT8ME=
X-Received: by 2002:a25:3302:0:b0:64a:df5b:d08 with SMTP id
 z2-20020a253302000000b0064adf5b0d08mr5295724ybz.81.1652981914465; Thu, 19 May
 2022 10:38:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220514152032.758738-1-ulf.hansson@linaro.org>
 <CAAhSdy3m3FzbkL-On5kPtrZgyO4x=6onr6mXi_=te5B=m_n8GQ@mail.gmail.com>
 <CAJZ5v0i+RR2nK8gew9tbnO_VVU3YUx2JgdRTBW07EPrB3UK87g@mail.gmail.com> <CAPDyKFrcWBL=7enQ3FJO7pFqv465-Nb3UWZm3faGYe5kG+Mjaw@mail.gmail.com>
In-Reply-To: <CAPDyKFrcWBL=7enQ3FJO7pFqv465-Nb3UWZm3faGYe5kG+Mjaw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 19 May 2022 19:38:23 +0200
Message-ID: <CAJZ5v0jLH2cmy_vUoyg_4eumUif0csrsvg3_ATY0MEDmVr5nFQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] cpuidle: psci: Fix regression leading to no genpd governor
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@rivosinc.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
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

On Thu, May 19, 2022 at 3:01 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 18 May 2022 at 20:50, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Sat, May 14, 2022 at 6:49 PM Anup Patel <anup@brainfault.org> wrote:
> > >
> > > On Sat, May 14, 2022 at 8:50 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > >
> > > > While factoring out the PM domain related code from PSCI domain driver into
> > > > a set of library functions, a regression when initializing the genpds got
> > > > introduced. More precisely, we fail to assign a genpd governor, so let's
> > > > fix this.
> > > >
> > > > Fixes: 9d976d6721df ("cpuidle: Factor-out power domain related code from PSCI domain driver")
> > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > >
> > > Looks good to me.
> > >
> > > Reviewed-by: Anup Patel <anup@brainfault.org>
> > >
> >
> > Ulf, do you want me to take this lot or is it going to be handled elsewhere?
>
> I appreciate it if you can pick both this and the second patch.

Both applied, thanks!
