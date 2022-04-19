Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDFFA507984
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 20:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344973AbiDSTAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 15:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbiDSTAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 15:00:32 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37BA3ED36
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650394669; x=1681930669;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=f+W2Ih8aKCmt5L8CYbVsox9snHwPTAi539aEQEoULyk=;
  b=lM2V88v71V/35Q+xmR5Vd8s3RwkdqzF2f2xXv8f/HFufEcgf+XU0xXkJ
   GnAWoIJLLCwvgQdajxN5nv/Z+QpGwwd2Qrur47cNjnhtYnCp/L8kKMP22
   4rcXAx1oRRWQKX12ucWqq7Vmdam1YoPOx/bYm/2FRosc39N6/knQIpYkL
   7zMSoeeRx3+RHxlRqT8bllbfiE/hn7r2VWJ7N+8pdBgal558+MZyfoYxU
   L2OP0bfVHwpLKbiWOKdE3T1sJaLxNbk3XmC/CXFIYfPrvF7g8w1PePHbr
   rP+8nsWbNiL6E+Vas8XulN6k7Gq14yKiKQGe2UUPDavPp4j4PaFVmp2aj
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="262704958"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="262704958"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 11:57:49 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="530625361"
Received: from sazizi-mobl2.amr.corp.intel.com (HELO [10.212.98.167]) ([10.212.98.167])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 11:57:48 -0700
Message-ID: <3f27999a-35bc-3499-2bf8-afd0e8666068@intel.com>
Date:   Tue, 19 Apr 2022 11:57:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220419143545.30295-1-rppt@kernel.org>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH] x86/mm/ptdump: display page encryption state
In-Reply-To: <20220419143545.30295-1-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/22 07:35, Mike Rapoport wrote:
> When memory encryption is enabled, for instance in SEV guest, it is useful
> to see what memory ranges are mapped as encrypted in the kernel page tables
> and what ranges are left plain.
> 
> Add printing of 'ENC' for the encrypted ranges to the page table dumps.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/x86/mm/dump_pagetables.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
> index e1b599ecbbc2..187dd17b8780 100644
> --- a/arch/x86/mm/dump_pagetables.c
> +++ b/arch/x86/mm/dump_pagetables.c
> @@ -201,6 +201,10 @@ static void printk_prot(struct seq_file *m, pgprotval_t pr, int level, bool dmsg
>  			pt_dump_cont_printf(m, dmsg, "PCD ");
>  		else
>  			pt_dump_cont_printf(m, dmsg, "    ");
> +		if (pr & _PAGE_ENC)
> +			pt_dump_cont_printf(m, dmsg, "ENC ");
> +		else
> +			pt_dump_cont_printf(m, dmsg, "    ");

_PAGE_ENC is AMD-specific.  Could we do this with a new generic "cc_"
function, maybe cc_is_enc()?

Something like this would (I think) work for both SEV and TDX:

bool cc_is_enc(u64 prot)
{
	return cc_mkdec(prot) != prot;
}
