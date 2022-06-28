Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D3355D6BC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343588AbiF1Gzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 02:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiF1Gzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 02:55:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B7E22BCE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 23:55:37 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 271F46601856;
        Tue, 28 Jun 2022 07:55:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656399336;
        bh=CQRz8B+bkCZiBSEzDEK0Y9ZfKFUVGt+3EPrz6C/F4nY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O+RMMaj3oBnqHjdgpSOaqa6f+tPOSOEwu1KRsgBClppDzGAMEKwdrouboQx1xoaHj
         Qt+dZ4yKEZJuqujtaMAVddWovXt20NWHKAJk4g6wgUKdk0GGQqIN4EKsHbsn7uta/r
         vAgkHTcgjTso4dwIzGHXoC32yWxpoz/MdOj40AkpVK02QSQU+uEcgq98mEviu9pxEB
         e5MJWzaTT0AghPFLD1KGjSold/SE/VkhEkiqPn+zB3S6HZSDTNSZhNjQAro6lZUZpM
         wdvT+GFW980Thc3wInmUjDug9aPLc1alUgWp+QabbGjpZlvOi17SI8wWq2OmabedMG
         97P8/KZ0wvB2w==
Date:   Tue, 28 Jun 2022 08:55:33 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Yu Liao <liaoyu15@huawei.com>
Cc:     <emma@anholt.net>, <mripard@kernel.org>, <eric@anholt.net>,
        <bbrezillon@kernel.org>, <liwei391@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/vc4: fix dereference before NULL check
Message-ID: <20220628085533.7b7885fb@collabora.com>
In-Reply-To: <20220628063657.3169049-1-liaoyu15@huawei.com>
References: <20220628063657.3169049-1-liaoyu15@huawei.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jun 2022 14:36:57 +0800
Yu Liao <liaoyu15@huawei.com> wrote:

> The "perfmon" pointer is equal to the return value of idr_find
> which may be NULL, access by vc4_perfmon_get before checking if
> it was NULL. Fix this by dereferencing "perfmon" after "perfmon"
> has been null checked.
> 
> Addresses-Coverity: ("Dereference before null check")
> Fixes: 65101d8c9108 ("drm/vc4: Expose performance counters to userspace")
> Signed-off-by: Yu Liao <liaoyu15@huawei.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/vc4/vc4_perfmon.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_perfmon.c b/drivers/gpu/drm/vc4/vc4_perfmon.c
> index c7f5adb6bcf8..ca969b8c7dde 100644
> --- a/drivers/gpu/drm/vc4/vc4_perfmon.c
> +++ b/drivers/gpu/drm/vc4/vc4_perfmon.c
> @@ -17,13 +17,17 @@
>  
>  void vc4_perfmon_get(struct vc4_perfmon *perfmon)
>  {
> -	struct vc4_dev *vc4 = perfmon->dev;
> +	struct vc4_dev *vc4;
> +
> +	if (!perfmon)
> +		return;
> +
> +	vc4 = perfmon->dev;
>  
>  	if (WARN_ON_ONCE(vc4->is_vc5))
>  		return;
>  
> -	if (perfmon)
> -		refcount_inc(&perfmon->refcnt);
> +	refcount_inc(&perfmon->refcnt);
>  }
>  
>  void vc4_perfmon_put(struct vc4_perfmon *perfmon)

