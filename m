Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399D758F4A2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 01:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbiHJXDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 19:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbiHJXDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 19:03:49 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452A56CD2A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 16:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660172629; x=1691708629;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4MvWDtPgbTCdkg8tpthgX1oBWOMtO/DwRzPVVKpE+dA=;
  b=Ag+pQ2U0Hx3MAu3R3i/DhaboRXyDPMDSJGF5X553RnYT8WeW8XEF7KTI
   j+2Lw3Ryya1X92s1122blXj0G262L25o0xxQlqh3MuzfZ84VDOp7+2ICq
   u8aaaBbJLkNI8421tgoCnKM8ozo5dKJWrs1a3Yazhb+cJ6TGyC7dVhAYp
   WTYPqkv/hY3lkgNcQ52e0UXrzimjkGGv8J9DTVBjWM0xt6RpC8CWzCcnh
   iqIYrC4BdExsjfzRCY0jEUxa58wGD+X0V15DdhBBOWrcVh14igQN6t2+G
   5muGZqLaK6wJ0E8OgBCRf5jelzjFFMdHttuc6MkWZ4QlkWuBWwxvlkFzr
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="317170698"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="317170698"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 16:03:48 -0700
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="933079844"
Received: from sarava2x-mobl1.gar.corp.intel.com (HELO [10.254.67.234]) ([10.254.67.234])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 16:03:47 -0700
Message-ID: <83a0d220-1872-caba-4e7e-b6a366655cf2@linux.intel.com>
Date:   Wed, 10 Aug 2022 16:03:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] x86/apic: Don't disable x2APIC if locked
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>,
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
 <341ea6e9-d8f3-ee7a-6794-67408abbf047@linux.intel.com> <87r11nu52l.ffs@tglx>
From:   Daniel Sneddon <daniel.sneddon@linux.intel.com>
In-Reply-To: <87r11nu52l.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/22 15:06, Thomas Gleixner wrote:
> So this affects already deployed systems and we have to
> 
>   - backport the x2apic lock changes
> 
>   - provide proper diagnostics
> 
>   - make SGX and TDX depend on X2APIC support
I'll add the comments Dave mentioned earlier, and will make SGX and TDX depend
on X2APIC since that makes sense regardless of what hw ends up with this change.
 Unless we want to get rid of CONFIG_X86_X2APIC like Dave mentioned?
