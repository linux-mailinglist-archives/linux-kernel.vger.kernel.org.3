Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513B6534100
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 18:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbiEYQFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 12:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245187AbiEYQF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 12:05:27 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C89B41E8
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 09:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653494720; x=1685030720;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XacTBAWaGoPSK7ToURQLq4UISvcQ3WYB1UZRddunuSM=;
  b=AGxnkzonfLJAU+CIrFvGwbUP3RAYg7dwVMFGPqKK03YqyGIsDqf7Oy6U
   VWmTDkE3pSe9vrWvp9ZNymYau1twFXyRhLsdnKxTC7N4Xg3z1HIxnBRrp
   Tyc9uInhabfKCQ7Ppqr7dnVxDV4Tw3jS4hDofhqIonesrmaQvd/yEz45X
   b4fhdNeleaCGykli8vB66iGZaQjI+TWoeoi1M3P2tNWTlnh3Zu7jPbG/L
   Nt+CEOdolg4SmVgrsRVwYUBggsAGxwe0C6Zc5NjV1R2pKI/1DDp+7PFGf
   W+G5UAsPIuymYKkP/I0mU77DMoEKbPLRZhNxGP5JTgPBX2gvubb2JgD7G
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="273854939"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="273854939"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 09:02:51 -0700
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="717812096"
Received: from hdovel-mobl2.amr.corp.intel.com (HELO [10.212.167.109]) ([10.212.167.109])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 09:02:50 -0700
Message-ID: <89f55141-a71c-1fd8-e1be-96355c63c03a@intel.com>
Date:   Wed, 25 May 2022 09:02:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCHv3 2/3] x86/tdx: Clarify RIP adjustments in #VE handler
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org
Cc:     ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        thomas.lendacky@amd.com, x86@kernel.org
References: <20220524221012.62332-1-kirill.shutemov@linux.intel.com>
 <20220524221012.62332-3-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220524221012.62332-3-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/22 15:10, Kirill A. Shutemov wrote:
> +static int ve_instr_len(struct ve_info *ve)
> +{
> +	/*
> +	 * If the #VE happened due to instruction execution, GET_VEINFO
> +	 * provides info on the instruction.
> +	 *
> +	 * For #VE due to EPT violation, info provided by GET_VEINFO not usable
> +	 * and kernel has to decode instruction manually to find out its
> +	 * length. Catch such cases.
> +	 */
> +	if (WARN_ON_ONCE(ve->exit_reason == EXIT_REASON_EPT_VIOLATION))
> +		return 0;
> +
> +	return ve->instr_len;
> +}

I'm not super happy with how this comment ended up.  First, let's put
the comment next to the code to which it applies, like:

	/*
	 * ve->instr_len is not defined for EPT violations.  For those,
	 * the kernel must decode instructions manually and should not
	 * be using this function.
	 */
	if (WARN_ON_ONCE(ve->exit_reason == EXIT_REASON_EPT_VIOLATION))
		return 0;

	/*
	 * Assume that the #VE occurred due to instruction execution.
	 */
	return ve->instr_len;

Second, there also needs to be *something* here to link this back to the
TDX module spec and the VMCS documentation.  To make actual sense of
this, you need to tie together something like three or four pieces of
disparate information scattered across two massive documents.

Intel really made this quite the scavenger hunt.  Time to atone for the
sins of your colleagues by tying all of those things together in one place.
