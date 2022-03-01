Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3E54C893E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 11:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234140AbiCAK3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 05:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiCAK3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 05:29:12 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DFF5BD37
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 02:28:30 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id v5-20020a17090ac90500b001bc40b548f9so1704637pjt.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 02:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OnrvTGkeFdz9SdbU5YzUcBSW1gSC4dxIsoPtl5S/0ts=;
        b=lMlykeCoeBj9pbm8Ib7uSMq9dStt/53mqUfx2z5VFG6jvOn36rzyKO/bfGleQvEiXE
         FzasQdln3ka7j+JaThLPFGyV6U/ACZts500Rvo7q6u6i20CssPsw9nnuZwPNED0r70UU
         5SK3n9+/DGKFtTmR8ghteojViVhQui3Cqzdce3A358Y6XD0PPkAOFXP9zod+bwchXybO
         YBdv506L4f553PXcFwYQ7ywQg7js5X7r/PcC4E6iId7+DfqWvRvwOzc7LFxQ/zWtRVVU
         /Dp8PKzt37KMYZUWpmtsV6CiTl2Rtryy1BoegmoOY86Al9w3GbFbtgOFWwfN85Qey9Ys
         ndtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OnrvTGkeFdz9SdbU5YzUcBSW1gSC4dxIsoPtl5S/0ts=;
        b=yLaGY3d2qp4pB94de1u7VxVallhIJ2zdTg+NxAkq0CO4/oQcp8nfWRacxQIbufSL1L
         CcYYzwGE1n42YaASHVTSNcoxZxfMRuhWsEB30JLDnOZ0Szi7hicrdPb67lRAuxvRHW3i
         YBsNEFO7mIrPbwuhR+Gs2cxEMuK1jKCRT+Q892S1wuSic9clQHlVcNWkjQH4GlkWrTZt
         PlPq89nn0rqFhSBBD2Cj1pEunmf9a79GaBKe0+kYfI1bWygPeMJVgSRYg0okwtrEN3uv
         FAGonsEZreYmMV0vPAOP0dbrKK/3mga/ofIZE6mpygjn+OS5H7dxHDRYLdPuu8i1TKZG
         rkVQ==
X-Gm-Message-State: AOAM530IrDXp+SkzkFlYAIbrFExDNR5wYlhYrS6DvAb5qCj1ehvEbLfl
        veNF3aZPqkODgazczLTHCBkWAg==
X-Google-Smtp-Source: ABdhPJyRALXKhW8s2bFsc2BXDdKE696FpYRLC0WDq+QpkTb6aaJXFusyucj3Yl8gAZuVpQGgt+Wr/A==
X-Received: by 2002:a17:902:7204:b0:14f:b325:7658 with SMTP id ba4-20020a170902720400b0014fb3257658mr24704466plb.110.1646130510135;
        Tue, 01 Mar 2022 02:28:30 -0800 (PST)
Received: from [10.76.15.169] ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id r12-20020a63a54c000000b00376047bf784sm12271772pgu.23.2022.03.01.02.28.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 02:28:29 -0800 (PST)
Subject: PING: [PATCH v2 3/3] virtio-crypto: implement RSA algorithm
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc:     "jasowang@redhat.com" <jasowang@redhat.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "helei.sig11@bytedance.com" <helei.sig11@bytedance.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        kernel test robot <lkp@intel.com>
References: <20220211084108.1254218-1-pizhenwei@bytedance.com>
 <20220211084108.1254218-4-pizhenwei@bytedance.com>
 <c9144b0d82e34566a960f210ddc32696@huawei.com>
 <8ef2f660-bd84-de70-1539-402c73795dfe@bytedance.com>
 <bc2bbc3b-8a34-2f09-41f5-60f1568a6bef@bytedance.com>
Message-ID: <0c148ada-9f32-3272-8a89-591299ab098d@bytedance.com>
Date:   Tue, 1 Mar 2022 18:25:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <bc2bbc3b-8a34-2f09-41f5-60f1568a6bef@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PING!

Hi, Lei
I also take a look at other crypto drivers qat/ccp/hisilicon, they
separate akcipher/skcipher algo. If you consider that reusing
virtio_crypto_algs_register/unregister seems better, I will try to merge
them into a single function.

On 2/23/22 6:17 PM, zhenwei pi wrote:
> 
> On 2/18/22 11:12 AM, zhenwei pi wrote:
>>>> +void virtio_crypto_akcipher_algs_unregister(struct virtio_crypto
>>>> +*vcrypto) {
>>>> +    int i = 0;
>>>> +
>>>> +    mutex_lock(&algs_lock);
>>>> +
>>>> +    for (i = 0; i < ARRAY_SIZE(virtio_crypto_akcipher_algs); i++) {
>>>> +        uint32_t service = virtio_crypto_akcipher_algs[i].service;
>>>> +        uint32_t algonum = virtio_crypto_akcipher_algs[i].algonum;
>>>> +
>>>> +        if (virtio_crypto_akcipher_algs[i].active_devs == 0 ||
>>>> +            !virtcrypto_algo_is_supported(vcrypto, service, algonum))
>>>> +            continue;
>>>> +
>>>> +        if (virtio_crypto_akcipher_algs[i].active_devs == 1)
>>>> +
>>>>     crypto_unregister_akcipher(&virtio_crypto_akcipher_algs[i].algo);
>>>> +
>>>> +        virtio_crypto_akcipher_algs[i].active_devs--;
>>>> +    }
>>>> +
>>>> +    mutex_unlock(&algs_lock);
>>>> +}
>>>
>>> Why don't you reuse the virtio_crypto_algs_register/unregister 
>>> functions?
>>> The current code is too repetitive. Maybe we don't need create the 
>>> new file virtio_crypto_akcipher_algo.c
>>> because we had virtio_crypto_algs.c which includes all algorithms.
>>>
>>
>> Yes, this looks similar to virtio_crypto_algs_register/unregister.
>>
>> Let's look at the difference:
>> struct virtio_crypto_akcipher_algo {
>>          uint32_t algonum;
>>          uint32_t service;
>>          unsigned int active_devs;
>>          struct akcipher_alg algo;
>> };
>>
>> struct virtio_crypto_algo {
>>          uint32_t algonum;
>>          uint32_t service;
>>          unsigned int active_devs;
>>          struct skcipher_alg algo; /* akcipher_alg VS skcipher_alg */
>> };
>>
>> If reusing virtio_crypto_algs_register/unregister, we need to modify 
>> the data structure like this:
>> struct virtio_crypto_akcipher_algo {
>>          uint32_t algonum;
>>          uint32_t service;    /* use service to distinguish 
>> akcipher/skcipher */
>>          unsigned int active_devs;
>>      union {
>>          struct skcipher_alg skcipher;
>>              struct akcipher_alg akcipher;
>>      } alg;
>> };
>>
>> int virtio_crypto_akcipher_algs_register(struct virtio_crypto *vcrypto)
>> {
>>      ...
>>          for (i = 0; i < ARRAY_SIZE(virtio_crypto_akcipher_algs); i++) {
>>                  uint32_t service = 
>> virtio_crypto_akcipher_algs[i].service;
>>          ...
>>          /* test service type then call 
>> crypto_register_akcipher/crypto_register_skcipher */
>>                  if (service == VIRTIO_CRYPTO_SERVICE_AKCIPHER)
>> crypto_register_akcipher(&virtio_crypto_akcipher_algs[i].algo.akcipher);
>>          else
>> crypto_register_skcipher(&virtio_crypto_skcipher_algs[i].algo.skcipher);
>>          ...
>>          }
>>      ...
>> }
>>
>> Also test service type and call 
>> crypto_unregister_skcipher/crypto_unregister_akcipher.
>>
>> This gets unclear from current v2 version.
>>
>> On the other hand, the kernel side prefers to separate skcipher and 
>> akcipher(separated header files and implementations).
>>
>

-- 
zhenwei pi
