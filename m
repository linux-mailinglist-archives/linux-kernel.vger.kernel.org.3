Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F05654D3FE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 23:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348674AbiFOVzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 17:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347869AbiFOVzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 17:55:17 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0EF3BBCB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 14:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655330116; x=1686866116;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2C9vYUhv5jL2K5xzRH45goeY7fn47lkvkQBHQ5F3nCE=;
  b=DmJqBheUUnVN2mhPBs24RslqFUtDWTwG/ep3/xwBEmT622ETCyIt1cZO
   VFpki4bWqbMj4WvjK0wUte4x5K4pX0st/ySL4HCBGqh7Vkaa/twNQ2ZuW
   fdqU1J6pUPg3PJaYIlqWKxeItVRS9R3Y2NjkKSV5UBD25G9cnTWUQOhpv
   pYvU9s3XWrtsnDFIh14gwT8gX+Y7q3NCdZ4ER3wNo4/wb3m27Rg1GUtiT
   p3cMwaBbeADee3HhON+p2/ZVM+BHpH4p/74wb0nsHi/4iZXfx2X7Vv7Hg
   40aKAUf8Rw7lDM4qTIeUz9VO5JoERHM1LLGaPxWgBrKeegcPuy4LHFMKQ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="343068095"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="343068095"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 14:55:13 -0700
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="559385208"
Received: from mjortiz-mobl.amr.corp.intel.com (HELO [10.212.185.241]) ([10.212.185.241])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 14:55:13 -0700
Message-ID: <1d190555-2bb1-e483-2405-e28ddabead07@intel.com>
Date:   Wed, 15 Jun 2022 14:55:13 -0700
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
 <051fd468-11e6-308b-66c8-4de16ff80deb@intel.com>
 <20220615171042.oeumb3vs3ttu4rvd@black.fi.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220615171042.oeumb3vs3ttu4rvd@black.fi.intel.com>
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

On 6/15/22 10:10, Kirill A. Shutemov wrote:
>> I thought this whole exercise was kicked off by hitting this in testing.
>>  Am I remembering this wrong?
>>
>>> https://lore.kernel.org/all/20220517153444.11195-10-kirill.shutemov@linux.intel.com/
>> Says:
>>
>>> This is an actual, real-world problem which was discovered during TDX
>>> testing.
>> Or were you considering this a different problem somehow?
> They are different.
> 
> The patch by the link addresses issue of load_unaligned_zeropad() stepping
> onto unaccepted memory. This was triggered in practice.

OK, so we've got two problems both triggered by
load_unaligned_zeropad(), but where the fixes are different.  We
actually hit the "unaccepted memory one" in testing, but that made us
think about other problems in the area and that's where this one came up.

