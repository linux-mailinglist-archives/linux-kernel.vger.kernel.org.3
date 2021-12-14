Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A97473DF5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 09:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbhLNIHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 03:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhLNIHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 03:07:07 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C69FC061574;
        Tue, 14 Dec 2021 00:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZyC+7xWVW2j5+g5NKeUtyv86D7fnjjhxXdSCXA1kIQI=; b=1zXTnkqfX511DoGIa0Lc80g3Q8
        /3SaqrRXSIf6svFBmJC7ZD5/lrJ+/ZQgjG+OfZodx3H+XBxywPYJWMb0Ga5V/PZfqHfSv6P6a1cj8
        Z0sEtnvfPLtDrfJTqhRSoECl8LOQvVKzYADMVGZTqj2jb8o6z06l8VQYUiIWkr7oD0ABH5VYL+Xgb
        LRMfb+IfMs5/fU/eMrDESRxNoPbcFPCkjXlR+/YEI80UexqFXHVzoADbPBtsjg9Tb1inOUK0KnLSM
        JmxfYNJOY8qfvU01wihpZJjZI21bFFy9/71plSjmHhXVFn6Ybv+Xa5Owpfqh8D2iUs5IfstjlmpOq
        RRzRtsBA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mx2pz-00CxWU-Kx; Tue, 14 Dec 2021 08:07:03 +0000
Date:   Tue, 14 Dec 2021 00:07:03 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Laibin Qiu <qiulaibin@huawei.com>, axboe@kernel.dk,
        yi.zhang@huawei.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] block/wbt: fix negative inflight counter when
 remove scsi device
Message-ID: <YbhQp9H6Z08izS+T@infradead.org>
References: <20211213040907.2669480-1-qiulaibin@huawei.com>
 <YbeAAyWbkh5frMGc@infradead.org>
 <YbfvplNrBkuZUIyf@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbfvplNrBkuZUIyf@T590>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 09:13:10AM +0800, Ming Lei wrote:
> > Wouldn't it make more sense to simply not call wbt_enable_default from
> > elv_unregister_queue?
> 
> wbt_disable_default() is called in bfq_init_root_group(), so wbt_enable_default

s/bfq_init_root_group/bfq_init_queue/

But yes, that sounds like an even better idea.  Or maybe even an
elevator feature flag.
