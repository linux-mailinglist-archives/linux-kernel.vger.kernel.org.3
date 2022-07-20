Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4835157B686
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 14:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240306AbiGTMeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 08:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240316AbiGTMeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 08:34:08 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A066248E86
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 05:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658320447; x=1689856447;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=m8UE94lm120xwp+UQ1DIKklBTjA1TqoSZvLkoilB/is=;
  b=aEv1Xx4rbOhr/3eQCnfCnHL328UVkV9K/3g3JQDVqmpMiGnV4K5v1gxY
   SLUkqvvFjaIx7nufsl1sT4tCsqRzlEx6TdQiweF3nMe/nU0ukOwo3ZrlA
   feiQNeACpbQMdgxSLa2AqXy8hOIiAgWd4KKU9Wr3Xet80XDAql5nF1iaP
   M=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 20 Jul 2022 05:34:07 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 05:34:07 -0700
Received: from [10.216.42.116] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.47.97.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 20 Jul
 2022 05:34:03 -0700
Message-ID: <d95c4715-c194-759b-b698-c548a771f27c@quicinc.com>
Date:   Wed, 20 Jul 2022 18:03:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5] devcoredump : Serialize devcd_del work
Content-Language: en-US
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>,
        <sboyd@kernel.org>, <rafael@kernel.org>, <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>
References: <1653660220-19197-1-git-send-email-quic_mojha@quicinc.com>
 <YrmsggY7L6E+LWJ+@kroah.com>
 <50bb39d7-8207-31e2-0a7d-99c5d2b3c8a8@quicinc.com>
In-Reply-To: <50bb39d7-8207-31e2-0a7d-99c5d2b3c8a8@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.47.97.222)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle reminder for review.

-Mukesh

On 7/1/2022 8:23 PM, Mukesh Ojha wrote:
> Thanks @greg.
> 
> Hi @johannes,
> 
> Could you review this patch?
> 
> -Mukesh
> 
> On 6/27/2022 6:41 PM, Greg KH wrote:
>> On Fri, May 27, 2022 at 07:33:40PM +0530, Mukesh Ojha wrote:
>>> In following scenario(diagram), when one thread X running 
>>> dev_coredumpm()
>>> adds devcd device to the framework which sends uevent notification to
>>> userspace and another thread Y reads this uevent and call to
>>> devcd_data_write() which eventually try to delete the queued timer that
>>> is not initialized/queued yet.
>>>
>>> So, debug object reports some warning and in the meantime, timer is
>>> initialized and queued from X path. and from Y path, it gets 
>>> reinitialized
>>> again and timer->entry.pprev=NULL and try_to_grab_pending() stucks.
>>>
>>> To fix this, introduce mutex and a boolean flag to serialize the 
>>> behaviour.
>>>
>>>       cpu0(X)                            cpu1(Y)
>>>
>>>      dev_coredump() uevent sent to user space
>>>      device_add()  ======================> user space process Y reads 
>>> the
>>>                                            uevents writes to devcd fd
>>>                                            which results into writes to
>>>
>>>                                           devcd_data_write()
>>>                                             mod_delayed_work()
>>>                                               try_to_grab_pending()
>>>                                                 del_timer()
>>>                                                   debug_assert_init()
>>>     INIT_DELAYED_WORK()
>>>     schedule_delayed_work()
>>>                                                     debug_object_fixup()
>>>                                                       
>>> timer_fixup_assert_init()
>>>                                                         timer_setup()
>>>                                                           
>>> do_init_timer()
>>>                                                         /*
>>>                                                          Above call 
>>> reinitializes
>>>                                                          the timer to
>>>                                                          
>>> timer->entry.pprev=NULL
>>>                                                          and this 
>>> will be checked
>>>                                                          later in 
>>> timer_pending() call.
>>>                                                         */
>>>                                                   timer_pending()
>>>                                                    
>>> !hlist_unhashed_lockless(&timer->entry)
>>>                                                      !h->pprev
>>>                                                  /*
>>>                                                    del_timer() checks 
>>> h->pprev and finds
>>>                                                    it to be NULL due 
>>> to which
>>>                                                    
>>> try_to_grab_pending() stucks.
>>>                                                  */
>>>
>>> Link: 
>>> https://lore.kernel.org/lkml/2e1f81e2-428c-f11f-ce92-eb11048cb271@quicinc.com/ 
>>>
>>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>>> ---
>>
>> I need an ack from the devcoredump maintainer before I can take this...
>>
>> thanks,
>>
>> greg k-h
