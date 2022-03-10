Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBD14D4273
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 09:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240316AbiCJI0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 03:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240315AbiCJI0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 03:26:35 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BFD1354B0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 00:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646900735; x=1678436735;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M1FxyZOr2miK6glLtvAtSHCGudtfTwOvAFevUu4VqpU=;
  b=MtxYCj+QnIjhmmR9T/K5XqbBGJEIQSLofSYnuC436s4ASRlIvnyVMbbb
   pL3ou/5jM9zPXJDNiIQmeUfggHVMUjG5dJvOapbKI07fuVJVGYA57y3Rb
   vmHtqVdp6UPOPC6SXJAdqswG17fwLf2Jg3oW0zowkuBe9ImGgcZtTvGsK
   I=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 10 Mar 2022 00:25:34 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 00:25:34 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 10 Mar 2022 00:25:34 -0800
Received: from [10.216.27.16] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Thu, 10 Mar
 2022 00:25:30 -0800
Message-ID: <8758f360-0c6f-28bb-8483-342ad808865f@quicinc.com>
Date:   Thu, 10 Mar 2022 13:55:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] mm: madvise: return correct bytes advised with
 process_madvise
Content-Language: en-US
To:     Minchan Kim <minchan@kernel.org>
CC:     <akpm@linux-foundation.org>, <yuehaibing@huawei.com>,
        <sfr@canb.auug.org.au>, <rientjes@google.com>,
        <edgararriaga@google.com>, <mhocko@suse.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <1646803679-11433-1-git-send-email-quic_charante@quicinc.com>
 <YijaP7cC6Sclxc29@google.com>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <YijaP7cC6Sclxc29@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks Minchan for your comment!!
On 3/9/2022 10:17 PM, Minchan Kim wrote:
>> @@ -1426,15 +1426,21 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
>>  
>>  	while (iov_iter_count(&iter)) {
>>  		iovec = iov_iter_iovec(&iter);
>> +		/*
>> +		 * Even when [start, end) passed to do_madvise covers
>> +		 * some unmapped addresses, it continues processing with
>> +		 * returning ENOMEM at the end. Thus consider the range
>> +		 * as processed when do_madvise() returns ENOMEM.
>> +		 * This makes process_madvise() never returns ENOMEM.
>> +		 */
> Looks like that this patch has two things. first, returns processed
> bytes instead of error in case of error. Second, keep working on
> rest vmas on -ENOMEM due to unmapped hole.
> 
> First thing totally makes sense to me(that's exactly I wanted to
> do but somehow missed) so it should go stable tree. However,
> second stuff might be arguble so it would be great if you split
> the patch.

Sure, then will split the patch in V2.

> 
