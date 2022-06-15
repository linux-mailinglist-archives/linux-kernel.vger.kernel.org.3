Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CB454CCF7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 17:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354767AbiFOPaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 11:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355717AbiFOP2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:28:41 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45BA434AB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 08:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655306872; x=1686842872;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SRHdAt5c+iG6nC47CDkQ4xDzPy+xva5pr4/9bMvN8yc=;
  b=mAjhabvq/AesKvcCgutZ+c4HI0NUJ6gNbGOrE3HAmY2cSXR4q11hPD9h
   GJS+kaPdqwip/JbRtxOYLCMSEtluGD9Yf8rxyxzAgtmTmjts8SceM+QEX
   Kmrcprv8X2LOydUcB3fI5GH52jirS42aOYlEq/UoVrarC0Z2bXD3+1EWz
   0Rz06jjm4t5IKvjap17TNIjXq7HedGY+NYt+JYXnq3uMrVEHQOmloZ7+Y
   kzMrypW9uEclJWlMyMQp92DZF1dVSW6jhMLFWRP4fK9uWPIa5OGlygINf
   gdiono5sPR5lRqj3ecZjRpiX79yXzj2bECG/EV8pOictGezciHRoPni6M
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="340656982"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="340656982"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 08:27:52 -0700
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="559173120"
Received: from mjortiz-mobl.amr.corp.intel.com (HELO [10.212.185.241]) ([10.212.185.241])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 08:27:52 -0700
Message-ID: <051fd468-11e6-308b-66c8-4de16ff80deb@intel.com>
Date:   Wed, 15 Jun 2022 08:27:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCHv4 3/3] x86/tdx: Handle load_unaligned_zeropad() page-cross
 to a shared page
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org
Cc:     ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        thomas.lendacky@amd.com, x86@kernel.org
References: <20220614120135.14812-1-kirill.shutemov@linux.intel.com>
 <20220614120135.14812-4-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220614120135.14812-4-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/22 05:01, Kirill A. Shutemov wrote:
> load_unaligned_zeropad() can lead to unwanted loads across page boundaries.
> The unwanted loads are typically harmless. But, they might be made to
> totally unrelated or even unmapped memory. load_unaligned_zeropad()
> relies on exception fixup (#PF, #GP and now #VE) to recover from these
> unwanted loads.
> 
> In TDX guests, the second page can be shared page and VMM may configure
> it to trigger #VE.
> 
> Kernel assumes that #VE on a shared page is MMIO access and tries to
> decode instruction to handle it. In case of load_unaligned_zeropad() it
> may result in confusion as it is not MMIO access.
> 
> Fix it by detecting split page MMIO accesses and fail them.
> load_unaligned_zeropad() will recover using exception fixups.
> 
> The issue was discovered by analysis. It was not triggered during the
> testing.

I thought this whole exercise was kicked off by hitting this in testing.
 Am I remembering this wrong?

> https://lore.kernel.org/all/20220517153444.11195-10-kirill.shutemov@linux.intel.com/

Says:

> This is an actual, real-world problem which was discovered during TDX
> testing.

Or were you considering this a different problem somehow?
