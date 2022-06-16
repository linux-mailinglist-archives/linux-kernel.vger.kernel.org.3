Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A65654EDFB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 01:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379363AbiFPXn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 19:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiFPXnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 19:43:53 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8F843393
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 16:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655423032; x=1686959032;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gvd8jlhw50cWYlW87KaSp82+5jOEFw1C0vFTcwNzk9I=;
  b=Vzw9uXPAso2hnzmLJGq/H/TAqXKf34RfuzZ1Rp9DjFPY0+l3Myhee2C3
   aVc0py3IZIZFQIztP58e2647pEjEgWrGTrrAy6vnc9R0M9P4ysz34gt2x
   aUdysVeK+ANsrl+K60zX2Ghfe6iQX8ZiBMiN080+0/T/bTxekEhdkHGTb
   AMTKSiPnPTbtTMfSqVjVrliXTFkAmKQ85XD015nFZHl5SEWD0XxyGH8RB
   BFi5PcMN+G7PFj4Rhvz7/b0usteXUCNckJmF0G+3G4eWffxMpskWQqlAr
   1rXnxp6LV9glxuMqIKAqUySFO6yZIHHZ0DjD2vjbNeP6i5+Zd1F6/GkbR
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="262398404"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="262398404"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 16:43:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="576182859"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 16 Jun 2022 16:43:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 473B5109; Fri, 17 Jun 2022 02:43:52 +0300 (EEST)
Date:   Fri, 17 Jun 2022 02:43:52 +0300
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
Subject: Re: [PATCHv3 0/8] Linear Address Masking enabling
Message-ID: <20220616234352.2h4f64a4fw46atrs@black.fi.intel.com>
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
 <fdc44a96f0734682338930aec4884d9a2b39650d.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdc44a96f0734682338930aec4884d9a2b39650d.camel@intel.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 10:52:14PM +0000, Edgecombe, Rick P wrote:
> On Fri, 2022-06-10 at 17:35 +0300, Kirill A. Shutemov wrote:
> > Linear Address Masking[1] (LAM) modifies the checking that is applied
> > to
> > 64-bit linear addresses, allowing software to use of the untranslated
> > address bits for metadata.
> > 
> > The patchset brings support for LAM for userspace addresses.
> 
> Arm has this documentation about which memory operations support being
> passed tagged pointers, and which do not:
> Documentation/arm64/tagged-address-abi.rst
> 
> Is the idea that LAM would have something similar, or exactly mirror
> the arm ABI? It seems like it is the same right now. Should the docs be
> generalized?

It is somewhat similar, but not exact. ARM TBI interface implies tag size
and placement. ARM TBI is per-thread and LAM is per-process.

-- 
 Kirill A. Shutemov
