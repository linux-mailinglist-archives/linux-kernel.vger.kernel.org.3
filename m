Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EADE247BFD1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 13:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237666AbhLUMjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 07:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237676AbhLUMjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:39:33 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F867C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 04:39:33 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id m15so12195235pgu.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 04:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=Jcbc6QJP89ak79IAx14tbPJ/4XYy5wRBpwiCtLAceHo=;
        b=RTzjvbKc6uU8ejTR3DBqNOrBsXCe6pWEGzo81lZPXKvHshyIJwm4jeAC77bt3Oay6p
         aXZ2kifSO1JkAv91tfmGhv9p1x+i70ueheH8fg4lVQ0kWt/+3y5sQL5smEY95X9oH6fe
         IiGWwImCn30LFIIM6kGF1+YjmRkW8IJxGYlNn66qmvzccgOYDUk6Rm+3O4hesCE+Y/uA
         qCmvMfQVUZvnw/NRIWtBXhM1+EehRLwXWKdWf/rK5Vd34WZsNKnIL+jsZBYxavNFZUXT
         PDNENqGS18oc76PZ1TGQVrGPvcri7Z8wvFcYDZS7PstV1XItGra8kj2rfCb4brD2oDWP
         2AfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Jcbc6QJP89ak79IAx14tbPJ/4XYy5wRBpwiCtLAceHo=;
        b=59pTnypAVsi/hohYL+6uwdjWT642RThTM7vx9m1iAtNKliY2WeimKW/FLg1gDyV4Y7
         BPa9WmU0yl1snlgsFGNfPcWKxk1D+rn3dqxa9+CZkh8WgwKBhCbtB+IK+DDdBlwecTvz
         N+69wIJzDT3XSIwCOna9WhNyBfFGN3tvBIPKM3XYUqA2ROgC+MXFM1KzfuiLtXkTZfBB
         EnagmNLeVGYDtEgCKUZrL3tmlLslpTE+YJ3i0TXtk1sHOCjNN8ZiJRJ/bFAhmdpwhCiW
         /xT7kTXe52+97wCUo9rzKOFzPqO9nQKmR5uBHBvTAaXdR4FCZR3cEd0Flcak0kKVtJ9d
         lKiw==
X-Gm-Message-State: AOAM530Bz9zIXwV20xsX5rqhQQj0hLp9/qJZEN+KRCw0xldPgKYje+9i
        2p6mNNbhXtzLrwL66fvy0Q0=
X-Google-Smtp-Source: ABdhPJziHGdGbwG+RInTKfmcdDOJGB2/hJeuZ1A08ldhDuag25urGAzwKN+ETr4pB5AXrONJZdt3Cw==
X-Received: by 2002:a63:7a05:: with SMTP id v5mr2753515pgc.83.1640090372469;
        Tue, 21 Dec 2021 04:39:32 -0800 (PST)
Received: from [30.240.97.243] ([205.204.117.107])
        by smtp.gmail.com with ESMTPSA id v22sm2540494pjg.47.2021.12.21.04.39.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 04:39:32 -0800 (PST)
Message-ID: <c7f5f829-5f2f-0c57-0599-6fc20fc8f1d7@gmail.com>
Date:   Tue, 21 Dec 2021 20:39:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v2] virtio_mem: fix panic on mb_states indexing overflow
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, vbabka@suse.cz, ziy@nvidia.com
References: <e60a66f60c059237bbf5cec3623c162a1bb1cbcb.1640005703.git.renzhen.rz@alibaba-inc.com>
 <32103255-7eba-08c1-8ab8-0730486332c1@redhat.com>
From:   Eric Ren <renzhengeek@gmail.com>
In-Reply-To: <32103255-7eba-08c1-8ab8-0730486332c1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2021/12/20 22:15, David Hildenbrand 写道:
> On 20.12.21 14:18, Eric Ren wrote:
>> `mb_id` is unsigned integer, which is used to index
>> `mb_states` array in reverse order. `mb_id` can decrease
>> to `0UL - 1` that is a very large number, causing invalid
>> address access.
> Hi Eric,
>
> thanks for your report!
>
> The only way I can see this happening would be if
>
> next_mb_id == 0, in which case we would get
>
> 	_mb_id = _vm->sbm.next_mb_id - 1
> 	-> _mb_id = 0 - 1 = -1ULL
In the for loop,  eg.

_vm->sbm.next_mb_id == 756
initial _mb_id = 755
_vm->sbm.first_mb_id == 0
_vm->sbm.mb_count[_state] == 1

_mb_id-- will decrease to 0, * at this time *, the condition below in loop is true:
	_mb_id >= _vm->sbm.first_mb_id && _vm->sbm.mb_count[_state];

in next iteration, _mb_id-- results in _mb_id == -1UL. -1UL > _vm->sbm.first_mb_id
is true, then the condition is still true. There, we have a invalid mb_id number.

>
> Otherwise we should always stay above _vm->sbm.first_mb_id.
>
> Am I correct or am I missing something?
>
>
> But in that case we would have to have
> 	vm->sbm.first_mb_id == 0
>
> and consequently the start address of the device would have to be at
> address 0.
>
> ... but that does sound very weird, especially on x86_64?
>
> Do you have details about the device layout / position in guest physical
> address space?
Hope I've explained it clearly above :-)
>
> virtio_mem_bbm_for_each_bb_rev() would need a similar fix.
Oh yes, thanks!

Eric
>
>
>> The calltrace is like below:
>> ```
>> [  286.344977] BUG: unable to handle page fault for address: ffffa95180cf8fff
>> [  286.345800] #PF: supervisor read access in kernel mode
>> [  286.346738] #PF: error_code(0x0000) - not-present page
>> [  286.347440] PGD 1000067 P4D 1000067 PUD 138c067 PMD 1840435067 PTE 0
>> [  286.348156] Oops: 0000 [#1] SMP PTI                                                        [  286.348556] CPU: 1 PID: 122 Comm: kworker/1:2 Tainted: G           OE
>> ...
>> [  286.350740] Workqueue: events_freezable virtio_mem_run_wq [virtio_mem]
>> [  286.351605] RIP: 0010:virtio_mem_unplug_request+0x418/0x890 [virtio_mem]
>> [  286.352519] Code: 0f 87 fc 00 00 00 4a 63 54 ac 30 48 83 bc d5 f8 00 00 00 00 48 89 d0 0f 8
>> 4 e5 00 00 00 48 8b b5 38 01 00 00 4c 89 e2 48 29 ca <0f> b6 34 16 39 c6 75 c7 40 80 fe 02 0f
>> 82 a4 01 00 00 40 80 fe 03
>> [  286.355030] RSP: 0018:ffffa95181c4bd50 EFLAGS: 00010286
>> [  286.355737] RAX: 0000000000000005 RBX: 0000000000006100 RCX: 0000000000000000
>> [  286.356752] RDX: ffffffffffffffff RSI: ffffa95180cf9000 RDI: ffff8e5dc393b348
>> [  286.357649] RBP: ffff8e5dc393b200 R08: ffff8e463cd2b610 R09: 0000000000000021
>> [  286.358627] R10: ffffa95181c4bcd0 R11: ffffa95181c4baa0 R12: ffffffffffffffff
>> [  286.359617] R13: 0000000000000003 R14: ffff8e5dc393b348 R15: 00000000fffffff0
>> [  286.360503] FS:  0000000000000000(0000) GS:ffff8e463cd00000(0000) knlGS:0000000000000000
>> [  286.361532] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  286.362229] CR2: ffffa95180cf8fff CR3: 0000001846234000 CR4: 00000000000006e0
>> [  286.363168] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> [  286.364162] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> [  286.365054] Call Trace:
>> [  286.365431]  ? virtio_mem_run_wq+0x5a4/0x870 [virtio_mem]
>> [  286.366132]  ? __schedule+0x4b3/0x800
>> [  286.366547]  ? process_one_work+0x18b/0x350
>> [  286.367041]  ? worker_thread+0x4f/0x3a0
>> [  286.367675]  ? rescuer_thread+0x350/0x350
>> [  286.368234]  ? kthread+0xfa/0x130
>> [  286.368605]  ? kthread_create_worker_on_cpu+0x70/0x70
>> [  286.369155]  ? ret_from_fork+0x1f/0x30
>> ```
>>
>> Fixes by also checking its up boundary.
>>
>> Signed-off-by: Eric Ren <renzhengeek@gmail.com>
>> --
>> v2: Correct the SOB
>>      Use _vm and remove duplicated spaces
>> ---
>>   drivers/virtio/virtio_mem.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
>> index 96e5a8782769..f1ba0dadd47a 100644
>> --- a/drivers/virtio/virtio_mem.c
>> +++ b/drivers/virtio/virtio_mem.c
>> @@ -486,7 +486,9 @@ static int virtio_mem_sbm_mb_states_prepare_next_mb(struct virtio_mem *vm)
>>   
>>   #define virtio_mem_sbm_for_each_mb_rev(_vm, _mb_id, _state) \
>>   	for (_mb_id = _vm->sbm.next_mb_id - 1; \
>> -	     _mb_id >= _vm->sbm.first_mb_id && _vm->sbm.mb_count[_state]; \
>> +	     _mb_id >= _vm->sbm.first_mb_id && \
>> +	     _mb_id < _vm->sbm.next_mb_id && \
>> +	     _vm->sbm.mb_count[_state]; \
>>   	     _mb_id--) \
>>   		if (virtio_mem_sbm_get_mb_state(_vm, _mb_id) == _state)
>>   
>

