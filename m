Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132365A9E80
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbiIARy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbiIARyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:54:50 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99CC21837
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662054304; x=1693590304;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/59lUBPazWehnHqG6Yhvtz5YTUoyACoFaPW03K4rfaA=;
  b=LGr/A96zmRPOjV3DZinoW+yDvub3agj0kLKUNNCbAtVaQTEFc5d/iZD1
   M6iO6ggeCUQ+PcX5YI119XeealMLprPWFxH06E8okVfH1CoK5GrAjwcUi
   9GKUpB2s10KzD7e9pVeRG3sUViLFgQAxfyuCUsp84HWC/TLse00/MSAsZ
   qtFDnQee3E0cl1937xG2hQM4OfEiRRyexOOivTb9PEhoCYd0fP1Ncs1Da
   IaohzE9jFWGefq9iHVLauTtZ+QgZz2MrwPv0vvmzmge5Ox8jcLsyWf/HU
   eL8Elgu1IGcbzz17W9Uk52plwqhOTs4MYeuScytRyb7ycr7o52GdnIqRA
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="282767539"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="282767539"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 10:45:02 -0700
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="680961760"
Received: from araj-dh-work.jf.intel.com (HELO araj-dh-work) ([10.165.157.158])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 10:45:02 -0700
Date:   Thu, 1 Sep 2022 17:45:08 +0000
From:   Ashok Raj <ashok_raj@linux.intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jacon Jun Pan <jacob.jun.pan@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCHv8 00/11] Linear Address Masking enabling
Message-ID: <YxDvpLb77lwb8zaT@araj-dh-work>
References: <20220830010104.1282-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830010104.1282-1-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kirill,

On Tue, Aug 30, 2022 at 04:00:53AM +0300, Kirill A. Shutemov wrote:
> Linear Address Masking[1] (LAM) modifies the checking that is applied to
> 64-bit linear addresses, allowing software to use of the untranslated
> address bits for metadata.

We discussed this internally, but didn't bubble up here.

Given that we are working on enabling Shared Virtual Addressing (SVA)
within the IOMMU. This permits user to share VA directly with the device,
and the device can participate even in fixing page-faults and such.

IOMMU enforces canonical addressing, since we are hijacking the top order
bits for meta-data, it will fail sanity check and we would return a failure
back to device on any page-faults from device. 

It also complicates how device TLB and ATS work, and needs some major
improvements to detect device capability to accept tagged pointers, adjust
the devtlb to act accordingly. 


Both are orthogonal features, but there is an intersection of both
that are fundamentally incompatible.

Its even more important, since an application might be using SVA under the
cover provided by some library that's used without their knowledge.

The path would be:

1. Ensure both LAM and SVM are incompatible by design, without major
   changes.
   	- If LAM is enabled already and later SVM enabling is requested by
	  user, that should fail. and Vice versa.
	- Provide an API to user to ask for opt-out. Now they know they
	  must sanitize the pointers before sending to device, or the
	  working set is already isolated and needs no work.
2. I suppose for any syscalls that take tagged pointers you would maybe
   relax checks for how many bits to ignore for canonicallity. This is
   required so user don't need to do the same for everything sanitization
   before every syscall. 

If you have it fail, the library might choose a less optimal path if one is
available.

Cheers,
Ashok
