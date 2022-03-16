Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6EB4DB519
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 16:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357302AbiCPPoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 11:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357294AbiCPPoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 11:44:14 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E3713E1A;
        Wed, 16 Mar 2022 08:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647445376; x=1678981376;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=Ixp7OhMpuLHg7wYtSO0RbosnpcFuNIgV6KAlovOHN5A=;
  b=GHYvDGzSF9aScylHgvCprSxFoYbsmMcrk642cQFTR+uaG+RPXyNYTsGl
   ZlExH/teClHc4NY5eAGRdDR3K6SyevC2PM2EY18Nnw9KoD8DPoT9aonME
   uUyDCXJacBElgK6Wgbv0Kk7obaFgLaE9gCz0bpxCO1q9bK1VERWUgD54R
   Beb7iGthWP8/IVZiDp4io/AHuQangmz47S97Y6mEWbgQagWaXCA6ZN3p0
   73R+knLWJzOPfM4nyvxNq6KUV38EWn60Mi+L0pM7Vah+OSbrV9izuSy+Z
   1/sy2qf3EuHfaAJODtE61s0AAQUv/EKHnRHn4g1/UKoIKnMVgYWWrCegZ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="281418833"
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="281418833"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 08:42:40 -0700
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="557506601"
Received: from jdwaldem-mobl.amr.corp.intel.com (HELO [10.255.228.230]) ([10.255.228.230])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 08:42:40 -0700
Message-ID: <947c4872-df94-0091-ebbf-b733db4bd9d6@intel.com>
Date:   Wed, 16 Mar 2022 08:42:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Jethro Beekman <jethro@fortanix.com>,
        Cathy Zhang <cathy.zhang@intel.com>, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ashok.raj@intel.com
References: <20220315010300.10199-1-cathy.zhang@intel.com>
 <20220315010300.10199-10-cathy.zhang@intel.com>
 <53e7d3a3-a576-7ef1-fa2d-d170fa1172a1@fortanix.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RFC PATCH v2 09/10] x86/cpu: Call ENCLS[EUPDATESVN] procedure in
 microcode update
In-Reply-To: <53e7d3a3-a576-7ef1-fa2d-d170fa1172a1@fortanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/22 02:46, Jethro Beekman wrote:
>> +void update_cpusvn_intel(void) +{ +	sgx_lock_epc(); +	if
>> (sgx_zap_pages())
> Doing this automatically and unconditionally during a microcode
> update seems undesirable. This requires the userland tooling that is
> coordinating the microcode update to be aware of any SGX enclaves
> that are running and possibly coordinate sequencing with the
> processes containing those enclaves. This coupling does not exist
> today.

"Today" in what?

If a microcode update changes SGX behavior and bumps CPUSVN, it's
fundamentally incompatible with letting enclaves continue to run.  They
might as well be killed.

But, seriously, if you can't handle enclaves being killed every few
months, don't use SGX.  The architecture doesn't allow data to be
persistent like normal x86.  It's fundamental to the architecture.  You
can also think of this as a shiny new SGX *testing* feature: one that
keeps enclave owners from becoming complacent and forgetting about what
the SGX architecture provides.
