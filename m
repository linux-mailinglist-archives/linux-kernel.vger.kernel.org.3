Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1424DB544
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 16:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357373AbiCPPsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 11:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357378AbiCPPsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 11:48:43 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D3D6D390;
        Wed, 16 Mar 2022 08:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647445649; x=1678981649;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=BrzHWmqSAHVQTAHSUYYjuNm7pNzr8pYle8SOGv/r6GU=;
  b=b/gLlPjo+GNMXH0FpOx/NfcTwWyfOZVqa6qYElT/VsEJVc7NuRK4gc5+
   VONr6SKWcTAGlPDBCqC5edqCdtTsOnzqj4wKNWxGGaGRVNuBIjtxNBam3
   NMPJUNyYjJabJSJu7GUvYjubzFlqXEXF5eoHOMmwMzp5CFLyMpfPn44eh
   p67BBddpxwJGAf31Tl1Oe/6875KkHuceHWHGyy5i/MMoAWXuXvRmLiG1F
   xby6kxQgM4RF0YFgQmupStrgbRn8LQmMl0Wt7wcg62UeoF2q33QAblyXb
   EY7jaPaTar3V2SNjDUTrEP57FSLssC1FAJ0X3k5fqBG8btb5CdJFyqY0y
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="343072053"
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="343072053"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 08:47:29 -0700
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="557509706"
Received: from jdwaldem-mobl.amr.corp.intel.com (HELO [10.255.228.230]) ([10.255.228.230])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 08:47:29 -0700
Message-ID: <e121e972-7689-b2f3-5919-746e3a90cb36@intel.com>
Date:   Wed, 16 Mar 2022 08:47:23 -0700
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
 <e1682971-4821-8e57-3232-de7a72086991@fortanix.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RFC PATCH v2 09/10] x86/cpu: Call ENCLS[EUPDATESVN] procedure in
 microcode update
In-Reply-To: <e1682971-4821-8e57-3232-de7a72086991@fortanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/22 03:24, Jethro Beekman wrote:
>> Doing this automatically and unconditionally during a microcode
>> update seems undesirable. This requires the userland tooling that
>> is coordinating the microcode update to be aware of any SGX
>> enclaves that are running and possibly coordinate sequencing with
>> the processes containing those enclaves. This coupling does not
>> exist today.
> Also, a microcode update may not affect SGX security at all and doing
> the EUPDATESVN procedure may not be required for this particular
> update. This case is called out specifically in the EUPDATESVN
> documentation.

I don't think Intel provides the metadata for the kernel to tell if an
update requires an EUPDATESVN procedure or not.  If this is inconvenient
for you, I'd suggest reporting this to the folks at Intel who can fix
it.  It doesn't seem like something which they are motivated to fix.
