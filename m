Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0A44AEB37
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 08:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238518AbiBIHgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 02:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238416AbiBIHgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 02:36:49 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D75AC05CBA0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 23:36:48 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 96FD468AFE; Wed,  9 Feb 2022 08:36:44 +0100 (CET)
Date:   Wed, 9 Feb 2022 08:36:44 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Zhi Wang <zhi.wang.linux@gmail.com>
Cc:     hch@lst.de, jgg@nvidia.com, jani.nikula@linux.intel.com,
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
Message-ID: <20220209073644.GD9050@lst.de>
References: <20220208111151.13115-1-zhi.a.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208111151.13115-1-zhi.a.wang@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A cover letter with the changelog, the base and maybe a pointer to a git
tree would be nice.

> +static int handle_mmio_cb(struct intel_gvt_mmio_table_iter *iter, u32 offset,
> +			  u32 device, u32 size)
> +{
> +	if (size < 1024 || offset == i915_mmio_reg_offset(GEN9_GFX_MOCS(0)))
> +		return handle_mmio(iter, offset, device, size);
> +	else
> +		return handle_mmio_block(iter, offset, device, size);
> +}

No need for an else statement after a return statement.

> +/* XXX FIXME i915 has changed PP_XXX definition */

Btw, can someone explain this comment?  I has always puzzled me.
