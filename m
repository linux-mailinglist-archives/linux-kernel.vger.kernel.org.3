Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7E4494EFE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 14:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237048AbiATN2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 08:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235902AbiATN2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 08:28:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5B5C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 05:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=weO+je4/1y+8GovrROQPY/ynyjtD2DcyE7cAMMlyB1Q=; b=u7ni/XvdlWLw11IVs5pMAj+vjZ
        PMeJ/hybbB1riIYjy6i1kSRg08W1NeyRrNgMzFVT9JEfzWAf/lPSz3iR9R9k2ytEuQFC/Pmoeu/CL
        Mc3WRRZq0+p7PoSqdGSVEcgeWYgPAyhpUCbAhv7GRBOsa4Ucd/Q10tZBgpjhz+oiPexmDQfwetggi
        1pBhidvz9OAvBST9pjcJ7zlBrIg5e33hEAJeooj+rVlqNi1+zfYpTPz6aqMeNxbyKanJPfi2e962K
        lbD0k6F3iByeSUqvhEE5InF4X8Ps8sOy3/+lSxKK6dujAnKGWGVOtT+ZJ9e0Z1hqBDLTRXSuzILyN
        GFrMy84g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nAXTa-00EHn0-Vb; Thu, 20 Jan 2022 13:27:43 +0000
Date:   Thu, 20 Jan 2022 13:27:42 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     alexs@kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Yu Zhao <yuzhao@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/5] mm: remove page_is_file_lru function
Message-ID: <YeljTuECoPfKn6VW@casper.infradead.org>
References: <20220120131024.502877-1-alexs@kernel.org>
 <20220120131024.502877-2-alexs@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120131024.502877-2-alexs@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 09:10:20PM +0800, alexs@kernel.org wrote:
> From: Alex Shi <alexs@kernel.org>
> 
> This function could be full replaced by folio_is_file_lru, so no reason
> to keep a duplicate function.

This is not a helpful way to do this kind of replacement.

Instead of choosing a function to remove and doing a blind replacement,
choose a call site and convert the whole calling function to use folios.
Once you've removed all callers, you can remove the wrapper function.

Also, a number of changes here will conflict with patches I've already
posted.  Try doing change_pte_range() in mprotect.c to get a feel for
how to convert a function entirely to folios.
