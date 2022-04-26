Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8484850FFFF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 16:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351448AbiDZOHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 10:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351441AbiDZOHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 10:07:32 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4188198C78
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 07:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650981859; x=1682517859;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iZ0TXjmMThX0L3lTUqlAA5brY4dwXaaXq+sou7uxL8s=;
  b=voqJWvGIbLptb6DCHgS5PW4Vbhip9bNr9lVHA7vP7+3MHg/JXIPIIXYE
   dY0WXPcwgLI+ev+6asO2ZQRhuK87WOlr9OBROBw8oVPHp3v33kj7iKQJe
   kFXqbufHs8ghaz8xJr2SdmyNOjOC6YAoACAXs5UJf5lGnbEtQtJRIee0e
   Y=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 26 Apr 2022 07:04:19 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 07:04:18 -0700
Received: from [10.110.67.93] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.47.97.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 26 Apr
 2022 07:04:11 -0700
Message-ID: <13df1664-fc52-4772-afa1-4f75019b7830@quicinc.com>
Date:   Tue, 26 Apr 2022 19:34:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 ] devcoredump : Serialize devcd_del work
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Johannes Berg <johannes@sipsolutions.net>,
        <linux-kernel@vger.kernel.org>
CC:     <sboyd@kernel.org>, <rafael@kernel.org>,
        <gregkh@linuxfoundation.org>, Kees Cook <keescook@chromium.org>
References: <87levt14kn.ffs@tglx>
 <8186de033c87f0cdec296ae272a72c5b9a2880a3.camel@sipsolutions.net>
 <878rrt0xa2.ffs@tglx>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <878rrt0xa2.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.47.97.222)
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/26/2022 1:07 AM, Thomas Gleixner wrote:
> Cc+: Kees
> 
> On Mon, Apr 25 2022 at 19:19, Johannes Berg wrote:
>> On Mon, 2022-04-25 at 19:00 +0200, Thomas Gleixner wrote:
>>>
>>> Johannes, can you please explain whether this immediate flush in
>>> disabled_store() is really required and if so, why?
>>>
>> I don't really know, as I remember that requirement (or maybe even code,
>> not sure) came from Kees, who needed the lockdown.
>>
>> Given the use case (ChromeOS?) I'm not sure I see a need to flush all of
>> them, since I guess a typical system would set the lockdown early in
>> boot and hopefully not have a crash-dump around already.
>>
>> That said, I don't think the diagram you made works - fn() during the
>> iteration is guaranteed to be invoked with a reference of its own, so
>> the put_device() there can't be the last reference, only as fn() returns
>> you'd put the last reference *there*, freeing it.
> 
> Bah, you are right, it's magically protected by the klist ref, which
> prevents devcd from going away. Damned obvious.
> 
> This really needs comments why this all can magically "work".
> 
> Thanks,
> 
>          tglx
> 

Thanks you all for your time in reviewing this.
I tried to address few comments in v3 here.

https://lore.kernel.org/lkml/1650981343-11739-1-git-send-email-quic_mojha@quicinc.com/

While, we would like to hear from Kees about reason of immediate flush 
from disabled_store().

Regards,
-Mukesh
> 
> 
> 
