Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B53657DF5A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234922AbiGVJ5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 05:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234839AbiGVJ53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 05:57:29 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E0B3FA33
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 02:57:28 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A3C6C68AFE; Fri, 22 Jul 2022 11:57:24 +0200 (CEST)
Date:   Fri, 22 Jul 2022 11:57:24 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robert Beckett <bob.beckett@collabora.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, kernel@collabora.com,
        Christoph Hellwig <hch@lst.de>,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915: stop using swiotlb
Message-ID: <20220722095724.GA14113@lst.de>
References: <20220721174307.1085741-1-bob.beckett@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721174307.1085741-1-bob.beckett@collabora.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 06:43:07PM +0100, Robert Beckett wrote:
> +	max_segment = dma_max_mapping_size(i915->drm.dev);
> +	max_segment = max_t(size_t, max_segment, PAGE_SIZE) >> PAGE_SHIFT;

dma_max_mapping_size is always larger than PAGE_SIZE, so I don't think
the max is needed.

Otherwise this loks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
