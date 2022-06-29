Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C822B55F287
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 02:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiF2Axo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 20:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiF2Axl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 20:53:41 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7943326F0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 17:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656464020; x=1688000020;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3vkw3zESbKa0B1riqVX7U9aJn8b2eWkzoJatn5u26Kw=;
  b=nA5isbSzTMkULBR1K+4Y2yNUxY6qMDQRa9UOMoDmUTMEjOVefnLHLCyQ
   UU+7eGxH94TlJzE/LNIKTqKX9GaPHHuGQdPgc9Zf7XpUldtc3a67cH86a
   8W5ulb/b37i9oOpNMWCBLyOpct2rSTmCcRaoQcnkX6PrHH4P9a9annVUJ
   wByPrCZvtdk30cJpknRrclyjsjKwDHclz2RqBA03/STBlRdclfpzMx+Vg
   0oGPQ4KphYzaJiz9WCQqxL1uOvsnPaBRaxthKuQPFIDX80Pt7DqtDygZ1
   5m7v/bR4VM+ZpTnO0NyS0B6swrs/On6UVUB1L8X95XpHBac6GBjv3PWo7
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="264926578"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="264926578"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 17:53:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="590501711"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 28 Jun 2022 17:53:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id A9E8FCE; Wed, 29 Jun 2022 03:53:42 +0300 (EEST)
Date:   Wed, 29 Jun 2022 03:53:42 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 6/8] x86/mm: Provide ARCH_GET_UNTAG_MASK and
 ARCH_ENABLE_TAGGED_ADDR
Message-ID: <20220629005342.3thjt26e6p6znyrh@black.fi.intel.com>
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
 <20220610143527.22974-7-kirill.shutemov@linux.intel.com>
 <6cb17661-9436-afbf-38eb-58565bba1a56@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cb17661-9436-afbf-38eb-58565bba1a56@kernel.org>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 04:42:40PM -0700, Andy Lutomirski wrote:
> On 6/10/22 07:35, Kirill A. Shutemov wrote:
> 
> > +	/* Update CR3 to get LAM active */
> > +	switch_mm(current->mm, current->mm, current);
> 
> Can you at least justify this oddity?  When changing an LDT, we use a
> dedicated mechanism.  Is there a significant benefit to abusing switch_mm
> for this?

I'm not sure I follow. LAM mode is set in CR3. switch_mm() has to handle
it anyway to context switch. Why do you consider it abuse?

> 
> Also, why can't we enable LAM on a multithreaded process?  We can change an
> LDT, and the code isn't even particularly complicated.

I reworked this in v4[1] and it allows multithreaded processes. Have you
got that version?

Intel had issue with mail server, but I assumed it didn't affect my
patchset since I see it in the archive.

[1] https://lore.kernel.org/all/20220622162230.83474-1-kirill.shutemov@linux.intel.com/

-- 
 Kirill A. Shutemov
