Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA719546958
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 17:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242177AbiFJPYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 11:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbiFJPYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 11:24:40 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7015213D23
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 08:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654874679; x=1686410679;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZmN9F24xfWub7ZpgfngTxQnTs9AUGNWnHWe661GnoRc=;
  b=EUtSgflbWRWV5N/1YhU/UBtRPvSPC94sydprxvErCOhiPF8jxXr15CmP
   J3JoXInzL13th2zOOs61RYHTcV0bZcNHsS5rO1ddDXGmUn1K+jlBijd6T
   saCClYtOGY1lLEd1kIHnedSK3POM/EGPZbwsvyEhkDfxerHy3B6xdJDos
   FmiVatJcNl5QTfMyMLv1rWu49M/+MIoa9FVVK4GxiZn4SouxoW322g5Rf
   5by6uEQbR0IALU8q+8IfDYBdzNjmmazO+o4AVPb3cSHaVb4y5WH06V0iF
   743w6UL6znO1BXlbf8op7N0azRGXqu2D5XbDIObhJhW3Fb44gbHz8ByuK
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="278457627"
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="278457627"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 08:24:39 -0700
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="710980278"
Received: from cpatrick-mobl.amr.corp.intel.com (HELO [10.209.109.10]) ([10.209.109.10])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 08:24:38 -0700
Message-ID: <144af1ab-1e7e-b75c-331c-d9c2e55b9062@intel.com>
Date:   Fri, 10 Jun 2022 08:24:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCHv3 7/8] x86: Expose untagging mask in
 /proc/$PID/arch_status
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
 <20220610143527.22974-8-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220610143527.22974-8-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/22 07:35, Kirill A. Shutemov wrote:
> +/*
> + * Report architecture specific information
> + */
> +int proc_pid_arch_status(struct seq_file *m, struct pid_namespace *ns,
> +			struct pid *pid, struct task_struct *task)
> +{
> +	/*
> +	 * Report AVX512 state if the processor and build option supported.
> +	 */
> +	if (cpu_feature_enabled(X86_FEATURE_AVX512F))
> +		avx512_status(m, task);
> +
> +	seq_printf(m, "untag_mask:\t%#lx\n", mm_untag_mask(task->mm));
> +
> +	return 0;
> +}

Arch-specific gunk is great for, well, arch-specific stuff.  AVX-512 and
its, um, "quirks", really won't show up anywhere else.  But x86 isn't
even the first to be doing this address tagging business.

Shouldn't we be talking to the ARM folks about a common way to do this?
