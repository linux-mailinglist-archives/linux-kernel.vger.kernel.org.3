Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCBB46C1A3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 18:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235340AbhLGRY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 12:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbhLGRY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 12:24:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B721C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 09:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hbw7xjyNHBdKCDx8f/fj+yJQq2CelgAsBRYWYzZTDA4=; b=GsnOB/WKfTxJnByS0ol5L3Wuhb
        G5JX8XEKwvNplL2wxqJ6sQtWsFcGUl48B0IoQEf+AAbE+NYuvNbDNIlX7l1K6+OJxr1X6bjo80kF+
        5pHri6wdkO7jCxp5tGis+QAzaEonkfyTMp+yPi+PXiWrL75YurCrvuqmENbrTB5xczqa1y4qjk5LC
        5F6WbZn36V+9MQ0m/ToJrpBJZ6yHsp3DtGiQzjdzgG2kJ5xd5D5Mk/Tbj53Stl4sQ0gwqYSWYh5XM
        JdqxkzEP2toExlKoR/Yxedqkr6uWjc1LUsDeKaT4JF3oxx0FmIaVdNj8UkB79T3NjnXrNQRrtgKpr
        D86eQvFw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mue96-007aIp-3V; Tue, 07 Dec 2021 17:20:52 +0000
Date:   Tue, 7 Dec 2021 17:20:52 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     xf2017140389@gmail.com
Cc:     akpm@linux-foundation.org, christian@brauner.io,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        zhangcang@xiaomi.com, wangju@xiaomi.com, surenb@google.com,
        fangzhirong@xiaomi.com, xiaofeng <xiaofeng5@xiaomi.com>
Subject: Re: [PATCH] mm/madvise: break reclaim when lock race
Message-ID: <Ya+X9IEXiCDFPJIZ@casper.infradead.org>
References: <20211207032202.6022-1-xiaofeng5@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207032202.6022-1-xiaofeng5@xiaomi.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 11:22:02AM +0800, xf2017140389@gmail.com wrote:
> From: xiaofeng <xiaofeng5@xiaomi.com>
> 
> When the process_madvise() system call is being used, it takes mmap_lock and blocks the application from allocating memory, leading to unreasonable delays. This patchset aims to fix it.

This means that any page fault will cause madvise() to fail.  NACK.
