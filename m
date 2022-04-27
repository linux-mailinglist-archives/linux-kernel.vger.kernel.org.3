Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4AF512268
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234475AbiD0TUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234188AbiD0TUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:20:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED16E5AEDD
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 12:15:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50FA1B82929
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 19:15:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D277C385A9;
        Wed, 27 Apr 2022 19:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1651086918;
        bh=ioNGbfdFnBHpiC6gJveMVVb84weNz19R76deS5tr4gY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WgVtHpW4eLTcD7YwN7pDond0akwklFUSGgPBXxARAR7WYj1Za/q9kaBrIrOpFtE+p
         7Uqz1e6BGP8KVfERJSOUTP6qd+eK3GLuJGS9njCwJc3aXabG6uMl9BxcDEZCs2XClO
         dBEtEHlGzKDEyd84nLk+D+g936jkXLT5Yya6Pzp0=
Date:   Wed, 27 Apr 2022 12:15:17 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/hwpoison: use pr_err() instead of dump_page() in
 get_any_page()
Message-Id: <20220427121517.a9515a17697424604f8fbcf0@linux-foundation.org>
In-Reply-To: <20220427053220.719866-1-naoya.horiguchi@linux.dev>
References: <20220427053220.719866-1-naoya.horiguchi@linux.dev>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Apr 2022 14:32:20 +0900 Naoya Horiguchi <naoya.horiguchi@linux.dev> wrote:

> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> The following VM_BUG_ON_FOLIO() is triggered when memory error event
> happens on the (thp/folio) pages which are about to be freed:
> 
> ...
>
> Fixes: 74e8ee4708a8 ("mm: Turn head_compound_mapcount() into folio_entire_mapcount()")

I added cc:stable to this, OK?


