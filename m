Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFFC759111E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 14:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238846AbiHLM6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 08:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbiHLM6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 08:58:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE79CA2853
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 05:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4am81UbSMZH1z8CTcN1Do4Z0EoGjAhBQWlLof5f4rsI=; b=sna6yP4K/nEENbmAk6Wvn0FnIF
        uwcXbnkaq1A9QPfcxWFLMqeYWNVpEJPWXlEsFgNzYFSjhNCo8n0fN+qHGG46U2ARiJTse6oJFJxYP
        esEHB+ODI+vXhcc3eVUlaE96LTLiRowMHe/Cv+yVQIVwBDV8i+XbcC3q6Cqt1fBZdYzf4nfBgcl1K
        QkBDWU5R0toO9dPNVEfwmr49Ac9XGljkm5R/xWpNTM1W+SR3Jw1y3QIyp6ZDVWTuIzSSVPYvK1b7c
        cNogU5orL9r5Y47xnEeQoPhdsqON+TRHnGTST6IslICRWoTZi8rbMSGC6FBrOtHbNb9CXnEnXFZ3Z
        CFwUWoHQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oMUET-0029Qg-Sb; Fri, 12 Aug 2022 12:57:46 +0000
Date:   Fri, 12 Aug 2022 13:57:45 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4 1/2] mm/gup.c: Don't pass gup_flags to
 check_and_migrate_movable_pages()
Message-ID: <YvZOSUrXoeYnuCyg@casper.infradead.org>
References: <487960bf67c7273ff5606c76f73bb51271bc7b90.1660269441.git-series.apopple@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <487960bf67c7273ff5606c76f73bb51271bc7b90.1660269441.git-series.apopple@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2022 at 12:13:08PM +1000, Alistair Popple wrote:
> +			get_page(&folio->page);
> +			unpin_user_page(&folio->page);

https://lore.kernel.org/linux-mm/YvJddHPZsh7Lwzps@casper.infradead.org/
