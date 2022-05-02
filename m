Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964CD51701A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 15:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385208AbiEBNUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 09:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235101AbiEBNU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 09:20:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 33F40B7DB
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 06:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651497417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7cwYIEVCgK2ZcDFx93WqFNXSS/yGNvEyS5NdQXSjyRE=;
        b=KuEh1X3sFn5fghAS/5r06hv2bvbcB+fqigiNIqfBi1rVpEgbAdbdOKnkgzsU1Ie7LScsHn
        8exe3kMD7vr8xOypjEAePsaruvGb5eJdz68NQ+01Nw6ym1p+/zsAMrB/ENT3xBYUWsIUI7
        rWyW0kv6RUq5xqjZ1XdwS1lN+DYqDoI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-fzoOXCXYMGKzZRnuTYVwLw-1; Mon, 02 May 2022 09:16:53 -0400
X-MC-Unique: fzoOXCXYMGKzZRnuTYVwLw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 702178015BA;
        Mon,  2 May 2022 13:16:52 +0000 (UTC)
Received: from fedora (unknown [10.22.8.190])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3FA28C52C84;
        Mon,  2 May 2022 13:16:49 +0000 (UTC)
Date:   Mon, 2 May 2022 10:16:48 -0300
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
        Kai Huang <kai.huang@intel.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] x86/tdx: Add Quote generation support
Message-ID: <Ym/ZwMUHbgz4av3U@fedora>
References: <20220501183500.2242828-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220501183500.2242828-4-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220501183500.2242828-4-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 01, 2022 at 11:35:00AM -0700, Kuppuswamy Sathyanarayanan wrote:

[snip]

> +
> +static long tdx_get_quote(void __user *argp)
> +{
> +	struct tdx_quote_req quote_req;
> +	long ret = 0;
> +	int order;
> +
> +	/* Hold lock to serialize GetQuote requests */
> +	mutex_lock(&quote_lock);
> +
> +	reinit_completion(&req_compl);
> +
> +	/* Copy GetQuote request struct from user buffer */
> +	if (copy_from_user(&quote_req, argp, sizeof(struct tdx_quote_req))) {
> +		ret = -EFAULT;
> +		goto quote_failed;
> +	}
> +
> +	/* Make sure the length & timeout is valid */
> +	if (!quote_req.len || !quote_req.timeout) {
> +		ret = -EINVAL;
> +		goto quote_failed;
> +	}
> +
> +	/* Get order for Quote buffer page allocation */
> +	order = get_order(quote_req.len);
> +
> +	/*
> +	 * Allocate buffer to get TD Quote from the VMM.
> +	 * Size needs to be 4KB aligned (which is already
> +	 * met in page allocation).
> +	 */
> +	tdquote = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
> +	if (!tdquote) {
> +		ret = -ENOMEM;
> +		goto quote_failed;
> +	}
> +
> +	/*
> +	 * Since this buffer will be shared with the VMM via GetQuote
> +	 * hypercall, decrypt it.
> +	 */
> +	ret = set_memory_decrypted((unsigned long)tdquote, 1UL << order);
> +	if (ret)
> +		goto quote_failed;
> +
> +	/* Copy TDREPORT from user buffer to kernel Quote buffer */
> +	if (copy_from_user(tdquote, (void __user *)quote_req.buf, quote_req.len)) {
> +		ret = -EFAULT;
> +		goto quote_failed;
> +	}
> +
> +	/* Submit GetQuote Request */
> +	ret = tdx_get_quote_hypercall(tdquote, (1ULL << order) * PAGE_SIZE);
> +	if (ret) {
> +		pr_err("GetQuote hypercall failed, status:%lx\n", ret);
> +		ret = -EIO;
> +		goto quote_failed;
> +	}
> +
> +	/* Wait for attestation completion */
> +	ret = wait_for_completion_interruptible(&req_compl);
> +	if (ret <= 0) {
> +		ret = -EIO;
> +		goto quote_failed;
> +	}
> +
> +	/* Copy output data back to user buffer */
> +	if (copy_to_user((void __user *)quote_req.buf, tdquote, quote_req.len))
> +		ret = -EFAULT;
> +

IIUC, ret has a positive value at this point, due to the call to
wait_for_completion_interruptible, so we need add "ret = 0;"
here, don't we?

[snip]

