Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D528358DFDB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 21:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245693AbiHITIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 15:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243494AbiHITHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 15:07:18 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B82D2B254
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 11:54:07 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A225E68AA6; Tue,  9 Aug 2022 20:54:03 +0200 (CEST)
Date:   Tue, 9 Aug 2022 20:54:03 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     "Hellstrom, Thomas" <thomas.hellstrom@intel.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        "bob.beckett@collabora.com" <bob.beckett@collabora.com>,
        "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
        "airlied@linux.ie" <airlied@linux.ie>, "hch@lst.de" <hch@lst.de>,
        "Ursulin, Tvrtko" <tvrtko.ursulin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "Auld, Matthew" <matthew.auld@intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v5] drm/i915: stop using swiotlb
Message-ID: <20220809185403.GB15307@lst.de>
References: <20220726153935.2272777-1-bob.beckett@collabora.com> <1160a7c31084ab2259088e4bfe88b41ad61c2bcc.camel@intel.com> <db9f787e-c3e4-d353-da57-80cb7a135d86@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db9f787e-c3e4-d353-da57-80cb7a135d86@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2022 at 12:36:50PM +0100, Tvrtko Ursulin wrote:
>
> Digging through git history at least running as Xen dom0 looks to have been 
> impacted, but commits such as abb0deacb5a6 ("drm/i915: Fallback to single 
> PAGE_SIZE segments for DMA remapping") are older and suggest problem was 
> generic. 1625e7e549c5 ("drm/i915: make compact dma scatter lists creation 
> work with SWIOTLB backend.") as well. So it looks it did work behind 
> swiotlb despite those missing calls you highlighted.

Hmm.  xen-swiotlb bounce buffers as soon as any single mapping that
straddles a Xen page size boundary.  Could the magic value there
somehow made all mappings small enough to just avoid bounce buffering
for Xen by more or less accident?
