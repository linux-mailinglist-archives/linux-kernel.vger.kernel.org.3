Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5187508ACF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 16:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343983AbiDTOcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 10:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbiDTOcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 10:32:50 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10722DEB5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650465004; x=1682001004;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hQFUSFKncVrleQOWMCchXY4SxJ71Fh4LDwpgNGBlicA=;
  b=HVJthji6gELK0vYMsZJ1dYznpz5i4KRxH7YEYNoDPTF6hgXx9VrXGgKq
   MHebHZzBEWAIdsmz6M9kg2qyrdfBKzjfSFyTDWkptnbNsk25ql05APOPd
   Oe42i/nd0SMSeaDXAvDFKknOcg2py9HUsC0xJCxtNRv2BCoSDfrex+X/C
   At3RzSD6uNaZlxwNl2DUWHn1OawO0PcFRV+6QaaC2c0xN4KTnOIuRIwZa
   Ilq5kn/rrT7NZ++OMIvb+UFBuPEasIJqF6yqafm3jf8SMV/Xv8yFkYiZp
   RRWSDAeIPMmwk6crpLtqbOhJvhzTZalT+m1sLttyvYJOv98BmHKP0FH7R
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="251344176"
X-IronPort-AV: E=Sophos;i="5.90,276,1643702400"; 
   d="scan'208";a="251344176"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 07:30:03 -0700
X-IronPort-AV: E=Sophos;i="5.90,276,1643702400"; 
   d="scan'208";a="562124251"
Received: from mileskin-mobl.amr.corp.intel.com (HELO [10.213.184.8]) ([10.213.184.8])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 07:30:02 -0700
Message-ID: <20356d0e-74cc-1537-71f9-1c3f81e01b9f@intel.com>
Date:   Wed, 20 Apr 2022 07:30:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] x86/mm/ptdump: display page encryption state
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20220419143545.30295-1-rppt@kernel.org>
 <3f27999a-35bc-3499-2bf8-afd0e8666068@intel.com>
 <Yl+zdNP/5iHtPolv@kernel.org>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <Yl+zdNP/5iHtPolv@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/22 00:17, Mike Rapoport wrote:
>> _PAGE_ENC is AMD-specific. Could we do this with a new generic "cc_"
>> function, maybe cc_is_enc()?
>>
>> Something like this would (I think) work for both SEV and TDX:
>>
>> bool cc_is_enc(u64 prot)
>> {
>> 	return cc_mkdec(prot) != prot;
>> }
> It works for SEV. I can repost with this and you'll confirm it works on
> TDX?

I don't have a TDX setup handy, but Kirill certainly does.  I'm sure
he'd be happy to give you a tested-by.
