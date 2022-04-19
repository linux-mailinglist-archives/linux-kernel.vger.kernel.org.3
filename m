Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F44507CD6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 00:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358366AbiDSWwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 18:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358362AbiDSWwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 18:52:41 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F191CFC9;
        Tue, 19 Apr 2022 15:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650408597; x=1681944597;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=WYVYNsvPxVthnQheJXzFIGzmkqTaq4QduTSZst8QeLE=;
  b=EuQ2RqQa3+358l4nq2g4UittGID61jEJNtz8J7kKA0QCoUeTK9qRhwhX
   cNKKnl0blmOlJUwoRk58zrOpdncaKDZ6snJTVQWGmHfuvWZMT+pAmaCZ1
   /DqOeDpjAV0UbRk4P1EGY6/Vk4v8QHuZQYXDJ1zFv374dlU4cFTvlkHG3
   v3bOJex9BmWKCAIQuWHnPsongoG0JKdO8tW+G6GoZsT8nUZ4Nezvf8Ap5
   So8J/W3D/uIVjr7KZcjjcXETxh9t9km5+X+BV45iNVLgOES5+CLOOg758
   /Aj2enQu7bgSGKr6SMQuSpBwc6pPvjOHxpsxRd4q2qJ8g7pDKMGldCh1e
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="262748136"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="262748136"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 15:49:55 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="530875662"
Received: from sazizi-mobl2.amr.corp.intel.com (HELO [10.212.98.167]) ([10.212.98.167])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 15:49:54 -0700
Message-ID: <ec60ed6f-eafc-80eb-affc-3102c5dc3165@intel.com>
Date:   Tue, 19 Apr 2022 15:49:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Kai Huang <kai.huang@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20220415220109.282834-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220415220109.282834-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <bd83067542a3519ee4c91f9d50e9bd4fac27e4bb.camel@intel.com>
 <975b5050-2108-9ace-cc71-46f17db0a731@intel.com>
 <f40fe89d9b978d525ed5d56b0679d1c20b10864b.camel@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v3 4/4] platform/x86: intel_tdx_attest: Add TDX Guest
 attestation interface driver
In-Reply-To: <f40fe89d9b978d525ed5d56b0679d1c20b10864b.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/22 15:21, Kai Huang wrote:
> On Tue, 2022-04-19 at 07:13 -0700, Dave Hansen wrote:
>> On 4/19/22 00:47, Kai Huang wrote:
>>>> From security's perspective, attestation is an essential part of TDX.  That
>>> being said, w/o attestation support in TD guest, I guess nobody will seriously
>>> use TD guest.
>> Are you saying you can't think of a single threat model where there's a
>> benefit to running a TDX guest without attestation?  Will TDX only be
>> used in environments where secrets are provisioned to guests on the
>> basis of attestation?
>>
> I don't think anyone should provision secret to a TD before it get attested that
> it is a genuine TD that he/she expected.  If someone does that, he/she takes the
> risk of losing the secret.  Of course if someone just want to try a TD then w/o
> attestation is totally fine.

Yeah, but you said:

	w/o attestation support in TD guest, I guess nobody will
	seriously use TD guest.

I'm trying to get to the bottom of that.  That's a much more broad
statement than something about when it's safe to deploy secrets.

There are lots of secrets deployed in (serious) VMs today.  There are
lots of secrets deployed in (serious) SEV VMs that don't have
attestation.  Yet, the world somehow hasn't come crashing down.

I think it's crazy to say that nobody will deploy secrets to TDX VMs
without attestation.  I think it's a step father into crazy land to say
that no one will "seriously" use TDX guests without attestation.

Let's be honest about this and not live in some fantasy world, please.
