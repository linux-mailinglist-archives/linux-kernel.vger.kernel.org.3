Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D1954E825
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 18:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbiFPQyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 12:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbiFPQyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:54:13 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B436E286C3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 09:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655398452; x=1686934452;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lqAjFaMd+IIDWYQLfoAerUJeGKE/DpmPQXkgkytknlI=;
  b=PZvwur7Mokw5xBEZqD8vuabSu6BhDXxm9d7SXL3DTWfbjxx0kqdN5DqV
   FQajdO1vDMgfS8esRxWZCbgXXC0nbsRRlx4Xvh3tv4mYgHyvhjF40dpuE
   KIv4LzOlswnAjwrEou0uF0BjWYm2KgEYtKBi3d1KJN6QXvPaaJjhzdsg5
   ljjn+VvOe4OWGT9m5RWwFM9qq0BFOrmtXLv1M3wID/B6QghPEUpl+lGy9
   P0GYimOSBTt8VuRfToQZZMyuTuZsOeB/aKDcEhQi07whWHS0InGi2cVx+
   GvWMGNCi2SmhBTEk7Z1SynOufNG+vipXHCYHopJv6rWcRM0gnJGt7jbGC
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="365646631"
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="365646631"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 09:54:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="912238632"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 16 Jun 2022 09:54:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 95605109; Thu, 16 Jun 2022 19:54:13 +0300 (EEST)
Date:   Thu, 16 Jun 2022 19:54:13 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "kcc@google.com" <kcc@google.com>, Andi Kleen <ak@linux.intel.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
        "glider@google.com" <glider@google.com>
Subject: Re: [PATCHv3 6/8] x86/mm: Provide ARCH_GET_UNTAG_MASK and
 ARCH_ENABLE_TAGGED_ADDR
Message-ID: <20220616165413.c35yliaxbxvmwsqw@black.fi.intel.com>
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
 <20220610143527.22974-7-kirill.shutemov@linux.intel.com>
 <c3b4f3ccf8ee547a588bf8a971064e4d62b6a44c.camel@intel.com>
 <20220610180635.l44opq2votd3gxpl@black.fi.intel.com>
 <5b56c88e477d879e5a0e3c15627cb05901a812f4.camel@intel.com>
 <dda083610d4c8b8d8d0b09021345e9cc0cb35bbe.camel@intel.com>
 <5d3b281f-3d8b-4bbd-9681-b226810c3e8b@www.fastmail.com>
 <Yqr7mzvX1+hWM8NL@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yqr7mzvX1+hWM8NL@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 11:44:59AM +0200, Peter Zijlstra wrote:
> > get_nr_threads() is the wrong thing.  Either look at mm->mm_users or
> > find a way to get rid of this restriction entirely.
> 
> mm->mm_users should indeed be sufficient here.

Hm. kthread_use_mm() doesn't bump mm_users. Do we care?

-- 
 Kirill A. Shutemov
