Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14365492C58
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 18:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347256AbiARR2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 12:28:54 -0500
Received: from mga17.intel.com ([192.55.52.151]:57294 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235427AbiARR2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 12:28:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642526929; x=1674062929;
  h=to:cc:references:from:subject:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=k4eJH2zoU91Kl9uf4FCGcvt/8O88IEchGIaQVuOy/n8=;
  b=nerDM3vl20D3blaYkn3ET5kzoRYfP5UXAgBiiGpn3RYgh3DH5dbE96wd
   CwhyS5KI99BB4b73tzfBIZUL9Wb/E+cgV4IpsvjH2vbiv9nfYGa4ZemWz
   /7g7yWHu8HG+vY1oyMFtIGji6Tmsjb8vHzKB0tLir2CMTINvWMiPWBsMt
   7XMWC73wUfvapC47uwwMgb1RjvC4DBy+xVAZ5+F9KSQr8GNGILPrwtI6R
   3YygNGtdDYfTJ0MAMeQEkKQPp5Tbzdu06HG+ceif3rlCOB6LYJm13EMQb
   ZaWNbmqajXCil9yMBMypndKMFd+HFuB8MBZBhCU+fPZt/Itb0t+YvRTAd
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="225545861"
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="225545861"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 09:28:48 -0800
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="764657295"
Received: from ssrikan2-mobl2.amr.corp.intel.com (HELO [10.209.52.128]) ([10.209.52.128])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 09:28:47 -0800
To:     Nicholas Piggin <npiggin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>, x86@kernel.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
References: <20211227145903.187152-1-wangkefeng.wang@huawei.com>
 <20211227145903.187152-4-wangkefeng.wang@huawei.com>
 <70ff58bc-3a92-55c2-2da8-c5877af72e44@intel.com>
 <3858de1f-cdbc-ff52-2890-4254d0f48b0a@huawei.com>
 <31a75f95-6e6e-b640-2d95-08a95ea8cf51@intel.com>
 <1642472965.lgfksp6krp.astroid@bobo.none>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v2 3/3] x86: Support huge vmalloc mappings
Message-ID: <4488d39f-0698-7bfd-b81c-1e609821818f@intel.com>
Date:   Tue, 18 Jan 2022 09:28:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1642472965.lgfksp6krp.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/22 6:46 PM, Nicholas Piggin wrote:
>> This all sounds very fragile to me.  Every time a new architecture would
>> get added for huge vmalloc() support, the developer needs to know to go
>> find that architecture's module_alloc() and add this flag.
> This is documented in the Kconfig.
> 
>  #
>  #  Archs that select this would be capable of PMD-sized vmaps (i.e.,
>  #  arch_vmap_pmd_supported() returns true), and they must make no assumptions
>  #  that vmalloc memory is mapped with PAGE_SIZE ptes. The VM_NO_HUGE_VMAP flag
>  #  can be used to prohibit arch-specific allocations from using hugepages to
>  #  help with this (e.g., modules may require it).
>  #
>  config HAVE_ARCH_HUGE_VMALLOC
>          depends on HAVE_ARCH_HUGE_VMAP
>          bool
> 
> Is it really fair to say it's *very* fragile? Surely it's reasonable to 
> read the (not very long) documentation ad understand the consequences for
> the arch code before enabling it.

Very fragile or not, I think folks are likely to get it wrong.  It would
be nice to have it default *everyone* to safe and slow and make *sure*
they go look at the architecture modules code itself before enabling
this for modules.

Just from that Kconfig text, I don't think I'd know off the top of my
head what do do for x86, or what code I needed to go touch.
