Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD76758F36B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 22:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbiHJUGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 16:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiHJUGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 16:06:52 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1908A72865
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 13:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660162012; x=1691698012;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=m77Ga0zACyhhhvX7qrvZch4i5z1Aec8NBTIcASU+Fm4=;
  b=gfLoOLtGffOWTTK8Qd2L7yJVBbDBs5keGV8I4AFha41piCRlR0Cd28np
   fm2Nhi5iyLHttD476XarsejMEb/nmm7EcADmVVYu44MeSqzpXtWY5+JGe
   bbAkWsR9P+U1VunY27NdRKEqiQwXCqOKExqgnX+cUNagnOxwZe6DaNN7s
   /6mg//FJoJKDqvXhW4pOzod7RaTIgz5N7FiqJ3wCA75OassNnLriDu96i
   fQYYvlsVo9D1VxiBbAe7fe7Ky/FqMtK+NM6da4HQ1i0IEj/HJef+7E5Ji
   8Z1+Q1/Lo5h7i7y69kQ3JC1ynJQDD41yJuW0NrOXP4euSvCfTxnv1MtJO
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="352916953"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="352916953"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 13:06:51 -0700
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="605278828"
Received: from sarava2x-mobl1.gar.corp.intel.com (HELO [10.254.67.234]) ([10.254.67.234])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 13:06:50 -0700
Message-ID: <2446fb33-9c5c-642a-797e-4e93345adb82@linux.intel.com>
Date:   Wed, 10 Aug 2022 13:06:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
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
From:   Daniel Sneddon <daniel.sneddon@linux.intel.com>
Subject: Re: [PATCH] x86/apic: Don't disable x2APIC if locked
In-Reply-To: <d315aac4-8cda-bc2d-d052-09fb0649b1ad@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/22 12:59, Dave Hansen wrote:
> On 8/10/22 12:40, Daniel Sneddon wrote:
>>> It it going to be *forced* on those SPR system?  In other words, is it a
>>> little BIOS switch that users can flip?  Is there any non-kernel
>>> workaround if a user hits this, or is the entire burden of this going to
>>> be foisted on the kernel?
>> It won't be forced, BUT, certain features won't be available if the APIC isn't
>> locked.  According to the documentation SGX and TDX won't be available if you
>> don't lock the APIC.  So, yes, you don't have to fix it in the kernel, but you
>> may lose access to features if you don't.
> 
> Let's get some of this in the changelog and _possibly_ Documentation/ so
> that users know we're depending on the BIOS to play nice.  Let's put
> ourselves in the place of our users for a moment at least and try to
> figure out how we play our part to help get them from seeing "can't
> disable x2apic mode" or whatever to them flipping knobs in the BIOS.

I will certainly add this to the changelog.  I could add a blurb to the
documentation where nox2apic is defined as a parameter as well.  If there is a
better place to document that please let me know.

> 
> I also dearly hope that Intel has told BIOS writers that the onus is on
> them *and* those nice BIOS folks listen to Intel. :)
You and me both!  I know this has gone out to our BIOS partners and they are
aware of it.  Beyond that, well, I guess we'll find out when SPR is released!

> 
> In any case, I don't think backports are warranted here at the moment.
> We can always do it in the future if the need arises.

