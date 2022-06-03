Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3889253CDED
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 19:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344300AbiFCRPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 13:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240019AbiFCRPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 13:15:14 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E7B35A8A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 10:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654276513; x=1685812513;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=88FPR2mmn/uxOdd7Xg7CMgvsie461tRhzDgnf+b4ozw=;
  b=cCZOvE3K7o3QsaQX2ZvnilqgyrmgEMmZdLjpRSFz0uRMc7VkoaEvbIO6
   qGoxGKgItuw1zMumA6FbB11bMaDP7drxz7ZNSg1PRWSXX8Yl8wYPoJLhb
   Z9HbadAh4TFCsEU7k6ArGLGl8KluJ8uXv0Cbt2Cob0Kf7QxxLJaVNNMwr
   xFZQCXImysuN6t98/oQeNv3R8wlB3dufpZFBBiT70lkxh6wvpRBPKogxG
   t4d/PRN/drVAqmR/Fi+xW5mQgt4m42fNTnOX7WnovOD9haYI0EHh4F5Jp
   /nH9oamjo0AMbxNr88EhXgceenI6nmoVwLFhVzBbfX9344UmEXirSFIFc
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10367"; a="263957173"
X-IronPort-AV: E=Sophos;i="5.91,275,1647327600"; 
   d="scan'208";a="263957173"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2022 10:15:12 -0700
X-IronPort-AV: E=Sophos;i="5.91,275,1647327600"; 
   d="scan'208";a="613357569"
Received: from rngun-mobl.amr.corp.intel.com (HELO [10.212.137.168]) ([10.212.137.168])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2022 10:15:12 -0700
Message-ID: <403d4d21-0238-3169-b43e-cab1e65a6421@linux.intel.com>
Date:   Fri, 3 Jun 2022 10:15:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: [PATCH v7 5/5] x86/tdx: Add Quote generation support
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
References: <20220524040517.703581-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220524040517.703581-6-sathyanarayanan.kuppuswamy@linux.intel.com>
 <Yo+epmvA0U0+m3/C@fedora>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <Yo+epmvA0U0+m3/C@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/26/22 8:37 AM, Wander Lairson Costa wrote:
> On Mon, May 23, 2022 at 09:05:17PM -0700, Kuppuswamy Sathyanarayanan wrote:
>> +
>> +/* Used for buffer allocation in GetQuote request */
>> +struct quote_buf {
>> +	/* vmapped address of kernel buffer (size is page aligned) */
>> +	void *vmaddr;
>> +	/* Number of pages */
>> +	int count;
>> +};
>> +
>> +/* List entry of quote_list */
>> +struct quote_entry {
>> +	/* Flag to check validity of the GetQuote request */
>> +	bool valid;
>> +	/* Kernel buffer to share data with VMM */
>> +	struct quote_buf *buf;
> 
> Instead of a pointer, we can embed the quote_buf object directly into the
> quote_entry. alloc_quote_buf would receive a pointer to quote_buf, and would
> only allocate vmaddr (may we should change the names from alloc/free to
> init/deinit). This way we can save one memory allocation and have a
> simpler code. Not to mention is one less pointer to track its lifetime.

Agree. I will change it to embed object.


-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
