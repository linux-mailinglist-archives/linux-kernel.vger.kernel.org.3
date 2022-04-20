Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4CA50926C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 23:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382714AbiDTWAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 18:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236516AbiDTWAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 18:00:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9F43D489
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 14:57:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EBED5B821B0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 21:57:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 665F3C385A0;
        Wed, 20 Apr 2022 21:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1650491860;
        bh=vmNtN9e9H1hSyHfV0BVf2/UBMQJeK+7vsMOQz3vywEM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QGuPO28joxCzaeenSatWUy6HeYYIZDwI2mgdBaQKHG1cES9xrTr1CYefq2EuB2xWr
         8lRPDj+HJCpxZlLF1AO9J79kC+CcwvHHrjcusBjdk9JLoLh3yapcIU47NEjw3EOOIH
         2Yw8VyfI8aaRT01Vp/Sx/fNLypSYGTT1MN0bGRns=
Date:   Wed, 20 Apr 2022 14:57:39 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     lipeifeng@oppo.com
Cc:     peifeng55@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, 21cnbao@gmail.com,
        zhangshiming@oppo.com
Subject: Re: [PATCH] mm: modify the method to search addr in unmapped_area
Message-Id: <20220420145739.425c01603a6f63e550e556ed@linux-foundation.org>
In-Reply-To: <20220420084039.1431-1-lipeifeng@oppo.com>
References: <20220420084039.1431-1-lipeifeng@oppo.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Apr 2022 16:40:39 +0800 lipeifeng@oppo.com wrote:

> The old method will firstly find the space in len(info->length
> + info->align_mask), and get address at the desired alignment.
> 
> Sometime, addr  would be failed if there are enough
> addr space in kernel by above method, e.g., you can't get a
> addr sized in 1Mbytes, align_mask 1Mbytes successfully although
> there are still (2M-1)bytes space in kernel.
> 
> This patch would fix thr problem above by the new method: find the
> space in info->length and judge if at the desired info->align_mask
> at the same time.
> 
> Do a simple test in TIF_32BIT with unmapped_area:
> - Try to take addr (size:1M align:2M) until allocation fails;
> - Try to take addr (size:1M align:1M) and account how to space can
> be alloced successfully.
> 
> Before optimization: alloced 0     bytes.
> After  optimization: alloced 1.9+G bytes.

Thanks.

Unfortunately this part of the code is undergoing a lot of change
lately.  How serious is this problem?  Please tell us how often the
problem is being observed, under what circumstances, etc.

