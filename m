Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC2B5790B3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 04:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236881AbiGSCQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 22:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236875AbiGSCQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 22:16:30 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2CF2528F;
        Mon, 18 Jul 2022 19:16:28 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oDcme-001wgN-8q; Tue, 19 Jul 2022 12:16:25 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 19 Jul 2022 10:16:24 +0800
Date:   Tue, 19 Jul 2022 10:16:24 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Zhengchao Shao <shaozhengchao@huawei.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        liulongfang@huawei.com, davem@davemloft.net, xuzaibo@huawei.com,
        weiyongjun1@huawei.com, yuehaibing@huawei.com
Subject: Re: [PATCH] crypto: hisilicon/hpre - don't use GFP_KERNEL to alloc
 mem during softirq
Message-ID: <YtYT+JeYj7vlz9Xp@gondor.apana.org.au>
References: <20220719021042.250882-1-shaozhengchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719021042.250882-1-shaozhengchao@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 10:10:42AM +0800, Zhengchao Shao wrote:
>
> @@ -252,7 +252,7 @@ static int hpre_prepare_dma_buf(struct hpre_asym_request *hpre_req,
>  	if (unlikely(shift < 0))
>  		return -EINVAL;
>  
> -	ptr = dma_alloc_coherent(dev, ctx->key_sz, tmp, GFP_KERNEL);
> +	ptr = dma_alloc_coherent(dev, ctx->key_sz, tmp, flags);

How about just using GFP_ATOMIC unconditinoally?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
