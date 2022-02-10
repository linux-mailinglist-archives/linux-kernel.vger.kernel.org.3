Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3DF4B06C0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 07:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235733AbiBJG6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 01:58:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbiBJG6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 01:58:30 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B651007
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 22:58:31 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id u16so2917648pfg.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 22:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qubtFSL5pffuSE96y3KeDZ8ATTHDcApsGYblihKFKlM=;
        b=EJVUaU8FgXsLEg4U3EZPRn43bEa9gR+0klojCs/EluWwEY+HOcMpGt8mz0MLTWfDli
         qauc/PGRY033F8Tl9tbpzf+m9yWO/hW8G4GSAAiN5tbaLEyyIpGoU9fV/rM4rQ7ZZQsx
         dDewofAx3MwRkM8+5kbNA4zzIMcgaKOsgeNnwEofmay4MTy70hEmofAKysX/3wQUHa6b
         IUmexz1cnwAIYlI1mhnqzUeXVhDUT4cn/83Nys6l3ClEbfRVXJ5m5h76IVWeSSDOqf0T
         GMiE60mDEldQ0KK4Q4cZILLx5jPwXRN9TXmIhfZIYYA9GnGmzdJLnmybBl+FM4hsne0X
         4/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qubtFSL5pffuSE96y3KeDZ8ATTHDcApsGYblihKFKlM=;
        b=uVKcX9Iow5R88RE9DLriqTid5QqJfywFk5ChHblXnNZWdqx0ATMBwQTGe4ChaQ5M/k
         aHV3b/0l8AX+O5souQqV0OfomTxKH6onw6rDQA3/QlYuRGGHgt5W8A6Ycug7R7r3evur
         Zeq0dIGxt55Bmcy0IgmUJcgAPL49drwquEsvsIwfCRt7fVbrm3ZxOPN88NqI3B6OhCi6
         DAaxiDDCIELThZYYTRUZFomFikq7y/gfDQMJX3+vhqUNoiS35RBGW8DLQRGt9aRQMvUr
         GXqaa+2Tk50SymtumdH85tLeAJwH/cXm3ftgF7ZrTf55hYS12XNCjFFI0EUyvWwpPk4S
         e/Tw==
X-Gm-Message-State: AOAM530HZ67sg35vNoShuXU0L/+cp127G8LouFkZ8NITxW5CWvYeKRUT
        OF2BfCE/STFsFE5sQS1qAIQHDA==
X-Google-Smtp-Source: ABdhPJz1WhCuTVXHDD6QOhULgG9i8OXhz4OWau8w2cQgW4jcTWpQlOcKDdkF6kfkaUkIxBX/nFR0qA==
X-Received: by 2002:a63:b141:: with SMTP id g1mr5087167pgp.269.1644476311381;
        Wed, 09 Feb 2022 22:58:31 -0800 (PST)
Received: from [10.76.15.169] ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id h10sm22807072pfc.103.2022.02.09.22.58.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 22:58:30 -0800 (PST)
Subject: PING: [PATCH 0/3] Introduce akcipher service for virtio-crypto
To:     mst@redhat.com, arei.gonglei@huawei.com
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        helei.sig11@bytedance.com
References: <20220121022438.1042547-1-pizhenwei@bytedance.com>
From:   zhenwei pi <pizhenwei@bytedance.com>
Message-ID: <9d07cc9d-b3f1-6fc9-eca1-6124f7baf7e0@bytedance.com>
Date:   Thu, 10 Feb 2022 14:55:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220121022438.1042547-1-pizhenwei@bytedance.com>
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

PING!

PS: Please ignore the warning from kernel test robot, I'll fix it in 
next version.

On 1/21/22 10:24 AM, zhenwei pi wrote:
> Introduce akcipher service, implement RSA algorithm, and a minor fix.
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
>   include/uapi/linux/virtio_crypto.h            |  98 ++-
>   6 files changed, 693 insertions(+), 10 deletions(-)
>   create mode 100644 drivers/crypto/virtio/virtio_crypto_akcipher_algo.c
> 

-- 
zhenwei pi
