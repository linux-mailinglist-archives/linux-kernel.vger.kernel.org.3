Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7AD567565
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 19:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbiGERR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 13:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiGERR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 13:17:57 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7458E1CFD0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 10:17:56 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id j15so125260vkn.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 10:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DibX9iQEUFrXxkIm9PYaQ+YczA5+PDT4pu/k9a93CZ4=;
        b=nK5H+j5ZR39sYeXQoPrCBk/xTcXYb0lrGz/hZhHBtPek2kaE+xuCcYjTmZZBb5J4IZ
         VFXFAj0a3LAS8jtJhbS4PtkPhPg1CjfV00iuEL+oI3k5WQYaDFov2C6t9uju9W509TwD
         /5RBMO3qIpkp6DxPnVoIw5VeFwEi5JWiEJotw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DibX9iQEUFrXxkIm9PYaQ+YczA5+PDT4pu/k9a93CZ4=;
        b=4/xnd39k26sbwxLDG/09tUQh1OWLf2lf7vDeCogfu5uOW8BXp1ISNsGFEjBExj5LSC
         RVwiuo8cSfdKVkcGt8CmSXx82MtRAZkuob9Q/4NoR1KMe3JgdEvqG/arSzNBzAvJPgtW
         OXnd44+sPTZPr1WJM8S1KAH+qErxXKvW04fU2BAY5N0efxX8NFHg9dndCtBOMbcXiNTp
         Nj6Ayb9mwuNHYK8usFL41ujeWez5Su9F0KcxXUxeIQIUUhB6g+W2j3VEj24swtFRtDcQ
         11QjeEUw5/WOu8rE9yD/RZZOFfhLLR31/AzQ0iQ9/iRiPcIyo/QN4atRgkTtWUiC2FSl
         l/yQ==
X-Gm-Message-State: AJIora9yRyaK/PWZG3q6PTIBW4mh5uuPtfIJ7IkV/K5eSFcYY2LBAAp8
        e+B/rAD3af6FqnDCZuew7soW1FhYKOu1yaPp3usKJw==
X-Google-Smtp-Source: AGRyM1vjE+XIl428JT5ISAnbg0EIoYJ+7JSRqA2pTtZa1SnDBKe7Cz1aIqj0GttScxh4Hat1teS3mBNopwWOIyHsf50=
X-Received: by 2002:a05:6122:152b:b0:36c:2e3f:599b with SMTP id
 g11-20020a056122152b00b0036c2e3f599bmr21318514vkq.5.1657041475532; Tue, 05
 Jul 2022 10:17:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220705094946.827697-1-hsinyi@chromium.org> <YsQUrXfugKT1IV75@kroah.com>
 <CAJMQK-jA-GWw=v1PGAfYBKq5KWyYXGbYk30jVx26b1HWiw5yTQ@mail.gmail.com>
 <YsQluCvLLRXSo3Oc@kroah.com> <CAJMQK-gtfCL3smM6EAm2bLsSWvuk1QzviCQ6de4k8wiphEKQHg@mail.gmail.com>
 <YsRmQVrcAuguv03U@kroah.com>
In-Reply-To: <YsRmQVrcAuguv03U@kroah.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Wed, 6 Jul 2022 01:27:07 +0800
Message-ID: <CAJMQK-gYjdWg8wXHMjzRSBvAPHO9aT08tqiviJ8O3jjYe8PV3g@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 6, 2022 at 12:26 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jul 05, 2022 at 11:58:52PM +0800, Hsin-Yi Wang wrote:
> > On Tue, Jul 5, 2022 at 7:51 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, Jul 05, 2022 at 07:06:41PM +0800, Hsin-Yi Wang wrote:
> > > > On Tue, Jul 5, 2022 at 6:38 PM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Tue, Jul 05, 2022 at 05:49:47PM +0800, Hsin-Yi Wang wrote:
> > > > > > genpd_debug_remove() may be indirectly called from others while
> > > > > > genpd_debugfs_dir is not yet set. Make sure genpd_debugfs_dir exists
> > > > > > before remove the sub components, otherwise components under
> > > > > > /sys/kernel/debug may be accidentally removed.
> > > > > >
> > > > > > Fixes: 718072ceb211 ("PM: domains: create debugfs nodes when adding power domains")
> > > > > > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > > > > > ---
> > > > > > An example:
> > > > > > scpsys_probe() in drivers/soc/mediatek/mtk-pm-domains.c indirectly calls
> > > > > > genpd_debug_remove() on probe fail, causing /sys/kernel/debug/usb to be
> > > > > > removed.
> > > > > > ---
> > > > > >  drivers/base/power/domain.c | 3 +++
> > > > > >  1 file changed, 3 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > > > > > index 3e86772d5fac5..5a2e0232862e0 100644
> > > > > > --- a/drivers/base/power/domain.c
> > > > > > +++ b/drivers/base/power/domain.c
> > > > > > @@ -222,6 +222,9 @@ static void genpd_debug_remove(struct generic_pm_domain *genpd)
> > > > > >  {
> > > > > >       struct dentry *d;
> > > > > >
> > > > > > +     if (!genpd_debugfs_dir)
> > > > > > +             return;
> > > > > > +
> > > > > >       d = debugfs_lookup(genpd->name, genpd_debugfs_dir);
> > > > > >       debugfs_remove(d);
> > > > >
> > > > > Why not just change this to be:
> > > > >         debugfs_remove(debugfs_lookup(genpd->name, debugfs_lookup("pm_genpd", NULL)));
> > > > If pm_genpd hasn't been created yet,  debugfs_lookup("pm_genpd", NULL)
> > > > will return null.
> > >
> > > And how is this codepath being called if pm_genpd is not created yet?
> > > Surely you are not relying on the presence of a debugfs file to
> > > determine that?
> > >
> >
> > Caller didn't directly call genpd_debug_remove(). The flow is as follows:
> >
> > Normally, scpsys will create pm domain by:
> > scpsys_probe()
> >    --> scpsys_add_one_domain()
> >      --> pm_genpd_init()
> >        --> genpd_debug_add()
> >
> >
> > If something fails, it will do the cleanup:
> > scpsys_probe()
> >   --> scpsys_domain_cleanup()
> >      --> scpsys_remove_one_domain()
> >        --> pm_genpd_remove()
> >           --> genpd_remove()
> >             --> genpd_debug_remove()
> >
> > genpd_debug_add() checks if genpd_debugfs_dir is init by a
> > late_initcall genpd_debug_init(). If it's NULL, it will return
> > directly without creating anything. Later when genpd_debug_init() is
> > called, it will call genpd_debug_add() again.
> >
> > pm_genpd_remove() still needs to be called on the cleanup path to free
> > other stuff, but if genpd_debug_init() hasn't happened,
> > genpd_debug_remove() should be a no-op, or genpd_remove() shouldn't
> > call it. (We can move the check there, but adding in
> > genpd_debug_remove() is more similar to what genpd_debug_add()
> > currently is.)
>
> Thanks for the details.  You might want to include this in the changelog
> text.  I'm ok with the change now if that information is in there, I
> missed that there are paths to create devices before debugfs is
> initialized.
>
Done. Added in v2. Thanks for the review.

> thanks,
>
> greg k-h
