Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5683B512126
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbiD0SQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 14:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiD0SQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 14:16:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C5638BB
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 11:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S3JuW/SM98WH2rFrFeqGk8MdEjJ3XU4x3GX4vPeS2bI=; b=WWryCU6reEJAjmZsxdPsnMqlqJ
        pIzLPwOF97Vd080BBhRV7WaV8DJyeeMNpaSJ68OPAM35wOsmPa8F4Y/EBBygrF71JRn8wqptTPM/N
        3F+HgB51lidwodYeX2YHiNoWArzFEtZVmnzA30rQ5ASahwmBHxmEorL6Dv8EqszgBKbaAutohBOum
        aBBdRoqGmymEK7lD0SEqcXUz/842aLs2uJedrbXvAXdYe7jfonV7n1qx0vtxe/CWzRxvwLFCw0p+1
        VclzLATezRkvhof54tplPeojouC8Zf2R5ezsd66nK4EuU/48LKZk/9tVMx3AgE6SVIg4rAQs/O2UM
        c+V6GrTA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1njm9q-00AmQj-7t; Wed, 27 Apr 2022 18:12:58 +0000
Date:   Wed, 27 Apr 2022 19:12:58 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH v8 00/70] Introducing the Maple Tree
Message-ID: <YmmHqlR6lV84KDrO@casper.infradead.org>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
 <20220426130857.09f40743b42b5f0bf4f19a59@linux-foundation.org>
 <20220427140832.mpvnnkkhrbupk46i@revolver>
 <20220427103331.9876ad87626af0f50e9ced0d@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427103331.9876ad87626af0f50e9ced0d@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 10:33:31AM -0700, Andrew Morton wrote:
> On Wed, 27 Apr 2022 14:08:39 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:
> > The benchmarks are around the same as they have always been.
> 
> So it's presently a wash.
> 
> That makes "the plan" (below) really critical, otherwise there seems
> little point in merging this code at this time?
> 
> Please send me many very soothing words about how confident we should
> be that the plan will be implemented and that it shall be good?

Yes, performance-wise it's a wash.  However, Davidlohr was very
impressed that it was a wash because we're actually getting rid of three
data structures here; the linked list, the rbtree and the vmacache.
His opinion was that we should push the maple tree in now, in advance
of the future RCU uses.

We also have other users waiting in the wings.  Dave Howells has something
he's working on that uses the maple tree directly.  I have a couple of
XArray users that are using it inappropriately that I want to convert
... I just didn't want to do that work before all this lands.

The current LSFMM schedule has very many words about the Maple tree
scheduled for 13:30-15:00 on Monday.  Hopefully we'll have a better idea
after that how confident we are that RCU VMA walking is going to work.
