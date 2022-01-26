Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9CF49C177
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 03:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236655AbiAZCvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 21:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236514AbiAZCvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 21:51:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64015C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 18:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=86XwsEqiHWcpAKS+1w66D4BvB/zNvs89vkaCBpH8v1A=; b=WVIaPz8PNke5qT2GHlggxTERIt
        1gByfyYpDfCQf3V4cJwM8jJX1yZjxR7A5zbsBQgSgJA5GOtlRgQpLiqkAG87yRkPSdMt/Hb7X+biu
        1CNLDxWXRd/rkXeiZrkTquDHB6Z7vn7QwjiQ8TVckrWw8oSvmtZ+P7f2pT+9il3b010BOL9pXMyGN
        cfsxfsq2hvoFGT2KOkRv4FYjhfEUHyyg5YX2WbTtVHY197jxgs77IvBxmpZds6dst8x7n+OEa6sG4
        Leb1KP/pny3DOZid1GUF9FEp+yFHOcXK9hyuGMVBjp7dDDtC2QvNL3403LwMcbxSdBqhtIpvrukkd
        ocKpgIkA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCYOZ-003di7-Ho; Wed, 26 Jan 2022 02:50:51 +0000
Date:   Wed, 26 Jan 2022 02:50:51 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] vmap(): don't allow invalid pages
Message-ID: <YfC3C5MiyKzSX4Sg@casper.infradead.org>
References: <20220118235244.540103-1-yury.norov@gmail.com>
 <f85b3cac-29e7-4179-e078-fd859040c294@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f85b3cac-29e7-4179-e078-fd859040c294@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 01:28:14PM +0000, Robin Murphy wrote:
> Is it page_to_pfn() guaranteed to work without blowing up if page is invalid
> in the first place? Looking at the CONFIG_SPARSEMEM case I'm not sure that's
> true...

Something that all the ARM people weighing in on this don't understand
is that basically nobody uses SPARSEMEM without SPARSEMEM_VMEMMAP.
So all this complicated code to do page_to_pfn() is never tested.
Real users all do a simple subtraction and so the simple pfn_valid()
works fine.
