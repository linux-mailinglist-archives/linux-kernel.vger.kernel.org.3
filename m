Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919A659FFE3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 18:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239506AbiHXQ5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 12:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236806AbiHXQ4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 12:56:48 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEE131204
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 09:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661360205; x=1692896205;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iLC72vOxwfIp/s4mbRK8DvAKazABWS8f+3xpc1O24vo=;
  b=VLkeuXuIE3qsZYVW2ajQxzOUpbEfvox+fzEA9JRwke67ysoH9VtEbi3+
   aJchyQl++FBZBSr1s4Az7IkmisC4xpDWuvfcczYvWyEUvYhatXTgb17UA
   +gw24Assex3DfW7i1Y5JGTLlwNsKlqZ5bJSfKyQHvOs306syCBKGss/Pn
   wMuowNmWmw7YYlNmPxJTsBalDzkPNJaxLssQqbnl2ojirw3tA06oqFNJG
   EK//sh3J+7RwgtT8FEN8XcWNFg7GUDCPpHeAi04CGATqfS9EjcxZ6Lp+Y
   HcJ5tw1gMQc7vGgdoic6xqbblf+r38T6KS9Vm2LNnD6FSM8wPuiD6vUQ9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="295300007"
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="295300007"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 09:56:44 -0700
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="639198910"
Received: from cceisenm-mobl1.amr.corp.intel.com (HELO [10.212.174.196]) ([10.212.174.196])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 09:56:44 -0700
Message-ID: <9519f3eb-9efd-b596-4331-e62ada389e1e@linux.intel.com>
Date:   Wed, 24 Aug 2022 09:56:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v9 1/6] x86/tdx: Add TDX Guest attestation interface
 driver
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
References: <20220728034420.648314-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220728034420.648314-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <Yv5KNyX992ddvVtD@zn.tnic> <20abfa00-b70c-f151-9ee4-5668f09f4ace@intel.com>
 <YwP27a6/9Yq8LBM3@zn.tnic> <be080a46-e6c2-995b-9064-a8506c38bef8@intel.com>
 <08c5b818-a030-4c97-80f7-52ee42dc1f79@linux.intel.com>
 <YwZKGzXloHWeFV/k@zn.tnic>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <YwZKGzXloHWeFV/k@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/24/22 8:56 AM, Borislav Petkov wrote:
> On Mon, Aug 22, 2022 at 03:41:00PM -0700, Sathyanarayanan Kuppuswamy wrote:
>> In addition to above, I think there is a possibility to add IOCTL to get
>> storage keys from the ACPI SVKL table. Storage Volume Key Table (SVKL) is
>> used by the VBIOS to share keys required to access encrypted drives. Although
>> we don't have a clear requirement, I suspect that we might add IOCTL for it.
> 
> So this all sounds like a single tdx-guest driver to me which services a
> bunch of ioctls... not separate drivers.
> 
> Hmm?

Yes. You are right. This is similar to AMD sev-guest driver. 

https://github.com/torvalds/linux/blob/master/drivers/virt/coco/sev-guest/sev-guest.c

> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
