Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7284FF8F2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 16:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235522AbiDMOcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 10:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233793AbiDMOcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 10:32:17 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8083EF19;
        Wed, 13 Apr 2022 07:29:55 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id t67so4099235ybi.2;
        Wed, 13 Apr 2022 07:29:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P6HqlanCyPSwncb4shZm76Hg2UdOq2aV2/+OAl9p+/g=;
        b=NMP0IWxZfJse6iT27NVOPoj7/t3UtTKGwibRMRnREJaHei+/pHWm+yJtJL7toiqir9
         R5r1CVqeaPKvUsTc2SyDEjob3iyvdkqz7HnCnwTIlEdtKDgsR5f2/omdsM7Gak4XIZVr
         M8PNAf9gAt1nF2SZ5GfPqM2oWKn6Ycp5AfSoRGDjRLhBloyFtIrDQq/6KNf0fHHWRCr2
         YARgSD8a6pAkgfMecLyl5sLp7sKtqzOSEZx+tIQ4dCfGsbv6LT/RQZ2kDbeeTOTQe1YC
         ysk7VsozITI6ug1X9T6aSLN06Mmc96putFFCvOMCpLLcQO/GX885GZFE2o7Ny7Eq2Pee
         EmoA==
X-Gm-Message-State: AOAM531pZY1V4I+jhnPf5stobmqkpuXxxF19/Vq/hos5fngWtc5dNNLC
        siiPNh+HX13x6OSaADnk1KeH7Xvf/P7DTqljX+4=
X-Google-Smtp-Source: ABdhPJyIEe6g/M5R+wfhGO1Tn2f6GQ9LY3zIVdu915DAN1BxmCSF3smK/dPKs7NrgvevM6qmuH0nezgz/sviDNUop8I=
X-Received: by 2002:a05:6902:1544:b0:63d:d3a7:8cc4 with SMTP id
 r4-20020a056902154400b0063dd3a78cc4mr31215822ybu.622.1649860195288; Wed, 13
 Apr 2022 07:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220321095729.20655-1-lukasz.luba@arm.com> <76230a1c-73b8-c471-c62e-3ec9b33461a6@arm.com>
 <55d4a19d-15d4-4d15-8430-8a8ed8149497@arm.com>
In-Reply-To: <55d4a19d-15d4-4d15-8430-8a8ed8149497@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Apr 2022 16:29:44 +0200
Message-ID: <CAJZ5v0g5vcC7aS4KS-uN+fHmbrKCmA-MVbJEKOnPgEyDDfqSRw@mail.gmail.com>
Subject: Re: [RESEND][PATCH 0/8] Introduce support for artificial Energy Model
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Hi,

On Tue, Apr 12, 2022 at 8:53 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Hi Rafael,
>
> gentle ping. If you need some help with this maintenance,
> we can help.

Sorry for the delay.

Given the lack of objections or concerns, I've applied the whole
series as 5.19 material.

Thanks!
