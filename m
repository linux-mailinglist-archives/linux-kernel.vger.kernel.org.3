Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E56B5827B3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 15:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbiG0N3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 09:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233819AbiG0N3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 09:29:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B97733410
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 06:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HT2rOBSyTRGmZLXB5THzZMPG0tRMQrdvo4co8YN86Jw=; b=mgg+6ctM5v5lYiiaaOooVV00Cu
        M7JHlQPx6inDqn92HaduWdqp41FWaYU1S8zVRaZI8LKIYzIV5O+dudfbqJ+FIbxJebWx2zw2MNxKY
        3dGeKs8WZTU23WWFVdmqukjz2MsU7IEA8arARlu+eXEKMEVmAbEq5GThfLkfYrBEA3a/MJU+XV/pE
        Qa/Tk4KikIq9E5jB/ovphAxTOEtzPIGgQdrlI7v0jInqK5FXJjZ0BxyhO0eQaMWRaDlLrMxhNqj1A
        9dZfcwuXJ5328CaV4cUNJ+orL+PVRuEFCWcOGvQYr9VTwA93a71kHWF+KJ+v8IUaPqAhFR4OCu0Jb
        CF2iOc8w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oGh69-002wOq-Ig; Wed, 27 Jul 2022 13:29:13 +0000
Date:   Wed, 27 Jul 2022 14:29:13 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yongqiang Liu <liuyongqiang13@huawei.com>
Cc:     dhowells@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, zhangxiaoxu5@huawei.com,
        yanaijie@huawei.com, vbabka@suse.cz, wangkefeng.wang@huawei.com
Subject: Re: [PATCH] mm/folio-compact: fix potential NULL pointer in
 pagecache_get_page
Message-ID: <YuE9qcUs9NxB14Bh@casper.infradead.org>
References: <20220727064621.534528-1-liuyongqiang13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727064621.534528-1-liuyongqiang13@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 06:46:21AM +0000, Yongqiang Liu wrote:
> When __filemap_get_folio() failed and returned NULL, we would
> get a NULL pointer dereference in pagecache_get_page.

No we wouldn't.

