Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465AB4636F1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 15:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242306AbhK3OpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 09:45:18 -0500
Received: from mga07.intel.com ([134.134.136.100]:28007 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242309AbhK3OpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 09:45:12 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="299619908"
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="299619908"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 06:41:52 -0800
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="654193890"
Received: from felsner-mobl2.ger.corp.intel.com (HELO [10.249.36.147]) ([10.249.36.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 06:41:49 -0800
Subject: Re: [RFCv2 0/8] USI stylus support series
To:     Hyungwoo Yang <hyungwoo.yang@gmail.com>,
        linux-input@vger.kernel.org, benjamin.tissoires@redhat.com,
        jikos@kernel.org, mika.westerberg@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        peter.hutterer@who-t.net
References: <20211126130141.1811848-1-tero.kristo@linux.intel.com>
 <1bcb6a07-c1c2-c8c6-a0a7-4eace372dd5e@gmail.com>
From:   Tero Kristo <tero.kristo@linux.intel.com>
Message-ID: <447d53c6-280d-da3d-fb04-3fd161aa28f4@linux.intel.com>
Date:   Tue, 30 Nov 2021 16:41:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1bcb6a07-c1c2-c8c6-a0a7-4eace372dd5e@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hyungwoo,

On 30/11/2021 08:36, Hyungwoo Yang wrote:
> Hi Tero,
>
>
> I have a question. As you know, USI provides a room for vendors to 
> differentiate their stylus. If a vendor wants to add reach features to 
> differentiate their stylus. Do you think the vendor needs to come up 
> with like HID-USI-<vendor>.c to configure the corresponding 
> usages(vendor-defined data) ? or we should use other approach ? like 
> register callbacks via HID-core ?

I think this depends quite a bit on what kind of features we are talking 
about. Looking at this series, we have:

- hid-core changes to add new event codes / add support for these

- bfp modifications to support caching and write feature for the new 
event codes (technically they can be written already via /dev/hidraw 
directly, but the interface is bit clumsy, so we improve it with BFP)

So, depending on the feature you want to add, you can take either way, 
but probably hacking with BPF is going to be easiest. Vendor could even 
write their own BPF tool. Also, please note that the location of 
samples/bpf/hid_usi* is not going to remain, there will most likely be 
an external repository where the new HID related BPF tools are going to 
maintained, Benjamin had some thoughts about that already.

-Tero


>
> -Hyungwoo
>
> On 11/26/21 5:01 AM, Tero Kristo wrote:
>> Hi,
>>
>> This series is an update based on comments from Benjamin. What is done
>> is this series is to ditch the separate hid-driver for USI, and add the
>> generic support to core layers. This part basically brings the support
>> for providing USI events, without programmability (patches 1-6).
>>
>> Additionally, a HID-BPF based sample is provided which can be used to
>> program / query pen parameters in comparison to the old driver level
>> implementation (patches 7-8, patch #8 is an incremental change on top of
>> patch #7 which just converts the fifo to socket so that the client can
>> also get results back from the server.)
>>
>> The whole series is based on top of Benjamin's hid-bpf support work, and
>> I've pushed a branch at [1] with a series that works and brings in
>> the dependency. There are also a few separate patches in this series to
>> fix the problems I found from Benjamin's initial work for hid-bpf; I
>> wasn't able to get things working without those. The branch is also
>> based on top of 5.16-rc2 which required some extra changes to the
>> patches from Benjamin.
>>
>> -Tero
>>
>> [1] https://github.com/t-kristo/linux/tree/usi-5.16-rfc-v2-bpf
>>
>>
>>
>>
