Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646A4566A24
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 13:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbiGELv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 07:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiGELv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 07:51:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50548175B8;
        Tue,  5 Jul 2022 04:51:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0A62B817CC;
        Tue,  5 Jul 2022 11:51:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60438C341C7;
        Tue,  5 Jul 2022 11:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657021882;
        bh=8HX0q1v4bVW7EEm1S8O24u/Z8pt58GWOB4V5BuNmPrg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YHFAOi08AvKpokYgI7PUKYQL3d4jofoBstvbDMDuHPYPjciMiOjPArwXYNs7QgjQe
         Rjhb82AypMx/6SpCaxNLvjEgsXBkBzlUz/rvyWFXd3hHNDqiB8ccnTeFNzSt+aE9uV
         92rp21qwVy4hAuLsy560Wdhceicv0Jo/DGaAcr7o=
Date:   Tue, 5 Jul 2022 13:51:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thierry Strudel <tstrudel@google.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Pin-yen Lin <treapking@chromium.org>
Subject: Re: [PATCH] PM: domains: Ensure genpd_debugfs_dir exists before
 remove
Message-ID: <YsQluCvLLRXSo3Oc@kroah.com>
References: <20220705094946.827697-1-hsinyi@chromium.org>
 <YsQUrXfugKT1IV75@kroah.com>
 <CAJMQK-jA-GWw=v1PGAfYBKq5KWyYXGbYk30jVx26b1HWiw5yTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJMQK-jA-GWw=v1PGAfYBKq5KWyYXGbYk30jVx26b1HWiw5yTQ@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 07:06:41PM +0800, Hsin-Yi Wang wrote:
> On Tue, Jul 5, 2022 at 6:38 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Jul 05, 2022 at 05:49:47PM +0800, Hsin-Yi Wang wrote:
> > > genpd_debug_remove() may be indirectly called from others while
> > > genpd_debugfs_dir is not yet set. Make sure genpd_debugfs_dir exists
> > > before remove the sub components, otherwise components under
> > > /sys/kernel/debug may be accidentally removed.
> > >
> > > Fixes: 718072ceb211 ("PM: domains: create debugfs nodes when adding power domains")
> > > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > > ---
> > > An example:
> > > scpsys_probe() in drivers/soc/mediatek/mtk-pm-domains.c indirectly calls
> > > genpd_debug_remove() on probe fail, causing /sys/kernel/debug/usb to be
> > > removed.
> > > ---
> > >  drivers/base/power/domain.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > > index 3e86772d5fac5..5a2e0232862e0 100644
> > > --- a/drivers/base/power/domain.c
> > > +++ b/drivers/base/power/domain.c
> > > @@ -222,6 +222,9 @@ static void genpd_debug_remove(struct generic_pm_domain *genpd)
> > >  {
> > >       struct dentry *d;
> > >
> > > +     if (!genpd_debugfs_dir)
> > > +             return;
> > > +
> > >       d = debugfs_lookup(genpd->name, genpd_debugfs_dir);
> > >       debugfs_remove(d);
> >
> > Why not just change this to be:
> >         debugfs_remove(debugfs_lookup(genpd->name, debugfs_lookup("pm_genpd", NULL)));
> If pm_genpd hasn't been created yet,  debugfs_lookup("pm_genpd", NULL)
> will return null.

And how is this codepath being called if pm_genpd is not created yet?
Surely you are not relying on the presence of a debugfs file to
determine that?

> If genpd->name also exists under root debugfs, it will still be
> deleted unintentionally, since NULL represents root debugfs.
> Eg. one of the genpd->name is "usb", which is supposed to be added as
> /sys/kernel/debug/pm_genpd/usb later. But pm_genpd is not yet created,
> /sys/kernel/debug/usb will be removed.

Ah, that's a bad name to pick :)

But still, don't paper over this problem, please solve the root issue of
never relying on the creation of a debugfs file to determine functional
logic.

thanks,

greg k-h
