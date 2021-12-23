Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2229247E29B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 12:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348028AbhLWLu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 06:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhLWLuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 06:50:25 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FAEC061401;
        Thu, 23 Dec 2021 03:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jN4W7V/DKmT3sEjHZdJJG0OYk3hQiWIlt6ROG0e5110=; b=A8+rMjJj7+zIoLXVrSzuuQgtX3
        FC18qgYDhAvzNlz73HYh1fhvTmsCNsFGLaDPXN2WAf8VpOep8pVXQLLjkzUsBTyp/W7nOp3lzUWg3
        sYUYFU5acqxNldiW5xybkYrBJS0K6etgpLeu2U5F5Mrj+URr5NbkZC5oLXBr04lHzVTrrv2EEBtJb
        k9abJqzBG91h8OUFPKC/VFN+NMM30AMvunStEIFG4Oy0z1IRMKTnsd3oJ57sRKs/3jp0Z2BxbipvJ
        1X27y8ige9wnn1+klRnxSMtEblPVn8BxGMKwR+eqRXYPtkc9rOGo3XqGHmsNqmuHzZEIXiFn9y1G6
        bH+ijzFw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0Mc3-00Ccyi-H0; Thu, 23 Dec 2021 11:50:23 +0000
Date:   Thu, 23 Dec 2021 03:50:23 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        linux-block@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
        ming.lei@redhat.com, hch@lst.de, Long Li <longli@microsoft.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: very low IOPS due to "block: reduce
 kblockd_mod_delayed_work_on() CPU consumption"
Message-ID: <YcRif3u3GxUdP3il@infradead.org>
References: <1639853092.524jxfaem2.none.ref@localhost>
 <1639853092.524jxfaem2.none@localhost>
 <7d1e4bb8-1a73-9529-3191-66df4ff2d5fe@kernel.dk>
 <12f43a71-713b-a74f-a169-b6ac3d804e50@kernel.dk>
 <237bd7d8-9e75-01b5-ebe7-8b1eb747474b@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <237bd7d8-9e75-01b5-ebe7-8b1eb747474b@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 19, 2021 at 08:28:18AM -0700, Jens Axboe wrote:
> > 
> > Dexuan, can you test this for your test case too? I'm going to queue
> > up a revert for -rc6 just in case.
> 
> This one should be better...

We might just want something like a revert of
9f993737906b30d7b2454a38637d1f70ffd60f2f.

Or just always use a normal work queue for run_work, and then use a
timer to schedule it for the relatively rare delayed case.
