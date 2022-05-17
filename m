Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810B352AB1D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 20:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352328AbiEQSof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 14:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347049AbiEQSod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 14:44:33 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FF139164;
        Tue, 17 May 2022 11:44:32 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id d3so13218103ilr.10;
        Tue, 17 May 2022 11:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j51jKuN9LxvI+OJRdkmu6rD6Kj69fRthuGQLklYAkDA=;
        b=as17G5fbhkMRlyXiHsU2KOLKCrfeZcdSYQlK1LW7Q8XiRvt3/rvMdCt9YdS6IVQIyR
         G5jGuOFEU38O7dokmbx2OkssSbKCCe4PNCnvyE4PWTfpNTlkqaWFsvCt+rkxOZffu1zn
         eVkVlRV5tqGqvDBXVggSl4zD/n4rLWObhE3iac3Uua5g5n47TChEhLJcTZtshzjVGzv/
         3H1q1UDPdjttHDKpQM0vIBxiavoZgLzuPVPzzO59GDqil4mokNUn7ON0krii5w1TqmIn
         KDSSXSC5lcuZhi76ddqFyYUApnEz62L0ffUtc5+71dbXayAAlXPhVVXShSP2c1/9JP/b
         v0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j51jKuN9LxvI+OJRdkmu6rD6Kj69fRthuGQLklYAkDA=;
        b=yJcLuMxwNhw+qN8V91WP+RzXXta284U+Z8KMPsdl2my/Hn/bnuy+aGh4ncB5wxAWmc
         spmSI6tl/SCTquwM5RIhOOAC294Q2as5bUbipqC4QS+7a2ylUdAxU36HhvWVi5hIHwG0
         swF75AFSC3e7uioS+NIKP9FtkyrIR5NyN1etcWH781/LyCSEehD/jvuCgwcSTph3S69D
         7lnjGCbbsVGzUgh+Nguq96buJ63HR+NqUAjmIhebBPCDKkgU7Zl/hz4tnyTNEL2IJ9VY
         HeqHkYFhUvNxpqqVxfi88N6pG2P5fSia1Es002abSv1bM4hoJvg6aLBB/s9KyeRGMiD0
         MIaA==
X-Gm-Message-State: AOAM5320YFcY7NxgO85v5BFObyjC5VXhDVk7cAr6Br1AKOqD5BU0lKFQ
        /L4OtY9VQ4Qqtcl8bYXWZWwzYyGCxNFBAmEafbw=
X-Google-Smtp-Source: ABdhPJxJ6tU3iv6ZTZdFdsDIf4WvuvuPVt1sg1fug6jUfJkmip9XyKYbki5Vhi6bMNmdl6Ae9J2s/GR+4NVJhh7Ohx4=
X-Received: by 2002:a05:6e02:20c3:b0:2cf:976d:f43c with SMTP id
 3-20020a056e0220c300b002cf976df43cmr12036180ilq.264.1652813071800; Tue, 17
 May 2022 11:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220515064126.1424-1-linux.amoon@gmail.com> <20220515064126.1424-4-linux.amoon@gmail.com>
 <7c479bdb-4bf7-68a5-c6e7-20dc19b91dc8@linaro.org>
In-Reply-To: <7c479bdb-4bf7-68a5-c6e7-20dc19b91dc8@linaro.org>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 18 May 2022 00:14:16 +0530
Message-ID: <CANAwSgS4uEJd98hs-CGU+LqzMfAqJzvbEgQp5MRC4ad5XT3XfA@mail.gmail.com>
Subject: Re: [PATCHv2 3/6] thermal: exynos: Check before clk_disable_unprepare()
 not needed
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Sun, 15 May 2022 at 15:13, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 15/05/2022 08:41, Anand Moon wrote:
> > All code in clk_disable_unprepare() already checks the clk ptr using
> > IS_ERR_OR_NULL so there is no need to check it again before calling it.
> > A lot of other drivers already rely on this behaviour, so it's safe
> > to do so here.
> >
> > Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > v1: improve the commit message
> > ---
> >  drivers/thermal/samsung/exynos_tmu.c | 12 ++++--------
> >  1 file changed, 4 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> > index 1ef90dc52c08..58ff1b577c47 100644
> > --- a/drivers/thermal/samsung/exynos_tmu.c
> > +++ b/drivers/thermal/samsung/exynos_tmu.c
> > @@ -289,8 +289,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
> >
> >       mutex_lock(&data->lock);
> >       clk_enable(data->clk);
> > -     if (!IS_ERR(data->clk_sec))
> > -             clk_enable(data->clk_sec);
> > +     clk_enable(data->clk_sec);
>
> You say that clk_enable() checks for IS_ERR_OR_NULL. Where? I see only
> check for non-null case and then immediately taking clk prepare lock.
>
> This looks buggy... did you test it?

Thanks for your review comments
Yes have tested the changes, this was last-minute changes
will drop this in the next version.

>
> Best regards,
> Krzysztof

Thanks & Regards


-Anand
