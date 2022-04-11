Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96D24FC652
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 23:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346486AbiDKVKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 17:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiDKVKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 17:10:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A2212AC70
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 14:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649711265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jemOUKtsQjTBQP4/G5H2AE4psd90cYA8xWnRCL9lC8M=;
        b=OuAzSa0kpB1s5fZB7f6neiEH/p/wh6Sb3jmcnkFUh60hwmClCUDkBy8mpVH6h4xgx8mlKD
        EEu8X4w8gSVU8iHuWCHgl9TKL0nF+AZdOmfDqnyz6pDZLPB1FaPrxgMjLPgOIdvdsMBrkB
        +dFPYuuPF8tYf+5qCaU7ETnqI9842Yw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-524-DJT_zkMEMjKrYjRkkS4JcQ-1; Mon, 11 Apr 2022 17:07:40 -0400
X-MC-Unique: DJT_zkMEMjKrYjRkkS4JcQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5B49D85A5A8;
        Mon, 11 Apr 2022 21:07:39 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D8FBE40CF914;
        Mon, 11 Apr 2022 21:07:38 +0000 (UTC)
Message-ID: <161c2e25-3d26-4dd7-d378-d1741f7bcca8@redhat.com>
Date:   Mon, 11 Apr 2022 17:07:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5] locking/rwsem: Make handoff bit handling more
 consistent
Content-Language: en-US
To:     john.p.donnelly@oracle.com,
        chenguanyou <chenguanyou9338@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     dave@stgolabs.net, hdanton@sina.com, linux-kernel@vger.kernel.org,
        mazhenhua@xiaomi.com, mingo@redhat.com, peterz@infradead.org,
        quic_aiquny@quicinc.com, will@kernel.org, sashal@kernel.org
References: <20211116012912.723980-1-longman@redhat.com>
 <20220214154741.12399-1-chenguanyou@xiaomi.com>
 <3f02975c-1a9d-be20-32cf-f1d8e3dfafcc@oracle.com>
 <e873727e-22db-3330-015d-bd6581a2937a@redhat.com>
 <31178c33-e25c-c3e8-35e2-776b5211200c@oracle.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <31178c33-e25c-c3e8-35e2-776b5211200c@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/11/22 17:03, john.p.donnelly@oracle.com wrote:
>
>>>
>>> I have reached out to Waiman and he suggested this for our next test 
>>> pass:
>>>
>>>
>>> 1ee326196c6658 locking/rwsem: Always try to wake waiters in 
>>> out_nolock path
>>
>> Does this commit help to avoid the lockup problem?
>>
>> Commit 1ee326196c6658 fixes a potential missed wakeup problem when a 
>> reader first in the wait queue is interrupted out without acquiring 
>> the lock. It is actually not a fix for commit d257cc8cb8d5. However, 
>> this commit changes the out_nolock path behavior of writers by 
>> leaving the handoff bit set when the wait queue isn't empty. That 
>> likely makes the missed wakeup problem easier to reproduce.
>>
>> Cheers,
>> Longman
>>
>
> Hi,
>
>
> We are testing now
>
> ETA for fio soak test completion is  ~15hr from now.
>
> I wanted to share the stack traces for future reference + occurrences.
>
I am looking forward to your testing results tomorrow.

Cheers,
Longman

