Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF00519BF9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 11:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347296AbiEDJjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 05:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347712AbiEDJjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 05:39:22 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6696226117
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 02:35:46 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id x33so1369323lfu.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 02:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9/WJ0tqMozkcFwQbk0zwDH9itMdQXF9SUhVNLVNoj+0=;
        b=boEv99Alzg6cPbETkNH72ehzATXFLMi5L3muYvYsEn/vKqkvsCs1VdacBOyJpuE0N9
         /RiBOILz34hEQ06GMFwyq7fIDpy8/fsTesXOsvHRgDwhs6aAYEAJOE3siuM5BFHieTVc
         1QBC2R6vyZUP8e3ACeDowMLf3pXC8YeRdpx6O6fF0tf87oJHYuLu/93+ZGIww1e/YC8A
         RxOHBwucOrOR6Opexh2tUF2w5dDuZXmJ1+dXRv2YKsgjflGj1dd3ObIOq5xQD+oQ3Fyz
         OsuFogZisOa/u4a0Km3JfSnfWScn0V00W2g9UA+R126iqo7tmLlI7sUhj3RDLDQyDaSQ
         Scqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9/WJ0tqMozkcFwQbk0zwDH9itMdQXF9SUhVNLVNoj+0=;
        b=QLC4dNjiWOovmq1CAZveiA1zgS707iytj5YP6ToiwF/LcMtap4FGNi6jGS/6uHDTLW
         ehZtGY38Rl1iZ15Z3YBW127gQ3lu01ah6QGuX9b1G/JcTsFgK+8/Mdkibp64D3yRL8/Z
         cZzaYOJXkjVlNKUCqdFIT+ViQkXoh4B/I9bQ6Usv5iKe9k5SYyY0fsJGL5KhlgcGqf7f
         11LBZ2eFI+fahoIpxJDJYlUwtnUYDJBWighmsiBkli8T3NmBKJz/ONzbieeXSN6wVLLH
         PgEP84Wk748v5LFwCHpU7EwmUNipMOBmpaonFrxiRg3qfSZFpxSWTcc0ylU98vDLrVBw
         dCDg==
X-Gm-Message-State: AOAM531GFhzXYlwCS3e6NIuJIXvuWUZENmK/Q+QM7WxJTvP1Hyp1ztJ2
        SkmnsulsPzHymUONbqxk3enfDh8/UognOl3GP0aI2w==
X-Google-Smtp-Source: ABdhPJxdJ7AeCc3WGwsxm2aWitYelOiSZyUAsthyGttVRji7k1IxzTQn213OcxxbKtIt5MCydz7+Y7/NhLVt1QyP9b0=
X-Received: by 2002:a19:e007:0:b0:44a:a22d:2d49 with SMTP id
 x7-20020a19e007000000b0044aa22d2d49mr13432121lfg.254.1651656944773; Wed, 04
 May 2022 02:35:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220426141507.89868-1-ulf.hansson@linaro.org>
In-Reply-To: <20220426141507.89868-1-ulf.hansson@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 May 2022 11:35:08 +0200
Message-ID: <CAPDyKFrxr_t5iCa4E5Obvzk25wQbLCoY2Co=8iG==WfbBhpRVQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] PM: domains: Some minor improvements for genpd_power_off()
To:     "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc:     Kevin Hilman <khilman@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2022 at 16:15, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> This small series intends to improve some of the execution paths when powering
> off a genpd. More information is available in the commit messages.
>
> Ulf Hansson (3):
>   PM: domains: Add GENPD_FLAG_RPM_ALWAYS_ON for the always-on governor
>   PM: domains: Drop redundant code for genpd always-on governor
>   PM: domain: Don't check PM_QOS_FLAG_NO_POWER_OFF in genpd
>
>  drivers/base/power/domain.c          | 10 ++++------
>  drivers/base/power/domain_governor.c |  6 ------
>  2 files changed, 4 insertions(+), 12 deletions(-)
>

Rafael, I have another slew of patches for genpd that I am getting
prepared to submit. However, it would be nice to get @subject series
queued first. Is it ready to go, you think?

Kind regards
Uffe
