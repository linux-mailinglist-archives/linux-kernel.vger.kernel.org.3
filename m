Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3676C5668E1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 13:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiGELHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 07:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiGELHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 07:07:12 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D654E14027
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 04:07:08 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id k2so1867358vsc.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 04:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y9e8t0xvIcP4OOyjUt8Jy2aBr44SekSg/71LORWW1kU=;
        b=Akgtn8lqhtzQ/KRNwL5iZw/qXJVwS20VolfQBkoxHnpVX/FMk97auoaz5PyknxSvmk
         ZrMfqXEAg4dAIj9RLqIg1IFsJ/VD26Ps+alf6J93ZJns08y4glI8Mx/BFnsQ9emmCzo1
         H7OFTi0mNbFDWp9opyqQRoLBa4En2DAQH8JQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y9e8t0xvIcP4OOyjUt8Jy2aBr44SekSg/71LORWW1kU=;
        b=KaFSAztH858OZlIRs4GU0mUSe7cC9wsEKQEuOZsNNYKY2+6IvWLW9rxoSsiuR8RMEW
         XQkK0GoVTkPIWJbhYrKOqCf+/Yjb4tlxuR1Cz6+UNKkZifC/zxiC1DMsWyLF1qQKtsf/
         j1qScjbwMOEVhgwc7VRMRIYfYNIS0XFyoDiQBUQVnUZ5f7geXwQqJ1Vt/Y18PGp2GaP9
         MTYEDlGm0hRDowunhNdk2FdpqFpGQjlpxZvbn3lOXRqAtoL9m2eJZXvJI0wnkHgepOfv
         J2BoyRh2ve9j9RBq7e/pveZsDAy0uVXoetP1hg0j9ttYFgSGPS1tyZL4VOBulD3Zf0tZ
         6PBg==
X-Gm-Message-State: AJIora+KZZryT3tyM1/ml0sSSc5Ga39v03qaoQg+Xi4HqwTUAcJae3Sf
        K0btPO7hDxH6rYq7JBAZUWXeCiro/lxW+7ZsM6hpLg==
X-Google-Smtp-Source: AGRyM1uU8wD/f57nGYm4GpQ8Sq+qZiZOniYgpVwcushbr1cGJbgDtPk8cgKK2bx2o6/CJ/4GwNNTygGXN7DxZqr6eOA=
X-Received: by 2002:a67:f614:0:b0:356:bb60:3eca with SMTP id
 k20-20020a67f614000000b00356bb603ecamr5823068vso.69.1657019227439; Tue, 05
 Jul 2022 04:07:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220705094946.827697-1-hsinyi@chromium.org> <YsQUrXfugKT1IV75@kroah.com>
In-Reply-To: <YsQUrXfugKT1IV75@kroah.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 5 Jul 2022 19:06:41 +0800
Message-ID: <CAJMQK-jA-GWw=v1PGAfYBKq5KWyYXGbYk30jVx26b1HWiw5yTQ@mail.gmail.com>
Subject: Re: [PATCH] PM: domains: Ensure genpd_debugfs_dir exists before remove
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thierry Strudel <tstrudel@google.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Pin-yen Lin <treapking@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 5, 2022 at 6:38 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jul 05, 2022 at 05:49:47PM +0800, Hsin-Yi Wang wrote:
> > genpd_debug_remove() may be indirectly called from others while
> > genpd_debugfs_dir is not yet set. Make sure genpd_debugfs_dir exists
> > before remove the sub components, otherwise components under
> > /sys/kernel/debug may be accidentally removed.
> >
> > Fixes: 718072ceb211 ("PM: domains: create debugfs nodes when adding power domains")
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > ---
> > An example:
> > scpsys_probe() in drivers/soc/mediatek/mtk-pm-domains.c indirectly calls
> > genpd_debug_remove() on probe fail, causing /sys/kernel/debug/usb to be
> > removed.
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
> >       struct dentry *d;
> >
> > +     if (!genpd_debugfs_dir)
> > +             return;
> > +
> >       d = debugfs_lookup(genpd->name, genpd_debugfs_dir);
> >       debugfs_remove(d);
>
> Why not just change this to be:
>         debugfs_remove(debugfs_lookup(genpd->name, debugfs_lookup("pm_genpd", NULL)));
If pm_genpd hasn't been created yet,  debugfs_lookup("pm_genpd", NULL)
will return null.
If genpd->name also exists under root debugfs, it will still be
deleted unintentionally, since NULL represents root debugfs.
Eg. one of the genpd->name is "usb", which is supposed to be added as
/sys/kernel/debug/pm_genpd/usb later. But pm_genpd is not yet created,
/sys/kernel/debug/usb will be removed.

>
> thanks,
>
> greg k-h
