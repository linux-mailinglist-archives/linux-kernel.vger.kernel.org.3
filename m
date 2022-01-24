Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C092049A16C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 00:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2359725AbiAXXeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 18:34:46 -0500
Received: from mga04.intel.com ([192.55.52.120]:1125 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1838200AbiAXWqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 17:46:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643064364; x=1674600364;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=0yjYC5cSG6wMR0icUJQxGPCW1Tr8fzyk1/f5bniTbYQ=;
  b=DY6Hu/1A68drM+e9RenNZm/Gfw55PMgAvdaHKR8EjE/UIephx9+QT58t
   enW839gzq0Txn4xmlkUmUAoHoN5adqrCEhKX9ayRS89xtaVilAeiOPbPA
   OgUzYiCE36E8YtGQlmt8HmF4QGl09cnPXn3uhOkcwZNrDtl/fAuZchnPP
   0hNiPAL5SXO2wAcNEzZiUjWxY3YJ1r78y/J4gpbbIjLz+K9g715yKblAm
   3JaoZMi+uczNc/QzfIr8rIk0qksjGKmIAwKnidG9iZF5Zjb5vzGOlg2Rt
   0ufThj0aw4sMn/MefHjLiBEh+uPRFjr0FkKOhVzHI0ML5yO4k2Lq49goz
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="244998192"
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="244998192"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 14:40:46 -0800
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="580544212"
Received: from jncomo-mobl.amr.corp.intel.com (HELO [10.251.27.220]) ([10.251.27.220])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 14:40:45 -0800
Message-ID: <12fb2758-8c06-8ab8-03d8-d77bd1edfce1@intel.com>
Date:   Mon, 24 Jan 2022 14:40:41 -0800
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
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-9-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv2 08/29] x86/tdx: Handle in-kernel MMIO
In-Reply-To: <20220124150215.36893-9-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static bool tdx_mmio(int size, bool write, unsigned long addr,
> +		     unsigned long *val)
> +{
> +	struct tdx_hypercall_output out;
> +	u64 err;
> +
> +	err = _tdx_hypercall(EXIT_REASON_EPT_VIOLATION, size, write,
> +			     addr, *val, &out);
> +	if (err)
> +		return true;
> +
> +	*val = out.r11;
> +	return false;
> +}
> +
> +static bool tdx_mmio_read(int size, unsigned long addr, unsigned long *val)
> +{
> +	return tdx_mmio(size, false, addr, val);
> +}
> +
> +static bool tdx_mmio_write(int size, unsigned long addr, unsigned long *val)
> +{
> +	return tdx_mmio(size, true, addr, val);
> +}
> +
> +static int tdx_handle_mmio(struct pt_regs *regs, struct ve_info *ve)
> +{
...
> +	bool err;

I'll agree with Josh on one point: "bool err" _is_ weird.

Things tend to either return int with 0 for success or bool with true 
for success.

The tdx_handle*() ones seem OK to me.  It's pretty normal to have a 
literal "handler" return true if things were handled.

I'd probably just make tdx_mmio() return an int.  It seems to only able 
to return -EFAULT anyway, so changing the return from bool->int and doing:

-	return false;
+	return -EFAULT;

isn't exactly a heavy lift.
