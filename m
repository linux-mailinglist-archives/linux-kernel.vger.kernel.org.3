Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E22749BA24
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 18:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbiAYRTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 12:19:19 -0500
Received: from mga11.intel.com ([192.55.52.93]:16098 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1453635AbiAYRPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 12:15:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643130937; x=1674666937;
  h=to:cc:references:from:subject:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=veCZt3yQfTYBk3+GU00z9OZ21bMHmTBnTb5ztruHxPg=;
  b=InZJhdZ8h/rTgZAng4zAvgPPOxOIYUdsBTyj+fZhOlTEjgwwWVQEmyN/
   mChuqpKxs5FvXyAxIlJI1gyK/Y7QQDKkOTRywTXb2wboEjniD5VqYBaRN
   mil6iXBqEnpVNfe2314Eyx7ak5juYnCTRo/8Smt7+jGYVyPoEKsIEfxoI
   s1l6NB6V37lsFm4TBmQtPlyRrvmK6+3eo9WvnJvEezIJNkrYVla0xySS6
   +rTIix+gbWWfd3smRQf4z8bEr/v5gBZZm6bvwo6vCI+Vmgpg2fBclujey
   +ani0HDY3D3gCt8+GvJYyQWOnylpHrvjlbipGC2vWZH0IZn0yoRpgQ3mL
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="243951946"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="243951946"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 09:11:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="563104854"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga001.jf.intel.com with ESMTP; 25 Jan 2022 09:11:33 -0800
To:     Sven Schnelle <svens@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
References: <Yao35lElOkwtBYEb@kroah.com>
 <c2b5c9bb-1b75-bf56-3754-b5b18812d65e@linux.intel.com>
 <YbyWuxoBSicFBGuv@hirez.programming.kicks-ass.net>
 <YcGhIm7yqYPk4Nuu@hirez.programming.kicks-ass.net>
 <YeE4rtq6t73OxOi+@hirez.programming.kicks-ass.net>
 <cd534ff9-e500-c7ea-426a-347ac2b0830b@linux.intel.com>
 <YeLxE3zQ7Vexk3gv@hirez.programming.kicks-ass.net>
 <dfb311e3-1a83-31a2-3c82-fd982c0757f6@linux.intel.com>
 <Ye/w/lOf4f8+8fDt@hirez.programming.kicks-ass.net>
 <yt9dbl00rmgx.fsf@linux.ibm.com>
 <YfAA+age1zo3lxIB@hirez.programming.kicks-ass.net>
 <yt9dh79rnccf.fsf@linux.ibm.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: earlyprintk=xdbc seems broken
Message-ID: <f1ac3163-d005-9b0b-b9f1-f4e98b9798d5@linux.intel.com>
Date:   Tue, 25 Jan 2022 19:13:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <yt9dh79rnccf.fsf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.1.2022 16.01, Sven Schnelle wrote:
> Peter Zijlstra <peterz@infradead.org> writes:
> 
>> On Tue, Jan 25, 2022 at 02:09:18PM +0100, Sven Schnelle wrote:
>>> Peter Zijlstra <peterz@infradead.org> writes:
>>>
>>>> Now the documentation states we need this super speed A<->A cable, but
>>>> could you also update the documentation for usb-c ? There's a fair
>>>> number of usb-c only devices out there now.
>>>
>>> Stupid beginners question: Would every USB3 A-A cable work, or are the
>>> debug cables special? I've read the RX/TX pairs have to be swapped, but
>>> to me it looks like that's always the case?
>>
>> I'm using a random USB3 A-A cable (it came with an HDMI frame grabber of
>> of AliExpress). The official one has a wire missing I think, to avoid
>> ground loops or something like that.
>>
>> The easiest thing to do is try the runtime DBC option:
>>
>>   echo enable > /sys/bus/pci/devices/0000:00:14.0/dbc
>>
>> If that works you can see what it takes to make the earlyprintk one
>> working. This thread seems to have much of that covered.
> 
> Thanks, the sysfs test works for me. I have two A-A cables, one is from
> a cheap PCI-e extender, the other one from a KVM switch. Both work,
> which is great. So i assume that most A-A cable would work. I'm building
> a new kernel now with the patch on top, lets see.
> 

I enabled runtime dbc on a Tigerlake 0000:00:0d.0 xhci, and connected the
USB-C port to a host using a USB-C to A adapter, and a cheap USB3 A-to-A cable.
Worked for me, but can't make any official recommendation.

I'm guessing the USB-C port works as long as the USB-C TX/RX pins are muxed
to a xhci.

With additional dbc patches it's possible to have dbc connected on both xhci
controllers at the same time (runtime via sysfs).

-Mathias
