Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB5351B607
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 04:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239739AbiEECmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 22:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239426AbiEECmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 22:42:49 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD844926A
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 19:39:11 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id n18so3152846plg.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 19:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=aEOiwyG+eTh6W3KHKpg7shbqlJQ76/KhFzFg57zL5/0=;
        b=SxFvslkZn6Q7OGlLS0jfiCTQI0xExlJuAPCV/QgaRH9jHQ3UvOSGxz4PqWTvGgBoOj
         gBffuL3wuhZtQhDfJigr7X7r7hQ7pNB++kVGMw+ILNK+ZJOd/AkCeDcxTSmZg47MtDoD
         z80FE3h2Xcbh2AjufRmu/kpVcavdLzpyMOpSRw6Xj1hH6rfCCnRe0xK7XDskvZdjifBr
         2INqvNc4tChqAjFbu7htLf9yRlSjmfKGuHKu0S1g273gLnpPseYMXEplQsMUT3NjD+fr
         CGrdIGglM3GN0s8WNVIib+e6y9hsThmkkioTe5fxw/nghkpclZz6l0mWXwD+MKQlmaVj
         Ui8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aEOiwyG+eTh6W3KHKpg7shbqlJQ76/KhFzFg57zL5/0=;
        b=XczxPu6EnBScePe/1lBbFoNrfzjMgU7k2HEip8+NwsP/zdPppAKDpxjmL1IDdO5mfl
         bAXuDlh0KZUjjcV6ZTdxFEo7t2909zT+Mq0sS3xn6jEbAP2Uiogcw5iQhwhSbY6R3zQh
         pmWhu45Pem/XVRYUAgpdZa8i+j9oTHlpzUr+4ON6mdp4qiKouO7azPesA0vjAmNuVA73
         nsNBQmJsJs6njV4eHkPYkliaJakKbhZEKyUvLcVVJcNITVrhi+UiZpZZROffaiceY3Hn
         sI5ZFE4dhYGPdWsjGkWkpyYn5lt0jkxuh6FRWchvTHO0e5mw1w2gH/wr/y3AQ6ggHO3U
         TnnQ==
X-Gm-Message-State: AOAM530dhSu0QjAB9mpmfTj54Ffn8SNM4IMa0KV+Q6h5TRJtXteOCqyd
        wXFIxHFM1TJbdDemW+HcE+eFiA==
X-Google-Smtp-Source: ABdhPJxJbVfMb0WtsafX9eaZn5+JI7p1n0mchGmJpTKtQMX5xjsduPiS9ugOP+49TDJNvmYc0nwoQw==
X-Received: by 2002:a17:90b:3903:b0:1dc:8fe0:df4d with SMTP id ob3-20020a17090b390300b001dc8fe0df4dmr3327533pjb.191.1651718350808;
        Wed, 04 May 2022 19:39:10 -0700 (PDT)
Received: from [10.255.89.252] ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id n1-20020a170902e54100b0015e8d4eb252sm203223plf.156.2022.05.04.19.39.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 19:39:10 -0700 (PDT)
Message-ID: <cc9eb4aa-2e40-490f-f5a0-beee3a57313b@bytedance.com>
Date:   Thu, 5 May 2022 10:35:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: PING: [PATCH v4 0/5] virtio-crypto: Improve performance
Content-Language: en-US
To:     arei.gonglei@huawei.com, mst@redhat.com, jasowang@redhat.com
Cc:     herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, helei.sig11@bytedance.com,
        davem@davemloft.net
References: <20220424104140.44841-1-pizhenwei@bytedance.com>
From:   zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <20220424104140.44841-1-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Lei

Jason replied in another patch:
Still hundreds of lines of changes, I'd leave this change to other
maintainers to decide.

Quite frankly, the virtio crypto driver changed only a few in the past, 
and the performance of control queue is not good enough. I am in doubt 
about that this driver is not used widely. So I'd like to rework a lot, 
it would be best to complete this work in 5.18 window.

This gets different point with Jason. I would appreciate it if you could 
give me any hint.

On 4/24/22 18:41, zhenwei pi wrote:
> Hi, Lei
> I'd like to move helper and callback functions(Eg, virtcrypto_clear_request
>   and virtcrypto_ctrlq_callback) from xx_core.c to xx_common.c,
> then the xx_core.c supports:
>    - probe/remove/irq affinity seting for a virtio device
>    - basic virtio related operations
> 
> xx_common.c supports:
>    - common helpers/functions for algos
> 
> Do you have any suggestion about this?
> 
> v3 -> v4:
>   - Don't create new file virtio_common.c, the new functions are added
>     into virtio_crypto_core.c
>   - Split the first patch into two parts:
>       1, change code style,
>       2, use private buffer instead of shared buffer
>   - Remove relevant change.
>   - Other minor changes.
> 
> v2 -> v3:
>   - Jason suggested that spliting the first patch into two part:
>       1, using private buffer
>       2, remove the busy polling
>     Rework as Jason's suggestion, this makes the smaller change in
>     each one and clear.
> 
> v1 -> v2:
>   - Use kfree instead of kfree_sensitive for insensitive buffer.
>   - Several coding style fix.
>   - Use memory from current node, instead of memory close to device
>   - Add more message in commit, also explain why removing per-device
>     request buffer.
>   - Add necessary comment in code to explain why using kzalloc to
>     allocate struct virtio_crypto_ctrl_request.
> 
> v1:
> The main point of this series is to improve the performance for
> virtio crypto:
> - Use wait mechanism instead of busy polling for ctrl queue, this
>    reduces CPU and lock racing, it's possiable to create/destroy session
>    parallelly, QPS increases from ~40K/s to ~200K/s.
> - Enable retry on crypto engine to improve performance for data queue,
>    this allows the larger depth instead of 1.
> - Fix dst data length in akcipher service.
> - Other style fix.
> 
> lei he (2):
>    virtio-crypto: adjust dst_len at ops callback
>    virtio-crypto: enable retry for virtio-crypto-dev
> 
> zhenwei pi (3):
>    virtio-crypto: change code style
>    virtio-crypto: use private buffer for control request
>    virtio-crypto: wait ctrl queue instead of busy polling
> 
>   .../virtio/virtio_crypto_akcipher_algs.c      |  83 ++++++-----
>   drivers/crypto/virtio/virtio_crypto_common.h  |  21 ++-
>   drivers/crypto/virtio/virtio_crypto_core.c    |  55 ++++++-
>   .../virtio/virtio_crypto_skcipher_algs.c      | 140 ++++++++----------
>   4 files changed, 180 insertions(+), 119 deletions(-)
> 

-- 
zhenwei pi
