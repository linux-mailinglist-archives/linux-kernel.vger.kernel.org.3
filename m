Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA364B7CAC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 02:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245561AbiBPBjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 20:39:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238697AbiBPBjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 20:39:20 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF376237E2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:39:08 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id v4so1104519pjh.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4IkDugObOHw/CxlumnAa9V9g2g9OJVY9HrD6pEfE2lM=;
        b=P61cP+b5/QdSjJQm9e3zgGhGrgdXFH3lfZfyCCnrtJvrS2+7Cgg/dK89cqyX5yiXdM
         aRg6deIkdutkpSXDRfq1SNB/AVdg67oJTEfGuZzvMRJv/p9e6KRJLEXzcrjwLer7bRSl
         5Hqbc6Y4GJ7wXys6sEIq6kO2AwpaP3Ih1QhqmQi2Ibob5FqsJtnc7XS9CJrZc/tNAlgN
         jpKWExv6vcU/EcHtH4LDz+fQj1sM9wpY6DQprEJuyOb0+OgqwL842EHBvA+fLBpyfLcO
         VgwsmOlwkj6aVXkg+59IM7suM4/u86uaKECJ+K6z9bKeydZ0ploCky1eRev1yrcrzvLq
         wZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4IkDugObOHw/CxlumnAa9V9g2g9OJVY9HrD6pEfE2lM=;
        b=bWECYKNmU+tMCnSDDDGCAcLM7Qu4Po5eidXvU+Mb/GlpPZMjF1Mm9qCT+ynNvArv4Z
         I7REIuwgltDzFpW8H4eewlUi73eTqmtlpPUfU7L9bbxyFNnTXwhdiYn5p4pUU5HsDp7s
         apDCg+ky+SznzHUW1A3blwLGstspfkSiITdHpdNKNp3wZHOg4p6l4PmnEDokRDEK+Uov
         GopJRostOTEUu6/AkPI+VwZuziDuLNAkc6gh2yDCCQ6A+Z199eIJLPuUp08f0R3mrFVc
         UDAjq1Q5CNxyi4AyNGP5d3L4P0OG8fAfkVzmNcRNWF5gBG6K68b1oG6ITNOtVDRXSj0s
         Tr3Q==
X-Gm-Message-State: AOAM531eUqDyWYRhf18q2RkLJ/EeGKwk0++z/uf66wWPf8ZUVlpQL12m
        1htEgp/9lmMb1FeXPm07NB7Qhg==
X-Google-Smtp-Source: ABdhPJyVcEQPG2VDaGKPFncTObF/Wmp+3tHQlHV4luaY2AjnKJkKFGfI/nUrfIAuuNsLJkHuYb42pA==
X-Received: by 2002:a17:90b:2390:b0:1b9:c392:ab8d with SMTP id mr16-20020a17090b239000b001b9c392ab8dmr293672pjb.30.1644975548318;
        Tue, 15 Feb 2022 17:39:08 -0800 (PST)
Received: from [10.76.15.169] ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id j12sm35873328pfu.79.2022.02.15.17.39.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 17:39:07 -0800 (PST)
Subject: PING: [PATCH v2 0/3] Introduce akcipher service for virtio-crypto
To:     arei.gonglei@huawei.com
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        helei.sig11@bytedance.com, herbert@gondor.apana.org.au,
        mst@redhat.com
References: <20220211084108.1254218-1-pizhenwei@bytedance.com>
From:   zhenwei pi <pizhenwei@bytedance.com>
Message-ID: <cf1c6a2e-92a1-06f7-8f1b-be823c21ab5a@bytedance.com>
Date:   Wed, 16 Feb 2022 09:36:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220211084108.1254218-1-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Lei

Could you please review the V2 version?

On 2/11/22 4:41 PM, zhenwei pi wrote:
> v1 -> v2:
> - Fix 1 compiling warning reported by kernel test robot <lkp@intel.com>
> - Put "__le32 akcipher_algo;" instead of "__le32 reserve;" field of
>     struct virtio_crypto_config directly without size change.
> - Add padding in struct virtio_crypto_ecdsa_session_para to keep
>     64-bit alignment.
> - Remove irrelevant change by code format alignment.
> 
> - Also CC crypto gurus Herbert and linux-crypto@vger.kernel.org.
> 
> - Test with QEMU(patched by the v2 version), works fine.
> 
> v1:
> - Introduce akcipher service, implement RSA algorithm, and a minor fix.
> 
> zhenwei pi (3):
>    virtio_crypto: Introduce VIRTIO_CRYPTO_NOSPC
>    virtio-crypto: introduce akcipher service
>    virtio-crypto: implement RSA algorithm
> 
>   drivers/crypto/virtio/Makefile                |   1 +
>   .../virtio/virtio_crypto_akcipher_algo.c      | 584 ++++++++++++++++++
>   drivers/crypto/virtio/virtio_crypto_common.h  |   3 +
>   drivers/crypto/virtio/virtio_crypto_core.c    |   6 +-
>   drivers/crypto/virtio/virtio_crypto_mgr.c     |  11 +
>   include/uapi/linux/virtio_crypto.h            |  82 ++-
>   6 files changed, 685 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/crypto/virtio/virtio_crypto_akcipher_algo.c
> 

-- 
zhenwei pi
