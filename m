Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCF24BA4DC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 16:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242726AbiBQPsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 10:48:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242582AbiBQPsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:48:52 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A6015C672;
        Thu, 17 Feb 2022 07:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=C64EWtN/f9bCsY8A/y864AzqVeE3CzsItNdn/gVkzik=; b=jCfaIcxlLYVA6BVbQUUqoq9vs3
        ttepisGsE54fuHbaxe7EZGo8aY4x5XyqA0Gq3DycWRmaSI47gwocc9MsqKRASysh54GhMwhY1GLwk
        gceCtl3pqUzVV9ADo9SxQCcFaLuNdArZwG8Ijbx6Avbpczu5T8YWM6dloPLyr0hYmuIISBTyrVnOM
        DYRhGWt1EwNRQ22wwnIC5imtDAx4Qo9i/eYZybjnEaVhoWoAE+p8ckk98ByTUVWS9uvTcdkBhKlKN
        aIxNyleEJsc4zglXLG3+zbpoXIgldXFi59/lpjrt3hTRbacTXZTR3p/PzcCfgqle0FgaWes7/niLS
        EBD2gAZQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKj1F-00BL4C-UU; Thu, 17 Feb 2022 15:48:33 +0000
Date:   Thu, 17 Feb 2022 07:48:33 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk: do rq_qos_exit in blk_cleanup_queue
Message-ID: <Yg5uUeMONPn4jnng@infradead.org>
References: <20220216113212.83000-1-jianchao.wan9@gmail.com>
 <Yg392sqFydj9p3My@infradead.org>
 <96deb063-f4ef-fadd-543b-e905495898f6@kernel.dk>
 <Yg5VnRtsrrQX4mFG@infradead.org>
 <eb8e2477-d8f6-b032-6177-8ce187de12ab@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb8e2477-d8f6-b032-6177-8ce187de12ab@kernel.dk>
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

On Thu, Feb 17, 2022 at 07:55:16AM -0700, Jens Axboe wrote:
> > from Jan 22.  Although it would need a rebase so it can be applied
> > without the preceding patches.
> 
> Can someone respin that for 5.17 then?

I looked at it and it I don't think we can do that without a lot of
the prep patches.

That being said I think this version of the patch also is buggy, we
want the policies shut down in del_gendisk with the queue frozen for
normal operation.

I guess until we can move the initialization and teardown entirely
to the gendisk as in Ming's more complex series we need to keep the
call in del_gendisk and also do it in blk_cleanup_queue.  For the
normal shutdown on disk that were life del_gendisk does the all the
work on the frozen queue, while for queues that never had a disk
blk_cleanup_queue will clean up the unused rq_qos.
