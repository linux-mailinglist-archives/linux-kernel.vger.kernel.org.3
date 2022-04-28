Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDED513B25
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 19:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350669AbiD1SCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 14:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345831AbiD1SCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 14:02:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BAB9EBB088
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 10:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651168736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cIjpgsiLsw3XcYdc/Hr1MoGaRlP4zUefffh+YhKfGsI=;
        b=J8UU11ZJokZAullUlrMg+p8n2ZOMjTpmGHcXA/ShfBT9wyn+ZTR6ydgrUwf/eBszbXavip
        2ZRn2KAZkXEZbmzyeaxx/WrzKbgjSysTqNnZoyrDTH45y+gm0vmPThO+X+dTMxwY6B91X8
        QxjAivVzIIt/V5IJ216BfdyxsXRDPKo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-468-ZiLh68HvNo-ThRqG6eU8rQ-1; Thu, 28 Apr 2022 13:58:46 -0400
X-MC-Unique: ZiLh68HvNo-ThRqG6eU8rQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 88B263C0E182;
        Thu, 28 Apr 2022 17:58:45 +0000 (UTC)
Received: from fedora (unknown [10.22.33.56])
        by smtp.corp.redhat.com (Postfix) with SMTP id 26BA2574B5B;
        Thu, 28 Apr 2022 17:58:43 +0000 (UTC)
Date:   Thu, 28 Apr 2022 14:58:42 -0300
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
Subject: Re: [PATCH v4 3/3] x86/tdx: Add Quote generation support
Message-ID: <YmrV0uYMBCSq7xNK@fedora>
References: <20220422233418.1203092-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220422233418.1203092-4-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422233418.1203092-4-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 04:34:18PM -0700, Kuppuswamy Sathyanarayanan wrote:

[snip]

> +static long tdx_get_tdquote(void __user *argp)
> +{
> +	struct tdx_quote_hdr *quote_hdr;
> +	struct tdx_quote_req quote_req;
> +	void *quote_buf = NULL;
> +	dma_addr_t handle;
> +	long ret = 0, err;
> +	u64 quote_buf_len;
> +
> +	mutex_lock(&quote_lock);
> +
> +	reinit_completion(&req_compl);
> +
> +	/* Copy Quote request struct from user buffer */
> +	if (copy_from_user(&quote_req, argp, sizeof(struct tdx_quote_req)))
> +		return -EFAULT;
> +
> +	/* Make sure the length & timeout is valid */
> +	if (quote_req.len <= 0 || quote_req.timeout <= 0)

len and timeout are unsigned values, so they will never be negative.

> +		return -EINVAL;
> +
> +	/* Align with page size to meet 4K alignment */
> +	quote_buf_len = PAGE_ALIGN(quote_req.len);
> +
> +	/*
> +	 * Allocate DMA buffer to get TDQUOTE data from the VMM.
> +	 * dma_alloc_coherent() API internally marks allocated
> +	 * memory as shared with VMM. So explicit shared mapping is
> +	 * not required.
> +	 */
> +	quote_buf = dma_alloc_coherent(&pdev->dev, quote_buf_len, &handle,
> +					GFP_KERNEL | __GFP_ZERO);
> +	if (!quote_buf) {
> +		ret = -ENOMEM;
> +		goto quote_failed;
> +	}
> +
> +	/* Copy TDREPORT from user Quote data buffer to kernel Quote buffer */
> +	if (copy_from_user(quote_buf, (void __user *)quote_req.buf, quote_req.len)) {
> +		ret = -EFAULT;
> +		goto quote_failed;
> +	}
> +
> +	/* Submit GetQuote Request */
> +	err = tdx_hcall_get_quote(quote_buf, quote_buf_len);
> +	if (err) {
> +		/* if failed, copy hypercall error code to user buffer */
> +		ret = put_user(err, (long __user *)argp);

The assigment to ret is unused.

> +		ret = -EIO;
> +		goto quote_failed;
> +	}
> +
> +	/* Wait for attestation completion */
> +	ret = wait_for_completion_interruptible_timeout(
> +			&req_compl,
> +			msecs_to_jiffies(quote_req.timeout));
> +	if (ret <= 0) {
> +		ret = -EIO;
> +		goto quote_failed;
> +	}
> +
> +	/* Copy generated Quote data back to user buffer */
> +	if (copy_to_user((void __user *)quote_req.buf, quote_buf, quote_buf_len)) {

Shouldn't we use quote_req.len instead of quote_buf_len here?

> +		ret = -EFAULT;
> +		goto quote_failed;
> +	}
> +
> +	quote_hdr = (struct tdx_quote_hdr *)quote_buf;
> +
> +	/* Make sure quote generation is successful */
> +	if (!quote_hdr->status)
> +		ret = 0;
> +	else
> +		ret = -EIO;
> +

Shouldn't copy_to_user be called after checking the status?

> +quote_failed:
> +	if (quote_buf)
> +		dma_free_coherent(&pdev->dev, quote_buf_len, quote_buf, handle);
> +
> +	mutex_unlock(&quote_lock);
> +
> +	return ret;
> +}
> +
> +static void attestation_callback_handler(void)
> +{
> +	complete(&req_compl);
> +}
> +
>  static long tdx_attest_ioctl(struct file *file, unsigned int cmd,
>  			     unsigned long arg)
>  {
> @@ -89,6 +183,9 @@ static long tdx_attest_ioctl(struct file *file, unsigned int cmd,
>  	case TDX_CMD_GET_TDREPORT:
>  		ret = tdx_get_tdreport(argp);
>  		break;
> +	case TDX_CMD_GEN_QUOTE:
> +		ret = tdx_get_tdquote(argp);
> +		break;
>  	default:
>  		pr_err("cmd %d not supported\n", cmd);
>  		break;
> @@ -103,6 +200,14 @@ static const struct file_operations tdx_attest_fops = {
>  	.llseek		= no_llseek,
>  };
>  
> +/* Helper function to cleanup attestation related allocations */
> +static void _tdx_attest_remove(void)
> +{
> +	misc_deregister(&miscdev);

Won't misc_deregister be called even if misc_register fails?

> +
> +	tdx_remove_ev_notify_handler();
> +}
> +

