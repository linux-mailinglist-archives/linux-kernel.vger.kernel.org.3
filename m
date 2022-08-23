Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A04A59E818
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245529AbiHWQ42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245668AbiHWQzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:55:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B040E13AE1D
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 06:25:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CCDD61527
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 13:25:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84CF6C433C1;
        Tue, 23 Aug 2022 13:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661261140;
        bh=/4xhD7ELNjBZtgpSSVaLsvo9d58ZYqtV6ReDGw96m5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D3MRIp0X5ItLOQUwiZtdhZ0TmB2kzlIWU3Kw/M0a9bICSUz4b5UJFQb0AFkU0Msbc
         2/jzI9dCTmVTL8M2tVkQ/Jr2EZ2FloyBnnuYVEffahexXdYyEkw4v74RY5xmZdIuPk
         4+ROMQHgrVVABkvkS6/oX7NTbYbPTur0KJa4TqdmfFgo+o0LrsMjrI1ZyCoeFVJhB+
         HLzbn0pU8+B64MQIOsX2gCN8ROURcpP9kLwsO875FlgnQ+73SAb9O9QYPQa8O9fuWM
         LypSYds//Lc99u3jTSHur4c6XLqnHAh5+xDwJQSV+bFon1kOGBTLJlRtKXo5HhFIQ/
         qfG/6ezFh0Vjg==
Date:   Tue, 23 Aug 2022 16:25:24 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Rebecca Mckeever <remckee0@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Shaoqin Huang <shaoqin.huang@intel.com>
Subject: Re: [PATCH v2 1/8] memblock tests: update tests to check if
 memblock_alloc zeroed memory
Message-ID: <YwTVRHXslU4aW52G@kernel.org>
References: <cover.1660897732.git.remckee0@gmail.com>
 <669782f4f508c3dd60c5efd6d130d12a77573448.1660897732.git.remckee0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <669782f4f508c3dd60c5efd6d130d12a77573448.1660897732.git.remckee0@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 01:34:49AM -0700, Rebecca Mckeever wrote:
> Add an assert in memblock_alloc() tests where allocation is expected to
> occur. The assert checks whether the entire chunk of allocated memory is
> cleared.
> 
> The current memblock_alloc() tests do not check whether the allocated
> memory was zeroed. memblock_alloc() should zero the allocated memory since
> it is a wrapper for memblock_alloc_try_nid().
> 
> Reviewed-by: Shaoqin Huang <shaoqin.huang@intel.com>
> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> ---
>  tools/testing/memblock/tests/alloc_api.c | 23 +++++++++++++++++++++++
>  tools/testing/memblock/tests/common.c    |  7 +++++++
>  tools/testing/memblock/tests/common.h    | 12 ++++++++++++
>  3 files changed, 42 insertions(+)
> 
> diff --git a/tools/testing/memblock/tests/alloc_api.c b/tools/testing/memblock/tests/alloc_api.c
> index a14f38eb8a89..aefb67557de9 100644
> --- a/tools/testing/memblock/tests/alloc_api.c
> +++ b/tools/testing/memblock/tests/alloc_api.c
> @@ -22,6 +22,8 @@ static int alloc_top_down_simple_check(void)
>  	allocated_ptr = memblock_alloc(size, SMP_CACHE_BYTES);
>  
>  	ASSERT_NE(allocated_ptr, NULL);
> +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
> +

Can we please hide the casting inside ASSERT_MEM_EQ()?

Like if ASSERT_MEM_EQ() were a function its declaration would be

bool ASSERT_MEM_EQ(void *mem, char val, size_t size);

>  	ASSERT_EQ(rgn->size, size);
>  	ASSERT_EQ(rgn->base, expected_start);
>  

-- 
Sincerely yours,
Mike.
