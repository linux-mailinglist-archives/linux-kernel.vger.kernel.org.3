Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4955893FF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 23:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237035AbiHCVS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 17:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiHCVSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 17:18:55 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661B02720
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 14:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659561534; x=1691097534;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eGOPIkxNkgwBYYmCow54jHRCqvizlDn4rt/PiARlb80=;
  b=axZqVxs4cr0/7bHODJII0TNlDtIpl/e3mPKpsHg5lzhaEJnRVN8TKYzQ
   U7hVU47mfG6saxDvMsq4HAwyPA/64B2yueaWR6d2NfHTUuislStG9n+5f
   nHvS6Dh6cb4VVwR7dUaIGLzN+p+td0vDEvTcjsH/Mn4nJfqHAh1t8W1mn
   Mp23w91ZffiLbIRb/OUyAUz9cpDZV1/X5jZhiQkzsegmqxiz9rtYYUvPJ
   BR35CaPPb3p9x1U+0IHvEYLZNaaR/iGFfCiEkDNaFV0Ye8Qkkwe+JvAjR
   hUaxyaV61CW1qZEagaGQrL6xLWE2s837T8Z9Gv0tp6M0Akqri12Uda1vQ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="270161560"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="270161560"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 14:18:54 -0700
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="606522635"
Received: from bliviero-mobl.amr.corp.intel.com (HELO [10.209.58.137]) ([10.209.58.137])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 14:18:53 -0700
Message-ID: <3cf239c8-ccc4-d112-fb42-605661816cf0@intel.com>
Date:   Wed, 3 Aug 2022 14:18:53 -0700
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
 <d5902382-70f4-be07-99f6-80d17cdfdcaa@intel.com>
 <9f47ed0f-99cc-a237-f09b-45291feffcd3@amd.com>
 <e52341be-076e-92d1-a649-421dac5a4f5d@intel.com>
 <0eccea46-648d-ff70-dcc6-fdca88ff1234@amd.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <0eccea46-648d-ff70-dcc6-fdca88ff1234@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/22 14:03, Tom Lendacky wrote:
>> This whole iteration does look good to me versus the per-cpu version, so
>> I say go ahead with doing this for v2 once you wait a bit for any more
>> feedback.
> 
> I'm still concerned about the whole spinlock and performance. What if I
> reduce the number of entries in the PSC structure to, say, 64, which
> reduces the size of the struct to 520 bytes. Any issue if that is put on
> the stack, instead? It definitely makes things less complicated and
> feels like a good compromise on the size vs the number of PSC VMGEXIT
> requests.

That would be fine too.

But, I doubt there will be any real performance issues coming out of
this.  As bad as this MSR thing is, I suspect it's not half as
disastrous as the global spinlock in Kirill's patches.

Also, private<->shared page conversions are *NOT* common from what I can
tell.  There are a few pages converted at boot, but most host the
guest<->host communications are through the swiotlb pages which are static.

Are there other things that SEV uses this structure for that I'm missing?
