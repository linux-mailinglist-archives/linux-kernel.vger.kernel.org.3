Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D476858DFD3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 21:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345559AbiHITHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 15:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348377AbiHITGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 15:06:48 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6684286E3
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 11:52:01 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id F0ABB68AA6; Tue,  9 Aug 2022 20:51:57 +0200 (CEST)
Date:   Tue, 9 Aug 2022 20:51:57 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     "Hellstrom, Thomas" <thomas.hellstrom@intel.com>
Cc:     "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        "bob.beckett@collabora.com" <bob.beckett@collabora.com>,
        "tvrtko.ursulin@linux.intel.com" <tvrtko.ursulin@linux.intel.com>,
        "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
        "airlied@linux.ie" <airlied@linux.ie>, "hch@lst.de" <hch@lst.de>,
        "Ursulin, Tvrtko" <tvrtko.ursulin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "Auld, Matthew" <matthew.auld@intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v5] drm/i915: stop using swiotlb
Message-ID: <20220809185157.GA15307@lst.de>
References: <20220726153935.2272777-1-bob.beckett@collabora.com> <1160a7c31084ab2259088e4bfe88b41ad61c2bcc.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160a7c31084ab2259088e4bfe88b41ad61c2bcc.camel@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2022 at 03:48:02PM +0000, Hellstrom, Thomas wrote:
> This whole thing looks a bit strange to me since with SWIOTLB actually
> used for i915, the driver should malfunction anyway as it doesn't do
> any dma_sync_sg_for_cpu() or dma_sync_sg_for_device(),

Yeah, I can't actually see any syncs in i915.

> and the driver
> assumes all coherent dma. Is that SWIOTLB=force kernel option still
> available?

Yes, although it is (and always has been) lower case swiotlb for the
option.

> Also, correct me if I'm wrong, but the original driver segment size
> appears to mean "the largest contiguous area that can be handled either
> by the device or the dma mapping layer" rather than the total space
> available for dma mappings? Not completely sure what
> dma_max_mapping_size() is returning, though?

dma_max_mapping_size is sort of both.  It is is the largest contigous
size, but we really should not go above that to avoid starvation.
