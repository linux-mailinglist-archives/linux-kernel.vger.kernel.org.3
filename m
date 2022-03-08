Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458954D2366
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 22:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350435AbiCHViR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 16:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbiCHViP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 16:38:15 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0126654FBD
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 13:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646775438; x=1678311438;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=Rrkr8FcqnMz3FWaePedrsHWeH53x/+UhvHl600OQ3k0=;
  b=R5A8qvo+meOZSPXloO2bZYkbirw6Kq5aeaZ68DUwOFL6IkjyTlOG4pSI
   cGKabDU/xYLGMvBdUs8Jccq2M+FdiTyhI0qZ8LXCzX/in22iLokxqIL/c
   XXxk1CEPNymIAolt+i0I149FJAUSqq4F3WmCAmjQlWXzNzbn5UJyNMzJY
   q4Gc9pXY52RBlvOMxJdN8nV+DFtMuGNmJZBeeCUKLolCsA2RcOKdm4dpJ
   fOaN8kILv/o1HgRAOmbHzJ7dO6u+WAirLjq+8l/rn0HHNxBAsmBO4k2+q
   pOSCV3ckzTi/5k4TjiJHDti3RGIJu5LJ3CpSkt5ARXlIefSnplB0WC52y
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="254761519"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="254761519"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 13:37:18 -0800
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="547413427"
Received: from ntebyanx-mobl7.amr.corp.intel.com (HELO [10.212.224.65]) ([10.212.224.65])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 13:37:16 -0800
Message-ID: <13847c84-a305-f63d-95b3-833ffb3a49c1@intel.com>
Date:   Tue, 8 Mar 2022 13:37:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
 <20220302142806.51844-23-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv5 22/30] x86/boot: Set CR0.NE early and keep it set during
 the boot
In-Reply-To: <20220302142806.51844-23-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/22 06:27, Kirill A. Shutemov wrote:
> TDX guest requires CR0.NE to be set. Clearing the bit triggers #GP(0).
> 
> If CR0.NE is 0, the MS-DOS compatibility mode for handling floating-point
> exceptions is selected. In this mode, the software exception handler for
> floating-point exceptions is invoked externally using the processor’s
> FERR#, INTR, and IGNNE# pins.
> 
> Using FERR# and IGNNE# to handle floating-point exception is deprecated.
> CR0.NE=0 also limits newer processors to operate with one logical
> processor active.
> 
> Kernel uses CR0_STATE constant to initialize CR0. It has NE bit set.
> But during early boot kernel has more ad-hoc approach to setting bit
> in the register.

This walks right up to the problem but never actually comes out and says
what the problem is:

	During some of this ad-hoc manipulation, CR0.NE is cleared.
	This causes a #GP in TDX guests and makes it die in early boot.

> Make CR0 initialization consistent, deriving the initial value of CR0
> from CR0_STATE.

... and the solution:

	Since CR0_STATE always has CR0.NE=1, this ensures that CR0.NE is
	never 0 and avoids the #GP.

With the fixed changelog:

Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
