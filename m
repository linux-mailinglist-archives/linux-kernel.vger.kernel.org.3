Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF28589220
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 20:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237759AbiHCSR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 14:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237394AbiHCSRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 14:17:52 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133D95A175
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 11:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659550668; x=1691086668;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HSprJA3h+9xu55RyAVG01fa5qBNtYY99LJPlZZrdu+s=;
  b=N31wp8+GK9TJ/lQapFEeaUDJQiYVn3XDhifMFUqLxzGEqqGJmx9J+WvI
   m115f5GkxIYzC6JfjgMPFRDbe47WoYQIMBE+i7ku5V6FBSebdpfqBTZV3
   t0Ol8B1+c3BwunJUKfmbvKaoXZ2bPIooJcGjss8ZX9sgh5WuSSbdPIfkp
   UH1GnTjFHzS/9uQGuMgH9Xzz9FZSl/eFC8tQLDKyaeun9j+lxBJzjbIzj
   ArrwgWyRuD5ktojwIY/WfgX4P1dUR9MR7W7D9e7D5HWvMPNN8xjOx/34C
   MYtN6D0/MZaFw0RphNj2Hp6yS2rCImw/0csR1JPg3wZKSkm3oemyjftk6
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="289755269"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="289755269"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 11:17:47 -0700
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="631253638"
Received: from buichris-mobl.amr.corp.intel.com (HELO [10.209.124.150]) ([10.209.124.150])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 11:17:46 -0700
Message-ID: <d5902382-70f4-be07-99f6-80d17cdfdcaa@intel.com>
Date:   Wed, 3 Aug 2022 11:17:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1.1 1/2] x86/sev: Use per-CPU PSC structure in prep for
 unaccepted memory support
Content-Language: en-US
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <1b50311c-448b-96aa-1d96-f4bfed409c1f@amd.com>
 <cover.1659550264.git.thomas.lendacky@amd.com>
 <2a2adc3570ae9c24d03fff877c4fe79ed43605e0.1659550264.git.thomas.lendacky@amd.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <2a2adc3570ae9c24d03fff877c4fe79ed43605e0.1659550264.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/22 11:11, Tom Lendacky wrote:
> +	/*
> +	 * Use the MSR protocol when either:
> +	 *   - executing in an NMI to avoid any possibility of a deadlock
> +	 *   - per-CPU GHCBs are not yet registered, since __vmgexit_psc()
> +	 *     uses the per-CPU GHCB.
> +	 */
> +	if (in_nmi() || !ghcb_percpu_ready)
> +		return early_set_pages_state(__pa(vaddr), npages, op);
> +
> +	spin_lock_irqsave(&psc_desc_lock, flags);

Would it be simpler to just do a spin_trylock_irqsave()?  You fall back
to early_set_pages_state() whenever you can't acquire the lock.

That avoids even having to know what the situations are where you
_might_ recurse.  If it recurses, the trylock will just naturally fail.
 You simply can't have bugs where the "(in_nmi() || !ghcb_percpu_ready)"
conditional was wrong.
