Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B34B58B003
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 20:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241286AbiHESrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 14:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241416AbiHESrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 14:47:10 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B311EAD3
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 11:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659725230; x=1691261230;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Z8SephuIhT3A9STx6tcHEJqbCFCxP7dfwWiubhwEyek=;
  b=h0VFsVgv/mL8woo9F9oxc1EEpcGjWotS6z0KyZbLycEfqGCqS58hrDx0
   NIfEL3l8rgMFHNeuTyD7dktKrtMRfvkYwjm6V50cs0SKR2fV2p0WUw9dZ
   MzXxjlPIH8ZJfLEnzypJbyfjgaiRYzzNCf5zjPy1RoP+V4FSKNNdNj283
   kTA+d/aWfO2siuXZA91PDM5kP28EMin89kpIiCbMW4t+SfCrgkfI4evoB
   O8ct1SvGzyzSyLUN5SdnUyy9k7yhQAeAUjsSHyUmC5C0za61c/bJdQfp1
   q0OIT2MahqIvffqUJT71QHGFl+QmbniU5+3Cyia6x60v8sXw6d91PEOCm
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="291039064"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="291039064"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 11:47:09 -0700
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="579595428"
Received: from rderber-mobl1.amr.corp.intel.com (HELO [10.212.217.71]) ([10.212.217.71])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 11:47:09 -0700
Message-ID: <5d62c1d0-7425-d5bb-ecb5-1dc3b4d7d245@intel.com>
Date:   Fri, 5 Aug 2022 11:47:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 5/5] x86/entry: Store CPU info on exception entry
Content-Language: en-US
To:     ira.weiny@intel.com, Rik van Riel <riel@surriel.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kernel-team@fb.com
References: <20220805173009.3128098-1-ira.weiny@intel.com>
 <20220805173009.3128098-6-ira.weiny@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220805173009.3128098-6-ira.weiny@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/22 10:30, ira.weiny@intel.com wrote:
> +static inline void arch_save_aux_pt_regs(struct pt_regs *regs)
> +{
> +	struct pt_regs_auxiliary *aux_pt_regs = &to_extended_pt_regs(regs)->aux;
> +
> +	aux_pt_regs->cpu = raw_smp_processor_id();
> +}

This is in a fast path that all interrupt and exception entry uses.  So,
I was curious what the overhead is.

Code generation in irqentry_enter() gets a _bit_ more complicated
because arch_save_aux_pt_regs() has to be done on the way out of the
function and the compiler can't (for instance) do a

	mov    $0x1,%eax
	ret

to return.  But, the gist of the change is still only two instructions
that read a pretty hot, read-only per-cpu cacheline:

	mov    %gs:0x7e21fa4a(%rip),%eax        # 15a38 <cpu_number>
	mov    %eax,-0x8(%rbx)

That doesn't seem too bad.
