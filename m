Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4964E469357
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 11:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236406AbhLFKYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 05:24:02 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:42730 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236370AbhLFKX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 05:23:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638786030; x=1670322030;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/BBlyPONAhSOL7obwvgzZzSGer12RlY8b5Kj0XHt0pI=;
  b=jUEYNcWPtbU1mlWCsfpslyY7xmZAg58RprT5fJOGubUnVt89tMq5m3VO
   pxv/QsXuUBKNedpWwZUjqbGP300Quo8A6AgWPPcAeSrupQqZMwh8JobH8
   7w2h2VLPoY3omd66ozaGPIjuFk7nP1+9JrZzuBEGpEORZUhOsA5nlHlre
   w=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 06 Dec 2021 02:20:28 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 02:20:28 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 6 Dec 2021 02:20:28 -0800
Received: from [10.50.43.186] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 6 Dec 2021
 02:20:22 -0800
Message-ID: <7e5dbbf5-2385-ddb3-bf88-66e347d7d5e9@quicinc.com>
Date:   Mon, 6 Dec 2021 15:50:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCHv5 4/4] asm-generic/io: Add logging support for MMIO
 accessors
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Marc Zyngier <maz@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        <quic_psodagud@quicinc.com>
References: <cover.1638275062.git.quic_saipraka@quicinc.com>
 <99ecc64c6da3abb3ea2930082c40f1820655664c.1638275062.git.quic_saipraka@quicinc.com>
 <CAK8P3a1k-1_m7r-u0uO1nW1m43bt_hR9u+UeW=SqK40+Ltb+iA@mail.gmail.com>
 <0cd0bc8c-e3db-b3fb-5be4-c619d1d5d633@quicinc.com>
 <CAK8P3a0mxRshs=OrOK+NaMharykS0PffATq30wJTv4qe52_ecg@mail.gmail.com>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <CAK8P3a0mxRshs=OrOK+NaMharykS0PffATq30wJTv4qe52_ecg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/2021 3:31 PM, Arnd Bergmann wrote:
> On Mon, Dec 6, 2021 at 10:52 AM Sai Prakash Ranjan
> <quic_saipraka@quicinc.com> wrote:
>> Yes just the trace after read/write won't serve our usecase where we
>> expect crashes/hangs on accessing
>> these registers but internally we did have a log_post_read_mmio() as
>> well, if it is useful then I can add it.
> Are there any downsides to tracing both before and after, besides another growth
> in binary size? Aside from the 'value', that would also allow
> measuring the time it
> takes to complete a readl(), which may be valuable for other users as these
> can be significant.

Ah yes, that would be useful. No downsides as far as I know other than 
the size
but that should be fine given this depends on ftrace.

>
> Not sure how to best do that that, we could return a timestamp from the 'before'
> tracepoint and pass it into the 'after' tracepoint in order to log the
> difference, or just
> rely on calculating the differences in user space based on the log.

For trace events, timing information is already logged by ftrace 
infrastructure. Most of the users do
use these for timing information based on post processing these logs 
looking at these timestamps,
so we should be good using that as well.


> For the 'write' style accessors, the timing data would be less interesting, at
> least for posted PCI transactions, but it may be helpful to do the same for
> symmetry reasons.

Ok, I will add these post read/write logging in the next version.

Thanks,
Sai


