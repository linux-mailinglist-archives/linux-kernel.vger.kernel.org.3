Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1B058D926
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 15:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243624AbiHINNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 09:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239452AbiHINNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 09:13:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63E064D4
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 06:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=q2RSgELMo1Ec3TTObFleMRZb2/wEYG1v3Jr0N/Jwx3Q=; b=qiIJEt6IZqRo5U94VIXuVd9L77
        1/PjSLsC0v/7ilcDLKA2HpZDPlUoib0PfEDrolR5NA6LCxggiScqWULw/eNEj3CktIqGwR8l0PCPn
        qGLR5dU43ch5NOoIGAW41yTNEFfjxZjbdyhOapkTLQ5rYpvayJnAXeVDUIkyVufl9YsIITqyRpWGl
        xtWb6vQBQhtqjsjDaCT4TC0fVb4gO28jW+lbi8FgHFdYi8LdQDIqRPT8SDtWgoUv87jlrPDHLJVXe
        Yp/mrhiCUrL2g82BPh5aHtYjgKqER/pljA1jTvCYeyZXtdI1t8KjfRTFcUt+7C/Y5fK4EzRgjKEqt
        COCta4BQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oLP2y-00FMhJ-FR; Tue, 09 Aug 2022 13:13:24 +0000
Date:   Tue, 9 Aug 2022 14:13:24 +0100
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
Subject: Re: [PATCH v3 1/2] mm/gup.c: Don't pass gup_flags to
 check_and_migrate_movable_pages()
Message-ID: <YvJddHPZsh7Lwzps@casper.infradead.org>
References: <487960bf67c7273ff5606c76f73bb51271bc7b90.1660003800.git-series.apopple@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <487960bf67c7273ff5606c76f73bb51271bc7b90.1660003800.git-series.apopple@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2022 at 10:16:25AM +1000, Alistair Popple wrote:
> +			get_page(&folio->page);
> +			unpin_user_page(&folio->page);

			folio_get(folio);
			gup_put_folio(folio, 1, FOLL_PIN);

