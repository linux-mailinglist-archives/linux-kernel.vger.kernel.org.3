Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE6746714C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 06:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbhLCFJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 00:09:36 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:57376 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229548AbhLCFJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 00:09:34 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1mt0lq-00026a-Ax; Fri, 03 Dec 2021 16:06:07 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 03 Dec 2021 16:06:06 +1100
Date:   Fri, 3 Dec 2021 16:06:06 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Gaurav Jain <gaurav.jain@nxp.com>
Cc:     Horia Geanta <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        "David S . Miller" <davem@davemloft.net>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: [PATCH v2] crypto: caam: save caam memory to support crypto
 engine retry mechanism.
Message-ID: <20211203050606.GA20393@gondor.apana.org.au>
References: <20211122113234.851618-1-gaurav.jain@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211122113234.851618-1-gaurav.jain@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 05:02:34PM +0530, Gaurav Jain wrote:
> When caam queue is full (-ENOSPC), caam frees descriptor memory.
> crypto-engine checks if retry support is true and h/w queue
> is full(-ENOSPC), then requeue the crypto request.
> During processing the requested descriptor again, caam gives below error.
> (caam_jr 30902000.jr: 40000006: DECO: desc idx 0: Invalid KEY Command).
> 
> This patch adds a check to return when caam input ring is full
> and retry support is true. so descriptor memory is not freed
> and requeued request can be processed again.
> 
> Fixes: 2d653936eb2cf ("crypto: caam - enable crypto-engine retry mechanism")
> Signed-off-by: Gaurav Jain <gaurav.jain@nxp.com>
> Reviewed-by: Horia Geantă <horia.geanta@nxp.com>
> ---
>  drivers/crypto/caam/caamalg.c  | 6 ++++++
>  drivers/crypto/caam/caamhash.c | 3 +++
>  drivers/crypto/caam/caampkc.c  | 3 +++
>  3 files changed, 12 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
