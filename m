Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E6B59CA8B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 23:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237885AbiHVVLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 17:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237048AbiHVVLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 17:11:11 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47EB47BB2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 14:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661202669; x=1692738669;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9uEjUrx1BvA19/wl9sg2vuY7NmpmeLBmaJAfmOpH5FA=;
  b=YdHTEHQGtd43Y47TI7lBLHp/BNTvFokUQsntMRG8PBIJfSIrlMiJP4He
   6Sr9ucMRFTtqcoN7wVVYfODa2/1mDM+YGT4E4HEYQ1ug8Omo90lR6SQzX
   M0LSElgyl1KSHguVURzi2fmF0u+xrkuGt6+tCthQecd2Q+51eOUpybRLi
   xZkr91BlwB9ce+YwSaFONWZjgev7cdfuB1xzDYC9cSfprXDLO0K85thvm
   q4/lXhgbb7ydP1Z2XIcUZG0Pm9Ox+oDm77YCZCUsVmTQU5g+f3mAdG6Jd
   AkDk7FAmC2BVd7s1nlJNEug1FNdfQGAOu+7KLjFiiQN73z/pleSBMA/lS
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="294805221"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="294805221"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 14:11:09 -0700
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="751434809"
Received: from sraksht-mobl.amr.corp.intel.com (HELO [10.212.204.203]) ([10.212.204.203])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 14:11:08 -0700
Message-ID: <a5df4929-24aa-79bf-c5d0-98efbf323132@intel.com>
Date:   Mon, 22 Aug 2022 14:11:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: PKU usage improvements for threads
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     =?UTF-8?Q?Stephen_R=c3=b6ttger?= <sroettger@google.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>
References: <202208221331.71C50A6F@keescook>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <202208221331.71C50A6F@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/22 13:40, Kees Cook wrote:
> 1) It appears to be a bug that a thread without the correct PK can make
> VMAs covered by a separate PK, out from under other threads. (e.g. mmap
> a new mapping to wipe out the defined PK for it.) It seems that PK checks
> should be made when modifying VMAs.

Hi Kees,

Could you give an example of this?  Is this something along the lines of
a mmap(MAP_FIXED) wiping out an earlier mapping?  Or, is it more subtle
than that?

I'm not sure I know of any bugs in the area.

> 2) It would be very helpful to have a mechanism for the signal stack to
> be PK aware, in the sense that the kernel would switch to a predefined
> PK. i.e. having a new interface to sigaltstack() which includes a PK.

Are you thinking that when switching to the sigaltstack that it would
also pick up a specific PKRU value?  Or, that it would ensure that PKRU
allows access to the sigaltstack's pkey?  Logically something like this:

	stack_t sas = {
		ss_sp = stack_ptr;
		ss_flags = ... flags;
		ss_size = ...;
		ss_pkey = 12;
	};

Then the kernel would set up RSP to point to ss_sp, and do (logically):

   pkkru &= ~(3<<(12*2)); // clear Write and Access-disable for pkey-12

before building the signal frame running the signal handler?

> Are either of these something the PKU authors have considered? (Or are
> there some details we're missing in this area?)

We've talked about having signal behavior which might give different
PKRU values at signal entry, but nothing too concrete.  Something like
that wouldn't be *awful* to implement.  It would also be nice that it
would be confined to folks that set up special signal handlers anyway
and that context is already pretty special.

I'd love to hear more why this behavior is useful and how it will be used.
