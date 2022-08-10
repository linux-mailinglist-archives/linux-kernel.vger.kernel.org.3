Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E4358F405
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 23:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbiHJV5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 17:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbiHJV5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 17:57:18 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E46781B28
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 14:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660168638; x=1691704638;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zWL7knpSxfOLVTuPGGUfO9icTmdPu1AKSWoBLlI/HPY=;
  b=hlUDhOzmpqtnelNnGFlg9kIxsJ0lykccUUSQpSbDcEplXK1InKGR9m6w
   mx1BzcRUUMskySN0w7BzEhNMCWj2dszlJfSVTd0YfcLM/MWJXDyA27WfJ
   wn40sC7rBQH1W3zqwVKc/kPrXDBrBBTIBszBVXL1Nh3/DASCqW/8g6W1V
   zJs3JWCse/teN5zpP31J/NB9Qc6geGv4p0dyH8jBgQsmonNLEsBmPx0IC
   +NvA7LAe+mvBFQ3phpIB5pydIMR5oqVCnRlTlwaJM6Hh+w2BBPjEZudEO
   y/zrw2hO4NN9ODj8TmCFUHfezoYLr5oLq/JIehfSkVYhzveybo/BURidd
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="352939937"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="352939937"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 14:57:18 -0700
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="781381887"
Received: from snedunga-mobl2.amr.corp.intel.com (HELO [10.212.234.47]) ([10.212.234.47])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 14:57:17 -0700
Message-ID: <c0e46d84-5015-34b4-a80b-758562118bde@intel.com>
Date:   Wed, 10 Aug 2022 14:57:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] x86/apic: Don't disable x2APIC if locked
Content-Language: en-US
To:     Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        "Gomez Iglesias, Antonio" <antonio.gomez.iglesias@intel.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
References: <20220809234000.783284-1-daniel.sneddon@linux.intel.com>
 <d6ffb489-7024-ff74-bd2f-d1e06573bb82@intel.com>
 <238ea612-5a25-9323-b31f-0a14493db2f7@linux.intel.com>
 <d4bcb22e-224c-d256-cb93-3ff6ed89a7d0@intel.com>
 <341ea6e9-d8f3-ee7a-6794-67408abbf047@linux.intel.com>
 <d315aac4-8cda-bc2d-d052-09fb0649b1ad@intel.com>
 <2446fb33-9c5c-642a-797e-4e93345adb82@linux.intel.com>
 <ef3055a8-9cfd-cbd1-d76c-a2242836d16d@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <ef3055a8-9cfd-cbd1-d76c-a2242836d16d@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/22 13:29, Daniel Sneddon wrote:
> On 8/10/22 13:06, Daniel Sneddon wrote:
>> I could add a blurb to the
>> documentation where nox2apic is defined as a parameter as well.  
> While I'm at it, I'm thinking of adding something where CONFIG_X86_X2APIC is
> defined in kconfig.  I'll put in a blurb about selecting N on SPR systems could
> prevent you from booting due to the lock.

Please don't make it _too_ specific.  This is, after all, new
architecture that is presumably going to be in place long after we all
forget what SPR is.

Good Kconfig text would probably be something along the lines of:

	Some ~2022 and later systems are locked into x2APIC mode and can
	not fall back to the legacy APIC modes.  They will be unable to
	boot without enabling this option.

Would anybody hate if we just removed the CONFIG_X86_X2APIC prompt entirely?
