Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938504FC43D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 20:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349210AbiDKSnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 14:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349204AbiDKSnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 14:43:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B318411161
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 11:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649702454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iST1JCeDfb6wVIu/vYvu8a0R4dF4ChWv1KEudThOes8=;
        b=ZC9kfnFUL8G2SEDsZ/xZriGQFhKqYGVdlvpaO5hbqK4/c7ZE7JUDT8XSllTNsU/iQnDfxY
        m0xiX8m1+gpnOeI6tdwAtplw6zqmSlOGWo7QjLBfPccI/DJjmySsFHR4nfYf+0dbowOLBb
        4PrG63RXK+xIcpG0ev/Alj7I66BdIf4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-97-hHUTFYQpNaCZV7iWB-ciXQ-1; Mon, 11 Apr 2022 14:40:46 -0400
X-MC-Unique: hHUTFYQpNaCZV7iWB-ciXQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4CE461C05EAA;
        Mon, 11 Apr 2022 18:40:45 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5140A145BA41;
        Mon, 11 Apr 2022 18:40:44 +0000 (UTC)
Message-ID: <e873727e-22db-3330-015d-bd6581a2937a@redhat.com>
Date:   Mon, 11 Apr 2022 14:40:44 -0400
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
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <3f02975c-1a9d-be20-32cf-f1d8e3dfafcc@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/22 14:26, john.p.donnelly@oracle.com wrote:
> On 2/14/22 9:47 AM, chenguanyou wrote:
>> Hi Waiman, Greg,
>> This patch has been merged in branch linux-5.16.y.
>> Can we take it to the linux-5.10.y LTS version?
>>
>> thanks,
>
> Hi,
>
> As a FYI:
>
> We have observed that following lockup with this commit added to 
> 5.15.LTS:
>
> d257cc8cb8d5 - locking/rwsem: Make handoff bit handling more 
> consistent (4 months ago) <Waiman Long>
>
> The "fio" test suit fails with LVM devices composed of four NVME 
> devices with these observed lockup, panic.
>
>
>
> ext4:
>
> PID: 3682   TASK: ffff8f489ae34bc0  CPU: 2   COMMAND: "dio/dm-0"
>  #0 [fffffe0000083e50] crash_nmi_callback at ffffffff828772b3
>  #1 [fffffe0000083e58] nmi_handle at ffffffff82840778
>  #2 [fffffe0000083ea0] default_do_nmi at ffffffff8337a1e2
>  #3 [fffffe0000083ec8] exc_nmi at ffffffff8337a48d
>  #4 [fffffe0000083ef0] end_repeat_nmi at ffffffff8340153b
>     [exception RIP: _raw_spin_lock_irq+23]
>     RIP: ffffffff8338b2e7  RSP: ffff9c4409b47c78  RFLAGS: 00000046
>     RAX: 0000000000000000  RBX: ffff8f489ae34bc0  RCX: 0000000000000000
>     RDX: 0000000000000001  RSI: 0000000000000000  RDI: ffff8f47f7b90104
>     RBP: ffff9c4409b47d20   R8: 0000000000000000   R9: 0000000000000000
>     R10: 0000000000000000  R11: 0000000000000000  R12: ffff8f47f7b90104
>     R13: ffff9c4409b47cb0  R14: ffff8f47f7b900f0  R15: 0000000000000000
>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>     <NMI exception stack> ---
>  #5 [ffff9c4409b47c78] _raw_spin_lock_irq at ffffffff8338b2e7
>  #6 [ffff9c4409b47c78] rwsem_down_write_slowpath at ffffffff82925be9
>  #7 [ffff9c4409b47d28] ext4_map_blocks at ffffffffc11c26dc [ext4]
>  #8 [ffff9c4409b47d98] ext4_convert_unwritten_extents at
> ffffffffc11ad9e0 [ext4]
>  #9 [ffff9c4409b47df0] ext4_dio_write_end_io at ffffffffc11b22aa [ext4]
>
> xfs:
>
> PID: 3719   TASK: ffff9f81d2d74bc0  CPU: 37  COMMAND: "dio/dm-0"
>  #0 [fffffe0000894e50] crash_nmi_callback at ffffffffad6772b3
>  #1 [fffffe0000894e58] nmi_handle at ffffffffad640778
>  #2 [fffffe0000894ea0] default_do_nmi at ffffffffae17a1e2
>  #3 [fffffe0000894ec8] exc_nmi at ffffffffae17a48d
>  #4 [fffffe0000894ef0] end_repeat_nmi at ffffffffae20153b
>     [exception RIP: _raw_spin_lock_irq+23]
>     RIP: ffffffffae18b2e7  RSP: ffffbb7ec9637c48  RFLAGS: 00000046
>     RAX: 0000000000000000  RBX: ffff9f81d2d74bc0  RCX: 0000000000000000
>     RDX: 0000000000000001  RSI: 0000000000000000  RDI: ffff9f81c04a918c
>     RBP: ffffbb7ec9637ce8   R8: 0000000000000000   R9: 0000000000000000
>     R10: 0000000000000000  R11: 0000000000000000  R12: ffff9f81c04a918c
>     R13: ffffbb7ec9637c80  R14: ffff9f81c04a9178  R15: 0000000000000000
>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>     <NMI exception stack> ---
>  #5 [ffffbb7ec9637c48] _raw_spin_lock_irq at ffffffffae18b2e7
>  #6 [ffffbb7ec9637c48] rwsem_down_write_slowpath at ffffffffad725be9
>  #7 [ffffbb7ec9637cf0] xfs_trans_alloc_inode at ffffffffc074f2bd [xfs]
>  #8 [ffffbb7ec9637d50] xfs_iomap_write_unwritten at ffffffffc073ad15
> [xfs]
>  #9 [ffffbb7ec9637dd0] xfs_dio_write_end_io at ffffffffc072db62 [xfs]
>
>
> I have reached out to Waiman and he suggested this for our next test 
> pass:
>
>
> 1ee326196c6658 locking/rwsem: Always try to wake waiters in out_nolock 
> path

Does this commit help to avoid the lockup problem?

Commit 1ee326196c6658 fixes a potential missed wakeup problem when a 
reader first in the wait queue is interrupted out without acquiring the 
lock. It is actually not a fix for commit d257cc8cb8d5. However, this 
commit changes the out_nolock path behavior of writers by leaving the 
handoff bit set when the wait queue isn't empty. That likely makes the 
missed wakeup problem easier to reproduce.

Cheers,
Longman

