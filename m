Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25DE44881AB
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 06:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbiAHFeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 00:34:25 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:17913 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229708AbiAHFeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 00:34:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1641620064; x=1673156064;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rur0/nZv+Mm/lbEL32xKYlmQrxtSdjeSo48l1xph7k8=;
  b=jjkZLFZMHk8L/E7zv84O+8hjotCGU4HCcqqa2NGm6871gfL5ghjNaFWN
   d+v3mnOD7yR9mVliP5pnau7JXFmBqWmc4pDAPB2+VcXeLuepkWM9yJpxA
   Lq/6B5mm0sz41GZ24UFFYQc3QNMimtWnSGXgyeitROeaKQMCicWAhA+iS
   4=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 07 Jan 2022 21:34:24 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 21:34:24 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 7 Jan 2022 21:34:23 -0800
Received: from [10.50.8.216] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Fri, 7 Jan 2022
 21:34:19 -0800
Message-ID: <b36d92de-ae0b-243d-f2de-e12fe730f6c4@quicinc.com>
Date:   Sat, 8 Jan 2022 11:04:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCHv6 4/5] tracing: Add register read/write tracing support
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        gregkh <gregkh@linuxfoundation.org>, <quic_psodagud@quicinc.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>
References: <cover.1638858746.git.quic_saipraka@quicinc.com>
 <76983c26d889df7252a17017a48754163fb6b0d5.1638858747.git.quic_saipraka@quicinc.com>
 <20220106131824.073fbe5c@gandalf.local.home>
 <df9b5a82-5f00-f3ec-14cf-0b212be2a7a7@quicinc.com>
 <20220107095638.7d81c1b9@gandalf.local.home>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <20220107095638.7d81c1b9@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/7/2022 8:26 PM, Steven Rostedt wrote:
> On Fri, 7 Jan 2022 10:40:05 +0530
> Sai Prakash Ranjan <quic_saipraka@quicinc.com> wrote:
>
>> Hi Steve,
>>
>> On 1/6/2022 11:48 PM, Steven Rostedt wrote:
>>> This should not be in the kernel/trace directory. It should be in the
>> Hmm these are called from low level generic io header file
>> (include/asm-generic/) where
>> we wouldn't have any Kconfig to control this feature flexibly and as we
>> can have this as
>> a generic feature selectable by other architectures, wouldn't this be
>> suited in kernel/trace?
> Isn't there a place for generic rwmmio code?

I am thinking of moving it to lib/ similar to an interface of 
logic_iomem.c which
Arnd had initially suggested to look at.

>> I thought you were ok with the folder structure in the initial versions
>> of the series?
> Sorry, I missed the C file in kernel/trace. The files in kernel/trace tend
> to be specific for the internals of tracing. This C file is more to hold
> helper functions for mmio, which to me should be someplace for mmio code.
> Perhaps in mm/ ?
>

Oh ok, mm would not be the right fit as it is memory management and this 
is about
memory mapped IO, let me try and move it to lib/ as done for logic_iomem.c

Thanks,
Sai
