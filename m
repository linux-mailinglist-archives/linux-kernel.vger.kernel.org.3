Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC614B9A0B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 08:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236576AbiBQHtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 02:49:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbiBQHs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 02:48:59 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCBB23A1BF;
        Wed, 16 Feb 2022 23:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KeoMC3QDwkILkdaaVYJOrxxk8FLYMhwewJ4WEEPcc7k=; b=RIgIYM9q2/MnwiQ3vnxgKWOrAo
        c0RqBVyDuXHGbVdlybtKyRmlodpXUkhbYGY6XaYZ3vx204mi1cVgUmDBMZpUvT3Xw1E1Za17p1N22
        2YX8yyeAi/lBzDvHhFuYKqQNiQGAfWSkST/uhj3NEIqbIfokyvXUTx0YU93m/SnGc5zkf6Nc9g2Nf
        v+dFR7YhgtPiZ0Q3R2DtfTPwqg4vM95oPUjN7YN78AXdoiGLtHGP7HCYnVscckHxoWNNGH8ocvokG
        Z00LjzOlArCrAunL8hOTvIqwway3efTpc9I6gzplTFDB+X8MfGiPIe0LpZi6nP6ZWF+6u0WJJwNDd
        jjkUmD0Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKbWs-009GRt-Dx; Thu, 17 Feb 2022 07:48:42 +0000
Date:   Wed, 16 Feb 2022 23:48:42 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, hch@infradead.org,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk: do rq_qos_exit in blk_cleanup_queue
Message-ID: <Yg392sqFydj9p3My@infradead.org>
References: <20220216113212.83000-1-jianchao.wan9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216113212.83000-1-jianchao.wan9@gmail.com>
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

On Wed, Feb 16, 2022 at 07:32:12PM +0800, Wang Jianchao (Kuaishou) wrote:
> From: Wang Jianchao <wangjianchao@kuaishou.com>
> 
> When __alloc_disk_node() failed, there will not not del_gendisk()
> any more, then resource in rqos policies is leaked. Add rq_qos_exit()
> into blk_cleanup_queue(). rqos is removed from the list, so needn't
> to worry .exit is called twice.
> 
> Fixes: commit 8e141f9eb803 ("block: drain file system I/O on del_gendisk")
> Suggested-by: Bart Van Assche <bart.vanassche@wdc.com>
> Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>

Ming had a pending patch to move it into disk_release instead, which
I think is the right place.
