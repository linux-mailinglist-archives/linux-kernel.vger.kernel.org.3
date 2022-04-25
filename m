Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE8450E517
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242718AbiDYQG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbiDYQG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:06:27 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAAA10FF7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 09:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650902603; x=1682438603;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=l670SSouoyuWT8a8f0xfOswkjRBp17Vt1prtNQUoRJ4=;
  b=GM6+wdmnZvK9Y91z5dKMUX43G3PBhyIkTsbK5IyWMrIUf069+zyehN3j
   hHK470ie4no5irdlMsHQ0tfdEsUc9EEO1EpSWgZV639n4RyMIe/qfy3Qv
   sRlVawPSjoF0DkLWkU3oO6KI2AVO5OQma22esM/hEcIO98z7OKcHzYdwG
   VCLKw/gvtWKeVLp1XKTl7DiCAqsHssMOZ3AXdKMfcuXEeC6FOaeQ3hEHe
   XPgO5XBTCdxA656b9Pteeet3JJ3xFmj6nOPJGBC5s/Iw7Y79w5akQ/rKI
   IAVwcZAMmx0B6f2elecZ2K13PAi8vr9QEcFWjRkdbkTXdyuCwAajpeAE+
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="252657608"
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="252657608"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 09:03:22 -0700
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="595298684"
Received: from bjkrist-mobl.amr.corp.intel.com (HELO [10.212.88.70]) ([10.212.88.70])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 09:03:21 -0700
Message-ID: <7558ae3d-a1fa-6c11-cccd-ad0f65cde25b@intel.com>
Date:   Mon, 25 Apr 2022 09:05:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] x86/traps: add CONFIG_BUG to the use of __warn()
Content-Language: en-US
To:     Stephen Zhang <starzhangzsd@gmail.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org
Cc:     hpa@zytor.com, peterz@infradead.org, laijs@linux.alibaba.com,
        lihuafei1@huawei.com, fenghua.yu@intel.com,
        chang.seok.bae@intel.com, zhangshida@kylinos.cn,
        linux-kernel@vger.kernel.org
References: <20220425055935.458583-1-starzhangzsd@gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220425055935.458583-1-starzhangzsd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/22 22:59, Stephen Zhang wrote:
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -246,7 +246,9 @@ DEFINE_IDTENTRY_ERRORCODE(exc_control_protection)
>  	pr_err("Missing ENDBR: %pS\n", (void *)instruction_pointer(regs));
>  	if (!ibt_fatal) {
>  		printk(KERN_DEFAULT CUT_HERE);
> +#ifdef CONFIG_BUG
>  		__warn(__FILE__, __LINE__, (void *)regs->ip, TAINT_WARN, regs, NULL);
> +#endif

This really should be done with an #ifdef'd stub in in bug.h, not an
#ifdef at every call site.  I assume there was a good reason for not
using the normal WARN*() macros.
