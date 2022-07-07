Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89BE256A993
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 19:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236070AbiGGR0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 13:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbiGGR0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 13:26:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094651C90A;
        Thu,  7 Jul 2022 10:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UHkKBpm+RhgrMphAf+XCwO//K//fxp+6iHZ7q8wCcNM=; b=vbEVH511VYM2BZTVa39U3EA3ro
        Lf5kDXfDT46fqK25htVyvxN9bKmcLrrVh5iV9eq9ProjLfQYHqYiSqMgNwlRFx7/yzwN2LjGuSVcG
        w86ETGFmGN8s6F21uTlGAC711vNk6dO8Yb8Ssb4DS2lGEJd282WEE5jq9XlKjRzxlSDjSDGYc4XuS
        syI9xC11i5Rbxsmez/f1csmXYnKrkO1hxS4bcpS784/idKGxcf8R1uYwY6b/F6Bx0JVaAYzTd0BE7
        2p5t2JAJm8isLef7ishy16TU3QsFE77jT/RlWRqHu51a64CoalatMPmr0Jhw3Rkg60ia3Y/WZcUBZ
        PX4N2pTA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9VGu-00HDr9-IW; Thu, 07 Jul 2022 17:26:36 +0000
Date:   Thu, 7 Jul 2022 10:26:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/20] block, blk_filter: enable block device filters
Message-ID: <YscXTGXumE5Ust15@infradead.org>
References: <1655135593-1900-1-git-send-email-sergei.shtepa@veeam.com>
 <1655135593-1900-2-git-send-email-sergei.shtepa@veeam.com>
 <YsWHHcCfSVFklh4M@infradead.org>
 <ff78a1ee-8bc5-6e8e-040f-978cd07eacfe@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff78a1ee-8bc5-6e8e-040f-978cd07eacfe@veeam.com>
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

On Thu, Jul 07, 2022 at 10:26:55AM +0200, Sergei Shtepa wrote:
> Thank you, Christoph, for your attention to the patch.
> 
> I am preparing the next version of the patch. In it, I planned to
> simplify the bdev_filer code.
> I will make changes in it, in accordance with your comments, and
> will add your code and check it on my test labs.
> 
> But I'm not sure if using the blk_mq_freeze_queue() is appropriate.
> If I understood the code correctly, it is based on the expectation
> that the counter q->q_usage_counter will decrease to zero.
> To increase it, a blk_queue_enter() is used. And at the time of
> calling the filter_bio() in the submit_bio_noacct(), this counter
> has not yet been increased. I will double check this and try to
> get rid of the bdev->bd_filter_lock.

Indeed.  For this to work we'd need to call the filter driver
later.  Which is brings up another question:  Is there a real
need to attach the filter driver to the bdev and thus potentially
partition?  The rest of the block layer operates on the whole disk
after the intial partition remapping, and besides allowing the
filter driver to be called under q_usage_counter, this would
also clean up some concepts.  It would probably also allow to
remove the repeat return value over just using submit_bio_noacct
similar to how normal stacking drivers reinject bios.
