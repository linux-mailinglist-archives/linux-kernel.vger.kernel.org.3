Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1956957DF4F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbiGVJ7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 05:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234516AbiGVJ7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 05:59:03 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06FF3FA13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 02:59:02 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8F04568AFE; Fri, 22 Jul 2022 11:58:59 +0200 (CEST)
Date:   Fri, 22 Jul 2022 11:58:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Robert Beckett <bob.beckett@collabora.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, kernel@collabora.com,
        Christoph Hellwig <hch@lst.de>,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915: stop using swiotlb
Message-ID: <20220722095859.GB14113@lst.de>
References: <20220721174307.1085741-1-bob.beckett@collabora.com> <a0a7a734-d3dd-960e-f130-39f86b04b24d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0a7a734-d3dd-960e-f130-39f86b04b24d@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 10:45:54AM +0100, Tvrtko Ursulin wrote:
>> -	unsigned int size = swiotlb_max_segment();
>> -
>> -	if (size == 0)
>> -		size = UINT_MAX;
>
> On a more detailed look, there was a CI failure which makes me think this 
> cap might need to stay. Because max sg segment is unsigned int. So I wonder 
> if sg contstruction overflows without it.
>
> If this quick analysis is right, you could leave i915_sg_segment_size 
> helper and cap the return from dma_max_mapping_size to UINT_MAX in it.

As dma_max_mapping_size retuns a size_t it would be good to make
all variables using it a size_t as well.  In places where that gets
lower to an unsigned int your probably want this cap.
