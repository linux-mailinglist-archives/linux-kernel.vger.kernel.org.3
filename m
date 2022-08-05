Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADDD58AC2A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 16:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240894AbiHEOK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 10:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240906AbiHEOKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 10:10:43 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E5B26554;
        Fri,  5 Aug 2022 07:10:41 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-328a1cff250so25426477b3.6;
        Fri, 05 Aug 2022 07:10:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=CHx7bJPvvyTngqWiFPDdkK2Ii5TEJtPQmjfIfoaxYFY=;
        b=NSTr78hm8kwgepBwe2aJ/ueD9Wm9YLRFP0LhX/rTNo7N+HqDN1dfMyBrGU7wvIaQk2
         gFVR3F7LBqIhVsb4c2Y5EcBlYurdBX90n6NZR56ffbOVjw2KjTo7VxHiAZ1tBKlx8hEZ
         dQKjlttvm7C6wOSrliiaSgNIwQI40iaAGr6vGtgmVinbLaEt/zzRXXVpjhBWVCMDOOjI
         o0ugR/03fiq2N74rCwq1tG09+MNF922XNeJJKFDEAU7q8SQlAH6OJ3oWo/YtPoaBWwa7
         8teNz+UNl/qnds2D+Z+9x1Po+5Kf1ySj+A/cCI6nhTzGtC5h3l0Pcf3bIQ3EqmkAJZ/9
         lVtg==
X-Gm-Message-State: ACgBeo2879Ks7vGRwfOICdQKMyx9C4ofvzumweeNpQlTofDJYjXU2yXQ
        3tHLJxArWLuz3RityNWCLU+FqJEy9XCb+Buywsw=
X-Google-Smtp-Source: AA6agR71VAjeCfoinelkmVMZFjmxfMNcwzNppNMp7moYuaidxLoi4rQ3wlVfEos3tVRX9iGw46tP/793Q3/dv/eWuL0=
X-Received: by 2002:a81:ae0a:0:b0:324:59ab:feec with SMTP id
 m10-20020a81ae0a000000b0032459abfeecmr6372940ywh.7.1659708640995; Fri, 05 Aug
 2022 07:10:40 -0700 (PDT)
MIME-Version: 1.0
References: <2643836.mvXUDI8C0e@kreacher> <FA016A79-B2B1-42A4-A63F-3A44B3EC57CB@chromium.org>
In-Reply-To: <FA016A79-B2B1-42A4-A63F-3A44B3EC57CB@chromium.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 5 Aug 2022 16:10:29 +0200
Message-ID: <CAJZ5v0j0ebQMWeR2VWjdRufYEoQ_viysYjsvFSVFX11ef2R17Q@mail.gmail.com>
Subject: Re: [PATCH] PM: core: Do not randomize struct dev_pm_ops layout
To:     Kees Cook <keescook@chromium.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

On Fri, Aug 5, 2022 at 4:12 AM Kees Cook <keescook@chromium.org> wrote:
>
>
>
> On August 4, 2022 10:15:08 AM PDT, "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
> >From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> >Because __rpm_get_callback() uses offsetof() to compute the address of
> >the callback in question in struct dev_pm_ops, randomizing the layout
> >of the latter leads to interesting, but unfortunately also undesirable
> >results in some cases.
>
> How does this manifest? This is a compile-time randomization, so offsetof() will find the correct location.

Well, I would think so.

> Is struct dev_pm_ops created or consumed externally from the kernel at any point?

I'm not sure TBH.  I have seen a trace where pci_pm_resume_noirq() is
evidently called via rpm_callback() which should never happen if the
offset computation is correct.

The driver in question (which is out of the tree for now) is modular,
so in theory it could be built separately from the rest of the kernel,
but I think that this still should work, shouldn't it?

> >
> >Prevent that from happening by using the __no_randomize_layout
> >annotation on struct dev_pm_ops.
> >
> >Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >---
> > include/linux/pm.h |    2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >Index: linux-pm/include/linux/pm.h
> >===================================================================
> >--- linux-pm.orig/include/linux/pm.h
> >+++ linux-pm/include/linux/pm.h
> >@@ -307,7 +307,7 @@ struct dev_pm_ops {
> >       int (*runtime_suspend)(struct device *dev);
> >       int (*runtime_resume)(struct device *dev);
> >       int (*runtime_idle)(struct device *dev);
> >-};
> >+} __no_randomize_layout;
> >
> > #define SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
> >       .suspend = pm_sleep_ptr(suspend_fn), \
> >
> >
> >
>
> --
> Kees Cook
