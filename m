Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632D94EB60E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 00:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237558AbiC2WfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 18:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237166AbiC2WfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 18:35:02 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BAA14036
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 15:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648593197; x=1680129197;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=5HP1LnLaDP8IRlonCDwlaKozInzB7zqMkrXNpgNKovU=;
  b=bxi0kmAcPIS9jdr85jEdtKkvwyPpuuamB0dYMvGl6FM70sK4VdP76cyg
   /rqTOLa0iq59IMxsusVfK3811D091HIMv4+0kDFuL0buYEB/kNKr9bETi
   TnYh0LV/7dgCC/fURIUoETTzLbnlUIcqLCzbJBk2abXDSTdVUToZyMh3y
   23amY17Hn+8oAb80nfgKfa55HkwqtY8rRz/nCmGeLmBUesY+ZtmGEW7lh
   6xe9CvSGbssTWPTPr5dR3dtgn7/8EUw1CzNoMr6G7CBK8ozvrQ2sQ0zPn
   PHlYlnZTdlJ56heyShlgg1cUcPMH6M34rd7d/5Rlai6w94haGaSIWzMPl
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="239986320"
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="239986320"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 15:33:16 -0700
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="605072142"
Received: from acstuden-mobl.amr.corp.intel.com (HELO [10.209.45.17]) ([10.209.45.17])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 15:33:16 -0700
Message-ID: <066bbff7-d2fe-44d3-0245-ccbcb5990257@intel.com>
Date:   Tue, 29 Mar 2022 15:33:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Matthias Welwarsky <matthias.welwarsky@sysgo.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, x86-ml <x86@kernel.org>
References: <3422754.iIbC2pHGDl@linux-3513> <Yj49F1pnehy3ga5U@zn.tnic>
 <d9d0405e-b118-b028-d26f-fbb8de4e7a0e@intel.com>
 <3346653.QJadu78ljV@linux-3513>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: x86, possible bug in __memmove() alternatives patching
In-Reply-To: <3346653.QJadu78ljV@linux-3513>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/22 04:39, Matthias Welwarsky wrote:
> 
>> But, we do try to make the kernel work even the face of funky
>> hypervisors that do things that never occur on real hardware.  If a nice
>> patch to fix this up showed up, I'd definitely take a look.
> The question is whether a sequence like this could be relevant:
> 
> 0) CPU announces feature FSRM through cpuid
> 1) BIOS/firmware disables fast string ops through IA32_MISC_ENABLE before 
> loading kernel (for whatever reason)
> 2) Kernel populates features from cpuid
> 3) Kernel clears ERMS based on IA32_MISC_ENABLE
> 4) "alternatives" patching destroys __memmove()

Hi Matthias,

What does "destroys __memmove()" mean in practice?  What's the end-user
visible effect of this?  Do they see a crash or just crummy performance?
