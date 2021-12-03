Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47416466F07
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 02:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236994AbhLCBRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 20:17:05 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35198 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhLCBRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 20:17:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 933D2B8259E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 01:13:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1478C00446;
        Fri,  3 Dec 2021 01:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638494019;
        bh=n57k6U7BW8VgLU48lSFDh1oK3CtoLW1LIqJES3Ic1Qg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rWxP8RrXU1aUJtsDSV7yB6O9Nbxn0EzwuegKXWK1eBR8dQPcHgNSkF2SWozC+Ko77
         HjdsAYV6epgBvjHwk2ij/W0yLTUvcsHXLfakmR27+D1zNMR0/H2ospYKkP/VdQI6X/
         9jbfNank/a+UMNDie59tUgrrLXxYVqAFgqKXw4/9zkAMjMYeKNqEJucGk2NiLYeoT0
         XuKpNF7QZy2sskjTf04gxbRDHpi3gFIgJ29H/aygFHH+KpDZzzmdi90vTyIa8+KjZi
         GjZKz4stzfy0SP+u4AC+5ZYwJAWosoh3zZABovEjZP1rBbNWDcsbp+1MQLTWKROXlC
         RGn02P4chgrGQ==
Message-ID: <0a4a1ad5-5143-bd51-c8db-194f7fa443b7@kernel.org>
Date:   Thu, 2 Dec 2021 17:13:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH V7 08/18] x86/entry: Preserve PKRS MSR across exceptions
Content-Language: en-US
To:     Ira Weiny <ira.weiny@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-mm@kvack.org
References: <20210804043231.2655537-1-ira.weiny@intel.com>
 <20210804043231.2655537-9-ira.weiny@intel.com>
 <20211113005051.GN3538886@iweiny-DESK2.sc.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <20211113005051.GN3538886@iweiny-DESK2.sc.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/21 16:50, Ira Weiny wrote:
> On Tue, Aug 03, 2021 at 09:32:21PM -0700, 'Ira Weiny' wrote:
>> From: Ira Weiny <ira.weiny@intel.com>
>>
>> The PKRS MSR is not managed by XSAVE.  It is preserved through a context
>> switch but this support leaves exception handling code open to memory
>> accesses during exceptions.
>>
>> 2 possible places for preserving this state were considered,
>> irqentry_state_t or pt_regs.[1]  pt_regs was much more complicated and
>> was potentially fraught with unintended consequences.[2]  However, Andy
>> came up with a way to hide additional values on the stack which could be
>> accessed as "extended_pt_regs".[3]
> 
> Andy,
> 
> I'm preparing to send V8 of this PKS work.  But I have not seen any feed back
> since I originally implemented this in V4[1].
> 
> Does this meets your expectations?  Are there any issues you can see with this
> code?

I think I'm generally okay with the approach to allocating space.  All 
of Thomas' comments still apply, though.  (Sorry, I'm horribly behind.)
