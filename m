Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BBC589423
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 23:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237884AbiHCVsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 17:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbiHCVsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 17:48:38 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EA319008
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 14:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659563317; x=1691099317;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OszUSZaeTwre2lg3VQaRr0MRLW8RAU4JNI+oAxhiK9I=;
  b=Ja1YOJy7hF9EFCAV9v0jbZvZSvH8uMG2+7fcBGGe9z+XBZygsPyjQBR1
   bb074Rj51vDmxMWv1lfejADaDD1JOgFU2gKOFocCcO3O0Ph5XNJphj3Vo
   Nlx82WIWU1Cm3akplXeSALgtgsT04WD23PG2TmCLyp7Y1GD36DEcEV4fs
   UR5X3M0KAr3wPOm3Fll1Iu8nCYOwoibwRMDaJaT8Zbb90cZ5FJXG9/WQk
   z2LIvOcG4pxPALO6rSAB9EJNYVrd+RfQW+bZSFFkizBkmNqsERoKdDzwH
   3zIq4GfmPclm3g3Zzc3e5OWSbTJkoMvWUynxEhqz077z9EdWGNQXn6Sz1
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="351497938"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="351497938"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 14:48:36 -0700
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="606530320"
Received: from bliviero-mobl.amr.corp.intel.com (HELO [10.209.58.137]) ([10.209.58.137])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 14:48:35 -0700
Message-ID: <6b492245-f25b-1019-0728-7c77a54a7540@intel.com>
Date:   Wed, 3 Aug 2022 14:48:35 -0700
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
        Peter Zijlstra <peterz@infradead.org>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        "Huang, Kai" <kai.huang@intel.com>
References: <1b50311c-448b-96aa-1d96-f4bfed409c1f@amd.com>
 <cover.1659550264.git.thomas.lendacky@amd.com>
 <2a2adc3570ae9c24d03fff877c4fe79ed43605e0.1659550264.git.thomas.lendacky@amd.com>
 <d5902382-70f4-be07-99f6-80d17cdfdcaa@intel.com>
 <9f47ed0f-99cc-a237-f09b-45291feffcd3@amd.com>
 <e52341be-076e-92d1-a649-421dac5a4f5d@intel.com>
 <0eccea46-648d-ff70-dcc6-fdca88ff1234@amd.com>
 <3cf239c8-ccc4-d112-fb42-605661816cf0@intel.com>
 <b33876b6-96bd-afe0-3523-b51b8628616a@amd.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <b33876b6-96bd-afe0-3523-b51b8628616a@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/22 14:34, Tom Lendacky wrote:
>> Also, private<->shared page conversions are *NOT* common from what I can
>> tell.  There are a few pages converted at boot, but most host the
>> guest<->host communications are through the swiotlb pages which are
>> static.
> 
> Generally, that's true. But, e.g., a dma_alloc_coherent() actually
> doesn't go through SWIOTLB, but instead allocates the pages and makes
> them shared, which results in a page state change. The NVMe driver was
> calling that API a lot. In this case, though, the NVMe driver was
> running in IRQ context and set_memory_decrypted() could sleep, so an
> unencrypted DMA memory pool was created to work around the sleeping
> issue and reduce the page state changes. It's just things like that,
> that make me wary.

Interesting.  Is that a real passthrough NVMe device or the hypervisor
presenting a virtual one that just happens to use the NVMe driver?

I'm pretty sure the TDX folks have been banking on having very few page
state changes.  But, part of that at least is their expectation of
relying heavily on virtio.

I wonder if their expectations are accurate, or if once TDX gets out
into the real world if their hopes will be dashed.
