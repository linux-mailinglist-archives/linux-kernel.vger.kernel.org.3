Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD0C509DB7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 12:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388417AbiDUKgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 06:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235786AbiDUKgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 06:36:03 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8C924F11;
        Thu, 21 Apr 2022 03:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650537194; x=1682073194;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jcMPy87x/HK1o0RKPabZAUkhnjVpowL1sK3ccHuaXNM=;
  b=Lw2IaOYXXJ4NDgrIVnCt4/ThocGVNf97knlesveEWokL/LL38CvHWhSL
   sajBFFry4PbRlpRmMKGcQzP08jfF3FdUtXoafaBE9ZveWguFcjZmyYZf+
   JmTeM4OA6mSIhaabfIAM0WQLKbcHZ4bjjIEr7fVIaE/9JvgTUlMMFBsZ7
   wezLEJdK20qhUNlJ/eXxssfZSU+zMJnrCEAprtVCHoyZGsQypgJGwbUMs
   fWD2Qu7+eAAYxdEsHLB9+fPas9eOf3Qa0sBr0rvEptNZTaVQ6j4R9ptm6
   40ldkNwVGP/fCsiL6HRLGuoQnkfkXB/zGXIg3Il2aIUowrmDaqVhPIkLT
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="263159553"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="263159553"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 03:33:14 -0700
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="703031400"
Received: from jharolds-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.254.58.27])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 03:33:11 -0700
Message-ID: <48356d733067781b527fc0294317be27098f502d.camel@intel.com>
Subject: Re: [PATCH v3 4/4] platform/x86: intel_tdx_attest: Add TDX Guest
 attestation interface driver
From:   Kai Huang <kai.huang@intel.com>
To:     Isaku Yamahata <isaku.yamahata@gmail.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Date:   Thu, 21 Apr 2022 22:33:09 +1200
In-Reply-To: <20220421065707.GA1423762@private.email.ne.jp>
References: <20220415220109.282834-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220415220109.282834-5-sathyanarayanan.kuppuswamy@linux.intel.com>
         <b209ee09b74394ab7aed85e0244e2191ee3d4171.camel@intel.com>
         <e0e2e399-2cac-cf75-2a64-9d017e6d7189@linux.intel.com>
         <420a4d689f73f9f7dc1ef71c61da75b7c9777a3f.camel@intel.com>
         <1e184b44-8024-b8ae-98a8-cf2b6f78df61@linux.intel.com>
         <20220421065707.GA1423762@private.email.ne.jp>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-04-20 at 23:57 -0700, Isaku Yamahata wrote:
> On Wed, Apr 20, 2022 at 07:42:06PM -0700,
> Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> 
> > 
> > 
> > On 4/20/22 5:11 PM, Kai Huang wrote:
> > > On Wed, 2022-04-20 at 16:45 -0700, Sathyanarayanan Kuppuswamy wrote:
> > > > If we want to support multiple GetQuote requests in parallel, then we
> > > > need some way to uniquely identify the GetQuote requests. So that when
> > > > we get completion notification, we can understand which request is
> > > > completed. This part is not mentioned/discussed in ABI spec. So we want
> > > > to serialize the requests for now.
> > > > 
> > > 
> > > Yes it's unfortunate that this part (whether concurrent GetQuote requests are
> > > supported by TDX architecture) is not explicitly mentioned in GHCI spec.  I am
> > > fine with only supporting GetQuote requests one by one.  AFAICT there's no
> > > request to support concurrent GetQuote requests anyway.  What concerns me is
> > > exactly how explain this.
> > > 
> > > As I said, we have GET_QUOTE_IN_FLIGHT flag now.  Theoretically, you can queue
> > > multiple GetQuote requests, and when you receive the interrupt, you check which
> > > buffer has GET_QUOTE_IN_FLIGHT cleared.  That buffer is the one with Quote
> > > ready.  However I am not 100% sure whether above will always work.  Interrupt
> > > can get lost when there are multiple Quotes ready in multiple buffer in very
> > > short time period, etc?  Perhaps Isaku can provide more input here.
> > 
> > Either supported or not, it should be mentioned in the GHCI spec. Currently,
> > there are no details related to it. If it is supported, the specification
> > should include the protocol to use.
> > 
> > I will check with Isaku about it.
> 
> The spec says that TD can call multiple GetQuote requests in parallel.
> 
>   TDG.VP.VMCALL<GetQuote> API allows one TD to issue multiple requests. It's
>   implementation specific that how many concurrent requests are allowed. The TD
>   should be able to handle TDG.VP.VMCALL_RETRY if it chooses to issue multiple
>   requests simultaneously
> 
> As Kai said, there is no requirement for multiple GetQuote in parallel, it's
> okay to support only single request at the same time.
> 
> While the status is GET_QUOTE_IN_FLIGHT, VMM owns the shared GPA.  The
> attestation driver should wait for GET_QUOTE_IN_FLIGHT to be cleared before
> sending next request.

Sorry I missed this in the spec.  Then as I mentioned above, TD should check
which buffer has GET_QUOTE_IN_FLIGHT bit cleared to determine which GetQuote
request is done?  I guess this is the only way.

Anyway, supporting single request only is fine to me.  Just needs some
explanation in comments or commit message.

-- 
Thanks,
-Kai


