Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E160494150
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 20:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiASTvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 14:51:36 -0500
Received: from mga06.intel.com ([134.134.136.31]:42165 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357132AbiASTvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 14:51:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642621869; x=1674157869;
  h=to:cc:references:from:subject:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=IaekLBKy12A7TazDiSD3oKpEQKdqYzsh5NJ4fpWQ560=;
  b=NypGMbBbnupJvXsrtP1e1POQLcoNoTVSebwZjRAXwr7qizAt7QCqFCfW
   K5Xqm2rr2w4zKJROz/4KOkIKTND8owdN+l9llmSqpSa8m1a3/AF1P/7mY
   bXZywQ9r2eJVZ4ehmm0+bcDTF54HHacKPvn3nhkg4xft9vTETC+tUW65j
   zrVmy5wFM8TI0ZNYJNQvHt5T+vBpv9k9xBDybdGcEPvJq9aJTK65vQqq3
   2yUyCSRKWpY6BtZwyskFFNoENNXR3bHtoiPWsm3DnYe8Dhs4p7gZiY+q2
   +JOgiAbd5iIEFYrDzILa6RT/sgIxiPOxy9Q9LBO5kO6H/8jb7XYhYdatE
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="305909489"
X-IronPort-AV: E=Sophos;i="5.88,300,1635231600"; 
   d="scan'208";a="305909489"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 11:51:08 -0800
X-IronPort-AV: E=Sophos;i="5.88,300,1635231600"; 
   d="scan'208";a="475264686"
Received: from rbschuch-mobl.amr.corp.intel.com (HELO [10.212.238.54]) ([10.212.238.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 11:51:08 -0800
To:     Reinette Chatre <reinette.chatre@intel.com>, tony.luck@intel.com,
        dave.hansen@linux.intel.com, jarkko@kernel.org, tglx@linutronix.de,
        bp@alien8.de, luto@kernel.org, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <ef74bd9548df61f77e802e7505affcfb5159c48c.1642545829.git.reinette.chatre@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH] x86/sgx: Add poison handling to reclaimer
Message-ID: <9cefa244-9830-c158-6112-b2c61a464632@intel.com>
Date:   Wed, 19 Jan 2022 11:51:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <ef74bd9548df61f77e802e7505affcfb5159c48c.1642545829.git.reinette.chatre@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/22 3:05 PM, Reinette Chatre wrote:
> The machine check recovery handling in SGX added the changes
> listed below to the freeing of pages in sgx_free_epc_page().
> The SGX reclaimer contains an open coded version of
> sgx_free_epc_page() and thus did not obtain the changes in
> support of poison handling.

I was trying to decide if this is an urgent fix or not.  A more crisp
problem statement might have helped in the changelog.

But, from what I can tell, the most probable troublesome scenario here
would be something like:

 1. Machine check (#MC) occurs (asynchronous, !MF_ACTION_REQUIRED)
 2. arch_memory_failure() called is eventually
 3. (SGX) page->poison set to 1
 4. Page is reclaimed
 5. Page added to normal free lists by sgx_reclaim_pages()
    ^ This is the bug
 6. Page is reallocated by some innocent enclave, a second (synchronous)
    in-kernel #MC is induced, probably during EADD instruction.
    ^ This is the fallout from the bug

#6 is unfortunate and can be avoided if this patch is applied.

Basically, this patch ensures that a bad enclave page is isolated
quickly and causes a minimal amount of collateral damage.  Is this a
valid summary?

	The SGX reclaimer code lacks page poison handling in its free
	path.  This can lead to completely avoidable machine checks if a
	poisoned page is freed and reallocated instead of being
	isolated.
