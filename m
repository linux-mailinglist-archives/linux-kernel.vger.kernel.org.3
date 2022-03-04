Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CD94CDA73
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 18:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241059AbiCDRbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 12:31:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240891AbiCDRbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 12:31:50 -0500
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C621CD9DA;
        Fri,  4 Mar 2022 09:31:01 -0800 (PST)
Received: by mail-yb1-f182.google.com with SMTP id j2so18346985ybu.0;
        Fri, 04 Mar 2022 09:31:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uDGIY2zwKZIzvKJRqnjWoDg4iEG13RBS5dNdwIAZJ6k=;
        b=l/Gvj88ofCz3+AwTkSL6w9uUD05oERk2ON2eQQLhmo/jtjNwe5+nuM1gUCnAJFj7Jv
         tHlQq/3hW/Lc4eOcz6qMIkRAvplVGDs66hvBmnpVSidWdpUkcl7I+RJvCIT/F4WD3O+7
         T5YfXQJGPTjnMuGFQIWfWM9uvV4Ws35TRa1zXBvmrXjjFn8KTqtjGq1qxVJDsUcKEXMC
         U2owLIxpL+j5rbcdVpXOl3HE1tIxsJRcEq9maBisBzzee55KBd8AZRki1kyQrqxCpJY0
         ADYLF8AC6dpxQ9D7nqpSGBJQdXBHIHp8HwCglpeFA7EwtZvgA0nQbZuZ34N+He3FRfiB
         I0Ig==
X-Gm-Message-State: AOAM5333SWY8++vYNzq0jPfl7nQg+JKfieVtrphPU7ZdcIzEu3pVjYSE
        9xBhTdeAS2lY1wmpEjbsb1RLZkU6kkOjqpbRgnY=
X-Google-Smtp-Source: ABdhPJzGdcfDcFhvRMKBUtpb1WMOq7XyKvsFCnal9Pr7bWhUsMLATseb8bX5h5/YhPOZMlOzDnFyZoRdR5ff8Vm+E4Y=
X-Received: by 2002:a25:fe10:0:b0:625:262f:e792 with SMTP id
 k16-20020a25fe10000000b00625262fe792mr37227265ybe.365.1646415060952; Fri, 04
 Mar 2022 09:31:00 -0800 (PST)
MIME-Version: 1.0
References: <20220223083441.1.I925ce9fa12992a58caed6b297e0171d214866fe7@changeid>
 <CAPDyKFrMu+zfsTzqEA-EtBdU4Wo5m=LwAEoYXPs5PFkxOERnfg@mail.gmail.com>
In-Reply-To: <CAPDyKFrMu+zfsTzqEA-EtBdU4Wo5m=LwAEoYXPs5PFkxOERnfg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 4 Mar 2022 18:30:49 +0100
Message-ID: <CAJZ5v0hOQS66hSWEFVSGsnpeoHCe_0UqHn3vQ_K9NhKv-HK3UQ@mail.gmail.com>
Subject: Re: [PATCH] PM: runtime: Have devm_pm_runtime_enable() handle pm_runtime_dont_use_autosuspend()
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Fri, Mar 4, 2022 at 11:04 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 23 Feb 2022 at 17:35, Douglas Anderson <dianders@chromium.org> wrote:
> >
> > The PM Runtime docs say:
> >   Drivers in ->remove() callback should undo the runtime PM changes done
> >   in ->probe(). Usually this means calling pm_runtime_disable(),
> >   pm_runtime_dont_use_autosuspend() etc.
> >
> > From grepping code, it's clear that many people aren't aware of the
> > need to call pm_runtime_dont_use_autosuspend().
> >
> > When brainstorming solutions, one idea that came up was to leverage
> > the new-ish devm_pm_runtime_enable() function. The idea here is that:
> > * When the devm action is called we know that the driver is being
> >   removed. It's the perfect time to undo the use_autosuspend.
> > * The code of pm_runtime_dont_use_autosuspend() already handles the
> >   case of being called when autosuspend wasn't enabled.
> >
> > Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> Okay, this provides an improvement from the short term perspective.

I agree.

> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

And so I've queued up the patch (for 5.18).

Thanks!
