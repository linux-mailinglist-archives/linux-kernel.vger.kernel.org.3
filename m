Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F07A49DE7C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 10:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237953AbiA0Jx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 04:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbiA0Jx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 04:53:56 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6481C061714;
        Thu, 27 Jan 2022 01:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=f7MlaSEz6umLGGRRw+gzvEQHKmGazXR+6FAeeKIYXok=; b=nCtelemW8pNoZKhelkxFwgSLGo
        7g/YeHr4rfvd+kkipunDzfRg43eQr4RBKgBmoyYFi4sMqTOcnbb/HtD3ubsVeS/mhNCRQftkctSCn
        /n30/GhgqdHDdjLOLKq80fI8Ve3E2kUI7e17VhTGAmwQPUXg4mcNscWy7SJiqpphil/1+7WEaz5tD
        P72UnFCyMC8iYAdkE2d4kZR15UJuxhCspBeF1xrKdxfqMlZolfz08qMjOJimuqZNR0R7wON52e31N
        wYNHBzxezBSVBVA9uNGQSRF3gWtosXvoUv9JlkhlaRIP2vaBBvE1ExJkigA7Ihz3qZ/kbClm9Ahu+
        m/s4yM8Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nD1TW-00EzYz-Gn; Thu, 27 Jan 2022 09:53:54 +0000
Date:   Thu, 27 Jan 2022 01:53:54 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     axboe@kernel.dk, hch@infradead.org, rostedt@goodmis.org,
        xiyou.wangcong@gmail.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v5 PATCH] block: introduce block_rq_error tracepoint
Message-ID: <YfJrsid0OJQykXYz@infradead.org>
References: <20220126185153.417948-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126185153.417948-1-shy828301@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 10:51:53AM -0800, Yang Shi wrote:
> +		__entry->dev	   = rq->q->disk ? disk_devt(rq->q->disk) : 0;
> +		__assign_str(name,   rq->q->disk ? rq->q->disk->disk_name : "?");

None f the other tracepoints has the disk name, why does this one need
it?  And if you add it please avoid the overly long line.

> +		__entry->sector    = blk_rq_pos(rq);
> +		__entry->nr_sector = nr_bytes >> 9;
> +		__entry->error     = blk_status_to_errno(error);

This still converts the block status to an errno.
