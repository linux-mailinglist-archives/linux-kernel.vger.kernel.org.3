Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0025359FF7D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 18:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239447AbiHXQ2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 12:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239418AbiHXQ2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 12:28:19 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E5582F8D
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 09:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661358498; x=1692894498;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5gPvSM69EFABalYJ9JXoG8SIkAFvTVcfdVREF5gnBvo=;
  b=J1x+uMTQqgiLHhtCnArjldHwXD2xeGrYImVgBfxcxc1SUitP/IXt5pCW
   +g6PNJe9UyoIToFt1dmsl/pHe33DiygzdTz+q0kpDr59ETceebQP7lDhu
   A5n9jwA1JR7PUEqRjqtKnQHMM0Z8dV8sTaQKbc73vhKsRaws4ChhYBovl
   pIH62jfeewu51fDjUXVNW8U4qzDEPVtsDWqyrZZmOgUdUwvFo/axNK3IU
   lZhbDxSrAVo3avrU1o3qOf7XDzokvXa83bJ1EPFFbOjqwoaOMdYa9pWZw
   FzNxa2IDSp+hq3gXZ/ymomJ3K1S6FlNU8oN//wg2DhOE2OYRtGwRMDYpC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="294796109"
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="294796109"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 09:28:17 -0700
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="937975167"
Received: from skeshri-mobl.ger.corp.intel.com (HELO [10.212.154.182]) ([10.212.154.182])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 09:28:16 -0700
Message-ID: <69cfbf60-2583-1bdc-3313-3b1ab72968e0@intel.com>
Date:   Wed, 24 Aug 2022 09:28:17 -0700
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
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAEAAPHae8Lr3KfqfLpK3w5F3MPFoG4HJLxX3cMgbKpmQ_jp6Og@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/22 01:51, Stephen Röttger wrote:
>>> Yeah, that's something for which our defenses are quite weak.  But, it
>>> also calls for a very generic mm/ solution and not something specific at
>>> all to pkeys.
> We were also thinking about if this should be a more generic feature instead of
> being tied to pkeys. I.e. the doc above has an alternative proposal to introduce
> something like a memory seal/unseal syscall.
> I was personally leaning towards using pkeys for this for a few reasons:
> * intuitively it would make sense to me to extend PKEY_DISABLE_ACCESS
>   to also mean disable all changes to the memory, not just the data.

It would make some sense, but we can't do it with the existing
PKEY_DISABLE_ACCESS ABI.  It would surely break existing users if they
couldn't munmap() memory that was PKEY_DISABLE_ACCESS.

But, making it part of the mprotect() ABI wouldn't be the worst thing in
the world.  Since we have a pkey_mprotect(), any mprotect()-based
mechanism could even reuse the existing pkey syscalls.

I do agree with Andy, though, that I'm not quite sure what the attack
model is here.  If an attacker can make arbitrary system calls, surely
protecting one little altstack VMA isn't doing to help much.
