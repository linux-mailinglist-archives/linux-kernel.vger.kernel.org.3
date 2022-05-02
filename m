Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27D3517AEA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 01:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiEBXmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 19:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiEBXlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 19:41:04 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC0ABF1
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 16:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651534653; x=1683070653;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4XLZUUn5VZ5th7pOOR71IpH56PArGKxViiV6iEMdEEc=;
  b=Qs6v6pIIQbAOamRHNu6kOWlpLBN2uWqLlXqCtRsnLPxpKVKJeyG670RK
   m9wtQuTyeL79n+JUzX59BtIaSEdQefSJFSAFSpZ7a3qN0UtK+5kur/xqj
   zg/7gHdHzHsi5AEkP6UQ5/UUnullzLDYcSh7yjk+BAa0RN/eE6Fm8qvYz
   X+ZGcuzhjQMB8ToRT5bUzgH1QgX0lzJ1tqfOVRKlBzYe2qd0f5PSxm8WU
   siDUgBKsHZrbNg6RwobY3wchPSgvnkFlJ9DyrYz0CfwdHhFmn85sLElLq
   nDhbOSSCdcQTuVHZod0rRir5j2xCmlmilMEq0MLH5QcVC5VcsSyLPoPYD
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="247265995"
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="247265995"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 16:37:33 -0700
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="887448290"
Received: from chgan-mobl1.gar.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.254.60.238])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 16:37:29 -0700
Message-ID: <0c31f9e5d74b8f5e494fcd3d9c0ebb6668f57c74.camel@intel.com>
Subject: Re: [PATCH v5 1/3] x86/tdx: Add TDX Guest attestation interface
 driver
From:   Kai Huang <kai.huang@intel.com>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
Date:   Tue, 03 May 2022 11:37:27 +1200
In-Reply-To: <e673ea3d-ae4f-39ed-33a5-c6480e58c6d8@linux.intel.com>
References: <20220501183500.2242828-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220501183500.2242828-2-sathyanarayanan.kuppuswamy@linux.intel.com>
         <5473f606bd8e60dd7b8d58a540285d126a1361bd.camel@intel.com>
         <e5aed619-20ce-7eb3-22a3-64b51de9cce3@linux.intel.com>
         <b8eadd3079101a2cf93ee87d36dbedf93d8a2725.camel@intel.com>
         <e673ea3d-ae4f-39ed-33a5-c6480e58c6d8@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > 
> > > > 
> > > > For instance, after rough thinking, why is the IOCTL better than below approach
> > > > using /sysfs?
> > > > 
> > > > echo <REPORTDATA> > /sys/kernel/coco/tdx/attest/reportdata
> > > > cat /sys/kernel/coco/tdx/attest/tdreport
> > > > 
> > > > Each "echo <REPORTDATA>" to '/sys/.../reportdata' triggers the driver to call
> > > > TDCALL to get the TDREPORT, which is available at '/sys/.../tdreport'.
> > > > 
> > > > The benefit of using IOCTL I can think of now is it is perhaps more secure, as
> > > > with IOCTL the REPORTDATA and the TDREPORT is visible to the process which calls
> > > > the IOCTL, while using the /sysfs they are potentially visible to any process.
> > > > Especially the REPORTDATA, i.e. it can come from attestation service after the
> > > > TD attestation agent sets up a secure connection with it.
> > > > 
> > > > Anyway, my 2cents above.
> > > 
> > > IMO, since TDREPORT is not a secret we don't have to hightlight security
> > > concern here.
> > > 
> > 
> > Right the TDREPORT itself isn't a secret.  However my thinking is the REPORTDATA
> > might be.  It's typically provided by the attestation service to the TD so the
> > Quote can be verified for instance per-session or per-connect or whatever.  The
> > REPORTDATA is the only thing that can be used to prevent reply attack anyway.
> >  From this perspective, it is kinda secret.  However the TDREPORT can be captured
> > by untrusted software and used for reply attack if no crypto-protection is used
> > when it is sent to the QE, so I am not sure how bad can the reply attack cause.
> > 
> > > How about following?
> > > 
> > > Operations like getting TDREPORT or Quote generation involves sending
> > > a blob of data as input and getting another blob of data as output. It
> > > was considered to use a sysfs interface for this, but it doesn't fit
> > > well into the standard sysfs model for configuring values. It would be
> > > possible to do read/write on files, but it would need multiple file
> > > descriptors, which would be somewhat messy. IOCTLs seems to be the best
> > > fitting and simplest model here.
> > > 
> > > 
> > 
> > Let's forget about GetQuote now.  As you can see it has couple of problems.
> > 
> > If we don't argue from security perspective, what's wrong with the approach
> > using /sysfs I mentioned above?
> 
> Sysfs is generally used for configuring values. As I have mentioned, it
> does not fit well for our use case where we want to send blob of data
> as input and get another blob as an output. But, if you really want to
> use it, you can implement it like you have mentioned (with multiple
> files). But I don't see any advantage in doing it.

I am not so sure about this argument.  Will leave this to maintainers.

My point is to me from security's perspective, IOCTL fits better.  And you can
add this to your changelog.

> 
> Also, in the future, if you want to support multiple requests in
> parallel, sysfs model will not work.
> 
> 
> > > 

I think you are mixing getting TDREPORT and GetQuote.  What's the point of
supporting get TDREPORT in parallel?  You can only get one TDREPORT from TDX
module at one time.

> > > > 
> > > > > + *
> > > > > + * @reportdata : User-defined 64-Byte REPORTDATA to be included into
> > > > > + *		 TDREPORT. Typically it can be some nonce provided by
> > > > > + *		 attestation software so the generated TDREPORT can be
> > > > > + *		 uniquely verified.
> > > > > + * @tdreport   : TDREPORT output from TDCALL[TDG.MR.REPORT] of size
> > > > > + *		 TDX_REPORT_LEN.
> > > > > + *
> > > > > + * Used in TDX_CMD_GET_REPORT IOCTL request.
> > > > > + */
> > > > > +struct tdx_report_req {
> > > > > +	union {
> > > > > +		__u8 reportdata[TDX_REPORTDATA_LEN];
> > > > > +		__u8 tdreport[TDX_REPORT_LEN];
> > > > > +	};
> > > > > +};
> > > > 
> > > > I am not sure overriding the input is a good idea, but will leave to others.
> > > 
> > > TDCALL uses it that way. So I have followed the same model.
> > 
> > Which TDCALL?
> 
> TDG.MR.REPORT. It uses the same buffer as input and output.
> 
> 
It doesn't override the REPORTDATA:

Input:

RCX:	1024B-aligned guest physical address of newly created report structure
RDX:	64B-aligned guest physical address of additional data to be signed

As you can see the buffer to hold TDREPORT and REPORTDATA are not the same.

Anyway, we are talking about userspace ABI.  I don't see why this is related
here.

-- 
Thanks,
-Kai


