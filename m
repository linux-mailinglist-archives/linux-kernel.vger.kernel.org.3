Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A434F8EA7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235046AbiDHGD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 02:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiDHGD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 02:03:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F297A7246E;
        Thu,  7 Apr 2022 23:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LwACgBHjx4pJUIm6fVU5Jm7rMF6w4rkrcMcx4fw4FCI=; b=375lV7YC8QITt0RjH/PrWrQSKU
        +OF4LBtPCTwnV3ST18w56iW8/gCOQIxCsXu4Jo9EyVXrx7K33nAbuJIxIc2VOOYCq7mYfZy/NUftn
        m/bbl1LQ36t79bf6ml8bGRR3gzVcLKK3ZTEfTzjpkI/FXvPLe1uCOB01UyzJcx4iT41nY5fm6QsmX
        tqQ4n0fApCd4PXVOtvPsxYCOUwGUrm4SV0JPwQdT/BxCv6jCuAliPmkFn/0u6Zn5ENZjNaaElGc/M
        YUXFyPChzzwczeI6hCxNBrr6EMxUdkUCBD+79za8afY+zpH8HDSp/ZJB9ZpWX9qYNF0lvbxbl+s5E
        abO0PaSg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nchgv-00FDvY-B7; Fri, 08 Apr 2022 06:01:53 +0000
Date:   Thu, 7 Apr 2022 23:01:53 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>, Shaohua Li <shli@kernel.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
Subject: Re: [PATCH v1 3/8] md/raid5: Move common stripe count increment code
 into __find_stripe()
Message-ID: <Yk/P0e6E7uVLkMnZ@infradead.org>
References: <20220407164511.8472-1-logang@deltatee.com>
 <20220407164511.8472-4-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407164511.8472-4-logang@deltatee.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 10:45:06AM -0600, Logan Gunthorpe wrote:
>  static struct stripe_head *__find_stripe(struct r5conf *conf, sector_t sector,
> -					 short generation)
> +					 short generation, int hash)
>  {
> +	int inc_empty_inactive_list_flag;
>  	struct stripe_head *sh;
>  
>  	pr_debug("__find_stripe, sector %llu\n", (unsigned long long)sector);
>  	hlist_for_each_entry(sh, stripe_hash(conf, sector), hash)
>  		if (sh->sector == sector && sh->generation == generation)
> -			return sh;
> +			goto found;
>  	pr_debug("__stripe %llu not in cache\n", (unsigned long long)sector);
>  	return NULL;
> +
> +found:
> +	if (!atomic_inc_not_zero(&sh->count)) {

There is a way on list iterators outside the loop body waging right
now.  So maybe just leave __find_stripe as-is and add a new
find_get_stripe that wraps it.  And then just return early when the
atomic_inc_not_zero dos not succeed and save on one level of
indentation.

