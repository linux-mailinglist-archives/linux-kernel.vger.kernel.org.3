Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE1650972C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 08:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384696AbiDUGNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbiDUGNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:13:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BAC13CD5;
        Wed, 20 Apr 2022 23:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=18xk0KT5B86gCiyEjqVUpD20TLPm7YxWiS57uAbCHcY=; b=zeJ+OM3dBqjlIlEfQ2ghD0PZm7
        kLxWTmdUZn3/hB2WTYhFVFFKzMVq/Z+XjALwi6wWZNAMOETDdH3HvbPN3VIer4Iz56Z247wQ/fJtJ
        Leqet9JRS0A5FjxbciRT6B8w8HoQWitihRJQSlq0WZ4mjCzGmxrCc2typkG/B2hyRRy3Rbru/e3Zp
        4Nvn+9wv4iRXLZZTjDCcB8rOiz4HY559iiiyQLTWrDYGfBRcy87mOi0rJJXrZ56+0HDcNw2LTA7oB
        nPuqXSbr9sPCx6WQk/nrsZsJAHTJ2hjm6XyZE4FyIaCd70GuwsYRHtvNNH5Ez4AkZdQZXzP443Nh2
        w70JBZ2A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhQ1F-00BdlH-Ia; Thu, 21 Apr 2022 06:10:21 +0000
Date:   Wed, 20 Apr 2022 23:10:21 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
Subject: Re: [PATCH v2 04/12] md/raid5: Move common stripe count increment
 code into __find_stripe()
Message-ID: <YmD1Tenc2Ylu+biA@infradead.org>
References: <20220420195425.34911-1-logang@deltatee.com>
 <20220420195425.34911-5-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420195425.34911-5-logang@deltatee.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 01:54:17PM -0600, Logan Gunthorpe wrote:
> Both uses of find_stripe() require a fairly complicated dance to
> increment the reference count. Move this into a common find_get_stripe()
> helper.
> 
> No functional changes intended.

The subject is wrong now.

>  static struct stripe_head *__find_stripe(struct r5conf *conf, sector_t sector,
> -					 short generation)
> +					 short generation, int hash)
>  {
>  	struct stripe_head *sh;
>  
> @@ -624,6 +624,49 @@ static struct stripe_head *__find_stripe(struct r5conf *conf, sector_t sector,
>  	return NULL;
>  }

And the new hash argument here is not needed.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
