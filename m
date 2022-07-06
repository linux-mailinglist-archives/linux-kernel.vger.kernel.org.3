Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AB75687F1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 14:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbiGFMLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 08:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbiGFMLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 08:11:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFE429CBA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 05:11:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A4A961F74
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 12:11:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3170CC3411C;
        Wed,  6 Jul 2022 12:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657109467;
        bh=2CdrEErWvvgDIbUAWRkAn9JrX8b38GrwM68HdHXvssc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e2hOt58qeJS6fCVticXw4yTeuBWlWu3CG/wLEvQpxwYWciMwrI+LbKIJOFBwcx/3N
         1zDF8dkkBsL36piFRDcqZ9s2OGoEnF7n5AzzOrwO6f2CstMObJlJ2YB6kkvRIEFvYW
         MmXyN0iZ1p18q+GY8lDVpwXFX3VwnYeRYpyGr4m011ppQUF/JyTLcaV4vb+y9MjrKT
         Kb2gZr2RD8wRj/WqCZH4ExnlSuX+B+rBUKGNpTdnReiypBJJloiHYkXhsk/RPCvoyp
         QVWRnwk3Fdfv8nq2ihMCoR8+0+DEXz8ZWtxXPlIiH1HdMk3u9+aHeizJ6BQ1bPGtL+
         azJTkU8IJFXdw==
Date:   Wed, 6 Jul 2022 13:10:58 +0100
From:   Will Deacon <will@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     joro@8bytes.org, robin.murphy@arm.com, mst@redhat.com,
        jasowang@redhat.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        chenxiang66@hisilicon.com, thunder.leizhen@huawei.com,
        jean-philippe@linaro.org, linuxarm@huawei.com
Subject: Re: [PATCH RESEND v5 2/5] iova: Allow rcache range upper limit to be
 flexible
Message-ID: <20220706121057.GF2403@willie-the-truck>
References: <1649071634-188535-1-git-send-email-john.garry@huawei.com>
 <1649071634-188535-3-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649071634-188535-3-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 07:27:11PM +0800, John Garry wrote:
> Some low-level drivers may request DMA mappings whose IOVA length exceeds
> that of the current rcache upper limit.
> 
> This means that allocations for those IOVAs will never be cached, and
> always must be allocated and freed from the RB tree per DMA mapping cycle.
> This has a significant effect on performance, more so since commit
> 4e89dce72521 ("iommu/iova: Retry from last rb tree node if iova search
> fails"), as discussed at [0].
> 
> As a first step towards allowing the rcache range upper limit be
> configured, hold this value in the IOVA rcache structure, and allocate
> the rcaches separately.
> 
> Delete macro IOVA_RANGE_CACHE_MAX_SIZE in case it's reused by mistake.
> 
> [0] https://lore.kernel.org/linux-iommu/20210129092120.1482-1-thunder.leizhen@huawei.com/
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/iommu/iova.c | 20 ++++++++++----------
>  include/linux/iova.h |  3 +++
>  2 files changed, 13 insertions(+), 10 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
