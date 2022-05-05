Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4706051C5DA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 19:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382527AbiEERQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236385AbiEERQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:16:27 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213F05C850
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 10:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651770768; x=1683306768;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aKKGEgJMG56VyF3nywLKZxfeSsIEToCBFd8rDzn4p44=;
  b=dHsAGSaKNVBirdfXiaaUw6jdRcnUrVvG67JHsRfaP+by0bkJ+Wf0k0+i
   Vaa14TkCCXaZQB4c/vcNgeTaFmiVHKPVGOqevF/dwS7oat/aCgEkd5ZkA
   QB6GgBBfXEPTpW06eKveHop1THpeLero/wW5tNuiC1EOjg8QYnu39lGck
   KO107CeZRP55rNBH2AXcYupKQpKXfyDYyuNP8pLdBvebilGxSAo0iWart
   x6BABuNRbBT/Rc+HXpi2dulcl/mgovZUthwPZAwjQlWZPs+Zy/X59hzaI
   +37E2Ji6lcPSMtnYjhutZvkHikLKiaiUtu8dsa5ol6UgUCzjpybhyPJVH
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="354623372"
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="354623372"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 10:12:47 -0700
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="694756993"
Received: from evegaag-mobl1.amr.corp.intel.com (HELO [10.209.187.127]) ([10.209.187.127])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 10:12:45 -0700
Message-ID: <12ce24d3-9b46-5c2e-c5c7-c690cb3ca81a@intel.com>
Date:   Thu, 5 May 2022 10:13:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 1/3] x86: Use HALT in default_idle when idle=nomwait
 cmdline arg is passed
Content-Language: en-US
To:     Wyes Karny <wyes.karny@amd.com>, linux-kernel@vger.kernel.org
Cc:     Lewis.Carroll@amd.com, Mario.Limonciello@amd.com,
        gautham.shenoy@amd.com, Ananth.Narayan@amd.com, bharata@amd.com,
        len.brown@intel.com, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, peterz@infradead.org, chang.seok.bae@intel.com,
        keescook@chromium.org, metze@samba.org, zhengqi.arch@bytedance.com,
        mark.rutland@arm.com, puwen@hygon.cn, rafael.j.wysocki@intel.com,
        andrew.cooper3@citrix.com, jing2.liu@intel.com,
        jmattson@google.com, pawan.kumar.gupta@linux.intel.com
References: <20220505104856.452311-1-wyes.karny@amd.com>
 <20220505104856.452311-2-wyes.karny@amd.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220505104856.452311-2-wyes.karny@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/22 03:48, Wyes Karny wrote:
> When kernel is booted with idle=nomwait avoid selecting MWAIT
> as the  default idle state.
> 
> If the user boots the kernel with idle=nomwait, it is a clear
> indication that they do not prefer the use of mwait as the default
> idle state.  However, the current code does not take this into
> consideration while selecting the default idle state on x86.
> 
> This patch fixes it by checking for the idle=nomwait boot option in
> prefer_mwait_c1_over_halt().

There are a couple of places in the existing documentation that talk
about idle=nomwait.  Could you please fix those up to make it clear that
the option is no longer specific to intel_idle?  We don't need a rewrite
or anything, just some small tweaks in the language.
