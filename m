Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70B15AAC58
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 12:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235677AbiIBKZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 06:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235795AbiIBKZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 06:25:52 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A785926E;
        Fri,  2 Sep 2022 03:25:50 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oU3rt-000Kmt-Km; Fri, 02 Sep 2022 20:25:46 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 02 Sep 2022 18:25:45 +0800
Date:   Fri, 2 Sep 2022 18:25:45 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     cuigaosheng <cuigaosheng1@huawei.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 1/2] crypto: api - Fix IS_ERR() vs NULL check
Message-ID: <YxHaKSOedCC9DLX1@gondor.apana.org.au>
References: <20220825084138.1881954-1-cuigaosheng1@huawei.com>
 <20220825084138.1881954-2-cuigaosheng1@huawei.com>
 <Ywc3u9ObRCpxQsK0@gondor.apana.org.au>
 <0ae57826-6a8c-b08b-2889-f91d50bf6e59@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ae57826-6a8c-b08b-2889-f91d50bf6e59@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 09:10:49PM +0800, cuigaosheng wrote:
> Thanks for taking the time to review this patch.
> 
> crypto_alloc_test_larval() will return null if manager is disabled,
> it will not return error pointers, IS_ERR should not be used to checking
> return value, should we fix it? or use another solution?

That's because NULL is returned indicating success.  When a genuine
error occurs then an error pointer will be returned.  IS_ERR will be
true only in case of a genuine error.  It will be false when either
NULL or a real larval pointer is returned.

You need to describe your problem more clearly as I have no idea what
you're trying to fix.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
