Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D904A92A3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 04:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356759AbiBDDOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 22:14:49 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:50610 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356754AbiBDDOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 22:14:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5425561A71
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 03:14:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8342C340E8;
        Fri,  4 Feb 2022 03:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643944487;
        bh=iEuUG3yFFN2BJhIISW8KmMv88Mk0Nz7kMwG+L/vQIMs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NAR3D0EbcYDgb0VJ2NvMi/LN4scHsbUGO3g7sb2f81Jvm0jUIwdzc7morj9B1nVH9
         9fEebkxOyS0uWNkQYD5+fvKpng7Yy2mn+j8AM7nQmx7vbbny4aXekp9Kb5AZePIiTV
         TnsaFqWaLQUu8DUJoXBHzO9mYJTe1MvvvKiolnyxMb/XfVCO2E7i6dw9is/ocC9h8D
         FENRZpfAmjFdShyuXaUrzsFaPC88iBbQUrlyV4GdXF9DmpgkuZrCO0vJAYcQCuZ8EN
         2RcfPOYuHnH+phVibunKCh4AM/oRK9hCOaK+vBPYGgZN9IMwHuoT/PLzhxhI1cu8N3
         PZIUIDKV9hTxg==
Message-ID: <e556fddf-c103-c658-51d2-32ee44041d6d@kernel.org>
Date:   Fri, 4 Feb 2022 11:14:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] erofs: fix small compressed files inlining
Content-Language: en-US
To:     Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
References: <20220203190203.30794-1-xiang@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220203190203.30794-1-xiang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/2/4 3:02, Gao Xiang wrote:
> From: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Prior to ztailpacking feature, it's enough that each lcluster has
> two pclusters at most, and the last pcluster should be turned into
> an uncompressed pcluster if necessary. For example,
>    _________________________________________________
>   |_ pcluster n-2 _|_ pcluster n-1 _|____ EOFed ____|
> 
> which should be converted into:
>    _________________________________________________
>   |_ pcluster n-2 _|_ pcluster n-1 (uncompressed)' _|
> 
> That is fine since either pcluster n-1 or (uncompressed)' takes one
> physical block.
> 
> However, after ztailpacking supported, the game is changed since the
> last pcluster can be inlined now. And such case above is quite common
> for inlining small files. Therefore, in order to inline such files
> more effectively, special EOF lclusters are now supported which can
> have three parts at most, as illustrated below:
>    _________________________________________________
>   |_ pcluster n-2 _|_ pcluster n-1 _|____ EOFed ____|
>                                     ^ i_size
> 
> Actually similar code exists in Yue Hu's original patchset [1], but I
> removed this part on purpose. After evaluating more real cases with
> small files, I've changed my mind.
> 
> [1] https://lore.kernel.org/r/20211215094449.15162-1-huyue2@yulong.com
> Fixes: ab92184ff8f1 ("erofs: add on-disk compressed tail-packing inline support")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
