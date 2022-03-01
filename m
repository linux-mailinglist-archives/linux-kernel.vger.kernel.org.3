Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE274C8E73
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 15:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbiCAPAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 10:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233520AbiCAPAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:00:07 -0500
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E393620F6E;
        Tue,  1 Mar 2022 06:59:26 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id b35so27638512ybi.13;
        Tue, 01 Mar 2022 06:59:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8SgW14CGIz2fmHGSXWyzZD+ARD1bI2LJmVpdQaWW7X4=;
        b=SzJ+v5PVByYnKS7d5DG3OplbTgEeSVmLQS32yA6Z+fzP7hqs9Rk2rlUhDJBOGqYBem
         GqrMte4FgiWE7qSc6NjQvqRlO3Bf2mnMmj0xmQ6TWEWslxHRBaUoDrP9l7v2ZWUTJuJ4
         SFVyLR87FbT7sKTrZ+yJTItqDXHdNmwbLkCcn6gb+Zi/N1edyvlNc4yGX/ZWUo4ThhCP
         7h0Ir9WuVAkh0skfo+Oebp7JkraIZdtqCXYyArCgW/1SnwyS2eRs0X2I3sGx6Eg1M5Sv
         dUAh5F9zM/2W8tfK6N7M6Te2dpbEaW1OJg0L0S0mC3xjX8bg5JmZx/rjzvMspXLd1cw2
         jKZQ==
X-Gm-Message-State: AOAM530I/DR4IYSmwPGGcbxjzl0n0Nv00L4e6U0SgouDaL9pDjfyYDrd
        Xhq3BEMAjmSUUbDVdLSTRfGRapnPqzco/fnHt4Q=
X-Google-Smtp-Source: ABdhPJyJ96ADag2mluIBz9AvxwHjcCSmt5yDqi+bZjHppC7zBXX019YWGOhBjJk7Xs/VHuRjFqDU+B+ctAzqwnpzflA=
X-Received: by 2002:a25:7785:0:b0:614:c283:2a3d with SMTP id
 s127-20020a257785000000b00614c2832a3dmr24576087ybc.137.1646146766120; Tue, 01
 Mar 2022 06:59:26 -0800 (PST)
MIME-Version: 1.0
References: <20220223080323.3717853-1-s.hauer@pengutronix.de>
 <20220223080858.GJ9136@pengutronix.de> <CAPDyKFpyCepZ_J4LNZzz-g90RLT1mVDMbQ-gNKweM8YnEWXqdg@mail.gmail.com>
In-Reply-To: <CAPDyKFpyCepZ_J4LNZzz-g90RLT1mVDMbQ-gNKweM8YnEWXqdg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 1 Mar 2022 15:59:15 +0100
Message-ID: <CAJZ5v0i2-U4CYbw2uxm=BstQdKMbunh-oW_-SBV+Afh4d_e33w@mail.gmail.com>
Subject: Re: [PATCH] PM: domains: use dev_err_probe() to simplify error handling
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sascha Hauer <Kernel@pengutronix.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>
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

On Tue, Mar 1, 2022 at 10:44 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 23 Feb 2022 at 09:09, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> >
> > On Wed, Feb 23, 2022 at 09:03:23AM +0100, Sascha Hauer wrote:
> > > From: Ahmad Fatoum <a.fatoum@pengutronix.de>
> > >
> > > dev_err_probe() can reduce code size, makes the code easier to read
> > > and has the added benefit of recording the defer reason for later
> > > read out. Use it where appropriate.
> > >
> > > This also fixes an issue, where an error message in __genpd_dev_pm_attach
> > > was not terminated by a line break.
> > >
> > > Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> > > ---
> > >  drivers/base/power/domain.c | 21 ++++++---------------
> > >  1 file changed, 6 insertions(+), 15 deletions(-)
> >
> > And of course:
> >
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Applied as 5.18 material, thanks!
