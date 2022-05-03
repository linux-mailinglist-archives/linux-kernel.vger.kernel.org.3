Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11073518C24
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 20:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241228AbiECSYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 14:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241293AbiECSX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 14:23:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDCD62C3
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 11:20:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B126161299
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD95C385A9;
        Tue,  3 May 2022 18:20:21 +0000 (UTC)
Date:   Tue, 3 May 2022 19:20:18 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     will@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, vijayb@linux.microsoft.com,
        f.fainelli@gmail.com
Subject: Re: [PATCH v3 0/3] arm64: mm: Do not defer reserve_crashkernel()
Message-ID: <YnFyYm93IVNlCQ4c@arm.com>
References: <20220411092455.1461-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411092455.1461-1-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 05:24:52PM +0800, Kefeng Wang wrote:
> Commit 031495635b46 ("arm64: Do not defer reserve_crashkernel() for
> platforms with no DMA memory zones"), this lets the kernel benifit
> due to BLOCK_MAPPINGS, we could do more if ZONE_DMA and ZONE_DMA32
> enabled.
> 
> 1) Don't defer reserve_crashkernel() if only ZONE_DMA32
> 2) Don't defer reserve_crashkernel() if ZONE_DMA with dma_force_32bit
>    kernel parameter(newly added)

I'm not really keen on a new kernel parameter for this. But even with
such parameter, there is another series that allows crashkernel
reservations above ZONE_DMA32, so that would also need
NO_BLOCK_MAPPINGS, at least initially. I think there was a proposal to
do the high reservation first and only defer the low one in ZONE_DMA but
suggested we get the reservations sorted first and look at optimisations
later.

If hardware is so bad with page mappings, I think we need to look at
different ways to enable the block mappings, e.g. some safe break
before make change of the mappings or maybe switching to another TTBR1
during boot.

Does FEAT_BBM level 2 allow us to change the block size without a break
before make? I think that can still trigger a TLB conflict abort, maybe
we can trap it and invalidate the TLBs (the conflict should be on the
linear map not where the kernel image is mapped).

-- 
Catalin
