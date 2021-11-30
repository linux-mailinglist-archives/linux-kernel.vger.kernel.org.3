Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBD28463C36
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244513AbhK3Quv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:50:51 -0500
Received: from verein.lst.de ([213.95.11.211]:59748 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229658AbhK3Qtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:49:46 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1EC9D68B05; Tue, 30 Nov 2021 17:46:23 +0100 (CET)
Date:   Tue, 30 Nov 2021 17:46:22 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Zhi Wang <zhi.wang.linux@gmail.com>
Cc:     intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Vivi Rodrigo <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Terrence Xu <terrence.xu@intel.com>
Subject: Re: [PATCH v4 1/2] i915/gvt: Introduce the mmio_info_table.c to
 support VFIO new mdev API
Message-ID: <20211130164622.GA15150@lst.de>
References: <20211129123832.105196-1-zhi.a.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129123832.105196-1-zhi.a.wang@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I still think this goes into the wrong direction.

Something closer to your first version that also saves away the
gvt->mmio.mmio_attribute flags in the core i915 module, and which
splits the MMIO table into one that contains just the offset, size
and flags (core i915) and one that has the read-only mask and handlers
(gvt) would be much simpler and not create this super-tight coupling
between core i915 and gvt.

Bonus points for moving your new intel_gvt_hw_state structure out
of struct intel_gvt and into struct i915_virtual_gpu.
