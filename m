Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD9F48463C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 17:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235523AbiADQwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 11:52:11 -0500
Received: from mga03.intel.com ([134.134.136.65]:2738 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234046AbiADQwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 11:52:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641315130; x=1672851130;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=B4JSVksj4KqzEAOO0ubUoTxIOso8jy7LZ/EF3a/TNdA=;
  b=Qmqoa5O2LOjmiWSZ3feg/288LWpJMLnrGiBcCgGoW9gbX1PRtEkeh32J
   xIcFIMTiphMRZFZrX6/RB3WJLl5nskh3QLeipAA8R3VQT4wk2oEL+o69j
   VE21ZUi2O217hvwQAfdmCi+ODS/xV0BWzThf8nEzy3qxPtYw/TbUDshVm
   3oB1nC6a1jOojuyPhwIKD17tsrknnmjC+dIqWPGVhKGUBoZCRMnpAt5qp
   TU4atKEWKpBF5KSIbC3jUjuFYU/lC//f0yMz6bHp7/JPrEd/L9oKMF7KE
   pj5YLjKy31xziNxWEL5+yqrHH/VVcsxzJFT7xOHeEXtqHyyxjD3TPatnA
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="242214257"
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="242214257"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 08:52:10 -0800
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="556218187"
Received: from mncallah-mobl.amr.corp.intel.com (HELO [10.209.35.108]) ([10.209.35.108])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 08:52:10 -0800
Subject: Re: [PATCH v13 2/2] x86/sgx: Add an attribute for the amount of SGX
 memory in a NUMA node
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, reinette.chatre@intel.com,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org
References: <20211116162116.93081-1-jarkko@kernel.org>
 <20211116162116.93081-2-jarkko@kernel.org> <YbzhBrimHGGpddDM@archlinux-ax161>
 <YcuhhI2+k0XVuTb1@iki.fi> <c857c964-89b9-d827-74ec-32cf874e8d8b@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Message-ID: <2da95214-8b1c-46e7-f6d1-a35ef2697c26@intel.com>
Date:   Tue, 4 Jan 2022 08:52:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <c857c964-89b9-d827-74ec-32cf874e8d8b@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/1/22 8:54 PM, Dave Hansen wrote:
> On 12/28/21 3:45 PM, Jarkko Sakkinen wrote:
>>> If I can provide any further information or testing, let me know!
>> Dave, when is the fix going to be applied [*]?
>>
>>> Cheers,
>>> Nathan
>> [*] https://lore.kernel.org/linux-sgx/YcGTePmWDMOQU1pn@iki.fi/T/#m831a01bdde347f9e0af2c973986fae0499718201
> Greg preferred hiding the file as opposed to faking a number in there.
> Any testing of the attached would be appreciated.

Well, that didn't work on real SGX hardware.  The sysfs node code calls
the ->is_visible() callback before SGX is initialized.

I'll send out and updated version shortly that uses sysfs_update_group()
instead.
