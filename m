Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF140554018
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 03:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354853AbiFVBca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 21:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbiFVBcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 21:32:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 975E633351
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 18:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655861539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HwcDXgVWRYn5xEnRTZK23QcHE6o+l0C+z1Ohojl7RzE=;
        b=TMePKWSYwuTfQSuk4jxNcI7CcjmD04o4drb0FsWusYkLrgXafOEepDdukIs+ddQzZo3SE3
        oKkLcOE2YgsKUmUK79+r+rmp2etj9Z42j9poAma1HfgUsnVGRr6HP7JjX5UKrBQNZtco29
        Ig4sGpN+VyMxE2JQDVOPQ/QPOd0+DaQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-StNFsjxzPx-si61hEaPxFQ-1; Tue, 21 Jun 2022 21:32:14 -0400
X-MC-Unique: StNFsjxzPx-si61hEaPxFQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB8A03801F50;
        Wed, 22 Jun 2022 01:32:13 +0000 (UTC)
Received: from [10.22.16.84] (unknown [10.22.16.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 212B8C15D42;
        Wed, 22 Jun 2022 01:32:12 +0000 (UTC)
Message-ID: <2c4084e3-9bd0-76ef-a11c-857de96a83e5@redhat.com>
Date:   Tue, 21 Jun 2022 21:32:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Lockups due to "locking/rwsem: Make handoff bit handling more
 consistent"
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Zhenhua Ma <mazhenhua@xiaomi.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
References: <20220617134325.GC30825@techsingularity.net>
 <b92bdb56-bfed-9cd2-5eb2-0b96a68b21d8@redhat.com>
 <20220620140950.GB15453@techsingularity.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220620140950.GB15453@techsingularity.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/22 10:09, Mel Gorman wrote:
> On Fri, Jun 17, 2022 at 10:29:20AM -0400, Waiman Long wrote:
>>> The C file and shell script to run it are attached.
>>>
>> Thanks for the reproducer and I will try to reproduce it locally.
>>
>> It is a known issue that I have receive similar report from an Oracle
>> engineer. That is the reason I posted commit 1ee326196c66 ("locking/rwsem:
>> Always try to wake waiters in out_nolock path") that was merged in v5.19. I
>> believe it helps but it may not be able to eliminate all possible race
>> conditions. To make rwsem behave more like before commit d257cc8cb8d5
>> ("locking/rwsem: Make handoff bit handling more consistent"), I posted a
>> follow-up patch
>>
>> https://lore.kernel.org/lkml/20220427173124.1428050-1-longman@redhat.com/
>>
>> But it hasn't gotten review yet.
>>
> FWIW, the patch passed the test case when applied to both 5.18 and
> 5.19-rc3.

Thanks for running the test. Do you mean that both 5.18 and 5.19-rc3 
fail the test and they pass only after applying the patch?

Anyway, I am not able to reproduce the failure in both 5.18 and 
5.19-rc3. Perhaps it is due to the difference in the running 
environment, i.e. gcc, glibc, etc. What operating environment (SuSE 
version) do you use to reproduce the failure? I used RHEL8 which is the 
most convenient one for me.

BTW, do you mind if I put down your name with a "Tested-by:" tag to the 
patch?

Thanks,
Longman

