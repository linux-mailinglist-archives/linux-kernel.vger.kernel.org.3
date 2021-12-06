Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B646746A087
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444601AbhLFQFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:05:12 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:36202 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444070AbhLFQCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 11:02:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638806314; x=1670342314;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eBsoCOieGRxUqBCU/SfO7UQSeK/mQGz2GwEs7g1Ifbo=;
  b=KwRB70mSTljF7TwvhlzATMTdlsBTqKTrz1Fw+GMvodTcTErH+CaaO1Ze
   tAmzlvP86HXHFQPZgihxSg+6cKxYlKXqBDwJyeoVNytY55H3GJUgOaekE
   wjMtdBQkWgrQaypmLSHiVGJ6/FNzJdzi7APS2O8TPOGuQSw3LoBfHdYCb
   s=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 06 Dec 2021 07:58:32 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 07:58:31 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 6 Dec 2021 07:58:31 -0800
Received: from [10.50.43.186] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 6 Dec 2021
 07:58:23 -0800
Message-ID: <7a8c0ef8-ce09-a3d7-90e9-d401f2feaec7@quicinc.com>
Date:   Mon, 6 Dec 2021 21:27:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCHv5 1/4] arm64: io: Use asm-generic high level MMIO
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
 <cc649faf144fce439b7a341303b6cc73ac285949.1638275062.git.quic_saipraka@quicinc.com>
 <CAK8P3a2JSSJxs92uEiJQAa0iQOvA6NDuww3+Br5cAxYvXVOOAQ@mail.gmail.com>
 <7b2b5888-c2ca-2ca0-8c0c-32128fcb37d2@quicinc.com>
 <CAK8P3a0TZp349d7xFvpa6rzGSa4Wj2cAhqOg9-BAewA-d+yvJA@mail.gmail.com>
 <2efe933e-de1e-0dfc-959a-c0003e28f830@quicinc.com>
 <CAK8P3a0L2tLeF1Q0+0ijUxhGNaw+Z0fyPC1oW6_ELQfn0=i4iw@mail.gmail.com>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <CAK8P3a0L2tLeF1Q0+0ijUxhGNaw+Z0fyPC1oW6_ELQfn0=i4iw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/2021 8:45 PM, Arnd Bergmann wrote:
> On Mon, Dec 6, 2021 at 2:52 PM Sai Prakash Ranjan
> <quic_saipraka@quicinc.com> wrote:
>> Sorry, what I meant was the literal name of these macros, i.e.,
>> __iormb() has more explicit naming as
>> IO read memory barrier and __io_ar() is IO after read? So doesn't it
>> make more sense that __iormb()
>> should be the primary definition which is already the case and ar/bw
>> should be based on them.
> My reasoning was that we should ideally only have one set, and that
> __io_ar()/__io_bw() are the ones used in architecture-independent code,
> so I'd rather use those and deprecate the arm64 specific ones, eventually
> moving all the arm64 specific code to use those directly where needed.
>
>          Arnd

Ah ok, good enough. I will do this in the next version.

Thanks,
Sai
