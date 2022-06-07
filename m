Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EABD53FFFD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 15:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244697AbiFGN0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 09:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244682AbiFGN0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 09:26:37 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22762C17CD;
        Tue,  7 Jun 2022 06:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654608397; x=1686144397;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UzJ5sFk3XLUYlgy5MtTnQZmHTWhbXi6L2isVak6wDXU=;
  b=y3+twpkCGtjxHOjVDpBcPpJ0564bv5zvPZDj+H+Q8DFsdUsHXjj13pfG
   XCaw3saMrisc5sAwwK4EmMbIrILEHPOEuJWxL7I2gncCDLEB1TBJSG+ST
   rxMeu91iubTLe18G+gvez1Ac/YLcTkPC9WX1AGL1BHnK0V4gbuJwYgTJc
   Y=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 07 Jun 2022 06:26:37 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 06:26:36 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 7 Jun 2022 06:26:35 -0700
Received: from [10.216.0.16] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 7 Jun 2022
 06:26:31 -0700
Message-ID: <9c457623-7a80-dad8-8ef8-2346b0a4f0a1@quicinc.com>
Date:   Tue, 7 Jun 2022 18:55:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [V4] serial: core: Do stop_rx in suspend path for console if
 console_suspend is disabled
Content-Language: en-CA
To:     Greg KH <gregkh@linuxfoundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
CC:     <jirislaby@kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_msavaliy@quicinc.com>,
        <dianders@chromium.org>, <mka@chromium.org>, <swboyd@chromium.org>
References: <1652692810-31148-1-git-send-email-quic_vnivarth@quicinc.com>
 <CGME20220523213246eucas1p2d0da08d931a996cd3410eda1c2fd48c0@eucas1p2.samsung.com>
 <bf7eec57-6ad6-2c1a-ea61-0e1d06fc77f5@samsung.com>
 <Yp9RCelSM9L+hpAV@kroah.com>
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
In-Reply-To: <Yp9RCelSM9L+hpAV@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/7/2022 6:52 PM, Greg KH wrote:
> On Mon, May 23, 2022 at 11:32:46PM +0200, Marek Szyprowski wrote:
>> Hi,
>>
>> On 16.05.2022 11:20, Vijaya Krishna Nivarthi wrote:
>>> For the case of console_suspend disabled, if back to back suspend/resume
>>> test is executed, at the end of test, sometimes console would appear to
>>> be frozen not responding to input. This would happen because, during
>>> resume, rx transactions can come in before system is ready, malfunction
>>> of rx happens in turn resulting in console appearing to be stuck.
>>>
>>> Do a stop_rx in suspend sequence to prevent this.
>>>
>>> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
>>> ---
>>> v4: moved the change to serial core to apply for all drivers
>>> v3: swapped the order of conditions to be more human readable
>>> v2: restricted patch to contain only stop_rx in suspend sequence
>>> v1: intial patch contained 2 additional unrelated changes in vicinity
>>> ---
>> This patch landed recently in linux-next as commit c9d2325cdb92
>> ("serial: core: Do stop_rx in suspend path for console if
>> console_suspend is disabled").
>>
>> Unfortunately it breaks console operation on my test systems after
>> system suspend/resume cycle if 'no_console_suspend' kernel parameter is
>> present. System properly resumes from suspend, the console displays all
>> the messages and even command line prompt, but then doesn't react on any
>> input. If I remove the 'no_console_suspend' parameter, the console is
>> again operational after system suspend/resume cycle. Before this patch
>> it worked fine regardless the 'no_console_suspend' parameter.
> Did this ever get resolved or do I need to revert this?

We have a resolution and I will be uploading a Fixes: patch today.

Thank you.

-Vijay/


>
> thanks,
>
> greg k-h
