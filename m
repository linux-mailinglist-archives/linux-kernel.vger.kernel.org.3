Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E614C102E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 11:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236653AbiBWKUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 05:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbiBWKUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 05:20:42 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A550C8BF71
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 02:20:14 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id i21so14860656pfd.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 02:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DQX7V52CBiJ7FddDejeLAMem+iUAD4nV8smE6+HMiCk=;
        b=nN41YCVInSLt/JhZi7jK4UIpYreHneBcjM9jaq1ZZoxJ1/HvTSNw/17hZcv+kDyYd6
         +REnkeyTUgx0AmMKdy+VTVlBINeBfEKvrtvRYmlTs9AgmnLtJF9qZixJ3s5pQNss0vs6
         zVZe/dXo1+NnSdrdMA9wcfg6nXb7vGWJxV6I5T0J6PkmWpN0YNnb6zjvCoCr935RSum7
         Y2LQBdU3OuNnflCdHskASMBzdNDYIplLTdH793XbTrZvH4nak4d7jYpjPCz/3Z2V+Mar
         9jB/QwBi/DjewJnn924OyllWj+1kAstpa7J+h5ZalOgqI27LkUHizcD3M1ll6ekNuD3h
         WfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DQX7V52CBiJ7FddDejeLAMem+iUAD4nV8smE6+HMiCk=;
        b=YOZuBy1xI97QabQ4GJCWVB/aywEe1W8TrwUoLZawh/NYRtPhRss5YaICL1DTLAYS+K
         dRHdXav5Hj+vnnIEwCD3er3JCYAj7JJcW+70UivW/rss9ku0UGwvfq0xTgBktqczBKWd
         kFZeRrqY+w5cgLzch/sn/QmpkpWSM0KR5JmUUH+cIwBuFGm/sgI9IorKPt5lOop0otlN
         OzTUrKMmyCbz4VzIaN502wg5IPOL68+fJn7/w1Tg8cotCoAz1Rtl/YHFEHFSGkc/QUNr
         5mEjZq+DBbKuQwYPe/iA7dcE3Z6XYASD3zuftl5gX7AlOT4x3SNRejBIjvJeTtX/sobM
         FUuQ==
X-Gm-Message-State: AOAM532sTi3icMvUfwJ2OGiFa5VultJnQsQ43svfY0CTrBxtKVqjl0AN
        crFfFf50yrbxDbGq+gt9sh1BOg==
X-Google-Smtp-Source: ABdhPJwOzH9BvKERdYDHwMSCkR2/GlOKIJMuXG+DePst13wAFc5G8wENJdbZFppqmk3wfvsgl9oAbg==
X-Received: by 2002:a63:af4b:0:b0:373:a2a1:bf9a with SMTP id s11-20020a63af4b000000b00373a2a1bf9amr23123430pgo.369.1645611614111;
        Wed, 23 Feb 2022 02:20:14 -0800 (PST)
Received: from [10.76.15.169] ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id x64-20020a17090a6c4600b001bc6d235a0esm2496931pjj.1.2022.02.23.02.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 02:20:13 -0800 (PST)
Subject: Re: [PATCH v2 3/3] virtio-crypto: implement RSA algorithm
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
Message-ID: <bc2bbc3b-8a34-2f09-41f5-60f1568a6bef@bytedance.com>
Date:   Wed, 23 Feb 2022 18:17:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <8ef2f660-bd84-de70-1539-402c73795dfe@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/18/22 11:12 AM, zhenwei pi wrote:
>>> +void virtio_crypto_akcipher_algs_unregister(struct virtio_crypto
>>> +*vcrypto) {
>>> +    int i = 0;
>>> +
>>> +    mutex_lock(&algs_lock);
>>> +
>>> +    for (i = 0; i < ARRAY_SIZE(virtio_crypto_akcipher_algs); i++) {
>>> +        uint32_t service = virtio_crypto_akcipher_algs[i].service;
>>> +        uint32_t algonum = virtio_crypto_akcipher_algs[i].algonum;
>>> +
>>> +        if (virtio_crypto_akcipher_algs[i].active_devs == 0 ||
>>> +            !virtcrypto_algo_is_supported(vcrypto, service, algonum))
>>> +            continue;
>>> +
>>> +        if (virtio_crypto_akcipher_algs[i].active_devs == 1)
>>> +
>>>     crypto_unregister_akcipher(&virtio_crypto_akcipher_algs[i].algo);
>>> +
>>> +        virtio_crypto_akcipher_algs[i].active_devs--;
>>> +    }
>>> +
>>> +    mutex_unlock(&algs_lock);
>>> +}
>>
>> Why don't you reuse the virtio_crypto_algs_register/unregister functions?
>> The current code is too repetitive. Maybe we don't need create the new 
>> file virtio_crypto_akcipher_algo.c
>> because we had virtio_crypto_algs.c which includes all algorithms.
>>
> 
> Yes, this looks similar to virtio_crypto_algs_register/unregister.
> 
> Let's look at the difference:
> struct virtio_crypto_akcipher_algo {
>          uint32_t algonum;
>          uint32_t service;
>          unsigned int active_devs;
>          struct akcipher_alg algo;
> };
> 
> struct virtio_crypto_algo {
>          uint32_t algonum;
>          uint32_t service;
>          unsigned int active_devs;
>          struct skcipher_alg algo; /* akcipher_alg VS skcipher_alg */
> };
> 
> If reusing virtio_crypto_algs_register/unregister, we need to modify the 
> data structure like this:
> struct virtio_crypto_akcipher_algo {
>          uint32_t algonum;
>          uint32_t service;    /* use service to distinguish 
> akcipher/skcipher */
>          unsigned int active_devs;
>      union {
>          struct skcipher_alg skcipher;
>              struct akcipher_alg akcipher;
>      } alg;
> };
> 
> int virtio_crypto_akcipher_algs_register(struct virtio_crypto *vcrypto)
> {
>      ...
>          for (i = 0; i < ARRAY_SIZE(virtio_crypto_akcipher_algs); i++) {
>                  uint32_t service = virtio_crypto_akcipher_algs[i].service;
>          ...
>          /* test service type then call 
> crypto_register_akcipher/crypto_register_skcipher */
>                  if (service == VIRTIO_CRYPTO_SERVICE_AKCIPHER)
>              
> crypto_register_akcipher(&virtio_crypto_akcipher_algs[i].algo.akcipher);
>          else
>              
> crypto_register_skcipher(&virtio_crypto_skcipher_algs[i].algo.skcipher);
>          ...
>          }
>      ...
> }
> 
> Also test service type and call 
> crypto_unregister_skcipher/crypto_unregister_akcipher.
> 
> This gets unclear from current v2 version.
> 
> On the other hand, the kernel side prefers to separate skcipher and 
> akcipher(separated header files and implementations).
> 
Hi, Lei
I also take a look at other crypto drivers at qat/ccp/hisilicon, they 
separate akcipher/skcipher algo. If you consider that reusing 
virtio_crypto_algs_register/unregister seems better, I will try to merge 
them into a single function.

-- 
zhenwei pi
