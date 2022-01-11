Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2410448B425
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 18:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344420AbiAKRjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 12:39:54 -0500
Received: from mga14.intel.com ([192.55.52.115]:59914 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344597AbiAKRjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 12:39:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641922775; x=1673458775;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hKS0lJuNex5dc7wXpcCYMGTo8mqZH5st+2QZqqdnM3o=;
  b=kTmEVrJN6ccM+ktIXlBQVg0oFoHCHqXSkBsH+jiFt5z08dDSpPtBzR+X
   Kx4EeSLoMbxS2xJ+RTCjydvd5Nt3hl+6/8qGEuKvYKmDQt7SAbIGtq1Cd
   GGcrDgwg6gEEmt88aSoiSD3+FYPjh8Sbb+OS86KaAldxt649SLivfKU0E
   VZ2FzKrbzNxWVxjnlwd3s86mo++YuuYraAMHFp9Hp5cmEoftFn/k4eqnd
   /fB6ZTzR8sz+6dayPqZh2cENJgQaw8GQyZLrLJduCN+QhPdLu/FfoKD8b
   QW927TTRV0P2Z7pj+o9Tg4fn1F4SrmsFDeMQRpbkED11NJmRkELqVo4Ek
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="243746939"
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="243746939"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 09:39:34 -0800
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="613290362"
Received: from padhika1-mobl.amr.corp.intel.com (HELO [10.209.13.65]) ([10.209.13.65])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 09:39:34 -0800
Message-ID: <4996667d-938d-0833-f5a5-bf5ec82f69ea@intel.com>
Date:   Tue, 11 Jan 2022 09:39:30 -0800
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
 <bc370c39-d8c1-9371-2345-cf255ced9a1b@intel.com>
 <op.1fuaql06wjvjmi@hhuan26-mobl1.mshome.net>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <op.1fuaql06wjvjmi@hhuan26-mobl1.mshome.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/22 08:33, Haitao Huang wrote:
> On Tue, 11 Jan 2022 09:43:35 -0600, Dave Hansen <dave.hansen@intel.com> 
> wrote:
>> On 1/11/22 06:20, Haitao Huang wrote:
>>> If the system has a ton of RAM but limited EPC, I think it makes 
>>> sense to allow more EPC swapping, can we do min(0.5*RAM, 2*EPC)?
>>> I suppose if the system is used for heavy enclave load, user would be 
>>> willing to at least use half of RAM.
>>
>> If I have 100GB of RAM and 100MB of EPC, can I really *meaningfully* 
>> run 50GB of enclaves?  In that case, if everything was swapped out 
>> evenly, I would only have a 499/500 chance that a given page reference 
>> would fault.
> 
> The formula will cap swapping at 2*EPC so only 200MB swapped out.  So 
> the miss is at most 1/3.
> The original hard coded cap 1.5*EPC may still consume too much RAM if 
> RAM<1.5*EPC.

Oh, sorry, I read that backwards.

Basing it on the amount of RAM is a bit nasty.  You might either really 
overly restrict the amount of allowed EPC, or you have to handle hotplug.
