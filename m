Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBD448AF5D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 15:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241696AbiAKOUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 09:20:38 -0500
Received: from mga01.intel.com ([192.55.52.88]:52076 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241605AbiAKOUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 09:20:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641910837; x=1673446837;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=7RMJP2lXxAIbB5vNgMmj7i+EJNws1Qf8O/v9iesBz7A=;
  b=aAAXZ0XXSs3Y4Qa6mcKpzl6H0PoDLw4WhbgnD9y86CFLSfbVwKSXiPz9
   LpyBaL6WR3my8nmsTqiYizWwxbBuLHMDJsoPUyx+MbUe44c4GCOCxiqk9
   Dsl+C/5ibeiv62R3vmDRgiGlafXFvaz7h6rYNfE+ohqGZas6cLhJ/kgFS
   Ri4Z4ajYs58EmjjcDOVCwLIhzJdECr0Mx+bs8FE96fbxv74MlcWu+8wcE
   sSxAPJ45+IkbFrRzQgNBY6QTUs1PFt232ztM3PPW1j+3EH5GpWt4xPRhy
   ujkCyFKmvm1zQvSUaX9ETjtbF+/wE+WV8DcL8B0kZ3kIp7ZDSTXYufHXl
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="267830891"
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="267830891"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 06:20:35 -0800
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="528757782"
Received: from hhuan26-mobl1.amr.corp.intel.com (HELO hhuan26-mobl1.mshome.net) ([10.255.38.99])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 11 Jan 2022 06:20:34 -0800
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     "Dave Hansen" <dave.hansen@intel.com>, linux-sgx@vger.kernel.org,
        "Jarkko Sakkinen" <jarkko@kernel.org>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Kristen Carlson Accardi" <kristen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] x86/sgx: Add accounting for tracking overcommit
References: <20220107181618.6597-1-kristen@linux.intel.com>
 <20220107181618.6597-2-kristen@linux.intel.com>
 <171631a9-aaec-f590-3377-29c13fc6041e@intel.com>
 <3b169fde457f28e086c49c8a3b8d81ac539cfb59.camel@linux.intel.com>
Date:   Tue, 11 Jan 2022 08:20:32 -0600
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel Corp
Message-ID: <op.1ft4sin7wjvjmi@hhuan26-mobl1.mshome.net>
In-Reply-To: <3b169fde457f28e086c49c8a3b8d81ac539cfb59.camel@linux.intel.com>
User-Agent: Opera Mail/1.0 (Win32)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Jan 2022 13:16:12 -0600, Kristen Carlson Accardi  
<kristen@linux.intel.com> wrote:

> On Fri, 2022-01-07 at 10:46 -0800, Dave Hansen wrote:
>> On 1/7/22 10:16, Kristen Carlson Accardi wrote:
>> > The overcommit percentage value is 150, which limits the total
>> > number of
>> > shared memory pages that may be consumed by all enclaves as backing
>> > pages
>> > to 1.5X of EPC pages on the system.
>>
>> Hi Kristen,
>>
>> Could you give some background on how this value was chosen and how
>> it
>> might impact userspace?
>
> Yes,
> The value of 1.5x the number of EPC pages was chosen because it will
> handle the most common case of a few enclaves that don't need much
> overcommit without any impact to user space. In the less commone case
> where there are many enclaves or a few large enclaves which need a lot
> of overcommit due to large EPC memory requirements, the reclaimer may
> fail to allocate a backing page for swapping if the limit has been
> reached. In this case the page will not be able to be reclaimed and the
> system will not be able to allocate any new EPC pages. Any ioctl or
> call to add new EPC pages will get -ENOMEM, so for example, new
> enclaves will fail to load, and new EPC pages will not be able to be
> added.
>
> Does that make sense?

If the system has a ton of RAM but limited EPC, I think it makes sense to  
allow more EPC swapping, can we do min(0.5*RAM, 2*EPC)?
I suppose if the system is used for heavy enclave load, user would be  
willing to at least use half of RAM.

Thanks
Haitao
