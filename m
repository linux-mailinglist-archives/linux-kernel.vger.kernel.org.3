Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F3D54D4A0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 00:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347100AbiFOWgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 18:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239638AbiFOWgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 18:36:03 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62983554B3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655332563; x=1686868563;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=K+tbkvL1oKMTgWEY19vttlX70wCWiady0HY8d7vx3+Y=;
  b=A6iF0kRJxPCcKFWugRdykuCV7NngawNjtts1mz8klHZ9jCBWbAxrzeV9
   ecGv3xZDNRER42nfakLzrbzV/7axrh+kOmRpl9a8frS1YDEJ9IuaOamJ9
   iTCfrXmYO05alQ3qs8krS8QLItNRie4Xb3FqZACRzc3VC2WGSZnoT2hUK
   kTJng5VTCdU99cBDanm1/2/n9ROFH0bya4RA1xCEhXa16V1sOqIot1J3E
   Rl5JCiPLWlMJgkXgY3ojjwh5MRyhtXCjnJiouRshw0cpFU9urBn6RtAFM
   2deTVJBpTXWodD/mzCKpIL32tH/1zuADOiFLruX62y9Pd85nQbPeBkdGv
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="304553454"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="304553454"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 15:36:03 -0700
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="559401664"
Received: from mjortiz-mobl.amr.corp.intel.com (HELO [10.212.185.241]) ([10.212.185.241])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 15:36:02 -0700
Message-ID: <184456a7-fd03-c3c6-3d4f-4f770e2e8b31@intel.com>
Date:   Wed, 15 Jun 2022 15:36:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCHv4 3/3] x86/tdx: Handle load_unaligned_zeropad() page-cross
 to a shared page
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org, ak@linux.intel.com,
        dan.j.williams@intel.com, david@redhat.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        thomas.lendacky@amd.com, x86@kernel.org
References: <20220614120135.14812-1-kirill.shutemov@linux.intel.com>
 <20220614120135.14812-4-kirill.shutemov@linux.intel.com>
 <2a6e0dbb-89e3-9735-de20-132992d699b4@intel.com>
 <20220615223251.bm4q24pnwkv37w2q@black.fi.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220615223251.bm4q24pnwkv37w2q@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/22 15:32, Kirill A. Shutemov wrote:
>>>         /*
>>>          * Reject EPT violation #VEs that split pages.
>>>          *
>>>          * MMIO accesses are supposed to be naturally aligned and therefore
>>>          * never cross page boundaries. Seeing split page accesses indicates
>>>          * a bug or a load_unaligned_zeropad() that stepped into an MMIO page.
>>>          *
>>>          * load_unaligned_zeropad() will recover using exception fixups.
>>>          */
> Looks good, thanks.

I've got that snippet and a few other things staged here:

> https://git.kernel.org/pub/scm/linux/kernel/git/daveh/devel.git/log/?h=testme

Could you take a quick look through before I push them somewhere for real?
