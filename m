Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50BDC524F73
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355022AbiELOHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354732AbiELOHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:07:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A0D35DCB
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9py6ogGa9oM8eFz+r/oJ/gtHX4WV1rBXNn56XWgDhJo=; b=g3/9RZGpqQT7hqtylUfNmBua4h
        npUP84ab6kqiLc+k1Ydo7u75/73h9GflPgoI3VkeczSc0mDGWDqpRl+PhLvM8kg/TKY8p+Dmg9+UJ
        CHMFo0A18xag9YhjdRI6CR7an5D6mc5yAkL4LaIFsHdkAjX/KXgOlL4O5nJZOQpsiHXOoLi2d04dy
        YvWLOUtY5gzzf4d4LK/PGwVBPFi7KVttAo0JTdGlZKzP0vymaIrUs+RNjqVfM0vby3RYXipjNAA0I
        iBh0rFa7Ks9ZHEliknjtMg1WP+MFijg4jmaODnJfWz8JlVo3OzwKjEoYJZ9FEQSe11EF67rHeOLfi
        rLk2+u5g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1np9TN-006SMQ-Hk; Thu, 12 May 2022 14:07:21 +0000
Date:   Thu, 12 May 2022 15:07:21 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     "'Kirill A. Shutemov'" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: Implement Linear Address Masking support
Message-ID: <Yn0UmdTOdceX1g05@casper.infradead.org>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511022751.65540-2-kirill.shutemov@linux.intel.com>
 <fc54d360620d436f93785ae5e9f8a23f@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc54d360620d436f93785ae5e9f8a23f@AcuMS.aculab.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 01:01:07PM +0000, David Laight wrote:
> > +static inline int64_t sign_extend64(uint64_t value, int index)
> > +{
> > +    int shift = 63 - index;
> > +    return (int64_t)(value << shift) >> shift;
> > +}
> 
> Shift of signed integers are UB.

Citation needed.
