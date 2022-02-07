Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D092A4AC100
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 15:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391089AbiBGOTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 09:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381876AbiBGOL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 09:11:59 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFC8C0401C3;
        Mon,  7 Feb 2022 06:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sDZcTdthLVK7szlPjHCIXwYM3fqcQ0lcfaos24QABmA=; b=LvNO9O05ToAroojyVi6aHCQaRS
        dC7qLtE2VC8YDQdSfZ9POLjxHBaCIWSlqe/ZfgIjZJy84PnuCYfSXutlvg1b5R+uZ2u/hlr+4hvqF
        5GhHNaKH5r+QPhn1paF71BWfbHkFNIhxwVKP/SEiTPbMYChP0JLSaHAEtsBeB+KSEI/YBGkGCKybX
        HwvQoIsYPX6hbjg1hVG2dmMT8NEPIrYQXzQe7zXhXfMnoGquHQJ6eYe/99epJBP8Bp7so5C3VOacM
        B9bfg4hn5jUkmrmdseQMKaHH4g3h24RjAIlfuFscgxxq7N18A/mZ0vmAxGNT2C4JWmUOp9zXHE1GP
        ptE9TbcA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nH4jy-007mzB-Gg; Mon, 07 Feb 2022 14:11:38 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9378E986235; Mon,  7 Feb 2022 15:11:36 +0100 (CET)
Date:   Mon, 7 Feb 2022 15:11:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zhipeng Xie <xiezhipeng1@huawei.com>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix perf_mmap fail when CONFIG_PERF_USE_VMALLOC enabled
Message-ID: <20220207141136.GG23216@worktop.programming.kicks-ass.net>
References: <20220207170259.2566-1-xiezhipeng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207170259.2566-1-xiezhipeng1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Your $Subject needs a subsystem prefix.

On Mon, Feb 07, 2022 at 12:02:59PM -0500, Zhipeng Xie wrote:
> when CONFIG_PERF_USE_VMALLOC is enabled, rb->nr_pages is always
> equal to 1 in rb_alloc, causing perf_mmap return -EINVAL when mmap.
> Fix this problem using data_page_nr.

How can this be? This would mean that any arch that selects that hasn't
worked for forever ?! That seems unlikely.

> Signed-off-by: Zhipeng Xie <xiezhipeng1@huawei.com>

If this is correct; this is also missing a Fixes: tag.
