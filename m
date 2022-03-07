Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045D54CEF51
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 03:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbiCGCIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 21:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234655AbiCGCIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 21:08:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C994346173
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 18:07:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 601426113A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 02:07:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B7EC340F4;
        Mon,  7 Mar 2022 02:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1646618839;
        bh=g1fJSX9Cmuv2g99r8W9WjGpWbQ+zv1aV+eLD6MGxv2w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zRHwIOIkLEgIJb0HtWRfGTeVkU9O4OG+S5EHmezaw9n/duO53j4Nk2NHGCluHFhUr
         pN24JAzMfYgN4d6pZx7o1ExTzTsgTkinyv6FxcXVlYC5k2IxyaOG6m2ZAxg8BBVQlH
         Gqt7jEZfLsujBNigIJxram5MZMJuw6LaJzTSEJiQ=
Date:   Sun, 6 Mar 2022 18:07:18 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Yang Shi <shy828301@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] mm: thp: don't have to lock page anymore when splitting
 PMD
Message-Id: <20220306180718.6d4e6233130b94fdad98df88@linux-foundation.org>
In-Reply-To: <13ad4ba1-2a88-9459-3995-70af36aba33e@redhat.com>
References: <20220303222014.517033-1-shy828301@gmail.com>
        <CADFyXm6W9CVkO4XPYep-tHg55c8m8NES783kcVYrdjSMbzYoDA@mail.gmail.com>
        <CAHbLzkriyBy2HqjssurLSnhoyuUzpJRZjMPNx34MTgxeO0dddg@mail.gmail.com>
        <13ad4ba1-2a88-9459-3995-70af36aba33e@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Mar 2022 19:50:08 +0100 David Hildenbrand <david@redhat.com> wrote:

> @Andrew, the last mail I received was
> 
> + mm-huge_memory-remove-stale-locking-logic-from-__split_huge_pmd.patch
> added to -mm tree
> 
> The patch shows up in mmotm as
> 
> #[merged]mm-huge_memory-remove-stale-locking-logic-from-__split_huge_pmd.patch
> 
> ... which shouldn't be true.

I guess I mislabelled the reason for dropping it.  Should have been to-be-updated, 
due to https://lkml.kernel.org/r/CAHbLzkpbnQyHRckoRtbZoaLvANu92MY4kEsbKudaQ8MDUA3nVg@mail.gmail.com
