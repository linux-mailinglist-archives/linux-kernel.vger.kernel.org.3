Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8B249EAE8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 20:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245151AbiA0TN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 14:13:58 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:48856 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbiA0TN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 14:13:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1643310837; x=1674846837;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mV9Rntd10MU7cdeZ3c0E0Qx20jU1t4bULsvd73nv/E4=;
  b=LCYx+3t92J6b7hnH/lTshzY5eqNdm9wA6BE27Jp0DpbnM5x0H/so5/eT
   r9F5pF00jicVnHTgAQOeTCyqjrfNYbLNCIFVeHEcndUS19+sovc1MPVXO
   Znoru1jL5m1PQPZiPEiqcmM1g/33CkamiU7SaznbEP9/zea3NLo8gItKy
   c=;
X-IronPort-AV: E=Sophos;i="5.88,321,1635206400"; 
   d="scan'208";a="173626860"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-10222bbc.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP; 27 Jan 2022 19:13:56 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1d-10222bbc.us-east-1.amazon.com (Postfix) with ESMTPS id 9B8DA1A0067;
        Thu, 27 Jan 2022 19:13:51 +0000 (UTC)
Received: from EX13D02UWB002.ant.amazon.com (10.43.161.160) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Thu, 27 Jan 2022 19:13:50 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D02UWB002.ant.amazon.com (10.43.161.160) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Thu, 27 Jan 2022 19:13:50 +0000
Received: from dev-dsk-alisaidi-i31e-9f3421fe.us-east-1.amazon.com
 (10.200.138.153) by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP
 Server id 15.0.1497.28 via Frontend Transport; Thu, 27 Jan 2022 19:13:50
 +0000
Received: by dev-dsk-alisaidi-i31e-9f3421fe.us-east-1.amazon.com (Postfix, from userid 5131138)
        id 72BD921BE9; Thu, 27 Jan 2022 19:13:49 +0000 (UTC)
From:   Ali Saidi <alisaidi@amazon.com>
To:     <german.gomez@arm.com>
CC:     <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <alisaidi@amazon.com>, <andrew.kilroy@arm.com>,
        <benh@kernel.crashing.org>, <james.clark@arm.com>,
        <john.garry@huawei.com>, <jolsa@redhat.com>, <leo.yan@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <mark.rutland@arm.com>, <mathieu.poirier@linaro.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <will@kernel.org>
Subject: Re: [PATCH 1/2] perf arm-spe: Add arm_spe_record to synthesized
Date:   Thu, 27 Jan 2022 19:13:45 +0000
Message-ID: <20220127191345.18173-1-alisaidi@amazon.com>
X-Mailer: git-send-email 2.24.4.AMZN
In-Reply-To: <c4a96839-1b4b-ac4d-38aa-26c1f4c8645a@arm.com>
References: <c4a96839-1b4b-ac4d-38aa-26c1f4c8645a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 26/01/2022 19:07, German Gomez wrote:
[...]
>>> Have you tried this with perf-inject? I think it would need the PERF_SAMPLE_RAW bit in the sample_type,
>> Yes I've tried the following and it worked as expected with the original
>> perf.data or the perf.data.jitted after perf-inject. 
>>
>> perf record -e arm_spe_0/jitter=1/ -k 1 java ...
>> perf  inject -f --jit -i perf.data -o perf.data.jitted
>
>This is not injecting the synthesized samples. I think it is still    
>processing from the aux trace. Try adding "--itrace=i1i --strip" to the
>inject command to remove the AUXTRACE events. Judging by the raw
>samples, the data is missing:
>
> [...]

Yep, you're correct here. If I use the command above the raw samples are lost.

>>> Although I quickly looked over the perf inject code and it looks like it's expecting some type of padding:
>>>
>>> [...]
>>>
>>> I'm seeing some comments in utils/event.h related to this on the intel events.
>> Yes i noticed this too,but looking at how the raw data is added to the same
>> other places like intel-pt.c:1703 the perf_synth__raw*() functions are used to
>> strip away the 4 bytes bytes before the data is added to the sample. The other
>> places i can find the padding used is in builtin-script.c but given we have the
>> --dump-raw-trace option it's not clear to me that it's needed to wrap the
>> arm_spe_event in another struct with padding like perf_synth_intel_ptwrite?
>
>I think the intel use case makes sense because the layout of the data
>is fixed and documented. If we modify the struct arm_spe_record later it
>may not be obvious how to match it to the raw data of an older perf.data
>file. And we're generating bigger files with redundant information.

Not injecting the samples into the perf trace, but having a way to support
custom scripts parsing the data would be really useful and much faster than
trying to parse back the --dump-raw-trace output into something useful. The
other way to go would be to put a header that describes the version of the spe
struct at the head of it to address any future changes, but I'm not familiar
with a workflow that would benefit from the added complexity. 

Thanks,
Ali


