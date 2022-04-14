Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96EDB501D98
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 23:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241479AbiDNVnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 17:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346303AbiDNVm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 17:42:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4046D3BD;
        Thu, 14 Apr 2022 14:40:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E944262057;
        Thu, 14 Apr 2022 21:40:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED77C385A1;
        Thu, 14 Apr 2022 21:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649972402;
        bh=jDhzXENpNbP/MiBdGm0JpBRVv9ehD6kcIrzqj40Dt0k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZnnAQ5oe6wEw7GrBpdTWtB7yLXnthd71LhoQgGS5KIFYaxXLmXj+sAFr7xc8BYtVS
         X9H6GuGW5fHb1Gy6mg4m1e2SJMYw2BcwLIwYMZ09bzshKY7ey49n6kZi+08fJvKpWQ
         HYOk0gWH0Ca+b14n3Jcj6ROoVBHCcfdJeY8kCKgs=
Date:   Thu, 14 Apr 2022 14:39:59 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Barry Song <21cnbao@gmail.com>,
        Stephen Rothwell <sfr@rothwell.id.au>,
        Linux-MM <linux-mm@kvack.org>, Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        x86 <x86@kernel.org>, Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        Holger =?ISO-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [PATCH v10 06/14] mm: multi-gen LRU: minimal implementation
Message-Id: <20220414143959.0daf4534613f2511b9b27f11@linux-foundation.org>
In-Reply-To: <YliFs3NOHeo2LeXl@google.com>
References: <20220407031525.2368067-1-yuzhao@google.com>
        <20220407031525.2368067-7-yuzhao@google.com>
        <CAGsJ_4xqm4L4E4dW4PPHos8Ed9ej6hph28tSGy21Re3u7WiuOA@mail.gmail.com>
        <YliFs3NOHeo2LeXl@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Apr 2022 14:36:03 -0600 Yu Zhao <yuzhao@google.com> wrote:

> > or it is only something
> > meaningful for the internal code?
> 
> This is how swappiness is interpreted.
> 
> > if so, can we rename it to
> > something else? otherwise, it is quite confusing.
> 
> Feel free to suggest something.

It is confusing,   swap_preference?


