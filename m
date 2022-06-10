Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C2E546C1D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 20:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347503AbiFJSEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 14:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347141AbiFJSEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 14:04:47 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E81DF5E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 11:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654884286; x=1686420286;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8eNvZWqD4YWYW659R4S17U2jKOE9xtXav0016+fJ7Ug=;
  b=U5QF+Hi9EIFZ1uPrSCZmNb/MLvGQGNknviN+ZzxT0/0m3YcrLy59UaYC
   q0j1UPE5S0111YWwfdlrAmrOTCWoOorFs/Us+q1g9ZXv7Neo9cakgVEZz
   4+Li2uhhPPqVjqSlRqeBT7Gx6dXuuKmhp/PELtGoWmOf3xzPercCmaYgc
   hfqEK8JNmT0FbJHBdiRad2wwavrOur7/0MWWbTZxkercssgw1CgoB5+5j
   ufq4I1TTpGZkW5scKuZ2PwMHJBx1I2fYyKG1BU/nmH2ZWujG4dAq1kY9w
   whRuH2ctNy342qxmnbpizNtaxFTk+YTSg+fkG/9xqFUuqhlVDltY63WaQ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="275231581"
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="275231581"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 11:04:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="760612018"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 10 Jun 2022 11:04:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id E1A0AF8; Fri, 10 Jun 2022 21:04:45 +0300 (EEST)
Date:   Fri, 10 Jun 2022 21:04:45 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "peterz@infradead.org" <peterz@infradead.org>,
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
Subject: Re: [PATCHv3 6/8] x86/mm: Provide ARCH_GET_UNTAG_MASK and
 ARCH_ENABLE_TAGGED_ADDR
Message-ID: <20220610180445.fmzgrobscwrblxud@black.fi.intel.com>
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
 <20220610143527.22974-7-kirill.shutemov@linux.intel.com>
 <eb22968d0691760f579b90cd4bf75bfc4be0edeb.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb22968d0691760f579b90cd4bf75bfc4be0edeb.camel@intel.com>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 03:25:02PM +0000, Edgecombe, Rick P wrote:
> On Fri, 2022-06-10 at 17:35 +0300, Kirill A. Shutemov wrote:
> > +static int prctl_enable_tagged_addr(unsigned long nr_bits)
> > +{
> > +       struct mm_struct *mm = current->mm;
> 
> do_arch_prctl_64() can be called via ptrace. I think you need to
> operate on the mm of 'task', or just block the operation if task !=
> current.

Hm. True. Let's see if the interface in general good enough.

Ouch. I just noticied that I missed check for LAM feature :/

-- 
 Kirill A. Shutemov
