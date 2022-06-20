Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7917C550DFA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 02:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237595AbiFTAgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 20:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiFTAgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 20:36:40 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E13A64D8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655685399; x=1687221399;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=undO36qaqeQkKf8PDzRHO1MNvIA+i6Lo/1oryZ2MsTM=;
  b=AccW8Kd6WUIR3fLKooiSsodOjJ8EjjJCjH70k0r1aQ9to188fLHm1ziy
   5nFApOi6K7QgS1Epi65XAuV4g2ef0Wx4TpEWd7m1tph9z43ergglQPrAm
   HDWXcuXd/S5KKz8Haj5/MtEHCsPviT1rUB7O6HN0ZdItNLyw+0Xd0xw3a
   OokHpXi/Hu/qcON246Ouy+nHEK0sEY4mYxzoAzRkdNSYuPOB3lYXlUiV6
   83PwHeu8m8GqiaPDKGWjXRv3wlIis4SPREjQJZQpwIuXJMq+qbUm2RssN
   0sQzZg6z1CtbfGMLHPnWmAIBiKW7gLqyykamd9PLwyIpLnntLYO4iBD+G
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="343765472"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="343765472"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2022 17:36:38 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="584309252"
Received: from mandalra-mobl.amr.corp.intel.com (HELO [10.251.27.254]) ([10.251.27.254])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2022 17:36:38 -0700
Message-ID: <d0931a48-ac87-c83e-1241-64819b87cf3c@linux.intel.com>
Date:   Sun, 19 Jun 2022 17:36:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v7 0/5] Add TDX Guest Attestation support
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
References: <20220524040517.703581-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20220524040517.703581-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave/Boris/Thomas,

On 5/23/22 9:05 PM, Kuppuswamy Sathyanarayanan wrote:
> Hi All,

Gentle ping!

Can you please let me know your comments on this patch set? This series
is so far reviewed by Kai, Wander, and Isaku. I have addressed all the
comments raised by them. So to progress further, your comments would be
appreciated.

> 
> Intel's Trust Domain Extensions (TDX) protect guest VMs from malicious
> hosts and some physical attacks. VM guest with TDX support is called
> as TD Guest.
> 
> In TD Guest, the attestation process is used to verify the 
> trustworthiness of TD guest to the 3rd party servers. Such attestation
> process is required by 3rd party servers before sending sensitive
> information to TD guests. One usage example is to get encryption keys
> from the key server for mounting the encrypted rootfs or secondary drive.
>     
> Following patches add the attestation support to TDX guest which
> includes attestation user interface driver and related hypercall support.
> 
> Any distribution enabling TDX is also expected to need attestation. So
> enable it by default with TDX guest support. The compiled size is
> quite small (~500 bytes).
> 
> Changes since v6:
>  * Fixed race between wait_for_completion_*() and
>    quote_callback_handler() in tdx_get_quote() when user terminates the
>    request.
>  * Fixed commit log and comments.
> 
> Changes since v5:
>  * Added support for parallel GetQuote requests.
>  * Add noalias variants of set_memory_*crypted() functions to
>    changes page attribute without touching direct map.
>  * Made set_memory_*crypted() functions vmalloc address compatible.
>  * Use vmap()/set_memory_*crypted() functions to share/unshare
>    memory without touching the direct map.
>  * Add support to let driver handle the memory cleanup for the
>    early termination of user requests.
>  * Removed unused headers in attest.c
>  * Fixed commit log and comments as per review comments.
> 
> Changes since v4:
>  * Removed platform driver model in attestation driver and used
>    miscdevice and initcall approach.
>  * Since dma_alloc*() APIs require a valid device reference,
>    replaced it with __get_free_pages() and set_memory_decrypted()
>    for quote memory allocation.
>  * Removed tdx_mcall_tdreport() and moved TDG.MR.REPORT TDCALL code
>    to tdx_get_report().
>  * Used kmalloc() for TDREPORT memory allocation instead of
>    get_zeroed_page().
>  * Returned -EINVAL in default case of tdx_attest_ioctl().
>  * Added struct tdx_report_req to explicitly mention the
>    TDX_CMD_GET_REPORT IOCTL argument.
>  * Removed tdx_get_quote_hypercall() and moved hypercall code to
>    attestation driver itself.
>  * Removed GetQuote timeout support (since it is not defined in
>    spec)
>  * Added support to check for spurious callback interrupt in GetQuote
>    request.
>  * Fixed commit log and comments as per review suggestions.
>    
> 
> Changes since v3:
>  * Moved the attestation driver from platform/x86 to arch/x86/coco/tdx/ and
>    renamed intel_tdx_attest.c to attest.c.
>  * Dropped CONFIG_INTEL_TDX_ATTESTATION and added support to compile
>    attestation changes with CONFIG_INTEL_TDX_GUEST option.
>  * Merged patch titled "x86/tdx: Add tdx_mcall_tdreport() API support" and
>    "platform/x86: intel_tdx_attest: Add TDX Guest attestation interface" into
>    a single patch.
>  * Moved GetQuote IOCTL support changes from patch titled "platform/x86:
>    intel_tdx_attest: Add TDX Guest attestation interface driver" to a
>    separate patch.
>  * Removed 8K size restriction when requesting quote, and added support
>    to let userspace decide the quote size.
>  * Added support to allow attestation agent configure quote generation
>    timeout value.
>  * Fixed commit log and comments as per review comments.
> 
> Changes since v2:
>  * As per Han's suggestion, modified the attestation driver to use
>    platform device driver model.
>  * Modified tdx_hcall_get_quote() and tdx_mcall_tdreport() APIs to
>    return TDCALL error code instead of generic error info (like -EIO).
>  * Removed attestation test app patch from this series to simplify
>    the patchset and review process. Test app patches will be submitted
>    once attestation support patches are merged.
>  * Since patches titled "x86/tdx: Add SetupEventNotifyInterrupt TDX
>    hypercall support" and "x86/tdx: Add TDX Guest event notify
>    interrupt vector support" are related, combining them into a
>    single patch.
> 
> Changes since v1:
>  * Moved test driver from "tools/tdx/attest/tdx-attest-test.c" to
>    "tools/arch/x86/tdx/attest/tdx-attest-test.c" as per Hans review
>    suggestion.
>  * Minor commit log and comment fixes in patches titled
>    "x86/tdx: Add tdx_mcall_tdreport() API support" and "x86/tdx:
>    Add tdx_hcall_get_quote() API support"
>  * Extended tdx_hcall_get_quote() API to accept GPA length as argument
>    to accomodate latest TDQUOTE TDVMCALL related specification update.
>  * Added support for tdx_setup_ev_notify_handler() and
>    tdx_remove_ev_notify_handler() in patch titled "x86/tdx: Add TDX
>    Guest event notify interrupt vector support"
> 
> 
> Kuppuswamy Sathyanarayanan (5):
>   x86/tdx: Add TDX Guest attestation interface driver
>   x86/tdx: Add TDX Guest event notify interrupt support
>   x86/mm: Make tdx_enc_status_changed() vmalloc address compatible
>   x86/mm: Add noalias variants of set_memory_*crypted() functions
>   x86/tdx: Add Quote generation support
> 
>  arch/x86/coco/tdx/Makefile         |   2 +-
>  arch/x86/coco/tdx/attest.c         | 432 +++++++++++++++++++++++++++++
>  arch/x86/coco/tdx/tdx.c            |  84 +++++-
>  arch/x86/include/asm/hardirq.h     |   3 +
>  arch/x86/include/asm/idtentry.h    |   4 +
>  arch/x86/include/asm/irq_vectors.h |   7 +-
>  arch/x86/include/asm/set_memory.h  |   2 +
>  arch/x86/include/asm/tdx.h         |   4 +
>  arch/x86/include/uapi/asm/tdx.h    |  87 ++++++
>  arch/x86/kernel/irq.c              |   7 +
>  arch/x86/mm/pat/set_memory.c       |  26 +-
>  11 files changed, 648 insertions(+), 10 deletions(-)
>  create mode 100644 arch/x86/coco/tdx/attest.c
>  create mode 100644 arch/x86/include/uapi/asm/tdx.h
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
