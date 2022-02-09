Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35CD4AEB04
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 08:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237555AbiBIH2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 02:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbiBIH2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 02:28:05 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B647FC0612C3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 23:28:09 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 10BB668AFE; Wed,  9 Feb 2022 08:28:06 +0100 (CET)
Date:   Wed, 9 Feb 2022 08:28:05 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Zhi Wang <zhi.wang.linux@gmail.com>, hch@lst.de, jgg@nvidia.com,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Vivi Rodrigo <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Terrence Xu <terrence.xu@intel.com>
Subject: Re: [PATCH v6 1/3] i915/gvt: Introduce the mmio table to support
 VFIO new mdev API
Message-ID: <20220209072805.GA9050@lst.de>
References: <20220208111151.13115-1-zhi.a.wang@intel.com> <871r0dqtjf.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871r0dqtjf.fsf@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 05:15:00PM +0200, Jani Nikula wrote:
> >  #ifdef CONFIG_DRM_I915_GVT
> > +
> > +#define D_BDW   (1 << 0)
> > +#define D_SKL	(1 << 1)
> > +#define D_KBL	(1 << 2)
> > +#define D_BXT	(1 << 3)
> > +#define D_CFL	(1 << 4)
> > +
> > +#define D_GEN9PLUS	(D_SKL | D_KBL | D_BXT | D_CFL)
> > +#define D_GEN8PLUS	(D_BDW | D_SKL | D_KBL | D_BXT | D_CFL)
> > +
> > +#define D_SKL_PLUS	(D_SKL | D_KBL | D_BXT | D_CFL)
> > +#define D_BDW_PLUS	(D_BDW | D_SKL | D_KBL | D_BXT | D_CFL)
> > +
> > +#define D_PRE_SKL	(D_BDW)
> > +#define D_ALL		(D_BDW | D_SKL | D_KBL | D_BXT | D_CFL)
> 
> If these really need to be in a header in i915/, I think they need to be
> longer with some namespacing or something. I do wish these could be
> hidden though.

I think we could actually kill them off entirely.  They are used as
arguments to the macros that setup the mmio table.

Thefunctions to build these tabls are already organized by families,
so we'd need relatively few conditions to just build them the right
way.  There also are some runtime checks in the callbacks, but they
seem entirely superflous as far as I can tell.

Only the cmd parser is a bit messy.  So maybe we could keep these
constants just for the cmd parser inside of gvt for now (and clean
that up later) and remove them entirely from the mmio table.
