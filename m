Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B976C513B0E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 19:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350594AbiD1Rsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 13:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350586AbiD1Rsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 13:48:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A42685643
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 10:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651167919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EsNsg8EauWEL29++/mUUWJlPTSHzrfQjwpW0zMDmrLk=;
        b=fkMdJCnDslxlvNrBui21U51OsELAnD7pimEPvybt6mT44nBKB1VyFI3IUWZQHlrbDJpcg6
        d6bZVUC5b3nfoJGwZfHtNhqhfuo0+8ZvGuzxoQVyZp8jk9gT9gTL2ITMfyRiZWqZ8bgdOi
        bf5cuWyYTP517ssiPhJ9oxcQyDxB+hM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-168-3AaWlVDlMRWYASuPlPqqvA-1; Thu, 28 Apr 2022 13:45:16 -0400
X-MC-Unique: 3AaWlVDlMRWYASuPlPqqvA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A521A800882;
        Thu, 28 Apr 2022 17:45:15 +0000 (UTC)
Received: from fedora (unknown [10.22.33.56])
        by smtp.corp.redhat.com (Postfix) with SMTP id 40423C2813D;
        Thu, 28 Apr 2022 17:45:13 +0000 (UTC)
Date:   Thu, 28 Apr 2022 14:45:12 -0300
From:   Wander Lairson Costa <wander@redhat.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] x86/tdx: Add TDX Guest attestation interface
 driver
Message-ID: <YmrSqEBHXZvWs4a0@fedora>
References: <20220422233418.1203092-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220422233418.1203092-2-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422233418.1203092-2-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 04:34:16PM -0700, Kuppuswamy Sathyanarayanan wrote:

[snip]

> +static long tdx_get_tdreport(void __user *argp)
> +{
> +	void *report_buf = NULL, *tdreport_buf = NULL;
> +	long ret = 0, err;
> +
> +	/* Allocate space for report data */
> +	report_buf = kmalloc(TDX_REPORT_DATA_LEN, GFP_KERNEL);
> +	if (!report_buf)
> +		return -ENOMEM;
> +
> +	/*
> +	 * Allocate space for TDREPORT buffer (1024-byte aligned).
> +	 * Full page alignment is more than enough.
> +	 */
> +	tdreport_buf = (void *)get_zeroed_page(GFP_KERNEL);

Maybe we should add BUILD_BUG_ON(TDX_TDREPORT_LEN > PAGE_SIZE)

> +	if (!tdreport_buf) {
> +		ret = -ENOMEM;
> +		goto tdreport_failed;
> +	}
> +
> +	/* Copy report data to kernel buffer */
> +	if (copy_from_user(report_buf, argp, TDX_REPORT_DATA_LEN)) {
> +		ret = -EFAULT;
> +		goto tdreport_failed;
> +	}
> +
> +	/* Generate TDREPORT using report data in report_buf */
> +	err = tdx_mcall_tdreport(tdreport_buf, report_buf);
> +	if (err) {
> +		/* If failed, pass TDCALL error code back to user */
> +		ret = put_user(err, (long __user *)argp);

The assigment to ret is useless here

> +		ret = -EIO;
> +		goto tdreport_failed;
> +	}
> +
> +	/* Copy TDREPORT data back to user buffer */
> +	if (copy_to_user(argp, tdreport_buf, TDX_TDREPORT_LEN))
> +		ret = -EFAULT;
> +
> +tdreport_failed:
> +	kfree(report_buf);
> +	if (tdreport_buf)
> +		free_pages((unsigned long)tdreport_buf, 0);
> +
> +	return ret;
> +}
> +
> +static long tdx_attest_ioctl(struct file *file, unsigned int cmd,
> +			     unsigned long arg)
> +{
> +	void __user *argp = (void __user *)arg;
> +	long ret = 0;
> +
> +	switch (cmd) {
> +	case TDX_CMD_GET_TDREPORT:
> +		ret = tdx_get_tdreport(argp);
> +		break;
> +	default:
> +		pr_err("cmd %d not supported\n", cmd);

Shouldn't we add "ret = -EINVAL" here?

> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct file_operations tdx_attest_fops = {
> +	.owner		= THIS_MODULE,
> +	.unlocked_ioctl	= tdx_attest_ioctl,
> +	.llseek		= no_llseek,
> +};
> +
> +static int tdx_attest_probe(struct platform_device *attest_pdev)
> +{
> +	struct device *dev = &attest_pdev->dev;
> +	long ret = 0;
> +
> +	/* Only single device is allowed */
> +	if (pdev)
> +		return -EBUSY;
> +
> +	pdev = attest_pdev;
> +
> +	miscdev.name = DRIVER_NAME;
> +	miscdev.minor = MISC_DYNAMIC_MINOR;
> +	miscdev.fops = &tdx_attest_fops;
> +	miscdev.parent = dev;
> +
> +	ret = misc_register(&miscdev);
> +	if (ret) {
> +		pr_err("misc device registration failed\n");
> +		goto failed;

Why just not return error here? There is nothing to cleanup

> +	}
> +
> +	pr_debug("module initialization success\n");
> +
> +	return 0;
> +
> +failed:
> +	misc_deregister(&miscdev);

The only way to get here is if misc_register fails, so we don't need
this call here.

> +
> +	pr_debug("module initialization failed\n");
> +
> +	return ret;
> +}
> +
> +static int tdx_attest_remove(struct platform_device *attest_pdev)
> +{
> +	misc_deregister(&miscdev);
> +	pr_debug("module is successfully removed\n");
> +	return 0;
> +}
> +
> +static struct platform_driver tdx_attest_driver = {
> +	.probe		= tdx_attest_probe,
> +	.remove		= tdx_attest_remove,
> +	.driver		= {
> +		.name	= DRIVER_NAME,
> +	},
> +};
> +
> +static int __init tdx_attest_init(void)
> +{
> +	int ret;
> +
> +	/* Make sure we are in a valid TDX platform */
> +	if (!cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
> +		return -EIO;
> +
> +	ret = platform_driver_register(&tdx_attest_driver);
> +	if (ret) {
> +		pr_err("failed to register driver, err=%d\n", ret);
> +		return ret;
> +	}
> +
> +	pdev = platform_device_register_simple(DRIVER_NAME, -1, NULL, 0);

pdev is assigned here and in the probe function. Is it correct?

> +	if (IS_ERR(pdev)) {
> +		ret = PTR_ERR(pdev);
> +		pr_err("failed to allocate device, err=%d\n", ret);
> +		platform_driver_unregister(&tdx_attest_driver);
> +		return ret;
> +	}
> +

