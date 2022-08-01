Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27CE5868E5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 13:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbiHALya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 07:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbiHALxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 07:53:51 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DD42FFC7
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 04:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659354629; x=1690890629;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NzcCfCscpwoWHMsQNKhneOoJCWfbmeXO5OjY7iwI/rc=;
  b=W93JPivz4gJqlsapmjex0/U+oYOF8YC4jfYVN+skuwtbelK/6cqw+2wt
   p+ulZoDZ2uS0voA+AovgNNXnl1rMRYIU5rMJg0lf3JRXhotYW8qxkL0td
   8lv+BSeRl4p5hisxu81U/UZHZJ5/maX+5WSd6W38h9/pMjGTjpoBWHypZ
   Y=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 01 Aug 2022 04:50:28 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 04:50:27 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 1 Aug 2022 04:50:27 -0700
Received: from [10.216.43.100] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 1 Aug 2022
 04:50:22 -0700
Message-ID: <f670c6ee-1c20-570f-68f9-42a3e1e85557@quicinc.com>
Date:   Mon, 1 Aug 2022 17:20:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V2] mm: fix use-after free of page_ext after race with
 memory-offline
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, <akpm@linux-foundation.org>,
        <quic_pkondeti@quicinc.com>, <pasha.tatashin@soleen.com>,
        <sjpark@amazon.de>, <sieberf@amazon.com>, <shakeelb@google.com>,
        <dhowells@redhat.com>, <willy@infradead.org>,
        <liuting.0x7c00@bytedance.com>, <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <1658931303-17024-1-git-send-email-quic_charante@quicinc.com>
 <6168cf49-bf75-2ebb-ab55-30de473835e3@redhat.com>
 <a26ce299-aed1-b8ad-711e-a49e82bdd180@quicinc.com>
 <3fc8a61b-ad70-8092-9197-4920e0897593@redhat.com>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <3fc8a61b-ad70-8092-9197-4920e0897593@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks David!!

On 8/1/2022 2:00 PM, David Hildenbrand wrote:
>> Having said that, I am open to go for call_rcu() and infact it will be a
>> much simple change where I can do the freeing of page_ext in the
>> __free_page_ext() itself which is called for every section there by
>> avoid the extra tracking flag PAGE_EXT_INVALID.
>>       ...........
>>         WRITE_ONCE(ms->page_ext, NULL);
>> 	call_rcu(rcu_head, fun); // Free in fun()
>>        .............
>>
>> Or your opinion is to use call_rcu () only once in place of
>> synchronize_rcu() after invalidating all the page_ext's of memory block?
> 
> Yeah, that would be an option. And if you fail to allocate a temporary
> buffer to hold the data-to-free (structure containing rcu_head), the
> slower fallback path would be synchronize_rcu().
> 

I will add this as a note in the code that in future If some
optimizations needs to be done in this path, this option can be
considered.  Hope this will be fine for now?

> But again, I'm also not sure if we have to optimize here right now.

Thanks,
Charan
