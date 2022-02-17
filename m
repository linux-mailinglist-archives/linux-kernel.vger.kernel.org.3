Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CAB4BA258
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 15:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239047AbiBQOD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 09:03:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiBQODZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 09:03:25 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDFC2739;
        Thu, 17 Feb 2022 06:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5ThTrjw8eJGxXVU77D/l4DZ/KHavY2TYx2rYbPHIVDc=; b=v2Ppdt5PASqi/PN2ZYV3ufJrhW
        JYjIc+nc+iwarsKwS7Y6+ZPcc+xNcvsKRDRbHhanompEvZKn+OvTXW25kwwMiJVmcPBpEo53MXH/5
        eWPwGxnC1deE7wQy24LvSDBcYXCo++cT4nZMrwZCv0/63VwDgGwCttXlvidTT8rpc2IyhDG22YZ/o
        OdCtDKLLcRrSUf7zvSkcYusz8QQ6zPnOXqhkxj36ErCkxExRxi8GI38mokT+Sn7WnbO4luJ6G6iSu
        +RViz5r/8Nd0lm2l+EivZAnNrVnXIVEpRzCN+bB8EeoXlUl1IwTNP1vq+EGoWnKqqkwMrQnoSWUny
        CMoeiwRA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKhNF-00AqVB-Jf; Thu, 17 Feb 2022 14:03:09 +0000
Date:   Thu, 17 Feb 2022 06:03:09 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk: do rq_qos_exit in blk_cleanup_queue
Message-ID: <Yg5VnRtsrrQX4mFG@infradead.org>
References: <20220216113212.83000-1-jianchao.wan9@gmail.com>
 <Yg392sqFydj9p3My@infradead.org>
 <96deb063-f4ef-fadd-543b-e905495898f6@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96deb063-f4ef-fadd-543b-e905495898f6@kernel.dk>
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

On Thu, Feb 17, 2022 at 06:34:02AM -0700, Jens Axboe wrote:
> On 2/17/22 12:48 AM, Christoph Hellwig wrote:
> > On Wed, Feb 16, 2022 at 07:32:12PM +0800, Wang Jianchao (Kuaishou) wrote:
> >> From: Wang Jianchao <wangjianchao@kuaishou.com>
> >>
> >> When __alloc_disk_node() failed, there will not not del_gendisk()
> >> any more, then resource in rqos policies is leaked. Add rq_qos_exit()
> >> into blk_cleanup_queue(). rqos is removed from the list, so needn't
> >> to worry .exit is called twice.
> >>
> >> Fixes: commit 8e141f9eb803 ("block: drain file system I/O on del_gendisk")
> >> Suggested-by: Bart Van Assche <bart.vanassche@wdc.com>
> >> Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>
> > 
> > Ming had a pending patch to move it into disk_release instead, which
> > I think is the right place.
> 
> I missed that patch and can't seem to find it, do you have a link?

[PATCH V2 12/13] block: move rq_qos_exit() into disk_release()

from Jan 22.  Although it would need a rebase so it can be applied
without the preceding patches.
