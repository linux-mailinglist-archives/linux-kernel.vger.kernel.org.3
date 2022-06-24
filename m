Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A7A559EDF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 18:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbiFXQwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 12:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbiFXQwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 12:52:36 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6D660C63
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 09:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656089555; x=1687625555;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0T/L9iR4nPCz40S3x4N7yZLx2Z/5idB9iH2qm693SHA=;
  b=YwyFD06H+V8M616q8IwEgqG01QAnZaTbwq2q6yIPYUFs9OR8s2XgLpVf
   5uJpXdBYDogz0+7sbk7Gjs4eM7qZ0sNaq6yNIFaZeULXo6MjSMczZz3Qg
   Smsop0+m5N/1MmtZmRFwXipG50U7BKKnHdpbTSAIcqGsq6n98hPU0Ihqv
   CJLrndAqVy7EJSaBtuWS+s15RjsvOh/T5Q5N5vxrhhdVgCFlPPbt+9iVl
   RSLP3lM0MwJ38tVoiuF4RoulkKHeTGcRbk3kC0fHlKZtCPNgD7YwIQWXA
   EfdzkMWfIzCIeKrR1DdNMpZsZjMPW+oWj/o89Qsw4/k18ANIkdLBRuCPH
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="264084626"
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="264084626"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 09:52:34 -0700
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="731392046"
Received: from mdedeogl-mobl.amr.corp.intel.com (HELO [10.209.126.186]) ([10.209.126.186])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 09:52:33 -0700
Message-ID: <0f6bedbb-14cc-bf93-5d9f-bfd2c49dc7b2@intel.com>
Date:   Fri, 24 Jun 2022 09:51:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v8 1/5] x86/tdx: Add TDX Guest attestation interface
 driver
Content-Language: en-US
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
References: <20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220609025220.2615197-2-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220609025220.2615197-2-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/22 19:52, Kuppuswamy Sathyanarayanan wrote:
> TDREPORT can only be verified on local platform as the MAC key is bound
> to the platform. To support remote verification of the TDREPORT, TDX
> leverages Intel SGX Quote Enclave (QE) to verify the TDREPORT locally
> and convert it to a remote verifiable Quote.
> 
> After getting the TDREPORT, the second step of the attestation process
> is to send it to the QE to generate the Quote. TDX doesn't support SGX
> inside the TD, so the QE can be deployed in the host, or in another
> legacy VM with SGX support. How to send the TDREPORT to QE and receive
> the Quote is implementation and deployment specific.

On high-level comment: this whole series is quite agnostic about what is
actually attested.  On some level, I guess it doesn't matter.  But, it
makes me a bit uneasy.  There needs to be at least *some* kind of claim
about that somewhere, preferably a sentence in the cover letter and
sentence or two here.

Second, how can someone test this code?  It appears that they need to
assemble a veritable Rube Goldberg machine.  The least we could do is
have a selftest that just calls the ioctl() and makes sure that
something halfway sane comes out of it.

> In such
> case, since REPORTDATA is a secret, using sysfs to share it is insecure
> compared to sending it via IOCTL.

Huh?  How is sysfs "insecure"?

> +	/*
> +	 * Generate TDREPORT using "TDG.MR.REPORT" TDCALL.
> +	 *
> +	 * Get the TDREPORT using REPORTDATA as input. Refer to
> +	 * section 22.3.3 TDG.MR.REPORT leaf in the TDX Module 1.0
> +	 * Specification for detailed information.
> +	 */
> +	ret = __tdx_module_call(TDX_GET_REPORT, virt_to_phys(tdreport),
> +				virt_to_phys(reportdata), 0, 0, NULL);

One of those 0's is a "Report sub type".  Those bits in the module call
are presumably because it won't *always* be zero.  But, if there's ever
a new report type, we'll need another user/kernel ABI.  That doesn't
seem great.

The TDX module spec doesn't even give a name to "sub report type 0".
That is not super helpful for deciding what it *means*.

Right now, the entire ABI is basically:

	ret = ioctl(TDX_GET_REPORT, &buffer);

That _implies_ a ton of stuff:

	1. report sub type 0
	2. a specific input length REPORTDATA
	3. a specific output length

I don't want to over-engineer this thing, but it would make a lot of
sense to me to feed the ioctl() with something like this:

struct tdx_report
{
	u8 report_sub_type;
	u64 report_input_data;
	u64 report_input_data_len;

	u64 report_output_data;
	u64 report_output_data_len;
}

That makes *everything* explicit.  It makes it utterly clear what goes
where, *AND* it makes userspace declare it.

But, you have:

> +/**
> + * struct tdx_report_req: Get TDREPORT using REPORTDATA as input.
> + *
> + * @reportdata : User-defined 64-Byte REPORTDATA to be included into
> + *		 TDREPORT. Typically it can be some nonce provided by
> + *		 attestation service, so the generated TDREPORT can be
> + *		 uniquely verified.
> + * @tdreport   : TDREPORT output from TDCALL[TDG.MR.REPORT] of size
> + *		 TDX_REPORT_LEN.
> + *
> + * Used in TDX_CMD_GET_REPORT IOCTL request.
> + */
> +struct tdx_report_req {
> +	union {
> +		__u8 reportdata[TDX_REPORTDATA_LEN];
> +		__u8 tdreport[TDX_REPORT_LEN];
> +	};
> +};
> +

and a bunch of code copying in and out of this structure:

> +static long tdx_get_report(void __user *argp)
> +{
> +	void *reportdata = NULL, *tdreport = NULL;
...
> +	/* Copy REPORTDATA from the user buffer */
> +	if (copy_from_user(reportdata, argp, TDX_REPORTDATA_LEN)) {
> +		ret = -EFAULT;
> +		goto out;
> +	}

But none of that code even bothers to *use* the structure!

What's with the union?  Are you really just trying to save 64 bytes of
space?  Is that worth it?

How many of these "drivers" are we going to need which are thinly veiled
ioctl()s that are only TDX module call wrappers?
