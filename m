Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279E750975F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 08:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384773AbiDUGVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352817AbiDUGVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:21:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7416BC2B;
        Wed, 20 Apr 2022 23:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xlBQ6DVKGvFJX+Ldx3rdWv/HFspbxlibkRveNNlmLbM=; b=ug8j40B6lWGt+wzhUTXj7e353L
        gJ4Bo/pvrUNY75psm5ERq71079ac/QEKwfkQZXEc0dKCAXNuoiTkVplW+XfWLyd3Kcbn4NLeTFk8/
        CWYYY8/aQFy6J1s+IE6OtE9TVksfH751fx0T0NRQzIoi4PCXQOvPwsiS1bFnTYYwbBCl6lvfevuto
        j1xnoqWAKx1mjzB4N1sTzM2E5FkoM3yyBgja95DbZhY/znKbEN7krEt753Oo2qMjefVGALyBTm+4v
        YvQoxX+U2FNxDaZ3+lapRetBuRcdlTUGd2mPRaXmZ8UxxgoZKxVQmwYbTTD7lGhYUYCHW3uSr4pOm
        hy1M7Ruw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhQ9X-00Bfqb-83; Thu, 21 Apr 2022 06:18:55 +0000
Date:   Wed, 20 Apr 2022 23:18:55 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
Subject: Re: [PATCH v2 11/12] md/raid5: Check all disks in a stripe_head for
 reshape progress
Message-ID: <YmD3T8KcmSm0e0bS@infradead.org>
References: <20220420195425.34911-1-logang@deltatee.com>
 <20220420195425.34911-12-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420195425.34911-12-logang@deltatee.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 01:54:24PM -0600, Logan Gunthorpe wrote:
> +static bool range_ahead_of_reshape(struct mddev *mddev, sector_t min,
> +				   sector_t max, sector_t reshape_sector)
> +{
> +	if (mddev->reshape_backwards)
> +		return max < reshape_sector;
> +	else
> +		return min >= reshape_sector;
> +}

Nit: no need for the return.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
