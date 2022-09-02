Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DED55AA5F1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 04:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbiIBChp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 22:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiIBChm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 22:37:42 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D56971BDA
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 19:37:39 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id y1so586303plb.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 19:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=21tuyaqs1vXmiWanrx2wXGnQAxkSG8CXdu407GW+pl8=;
        b=zbMKRGazbm1KrHImUnWrYDGuiPfF7phVtFs4j0Z35FsT9/kORv31YVz2ufvqJWP1W1
         oHlPL/Hqp4zo21FgxkC5QtmKosdv+hWChMiqh9U27SyyFQcH/W3kozIKw5V2aEd8CFKa
         17l65BCyOF4cSZPFZLuDBkGFyF9bpIwAnajruqa6B+2eTFyNQ0kWYbSyVzM9YORi3+Xl
         cTo+rADPXgKjccyun8G6Vn2tsH0ZquUIhfhTgGP+dVviWyIeb7O+0sKMzb4WFi3hrhjf
         pGvX13lsc3OD6FcJxZTPUkXdijbAe3izTBG/uk/F85QsMSNhca99t+/Rn8LdI8TMFT53
         7wAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=21tuyaqs1vXmiWanrx2wXGnQAxkSG8CXdu407GW+pl8=;
        b=Nj2o5nku8w7rLA+Xcd+f+rQbmtqKVGnXAXbzdqlQ/u5zXguNyEbinJNMvrnWviEMX+
         QbLIE0uFMU9DOoOOs1R6XDFZwLZ/bF2HmXcOw2Z6dFgvfxYHeM6UayYmMKCfNI+QGuYu
         5GM0+XcmmB/Co/JIe6c8hfWKXFOspIxFW/HPTZrlP9eGCj3tC1apNGv6N53xQq1ESOtJ
         If4tlvUMirWH7ugdwuZALpXJZVEvZsMBbcpt/vgDebxYz/iDB8MqXQmHMBvqQ5ct0zSH
         1+5FsxR+g8Sn+h2Gz9fkaztHL1VJeO0t8b98RDLFXt9PsJXnU2DvDkVmMRhUdKV70xyv
         ylJA==
X-Gm-Message-State: ACgBeo3NmATEqqSdnIl+X2JcCqpZwRLP1PkSfeL7/ecMWgCMzbCzOt9z
        fWNIzh+Jl3XVN/RBi1DEe72DxQ==
X-Google-Smtp-Source: AA6agR70lXWiSYOehD1/HyPGkVxHRBe3KA2ak/PssCKtf4wb6t+6554LN1MuiOjM/TtyZOXFEx/U9A==
X-Received: by 2002:a17:902:c403:b0:174:3a8a:b6e3 with SMTP id k3-20020a170902c40300b001743a8ab6e3mr32022633plk.48.1662086259048;
        Thu, 01 Sep 2022 19:37:39 -0700 (PDT)
Received: from [10.76.15.169] ([61.120.150.74])
        by smtp.gmail.com with ESMTPSA id l194-20020a633ecb000000b0042fe1914e26sm252411pga.37.2022.09.01.19.37.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 19:37:38 -0700 (PDT)
Message-ID: <db63eaac-08e5-cb78-9aef-14b3c9955e8b@bytedance.com>
Date:   Fri, 2 Sep 2022 10:37:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Re: [PATCH v3 1/1] nvmet-tcp: Fix NULL pointer dereference during
 release
Content-Language: en-US
To:     Sagi Grimberg <sagi@grimberg.me>, hch@lst.de
Cc:     kch@nvidia.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220901061409.545456-1-pizhenwei@bytedance.com>
 <20220901061409.545456-2-pizhenwei@bytedance.com>
 <33269462-f989-c4ba-a9ac-846b629cd360@grimberg.me>
From:   zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <33269462-f989-c4ba-a9ac-846b629cd360@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/22 18:52, Sagi Grimberg wrote:
> 
> 
> On 9/1/22 09:14, zhenwei pi wrote:
>> nvmet-tcp frees CMD buffers in nvmet_tcp_uninit_data_in_cmds(),
>> and waits the inflight IO requests in nvmet_sq_destroy(). During wait
>> the inflight IO requests, the callback nvmet_tcp_queue_response()
>> is called from backend after IO complete, this leads a typical
>> Use-After-Free issue like this:
>>
>>   BUG: kernel NULL pointer dereference, address: 0000000000000008
>>   #PF: supervisor read access in kernel mode
>>   #PF: error_code(0x0000) - not-present page
>>   PGD 0 P4D 0
>>   Oops: 0000 [#1] PREEMPT SMP NOPTI
>>   CPU: 14 PID: 207 Comm: kworker/14:1H Kdump: loaded Tainted: 
>> G            E      6.0.0-rc2.bm.1-amd64 #12
>>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 
>> rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
>>   Workqueue: nvmet_tcp_wq nvmet_tcp_io_work [nvmet_tcp]
>>   RIP: 0010:shash_ahash_digest+0x2b/0x110
>>   Code: 1f 44 00 00 41 57 41 56 41 55 41 54 55 48 89 fd 53 48 89 f3 48 
>> 83 ec 08 44 8b 67 30 45 85 e4 74 1c 48 8b 57 38 b8 00 10 00 00 <44> 8b 
>> 7a 08 44 29 f8 39 42 0c 0f 46 42 0c 41 39 c4 76 43 48 8b 03
>>   RSP: 0018:ffffc900006e3dd8 EFLAGS: 00010206
>>   RAX: 0000000000001000 RBX: ffff888104ac1650 RCX: 0000000000000000
>>   RDX: 0000000000000000 RSI: ffff888104ac1650 RDI: ffff888104ac1600
>>   RBP: ffff888104ac1600 R08: ffff8881073980c8 R09: ffff8881057798b8
>>   R10: 8080808080808080 R11: 0000000000000000 R12: 0000000000001000
>>   R13: 0000000000000000 R14: ffff88810601a1cc R15: ffff888107398000
>>   FS:  0000000000000000(0000) GS:ffff88823fd80000(0000) 
>> knlGS:0000000000000000
>>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>   CR2: 0000000000000008 CR3: 000000010a8e8000 CR4: 0000000000350ee0
>>   Call Trace:
>>    <TASK>
>>    nvmet_tcp_io_work+0xa1c/0xb1c [nvmet_tcp]
>>    ? __switch_to+0x106/0x420
>>    process_one_work+0x1ae/0x380
>>    ? process_one_work+0x380/0x380
>>    worker_thread+0x30/0x360
>>    ? process_one_work+0x380/0x380
>>    kthread+0xe6/0x110
>>    ? kthread_complete_and_exit+0x20/0x20
>>    ret_from_fork+0x1f/0x30
>>
>> Suggested by Sagi, separate nvmet_tcp_uninit_data_in_cmds() into two
>> steps:
>>    uninit data in cmds                  <- new step 1
>>    nvmet_sq_destroy();
>>    cancel_work_sync(&queue->io_work);
>>    free CMD buffers                     <- new step 2
>>
>> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
>> ---
>>   drivers/nvme/target/tcp.c | 18 ++++++++++++++++--
>>   1 file changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
>> index a3694a32f6d5..e18eae5ef90b 100644
>> --- a/drivers/nvme/target/tcp.c
>> +++ b/drivers/nvme/target/tcp.c
>> @@ -1423,14 +1423,27 @@ static void 
>> nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
>>       for (i = 0; i < queue->nr_cmds; i++, cmd++) {
>>           if (nvmet_tcp_need_data_in(cmd))
>>               nvmet_req_uninit(&cmd->req);
>> +    }
>> +
>> +    if (!queue->nr_cmds && nvmet_tcp_need_data_in(&queue->connect)) {
>> +        /* failed in connect */
>> +        nvmet_req_uninit(&queue->connect.req);
>> +    }
>> +}
>> +static void nvmet_tcp_free_cmd_data_in_buffers(struct nvmet_tcp_queue 
>> *queue)
>> +{
>> +    struct nvmet_tcp_cmd *cmd = queue->cmds;
>> +    int i;
>> +
>> +    for (i = 0; i < queue->nr_cmds; i++, cmd++) {
> 
>          if (nvmet_tcp_need_data_in(cmd))
> 
>>           nvmet_tcp_unmap_pdu_iovec(cmd);
> 
> This function should no longer exist in the code.
> 

Hi, Sagi

Sorry, I didn't notice this patch is on the way...
https://lore.kernel.org/linux-nvme/Yw%2F0cZFCQQpx3hhZ@ZenIV/T/#t

I'll send the v4 after this patch apply. Thanks!

>>           nvmet_tcp_free_cmd_buffers(cmd);
>>       }
>>       if (!queue->nr_cmds && nvmet_tcp_need_data_in(&queue->connect)) {
>> -        /* failed in connect */
>> -        nvmet_tcp_finish_cmd(&queue->connect);
>> +        nvmet_tcp_unmap_pdu_iovec(&queue->connect);
> 
> This function should no longer exist in the code.
> 
>> +        nvmet_tcp_free_cmd_buffers(&queue->connect);
>>       }
>>   }
>> @@ -1452,6 +1465,7 @@ static void nvmet_tcp_release_queue_work(struct 
>> work_struct *w)
>>       nvmet_tcp_uninit_data_in_cmds(queue);
>>       nvmet_sq_destroy(&queue->nvme_sq);
>>       cancel_work_sync(&queue->io_work);
>> +    nvmet_tcp_free_cmd_data_in_buffers(queue);
>>       sock_release(queue->sock);
>>       nvmet_tcp_free_cmds(queue);
>>       if (queue->hdr_digest || queue->data_digest)

-- 
zhenwei pi
