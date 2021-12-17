Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE8147895A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 12:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235191AbhLQLAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 06:00:07 -0500
Received: from mga12.intel.com ([192.55.52.136]:26872 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235165AbhLQLAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 06:00:06 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="219746368"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="219746368"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 03:00:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="662813875"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga001.fm.intel.com with ESMTP; 17 Dec 2021 03:00:03 -0800
To:     Greg KH <gregkh@linuxfoundation.org>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
References: <YajkzwmWQua3Kh6A@hirez.programming.kicks-ass.net>
 <105f35d2-3c53-b550-bfb4-aa340d31128e@linux.intel.com>
 <88f466ff-a065-1e9a-4226-0abe2e71b686@linux.intel.com>
 <972a0e28-ad63-9766-88da-02743f80181b@intel.com> <Yao35lElOkwtBYEb@kroah.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: earlyprintk=xdbc seems broken
Message-ID: <c2b5c9bb-1b75-bf56-3754-b5b18812d65e@linux.intel.com>
Date:   Fri, 17 Dec 2021 13:01:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <Yao35lElOkwtBYEb@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3.12.2021 17.29, Greg KH wrote:
> On Fri, Dec 03, 2021 at 07:22:57AM -0800, Dave Hansen wrote:
>> On 12/3/21 6:31 AM, Mathias Nyman wrote:
>>>>> Can you please see if you can repro and fix this?
>>>>>
>>>>> This all was with current 5.16-rc3 on a tigerlake nuc.
>>>>>
>>>>> Also, perhaps you can update the guide on what sort of setup/cables
>>>>> etc.. you need when either the host or the client is a usb3.1 usb-c only
>>>>> device.
>>>>>
>>>> + Mathias, maybe he still has a USB 3.0 debugging cable.
>>>>
>>> Should have at the office, I'll pick it up next week and try it out.
>>
>> Is someone at Intel responsible for this thing? get_maintainer.pl
>> doesn't think so:
>>
>>> $ perl scripts/get_maintainer.pl ./drivers/usb/early/xhci-dbc.c
>>> Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:USB SUBSYSTEM)
>>> Mike Rapoport <rppt@kernel.org> (commit_signer:1/1=100%,authored:1/1=100%,added_lines:5/5=100%,removed_lines:5/5=100%)
>>> Andrew Morton <akpm@linux-foundation.org> (commit_signer:1/1=100%)
>>> linux-usb@vger.kernel.org (open list:USB SUBSYSTEM)
>>> linux-kernel@vger.kernel.org (open list)
> 
> Intel is the only one that has this hardware :(
> 
> 

I can reproduce this.
Looks like problems started when driver converted to readl_poll_timeout_atomic() in:

796eed4b2342 usb: early: convert to readl_poll_timeout_atomic()

Seems to hang when read_poll_timeout_atomic() calls ktime_* functions.
Maybe  it's too early for ktime.

After reverting that patch it works again for me.

-Mathias
