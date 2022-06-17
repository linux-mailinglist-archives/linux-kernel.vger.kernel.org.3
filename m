Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02B454F6CF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 13:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381810AbiFQLhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 07:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380246AbiFQLhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 07:37:01 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6748F6A437
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 04:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cR4LnuVZtAt+9tGMI7j6kcQ3OFS9N17ZPUsUFSJS2hY=; b=FWg5hYegefT0O4qCxoNpGInvL1
        3CvZtxDn1NvT3GI7TrBZ889svm/ipuljeM6ZVbmrYVZsp6UrJOHU+RflM9Ph/5f7aGwIN3OXKivEf
        dISFmOCd1BsnYhFPeiiJnYCyTS27JhFM7u1Gx8b9BsijzL+VLenvdYGh0fBdCs/RJHz0xgg85qplM
        fAbui5Vc1IWuPGOupTeDaFOzZ7fxitlDI2iRc5GqxZcBBNSw1Kw2hyZ9mA+DVZSRZyUzGnWgXMxZD
        cLPKpLBMpCIyUNTgNVDtRm0cgUxJVKjGy9t7qASM0AB7uWriZjOJuP0zGQdLX2kQvRPuX/sC7sHFw
        TvNhmFtg==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o2AGw-008fkA-Ik; Fri, 17 Jun 2022 11:36:27 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0041F9816B5; Fri, 17 Jun 2022 13:36:17 +0200 (CEST)
Date:   Fri, 17 Jun 2022 13:36:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "kcc@google.com" <kcc@google.com>,
        "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
        "glider@google.com" <glider@google.com>
Subject: Re: [PATCHv3 5/8] x86/uaccess: Provide untagged_addr() and remove
 tags before address check
Message-ID: <YqxnMbMhvWO9rEy4@worktop.programming.kicks-ass.net>
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
 <20220610143527.22974-6-kirill.shutemov@linux.intel.com>
 <c7e2f8fb44da067e7565d091edeac300977b65ed.camel@intel.com>
 <Yqr4SVMyHRTkc+LN@hirez.programming.kicks-ass.net>
 <20220616164440.vw7sqnof6grrmnvl@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616164440.vw7sqnof6grrmnvl@black.fi.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 07:44:40PM +0300, Kirill A. Shutemov wrote:
> Any objection against this variant (was posted in the thread):
> 
>        	#define untagged_addr(mm, addr) ({                                      \
>                	u64 __addr = (__force u64)(addr);                               \
>                	s64 sign = (s64)__addr >> 63;                                   \
>                	__addr &= (mm)->context.untag_mask | sign;                      \
>                	(__force __typeof__(addr))__addr;                               \
>        	})
> 
> ?

Yeah, I suppose that should work fine.
