Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED63949DE74
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 10:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238858AbiA0JwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 04:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiA0JwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 04:52:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F251C061714;
        Thu, 27 Jan 2022 01:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0NAy8wocvqsiALK9bDMO3lSLn+RuXKvaS9DlBcJzgmc=; b=yR+aEqUOzXhIW8RsCKe5wiswgh
        b2BubhjdXNuFofnaLH/syQjatt96PFaRhSVq4gOD+RPYlsDnCYdML+2TxHa9YXdMflneayNrrCuQz
        WNI/r1iqmooa/DN2IMs3qJ+gyjS9vVopjdIqkyh+odnD8qKohq9mw8YmfU0prAOYrQsFnvdlWA0dQ
        Blklpaia1EI6QohM9cNafspBks8j6+in+IPGLHyJOf4T83TVLXAzjEFjQMAq+DxMS6BRlRPxWO7yX
        LFWfZIELFcWslK4cGpTBqoQ3a1CYasIv7IT91lsSQCz8IVJHjqim4Nh127Zl4H70xMBGJJ+5VbTAF
        Uxd4Nojw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nD1Rn-00Ez4V-7y; Thu, 27 Jan 2022 09:52:07 +0000
Date:   Thu, 27 Jan 2022 01:52:07 -0800
From:   "hch@infradead.org" <hch@infradead.org>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     Yang Shi <shy828301@gmail.com>,
        "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>
Subject: Re: [v5 PATCH] block: introduce block_rq_error tracepoint
Message-ID: <YfJrR7nIw0fbHLVj@infradead.org>
References: <20220126185153.417948-1-shy828301@gmail.com>
 <8de293cb-168b-5a52-3791-dba36ef4217d@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8de293cb-168b-5a52-3791-dba36ef4217d@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 08:02:26AM +0000, Chaitanya Kulkarni wrote:
> > +               __field(  unsigned int, nr_sector               )
> > +               __field(  int,          error                   )
> > +               __array(  char,         rwbs,   RWBS_LEN        )
> > +       ),
> > +
> > +       TP_fast_assign(
> > +               __entry->dev       = rq->q->disk ? disk_devt(rq->q->disk) : 0;
> > +               __assign_str(name,   rq->q->disk ? rq->q->disk->disk_name : "?");
> 
> Did you verify that rq->q->disk NULL checks are must in this checkout
> for blk_update_request() ?

Yes, we need this.
