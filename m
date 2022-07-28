Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01C85840D9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 16:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbiG1OP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 10:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiG1OPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 10:15:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A3811A29;
        Thu, 28 Jul 2022 07:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nFOoJ8nga1EDaqCwMEzbmkgTMo/1ebWCPdGaO/dEKf0=; b=SATzZfMwrRk0rCbGH7sFPKN6yh
        HopjXb7EzJu/QvddFaVznHFLYLcaMODru4cx1bZAsJNr46xIuO20ERe12oBCZd18/0nh6KQvHgj0a
        /LswS4Uq5R96y3Wog85EeSkHhJvoAxcv6SLDeTuee4nTpZio+XHn85C/nrCTAlkGTITImCrZxpLSY
        VEHVxFH6fIZ+KQP8Fi4weztiCYYryST2O8SDQNn6R1TL6UjCkiwEs+Rfj5AzAhPDascYQrnXaKdWb
        vGad+nZUIOowGuf4fz5JHzohIFdNSE3AvFCS51+IXbtpHq05ApbDOA2K2Uh2YchIsHAwXiWfBsHzy
        A8SvStvw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oH4Ip-00A30r-TM; Thu, 28 Jul 2022 14:15:51 +0000
Date:   Thu, 28 Jul 2022 07:15:51 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
Subject: Re: [PATCH 5/5] md/raid5: Ensure batch_last is released before
 sleeping for quiesce
Message-ID: <YuKaF99Da1vqpqVP@infradead.org>
References: <20220727210600.120221-1-logang@deltatee.com>
 <20220727210600.120221-6-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727210600.120221-6-logang@deltatee.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 03:06:00PM -0600, Logan Gunthorpe wrote:
> +static struct stripe_head *__raid5_get_active_stripe(struct r5conf *conf,
> +		struct stripe_request_ctx *ctx, sector_t sector,
> +		bool previous, bool noblock, bool noquiesce)

Passing three different bool arguments right after another is a really
confusing calling convention, at some point this should become a set of
flags.  I'd also drop the __raid5_get_active_stripe vs
raid5_get_active_stripe distinction.
