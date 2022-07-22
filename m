Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4438F57E3D5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 17:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235285AbiGVPiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 11:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiGVPiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 11:38:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791D213E11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 08:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mPAaLzKrMkLU/j896UlfyBtfiHZAkgGnP04Whg2NtOg=; b=l4osDtjE0GmEvzuUlYNsmG/MI5
        tetjI/Dgh0iTmOZvSOSuQjMxiiGldA/ZpitljGNfD2qq0d9TK0eJt6cr7a0olSjXxG+Fgus2gnWp3
        p9x8xY89IuJkW7/G1igBgvf3WdNj7XM1ykqsQeXKWJfrDa7puF6m8ZEN/3lcskhJwIqYm1PCZ9YvH
        mZw+TCnmhCsI+QEOVBpFcCkYDlscHS6znPQcp/yLjGJeuVGI/JIhsgFUZLnaFvDjye4+BdA4u2CiA
        0YOSU6D9w6YnacN/tY5sxYR0+pDAcvnX/b5rA+8J2L8y9a/g2QdqOYFePbVphGgyQ2B8IWZnp99ap
        gADC30uQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEuj6-00GPvC-Mg; Fri, 22 Jul 2022 15:38:04 +0000
Date:   Fri, 22 Jul 2022 16:38:04 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kassey Li <quic_yingangl@quicinc.com>
Cc:     akpm@linux-foundation.org, minchan@kernel.org,
        iamjoonsoo.kim@lge.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm/page_owner.c: allow page_owner with given
 start_pfn/count
Message-ID: <YtrEXB6o+VROImdg@casper.infradead.org>
References: <20220722150810.27740-1-quic_yingangl@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722150810.27740-1-quic_yingangl@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 11:08:10PM +0800, Kassey Li wrote:
> by default, page_owner iterates all page from min_low_pfn to
> max_pfn, this cost too much time if we want an alternative pfn range.
> 
> with this patch it allows user to set pfn range to dump the page_onwer.

This is a really bad UI.  If two users try to do different ranges at the
same time, it'll go wrong.  What use cases are you actually trying to
solve?
