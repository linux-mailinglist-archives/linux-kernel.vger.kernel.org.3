Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7C853DB58
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 13:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245550AbiFELtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 07:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbiFELtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 07:49:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CD220F4F
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 04:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TB+PasMPRGdy/jkWfabveRh+X4DQoZ0zEIC6kSjF58g=; b=OJtAnyg+Odw+HNIHNj67AOJ1xn
        OzdX3ktbywu3oQkhHUD2RytR1P4VAHNl4+kApnlNDsMrp3zz/qehUaPkobV0JZ1R7ENBBslHzUQYY
        wEvtfOCOG1LWOBGHLSVU5Jge9LvO/KphulBjwGqu+80JfAXVu+cg336h8Syd1x9QxvVxfxi+IJSiw
        xhVfzuZX+4Ivbp3ahcKTMuD4b4rEheQ11zLd68dB0EN7K5wWsygWP0e6OU/8Re6Lqilt6fkYC62zK
        +ED8Xwbiw5U6ou+0Udwq5O7VLOFWlPsDyETyXZJLenVSYUrFBcBK6qtf/YuhMKRXt7WVQ5ygw4M+3
        rdqsYCTQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nxol6-009eWr-OZ; Sun, 05 Jun 2022 11:49:28 +0000
Date:   Sun, 5 Jun 2022 12:49:28 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Chen Wandun <chenwandun@huawei.com>
Cc:     hughd@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, david@redhat.com,
        wangkefeng.wang@huawei.com
Subject: Re: [PATCH v2 1/3] mm/shmem: check return value of
 shmem_init_inodecache
Message-ID: <YpyYSFjTQQQ/p4bM@casper.infradead.org>
References: <20220605035557.3957759-1-chenwandun@huawei.com>
 <20220605035557.3957759-2-chenwandun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220605035557.3957759-2-chenwandun@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 05, 2022 at 11:55:55AM +0800, Chen Wandun wrote:
> It will result in null pointer access if shmem_init_inodecache fail,
> so check return value of shmem_init_inodecache

You ignored my suggestion from v1.  Here, let me write it out for you.

+static int shmem_init_inodecache(void)
 {
  	shmem_inode_cachep = kmem_cache_create("shmem_inode_cache",
  				sizeof(struct shmem_inode_info),
  				0, SLAB_PANIC|SLAB_ACCOUNT, shmem_init_inode);
+	if (!shmem_inode_cachep)
+		return -ENOMEM;
+	return 0;
 }

...

+	error = shmem_init_inodecache();
+	if (error)
+		goto out2;

