Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED484DD0E1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 23:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiCQWtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 18:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiCQWth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 18:49:37 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A531193DE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 15:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647557299; x=1679093299;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1hFcDf8anW6AdGeLSuh4hbFU4tK/wR4GsB+WTgpOk1s=;
  b=RB8HVqc180aUvHzsKvlbL86cy0d8qifsHU4eOKt3BD3UuUnMjlhYeh4F
   wYh1kOUdM6+mDzJg7XcX+fm6rXEoKRJGr7YgNfKKpTk13p5m9MsBAWCyZ
   KsW4VBc65klElNn0wIlXf0Tq5Fh6HiJAXfcohnIz8kDIIyNcqS3DWv0FD
   I6VgRhyAa2CQIKr6Zl1TDXKTFFPEYpdb4yd3nH4loili85q/uSPV3bi63
   cr1QacPlXCOltFZWz+mf/cKSGZ/hi/277b47i0VBJ01305lHQnw/JRIuY
   dI4d8bFgcqWnqkgig6ZxpBqjChbc6ULBpFsi90oZPwRZ3mhUihVRrHF+l
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="236945510"
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="236945510"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 15:48:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="499011864"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 17 Mar 2022 15:48:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 5A4E8107; Fri, 18 Mar 2022 00:48:31 +0200 (EET)
Date:   Fri, 18 Mar 2022 01:48:31 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv6 15/30] x86/boot: Port I/O: allow to hook up alternative
 helpers
Message-ID: <20220317224831.ci7tb4lasg3xlgvr@black.fi.intel.com>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-16-kirill.shutemov@linux.intel.com>
 <87czik22wk.ffs@tglx>
 <20220317201054.5wdykfru5hhvukvd@black.fi.intel.com>
 <c3b640aa-05a1-7706-0c0f-b3f75eee58c6@intel.com>
 <2b91abe5-88bd-2941-d561-a8b0ad40f62b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b91abe5-88bd-2941-d561-a8b0ad40f62b@intel.com>
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 01:23:12PM -0700, Dave Hansen wrote:
> On 3/17/22 13:20, Dave Hansen wrote:
> > You keep the preprocessor away from things like
> > 
> > 	foo.inb = bar;
> > 
> > with:
> > 
> > 	#define inb(x) pio_ops.inb(x)
> 
> ... and I spotted my nonsense just as I hit send.
> 
> You could do that ^^.  But you'd need to rename the 'inb' op  like:
> 
> struct port_io_ops {
> 	u8 (*f_inb)(u16 port);
> 	...
> };
> 
> so that you do:
> 
> 	#define inb(x) pio_ops.f_inb(x)
> 
> But, remember when I said I hate playing #define tricks? ;)  This is one
> reason why.

But the define tricks are unrelated to the linker issue. The issue pops up
after you get past the preprocessor tricks.

-- 
 Kirill A. Shutemov
