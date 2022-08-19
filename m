Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127A9599A3B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 13:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348460AbiHSLAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 07:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348493AbiHSLAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 07:00:33 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D01EF02D;
        Fri, 19 Aug 2022 04:00:32 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oOzjd-00CpaF-0I; Fri, 19 Aug 2022 21:00:18 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 19 Aug 2022 19:00:16 +0800
Date:   Fri, 19 Aug 2022 19:00:16 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ye Weihua <yeweihua4@huawei.com>
Cc:     wangzhou1@hisilicon.com, shenyang39@huawei.com,
        davem@davemloft.net, tanshukun1@huawei.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drivers: hisilicon: fix mismatch in get/set sgl_sge_nr
Message-ID: <Yv9tQP6HS9Qps2qY@gondor.apana.org.au>
References: <20220728020758.255383-1-yeweihua4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728020758.255383-1-yeweihua4@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 10:07:58AM +0800, Ye Weihua wrote:
> KASAN reported this Bug:
> 
> 	[17619.659757] BUG: KASAN: global-out-of-bounds in param_get_int+0x34/0x60
> 	[17619.673193] Read of size 4 at addr fffff01332d7ed00 by task read_all/1507958
> 	...
> 	[17619.698934] The buggy address belongs to the variable:
> 	[17619.708371]  sgl_sge_nr+0x0/0xffffffffffffa300 [hisi_zip]
> 
> There is a mismatch in hisi_zip when get/set the variable sgl_sge_nr.
> The type of sgl_sge_nr is u16, and get/set sgl_sge_nr by
> param_get/set_int.
> 
> Replacing param_get/set_int to param_get/set_ushort can fix this bug.
> 
> Fixes: f081fda293ffb ("crypto: hisilicon - add sgl_sge_nr module param for zip")
> Signed-off-by: Ye Weihua <yeweihua4@huawei.com>
> ---
>  drivers/crypto/hisilicon/zip/zip_crypto.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
