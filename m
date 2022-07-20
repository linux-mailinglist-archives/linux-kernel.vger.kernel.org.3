Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E2457BF90
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 23:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiGTVaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 17:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiGTVaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 17:30:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844F7599E5;
        Wed, 20 Jul 2022 14:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=TdqfPLZDQqoiJgcJ8XR8R3y1mXk+yPYhV3rFEr0vWdM=; b=EyyBW+GhbfCjbZGYNdYdMxe8Bv
        Cal32LM+2FxIqx8X4DVss81RIwwhRntKO+e0TUd/4ZIMszdyoDt6tSjrFMiaJbo5sQBrEFV+fywE1
        vQ4w7nx1rwbz5aboLityf7hx6YnJKYig79eNMx64FV7TJHcTjKVKnec63+1sm4u9zFC7b7y+GrFWz
        jZ82iNN77Ntt0X964bEa9fAn/PzQmxbd1CHe8oDKSb/SRl058hsSSpb42a5vOEw3m1OXUrD5nBjIJ
        W0qkFBuxtTYunmRoeWug9mkOodKEhhk2iUxyDApJ0YLbJEDsBGTxG2oTw5/gjzXqtjt2AjUSURIGS
        fOO3xLjQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEHGH-00BSfp-6C; Wed, 20 Jul 2022 21:29:41 +0000
Date:   Wed, 20 Jul 2022 14:29:41 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, Song Liu <song@kernel.org>,
        Takashi Iwai <tiwai@suse.de>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Matthew Wilcox <willy@traff-1.hugedomains.com>
Subject: Re: [PATCH v2] module: Replace kmap() with kmap_local_page()
Message-ID: <YthzxUOgyPKgiyPY@bombadil.infradead.org>
References: <20220720161932.9567-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220720161932.9567-1-fmdefrancesco@gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 06:19:32PM +0200, Fabio M. De Francesco wrote:
> kmap() is being deprecated in favor of kmap_local_page().
> 
> Two main problems with kmap(): (1) It comes with an overhead as mapping
> space is restricted and protected by a global lock for synchronization and
> (2) it also requires global TLB invalidation when the kmap’s pool wraps
> and it might block when the mapping space is fully utilized until a slot
> becomes available.
> 
> With kmap_local_page() the mappings are per thread, CPU local, can take
> page faults, and can be called from any context (including interrupts).
> Tasks can be preempted and, when scheduled to run again, the kernel
> virtual addresses are restored and still valid.
> 
> kmap_local_page() is faster than kmap() in kernels with HIGHMEM enabled.
> 
> Since the use of kmap_local_page() in module_gzip_decompress() and in
> module_xz_decompress() is safe (i.e., it does not break the strict rules
> of use), it should be preferred over kmap().
> 
> Therefore, replace kmap() with kmap_local_page().
> 
> Tested on a QEMU/KVM x86_32 VM with 4GB RAM, booting kernels with
> HIGHMEM64GB enabled. Modules compressed with XZ or GZIP decompress
> properly.
> 
> Cc: Matthew Wilcox <willy@infradead.com>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Thanks for the enhanced commit log! Queued onto modules-testing, if that
doesn't blow something up I'll move to modules-next afterwards.

  Luis
