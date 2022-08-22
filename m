Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBA659C43E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 18:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237092AbiHVQfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 12:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237072AbiHVQfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 12:35:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B06402DA
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 09:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=domgJmoasu517o7hiFT4zNTeyrBIkqaCSkQfvyZKNLU=; b=Tw6p8M7RyStV6wNAy4O/dgD1py
        vI8mWyvL8CibdIqBsMEyXMNElgEzEZzixMUTD1yqPToWVT4My1huMvirgeF4lJUU5e/ZYxIxjGSY0
        GY6xPkvT9xuSeg8W5uVzCTaadKsGTBBjILbTTk/LauSnfKVHgnmyNAiYQJn6iWdHI/iQ7LHyq9rzH
        JpHZsX94o3vxhZqy4sBuGG29P/OBozfvajJYze24by72NxUj9h0TZaZodcHTXjeNqYrDPCZpoqK/k
        0VcjMjhK5v10GI0aiBeGHcbp1nnQBO8er4IClskwoSrLFzWx7fzKY+aSGHeUyEQ0v887I1c5MdEcw
        BI9FOegg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQAO7-00EShX-Qn; Mon, 22 Aug 2022 16:34:55 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id DDD109804A3; Mon, 22 Aug 2022 18:34:53 +0200 (CEST)
Date:   Mon, 22 Aug 2022 18:34:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Linux-MM <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        X86 ML <x86@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Kernel Team <Kernel-team@fb.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>, Song Liu <song@kernel.org>
Subject: Re: [RFC 0/5] vmalloc_exec for modules and BPF programs
Message-ID: <YwOwLYUXuSn5acIG@worktop.programming.kicks-ass.net>
References: <20220818224218.2399791-1-song@kernel.org>
 <4D089469-B32B-4347-A811-B1E5EE011307@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4D089469-B32B-4347-A811-B1E5EE011307@fb.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 03:46:38PM +0000, Song Liu wrote:
> Could you please share your feedback on this? 

I've looked at it all of 5 minutes, so perhaps I've missed something.

However, I'm a little surprised you went with a second tree instead of
doing the top-down thing for data. The way you did it makes it hard to
have guard pages between text and data.
