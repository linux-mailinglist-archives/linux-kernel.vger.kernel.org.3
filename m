Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0DD4F8D70
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbiDHGRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 02:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiDHGRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 02:17:21 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5181115A;
        Thu,  7 Apr 2022 23:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649398519; x=1680934519;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=68dNn59YCjC6TD6XjImAybXjsyqeVIqyoKPnLWmhy8o=;
  b=iLGwUf7d+UzilOn9sF3d/rDzFhY5jnwbmFoPNLkwowMCH1xn0FYj+G+8
   X3d+6hUy8wWsDyN/MwFLjVDC5cZD2WHY/fGA1RmHLkNDyXp55qWdw1k+U
   rvgMY2mUF2enctKLB5VOI0qONheNH9UJeI28q6I14IvNRLwXHIDpjjxiY
   Y=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 07 Apr 2022 23:15:19 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 23:15:18 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 7 Apr 2022 23:15:18 -0700
Received: from [10.216.50.51] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 7 Apr 2022
 23:15:14 -0700
Message-ID: <e42527f9-fa5e-f03d-3af8-fe2c27f9597b@quicinc.com>
Date:   Fri, 8 Apr 2022 11:45:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [V3] drivers/tty/serial/qcom-geni-serial: Do stop_rx in suspend
 path for console if console_suspend is disabled
Content-Language: en-CA
To:     Jiri Slaby <jirislaby@kernel.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <gregkh@linuxfoundation.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_msavaliy@quicinc.com>, <dianders@chromium.org>
References: <1649316351-9220-1-git-send-email-quic_vnivarth@quicinc.com>
 <1649316351-9220-2-git-send-email-quic_vnivarth@quicinc.com>
 <0f52c6aa-46be-6971-76df-364150b1c1e1@kernel.org>
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
In-Reply-To: <0f52c6aa-46be-6971-76df-364150b1c1e1@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/7/2022 1:21 PM, Jiri Slaby wrote:
> On 07. 04. 22, 9:25, Vijaya Krishna Nivarthi wrote:
>> For the case of console_suspend disabled, if back to back suspend/resume
>> test is executed, at the end of test, sometimes console would appear to
>> be frozen not responding to input. This would happen because, for
>> console_suspend disabled, suspend/resume routines only turn resources
>> off/on but don't do a port close/open.
>> As a result, during resume, some rx transactions come in before 
>> system is
>> ready, malfunction of rx happens in turn resulting in console appearing
>> to be stuck.
>>
>> Do a stop_rx in suspend sequence to prevent this. start_rx is already
>> present in resume sequence as part of call to set_termios which does a
>> stop_rx/start_rx.
>
> So why is it OK for every other driver? Should uart_suspend_port() be 
> fixed instead?

For qcom driver we know that set_termios() call in uart_suspend_port() 
will recover with a call to start_rx.
However that may not be the case with other drivers.

We can move stop_rx to uart_suspend_port() and additionally have a 
start_rx in uart_resume_port()
Please let know if such a change would be ok.
Thank you.


