Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B2E58F4F9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 01:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbiHJXoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 19:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiHJXoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 19:44:20 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100CB7B1D4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 16:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660175060; x=1691711060;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oteDUqBYG8zZP5eboPGY4mFmY0qdZlXGZreN0Xphx28=;
  b=MLpBRO8cG1n9rNPO9WZ4KkOwwwa4Z9AHto+TS4mOLQTovZPveplaVno+
   zQ/9iL4iBZPwift/gT6oxoihCiTxwPHKV4GRqiBE+1Ji6Z90kMJlVjwbb
   LSCGkmMlMUsbqkcDNHHZ7cJe47YE0YodkjRP/REf9SjmiDuhr5Who9W5T
   edGLRARvl85OnEaTFq1nBbMYc01EH04EbpSpPfWVbv5PAohvOaXqO95yA
   S2yc0ZticZ+ZI9YWpF5wxhUnqefnhl0ZvKY3FmhUwNsB/GpRo4w2FuVfG
   /q/jQMj+oWutCKSWNltQcMv3tIq8o3En4e64qfdes3mBZrhnyYG0/zbcu
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="292010908"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="292010908"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 16:44:19 -0700
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="781407402"
Received: from snedunga-mobl2.amr.corp.intel.com (HELO [10.212.234.47]) ([10.212.234.47])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 16:44:18 -0700
Message-ID: <9888a920-37b8-9a1f-b887-6630492955c6@intel.com>
Date:   Wed, 10 Aug 2022 16:44:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] x86/apic: Don't disable x2APIC if locked
Content-Language: en-US
To:     Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        "Huang, Kai" <kai.huang@intel.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        "Gomez Iglesias, Antonio" <antonio.gomez.iglesias@intel.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
References: <20220809234000.783284-1-daniel.sneddon@linux.intel.com>
 <d6ffb489-7024-ff74-bd2f-d1e06573bb82@intel.com>
 <238ea612-5a25-9323-b31f-0a14493db2f7@linux.intel.com>
 <d4bcb22e-224c-d256-cb93-3ff6ed89a7d0@intel.com>
 <341ea6e9-d8f3-ee7a-6794-67408abbf047@linux.intel.com> <87r11nu52l.ffs@tglx>
 <83a0d220-1872-caba-4e7e-b6a366655cf2@linux.intel.com>
 <ba80b303-31bf-d44a-b05d-5c0f83038798@intel.com>
 <bff78ad9-57d8-ca82-cc75-0b7e5024116d@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <bff78ad9-57d8-ca82-cc75-0b7e5024116d@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/22 16:38, Daniel Sneddon wrote:
>>
>> config INTEL_TDX_GUEST
>>         bool "Intel TDX (Trust Domain Extensions) - Guest Support"
>>         depends on X86_64 && CPU_SUP_INTEL
>>         depends on X86_X2APIC
> So I got some more input.  SPR and newer will lock the APIC.  

Could you get a _little_ more clarity on this, please?  Exactly how and
when will it be locked?  What does the BIOS writer's guide say?  Will
there be an explicit x2APIC lock option?  Or, will it be implicitly
locked when SGX or TDX is enabled?

> Older products will get a ucode update, but that ucode update won't
> include the APIClock.  So, on non-SPR parts do we still want to make
> SGX depend on X2APIC?
Yes.  It's a small price to pay.
