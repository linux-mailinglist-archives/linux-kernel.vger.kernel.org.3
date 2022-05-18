Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B0152BFE9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 19:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240538AbiERQqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 12:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240495AbiERQpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 12:45:54 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5842AD;
        Wed, 18 May 2022 09:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652892348; x=1684428348;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=K0rrbc0K5LUJV5eVcZxJAUi8zXPdq/0qpUyGoqFCMP4=;
  b=d6towLlnaCDJLfyKtGKGr2JLj0EUP8z9iWRAanUwq8LcixuWEfVAhlfy
   z+pBlaYWUzyfNke4eK9/y+2HQbfYnC4k7YEVxgrmB69ThLqQbRqmrWFTR
   /KInc6OZ7z3cyrbsa2oknATrKKBWZ7UajjWcx41aLZihMwOdVGOKAEoSs
   U=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 18 May 2022 09:45:48 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 09:45:47 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 18 May 2022 09:45:47 -0700
Received: from [10.50.12.117] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 18 May
 2022 09:45:43 -0700
Message-ID: <ff0c9375-9e44-36fb-427e-37d53a6a7b98@quicinc.com>
Date:   Wed, 18 May 2022 22:15:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCHv14 5/9] lib: Add register read/write tracing support
Content-Language: en-US
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <arnd@arndb.de>, <catalin.marinas@arm.com>,
        <gregkh@linuxfoundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <maz@kernel.org>, <quic_psodagud@quicinc.com>,
        <quic_tsoni@quicinc.com>, <will@kernel.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>
References: <cover.1651663123.git.quic_saipraka@quicinc.com>
 <9827bae40f6f319f294d06859c9e3c7442f067f2.1651663123.git.quic_saipraka@quicinc.com>
 <20220518100721.18fb5876@gandalf.local.home>
 <c696ebfc-9a2a-7b12-7297-3be8a31a82d3@quicinc.com>
In-Reply-To: <c696ebfc-9a2a-7b12-7297-3be8a31a82d3@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/2022 8:48 PM, Sai Prakash Ranjan wrote:
> Hi Steve,
>
> On 5/18/2022 7:37 PM, Steven Rostedt wrote:
>>> +        (void *)(unsigned long)__entry->caller, __entry->width,
>> __entry->caller is already defined as "unsigned long", why the extra
>> typecast?
>
> I remember seeing compilation errors without this change in early versions of
> the series. Let me check this again.
>
>

No warnings or errors without this extra cast, yay. New version posted.

Thanks,
Sai
