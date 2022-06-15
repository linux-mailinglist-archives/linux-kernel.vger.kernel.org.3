Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93FC54C1B9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 08:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345724AbiFOGWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 02:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233995AbiFOGWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 02:22:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B1B220C5;
        Tue, 14 Jun 2022 23:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MR5dIhQ/3CQ+DJyAHEHewkMnjmVc/yPENWsA0gqfTtg=; b=M5S0w41Kf8KjwS8Y/YH1g3VGqI
        fKC+3UZ0Gqzlee9RVFDTwF4pQDliSsnMrng57U317+1YRvOeI7ug8Eijrgi/YpyAVWQYvvt660dgW
        rgQG6dfavqJrUDgF33SMs5t5QHZ14LYIW3+t2bzgjFSegvIgrlQDU4aXvXYsgndP6uX+SuAGQybWi
        j8yBTqLuY7YuDbowkeeUE5LCCjJRHszEvGr3dMFj/nx6sbBVnWI7OuQVuaZSDVI58uBmhGxFp6lhd
        KtI0uGc5w/fBrdS471ySYhhY9tfOnWe3hlDA2YmTc/qLzJR5o7KvIGt6jY+NZSmyX/jh1dTywBEnZ
        +SwhQjbA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1MPZ-00CqTw-6O; Wed, 15 Jun 2022 06:21:53 +0000
Date:   Tue, 14 Jun 2022 23:21:53 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, axboe@kernel.dk,
        djeffery@redhat.com, bvanassche@acm.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next] blk-mq: fix boot time regression for scsi drives
 with multiple hctx
Message-ID: <Yql6gbP2NmKsvFqH@infradead.org>
References: <20220614071410.3571204-1-yukuai3@huawei.com>
 <Yqg5QxSM+lub8DY0@T590>
 <01cb0e49-1154-33db-f572-3960c972fe08@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01cb0e49-1154-33db-f572-3960c972fe08@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 09:15:36PM +0800, Yu Kuai wrote:
> > for making so long, so I guess there must be other delay added by the feature
> > of BLK_MQ_F_TAG_HCTX_SHARED.
> 
> Please see details in the reasons 2), scsi scan will call
> __scsi_remove_device() a lot of times(each host, each channel, each
> target).

Well, if the SCSI core does that you are falling back to a sequentical
scan instad of using REPORT LUNS.  Which seems like a bug on its own
that is worth investigation.
