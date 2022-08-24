Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F7059FB76
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237753AbiHXNfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237449AbiHXNfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:35:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554EE1EC52
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 06:35:00 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B9CC022682;
        Wed, 24 Aug 2022 13:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1661348098; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cHzlnZidDyBhZ9au5VIeVEnIK4LNM13JTXYOfl1103s=;
        b=reifUiNBAiNnltI7FdGX+1IYGjWQOJ4KWf2m0G0+bTUxiLDd8gGVbXVQTaLYc0fczJ6FhH
        cfKV2AbQcp2pDjam6Aa5dhn0R8AlBcPPVM5TzKetKFb+TUB96Si9vxfBC89OC69x03VLwi
        uXihrwAUmT5XB1jxijKKvjijzeyDSR8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1661348098;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cHzlnZidDyBhZ9au5VIeVEnIK4LNM13JTXYOfl1103s=;
        b=H3PVQyjVovuIs55Sjs+kO0ob15CCXgr/NsazWjNvgHwBLslJOTk0Hbn8gAE14hN6L6ySYB
        s6KDQ749KzBe/PAg==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4A56A2C141;
        Wed, 24 Aug 2022 13:34:58 +0000 (UTC)
Date:   Wed, 24 Aug 2022 14:34:51 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] mm: reduce noise in show_mem for lowmem allocations
Message-ID: <20220824133451.6kqttzm5t4iigz2i@suse.de>
References: <YwScVmVofIZkopkF@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <YwScVmVofIZkopkF@dhcp22.suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 11:22:30AM +0200, Michal Hocko wrote:
> Hi,
> while discussing early DMA pool pre-allocation failure with Christoph
> [1] I have realized that the allocation failure warning is rather noisy
> for constrained allocations like GFP_DMA{32}. Those zones are usually
> not populated on all nodes very often as their memory ranges are
> constrained.
> 
> This is an attempt to reduce the ballast that doesn't provide any
> relevant information for those allocation failures investigation.
> Please note that I have only compile tested it (in my default config
> setup) and I am throwing it mostly to see what people think about it.
> 
> [1] http://lkml.kernel.org/r/20220817060647.1032426-1-hch@lst.de

No objections.

-- 
Mel Gorman
SUSE Labs
