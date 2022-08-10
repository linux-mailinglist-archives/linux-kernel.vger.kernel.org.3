Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C0158F306
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 21:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbiHJT1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 15:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiHJT1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 15:27:37 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17DE6F54A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 12:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660159656; x=1691695656;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CaDB+z2vh7ZhfyAPfuAdEuEnifjalQaLmqWiQRtuhho=;
  b=iuWG3u10Qfvs/Vf5gYW7GKxkAai10Ew9qbNgxgQ6Ud/mWVbovE6j3FiN
   x7PCHgFXLmfJanbev5z6kA/1H6asGnek4aPCIkx7S5rQLe5FroHfxrOnS
   /lxrDXhGnK8VY24Q/i3GLXpMmhU46PyqaoJxomoEsnlRXvXG7rovjn48D
   I+0qQJdyaRrcAGz6paegp1a32lncHGDx1l5V1VJ35PTqjswcdeMlCq592
   dtJRh4vE75uIdKUJfyWxxLF2MJiKSPfAqkIumarrEpFMFMIMYRGVZ5cth
   ro1N2753C5RUE5oIrFC1PeIwQJmwph4gf8jNxsi+qKtdHiukmhEqcoB5i
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="270948795"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="270948795"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 12:27:35 -0700
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="731612409"
Received: from jvux-mobl.amr.corp.intel.com (HELO [10.255.228.24]) ([10.255.228.24])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 12:27:34 -0700
Message-ID: <0db39c6e-1147-ac53-15eb-f4009f4da4f5@linux.intel.com>
Date:   Wed, 10 Aug 2022 12:27:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v9 1/6] x86/tdx: Add TDX Guest attestation interface
 driver
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
 <YvQCXDW3p2MCE3zF@zn.tnic>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <YvQCXDW3p2MCE3zF@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/10/22 12:09 PM, Borislav Petkov wrote:
> On Wed, Jul 27, 2022 at 08:44:15PM -0700, Kuppuswamy Sathyanarayanan wrote:
>> In TDX guest, attestation is used to verify the trustworthiness of a TD
>> to other entities before provisioning secrets to the TD.
> 
> What is the difference between a TDX guest and a TD?
> 
> I'm being told they're one and the same thing. If so, please rewrite

Yes. In this context, TD/TD guest means the same thing. So I will just
use TDX guest uniformly.

> this commit message into something actually readable because right now
> it is real hard to parse what this says.
> 
> And pls avoid the Intel marketing bla - that's a write-only text and not
> meant for humans.

Ok. will do.

> 
> Thx.
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
