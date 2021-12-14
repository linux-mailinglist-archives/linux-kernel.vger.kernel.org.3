Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A6F473DFF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 09:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbhLNIIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 03:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhLNIII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 03:08:08 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A88FC061574;
        Tue, 14 Dec 2021 00:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=Qnx+VU+YQAKWtlCK0Z/caQGDrXD77wQzwT4eNh5ScGQ=; b=SMTuicLRt3cAYHFtHUTFUlQeIT
        yiX9IhbbyS3h01s4D0Q2PJ8j6zssyQYQqFQn/MCQ5kd1MD9RwVn831cEIzeNF3dhkqKQqkNnEf3F/
        CFBHKm0zawaalDEyvBM398d+oYTQCPOs+bdIf89H9Xax3sQOtn7jQv6AZrCV9UKFiWwsS2CfvsjvD
        OgFRwIIhhERiaIqL315az3KpLmInNiy9ow6P+g+eaJy13fVvwoTW3m0uZ5UoZQQnaeqV+YWbTG0HT
        DZ9mV6/FhZGYHNGwo1h6tuu0NElZldbkxBM44O3p+SGVac8DE/aMi1/PnUoH/iaD9REBugxVtfMyQ
        ymVTFWoA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mx2qz-00CxmB-Cb; Tue, 14 Dec 2021 08:08:05 +0000
Date:   Tue, 14 Dec 2021 00:08:05 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
        bigeasy@linutronix.de, tglx@linutronix.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] blk-mq: make synchronous hw_queue runs RT friendly
Message-ID: <YbhQ5b2qZN0Jpk5i@infradead.org>
References: <20211213054425.28121-1-dave@stgolabs.net>
 <YbdFeHVnQbT0E5kR@infradead.org>
 <20211213190529.j54qikq7mk5zuc3o@offworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211213190529.j54qikq7mk5zuc3o@offworld>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 11:05:29AM -0800, Davidlohr Bueso wrote:
> On Mon, 13 Dec 2021, Christoph Hellwig wrote:
> > But more importantly:  why isn't migrate_disable/enable doing the right
> > thing for !PREEMPT_RT to avoid this mess?
> 
> Please see Peter's description of the situation in af449901b84.

That explains why migrate_disable is a bad idea in PREEMPT_RT, not why it
can't do something sensible for !PREEMPT_RT…

> 
> While I'm not at all a fan of sprinkling migrate_disabling around code,
> I didn't want to add any overhead for the common case. If this, however,
> were not an issue (if most cases are async runs, for example) the ideal
> solution I think would be to just pin current to the hctx->cpumask.

sync running is the performance case.
