Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0B8748B126
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 16:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245591AbiAKPnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 10:43:52 -0500
Received: from mga14.intel.com ([192.55.52.115]:45578 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240010AbiAKPnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 10:43:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641915830; x=1673451830;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mbYhbfEPWbz/jPT9cqRRXX3BhHy6E2iOrDNTHn/NRDk=;
  b=CtgQM56VgdNUncEHPiIB0+fBBdPLrwjemY3QtTSc5YOzgyq5XMCUfPXr
   /Je6iEBUu7Vfdon8mMRm0OyUBSrHiktgwqKqVXiXyZTbyzEW6105vZVPw
   Xupfioji8lc7If1YwmdwNWzmKN86RyhN1vLzPKWF16gyXe18tc3SGIT3X
   20oUFf1N6HTS93uj7cETdJVP9BCmo/YwQ0UqWqx0gaBqBb9UGbRDjZAe7
   //04mOfoYhh6NmCxK+oTvLtuIlh/pKfVDjyRwR9YE1vhBkgz16NoCTWyZ
   XmqYeAI3ZKjaTyrZpW0rw1YqIYqC8y8Xg3/u9n2MaI6QEM76k+pgRbOmI
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="243713762"
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="243713762"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 07:43:50 -0800
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="613254996"
Received: from padhika1-mobl.amr.corp.intel.com (HELO [10.209.13.65]) ([10.209.13.65])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 07:43:36 -0800
Message-ID: <bc370c39-d8c1-9371-2345-cf255ced9a1b@intel.com>
Date:   Tue, 11 Jan 2022 07:43:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 1/2] x86/sgx: Add accounting for tracking overcommit
Content-Language: en-US
To:     Haitao Huang <haitao.huang@linux.intel.com>,
        linux-sgx@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
References: <20220107181618.6597-1-kristen@linux.intel.com>
 <20220107181618.6597-2-kristen@linux.intel.com>
 <171631a9-aaec-f590-3377-29c13fc6041e@intel.com>
 <3b169fde457f28e086c49c8a3b8d81ac539cfb59.camel@linux.intel.com>
 <op.1ft4sin7wjvjmi@hhuan26-mobl1.mshome.net>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <op.1ft4sin7wjvjmi@hhuan26-mobl1.mshome.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/22 06:20, Haitao Huang wrote:
> If the system has a ton of RAM but limited EPC, I think it makes sense 
> to allow more EPC swapping, can we do min(0.5*RAM, 2*EPC)?
> I suppose if the system is used for heavy enclave load, user would be 
> willing to at least use half of RAM.

If I have 100GB of RAM and 100MB of EPC, can I really *meaningfully* run 
50GB of enclaves?  In that case, if everything was swapped out evenly, I 
would only have a 499/500 chance that a given page reference would fault.

This isn't about a "heavy enclave load".  If there is *that* much 
swapped-out enclave memory, will an enclave even make meaningful forward 
progress?
