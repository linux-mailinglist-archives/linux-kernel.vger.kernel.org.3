Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40CD44D9D6F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 15:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348996AbiCOO13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 10:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbiCOO12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 10:27:28 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409CC54FA0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 07:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647354376; x=1678890376;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xf8O2CSFPHkJl2l4dsMsAB+UtUVKliQySS04oxYD/BU=;
  b=elc3P5ARpGV9/EPwVPhFB1KlKangDkoQjegjXpoenb7njWm4rxySR7M9
   8+oS69x8AIAIsE88qs4PrblagFtiQJv+G5w0XkzzqAxqskwmKtF+AoZb5
   SyRoOMj15tvtuM3NTPar90SxlUMyAChRk/onglBa0dLiJLLkMVQw+ElOn
   w=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 15 Mar 2022 07:26:15 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 07:26:15 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 15 Mar 2022 07:26:15 -0700
Received: from [10.216.32.215] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 15 Mar
 2022 07:26:10 -0700
Message-ID: <3b1626e7-3a32-5733-2a4f-e782c87b8e58@quicinc.com>
Date:   Tue, 15 Mar 2022 19:56:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V2,0/2]mm: madvise: return correct bytes processed with
 process_madvise
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <surenb@google.com>, <vbabka@suse.cz>, <rientjes@google.com>,
        <sfr@canb.auug.org.au>, <edgararriaga@google.com>,
        <minchan@kernel.org>, <nadav.amit@gmail.com>, <mhocko@suse.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <cover.1647008754.git.quic_charante@quicinc.com>
 <20220311134203.47cbeab087b731bada12d0f1@linux-foundation.org>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <20220311134203.47cbeab087b731bada12d0f1@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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

Thanks Andrew!!

On 3/12/2022 3:12 AM, Andrew Morton wrote:
>> With the process_madvise(), always choose to return non zero processed
>> bytes over an error. This can help the user to know on which VMA, passed
>> in the 'struct iovec' vector list, is failed to advise thus can take the
>> decission of retrying/skipping on that VMA.
> Thanks, this is not good.
> 
> We should have added userspace tests for process_madvise() along with
> the syscall itself.  But evidently that was omitted.  If someone
> decides to contribute such tests, hopefully they will include checks
> for these return values.

We are happy to contribute here.

> 
