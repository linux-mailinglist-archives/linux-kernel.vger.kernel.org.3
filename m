Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5025A13CA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 16:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242252AbiHYOh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 10:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242190AbiHYOhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 10:37:09 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F094B4E80
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 07:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661438210; x=1692974210;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dmrRfDKFYvaqDCd7Z0UVB2+tu1U+7ChjMCLoAWvf3BM=;
  b=UXK/iNNaby6pfzXVMUfzF4Q04mWyxMRdMoHr3TFxaIy+p8dkUfshm8ih
   1zEfMGuWdwfMlDwPI5C8qBX0l5OLn4A8FFBqTiwxIEzVH/i0fUGdK/0lA
   6Wsm3lWZSrkDWOL/rJTQt2o6anfuacQilS75bKR3fp4AmkfI2woxBeIH4
   wZKce9rSC6/NZnbDRM4EWIj0HzrPRGFdpIkejP2CqJQOar72g1l63nTTv
   bikCTuAjAJHjq7FKt+onexWlDnK/O0Xbx1wGpuOdaVvYuJ0NA9jHUqbDv
   DATH/EzfU3SKvcsAPfWf8/4wGiA615PwJMMSKQ7ijxSN2r503+FxTbF/3
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="274646649"
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="274646649"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 07:36:49 -0700
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="752504924"
Received: from rnaraya1-mobl1.amr.corp.intel.com (HELO [10.212.254.160]) ([10.212.254.160])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 07:36:48 -0700
Message-ID: <a96082e1-96ad-e92b-a5d0-d239123d943e@intel.com>
Date:   Thu, 25 Aug 2022 07:36:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: PKU usage improvements for threads
Content-Language: en-US
To:     =?UTF-8?Q?Stephen_R=c3=b6ttger?= <sroettger@google.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>
References: <202208221331.71C50A6F@keescook>
 <a5df4929-24aa-79bf-c5d0-98efbf323132@intel.com>
 <CAEAAPHa3g0QwU=DZ2zVCqTCSh-+n2TtVKrQ07LvpwDjQ-F09gA@mail.gmail.com>
 <b4f0dca5-1d15-67f7-4600-9a0a91e9d0bd@intel.com>
 <26078f2a-67be-4aa1-bbb2-dcd1168c9d12@www.fastmail.com>
 <CAEAAPHae8Lr3KfqfLpK3w5F3MPFoG4HJLxX3cMgbKpmQ_jp6Og@mail.gmail.com>
 <c36eb441-e93e-4beb-bdf2-1e6285f7a187@www.fastmail.com>
 <CAEAAPHYTUYdtBLn4RsmNXMeaT8OvQ_k+Vy4uYdy_aSnaW79fcQ@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAEAAPHYTUYdtBLn4RsmNXMeaT8OvQ_k+Vy4uYdy_aSnaW79fcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/22 05:30, Stephen Röttger wrote:
>>> We were also thinking about if this should be a more generic feature instead of
>>> being tied to pkeys. I.e. the doc above has an alternative proposal to introduce
>>> something like a memory seal/unseal syscall.
>>> I was personally leaning towards using pkeys for this for a few reasons:
>>> * intuitively it would make sense to me to extend PKEY_DISABLE_ACCESS
>>>   to also mean disable all changes to the memory, not just the data.
>> It would make some sense, but we can't do it with the existing
>> PKEY_DISABLE_ACCESS ABI.  It would surely break existing users if they
>> couldn't munmap() memory that was PKEY_DISABLE_ACCESS.
> Our thought was that this could be opt-in with a prctl().

So, today, you have this:

	foo = malloc(PAGE_SIZE);
	pkey_mprotect(foo, PAGE_SIZE, READ|WRITE, pkey=1);
	munmap(foo); // <-- works fine
	mmap(hint=foo, ...); // now attacker controls &foo

Which is problematic.  What you want instead is something like this:

	prctl(PR_ARCH_NO_MUNMAP_ON_PKEY); // or whatever
	foo = malloc(PAGE_SIZE);
	pkey_mprotect(foo, PAGE_SIZE, READ|WRITE, pkey=1);
	wrpkru(PKEY_DISABLE_ACCESS<<pkey*2);
	munmap(foo); // returns -EPERM (or whatever)

Which requires the kernel to check when it's modifying a VMA (like the
munmap() above) to see if PKRU _currently_ permits access to the VMA's
contents.  If not, the kernel should refuse to modify the VMA.

Like I said, I don't think this is _insane_, but I can see it breaking
perfectly innocent things.  For instance, an app that today does a
free() if pkey-assigned memory might work perfectly fine for a long time
since that memory is rarely unmapped.  But, the minute that malloc()
decides it needs to zap the memory, *malloc()* will fail.

I also wonder how far these semantics would go.  Would madvise() work on
these access-denied VMAs?

My gut says that we don't want to mix up pkey semantics with this new
mechanism.
