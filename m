Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA6D513B23
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 19:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350649AbiD1R7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 13:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236683AbiD1R7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 13:59:43 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154494D63D
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 10:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651168588; x=1682704588;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wsMhluVjGR1axsAHZehnnMdnaITcbVyHrUIGAsit0Ms=;
  b=cOLzIJCscN+Zx+Ps5epk7d9JW+19ZWklTDZH+2MDh6iOwCCvtG02nO+6
   cOfgjuYbGkoT06suKiAJRHITo86v54VTflRD+FZcn9kb1Zk12N+YCY/SR
   haj3omHLNWBIIG6ce71Vf993dd2TBaUbdj8aXXBxaIpDZjyraUHvjvoEf
   t2rKlrZqsJs/LzuKjGPbrxHSxNTvCRz4ViT9yYjBmUHN/VdR8cyRYJzIc
   qs+tCHWphiRS9WKk6N7Lf1J5xp0BF4Z6KYMi4yUS90Jr30VXI0XIxpmq/
   /NW0fcfuqrLuweT/H056TfzuYB4JD3+3fTeCHqUf/OmB4FQ+gPhhlt70C
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="246926949"
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="246926949"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 10:56:27 -0700
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="661910404"
Received: from rbopardi-mobl.amr.corp.intel.com (HELO [10.251.19.231]) ([10.251.19.231])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 10:56:27 -0700
Message-ID: <c771664d-893b-a41e-079f-74673517b3bb@linux.intel.com>
Date:   Thu, 28 Apr 2022 10:56:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v4 1/3] x86/tdx: Add TDX Guest attestation interface
 driver
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
 <20220422233418.1203092-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YmrSqEBHXZvWs4a0@fedora>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <YmrSqEBHXZvWs4a0@fedora>
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

Hi,

On 4/28/22 10:45 AM, Wander Lairson Costa wrote:
> On Fri, Apr 22, 2022 at 04:34:16PM -0700, Kuppuswamy Sathyanarayanan wrote:
> 
> [snip]
> 
>> +static long tdx_get_tdreport(void __user *argp)
>> +{
>> +	void *report_buf = NULL, *tdreport_buf = NULL;
>> +	long ret = 0, err;
>> +
>> +	/* Allocate space for report data */
>> +	report_buf = kmalloc(TDX_REPORT_DATA_LEN, GFP_KERNEL);
>> +	if (!report_buf)
>> +		return -ENOMEM;
>> +
>> +	/*
>> +	 * Allocate space for TDREPORT buffer (1024-byte aligned).
>> +	 * Full page alignment is more than enough.
>> +	 */
>> +	tdreport_buf = (void *)get_zeroed_page(GFP_KERNEL);
> 
> Maybe we should add BUILD_BUG_ON(TDX_TDREPORT_LEN > PAGE_SIZE)

Currently, it is a constant value < PAGE_SIZE. But I can add the
BUILD_BUG_ON check for it.

> 
>> +	if (!tdreport_buf) {
>> +		ret = -ENOMEM;
>> +		goto tdreport_failed;
>> +	}
>> +
>> +	/* Copy report data to kernel buffer */
>> +	if (copy_from_user(report_buf, argp, TDX_REPORT_DATA_LEN)) {
>> +		ret = -EFAULT;
>> +		goto tdreport_failed;
>> +	}
>> +
>> +	/* Generate TDREPORT using report data in report_buf */
>> +	err = tdx_mcall_tdreport(tdreport_buf, report_buf);
>> +	if (err) {
>> +		/* If failed, pass TDCALL error code back to user */
>> +		ret = put_user(err, (long __user *)argp);
> 
> The assigment to ret is useless here

Yes, noted it already. I will remove it in next version.

> 
>> +		ret = -EIO;
>> +		goto tdreport_failed;
>> +	}
>> +
>> +	/* Copy TDREPORT data back to user buffer */
>> +	if (copy_to_user(argp, tdreport_buf, TDX_TDREPORT_LEN))
>> +		ret = -EFAULT;
>> +
>> +tdreport_failed:
>> +	kfree(report_buf);
>> +	if (tdreport_buf)
>> +		free_pages((unsigned long)tdreport_buf, 0);
>> +
>> +	return ret;
>> +}
>> +
>> +static long tdx_attest_ioctl(struct file *file, unsigned int cmd,
>> +			     unsigned long arg)
>> +{
>> +	void __user *argp = (void __user *)arg;
>> +	long ret = 0;
>> +
>> +	switch (cmd) {
>> +	case TDX_CMD_GET_TDREPORT:
>> +		ret = tdx_get_tdreport(argp);
>> +		break;
>> +	default:
>> +		pr_err("cmd %d not supported\n", cmd);
> 
> Shouldn't we add "ret = -EINVAL" here?

Yes. I have noted it already, I will fix this in next version.

> 
>> +		break;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static const struct file_operations tdx_attest_fops = {
>> +	.owner		= THIS_MODULE,
>> +	.unlocked_ioctl	= tdx_attest_ioctl,
>> +	.llseek		= no_llseek,
>> +};
>> +
>> +static int tdx_attest_probe(struct platform_device *attest_pdev)
>> +{
>> +	struct device *dev = &attest_pdev->dev;
>> +	long ret = 0;
>> +
>> +	/* Only single device is allowed */
>> +	if (pdev)
>> +		return -EBUSY;
>> +
>> +	pdev = attest_pdev;
>> +
>> +	miscdev.name = DRIVER_NAME;
>> +	miscdev.minor = MISC_DYNAMIC_MINOR;
>> +	miscdev.fops = &tdx_attest_fops;
>> +	miscdev.parent = dev;
>> +
>> +	ret = misc_register(&miscdev);
>> +	if (ret) {
>> +		pr_err("misc device registration failed\n");
>> +		goto failed;
> 
> Why just not return error here? There is nothing to cleanup

Agree. It came along with patch split I did. I will remove it
in next version.

> 
>> +	}
>> +
>> +	pr_debug("module initialization success\n");
>> +
>> +	return 0;
>> +
>> +failed:
>> +	misc_deregister(&miscdev);
> 
> The only way to get here is if misc_register fails, so we don't need
> this call here.

Yes. It is not required. I will remove it.

> 
>> +
>> +	pr_debug("module initialization failed\n");
>> +
>> +	return ret;
>> +}
>> +
>> +static int tdx_attest_remove(struct platform_device *attest_pdev)
>> +{
>> +	misc_deregister(&miscdev);
>> +	pr_debug("module is successfully removed\n");
>> +	return 0;
>> +}
>> +
>> +static struct platform_driver tdx_attest_driver = {
>> +	.probe		= tdx_attest_probe,
>> +	.remove		= tdx_attest_remove,
>> +	.driver		= {
>> +		.name	= DRIVER_NAME,
>> +	},
>> +};
>> +
>> +static int __init tdx_attest_init(void)
>> +{
>> +	int ret;
>> +
>> +	/* Make sure we are in a valid TDX platform */
>> +	if (!cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
>> +		return -EIO;
>> +
>> +	ret = platform_driver_register(&tdx_attest_driver);
>> +	if (ret) {
>> +		pr_err("failed to register driver, err=%d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	pdev = platform_device_register_simple(DRIVER_NAME, -1, NULL, 0);
> 
> pdev is assigned here and in the probe function. Is it correct?

platform_device_register_simple() seem to trigger probe before it
returns. So assigning it in probe is correct. Here it is redundant (
but not harmful)

Anyway this change will go way in next version when I change the driver
to be a pure "misc driver" and remove the "platform driver" support.

> 
>> +	if (IS_ERR(pdev)) {
>> +		ret = PTR_ERR(pdev);
>> +		pr_err("failed to allocate device, err=%d\n", ret);
>> +		platform_driver_unregister(&tdx_attest_driver);
>> +		return ret;
>> +	}
>> +
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
