Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506FC567432
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 18:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbiGEQ0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 12:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiGEQ0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 12:26:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AA715717;
        Tue,  5 Jul 2022 09:26:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEB2D61BF4;
        Tue,  5 Jul 2022 16:26:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A223FC341C7;
        Tue,  5 Jul 2022 16:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657038404;
        bh=xdkJ7dDI1TMRfLqibzYhOTOYetxZoqPZfydt+biEvLU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kWxNROmp9R1w+sHCDwq34HpsR/P/bYP1YyJTlrBFRbzTTg1TGK4+UACqqGtEX8q4G
         g8mdzVIhDrzuFPp3Qv9PHUaBpduIKfMkmybADyOSNU0uVrYi633TcgBVpf0wElooP8
         G5gtLo7aYlN9if14nJafisUEhLkGNABol3TP8Kcs=
Date:   Tue, 5 Jul 2022 18:26:41 +0200
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
Message-ID: <YsRmQVrcAuguv03U@kroah.com>
References: <20220705094946.827697-1-hsinyi@chromium.org>
 <YsQUrXfugKT1IV75@kroah.com>
 <CAJMQK-jA-GWw=v1PGAfYBKq5KWyYXGbYk30jVx26b1HWiw5yTQ@mail.gmail.com>
 <YsQluCvLLRXSo3Oc@kroah.com>
 <CAJMQK-gtfCL3smM6EAm2bLsSWvuk1QzviCQ6de4k8wiphEKQHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJMQK-gtfCL3smM6EAm2bLsSWvuk1QzviCQ6de4k8wiphEKQHg@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 11:58:52PM +0800, Hsin-Yi Wang wrote:
> On Tue, Jul 5, 2022 at 7:51 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Jul 05, 2022 at 07:06:41PM +0800, Hsin-Yi Wang wrote:
> > > On Tue, Jul 5, 2022 at 6:38 PM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Tue, Jul 05, 2022 at 05:49:47PM +0800, Hsin-Yi Wang wrote:
> > > > > genpd_debug_remove() may be indirectly called from others while
> > > > > genpd_debugfs_dir is not yet set. Make sure genpd_debugfs_dir exists
> > > > > before remove the sub components, otherwise components under
> > > > > /sys/kernel/debug may be accidentally removed.
> > > > >
> > > > > Fixes: 718072ceb211 ("PM: domains: create debugfs nodes when adding power domains")
> > > > > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > > > > ---
> > > > > An example:
> > > > > scpsys_probe() in drivers/soc/mediatek/mtk-pm-domains.c indirectly calls
> > > > > genpd_debug_remove() on probe fail, causing /sys/kernel/debug/usb to be
> > > > > removed.
> > > > > ---
> > > > >  drivers/base/power/domain.c | 3 +++
> > > > >  1 file changed, 3 insertions(+)
> > > > >
> > > > > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > > > > index 3e86772d5fac5..5a2e0232862e0 100644
> > > > > --- a/drivers/base/power/domain.c
> > > > > +++ b/drivers/base/power/domain.c
> > > > > @@ -222,6 +222,9 @@ static void genpd_debug_remove(struct generic_pm_domain *genpd)
> > > > >  {
> > > > >       struct dentry *d;
> > > > >
> > > > > +     if (!genpd_debugfs_dir)
> > > > > +             return;
> > > > > +
> > > > >       d = debugfs_lookup(genpd->name, genpd_debugfs_dir);
> > > > >       debugfs_remove(d);
> > > >
> > > > Why not just change this to be:
> > > >         debugfs_remove(debugfs_lookup(genpd->name, debugfs_lookup("pm_genpd", NULL)));
> > > If pm_genpd hasn't been created yet,  debugfs_lookup("pm_genpd", NULL)
> > > will return null.
> >
> > And how is this codepath being called if pm_genpd is not created yet?
> > Surely you are not relying on the presence of a debugfs file to
> > determine that?
> >
> 
> Caller didn't directly call genpd_debug_remove(). The flow is as follows:
> 
> Normally, scpsys will create pm domain by:
> scpsys_probe()
>    --> scpsys_add_one_domain()
>      --> pm_genpd_init()
>        --> genpd_debug_add()
> 
> 
> If something fails, it will do the cleanup:
> scpsys_probe()
>   --> scpsys_domain_cleanup()
>      --> scpsys_remove_one_domain()
>        --> pm_genpd_remove()
>           --> genpd_remove()
>             --> genpd_debug_remove()
> 
> genpd_debug_add() checks if genpd_debugfs_dir is init by a
> late_initcall genpd_debug_init(). If it's NULL, it will return
> directly without creating anything. Later when genpd_debug_init() is
> called, it will call genpd_debug_add() again.
> 
> pm_genpd_remove() still needs to be called on the cleanup path to free
> other stuff, but if genpd_debug_init() hasn't happened,
> genpd_debug_remove() should be a no-op, or genpd_remove() shouldn't
> call it. (We can move the check there, but adding in
> genpd_debug_remove() is more similar to what genpd_debug_add()
> currently is.)

Thanks for the details.  You might want to include this in the changelog
text.  I'm ok with the change now if that information is in there, I
missed that there are paths to create devices before debugfs is
initialized.

thanks,

greg k-h
