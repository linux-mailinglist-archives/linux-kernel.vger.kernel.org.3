Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF52355F27E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 02:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiF2Am5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 20:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiF2Am4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 20:42:56 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A40811A1A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 17:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656463375; x=1687999375;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=celv9RtvlunAXoqVWxMaVGo9wta5M5+aFHyYY4I6Hvw=;
  b=Zrsp8DaZmnTSbpRXV5IxUqVkW7JBrYCWK0598H7LWzjV2PnPgIGRiktl
   ym4OLLXToO3aATsu90fvqGTq/ktnnxkeglCFpm77sypItlxP9wu4BHfrn
   E1mUcGGF6SUTz0fDwbEtDZidkkSp69X9jvnwmDw2o+miNtfcpbJmLXV/4
   EbOWQRqaYhpDaTPGysqAGjK3UPk2cAGh8HyiOHnBRzE1G4Ucy5yfpj6fT
   VdQCBIBR0C8KVk73IYU2nEXXVyRu+eJaB0RWvdcaDd1IQgzEEguaSNvJO
   xmao6NIEWy4MFfIbFgdRCmRf5ETVDbzkndozGojXXanh89FkDQMGnBXNL
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="368198489"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="368198489"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 17:42:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="693344105"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 28 Jun 2022 17:42:51 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id A4CE3CE; Wed, 29 Jun 2022 03:42:57 +0300 (EEST)
Date:   Wed, 29 Jun 2022 03:42:57 +0300
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
Subject: Re: [PATCHv3 5/8] x86/uaccess: Provide untagged_addr() and remove
 tags before address check
Message-ID: <20220629004257.x3pyoydmtk2lhrnx@black.fi.intel.com>
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
 <20220610143527.22974-6-kirill.shutemov@linux.intel.com>
 <53d41f54-28ad-023c-537f-281cc2c40ae9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53d41f54-28ad-023c-537f-281cc2c40ae9@kernel.org>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 04:40:48PM -0700, Andy Lutomirski wrote:
> On 6/10/22 07:35, Kirill A. Shutemov wrote:
> > untagged_addr() is a helper used by the core-mm to strip tag bits and
> > get the address to the canonical shape. In only handles userspace
> > addresses. The untagging mask is stored in mmu_context and will be set
> > on enabling LAM for the process.
> > 
> > The tags must not be included into check whether it's okay to access the
> > userspace address.
> > 
> > Strip tags in access_ok().
> 
> What is the intended behavior for an access that spans a tag boundary?

You mean if 'addr' passed to access_ok() is below 47- or 56-bit but 'addr'
+ 'size' overflows into tags? If is not valid access and the current
implementation works correctly.

> Also, at the risk of a potentially silly question, why do we need to strip
> the tag before access_ok()?  With LAM, every valid tagged user address is
> also a valid untagged address, right?  (There is no particular need to
> enforce the actual value of TASK_SIZE_MAX on *access*, just on mmap.)
> 
> IOW, wouldn't it be sufficient, and probably better than what we have now,
> to just check that the entire range has the high bit clear?

No. We do things to addresses on kernel side beyond dereferencing them.
Like comparing addresses have to make sense. find_vma() has to find
relevant mapping and so on. 

-- 
 Kirill A. Shutemov
