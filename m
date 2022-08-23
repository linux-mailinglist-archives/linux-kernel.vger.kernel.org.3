Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378C459EC45
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbiHWT0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbiHWT0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:26:06 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B683D326CE
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 11:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661278345; x=1692814345;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EBJWFGhgoiE90SZv+jqTQEYMjFebOZvYueUFtmHFLJI=;
  b=j9qgr9DW9FcHZyJvDawhoGtRrqiDJfPTjI80ZZCK5HpoesQuvN58q2CK
   auHflwStrN3sEvgPm1Z1w7eP4lePHVXQ+qtEh+fOVabncqDiYCQQpHgeY
   /Catt/+GIbYbJ5r5x6s4R4ieA/O/rCcNGIOF8XxQV/vpX31IjKFJ28as9
   kEm103yON/5cxZACFjxury5gtU6pqpvv5SvKgndVPKGo5cLxg9Cr71F0m
   9EZgtPTucYRI1+Gg1pbvPtslcXKjH6Qk+LGXQOPoXwd/dcPttPTwmMCHR
   tpSI9RIVkZpb6jT1TbpatMDernrwCtrALx56EfxRVKJJZHY0wfz9SlgY4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="280734199"
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="280734199"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 11:12:24 -0700
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="677721791"
Received: from tmnguye8-mobl1.amr.corp.intel.com (HELO [10.212.174.243]) ([10.212.174.243])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 11:12:24 -0700
Message-ID: <b4f0dca5-1d15-67f7-4600-9a0a91e9d0bd@intel.com>
Date:   Tue, 23 Aug 2022 11:12:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: PKU usage improvements for threads
Content-Language: en-US
To:     =?UTF-8?Q?Stephen_R=c3=b6ttger?= <sroettger@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>
References: <202208221331.71C50A6F@keescook>
 <a5df4929-24aa-79bf-c5d0-98efbf323132@intel.com>
 <CAEAAPHa3g0QwU=DZ2zVCqTCSh-+n2TtVKrQ07LvpwDjQ-F09gA@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAEAAPHa3g0QwU=DZ2zVCqTCSh-+n2TtVKrQ07LvpwDjQ-F09gA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/22 04:08, Stephen Röttger wrote:
> On Mon, Aug 22, 2022 at 11:11 PM Dave Hansen <dave.hansen@intel.com> wrote:
>> On 8/22/22 13:40, Kees Cook wrote:
>>> 1) It appears to be a bug that a thread without the correct PK can make
>>> VMAs covered by a separate PK, out from under other threads. (e.g. mmap
>>> a new mapping to wipe out the defined PK for it.) It seems that PK checks
>>> should be made when modifying VMAs.
>>
>> Could you give an example of this?  Is this something along the lines of
>> a mmap(MAP_FIXED) wiping out an earlier mapping?  Or, is it more subtle
>> than that?
> 
> Yes, that's one example. And the same applies to other operations on the
> VMA. E.g. another case we'd like to prevent would be munmap(addr) where
> addr is covered by a pkey to which the calling thread doesn't have access
> permissions to.

Yeah, that's something for which our defenses are quite weak.  But, it
also calls for a very generic mm/ solution and not something specific at
all to pkeys.

I assume that you wouldn't want to turn off *all* mmap(), MAP_FIXED or
munmap() in the process.  You just want to make one or more VMAs more or
less immutable.  That _sounds_ like a topic that would have broached at
some point in the past, although it doesn't ring any bells.

The concept would make a good lightning talk at Plumbers of LSF/MM.

>>> 2) It would be very helpful to have a mechanism for the signal stack to
>>> be PK aware, in the sense that the kernel would switch to a predefined
>>> PK. i.e. having a new interface to sigaltstack() which includes a PK.
>>
>> Are you thinking that when switching to the sigaltstack that it would
>> also pick up a specific PKRU value?  Or, that it would ensure that PKRU
>> allows access to the sigaltstack's pkey?
> 
> Either of those would work for us.
> 
>> Logically something like this:
>>
>>         stack_t sas = {
>>                 ss_sp = stack_ptr;
>>                 ss_flags = ... flags;
>>                 ss_size = ...;
>>                 ss_pkey = 12;
>>         };
>>
>> Then the kernel would set up RSP to point to ss_sp, and do (logically):
>>
>>    pkkru &= ~(3<<(12*2)); // clear Write and Access-disable for pkey-12
>>
>> before building the signal frame running the signal handler?
> 
> Yeah, that would work for our use case.
> We also have a doc discussing this in more detail :) :

That doesn't seem like it would be too much of a stretch.  There's a
delicate point when building the stack frame that the kernel would need
to move over to the new PKRU value to build the frame before it writes
the *OLD* value to the frame.  But, it's far from impossible.

I also bet we could do this with minimal new ABI.  There's already a
->ss_flags field.  We could assign a flag to mean that stack_t doesn't
end at '->ss_size' and that there's a pkey value *after* ss_size.  I do
think having a single pkey that is made accessible before signal entry
is a more flexible ABI than taking an explicit PKRU value.

I think that would allow just reusing sys_sigaltstack().

