Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A048C567613
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 19:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbiGER6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 13:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbiGER6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 13:58:40 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC5616589;
        Tue,  5 Jul 2022 10:58:38 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7FD8E67373; Tue,  5 Jul 2022 19:58:34 +0200 (CEST)
Date:   Tue, 5 Jul 2022 19:58:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     LABBE Corentin <clabbe@baylibre.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        herbert@gondor.apana.org.au, heiko@sntech.de,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [RFC PATCH] crypto: flush poison data
Message-ID: <20220705175834.GA15815@lst.de>
References: <20220701132735.1594822-1-clabbe@baylibre.com> <4570f6d8-251f-2cdb-1ea6-c3a8d6bb9fcf@codethink.co.uk> <YsP0eekTthD4jWGV@Red> <20220705164213.GA14484@lst.de> <YsR7O4q4IRI14Wkc@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsR7O4q4IRI14Wkc@Red>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 07:56:11PM +0200, LABBE Corentin wrote:
> My problem is that a dma_sync on the data buffer corrupt the poison buffer as collateral dommage.
> Probably because the sync operate on a larger region than the requested dma_sync length.
> So I try to flush poison data in the cryptoAPI.

Data structures that are DMAed to must be aligned to
the value returned by dma_get_cache_alignment(), as non-coherent DMA
by definition can disturb the data inside that boundary.  That is not
a bug but fundamentally part of how DMA works when the device attachment
is not cache coherent.
