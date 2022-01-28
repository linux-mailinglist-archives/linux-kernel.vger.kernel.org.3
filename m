Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34FC64A0437
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 00:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344568AbiA1X0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 18:26:33 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:13919 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233182AbiA1X03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 18:26:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643412389; x=1674948389;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gaeFT6+rwIwh7KdRBiFX2XPa3nQt2Oi6p4+k5qcmksM=;
  b=U740x/uKVBbpW2ka5eJsM5nG9jT9tptlWtFGpZC+5oceXRpxRsi5hUpr
   hMuW67Xp8KhE9oerMjeGMWFqRvITwFwtmcGpdc/dsCkkPe2JWSypVTWQQ
   x1s4yM/czZFWON7r5A+k+sh8T8ZeYPfgiF0wnPSuzAm1Q9seEZVlkvX2k
   g=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 28 Jan 2022 15:26:29 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 15:26:29 -0800
Received: from [10.110.48.15] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Fri, 28 Jan
 2022 15:26:28 -0800
Message-ID: <094ab4eb-b877-2a14-d6c8-1d9e28335d7d@quicinc.com>
Date:   Fri, 28 Jan 2022 15:26:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2] kbuild: Add environment variables for userprogs flags
Content-Language: en-US
To:     Nick Desaulniers <ndesaulniers@google.com>
CC:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        "Matthias Maennich" <maennich@google.com>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <llvm@lists.linux.dev>, Fangrui Song <maskray@google.com>
References: <20220112224342.958358-1-quic_eberman@quicinc.com>
 <20220128220841.3222637-1-quic_eberman@quicinc.com>
 <20220128224528.f7ejzw55t6kfefmm@google.com>
 <CAKwvOd=Ab+GWNzSC6eaDWTVDF6gJQ9fDDMT3hep-DzhrEA6DpQ@mail.gmail.com>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <CAKwvOd=Ab+GWNzSC6eaDWTVDF6gJQ9fDDMT3hep-DzhrEA6DpQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/28/2022 2:49 PM, Nick Desaulniers wrote:
>   On Fri, Jan 28, 2022 at 2:45 PM Fangrui Song <maskray@google.com> wrote:
>>
>> On 2022-01-28, Elliot Berman wrote:
>>> Allow additional arguments be passed to userprogs compilation.
>>> Reproducible clang builds need to provide a sysroot and gcc path to
>>> ensure same toolchain is used across hosts. KCFLAGS is not currently
>>> used for any user programs compilation, so add new USERCFLAGS and
>>> USERLDFLAGS which serves similar purpose as HOSTCFLAGS/HOSTLDFLAGS.
>>>
>>> Specifically, I'm trying to force CC_CAN_LINK to consistently fail in
>>> an environment where a user sysroot is not specifically available.
>>> Currently, Clang might automatically detect GCC installation on hosts
>>> which have it installed to a default location in /. With addition of
>>> these environment variables, you can specify flags such as:
>>>
>>> $ make USERCFLAGS=--sysroot=/dev/null USERLDFLAGS=-Wl,--sysroot=/dev/null
>>>
>>> to force sysroot detection to fail.
>>
>> -Wl,--sysroot=/dev/null => --sysroot
>>
>> As I mentioned in
>> https://lore.kernel.org/all/20220128031549.w5a4bilxbkppagfu@google.com/
>> -Wl,--sysroot=/dev/null does not suppress search paths like -L/lib .
> 
> In that case, Elliot, can you please test whether USERLDFLAGS is
> necessary to be specified AT ALL? Maybe we can drop that addition from
> this patch if so?

USERLDFLAGS as --sysroot=/dev/null isn't necessary and not needed for 
the Android kernel usecase. I've included here since we have HOSTLDFLAGS 
and LDFLAGS for host programs and kernel respectively.
