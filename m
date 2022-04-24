Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C77450D147
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 12:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239224AbiDXKtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 06:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239170AbiDXKtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 06:49:05 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7562E687
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 03:46:00 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id h12so17101368plf.12
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 03:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SP4KfluiuXJHh2KKPumxZZlVV8JF4bhmLHZsgCuesyg=;
        b=6ozyP0IcpXqdjjAkg8EHiRfhAZbMfNkpv9jJzL9BGeFoG22CJMcJ6zoXKiZGYnhu2C
         L79mMpYrBbgyIfB6lTfJRq58guVeH4gb5Oxg9a7Xp4UCn/55ErSoWKU9M+E4ObbijwQ3
         Mwntf4N27SfCN28JN4upzCI/Zt7rH3qXbxt31MsjiAys328jl0ooocuxww020CEKkota
         iryZ/81INjhVk2s41DVz+tGawMlZP3oJGkd7soBOgHAidI952MJj9gaa0TFgczQkBHqs
         n6MGTYJoJLuEhtkYRNQE2mA6H87x2+e4hIy8KWQj0HVABzVVdjtNTD6eJgY0m3YcZiVr
         XYJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SP4KfluiuXJHh2KKPumxZZlVV8JF4bhmLHZsgCuesyg=;
        b=b2tf+AFzf+CZqxfzb5lITQzRJmvhJRXFwXxd4OkKyfgdzavE7Fq9HFYisQu8lHS0UK
         djSlYTKbwyLQZWPADBZwcQsC4dZxBrYq9wcqounhR7NA7GDYsVmmuw/e+K2sjElrgdG4
         8ZUQhhaX1t2m/xAEVMBWq7eRSxxLvaS+S/gZFXw3ri0YkVf5MobkE3lQnA/YJUq+JSkt
         rijFoeoz7ntPCs9jTqkodLJV/k8TexUSp+A/MWex2NevPlu8Jqqv3C0opvKvWIYQ6zSV
         rhY1vkE+MNpEvlzF+AKUExi+J7beD4ylPtOwlfI8czoGQSkJRyEb3YN//oQ+t5r+w+6V
         etOQ==
X-Gm-Message-State: AOAM5319+AamfRCSGSZqDI87L7yH9gcmgZ0vLrNJ8ZaMvhHxVOYRG3b1
        ysESJjRJKtLFCJKNRjh1TsVjHQ==
X-Google-Smtp-Source: ABdhPJw9iJskJAK8X9cDKl4WEqInvtbQy73L73WnZNFn41K3vl8RcwE08TtWBoVvrRLYp7KbUikXyw==
X-Received: by 2002:a17:902:b692:b0:14c:935b:2b03 with SMTP id c18-20020a170902b69200b0014c935b2b03mr12937938pls.81.1650797159217;
        Sun, 24 Apr 2022 03:45:59 -0700 (PDT)
Received: from [10.76.15.169] ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id r13-20020a635d0d000000b003aa482388dbsm6726945pgb.9.2022.04.24.03.45.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Apr 2022 03:45:58 -0700 (PDT)
Message-ID: <b4981dea-497c-7283-29a8-b4677e223272@bytedance.com>
Date:   Sun, 24 Apr 2022 18:42:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Re: Re: [PATCH v3 1/5] virtio-crypto: use private buffer for
 control request
Content-Language: en-US
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Gonglei (Arei)" <arei.gonglei@huawei.com>, mst <mst@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-crypto@vger.kernel.org, helei.sig11@bytedance.com,
        davem <davem@davemloft.net>
References: <20220421104016.453458-1-pizhenwei@bytedance.com>
 <20220421104016.453458-2-pizhenwei@bytedance.com>
 <7996f495-3bb8-fa80-7866-fa1fbff3e80a@redhat.com>
 <cbe1041e-e7e0-49bb-3164-f472823e736b@bytedance.com>
 <CACGkMEutBJpeZbO52KM6=2HPTBuGx00hVyjBuj7nu5EUHuofrQ@mail.gmail.com>
From:   zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <CACGkMEutBJpeZbO52KM6=2HPTBuGx00hVyjBuj7nu5EUHuofrQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/22 14:21, Jason Wang wrote:
> On Fri, Apr 22, 2022 at 5:12 PM zhenwei pi <pizhenwei@bytedance.com> wrote:
>>
>> On 4/22/22 15:41, Jason Wang wrote:
>>>
>>> 在 2022/4/21 18:40, zhenwei pi 写道:
>>>> Originally, all of the control requests share a single buffer(
>>>> ctrl & input & ctrl_status fields in struct virtio_crypto), this
>>>> allows queue depth 1 only, the performance of control queue gets
>>>> limited by this design.
>>>>
>>>> In this patch, each request allocates request buffer dynamically, and
>>>> free buffer after request, it's possible to optimize control queue
>>>> depth in the next step.
>>>>
>>>> A necessary comment is already in code, still describe it again:
>>>> /*
>>>>    * Note: there are padding fields in request, clear them to zero before
>>>>    * sending to host,
>>>>    * Ex, virtio_crypto_ctrl_request::ctrl::u::destroy_session::padding[48]
>>>>    */
>>>> So use kzalloc to allocate buffer of struct virtio_crypto_ctrl_request.
>>>>
>>>> Cc: Michael S. Tsirkin <mst@redhat.com>
>>>> Cc: Jason Wang <jasowang@redhat.com>
>>>> Cc: Gonglei <arei.gonglei@huawei.com>
>>>> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
>>>> ---
>>>>    drivers/crypto/virtio/Makefile                |   1 +
>>>>    .../virtio/virtio_crypto_akcipher_algs.c      |  90 ++++++------
>>>>    drivers/crypto/virtio/virtio_crypto_common.c  |  39 +++++
>>>
>>>
>>> Any reason we can't use virtio_crypto_core.c?
>>>
>> Another patch in this series: [PATCH v3 3/5] virtio-crypto: move helpers
>> into virtio_crypto_common.c
>>
>> Move virtcrypto_clear_request and virtcrypto_dataq_callback into
>> virtio_crypto_common.c to make code clear. Then the xx_core.c
>> supports:
>>     - probe/remove/irq affinity seting for a virtio device
>>     - basic virtio related operations
>>
>> xx_common.c supports:
>>     - common helpers/functions for algos
>>
>> So I put this into a new file.
> 
> I don't see obvious differences but we can leave it to the
> virtio-crypto maintainers to decide.
> 

OK!
>>
>>>
>>>>    drivers/crypto/virtio/virtio_crypto_common.h  |  19 ++-
>>>>    .../virtio/virtio_crypto_skcipher_algs.c      | 133 ++++++++----------
>>>>    5 files changed, 156 insertions(+), 126 deletions(-)
>>>>    create mode 100644 drivers/crypto/virtio/virtio_crypto_common.c
>>>>
>>>> diff --git a/drivers/crypto/virtio/Makefile
>>>> b/drivers/crypto/virtio/Makefile
>>>> index bfa6cbae342e..49c1fa80e465 100644
>>>> --- a/drivers/crypto/virtio/Makefile
>>>> +++ b/drivers/crypto/virtio/Makefile
>>>> @@ -3,5 +3,6 @@ obj-$(CONFIG_CRYPTO_DEV_VIRTIO) += virtio_crypto.o
>>>>    virtio_crypto-objs := \
>>>>        virtio_crypto_skcipher_algs.o \
>>>>        virtio_crypto_akcipher_algs.o \
>>>> +    virtio_crypto_common.o \
>>>>        virtio_crypto_mgr.o \
>>>>        virtio_crypto_core.o
>>>> diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
>>>> b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
>>>> index f3ec9420215e..9561bc2df62b 100644
>>>> --- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
>>>> +++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
>>>> @@ -102,8 +102,8 @@ static int
>>>> virtio_crypto_alg_akcipher_init_session(struct virtio_crypto_akcipher
>>>>    {
>>>>        struct scatterlist outhdr_sg, key_sg, inhdr_sg, *sgs[3];
>>>>        struct virtio_crypto *vcrypto = ctx->vcrypto;
>>>> +    struct virtio_crypto_ctrl_request *vc_ctrl_req;
>>>>        uint8_t *pkey;
>>>> -    unsigned int inlen;
>>>>        int err;
>>>>        unsigned int num_out = 0, num_in = 0;
>>>> @@ -111,98 +111,91 @@ static int
>>>> virtio_crypto_alg_akcipher_init_session(struct virtio_crypto_akcipher
>>>>        if (!pkey)
>>>>            return -ENOMEM;
>>>> -    spin_lock(&vcrypto->ctrl_lock);
>>>> -    memcpy(&vcrypto->ctrl.header, header, sizeof(vcrypto->ctrl.header));
>>>> -    memcpy(&vcrypto->ctrl.u, para, sizeof(vcrypto->ctrl.u));
>>>> -    vcrypto->input.status = cpu_to_le32(VIRTIO_CRYPTO_ERR);
>>>> +    vc_ctrl_req = kzalloc(sizeof(*vc_ctrl_req), GFP_KERNEL);
>>>> +    if (!vc_ctrl_req) {
>>>> +        err = -ENOMEM;
>>>> +        goto out;
>>>> +    }
>>>> -    sg_init_one(&outhdr_sg, &vcrypto->ctrl, sizeof(vcrypto->ctrl));
>>>> +    memcpy(&vc_ctrl_req->ctrl.header, header,
>>>> sizeof(vc_ctrl_req->ctrl.header));
>>>> +    memcpy(&vc_ctrl_req->ctrl.u, para, sizeof(vc_ctrl_req->ctrl.u));
>>>> +    sg_init_one(&outhdr_sg, &vc_ctrl_req->ctrl,
>>>> sizeof(vc_ctrl_req->ctrl));
>>>>        sgs[num_out++] = &outhdr_sg;
>>>>        sg_init_one(&key_sg, pkey, keylen);
>>>>        sgs[num_out++] = &key_sg;
>>>> -    sg_init_one(&inhdr_sg, &vcrypto->input, sizeof(vcrypto->input));
>>>> +    vc_ctrl_req->input.status = cpu_to_le32(VIRTIO_CRYPTO_ERR);
>>>
>>>
>>> Nit: if there's no special reason, let's move this after the above
>>> memcpys as what's done previously.
>>>
>>>
>>>> +    sg_init_one(&inhdr_sg, &vc_ctrl_req->input,
>>>> sizeof(vc_ctrl_req->input));
>>>>        sgs[num_out + num_in++] = &inhdr_sg;
>>>> -    err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out, num_in,
>>>> vcrypto, GFP_ATOMIC);
>>>> +    err = virtio_crypto_ctrl_vq_request(vcrypto, sgs, num_out,
>>>> num_in, vc_ctrl_req);
>>>
>>>
>>> I'd split this into a separate patch.
>>>
>>
>> OK!
>>>
>>>>        if (err < 0)
>>>>            goto out;
>>>> -    virtqueue_kick(vcrypto->ctrl_vq);
>>>> -    while (!virtqueue_get_buf(vcrypto->ctrl_vq, &inlen) &&
>>>> -           !virtqueue_is_broken(vcrypto->ctrl_vq))
>>>> -        cpu_relax();
>>>> -
>>>> -    if (le32_to_cpu(vcrypto->input.status) != VIRTIO_CRYPTO_OK) {
>>>> +    if (le32_to_cpu(vc_ctrl_req->input.status) != VIRTIO_CRYPTO_OK) {
>>>> +        pr_err("virtio_crypto: Create session failed status: %u\n",
>>>> +            le32_to_cpu(vc_ctrl_req->input.status));
>>>>            err = -EINVAL;
>>>>            goto out;
>>>>        }
>>>
>>>
>>> Do we need a warning for -ENOMEM?
>>>
>>
>> Memory(especially small size) allocation is unlikely case, I also check
>> the virtio_net and virtio_blk, both handles -ENOMEM only without error
>> reporting.
> 
> Ok.
> 
>>
>>>
>>>> -    ctx->session_id = le64_to_cpu(vcrypto->input.session_id);
>>>> +    ctx->session_id = le64_to_cpu(vc_ctrl_req->input.session_id);
>>>>        ctx->session_valid = true;
>>>>        err = 0;
>>>>    out:
>>>> -    spin_unlock(&vcrypto->ctrl_lock);
>>>> +    kfree(vc_ctrl_req);
>>>>        kfree_sensitive(pkey);
>>>> -    if (err < 0)
>>>> -        pr_err("virtio_crypto: Create session failed status: %u\n",
>>>> -            le32_to_cpu(vcrypto->input.status));
>>>> -
>>>>        return err;
>>>>    }
>>>>    static int virtio_crypto_alg_akcipher_close_session(struct
>>>> virtio_crypto_akcipher_ctx *ctx)
>>>>    {
>>>>        struct scatterlist outhdr_sg, inhdr_sg, *sgs[2];
>>>> +    struct virtio_crypto_ctrl_request *vc_ctrl_req;
>>>>        struct virtio_crypto_destroy_session_req *destroy_session;
>>>>        struct virtio_crypto *vcrypto = ctx->vcrypto;
>>>> -    unsigned int num_out = 0, num_in = 0, inlen;
>>>> +    unsigned int num_out = 0, num_in = 0;
>>>>        int err;
>>>> -    spin_lock(&vcrypto->ctrl_lock);
>>>> -    if (!ctx->session_valid) {
>>>> -        err = 0;
>>>> -        goto out;
>>>> -    }
>>>> -    vcrypto->ctrl_status.status = VIRTIO_CRYPTO_ERR;
>>>> -    vcrypto->ctrl.header.opcode =
>>>> cpu_to_le32(VIRTIO_CRYPTO_AKCIPHER_DESTROY_SESSION);
>>>> -    vcrypto->ctrl.header.queue_id = 0;
>>>> +    if (!ctx->session_valid)
>>>> +        return 0;
>>>> -    destroy_session = &vcrypto->ctrl.u.destroy_session;
>>>> +    vc_ctrl_req = kzalloc(sizeof(*vc_ctrl_req), GFP_KERNEL);
>>>> +    if (!vc_ctrl_req)
>>>> +        return -ENOMEM;
>>>> +
>>>> +    vc_ctrl_req->ctrl.header.opcode =
>>>> cpu_to_le32(VIRTIO_CRYPTO_AKCIPHER_DESTROY_SESSION);
>>>> +    vc_ctrl_req->ctrl.header.queue_id = 0;
>>>> +
>>>> +    destroy_session = &vc_ctrl_req->ctrl.u.destroy_session;
>>>>        destroy_session->session_id = cpu_to_le64(ctx->session_id);
>>>> -    sg_init_one(&outhdr_sg, &vcrypto->ctrl, sizeof(vcrypto->ctrl));
>>>> +    sg_init_one(&outhdr_sg, &vc_ctrl_req->ctrl,
>>>> sizeof(vc_ctrl_req->ctrl));
>>>>        sgs[num_out++] = &outhdr_sg;
>>>> -    sg_init_one(&inhdr_sg, &vcrypto->ctrl_status.status,
>>>> sizeof(vcrypto->ctrl_status.status));
>>>> +    vc_ctrl_req->ctrl_status.status = VIRTIO_CRYPTO_ERR;
>>>
>>>
>>> If no special reason, let's move this above:
>>>
>>> vc_ctrl_req->ctrl.header.opcode =
>>> cpu_to_le32(VIRTIO_CRYPTO_AKCIPHER_DESTROY_SESSION);
>>>
>>
>> OK!
>>>
>>>> +    sg_init_one(&inhdr_sg, &vc_ctrl_req->ctrl_status.status,
>>>> +        sizeof(vc_ctrl_req->ctrl_status.status));
>>>>        sgs[num_out + num_in++] = &inhdr_sg;
>>>> -    err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out, num_in,
>>>> vcrypto, GFP_ATOMIC);
>>>> +    err = virtio_crypto_ctrl_vq_request(vcrypto, sgs, num_out,
>>>> num_in, vc_ctrl_req);
>>>>        if (err < 0)
>>>>            goto out;
>>>> -    virtqueue_kick(vcrypto->ctrl_vq);
>>>> -    while (!virtqueue_get_buf(vcrypto->ctrl_vq, &inlen) &&
>>>> -           !virtqueue_is_broken(vcrypto->ctrl_vq))
>>>> -        cpu_relax();
>>>> -
>>>> -    if (vcrypto->ctrl_status.status != VIRTIO_CRYPTO_OK) {
>>>> +    if (vc_ctrl_req->ctrl_status.status != VIRTIO_CRYPTO_OK) {
>>>>            err = -EINVAL;
>>>> +        pr_err("virtio_crypto: Close session failed status: %u,
>>>> session_id: 0x%llx\n",
>>>> +            vc_ctrl_req->ctrl_status.status,
>>>> destroy_session->session_id);
>>>>            goto out;
>>>>        }
>>>>        err = 0;
>>>>        ctx->session_valid = false;
>>>> -
>>>>    out:
>>>> -    spin_unlock(&vcrypto->ctrl_lock);
>>>> -    if (err < 0) {
>>>> -        pr_err("virtio_crypto: Close session failed status: %u,
>>>> session_id: 0x%llx\n",
>>>> -            vcrypto->ctrl_status.status, destroy_session->session_id);
>>>> -    }
>>>> +    kfree(vc_ctrl_req);
>>>>        return err;
>>>>    }
>>>> @@ -210,14 +203,11 @@ static int
>>>> virtio_crypto_alg_akcipher_close_session(struct virtio_crypto_akciphe
>>>>    static int __virtio_crypto_akcipher_do_req(struct
>>>> virtio_crypto_akcipher_request *vc_akcipher_req,
>>>>            struct akcipher_request *req, struct data_queue *data_vq)
>>>>    {
>>>> -    struct virtio_crypto_akcipher_ctx *ctx =
>>>> vc_akcipher_req->akcipher_ctx;
>>>>        struct virtio_crypto_request *vc_req = &vc_akcipher_req->base;
>>>> -    struct virtio_crypto *vcrypto = ctx->vcrypto;
>>>>        struct virtio_crypto_op_data_req *req_data = vc_req->req_data;
>>>>        struct scatterlist *sgs[4], outhdr_sg, inhdr_sg, srcdata_sg,
>>>> dstdata_sg;
>>>>        void *src_buf = NULL, *dst_buf = NULL;
>>>>        unsigned int num_out = 0, num_in = 0;
>>>> -    int node = dev_to_node(&vcrypto->vdev->dev);
>>>>        unsigned long flags;
>>>>        int ret = -ENOMEM;
>>>>        bool verify = vc_akcipher_req->opcode ==
>>>> VIRTIO_CRYPTO_AKCIPHER_VERIFY;
>>>> @@ -228,7 +218,7 @@ static int __virtio_crypto_akcipher_do_req(struct
>>>> virtio_crypto_akcipher_request
>>>>        sgs[num_out++] = &outhdr_sg;
>>>>        /* src data */
>>>> -    src_buf = kcalloc_node(src_len, 1, GFP_KERNEL, node);
>>>> +    src_buf = kcalloc(src_len, 1, GFP_KERNEL);
>>>
>>>
>>> This seems not a relevant change. If it is a must we need use a separate
>>> for this and describe the rationale.
>>>
>>>
>>>>        if (!src_buf)
>>>>            goto err;
>>>> @@ -243,7 +233,7 @@ static int __virtio_crypto_akcipher_do_req(struct
>>>> virtio_crypto_akcipher_request
>>>>            sgs[num_out++] = &srcdata_sg;
>>>>            /* dst data */
>>>> -        dst_buf = kcalloc_node(req->dst_len, 1, GFP_KERNEL, node);
>>>> +        dst_buf = kcalloc(req->dst_len, 1, GFP_KERNEL);
>>>
>>>
>>> And this.
>>>
>>>
>>>>            if (!dst_buf)
>>>>                goto err;
>>>> diff --git a/drivers/crypto/virtio/virtio_crypto_common.c
>>>> b/drivers/crypto/virtio/virtio_crypto_common.c
>>>> new file mode 100644
>>>> index 000000000000..e65125a74db2
>>>> --- /dev/null
>>>> +++ b/drivers/crypto/virtio/virtio_crypto_common.c
>>>> @@ -0,0 +1,39 @@
>>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>>> +/* Common functions and helpers
>>>> + *
>>>> + * Authors: zhenwei pi <pizhenwei@bytedance.com>
>>>> + *
>>>> + * Copyright 2022 Bytedance CO., LTD.
>>>> + */
>>>> +
>>>> +#include "virtio_crypto_common.h"
>>>> +
>>>> +int virtio_crypto_ctrl_vq_request(struct virtio_crypto *vcrypto,
>>>> struct scatterlist *sgs[],
>>>> +                  unsigned int out_sgs, unsigned int in_sgs,
>>>> +                  struct virtio_crypto_ctrl_request *vc_ctrl_req)
>>>> +{
>>>> +    int err;
>>>> +    unsigned int inlen;
>>>> +    unsigned long flags;
>>>> +
>>>> +    spin_lock_irqsave(&vcrypto->ctrl_lock, flags);
>>>> +    err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, out_sgs, in_sgs,
>>>> vc_ctrl_req, GFP_ATOMIC);
>>>> +    if (err < 0) {
>>>> +        spin_unlock_irqrestore(&vcrypto->ctrl_lock, flags);
>>>> +        return err;
>>>> +    }
>>>> +
>>>> +    virtqueue_kick(vcrypto->ctrl_vq);
>>>> +
>>>> +    /*
>>>> +     * Trapping into the hypervisor, so the request should be
>>>> +     * handled immediately.
>>>> +     */
>>>> +    while (!virtqueue_get_buf(vcrypto->ctrl_vq, &inlen) &&
>>>> +        !virtqueue_is_broken(vcrypto->ctrl_vq))
>>>> +        cpu_relax();
>>>> +
>>>> +    spin_unlock_irqrestore(&vcrypto->ctrl_lock, flags);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> diff --git a/drivers/crypto/virtio/virtio_crypto_common.h
>>>> b/drivers/crypto/virtio/virtio_crypto_common.h
>>>> index e693d4ee83a6..d2a20fe6e13e 100644
>>>> --- a/drivers/crypto/virtio/virtio_crypto_common.h
>>>> +++ b/drivers/crypto/virtio/virtio_crypto_common.h
>>>> @@ -13,6 +13,7 @@
>>>>    #include <crypto/aead.h>
>>>>    #include <crypto/aes.h>
>>>>    #include <crypto/engine.h>
>>>> +#include <uapi/linux/virtio_crypto.h>
>>>>    /* Internal representation of a data virtqueue */
>>>> @@ -65,11 +66,6 @@ struct virtio_crypto {
>>>>        /* Maximum size of per request */
>>>>        u64 max_size;
>>>> -    /* Control VQ buffers: protected by the ctrl_lock */
>>>> -    struct virtio_crypto_op_ctrl_req ctrl;
>>>> -    struct virtio_crypto_session_input input;
>>>> -    struct virtio_crypto_inhdr ctrl_status;
>>>> -
>>>>        unsigned long status;
>>>>        atomic_t ref_count;
>>>>        struct list_head list;
>>>> @@ -85,6 +81,16 @@ struct virtio_crypto_sym_session_info {
>>>>        __u64 session_id;
>>>>    };
>>>> +/*
>>>> + * Note: there are padding fields in request, clear them to zero
>>>> before sending to host,
>>>> + * Ex, virtio_crypto_ctrl_request::ctrl::u::destroy_session::padding[48]
>>>> + */
>>>> +struct virtio_crypto_ctrl_request {
>>>> +    struct virtio_crypto_op_ctrl_req ctrl;
>>>> +    struct virtio_crypto_session_input input;
>>>> +    struct virtio_crypto_inhdr ctrl_status;
>>>> +};
>>>> +
>>>>    struct virtio_crypto_request;
>>>>    typedef void (*virtio_crypto_data_callback)
>>>>            (struct virtio_crypto_request *vc_req, int len);
>>>> @@ -135,4 +141,7 @@ void virtio_crypto_skcipher_algs_unregister(struct
>>>> virtio_crypto *vcrypto);
>>>>    int virtio_crypto_akcipher_algs_register(struct virtio_crypto
>>>> *vcrypto);
>>>>    void virtio_crypto_akcipher_algs_unregister(struct virtio_crypto
>>>> *vcrypto);
>>>> +int virtio_crypto_ctrl_vq_request(struct virtio_crypto *vcrypto,
>>>> struct scatterlist *sgs[],
>>>> +                  unsigned int out_sgs, unsigned int in_sgs,
>>>> +                  struct virtio_crypto_ctrl_request *vc_ctrl_req);
>>>>    #endif /* _VIRTIO_CRYPTO_COMMON_H */
>>>> diff --git a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
>>>> b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
>>>> index a618c46a52b8..fef355ff461c 100644
>>>> --- a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
>>>> +++ b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
>>>> @@ -118,11 +118,13 @@ static int virtio_crypto_alg_skcipher_init_session(
>>>>            int encrypt)
>>>>    {
>>>>        struct scatterlist outhdr, key_sg, inhdr, *sgs[3];
>>>> -    unsigned int tmp;
>>>>        struct virtio_crypto *vcrypto = ctx->vcrypto;
>>>
>>>
>>> Can we simply rename this to virtcrypto and then we can use the name
>>> "vcrypto" for virtio_crypto_ctrl_request then we save tons lot changes?
>>>
>>> It simplify the life of reviewers and backporting.
>>>
>>> Thanks
>>>
>>
>> This series focuses on performance improvment, and keeps the style with
>> the orignal style. What about fixing this in another series? (If so,
>> I'll fix this later)
> 
> Just in case we are at the same page, what I suggest can save hundreds
> lines of codes:
> 
> E.g:
> 
>>>> -    vcrypto->ctrl.header.queue_id = 0;
>>>> +    header->queue_id = 0;
> 
> If we stick to the name of "vcrypto" we don't need this change at all.
> 
> It can simplify:
> 
> 1) future context difference when backporting patches to -stable
> 2) reviewing
> 
> Thanks
> 

Oh, sorry, I misunderstood this. I agree with this point, but I notice 
that 'vcrypto' is always a variable of 'type struct virtio_crypto *' in 
this driver, should we break this?

To simplify reviewing, I have another opinion in the v4 series, could 
you please review it?

>>>
>>>>        int op = encrypt ? VIRTIO_CRYPTO_OP_ENCRYPT :
>>>> VIRTIO_CRYPTO_OP_DECRYPT;
>>>>        int err;
>>>>        unsigned int num_out = 0, num_in = 0;
>>>> +    struct virtio_crypto_ctrl_request *vc_ctrl_req;
>>>> +    struct virtio_crypto_ctrl_header *header;
>>>> +    struct virtio_crypto_sym_create_session_req *sym_create_session;
>>>>        /*
>>>>         * Avoid to do DMA from the stack, switch to using
>>>> @@ -133,26 +135,27 @@ static int virtio_crypto_alg_skcipher_init_session(
>>>>        if (!cipher_key)
>>>>            return -ENOMEM;
>>>> -    spin_lock(&vcrypto->ctrl_lock);
>>>> +    vc_ctrl_req = kzalloc(sizeof(*vc_ctrl_req), GFP_KERNEL);
>>>> +    if (!vc_ctrl_req) {
>>>> +        err = -ENOMEM;
>>>> +        goto out;
>>>> +    }
>>>> +
>>>>        /* Pad ctrl header */
>>>> -    vcrypto->ctrl.header.opcode =
>>>> -        cpu_to_le32(VIRTIO_CRYPTO_CIPHER_CREATE_SESSION);
>>>> -    vcrypto->ctrl.header.algo = cpu_to_le32(alg);
>>>> +    header = &vc_ctrl_req->ctrl.header;
>>>> +    header->opcode = cpu_to_le32(VIRTIO_CRYPTO_CIPHER_CREATE_SESSION);
>>>> +    header->algo = cpu_to_le32(alg);
>>>>        /* Set the default dataqueue id to 0 */
>>>> -    vcrypto->ctrl.header.queue_id = 0;
>>>> +    header->queue_id = 0;
>>>> -    vcrypto->input.status = cpu_to_le32(VIRTIO_CRYPTO_ERR);
>>>>        /* Pad cipher's parameters */
>>>> -    vcrypto->ctrl.u.sym_create_session.op_type =
>>>> -        cpu_to_le32(VIRTIO_CRYPTO_SYM_OP_CIPHER);
>>>> -    vcrypto->ctrl.u.sym_create_session.u.cipher.para.algo =
>>>> -        vcrypto->ctrl.header.algo;
>>>> -    vcrypto->ctrl.u.sym_create_session.u.cipher.para.keylen =
>>>> -        cpu_to_le32(keylen);
>>>> -    vcrypto->ctrl.u.sym_create_session.u.cipher.para.op =
>>>> -        cpu_to_le32(op);
>>>> -
>>>> -    sg_init_one(&outhdr, &vcrypto->ctrl, sizeof(vcrypto->ctrl));
>>>> +    sym_create_session = &vc_ctrl_req->ctrl.u.sym_create_session;
>>>> +    sym_create_session->op_type =
>>>> cpu_to_le32(VIRTIO_CRYPTO_SYM_OP_CIPHER);
>>>> +    sym_create_session->u.cipher.para.algo = header->algo;
>>>> +    sym_create_session->u.cipher.para.keylen = cpu_to_le32(keylen);
>>>> +    sym_create_session->u.cipher.para.op = cpu_to_le32(op);
>>>> +
>>>> +    sg_init_one(&outhdr, &vc_ctrl_req->ctrl, sizeof(vc_ctrl_req->ctrl));
>>>>        sgs[num_out++] = &outhdr;
>>>>        /* Set key */
>>>> @@ -160,45 +163,34 @@ static int virtio_crypto_alg_skcipher_init_session(
>>>>        sgs[num_out++] = &key_sg;
>>>>        /* Return status and session id back */
>>>> -    sg_init_one(&inhdr, &vcrypto->input, sizeof(vcrypto->input));
>>>> +    vc_ctrl_req->input.status = cpu_to_le32(VIRTIO_CRYPTO_ERR);
>>>> +    sg_init_one(&inhdr, &vc_ctrl_req->input,
>>>> sizeof(vc_ctrl_req->input));
>>>>        sgs[num_out + num_in++] = &inhdr;
>>>> -    err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out,
>>>> -                num_in, vcrypto, GFP_ATOMIC);
>>>> -    if (err < 0) {
>>>> -        spin_unlock(&vcrypto->ctrl_lock);
>>>> -        kfree_sensitive(cipher_key);
>>>> -        return err;
>>>> -    }
>>>> -    virtqueue_kick(vcrypto->ctrl_vq);
>>>> -
>>>> -    /*
>>>> -     * Trapping into the hypervisor, so the request should be
>>>> -     * handled immediately.
>>>> -     */
>>>> -    while (!virtqueue_get_buf(vcrypto->ctrl_vq, &tmp) &&
>>>> -           !virtqueue_is_broken(vcrypto->ctrl_vq))
>>>> -        cpu_relax();
>>>> +    err = virtio_crypto_ctrl_vq_request(vcrypto, sgs, num_out,
>>>> num_in, vc_ctrl_req);
>>>> +    if (err < 0)
>>>> +        goto out;
>>>> -    if (le32_to_cpu(vcrypto->input.status) != VIRTIO_CRYPTO_OK) {
>>>> -        spin_unlock(&vcrypto->ctrl_lock);
>>>> +    if (le32_to_cpu(vc_ctrl_req->input.status) != VIRTIO_CRYPTO_OK) {
>>>>            pr_err("virtio_crypto: Create session failed status: %u\n",
>>>> -            le32_to_cpu(vcrypto->input.status));
>>>> -        kfree_sensitive(cipher_key);
>>>> -        return -EINVAL;
>>>> +            le32_to_cpu(vc_ctrl_req->input.status));
>>>> +        err = -EINVAL;
>>>> +        goto out;
>>>>        }
>>>>        if (encrypt)
>>>>            ctx->enc_sess_info.session_id =
>>>> -            le64_to_cpu(vcrypto->input.session_id);
>>>> +            le64_to_cpu(vc_ctrl_req->input.session_id);
>>>>        else
>>>>            ctx->dec_sess_info.session_id =
>>>> -            le64_to_cpu(vcrypto->input.session_id);
>>>> -
>>>> -    spin_unlock(&vcrypto->ctrl_lock);
>>>> +            le64_to_cpu(vc_ctrl_req->input.session_id);
>>>> +    err = 0;
>>>> +out:
>>>> +    kfree(vc_ctrl_req);
>>>>        kfree_sensitive(cipher_key);
>>>> -    return 0;
>>>> +
>>>> +    return err;
>>>>    }
>>>>    static int virtio_crypto_alg_skcipher_close_session(
>>>> @@ -206,21 +198,24 @@ static int
>>>> virtio_crypto_alg_skcipher_close_session(
>>>>            int encrypt)
>>>>    {
>>>>        struct scatterlist outhdr, status_sg, *sgs[2];
>>>> -    unsigned int tmp;
>>>>        struct virtio_crypto_destroy_session_req *destroy_session;
>>>>        struct virtio_crypto *vcrypto = ctx->vcrypto;
>>>>        int err;
>>>>        unsigned int num_out = 0, num_in = 0;
>>>> +    struct virtio_crypto_ctrl_request *vc_ctrl_req;
>>>> +    struct virtio_crypto_ctrl_header *header;
>>>> +
>>>> +    vc_ctrl_req = kzalloc(sizeof(*vc_ctrl_req), GFP_KERNEL);
>>>> +    if (!vc_ctrl_req)
>>>> +        return -ENOMEM;
>>>> -    spin_lock(&vcrypto->ctrl_lock);
>>>> -    vcrypto->ctrl_status.status = VIRTIO_CRYPTO_ERR;
>>>>        /* Pad ctrl header */
>>>> -    vcrypto->ctrl.header.opcode =
>>>> -        cpu_to_le32(VIRTIO_CRYPTO_CIPHER_DESTROY_SESSION);
>>>> +    header = &vc_ctrl_req->ctrl.header;
>>>> +    header->opcode = cpu_to_le32(VIRTIO_CRYPTO_CIPHER_DESTROY_SESSION);
>>>>        /* Set the default virtqueue id to 0 */
>>>> -    vcrypto->ctrl.header.queue_id = 0;
>>>> +    header->queue_id = 0;
>>>> -    destroy_session = &vcrypto->ctrl.u.destroy_session;
>>>> +    destroy_session = &vc_ctrl_req->ctrl.u.destroy_session;
>>>>        if (encrypt)
>>>>            destroy_session->session_id =
>>>> @@ -229,37 +224,33 @@ static int
>>>> virtio_crypto_alg_skcipher_close_session(
>>>>            destroy_session->session_id =
>>>>                cpu_to_le64(ctx->dec_sess_info.session_id);
>>>> -    sg_init_one(&outhdr, &vcrypto->ctrl, sizeof(vcrypto->ctrl));
>>>> +    sg_init_one(&outhdr, &vc_ctrl_req->ctrl, sizeof(vc_ctrl_req->ctrl));
>>>>        sgs[num_out++] = &outhdr;
>>>>        /* Return status and session id back */
>>>> -    sg_init_one(&status_sg, &vcrypto->ctrl_status.status,
>>>> -        sizeof(vcrypto->ctrl_status.status));
>>>> +    vc_ctrl_req->ctrl_status.status = VIRTIO_CRYPTO_ERR;
>>>> +    sg_init_one(&status_sg, &vc_ctrl_req->ctrl_status.status,
>>>> +        sizeof(vc_ctrl_req->ctrl_status.status));
>>>>        sgs[num_out + num_in++] = &status_sg;
>>>> -    err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out,
>>>> -            num_in, vcrypto, GFP_ATOMIC);
>>>> -    if (err < 0) {
>>>> -        spin_unlock(&vcrypto->ctrl_lock);
>>>> -        return err;
>>>> -    }
>>>> -    virtqueue_kick(vcrypto->ctrl_vq);
>>>> -
>>>> -    while (!virtqueue_get_buf(vcrypto->ctrl_vq, &tmp) &&
>>>> -           !virtqueue_is_broken(vcrypto->ctrl_vq))
>>>> -        cpu_relax();
>>>> +    err = virtio_crypto_ctrl_vq_request(vcrypto, sgs, num_out,
>>>> num_in, vc_ctrl_req);
>>>> +    if (err < 0)
>>>> +        goto out;
>>>> -    if (vcrypto->ctrl_status.status != VIRTIO_CRYPTO_OK) {
>>>> -        spin_unlock(&vcrypto->ctrl_lock);
>>>> +    if (vc_ctrl_req->ctrl_status.status != VIRTIO_CRYPTO_OK) {
>>>>            pr_err("virtio_crypto: Close session failed status: %u,
>>>> session_id: 0x%llx\n",
>>>> -            vcrypto->ctrl_status.status,
>>>> +            vc_ctrl_req->ctrl_status.status,
>>>>                destroy_session->session_id);
>>>> -        return -EINVAL;
>>>> +        err = -EINVAL;
>>>> +        goto out;
>>>>        }
>>>> -    spin_unlock(&vcrypto->ctrl_lock);
>>>> -    return 0;
>>>> +    err = 0;
>>>> +out:
>>>> +    kfree(vc_ctrl_req);
>>>> +
>>>> +    return err;
>>>>    }
>>>>    static int virtio_crypto_alg_skcipher_init_sessions(
>>>
>>
>> --
>> zhenwei pi
>>
> 

-- 
zhenwei pi
