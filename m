Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6DC516A35
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 07:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383300AbiEBFFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 01:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346303AbiEBFFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 01:05:23 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C66C18B2F
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 22:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651467716; x=1683003716;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wm7gwDXh9BZWcKpELhaTWGGoPu2BD2ENh7B7L0WCkxg=;
  b=BVf0vN0NSjGonh304H0GIHMRiJsZLH/n27jcQL+fK35S7M2kIcJxxZ35
   vZaEmU4g2YcnR/F4pUd9f0nztiCjtrZ8G5KbBstiZnyVsErFYHKyXr7xr
   g53ZEg9cD5rDe5uGbSyIvtMxVaVyvQMSYdoJ4woUsqwPyxUlzvuRZGEuA
   FYyumK+gXvyhh2BUE8N3WaSoFYRu+mvqLRtQVFG/p9fA57VAivY3FfDgN
   flWD1N96mUjwLTFQcj2pjoGoF28QfMpmq12zXc5u09egKyZfWzP2CBc2W
   OoZu23Zmy5875/0yug+52+ALTFYYjU6AX/q7XgbbjRB1rlaYYKtPZ2CYE
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10334"; a="265971855"
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="265971855"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2022 22:01:56 -0700
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="707463129"
Received: from bwu50-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.254.2.219])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2022 22:01:52 -0700
Message-ID: <7daf429ffda2bf834c129899426e204fbbcbd0b0.camel@intel.com>
Subject: Re: [PATCH v5 3/3] x86/tdx: Add Quote generation support
From:   Kai Huang <kai.huang@intel.com>
To:     Kuppuswamy Sathyanarayanan 
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
Date:   Mon, 02 May 2022 17:01:50 +1200
In-Reply-To: <20220501183500.2242828-4-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20220501183500.2242828-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220501183500.2242828-4-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


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
> +quote_failed:
> +	if (tdquote)
> +		free_pages((unsigned long)tdquote, order);

The buffer is freed w/o being converted back to private.  How can you prevent
the buffer from being allocated by kernel and used as private pages again?

Also, the  buffer may be still used by VMM when timeout (IN_FLIGHT), how can
this even work?

> +	tdquote = NULL;
> +	mutex_unlock(&quote_lock);
> +	return ret;
> +}
> +
> +static void attestation_callback_handler(void)
> +{
> +	struct tdx_quote_hdr *quote_hdr;
> +
> +	quote_hdr = (struct tdx_quote_hdr *) tdquote;
> +
> +	/* Check for spurious callback IRQ case */
> +	if (!tdquote || quote_hdr->status == GET_QUOTE_IN_FLIGHT)
> +		return;

I don't get the logic.  Please explain.

> +
> +	complete(&req_compl);
> +}
> +

