Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D245E4DDD14
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 16:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238114AbiCRPh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 11:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236141AbiCRPh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 11:37:26 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97701BA307
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 08:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647617768; x=1679153768;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WMHZcCH8iqkgdIHogS8Uy2gKZXq1tFCApIr/TF9blTg=;
  b=MVqxKVhHsc1UQnJuiORiAuvQoGEixjx9ffdamOWUYJjvBLhNcWhsK/5b
   3iLvekc3oUJkigRCXOrIhf6YGNA6F2FQLVukacMwktu5k8B+KpuTa3lbS
   p5IA8kkjlOiGJj7LTXV3h1YQB77gzPGAv3ZAvweSM3SIPofKGz/ng1w0+
   gcMiyhKe0tceh1DBhDX7yzn+ZFKauwEUPEcKcOoPPzFIyh0ODt5wPOaRZ
   u7SUoSK7yHsu/R3UPm4EU9kpPV1mn9QWF5smQzKWJNRarG+Vwp5cto+sI
   exG13eLBGMQgCtoOvrdll9n1b/XXBHEDeEi6RtmXc/MicLJuJuvj7F2GE
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="237768682"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="237768682"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 08:36:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="647507908"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 18 Mar 2022 08:35:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 9F82C10E; Fri, 18 Mar 2022 17:36:17 +0200 (EET)
Date:   Fri, 18 Mar 2022 18:36:17 +0300
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
Subject: Re: [PATCHv6 16/30] x86/boot: Port I/O: add decompression-time
 support for TDX
Message-ID: <20220318153617.u7rztnnhv6gvls4z@black.fi.intel.com>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-17-kirill.shutemov@linux.intel.com>
 <87a6do22t6.ffs@tglx>
 <20220317201547.haoyqy2iaid7lku3@black.fi.intel.com>
 <874k3vcp1y.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874k3vcp1y.ffs@tglx>
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 03:28:57PM +0100, Thomas Gleixner wrote:
> On Thu, Mar 17 2022 at 23:15, Kirill A. Shutemov wrote:
> > On Thu, Mar 17, 2022 at 01:15:01PM +0100, Thomas Gleixner wrote:
> >> On Wed, Mar 16 2022 at 05:08, Kirill A. Shutemov wrote:
> >> >  void early_tdx_detect(void)
> >> >  {
> >> >  	u32 eax, sig[3];
> >> > @@ -23,4 +94,12 @@ void early_tdx_detect(void)
> >> >  
> >> >  	/* Cache TDX guest feature status */
> >> >  	tdx_guest_detected = true;
> >> > +
> >> > +	/* Use hypercalls instead of I/O instructions */
> >> > +	inb = tdx_inb;
> >> 
> >> Eeew. What's wrong with writing this out?
> >> 
> >>         pio_ops.inb = tdx_inb;
> >> 
> >> So it becomes obvious what this is about?
> >
> > This leads to preprocessor hell: "pio_ops.inb" is expanded to
> > "pio_ops.pio_ops.inb" :/
> >
> > I can rename fields in struct port_io_ops to avoid conflicts, I donno.
> 
> Yes, please rename them.

Oops, I've sent v7, before I read the reply. I will sent updates to
relevant patches.

-- 
 Kirill A. Shutemov
