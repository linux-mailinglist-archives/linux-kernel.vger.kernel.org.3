Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70EE652F1D4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 19:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352289AbiETRqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 13:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346185AbiETRqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 13:46:14 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7F413E01
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 10:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653068772; x=1684604772;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tc9UnOh4etZDotJNH76vJ/VKrX7c5CO0J+Z50ZDhDQI=;
  b=Y3GU0XVaKfpKPsGIbxR8JMWTOwPOAajFqvS+D8wzdv+qyItPGzqCy8NW
   bp6X8nByny9M7tyTsXrhei8cmzCgiTrC/X7CXtpQqX2m6vNmtfI+0Rsr1
   Qn0KQXaR2YS3uDmGV6OW+AO8J1Hd74fcLE++lbyH+1tQ09598RtBl3KW6
   aFg6tBCIgOemewLFTRMBEfGh1Azy/onrdDZ6TwOJEjgkqvQQmD76KFSaC
   sAjgWuy9TJxL87nxLt9FvVXL1rEFSt1B/XR+iOEzT4G1ueX0ZUZtoufuH
   4N2zWU6F7r50gvayMY43SHMZzburxtcsTVxAEdDIugfrcSI5gGdNy1y86
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="272809390"
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="272809390"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 10:46:11 -0700
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="701853623"
Received: from imlazutk-mobl2.amr.corp.intel.com (HELO [10.212.196.122]) ([10.212.196.122])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 10:46:10 -0700
Message-ID: <72c0c7ff-35db-eb8e-0220-87baed2a3cd8@linux.intel.com>
Date:   Fri, 20 May 2022 10:46:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: [PATCHv2 1/3] x86/tdx: Fix early #VE handling
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org, seanjc@google.com,
        thomas.lendacky@amd.com, x86@kernel.org
References: <20220520031316.47722-1-kirill.shutemov@linux.intel.com>
 <20220520031316.47722-2-kirill.shutemov@linux.intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20220520031316.47722-2-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/19/22 8:13 PM, Kirill A. Shutemov wrote:
> Move RIP in tdx_early_handle_ve() after handling the exception. Failure
> to do that leads to infinite loop of exceptions.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Fixes: 32e72854fa5f ("x86/tdx: Port I/O: Add early boot support")
> ---
>   arch/x86/coco/tdx/tdx.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)

Looks good to me

Reviewed-by: Kuppuswamy Sathyanarayanan 
<sathyanarayanan.kuppuswamy@linux.intel.com>

> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 03deb4d6920d..faae53f8d559 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -447,13 +447,17 @@ static bool handle_io(struct pt_regs *regs, u32 exit_qual)
>   __init bool tdx_early_handle_ve(struct pt_regs *regs)
>   {
>   	struct ve_info ve;
> +	bool ret;
>   
>   	tdx_get_ve_info(&ve);
>   
>   	if (ve.exit_reason != EXIT_REASON_IO_INSTRUCTION)
>   		return false;
>   
> -	return handle_io(regs, ve.exit_qual);
> +	ret = handle_io(regs, ve.exit_qual);
> +	if (ret)
> +		regs->ip += ve.instr_len;
> +	return ret;
>   }
>   
>   void tdx_get_ve_info(struct ve_info *ve)

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
