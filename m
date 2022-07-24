Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1505D57F4AE
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 12:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbiGXKZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 06:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiGXKZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 06:25:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B1CE40
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 03:25:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5AA461028
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 10:25:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76CFFC3411E;
        Sun, 24 Jul 2022 10:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658658345;
        bh=llr3NpuOtsHJafurgE+1bQ5Ai0owsCdalYBPSeJB2ok=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nhwUVI+T0cKTEoyz/KO7x19M282NEi+oeGqWBgdbZMW5Sjwf7TgvBpMgdgk/9HCki
         /ZipPK4EMgLx8/SgMgiyKnhwNixw4I3jfzTVdSwGRQSB+JdAy5NrDUmcGMHi8L5BXa
         Tzny134OVZRyabb1SN1ov6mxmjvlcD73jStFSZwKrd2Q58txFveoJ+mwuDDJqqEO24
         WSOxyWIM1gs0PquPB2H7pmHb6dAfweVhON9a/z5Y/MgAAkOzuwWPDjOsduxQ6qzIW4
         q013bsNztDTFV7P3VFKPuOFslIJ36UXEmbTMaepLGo7UHXUqghI/zMInDxOJxZlinj
         EoJIFGPkXbbjA==
Message-ID: <daecf6fe-6e12-ea6f-5463-747fdd0dd52e@kernel.org>
Date:   Sun, 24 Jul 2022 18:25:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] f2fs: Delete f2fs_copy_page() and replace with
 memcpy_page()
Content-Language: en-US
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>
References: <20220717083613.3861-1-fmdefrancesco@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220717083613.3861-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/17 16:36, Fabio M. De Francesco wrote:
> f2fs_copy_page() is a wrapper around two kmap() + one memcpy() from/to
> the mapped pages. It unnecessarily duplicates a kernel API and it makes
> use of kmap(), which is being deprecated in favor of kmap_local_page().
> 
> Two main problems with kmap(): (1) It comes with an overhead as mapping
> space is restricted and protected by a global lock for synchronization and
> (2) it also requires global TLB invalidation when the kmap’s pool wraps
> and it might block when the mapping space is fully utilized until a slot
> becomes available.
> 
> With kmap_local_page() the mappings are per thread, CPU local, can take
> page faults, and can be called from any context (including interrupts).
> It is faster than kmap() in kernels with HIGHMEM enabled. Therefore, its
> use in __clone_blkaddrs() is safe and should be preferred.
> 
> Delete f2fs_copy_page() and use a plain memcpy_page() in the only one
> site calling the removed function. memcpy_page() avoids open coding two
> kmap_local_page() + one memcpy() between the two kernel virtual addresses.
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
