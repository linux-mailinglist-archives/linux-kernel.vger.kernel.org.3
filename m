Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEAA45733CA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 12:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235000AbiGMKH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 06:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235507AbiGMKHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 06:07:44 -0400
X-Greylist: delayed 68035 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Jul 2022 03:07:41 PDT
Received: from gentwo.de (gentwo.de [161.97.139.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCC3EF23D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 03:07:41 -0700 (PDT)
Received: by gentwo.de (Postfix, from userid 1001)
        id CB054B00418; Wed, 13 Jul 2022 12:07:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.de; s=default;
        t=1657706859; bh=SeRKe3yf26MO72QyT8L5XOyRs4a5maEIynSyHOtqHmI=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=KfjqqhlJ+qL4z2DVAzkCyK3gUGScWGTsPAWcs3B+248mSEHsLroKOpBYT58vskshA
         HhDD8TPqp5LgUL7hh9w0lxfU6BdzJiaLFQuGF/Uk8dvqVPKr++46gU1OwJ8X6+9+8o
         3llasYq85WgGUZZaprYp0qBiYZ5Vt8Blt+AWJKK5Wuhd3AGRiEh2D2tOOGc6POyAFg
         JJPvvxUmvPWLo0Cp7ZFMTMvzzwdSsPrmtUW7HIQ/y+999X5Arba1dZZQlmHcDXmCEY
         oBbRbph2PYTXaaVhIZRjem5Jil5RUErOMQFc5CH0LOZkSlDgtQKYeiImI6nKf7HDtQ
         UbwnKwniLgl8g==
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id C88D1B00149;
        Wed, 13 Jul 2022 12:07:39 +0200 (CEST)
Date:   Wed, 13 Jul 2022 12:07:39 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
cc:     Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Joe Perches <joe@perches.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        Matthew WilCox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Marco Elver <elver@google.com>
Subject: Re: [PATCH 16/16] mm/sl[au]b: check if large object is valid in
 __ksize()
In-Reply-To: <Ys6Pp6ZPwJTdJvpk@ip-172-31-24-42.ap-northeast-1.compute.internal>
Message-ID: <alpine.DEB.2.22.394.2207131205590.112646@gentwo.de>
References: <20220712133946.307181-1-42.hyeyoo@gmail.com> <20220712133946.307181-17-42.hyeyoo@gmail.com> <alpine.DEB.2.22.394.2207121701070.57893@gentwo.de> <Ys6Pp6ZPwJTdJvpk@ip-172-31-24-42.ap-northeast-1.compute.internal>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jul 2022, Hyeonggon Yoo wrote:

> > Why return 0 if there is an error and why bother the callers with these
> > checks. BUG()?
>
> I thought BUG should be used when there is no other solution.

Spurios returns of 0 that the caller has to check for is a solution?

> > I guess this is an error since the order-0 page cannot come from slab
> > allocations.
>
> comment in ksize() says:
> 	"The caller must guarantee that objp points to a valid object
> 	previously allocated with either kmalloc() or kmem_cache_alloc()."
>
> It should not be used on order-0 page that is not allocated from slab. No?

I guess we would need to check. Code could exist that does this.

Getting a 0 size would be surprising too here. BUG()? Or WARN() and return
PAGE_SIZE.


