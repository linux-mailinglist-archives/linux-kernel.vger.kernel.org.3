Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4D41495002
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 15:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345729AbiATOVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 09:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbiATOVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 09:21:31 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14460C061574;
        Thu, 20 Jan 2022 06:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=To8BttLxoJklAEKbWFTWQDtm67ehUjdSCEtQCd+K09E=; b=x0Y2RJTm8w8ZVWJWj09a6R4OQD
        +ub/tV/zUe8Un+t8m95v196Hs9r8JsWtEHggbt0yXDvk4uYeH7/wCBdbsvSVBL77H95MolCRmsrOb
        PflsuDByorsmqro07tdlWkzWSUC00tbaiM/vglV/Hbr2jteilahbJ8IttLJSLHunNYxfjLpxfdWGu
        Hzavcu4Bs+q1Cjc5wDkPyFeAG/Og1j2G7JRc2b9ovyycl4EJtJjP20AfNsVd9yj9Vf3Q4ji5nw5Pn
        ZfpXuyA1qmBlfbosr1NdqRS3iasKZWP3OiOCg3YkjsCCvlTQ8tCXSwGJHIWmRy765o7f+6Q5jL599
        S6ha5Idw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nAYJa-00BsNF-QB; Thu, 20 Jan 2022 14:21:26 +0000
Date:   Thu, 20 Jan 2022 06:21:26 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/2] block: hold queue lock while iterating in
 diskstats_show
Message-ID: <Yelv5kTzQGOyucIS@infradead.org>
References: <20220120105248.117025-1-dwagner@suse.de>
 <20220120105248.117025-3-dwagner@suse.de>
 <Yelb4+r5KuV67tO0@T590>
 <20220120131936.mlug7nhnoe73abx5@carbon.lan>
 <Yelo1gx5cp1l4npK@T590>
 <20220120140126.ntzvrcmczd7pph75@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120140126.ntzvrcmczd7pph75@carbon.lan>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 03:01:26PM +0100, Daniel Wagner wrote:
> On Thu, Jan 20, 2022 at 09:51:18PM +0800, Ming Lei wrote:
> > Then Can you figure out where blk_mq_queue_tag_busy_iter+0x1e4 points to
> > in source code? And what is NULL pointer?
> 
> Here we go:
> 
> /usr/src/debug/kernel-default-5.3.18-59.27.1.x86_64/linux-5.3/linux-obj/../include/linux/sbitmap.h: 249

That looks quite old.  How does this look on mainline?
