Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69CE75A1918
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 20:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243635AbiHYSvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 14:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243548AbiHYSv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:51:29 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBCFB72AA;
        Thu, 25 Aug 2022 11:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661453480; x=1692989480;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=L3vWaTTASpx/1u0Gm5leyEzK09XuvW71io7DsaYHZTw=;
  b=FPeyNxRr03wpHNSaO7Phkgm4inbffbEMa8m1tTZdfLjoCZl9UzXgTd5J
   u5V2ICA/4CBQNPY4P+D4KZ/c6oxcPFnAVGAYuGfMOrpwBBjmGQNiQeW50
   +eic6OtI6yYJUWQwJzpwDOb4WmoV1BOP6v39W2uJ66oO2DN8X393G7LR/
   h5KPwt9wEQXtsPLAvI23ZytrbhPhONMh5TNleVNMeXJ1l4wODaLYLySmg
   tchI3v25QjrvbOXbEJbU4ZyMq6dwzPdzNzqPMU91P0yLhXHTAzmrVBPRY
   N6bEz3TzrQK+maoFxiqeOPGlrlY8Xm7STJ57RDMHSC++NNgBTGbCNMBmy
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="295607478"
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="295607478"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 11:51:19 -0700
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="752600007"
Received: from manjeets-mobl.amr.corp.intel.com (HELO [10.212.220.1]) ([10.212.220.1])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 11:51:18 -0700
Message-ID: <88d0f48a-d845-b0ca-b34d-5e22ae82b047@intel.com>
Date:   Thu, 25 Aug 2022 11:51:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] x86/sgx: Do not consider unsanitized pages an error
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, linux-sgx@vger.kernel.org
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
References: <20220825080802.259528-1-jarkko@kernel.org>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220825080802.259528-1-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/22 01:08, Jarkko Sakkinen wrote:
> +	/* Can happen, when the initialization is retracted: */
> +	if (verbose && dirty_count > 0)
> +		pr_info("%d unsanitized pages\n", dirty_count);
>  }
>  
>  static bool sgx_reclaimer_age(struct sgx_epc_page *epc_page)
> @@ -394,11 +403,8 @@ static int ksgxd(void *p)
>  	 * Sanitize pages in order to recover from kexec(). The 2nd pass is
>  	 * required for SECS pages, whose child pages blocked EREMOVE.
>  	 */
> -	__sgx_sanitize_pages(&sgx_dirty_page_list);
> -	__sgx_sanitize_pages(&sgx_dirty_page_list);
> -
> -	/* sanity check: */
> -	WARN_ON(!list_empty(&sgx_dirty_page_list));
> +	__sgx_sanitize_pages(&sgx_dirty_page_list, false);
> +	__sgx_sanitize_pages(&sgx_dirty_page_list, true);

This is backwards, IMNHO.

Make __sgx_sanitize_pages() return the number of pages that it leaves
dirty.

	__sgx_sanitize_pages(&sgx_dirty_page_list)
	left_dirty = __sgx_sanitize_pages(&sgx_dirty_page_list);
	if (left_dirty)
		pr_warn(...);

That rids us of the mystery true/false and puts the pr_warn() in a place
that makes logical sense.  Then, let's either *not* do the

	pr_err_ratelimited(EREMOVE_ERROR_MESSAGE, ret, ret);

at all, or make it an unconditional pr_warn_ratelimited().  They're not
going to be common and multiple messages are virtually worthless anyway.

I actually think a common tracepoint, or out-of-line ENCLS/ENCLU
functions that can be easily ftraced are a much better idea than a
one-off pr_whatever().
