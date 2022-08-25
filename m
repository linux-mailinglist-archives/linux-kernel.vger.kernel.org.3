Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439005A14EA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 16:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235964AbiHYO5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 10:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241332AbiHYO5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 10:57:15 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765DD72868;
        Thu, 25 Aug 2022 07:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661439434; x=1692975434;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=AIV/1fa6hC34uyOtftiFooG6bWuzydBKflOscvVox/0=;
  b=WP9R7XWphqdbl2jXpiA46Cqpa/Q6Zcz3Y4FwbU7bOdvkF3J2lL31kALw
   7eYzNzV+RMccsmXE2Jd00yuqlAudZfHMmvJ3ZQN/zO+2ygvdJMh1XAhzZ
   tVDF+H4JhaN5sktymE5M0JMkBAuYFzViRx8KeCP14hBs1wZHa/r8/MFe+
   UoSRrLJtYHNeFM0yhsmTATOAINStB2OmQnTE/JtsyCIY3/xGoX36z9P1y
   3SdxAg8V7eRJKJE+RgoVtw+37S1UGmpOM0SHTz4jJ6PNJHIvbhtY3H+3N
   QUl1GX1HXAQi9u4qhBM+n7oSz3aAaR80aj3e+3+7y53YJqlhPnDLU2mBa
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="293000440"
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="293000440"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 07:57:13 -0700
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="643279436"
Received: from hhuan26-mobl1.amr.corp.intel.com (HELO hhuan26-mobl1.mshome.net) ([10.212.105.25])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 25 Aug 2022 07:57:12 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     linux-sgx@vger.kernel.org, "Jarkko Sakkinen" <jarkko@kernel.org>
Cc:     "Paul Menzel" <pmenzel@molgen.mpg.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] x86/sgx: Do not consider unsanitized pages an error
References: <20220825080802.259528-1-jarkko@kernel.org>
Date:   Thu, 25 Aug 2022 09:57:11 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel Corp
Message-ID: <op.1rgo5llowjvjmi@hhuan26-mobl1.mshome.net>
In-Reply-To: <20220825080802.259528-1-jarkko@kernel.org>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On Thu, 25 Aug 2022 03:08:02 -0500, Jarkko Sakkinen <jarkko@kernel.org>  
wrote:

> If sgx_dirty_page_list ends up being non-empty, currently this triggers
> WARN_ON(), which produces a lot of noise, and can potentially crash the
> kernel, depending on the kernel command line.
>
> However, if the SGX subsystem initialization is retracted, the  
> sanitization
> process could end up in the middle, and sgx_dirty_page_list be left
> non-empty for legit reasons.
>
> Replace this faulty behavior with more verbose version
> __sgx_sanitize_pages(), which can optionally print EREMOVE error code and
> the number of unsanitized pages.
>
> Link:  
> https://lore.kernel.org/linux-sgx/20220825051827.246698-1-jarkko@kernel.org/T/#u
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Fixes: 51ab30eb2ad4 ("x86/sgx: Replace section->init_laundry_list with  
> sgx_dirty_page_list")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>
> Cc: Haitao Huang <haitao.huang@linux.intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Reinette Chatre <reinette.chatre@intel.com>
> ---
> v3:
> - Remove WARN_ON().
> - Tuned comments and the commit message a bit.
>
> v2:
> - Replaced WARN_ON() with optional pr_info() inside
>   __sgx_sanitize_pages().
> - Rewrote the commit message.
> - Added the fixes tag.
> ---
>  arch/x86/kernel/cpu/sgx/main.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/sgx/main.c  
> b/arch/x86/kernel/cpu/sgx/main.c
> index 515e2a5f25bb..d204520a5e26 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -50,16 +50,17 @@ static LIST_HEAD(sgx_dirty_page_list);
>   * from the input list, and made available for the page allocator. SECS  
> pages
>   * prepending their children in the input list are left intact.
>   */
> -static void __sgx_sanitize_pages(struct list_head *dirty_page_list)
> +static void __sgx_sanitize_pages(struct list_head *dirty_page_list,  
> bool verbose)
>  {
>  	struct sgx_epc_page *page;
> +	int dirty_count = 0;
>  	LIST_HEAD(dirty);
>  	int ret;
> 	/* dirty_page_list is thread-local, no need for a lock: */

Just a nitpick,
Although it is not added in this patch, the above comment is not accurate.
The list is accessed one thread only: filled first in main thread, then
only ever accessed here.

IIUC, could you remove or update that comment?

Other than that, FWIW:
Reviewed-by: Haitao Huang <haitao.huang@linux.intel.com>
Thanks
Haitao
