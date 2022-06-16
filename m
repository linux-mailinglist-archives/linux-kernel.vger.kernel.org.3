Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4025754E76E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 18:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbiFPQkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 12:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234013AbiFPQkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:40:12 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB4B2F656
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 09:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655397612; x=1686933612;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zpf+cLESJs+0bL1uH7tlT88U+YZ+F1ZKAMxJkuxX+8I=;
  b=XQHtEGbnwgYbWYLLz9SJqolzsweVZ5MJDSRo7i0e5gH+kJdjuCKRXgzJ
   ef41CpFmJLlOyXp0+buz2KG36X9iNbIeonANXnio5JaM2HR14PcG1v2qm
   4S+xpYhMhvsl76yQKlUSC9F4/4nJCWac0mvVvyYjJoU1Tj1YNHKfGKvH6
   L1BKRQQytwmGPD41NPTNJkiqOrapDcSqbRIrr4XKKvdibR4v/oj9g2aXK
   3x9x/LK+hdu6KRRVpEJHBTAC934zSygfCYgsOe0cS0mWGJJnfkOqUkpp7
   cWHZomBdO1TilHSUa95SpbuvWPoivjiwJvrWYwQlMqDmleawD9LSaHioW
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="262311358"
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="262311358"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 09:40:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="618944426"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 16 Jun 2022 09:40:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 60B38109; Thu, 16 Jun 2022 19:40:12 +0300 (EEST)
Date:   Thu, 16 Jun 2022 19:40:12 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, namit@vmware.com
Subject: Re: [PATCHv3 4/8] x86/mm: Handle LAM on context switch
Message-ID: <20220616164012.uuok46yozncbwe7u@black.fi.intel.com>
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
 <20220610143527.22974-5-kirill.shutemov@linux.intel.com>
 <Yqry9+efzp6lml89@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yqry9+efzp6lml89@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 11:08:07AM +0200, Peter Zijlstra wrote:
> Either use that one spare byte, or find room elsewhere I suppose.

Okay, I will put into the byte after invalidate_other and modify
tlbstate_lam_cr3_mask() and set_tlbstate_lam_cr3_mask() to shift it
accordingly.

It looks like this:

struct tlb_state {
	struct mm_struct *         loaded_mm;            /*     0     8 */
	union {
		struct mm_struct * last_user_mm;         /*     8     8 */
		unsigned long      last_user_mm_spec;    /*     8     8 */
	};                                               /*     8     8 */
	union {
		struct mm_struct *         last_user_mm;         /*     0     8 */
		unsigned long              last_user_mm_spec;    /*     0     8 */
	};

	u16                        loaded_mm_asid;       /*    16     2 */
	u16                        next_asid;            /*    18     2 */
	bool                       invalidate_other;     /*    20     1 */
	u8                         lam;                  /*    21     1 */
	unsigned short             user_pcid_flush_mask; /*    22     2 */
	unsigned long              cr4;                  /*    24     8 */
	struct tlb_context         ctxs[6];              /*    32    96 */

	/* size: 128, cachelines: 2, members: 9 */
};

-- 
 Kirill A. Shutemov
