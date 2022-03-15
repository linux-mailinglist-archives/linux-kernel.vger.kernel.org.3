Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C934D9F9B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 17:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348782AbiCOQHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 12:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239056AbiCOQHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 12:07:14 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01AC56414
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 09:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647360362; x=1678896362;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=BFrRqs9qFVnUa13ULOspS26Ceq0rJNvWyPQRN3j1Kl8=;
  b=JJRPS342IslocYGw07wvZxLN24bstElEsy+fmkCcF3RWQHGAVjYavGLh
   uUJHl1Eylf5VPnRSvQptoLlBHWKRnhoTH/bMkqoU5FYStouBxfGQNiJNR
   QpocmJY9kIHyQQXd25Do6QFdF9/JN1sKtZCVQlRK4l5/G3poedEunrVGD
   XqM7KpZsTSmSkOx7JuLnvY4j0/gXaW8EE4lfWDYVN1MB+1OLfSap5QxCH
   8FQaiC7Hem83sKhT2zu68gdj1UW6wM080lW7l124mDwuXTCGanYKY0au3
   hAp5Ht2iiOzWkI7agD5mVrUuF9WQ9LxAjbF6M2mBU78Ywx9TpsCckdAzE
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="317066720"
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="317066720"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 09:03:34 -0700
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="549645392"
Received: from rgatlin-mobl.amr.corp.intel.com (HELO [10.251.10.152]) ([10.251.10.152])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 09:03:33 -0700
Message-ID: <5b5ae505-84c7-1a46-832a-68bdfd8fd61c@intel.com>
Date:   Tue, 15 Mar 2022 09:03:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20220311005742.1060992-1-ira.weiny@intel.com>
 <20220311005742.1060992-6-ira.weiny@intel.com>
 <42e0aa73-04c8-a4c2-2d64-80812634b627@intel.com>
 <YjC2jcn7kJKdHrf3@iweiny-desk3>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 5/5] x86/pkeys: Standardize on u8 for pkey type
In-Reply-To: <YjC2jcn7kJKdHrf3@iweiny-desk3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/22 08:53, Ira Weiny wrote:
> On Mon, Mar 14, 2022 at 04:49:12PM -0700, Dave Hansen wrote:
>> On 3/10/22 16:57, ira.weiny@intel.com wrote:
>>> From: Ira Weiny <ira.weiny@intel.com>
>>>
>>> The number of pkeys supported on x86 and powerpc are much smaller than a
>>> u16 value can hold.  It is desirable to standardize on the type for
>>> pkeys.  powerpc currently supports the most pkeys at 32.  u8 is plenty
>>> large for that.
>>>
>>> Standardize on the pkey types by changing u16 to u8.
>>
>> How widely was this intended to "standardize" things?  Looks like it may
>> have missed a few spots.
> 
> Sorry I think the commit message is misleading you.  The justification of u8 as
> the proper type is that no arch has a need for more than 255 pkeys.
> 
> This specific patch was intended to only change x86.  Per that goal I don't see
> any other places in x86 which uses u16 after this patch.
> 
> $ git grep u16 arch/x86 | grep key
> arch/x86/events/intel/uncore_discovery.c:	const u16 *type_id = key;
> arch/x86/include/asm/intel_pconfig.h:	u16 keyid;
> arch/x86/include/asm/mmu.h:	u16 pkey_allocation_map;
> arch/x86/include/asm/pkeys.h:	u16 all_pkeys_mask = ((1U << arch_max_pkey()) - 1);

I was also looking at the generic mm code.

>> Also if we're worried about the type needing to changY or with the wrong
>> type being used, I guess we could just to a pkey_t typedef.
> 
> I'm not 'worried' about it.  But I do think it makes the code cleaner and more
> self documenting.

Yeah, consistency is good.  Do you mind taking a look at how a pkey_t
would look, and also seeing how much core mm code should use it?
