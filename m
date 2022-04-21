Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D505509752
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 08:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384719AbiDUGTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381512AbiDUGTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:19:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A77813DC6;
        Wed, 20 Apr 2022 23:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LJdfKH17SuEaJzlyMwbOL6nCjZoX11A6xpvP5YZSpq8=; b=QaBr4CmhpNuFzZ1LLNkoRnRUEN
        FCCoag2DYMAoQG0INxffncotG+uufY3iZblojfrjUG/2ufmv5rnq+Sr2LU3E1Ys4h5Yj0BdXxAmg/
        UZEjP1RASx5eVhq7J4IT/YgtMtbUnAT+cnOxtIOInXXY+TvBIgye8LDwiJGCLVwrorwdgaG63ilm1
        p4oBM3w19n+lbL61HLjX5AqfTsF9QT/6QmABRdwejtgPQVZpKCTwdgzCLYfdWAw2Nhmrl+cnZsdmb
        fl8Wl8jmIShKxZF03f80fxwoOxh0iFwiEziETkfUfbEnoGHp/LuL889O3ujZbVIAeiJXdJR0ncz4I
        7VlRMLfA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhQ7Y-00BesJ-PB; Thu, 21 Apr 2022 06:16:52 +0000
Date:   Wed, 20 Apr 2022 23:16:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
Subject: Re: [PATCH v2 08/12] md/raid5: Refactor for loop in
 raid5_make_request() into while loop
Message-ID: <YmD21LQIUl4ahTTh@infradead.org>
References: <20220420195425.34911-1-logang@deltatee.com>
 <20220420195425.34911-9-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420195425.34911-9-logang@deltatee.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 01:54:21PM -0600, Logan Gunthorpe wrote:
>  	prepare_to_wait(&conf->wait_for_overlap, &w, TASK_UNINTERRUPTIBLE);
> -	for (; logical_sector < last_sector; logical_sector += RAID5_STRIPE_SECTORS(conf)) {
> -	retry:
> +	while (logical_sector < last_sector) {
>  		res = make_stripe_request(mddev, conf, &ctx, logical_sector,
>  					  bi);
>  		if (res == STRIPE_FAIL) {
>  			break;
>  		} else if (res == STRIPE_RETRY) {
> -			goto retry;
> +			continue;
>  		} else if (res == STRIPE_SCHEDULE_AND_RETRY) {
>  			schedule();
>  			prepare_to_wait(&conf->wait_for_overlap, &w,
>  					TASK_UNINTERRUPTIBLE);
> -			goto retry;
> +			continue;
>  		}

All the else statements here aren't needed (this is really a
comment for the earlier patch adding them).

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
