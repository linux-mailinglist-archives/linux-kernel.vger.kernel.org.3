Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5717158F28C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 20:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbiHJSwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 14:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiHJSwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 14:52:49 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C86B85F86
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 11:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660157567; x=1691693567;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tkXMe3GHo5MJttImaZr8gkb6ZnuFVfU29Zg3JdEHw0U=;
  b=dyki3Vu7E2pBGbFrTuAFrA0wovyfP+E8R6uwYeRLYKK1uiJtQC42jmp8
   xnySraRQOHnJUIV4VIbOK/Ex1FSeUKRhHGRI27N5Q+/yiRFJKhBfwXDtk
   EIKtB/uBnTYYLmHBm7wqgJRG8RKe8QMWZLgdDTgIV2UVLdxfw5XpxkSF8
   w+qdLVYORmbmAaaMT1sCmyKkatLbquJtXCKJIMG0Bi4sllqBmL21VvGX9
   cwKPri7yce94pVLkJQC6fjety00cLoVhRMl1iM9ueUfKd/CqHSdN87YW0
   BBbfdRXu45JQ0/RbDhvA2esGmyp44Fi4DsDJ1uQliYnA0HwHtMWIRPkJW
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="352902559"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="352902559"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 11:52:46 -0700
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="781333117"
Received: from snedunga-mobl2.amr.corp.intel.com (HELO [10.212.234.47]) ([10.212.234.47])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 11:52:46 -0700
Message-ID: <d4bcb22e-224c-d256-cb93-3ff6ed89a7d0@intel.com>
Date:   Wed, 10 Aug 2022 11:52:48 -0700
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
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <20220809234000.783284-1-daniel.sneddon@linux.intel.com>
 <d6ffb489-7024-ff74-bd2f-d1e06573bb82@intel.com>
 <238ea612-5a25-9323-b31f-0a14493db2f7@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <238ea612-5a25-9323-b31f-0a14493db2f7@linux.intel.com>
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

On 8/10/22 11:30, Daniel Sneddon wrote:
>> If it's going to be on one server CPU that's coming out in ten years,
>> then we can hold off.
> SPR will certainly be sooner than 10 years, and with distros running on LTS
> kernels, it is probably worth backporting.  Since this isn't a bug fix (not a sw
> bug anyway), is this something I can just CC stable or is there a better way to
> say "Yes, this is a new feature, BUT, you really want it anyway"?

It it going to be *forced* on those SPR system?  In other words, is it a
little BIOS switch that users can flip?  Is there any non-kernel
workaround if a user hits this, or is the entire burden of this going to
be foisted on the kernel?

The worst case scenario would be if a user has managed to compile a
CONFIG_X86_X2APIC=n kernel and is happily running along until they get a
microcode update, reboot and can't boot any more.

A less-bad, but still nasty situation would be someone who is booting
with nox2apic, who also suddenly loses the ability to boot until they
figure out why their kernel is #GP'ing and oopsing early in boot and
remove nox2apic.

I think we need a bit more information on how this thing will get
deployed before we really know if it needs to be in stable kernels or
not.  For instance, if Intel really views this as an always-on security
mitigation, that's a different story than if this is, say, a performance
tweak.
