Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA7056A97C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 19:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236077AbiGGRYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 13:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235915AbiGGRYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 13:24:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB325A2D2;
        Thu,  7 Jul 2022 10:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pdWx3zARAREhuJR5xmtpPrC9f6WvfgxfaPOe+ISQ/VQ=; b=Q9pBOHD69DYAJF96Rm40sR0xsc
        nrQipV9T4V+haMQMLcdfJD7STdlgsfb+2RsnVfKvDgE1BP9WReYIE6DydGggEdd8TlzqwXEmVPh5G
        2FIXasmCmzdTsiEe1eh4rplcqy4ANFzM3lni6MrU8Ry90liRsYTRJzp57ROnToEHifvDQFqjyecKA
        WQXhVoSQG6LRXaSTUH+8nL4liPA3mFPEbrdGvQolYHgfT52zVnO2eNrP6+0awogUiIC7/tjyaUB7o
        JE6y9Q+0ITaRSo/rTNpi0X8H/+HOUceXLGsTbPSOvAzkEe+2UxoYMuBcriXt9jy8B1kOxP4eGYCSV
        pMxEfwjA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9VEy-00HDbO-Qz; Thu, 07 Jul 2022 17:24:36 +0000
Date:   Thu, 7 Jul 2022 10:24:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 15/20] block, blksnap: snapshot image block device
Message-ID: <YscW1Byo0PQq5C84@infradead.org>
References: <1655135593-1900-1-git-send-email-sergei.shtepa@veeam.com>
 <1655135593-1900-16-git-send-email-sergei.shtepa@veeam.com>
 <YsWKhjDV18DeyEZ8@infradead.org>
 <49039d2b-e4bc-62a1-7b4a-a78001a2f430@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49039d2b-e4bc-62a1-7b4a-a78001a2f430@veeam.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 11:16:42AM +0200, Sergei Shtepa wrote:
> The module creates a block device for each snapshot image.
> To make a backup of a block device, the backup tool reads snapshot image.
> This snapshot image block device allows to mount a file system on it
> and perform the necessary preparation. If not for this requirement,
> it would be possible to implement reading via an additional ioctl.
> But that wouldn't be a good design, I think.

Ok, got it.  It was just me who was confused.

> 
> Perhaps I have implemented this block device incorrectly?
> Processing requests of the snapshot image block device is started
> in the function snapimage_queue_rq(). And ends in the 
> snapimage_queue_work() in another kernel thread. Therefore, when
> the request is initialized in snapimage_init_request(), a kernel worker
> is prepared.

I don't think it is wrong, but there is some potential for optimization.

Is there a reson this is implemented as a blk-mq driver vs a bio
based driver that just implements ->submit_bio?  The latter has
the advantage that you are always called in user context, and don't
need the extra workqueue offload. 

The block layer also generally assumes that blk-mq drivers don't
call submit_bio_noacct underneath, so if we can't I'd much
prefer the bio based driver approach here.
