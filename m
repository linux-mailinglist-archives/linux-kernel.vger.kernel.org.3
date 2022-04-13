Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918374FFBA7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 18:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237024AbiDMQrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 12:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234436AbiDMQqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 12:46:47 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9896BF45
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 09:44:18 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8FC2568AFE; Wed, 13 Apr 2022 18:44:15 +0200 (CEST)
Date:   Wed, 13 Apr 2022 18:44:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chao Gao <chao.gao@intel.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        m.szyprowski@samsung.com,
        Wang Zhaoyang1 <zhaoyang1.wang@intel.com>,
        Gao Liang <liang.gao@intel.com>,
        Kevin Tian <kevin.tian@intel.com>
Subject: Re: [PATCH] dma-direct: avoid redundant memory sync for swiotlb
Message-ID: <20220413164415.GA31640@lst.de>
References: <20220412113805.3210-1-chao.gao@intel.com> <e25fbb7e-a67e-5421-b7be-700fd0209b0d@arm.com> <20220413010157.GA10502@gao-cwp> <20220413045958.GA31209@lst.de> <4a993382-6a29-a0f4-4600-90ab60ad982a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a993382-6a29-a0f4-4600-90ab60ad982a@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 02:10:56PM +0100, Robin Murphy wrote:
> Are you sure? AFAICS swiotlb_map() does the right thing, and 
> dma_direct_{sync,unmap} are working off the DMA address, which is that of 
> the bounce slot when SWIOTLB is involved (not least, how would the 
> is_swiotlb_buffer() checks work otherwise?)

Yeah, actually this should be fine.
