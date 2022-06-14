Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1AE654B1D0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 14:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245476AbiFNM7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 08:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343552AbiFNM6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 08:58:55 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0113E31901
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 05:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655211535; x=1686747535;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XotrzOx0LNp6R0ZYZcinq0wNe63x+kUJlQZDx/ficAA=;
  b=Aw8Z3wkApx/j9vMQwFaVjyOcHylzD2mB7HOc0s3wnLps6UVqdyOz27PE
   F+Dr3DKvNWbcjqR0Z24rpjacIZbWnsjOJRdteBya1gdEIYFFufsny4GID
   JKSjCB/0I9XRvZgduYWEdZtO1tcYYgXCk+5ctpzjrOL6J/vMBle2QySLW
   70jo3q40V/Bswp498LjaQJ+KTPUedK/0U/7bpgSKjHpVr4/NKgq+UsDaI
   uvmNsWftupQraxdMNE6d2W1w7R3SM3/5r7Dlenbn1DKcjnQFz+vxFAxGK
   dn5eEIqwYZBoFKt3TepKDyP+0Q22VCwV430WTsmnBi2TEHhnu8Gc/pVlr
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="261637411"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="261637411"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 05:58:54 -0700
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="612222731"
Received: from chakrab1-mobl.amr.corp.intel.com (HELO [10.209.55.84]) ([10.209.55.84])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 05:58:54 -0700
Message-ID: <b8afb2ac-0d31-e41c-6ebc-db193187f4e7@linux.intel.com>
Date:   Tue, 14 Jun 2022 05:58:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH v8 5/5] x86/tdx: Add Quote generation support
Content-Language: en-US
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
References: <20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220609025220.2615197-6-sathyanarayanan.kuppuswamy@linux.intel.com>
 <Yqh/fCamrCoujZU5@fedora>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <Yqh/fCamrCoujZU5@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/14/22 5:30 AM, Wander Lairson Costa wrote:
> On Wed, Jun 08, 2022 at 07:52:20PM -0700, Kuppuswamy Sathyanarayanan wrote:
> 
> [snip]
> 
>> +}
>> +
>> +/* Remove the shared mapping and free the memory */
>> +static void deinit_quote_buf(struct quote_buf *buf)
>> +{
>> +	if (!buf)
>> +		return;
> 
> nit: the null check isn't necessary anymore, is it?

Yes. I will remove it.

> 
> [snip]
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
