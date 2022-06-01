Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD1E539C74
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 07:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345510AbiFAFQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 01:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbiFAFQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 01:16:27 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE74B813D5;
        Tue, 31 May 2022 22:16:25 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 26A9368AFE; Wed,  1 Jun 2022 07:16:22 +0200 (CEST)
Date:   Wed, 1 Jun 2022 07:16:21 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Rob Clark <robdclark@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH] dma-debug: Make things less spammy under memory
 pressure
Message-ID: <20220601051621.GA21535@lst.de>
References: <20220531215106.192271-1-robdclark@gmail.com> <39d1fa65-8e82-721c-171e-ef36bda1c561@arm.com> <CAF6AEGuMN23hxe1+PES-F0rgXDnxi48OfbdHKasPGVnbFvQ8rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF6AEGuMN23hxe1+PES-F0rgXDnxi48OfbdHKasPGVnbFvQ8rw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 03:19:45PM -0700, Rob Clark wrote:
> um, quite..  tbf that was in the context of a WIP igt test for
> shrinker which was trying to cycle thru ~2x RAM size worth of GEM
> buffers on something like 72 threads.  So it could just be threads
> that had gotten past the dma_debug_disabled() check already before
> global_disable was set to true?
> 
> I guess this could be pr_err_once() instead, then?

Yes, we could use pr_err_once to reduce the chattyness while still
keeping global_disable to disable all the actual tracking.
