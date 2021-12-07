Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D69846C84F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 00:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238292AbhLGXka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 18:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbhLGXk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 18:40:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9161CC061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 15:36:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9727DB81D80
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 23:36:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA742C341C3;
        Tue,  7 Dec 2021 23:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638920215;
        bh=FG2SGFwHcUyA+9+/Ri7rTgQT9k2NE3/aM61sY9WDemQ=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Aok5DLUJj+Jy+u4ZaMwSlbC6ocZ+w7ekCFqJtmvUvFk88u7LuWmPb2RtTfOeKJ+vj
         74uRJCdnaTNBaLlNCL85DkWQ3ctIxEImPA/IjNSnrAU4RDG3ozJGTMnEH8LqxLCt0t
         M7L/j8LTAapBoD22PIB7nlv5uIAWuNbF5VX5lLdurPYF2WssIJmXdUM/kpkGsOIoj0
         hZ1vkRZUR0bho/yrYDQg1m5hNj3V/igTBF+RgOKwwsTFsYZM8XIZVtlil77U/38TKM
         qYlB/av2z5AFJH8/fB2CHpPVVOY9sAJhxDtFDi9D7dMKcgqpBTPTe1F0x3YU8vBlP+
         vsA2scHSad/Ww==
Date:   Tue, 7 Dec 2021 15:36:53 -0800 (PST)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Oleksandr <olekstysh@gmail.com>
cc:     Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Julien Grall <julien@xen.org>
Subject: Re: [PATCH V3 4/6] xen/unpopulated-alloc: Add mechanism to use Xen
 resource
In-Reply-To: <c2e8c00a-3856-8330-8e8f-ab8a92e93e47@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2112071506370.4091490@ubuntu-linux-20-04-desktop>
References: <1637787223-21129-1-git-send-email-olekstysh@gmail.com> <1637787223-21129-5-git-send-email-olekstysh@gmail.com> <alpine.DEB.2.22.394.2111241701240.1412361@ubuntu-linux-20-04-desktop> <c2e8c00a-3856-8330-8e8f-ab8a92e93e47@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1417778164-1638918436=:4091490"
Content-ID: <alpine.DEB.2.22.394.2112071520320.4091490@ubuntu-linux-20-04-desktop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1417778164-1638918436=:4091490
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.22.394.2112071520321.4091490@ubuntu-linux-20-04-desktop>

On Thu, 25 Nov 2021, Oleksandr wrote:
> > > Please note the following:
> > > for V3 arch_xen_unpopulated_init() was moved to init() as was agreed
> > > and gained __init specifier. So the target_resource is initialized there.
> > > 
> > > With current patch series applied if CONFIG_XEN_UNPOPULATED_ALLOC
> > > is enabled:
> > > 
> > > 1. On Arm, under normal circumstances, the xen_alloc_unpopulated_pages()
> > > won't be called “before” arch_xen_unpopulated_init(). It will only be
> > > called "before" when either ACPI is in use or something wrong happened
> > > with DT (and we failed to read xen_grant_frames), so we fallback to
> > > xen_xlate_map_ballooned_pages() in arm/xen/enlighten.c:xen_guest_init(),
> > > please see "arm/xen: Switch to use gnttab_setup_auto_xlat_frames() for DT"
> > > for details. But in that case, I think, it doesn't matter much whether
> > > xen_alloc_unpopulated_pages() is called "before" of "after"
> > > target_resource
> > > initialization, as we don't have extended regions in place the
> > > target_resource
> > > will remain invalid even after initialization, so
> > > xen_alloc_ballooned_pages()
> > > will be used in both scenarios.
> > > 
> > > 2. On x86, I am not quite sure which modes use unpopulated-alloc (PVH?),
> > > but it looks like xen_alloc_unpopulated_pages() can (and will) be called
> > > “before” arch_xen_unpopulated_init().
> > > At least, I see that xen_xlate_map_ballooned_pages() is called in
> > > x86/xen/grant-table.c:xen_pvh_gnttab_setup(). According to the initcall
> > > levels for both xen_pvh_gnttab_setup() and init() I expect the former
> > > to be called earlier.
> > > If it is true, the sentence in the commit description which mentions
> > > that “behaviour on x86 is not changed” is not precise. I don’t think
> > > it would be correct to fallback to xen_alloc_ballooned_pages() just
> > > because we haven’t initialized target_resource yet (on x86 it is just
> > > assigning it iomem_resource), at least this doesn't look like an expected
> > > behaviour and unlikely would be welcome.
> > > 
> > > I am wondering whether it would be better to move
> > > arch_xen_unpopulated_init()
> > > to a dedicated init() marked with an appropriate initcall level
> > > (early_initcall?)
> > > to make sure it will always be called *before*
> > > xen_xlate_map_ballooned_pages().
> > > What do you think?
> 
>    ... here (#2). Or I really missed something and there wouldn't be an issue?

Yes, I see your point. Yeah, it makes sense to make sure that
drivers/xen/unpopulated-alloc.c:init is executed before
xen_pvh_gnttab_setup.

If we move it to early_initcall, then we end up running it before
xen_guest_init on ARM. But that might be fine: it looks like it should
work OK and would also allow us to execute xen_xlate_map_ballooned_pages
with target_resource already set.

So I'd say go for it :)
--8323329-1417778164-1638918436=:4091490--
