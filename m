Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CC1513B3D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 20:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350777AbiD1SPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 14:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350785AbiD1SPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 14:15:17 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A69B8205
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 11:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651169519; x=1682705519;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YN8ESn/HRWKtJH/jwZ9GPFxcpNmP9Vxhgsndj/11SCA=;
  b=BVYYKOaTADyQ/u2r2YcOlrdcFQqSxKCtQqzMyLBQDysawszSbSw34lwu
   1HGz7ARP2MGMmyZzjdGsC34BS4iJLkq9ZMZsoFov+fg9sJZP2g9TWsaem
   Dp8VtuYAbP88ARdpmrVUGioEqSodyw6pV8NlljJ2BUUzebr+JPjah8nlA
   LVMves9Zhu0ap3H48GAq/u5BIfqHvjZUYvly8rkVMptwBFtH4G7a4KpvA
   0aqL2jN3dUcPWta8YmbPErxoezL50PpgYfr2jiXjX2PKAx7Ezfl4kYo5U
   Zglq0z3hxZIA8brOBCYOImh/Y14u3fqnSUltfVRsBXHNuntiL53DcOyzP
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="246931487"
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="246931487"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 11:11:59 -0700
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="661915488"
Received: from rbopardi-mobl.amr.corp.intel.com (HELO [10.251.19.231]) ([10.251.19.231])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 11:11:58 -0700
Message-ID: <1f2ec95a-f7ac-5a89-09bc-2c5a7fdc2f3c@linux.intel.com>
Date:   Thu, 28 Apr 2022 11:11:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v4 3/3] x86/tdx: Add Quote generation support
Content-Language: en-US
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>, linux-kernel@vger.kernel.org
References: <20220422233418.1203092-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220422233418.1203092-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YmrV0uYMBCSq7xNK@fedora>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <YmrV0uYMBCSq7xNK@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/28/22 10:58 AM, Wander Lairson Costa wrote:
> On Fri, Apr 22, 2022 at 04:34:18PM -0700, Kuppuswamy Sathyanarayanan wrote:
> 
> [snip]
> 
>> +static long tdx_get_tdquote(void __user *argp)
>> +{
>> +	struct tdx_quote_hdr *quote_hdr;
>> +	struct tdx_quote_req quote_req;
>> +	void *quote_buf = NULL;
>> +	dma_addr_t handle;
>> +	long ret = 0, err;
>> +	u64 quote_buf_len;
>> +
>> +	mutex_lock(&quote_lock);
>> +
>> +	reinit_completion(&req_compl);
>> +
>> +	/* Copy Quote request struct from user buffer */
>> +	if (copy_from_user(&quote_req, argp, sizeof(struct tdx_quote_req)))
>> +		return -EFAULT;
>> +
>> +	/* Make sure the length & timeout is valid */
>> +	if (quote_req.len <= 0 || quote_req.timeout <= 0)
> 
> len and timeout are unsigned values, so they will never be negative.

Yes. I will change it to non-zero check.

> 
>> +		return -EINVAL;
>> +
>> +	/* Align with page size to meet 4K alignment */
>> +	quote_buf_len = PAGE_ALIGN(quote_req.len);
>> +
>> +	/*
>> +	 * Allocate DMA buffer to get TDQUOTE data from the VMM.
>> +	 * dma_alloc_coherent() API internally marks allocated
>> +	 * memory as shared with VMM. So explicit shared mapping is
>> +	 * not required.
>> +	 */
>> +	quote_buf = dma_alloc_coherent(&pdev->dev, quote_buf_len, &handle,
>> +					GFP_KERNEL | __GFP_ZERO);
>> +	if (!quote_buf) {
>> +		ret = -ENOMEM;
>> +		goto quote_failed;
>> +	}
>> +
>> +	/* Copy TDREPORT from user Quote data buffer to kernel Quote buffer */
>> +	if (copy_from_user(quote_buf, (void __user *)quote_req.buf, quote_req.len)) {
>> +		ret = -EFAULT;
>> +		goto quote_failed;
>> +	}
>> +
>> +	/* Submit GetQuote Request */
>> +	err = tdx_hcall_get_quote(quote_buf, quote_buf_len);
>> +	if (err) {
>> +		/* if failed, copy hypercall error code to user buffer */
>> +		ret = put_user(err, (long __user *)argp);
> 
> The assigment to ret is unused.

Since we are already in error path and setting ret to -EIO I did not
handle the pur_user() error case.

> 
>> +		ret = -EIO;
>> +		goto quote_failed;
>> +	}
>> +
>> +	/* Wait for attestation completion */
>> +	ret = wait_for_completion_interruptible_timeout(
>> +			&req_compl,
>> +			msecs_to_jiffies(quote_req.timeout));
>> +	if (ret <= 0) {
>> +		ret = -EIO;
>> +		goto quote_failed;
>> +	}
>> +
>> +	/* Copy generated Quote data back to user buffer */
>> +	if (copy_to_user((void __user *)quote_req.buf, quote_buf, quote_buf_len)) {
> 
> Shouldn't we use quote_req.len instead of quote_buf_len here?

Good catch. I will fix it in next version.

> 
>> +		ret = -EFAULT;
>> +		goto quote_failed;
>> +	}
>> +
>> +	quote_hdr = (struct tdx_quote_hdr *)quote_buf;
>> +
>> +	/* Make sure quote generation is successful */
>> +	if (!quote_hdr->status)
>> +		ret = 0;
>> +	else
>> +		ret = -EIO;
>> +
> 
> Shouldn't copy_to_user be called after checking the status?

IMO, since GetQuote TDVMCALL is successful, we can copy the buffer
back to the user. My idea is to let the attestation agent handle the
error in GetQuote header (like IN_FLIGHT scenario).

Maybe I should remove quote_hdr->status check in kernel and let user
agent handle it.

Isaku/Kai, any comments?

> 
>> +quote_failed:
>> +	if (quote_buf)
>> +		dma_free_coherent(&pdev->dev, quote_buf_len, quote_buf, handle);
>> +
>> +	mutex_unlock(&quote_lock);
>> +
>> +	return ret;
>> +}
>> +
>> +static void attestation_callback_handler(void)
>> +{
>> +	complete(&req_compl);
>> +}
>> +
>>   static long tdx_attest_ioctl(struct file *file, unsigned int cmd,
>>   			     unsigned long arg)
>>   {
>> @@ -89,6 +183,9 @@ static long tdx_attest_ioctl(struct file *file, unsigned int cmd,
>>   	case TDX_CMD_GET_TDREPORT:
>>   		ret = tdx_get_tdreport(argp);
>>   		break;
>> +	case TDX_CMD_GEN_QUOTE:
>> +		ret = tdx_get_tdquote(argp);
>> +		break;
>>   	default:
>>   		pr_err("cmd %d not supported\n", cmd);
>>   		break;
>> @@ -103,6 +200,14 @@ static const struct file_operations tdx_attest_fops = {
>>   	.llseek		= no_llseek,
>>   };
>>   
>> +/* Helper function to cleanup attestation related allocations */
>> +static void _tdx_attest_remove(void)
>> +{
>> +	misc_deregister(&miscdev);
> 
> Won't misc_deregister be called even if misc_register fails?

Yes. I will fix this in next version.

> 
>> +
>> +	tdx_remove_ev_notify_handler();
>> +}
>> +
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
