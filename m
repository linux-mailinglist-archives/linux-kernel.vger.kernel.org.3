Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8085947865E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 09:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbhLQIj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 03:39:58 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:58082 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233933AbhLQIj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 03:39:57 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1my8mR-00014y-0O; Fri, 17 Dec 2021 19:39:56 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 17 Dec 2021 19:39:54 +1100
Date:   Fri, 17 Dec 2021 19:39:54 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Yang Shen <shenyang39@huawei.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, wangzhou1@hisilicon.com,
        liulongfang@huawei.com
Subject: Re: [PATCH] crypto: hisilicon/qm - fix deadlock for remove driver
Message-ID: <20211217083954.GH7018@gondor.apana.org.au>
References: <20211211085655.30294-1-shenyang39@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211211085655.30294-1-shenyang39@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 11, 2021 at 04:56:55PM +0800, Yang Shen wrote:
> When remove the driver and executing the task occur at the same time,
> the following deadlock will be triggered:
> 
> Chain exists of:
>     sva_lock --> uacce_mutex --> &qm->qps_lock
>     Possible unsafe locking scenario:
> 		CPU0                    CPU1
> 		----                    ----
> 	lock(&qm->qps_lock);
> 					lock(uacce_mutex);
> 					lock(&qm->qps_lock);
> 	lock(sva_lock);
> 
> And the lock 'qps_lock' is used to protect qp. Therefore, it's reasonable
> cycle is to continue until the qp memory is released. So move the release
> lock infront of 'uacce_remove'.
> 
> Signed-off-by: Yang Shen <shenyang39@huawei.com>
> ---
>  drivers/crypto/hisilicon/qm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
