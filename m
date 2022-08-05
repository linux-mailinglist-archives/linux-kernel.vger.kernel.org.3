Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A197758B009
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 20:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241239AbiHESun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 14:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240985AbiHESui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 14:50:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6391CB28
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 11:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N40CH4N73F1aD5pR/zImIWWFoHIInIlo6IUf8Y19MV0=; b=N6rJq8jMhgWcZ3MLB16mRqHuVE
        wHqstFKdhqAwhAarzMyJAF+t0mABjjawok3vFmh+pnewjj5k7atDabLw1ABjKta/ovvQtQvq5P6VP
        hxq70zWICpQEV2dSGHz1/tDKiRZNAHx6Dh4RQlVIe6/00LZ5NgagidUCpGiwUTRJCb/maR2eEUOlM
        XdWvV8yl9j6MIUGofJ8JRDAbvOZ18v1wMxoaqA5OGpxZkWorOhNBWC6fuuRSn/lUK/2dc9yAn3qhD
        kNnFw9KQIFPg3hwPAoWrGlgWVsAyFKQfr0srcQOiHHhxBLcbvKraQOBCBFIHn+bMQ9sJi4Dj37xVH
        xpA/fCrw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oK2Ou-00BUBv-EF; Fri, 05 Aug 2022 18:50:24 +0000
Date:   Fri, 5 Aug 2022 19:50:24 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     alexlzhu@fb.com
Cc:     linux-mm@kvack.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH v3] mm: add thp_utilization metrics to
 /proc/thp_utilization
Message-ID: <Yu1mcD6Jp4fCVEMi@casper.infradead.org>
References: <20220805184016.2926168-1-alexlzhu@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805184016.2926168-1-alexlzhu@fb.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 11:40:16AM -0700, alexlzhu@fb.com wrote:
> THPs have historically been enabled on a per application basis due to
> performance increase or decrease depending on how the particular
> application uses physical memory. When THPs are heavily utilized,
> application performance improves due to fewer TLB cache misses.
> It has long been suspected that performance regressions when THP
> is enabled happens due to heavily underutilized anonymous THPs.
> 
> Previously there was no way to track how much of a THP is
> actually being used. With this change, we seek to gain visibility
> into the utilization of THPs in order to make more intelligent
> decisions regarding paging.
> 
> This change introduces a tool that scans through all of physical
> memory for anonymous THPs and groups them into buckets based
> on utilization. It also includes an interface under
> /proc/thp_utilization.

OK, so I understand why we want to do the scanning, but why do we want to
report it to userspace at all?  And if we do, why do we want to do it in
this format?  AFAIK, there's nothing userspace can do with the information
"93% of your THPs are underutilised".  If there was something userspace
could do about it, wouldn't it need to know which ones?

Isn't the real solution here entirely in-kernel?  This scanning thread
you've created should be the one splitting the THPs.  And anyway, isn't
this exactly the kind of thing that DAMON was invented for?
