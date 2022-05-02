Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CD4517A00
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 00:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbiEBWeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 18:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiEBWee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 18:34:34 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF196A1B2
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 15:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651530663; x=1683066663;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tFPyJeC9v4cwAKfebe+SVDC0yXGBwGjA41mm9dEzQmw=;
  b=B5GLNbd5wnAiIwymz+dX4S+GvBT+Hz7g8+oQMV+pnvpue4n6gXRU6KTs
   PxYcVUQ978Ih5/wvS20o5eZRr5M9YtZLUWISEe/OJZF0XOPEKLwyMAOrF
   g/8k6Er7ZE1waVO6xk/aRZzgj5MQqmgZg7TlWUoG9LWywNh+9JFQxN/34
   9ZMJFLu9nwhpbPyFR7+WPokCgOuh+QCy8oLe9GEJH8z5+ZEyA62byM9pp
   KOO5Hh5+JZz9r3hxch+HRsXH/OfYH3oSBdUlRJpsOa7l2L1QrTk2vS3vr
   W3UtxqfTYwCArbh+x/X7PZJY6Gbh3KF71pQSOpikWtVnXcivjlaXkpnbL
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="266192524"
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="266192524"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 15:31:03 -0700
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="598826345"
Received: from chgan-mobl1.gar.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.254.60.238])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 15:30:59 -0700
Message-ID: <b8eadd3079101a2cf93ee87d36dbedf93d8a2725.camel@intel.com>
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
Date:   Tue, 03 May 2022 10:30:57 +1200
In-Reply-To: <e5aed619-20ce-7eb3-22a3-64b51de9cce3@linux.intel.com>
References: <20220501183500.2242828-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220501183500.2242828-2-sathyanarayanan.kuppuswamy@linux.intel.com>
         <5473f606bd8e60dd7b8d58a540285d126a1361bd.camel@intel.com>
         <e5aed619-20ce-7eb3-22a3-64b51de9cce3@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Also note that the MAC added to the TDREPORT is bound to the platform.
> So TDREPORT can only be verified locally. Intel SGX Quote Enclave (QE)
> can be leveraged to verify the TDREPORT locally and convert it to a
> remote verifiable Quote to support remote attestation of the TDREPORT.

Why "can be"?  TDX must use QE to generate the Quote.

[...]

> 
> > 
> > For instance, after rough thinking, why is the IOCTL better than below approach
> > using /sysfs?
> > 
> > echo <REPORTDATA> > /sys/kernel/coco/tdx/attest/reportdata
> > cat /sys/kernel/coco/tdx/attest/tdreport
> > 
> > Each "echo <REPORTDATA>" to '/sys/.../reportdata' triggers the driver to call
> > TDCALL to get the TDREPORT, which is available at '/sys/.../tdreport'.
> > 
> > The benefit of using IOCTL I can think of now is it is perhaps more secure, as
> > with IOCTL the REPORTDATA and the TDREPORT is visible to the process which calls
> > the IOCTL, while using the /sysfs they are potentially visible to any process.
> > Especially the REPORTDATA, i.e. it can come from attestation service after the
> > TD attestation agent sets up a secure connection with it.
> > 
> > Anyway, my 2cents above.
> 
> IMO, since TDREPORT is not a secret we don't have to hightlight security
> concern here. 
> 

Right the TDREPORT itself isn't a secret.  However my thinking is the REPORTDATA
might be.  It's typically provided by the attestation service to the TD so the
Quote can be verified for instance per-session or per-connect or whatever.  The
REPORTDATA is the only thing that can be used to prevent reply attack anyway. 
From this perspective, it is kinda secret.  However the TDREPORT can be captured
by untrusted software and used for reply attack if no crypto-protection is used
when it is sent to the QE, so I am not sure how bad can the reply attack cause.

> How about following?
> 
> Operations like getting TDREPORT or Quote generation involves sending
> a blob of data as input and getting another blob of data as output. It
> was considered to use a sysfs interface for this, but it doesn't fit
> well into the standard sysfs model for configuring values. It would be
> possible to do read/write on files, but it would need multiple file
> descriptors, which would be somewhat messy. IOCTLs seems to be the best
> fitting and simplest model here.
> 
> 

Let's forget about GetQuote now.  As you can see it has couple of problems.  

If we don't argue from security perspective, what's wrong with the approach
using /sysfs I mentioned above?

[...]

> > > +
> > > +	/*
> > > +	 * Generate TDREPORT using "TDG.MR.REPORT" TDCALL.
> > > +	 *
> > > +	 * Pass the physical address of user generated REPORTDATA
> > > +	 * and the physical address of the output buffer to the TDX
> > > +	 * module to generate the TDREPORT. Generated data contains
> > > +	 * measurements/configuration data of the TD guest. More info
> > > +	 * about ABI can be found in TDX 1.0 Module specification, sec
> > > +	 * titled "TDG.MR.REPORT".
> > 
> > I guess you can get rid of the entire second paragraph.  If the reference to the
> > spec is useful, then keep it but other sentences are not quite useful.  Perhaps:
> > 
> > 	Get the TDREPORT using REPORTDATA as input.  Refer to 22.3.3
> > 	TDG.MR.REPORT leaf in the TDX Module 1.0 Specification for detail
> > 	information.
> 
> How about following?
> 
> Pass REPORTDATA as input and generate TDREPORT using "TDG.MR.REPORT"
> TDCALL. Refer to 22.3.3 TDG.MR.REPORT leaf in the TDX Module 1.0
> Specification for detailed information.

No problem.

> 
> > 
> > > +	 */
> > > +	ret = __tdx_module_call(TDX_GET_REPORT, virt_to_phys(tdreport),
> > > +				virt_to_phys(reportdata), 0, 0, NULL);
> > > +	if (ret) {
> > > +		pr_debug("TDREPORT TDCALL failed, status:%lx\n",
> > > +				TDCALL_STATUS_CODE(ret));
> > 
> > You can just print out the exact error code.  It's more informative and can help
> > to debug.
> 
> As per spec, only upper 32 bits has status code. 0:32 does not have any
> useful info.

Bits 0:31 are also defined by TDX error codes.  For instance, it also prints
which argument caused this error in case of OPERAND_INVALID.  Why is it not
useful?

[...]

> > > +	ret = misc_register(&miscdev);
> > > +	if (ret) {
> > > +		pr_err("misc device registration failed\n");
> > 
> > pr_debug() is used when __tdx_module_call() fails, and in the default case in
> > tdx_attest_ioctl() too.
> > 
> > Shouldn't those error msg be printed using the same way?
> 
> For IOCTL case, I expect userspace to print the error. But for init
> code error, it needs to be handled by kernel. So I have used pr_err
> here.

I don't quite get.  Why "userspace will print the error or not" has anything to
do with using pr_debug() vs pr_err() here?

[...]

> 
> > > +
> > > +/**
> > > + * struct tdx_report_req: Get TDREPORT from the TDX module.
> > 
> > Just get the TDREPORT is enough I guess.
> 
> Get TDREPORT using REPORTDATA as input?

No problem.

> 
> > 
> > > + *
> > > + * @reportdata : User-defined 64-Byte REPORTDATA to be included into
> > > + *		 TDREPORT. Typically it can be some nonce provided by
> > > + *		 attestation software so the generated TDREPORT can be
> > > + *		 uniquely verified.
> > > + * @tdreport   : TDREPORT output from TDCALL[TDG.MR.REPORT] of size
> > > + *		 TDX_REPORT_LEN.
> > > + *
> > > + * Used in TDX_CMD_GET_REPORT IOCTL request.
> > > + */
> > > +struct tdx_report_req {
> > > +	union {
> > > +		__u8 reportdata[TDX_REPORTDATA_LEN];
> > > +		__u8 tdreport[TDX_REPORT_LEN];
> > > +	};
> > > +};
> > 
> > I am not sure overriding the input is a good idea, but will leave to others.
> 
> TDCALL uses it that way. So I have followed the same model.

Which TDCALL?

And TDCALL is kernel internal implementation, but we are talking about userspace
ABI here.  I don't see any connection between them.

> 
> > 
> > > +
> > > +/* Get TDREPORT from the TDX module using TDCALL[TDG.MR.REPORT) */
> > 
> > Just get the TDREPORT is enough I guess.
> 
> May be following?
> 
> Get TDREPORT using TDCALL[TDG.MR.REPORT)

My thinking is you don't need to call out the exact TDCALL in the uapi header. 
But no opinion here.  Will leave to maintainers.

> 
> > 
> > > +#define TDX_CMD_GET_REPORT		_IOWR('T', 0x01, struct tdx_report_req)
> > > +
> > > +#endif /* _UAPI_ASM_X86_TDX_H */
> > 
> 


-- 
Thanks,
-Kai


