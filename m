Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C154DCD29
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 19:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237164AbiCQSFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 14:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237100AbiCQSFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 14:05:38 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D09918FAE7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647540262; x=1679076262;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uUf5LFIzzQ0tXKBi4/9/PI02R9U0axKS3svPmT3Lxvc=;
  b=ctvb4Bu7oamwrPRru/Ompp9KIS7lRF+05bpVGi0kicVinjLdNOuUfTqn
   n2wxp3oYPN6Vv9mTnsp8Zc+cAWxwY5iKFm3p1rJbx4FZHDjQlIi8QB3Nx
   Ljljlc8AzH+AL6bHD4FS24pms3wFt6DewNc0i/p6AqOtuyjp4gfcn0mq1
   eLIaAZz7bx/JmoZNhKN6eHTCFkeddVZNQleQpwu+ZTMBbR5qkVMR1/svm
   7hHB3pZjVyjXy0x4GP8AqEAVz5FhEHsFCvbW0zXaJBdxoAjpuwjHqyZak
   1ZPN0yU//uQQK8qI8dwM7onRr+Lb/85iFWQ7QVBd2eonRzDumORMDSCR3
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="236885561"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="236885561"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 11:04:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="715136857"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 17 Mar 2022 11:04:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 868D9107; Thu, 17 Mar 2022 20:04:34 +0200 (EET)
Date:   Thu, 17 Mar 2022 21:04:34 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCHv6 12/30] x86/tdx: Detect TDX at early kernel
 decompression time
Message-ID: <20220317180434.5snbc2sni4r63nbg@black.fi.intel.com>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-13-kirill.shutemov@linux.intel.com>
 <87k0cs23oy.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0cs23oy.ffs@tglx>
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 12:55:57PM +0100, Thomas Gleixner wrote:
> On Wed, Mar 16 2022 at 05:08, Kirill A. Shutemov wrote:
> > +
> > +#include <asm/shared/tdx.h>
> > +
> > +static bool tdx_guest_detected;
> > +
> > +bool early_is_tdx_guest(void)
> > +{
> > +	return tdx_guest_detected;
> > +}
> 
> Neither tdx_guest_detected nor early_is_tdx_guest() is used anywhere.

Oh. Leftovers. Will drop.

-- 
 Kirill A. Shutemov
