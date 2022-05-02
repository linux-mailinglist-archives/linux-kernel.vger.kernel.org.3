Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1805B516979
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 04:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357020AbiEBCoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 22:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354699AbiEBCn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 22:43:59 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7587CB86D
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 19:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651459232; x=1682995232;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/YGMfrYTxMbbne12FKu10wyZkVvhumkNt5KrqfxjqUE=;
  b=Y6hk60n3VOvVUin6C1qp0+K7NMqoNU/rkNPwSDhWZ0f/YsH3aHv2vyge
   VtVzvfmZ69bCSBUDgpA3tDkOc0Goo/woak/bkwXR8fqGxrn2YxeOZXjb2
   X1+yWegtHto5TOojWJhGPg++s/+fWRLUcZ/Py4SZ4fnc+qgh3Ufix/bV+
   B0WR/25fxZ/3kT9F3BXqQYXKpdu+o6PGKKFyFl4tEz3cYSju8kc05XWRi
   1Jy4QYbI7cKtsRiGssIiFibff3eH1tXrI5bV1aksw+p2iVAPW1x6SGSTG
   7kHz8GYPcf8TpIbufCo1SFYBQMVpMV7zvGsyAMoHtd1A6RZUsI86Mq4+m
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10334"; a="266972364"
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="266972364"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2022 19:40:32 -0700
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="535644476"
Received: from bwu50-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.254.2.219])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2022 19:40:28 -0700
Message-ID: <243e918c523320ba3d216cbe22d24fe5ce33f370.camel@intel.com>
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
Date:   Mon, 02 May 2022 14:40:26 +1200
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

You can use alloc_pages_exact().

> +
> +	/*
> +	 * Since this buffer will be shared with the VMM via GetQuote
> +	 * hypercall, decrypt it.
> +	 */
> +	ret = set_memory_decrypted((unsigned long)tdquote, 1UL << order);
> +	if (ret)
> +		goto quote_failed;


Again, Dave and Andi already commented you should use vmap() to avoid breaking
up the direct-mapping.  Please use vmap() instead.

https://lore.kernel.org/all/ce0feeec-a949-35f8-3010-b0d69acbbc2e@linux.intel.com/

Will review the rest later.


-- 
Thanks,
-Kai


