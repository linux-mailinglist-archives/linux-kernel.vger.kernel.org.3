Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4439C50972B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 08:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384649AbiDUGKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384641AbiDUGKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:10:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436B010FE9;
        Wed, 20 Apr 2022 23:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jZM9msgDNeu7xI9NF/7peTFnK08gLMscQ4rYMQqGU2E=; b=nMkLeWmhfjkXKoni4Un4Mgw65Y
        PuRJLMdtiHJOV8lHmucaN5dQAqpvMlAkBKfObYoJbXRkV5cGiIW2OfUW+Mjl4F7vFGbijA9wLa2Ib
        RB6GGNoCBxpqVlWKQYaHumsW+0BbJUjEma05bxNjuPt9ZSRVF/aKCuxBGMAG2uU+9JMZFkGT1KDd4
        gZNh2o1jMzxkayTHxp/w6gDANWDp469mrMjwgLgd/VovQXOhziczigxlfHnHiJwgiNsJQiUwg28h9
        yv2iyhlad4GRwDgK4SL/noRlH+de37OLhfEpL//V6ic8cHniuQbO0ta4taELLZv5hb2tM9X9ls3ZH
        yZPnKfQQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhPym-00BdJE-UV; Thu, 21 Apr 2022 06:07:48 +0000
Date:   Wed, 20 Apr 2022 23:07:48 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 01/12] md/raid5: Factor out ahead_of_reshape() function
Message-ID: <YmD0tJ8JJmiL43q1@infradead.org>
References: <20220420195425.34911-1-logang@deltatee.com>
 <20220420195425.34911-2-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420195425.34911-2-logang@deltatee.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 01:54:14PM -0600, Logan Gunthorpe wrote:
> +static bool ahead_of_reshape(struct mddev *mddev, sector_t sector,
> +			     sector_t reshape_sector)
> +{
> +	if (mddev->reshape_backwards)
> +		return sector < reshape_sector;
> +	else
> +		return sector >= reshape_sector;
> +}

No real eed for the else here.  Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
