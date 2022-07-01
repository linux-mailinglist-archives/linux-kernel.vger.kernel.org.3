Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CF6563637
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 16:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbiGAOxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 10:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbiGAOxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 10:53:53 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943C41838F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 07:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656687232; x=1688223232;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6MNK+ZtSbcwXSIkZAqTLf+OhS7G7X3GCEGjl/zZ7lXg=;
  b=imtptmoZVmRP1GG6QRS09uJ3tdowFfYstMUVHsY39uuTbli+TlVjccrD
   PTsXw906ru9u6kK83Jz4ZN8KFfWSHGZMnD5HCpwePufJYkEOJHRoP2sXS
   vtCoAzph+Uxt6GsXYocl9ERjYpe2onnVuDi4d719gtSCLt1/hPEl2DyJL
   M=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 01 Jul 2022 07:53:52 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 07:53:52 -0700
Received: from [10.216.41.49] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.47.97.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 1 Jul 2022
 07:53:49 -0700
Message-ID: <50bb39d7-8207-31e2-0a7d-99c5d2b3c8a8@quicinc.com>
Date:   Fri, 1 Jul 2022 20:23:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v5] devcoredump : Serialize devcd_del work
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>,
        <sboyd@kernel.org>, <rafael@kernel.org>, <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>
References: <1653660220-19197-1-git-send-email-quic_mojha@quicinc.com>
 <YrmsggY7L6E+LWJ+@kroah.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <YrmsggY7L6E+LWJ+@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.47.97.222)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks @greg.

Hi @johannes,

Could you review this patch?

-Mukesh

On 6/27/2022 6:41 PM, Greg KH wrote:
> On Fri, May 27, 2022 at 07:33:40PM +0530, Mukesh Ojha wrote:
>> In following scenario(diagram), when one thread X running dev_coredumpm()
>> adds devcd device to the framework which sends uevent notification to
>> userspace and another thread Y reads this uevent and call to
>> devcd_data_write() which eventually try to delete the queued timer that
>> is not initialized/queued yet.
>>
>> So, debug object reports some warning and in the meantime, timer is
>> initialized and queued from X path. and from Y path, it gets reinitialized
>> again and timer->entry.pprev=NULL and try_to_grab_pending() stucks.
>>
>> To fix this, introduce mutex and a boolean flag to serialize the behaviour.
>>
>>   	cpu0(X)			                cpu1(Y)
>>
>>      dev_coredump() uevent sent to user space
>>      device_add()  ======================> user space process Y reads the
>>                                            uevents writes to devcd fd
>>                                            which results into writes to
>>
>>                                           devcd_data_write()
>>                                             mod_delayed_work()
>>                                               try_to_grab_pending()
>>                                                 del_timer()
>>                                                   debug_assert_init()
>>     INIT_DELAYED_WORK()
>>     schedule_delayed_work()
>>                                                     debug_object_fixup()
>>                                                       timer_fixup_assert_init()
>>                                                         timer_setup()
>>                                                           do_init_timer()
>>                                                         /*
>>                                                          Above call reinitializes
>>                                                          the timer to
>>                                                          timer->entry.pprev=NULL
>>                                                          and this will be checked
>>                                                          later in timer_pending() call.
>>                                                         */
>>                                                   timer_pending()
>>                                                    !hlist_unhashed_lockless(&timer->entry)
>>                                                      !h->pprev
>>                                                  /*
>>                                                    del_timer() checks h->pprev and finds
>>                                                    it to be NULL due to which
>>                                                    try_to_grab_pending() stucks.
>>                                                  */
>>
>> Link: https://lore.kernel.org/lkml/2e1f81e2-428c-f11f-ce92-eb11048cb271@quicinc.com/
>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>> ---
> 
> I need an ack from the devcoredump maintainer before I can take this...
> 
> thanks,
> 
> greg k-h
