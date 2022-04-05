Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35DA84F2381
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 08:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiDEGrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 02:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbiDEGqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 02:46:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44BEDE94;
        Mon,  4 Apr 2022 23:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aa6EnR0OODni9NkMlW60o+EQDHL2WUhXl/q4Tb5C0WA=; b=F4LcFfuZLWAu9MYQ1IC5TROCFf
        4kSSfdcZQZRcHRWwrmPTMkTLMoGOdmP87tvso2dlbXAGh2KNp1IyI1OKuM5COVBeLftnoTDZwlCWK
        IIHXkxdnE0QyAAti4rFCLRYndQWHSQ1XFRwsEYXlIjoK8TlG8kum0u1pljqalf+yc98EGUJzrBuKj
        y1plqwEmzXxbgvyy7KCdvK5/LtJY13nGSQKh4QAxJkJ6fB1E+GCazq2xWp7aIMGzDg2NboNQhjfFi
        zHCLk2pVlt4AfWN5Y0e+mmBPgb/b0HZnWDbEyKEVLF3m7hNPB8NEeWDsMZ1BVdsVl+HWByHhP+jS7
        ofuxnI1A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbcvO-00HM1T-5d; Tue, 05 Apr 2022 06:44:22 +0000
Date:   Mon, 4 Apr 2022 23:44:22 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Christoph Hellwig <hch@infradead.org>,
        syzbot <syzbot+4f1a237abaf14719db49@syzkaller.appspotmail.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Jan Kara <jack@suse.cz>
Subject: Re: [syzbot] INFO: task can't die in blkdev_common_ioctl
Message-ID: <YkvlRnO3Ho/mrk0V@infradead.org>
References: <0000000000007a4a2d05dba6baa6@google.com>
 <d3213c1a-f82a-02f6-b5b2-0d3242e0242a@I-love.SAKURA.ne.jp>
 <Ykp63pk7aSj/bNRT@infradead.org>
 <67179a84-8be7-4c93-e355-2ca50666f960@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67179a84-8be7-4c93-e355-2ca50666f960@I-love.SAKURA.ne.jp>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 02:12:14PM +0900, Tetsuo Handa wrote:
> On 2022/04/04 13:58, Christoph Hellwig wrote:
> > all, as it does not come through blkdev_fallocate.
> 
> My patch proposes filemap_invalidate_lock_killable() and converts only
> blkdev_fallocate() case as a starting point. Nothing prevents us from
> converting e.g. blk_ioctl_zeroout() case as well. The "not come through
> blkdev_fallocate" is bogus.

Sure, we could try to convert most of the > 50 instances of
filemap_invalidate_lock to be killable.  But that:

  a) isn't what your patch actuall did
  b) doesn't solve the underlying issue that is wasn't designed to to be
     held over very extremely long running operations

Or to get back to what I said before - I don't think we can just hold
the lock over manually zeroing potentially gigabytes of blocks.

In other words:  we'll need to chunk the zeroing up if we want
to hold the invalidate lock, I see no ther way to properly fix this.
