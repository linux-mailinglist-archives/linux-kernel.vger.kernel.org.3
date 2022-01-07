Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 416EF487CE5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 20:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbiAGTQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 14:16:44 -0500
Received: from mga07.intel.com ([134.134.136.100]:3822 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230475AbiAGTQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 14:16:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641583001; x=1673119001;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UJvI0p8S88c7Vko3exbS/ce8PjbOJZ8Ih0hV6b9Yuxo=;
  b=jX4N0AE7qAkrtAWAtpeCayYxe0mQX09BJXDrfjm9Jxwc+aHY20RWCRfu
   J/Dn1ydUEQaFMie90HLqz2hk/ezLyMk/obcwA7i67czr2/8iMJiAoupAf
   foWpVdW5tPaKSablWAtY7hWXxzMSYIRzq3SGdX501LaRgOUl3BotqL2sb
   LPhxDTUAKjdETVZbaTzzym2BOyTkcWIct4ssqIj8XuyqQJ0GenivxDriK
   wAjWqjDgXi8Xe3Gl/ERcmKY6trzBQpimYx88tze2yqcW1HRr/yRy9k3I7
   Osz2X9shCpAOhsVFL1U2S7g8ZogcTwV+3rnOiqFlhfO6DxvNp7qWfAhyw
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10219"; a="306290570"
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="306290570"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 11:16:14 -0800
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="612272381"
Received: from kcaccard-mobl.amr.corp.intel.com (HELO kcaccard-mobl1.jf.intel.com) ([10.212.25.179])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 11:16:14 -0800
Message-ID: <3b169fde457f28e086c49c8a3b8d81ac539cfb59.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/2] x86/sgx: Add accounting for tracking overcommit
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>, linux-sgx@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Fri, 07 Jan 2022 11:16:12 -0800
In-Reply-To: <171631a9-aaec-f590-3377-29c13fc6041e@intel.com>
References: <20220107181618.6597-1-kristen@linux.intel.com>
         <20220107181618.6597-2-kristen@linux.intel.com>
         <171631a9-aaec-f590-3377-29c13fc6041e@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-01-07 at 10:46 -0800, Dave Hansen wrote:
> On 1/7/22 10:16, Kristen Carlson Accardi wrote:
> > The overcommit percentage value is 150, which limits the total
> > number of
> > shared memory pages that may be consumed by all enclaves as backing
> > pages
> > to 1.5X of EPC pages on the system.
> 
> Hi Kristen,
> 
> Could you give some background on how this value was chosen and how
> it 
> might impact userspace?

Yes,
The value of 1.5x the number of EPC pages was chosen because it will
handle the most common case of a few enclaves that don't need much
overcommit without any impact to user space. In the less commone case
where there are many enclaves or a few large enclaves which need a lot
of overcommit due to large EPC memory requirements, the reclaimer may
fail to allocate a backing page for swapping if the limit has been
reached. In this case the page will not be able to be reclaimed and the
system will not be able to allocate any new EPC pages. Any ioctl or
call to add new EPC pages will get -ENOMEM, so for example, new
enclaves will fail to load, and new EPC pages will not be able to be
added.

Does that make sense?

Kristen


