Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF02F575568
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 20:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240843AbiGNSwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 14:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240858AbiGNSv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 14:51:57 -0400
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCC94F184;
        Thu, 14 Jul 2022 11:51:56 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id f73so4737826yba.10;
        Thu, 14 Jul 2022 11:51:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3/76e6BlVGV7ahO1isbvVhUJJRuUP5o5Z+iCFPnIizw=;
        b=yOOqWOUnm8Tx0OnYbDWYY7IJxsxh/pNA2rJeWHSogG3Ey6Wqh1b6QLFrVEBqOfbdBw
         Fg3Rx9chofrQD/ywpg4PFjs+aVN23xtxaUB4daDd4mZFgVeumI8HXDCbOjmXyy8kcKyj
         RJnnoiqGFICKhH5kXfeK5j4XXH5uqaMXfRTG9uZJ/BLTRFUKkh/MCn2G/70PYaR0OURX
         zou4pw1S9sbJbkZB/HFMhDLsyokxu13KOlZB4GQYR0jOseqFMlDHh8H0zT2+8jrzDIUe
         c6+LMtWbh6X6pdr6Xj/rq9r9O2czMUDlsXmsQ4Q47AkBXK9mWWAIDzw5Zap2xy574uIq
         PyDA==
X-Gm-Message-State: AJIora/7BwxhNc+9CBluoKFmoyE8cnM3MFbAU/Hb+NwRcLlpImK/p+1o
        laEJ2MvFq3b9ahk0AwEE0r6UCz87/9eHT4an6/k=
X-Google-Smtp-Source: AGRyM1uur5/4lggHX24EOZlmbHnkEJijJc6oXj383leHiHm+k9DSPmF5klys5sXwsx8O6F8hcRATRjMsm3Rqr+ZP3ac=
X-Received: by 2002:a05:6902:154f:b0:66e:e2d3:ce1 with SMTP id
 r15-20020a056902154f00b0066ee2d30ce1mr9474182ybu.365.1657824715446; Thu, 14
 Jul 2022 11:51:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220705171649.969194-1-hsinyi@chromium.org> <CAPDyKFq1KLYEo9jtN4j-=+sRoYtb0su5LzcErEWAtTxEKEF-mA@mail.gmail.com>
In-Reply-To: <CAPDyKFq1KLYEo9jtN4j-=+sRoYtb0su5LzcErEWAtTxEKEF-mA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 14 Jul 2022 20:51:44 +0200
Message-ID: <CAJZ5v0gS1kdmFD=HWW+8qOhnd8N3c5mGEKVMzdk4-=_tAPx=JA@mail.gmail.com>
Subject: Re: [PATCH v2] PM: domains: Ensure genpd_debugfs_dir exists before remove
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Pin-yen Lin <treapking@chromium.org>,
        Linux PM <linux-pm@vger.kernel.org>,
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

On Wed, Jul 13, 2022 at 2:02 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 5 Jul 2022 at 19:17, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> >
> > Both genpd_debug_add() and genpd_debug_remove() may be called
> > indirectly by other drivers while genpd_debugfs_dir is not yet
> > set. For example, drivers can call pm_genpd_init() in probe or
> > pm_genpd_init() in probe fail/cleanup path:
> >
> > pm_genpd_init()
> >  --> genpd_debug_add()
> >
> > pm_genpd_remove()
> >  --> genpd_remove()
> >    --> genpd_debug_remove()
> >
> > At this time, genpd_debug_init() may not yet be called.
> >
> > genpd_debug_add() checks that if genpd_debugfs_dir is NULL, it
> > will return directly. Make sure this is also checked
> > in pm_genpd_remove(), otherwise components under debugfs root
> > which has the same name as other components under pm_genpd may
> > be accidentally removed, since NULL represents debugfs root.
> >
> > Fixes: 718072ceb211 ("PM: domains: create debugfs nodes when adding power domains")
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Applied as 5.20 material, thanks!

> > ---
> > v1->v2: Add more context in commit message
> > ---
> >  drivers/base/power/domain.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index 3e86772d5fac5..5a2e0232862e0 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -222,6 +222,9 @@ static void genpd_debug_remove(struct generic_pm_domain *genpd)
> >  {
> >         struct dentry *d;
> >
> > +       if (!genpd_debugfs_dir)
> > +               return;
> > +
> >         d = debugfs_lookup(genpd->name, genpd_debugfs_dir);
> >         debugfs_remove(d);
> >  }
> > --
> > 2.37.0.rc0.161.g10f37bed90-goog
> >
