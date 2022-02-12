Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506E14B3506
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 13:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbiBLMuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 07:50:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234903AbiBLMuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 07:50:02 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A592613A
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 04:49:58 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id bu29so16340689lfb.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 04:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=idWS+dy/9zcAHhOmUKByw810+cre1HyYia7KtD9MJdE=;
        b=J7ZSlDBaOxGSKMrZf0Pc7V6AlASUvZJmt3m2fxlRMAaWwjlrr1h2gdgmKl4Rnx2dSm
         IfmWMj9Dc858vbexwMx0tLWVbdzgodTOTiYxhpCOpvTsTaO8XL1MpX8pToBRfgox5nB7
         6aqOSyrSo4nycHtj99MRQ1Uxnd2BXMW3SVTStB35tLc5KQa2DnL3DxqE29h26CFk1bQO
         Jn8MOivWUIokAnvury7OjQMa+1RaxZk3uSX1NpJ3+ib031eOMJVAFDhXh1Ifssb6azz/
         X0Z2Nucf3B2ww7UsNN2kc2wp8nG2AXJ8paGqnnBPuAOUrpi2avcR+xBe651OFQlzOI2w
         cgag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=idWS+dy/9zcAHhOmUKByw810+cre1HyYia7KtD9MJdE=;
        b=kfqjhyPu3d6eIZgBU9EuINy/ALc/K6PFEb5vQ3kDDU4N+RfhyMPM0wOCtMAW0xZoAA
         cm+IRzsk1rlbh8lIsB93vQv5atVJqnaEGKynRdm//n8je3Q7hZDHtnUiBjmh2Z4pN9Fr
         fjHii7dImmKXzJE0SPUUIfKpiDi7xphn8F2hoFvbB3tD8DOzXnJlW6Efyg5mC6WeHs2e
         9p6XEy/wuUZvMlpOQaSfoglVRseGH/mQOsbxJ2INqcGSB5O+OfGSyA4x/7MWxMGXd4YV
         9fTHmTvtPfPVvnzozRWO9CgbEayeNsa7mYeru+tidR6hNBSw1CLmHCMTuu7WVNO9t379
         nrcg==
X-Gm-Message-State: AOAM5302oTBUah/PWe55GlCd7KLoa1CE2lv2DkNKvLTzQx576VlkMYMY
        4Efs7tdVb2vC1CrMQUWEN1EhXw3xQ1/2dsaoJZMnZQ==
X-Google-Smtp-Source: ABdhPJzeHH07yDCVZVPUyyeoJRx73u7xqaZhnqbnL0ultgwjz50bXvR8YJh2OO11LoYsIZl66imqJHcVEOKUk0SGq3M=
X-Received: by 2002:a05:6512:33c8:: with SMTP id d8mr4325765lfg.41.1644670197034;
 Sat, 12 Feb 2022 04:49:57 -0800 (PST)
MIME-Version: 1.0
References: <20220210054947.170134-1-apatel@ventanamicro.com>
 <20220210054947.170134-2-apatel@ventanamicro.com> <20220212114355.GF20866@duo.ucw.cz>
In-Reply-To: <20220212114355.GF20866@duo.ucw.cz>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Sat, 12 Feb 2022 18:19:46 +0530
Message-ID: <CAK9=C2VzzT=GDyuptuxQj0y++Rb0SaZXCuoL1+ncpGWcYHqr1g@mail.gmail.com>
Subject: Re: [PATCH v11 1/8] RISC-V: Enable CPU_IDLE drivers
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Sandeep Tripathy <milun.tripathy@gmail.com>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Liush <liush@allwinnertech.com>,
        Anup Patel <anup@brainfault.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kvm-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 12, 2022 at 5:13 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > From: Anup Patel <anup.patel@wdc.com>
> >
> > We force select CPU_PM and provide asm/cpuidle.h so that we can
> > use CPU IDLE drivers for Linux RISC-V kernel.
> >
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > Signed-off-by: Anup Patel <apatel@vetanamicro.com>
>
> This is quite... interesting. Normally we have one signoff per
> person...

I was working for Western Digital (WDC) when I first submitted this
series and recently I joined Ventana Micro Systems.

Regards,
Anup

>
> Best regards,
>                                                         Pavel
> --
> http://www.livejournal.com/~pavelmachek
