Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FBD53E9F4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240915AbiFFPgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241232AbiFFPfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:35:43 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA57E4D60C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 08:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654529742; x=1686065742;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aHejLT/VRnChfDayBY6M2GyE/IJnjWN0cBFMUZHN78I=;
  b=lYWsdoE9shJD1ZmnO4O6JEp0P/3ATOQ+n/WOmub9G/p5oe+RSEGery7o
   8gfMyLZfw741f48hhdQ0B2Apno0YcpWDNl3CzRsnJyLT5pBPO2zgawTj6
   IqqCKI700uLa9S9AWeZUGmEHPpGJQ+6bAgZrnWt6bPpLFJvjrQpz1vkTu
   4Ih6mGf3DeHZGx8E0ytV1tf51nQL7E7xncz6ZcloBNVOiOzQ9x8xCpkzS
   6RcPLCg3/v+D0qAicNFvovaYmkOpWlSjR/EwE80neCDvI9RfYOWfD+qpE
   qrbZE0QxCj6CCw/t3gLM/bI1uJhAoG1AvVac1CgoP9nw/Vt0cyKP6EjQ3
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="259045606"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="259045606"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 08:29:50 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="825876855"
Received: from kplovato-mobl1.amr.corp.intel.com (HELO [10.212.186.68]) ([10.212.186.68])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 08:29:50 -0700
Message-ID: <84dc784b-10c9-9ade-7a20-97fe0c32f2ff@intel.com>
Date:   Mon, 6 Jun 2022 08:29:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] x86/mm/tlb: avoid reading mm_tlb_gen when possible
Content-Language: en-US
To:     Nadav Amit <nadav.amit@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
References: <20220322220757.8607-1-namit@vmware.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220322220757.8607-1-namit@vmware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/22 15:07, Nadav Amit wrote:
> +	if (f->new_tlb_gen <= local_tlb_gen) {
> +		/*
> +		 * We are already up to date in respect to f->new_tlb_gen.
> +		 * While the core might be still behind mm_tlb_gen, checking
> +		 * mm_tlb_gen unnecessarily would have negative caching effects
> +		 * so avoid it.
> +		 */
> +		return;
> +	}
> +

Nit: There's at least one "we" in here that needs to get fixed up.  I'll
plan to do that when I apply it, but a v2 with that fixed and Peter's
ack added might save me five minutes.
