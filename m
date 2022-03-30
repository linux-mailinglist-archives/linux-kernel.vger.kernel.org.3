Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774864EBCF2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 10:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244469AbiC3IvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 04:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237381AbiC3IvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 04:51:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298F63FBE4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 01:49:20 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6674A1F38C;
        Wed, 30 Mar 2022 08:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648630159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y+X7q1ZE3PyNwxyuP4aBqfMfnWOO3NvGABxZ8kqlIrk=;
        b=I1JuV3XBHMvLo1oTr1L2XPs8CnYBt4sWEm6auUlEjPVZfQVCFXk+/Kru9PltJ9ZtG5cwEG
        l9JCOC+wArnSyi4+/+6i43Fihu5c9d88BUIKZ7apjqqRfnqQ8RF8aeMIJ9nyguyaCcJG7t
        bK9xtGyHpsN7iIpAO9fNGGsdKA5uKlw=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EEC7EA3B92;
        Wed, 30 Mar 2022 08:49:17 +0000 (UTC)
Date:   Wed, 30 Mar 2022 10:49:15 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     minchan@kernel.org, ngupta@vflare.org, senozhatsky@chromium.org,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, s.suk@samsung.com,
        jaewon31.kim@gmail.com
Subject: Re: [PATCH] zram_drv: add __GFP_NOWARN flag on call to zs_malloc
Message-ID: <YkQZi5WFAwbqWKNZ@dhcp22.suse.cz>
References: <CGME20220330052214epcas1p250cff6b3168a1c9c253e1fe70e68ca8b@epcas1p2.samsung.com>
 <20220330052502.26072-1-jaewon31.kim@samsung.com>
 <YkQPefdRc+hxIXEV@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkQPefdRc+hxIXEV@dhcp22.suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 30-03-22 10:06:18, Michal Hocko wrote:
> On Wed 30-03-22 14:25:02, Jaewon Kim wrote:
> > The page allocation with GFP_NOIO may fail. And zram can handle this
> > allocation failure. We do not need to print log for this.
> 
> GFP_NOIO doesn't have any special meaning wrt to failures. zram
> allocates from the memory reclaim context which is a bad design IMHO.

Btw. I forgot to mention that GFP_NOIO doesn't have any different
meaning than GFP_KERNEL from this (PF_MEMALLOC) allocation context
because this request will never perform a reclaim.
-- 
Michal Hocko
SUSE Labs
