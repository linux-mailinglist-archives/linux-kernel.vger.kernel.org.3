Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE33754F639
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 13:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381169AbiFQLCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 07:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382294AbiFQLCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 07:02:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C30546CAA4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 04:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655463741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ziFOWbv9by8WUWOuHr9i3fD+ni8iVbPClUxuq+yU6N4=;
        b=dfL9y/qQwPUY299SmRJW/Dd2MjnVj3J3s70jh245B57fmYty6Pts9ZmphlCQ6BjoR7fDN1
        r2WdWv2l11ZabIUwL6OW7nD/NhsFwGr6x+zrr7E6YC+XV7A6R6Ub545I6MZLgSjPHxuD1F
        ylwc7iZCzd2JJDjExUnRJgOip8fOrVY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-539-H5itbLHvM5Sv9rRN4QobhQ-1; Fri, 17 Jun 2022 07:02:20 -0400
X-MC-Unique: H5itbLHvM5Sv9rRN4QobhQ-1
Received: by mail-wm1-f69.google.com with SMTP id l3-20020a05600c1d0300b0039c7efa2526so2060716wms.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 04:02:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ziFOWbv9by8WUWOuHr9i3fD+ni8iVbPClUxuq+yU6N4=;
        b=kYZhcAy8NyM6iVgp1NsBjOPQlGendDkT32qMh+etS5HVRQ0GlEE9DKRlFOpr+S1SOs
         AZ6ktfVUvHPitmJgIHLLyfz9eXAqblKTnjMwCW5FQs9uHjNBNGeu84RfGPi6SbXsonHx
         26YA/RGhrq9szkO7itaauURT+9egKIT0zLfraGgnXOpmiYiNuW1/Nanv5rVoZIswc5h8
         CA5NlSYXkfxONHRji+Ovb1nut9E3kzASexkxWZJpkuaC+XLSyrucYOg6w+ObKFWWWnGp
         7oELQzFJ+78CuTmqkvkNwDwm6V89Xm8pzDwP/NY3zxWZki8sQqUPJtB3/qDbHmNeJHKU
         r46Q==
X-Gm-Message-State: AOAM532lsidZ/wFH1tNLdUJHy68ENgDzoHirlYuE3GtaqUcsh7xY1RO4
        l3WrQ94Bq3ZgGdmrlwNVQpdf2j0Kx8iJJZCAps+VIN/25DFAvL2Q3U8Nin9Sq0onFrNRtYaCTUG
        oYeoo/XBD51jB6xMTPeZcDqQk
X-Received: by 2002:a05:600c:1d94:b0:39c:68c0:403b with SMTP id p20-20020a05600c1d9400b0039c68c0403bmr20288843wms.125.1655463739485;
        Fri, 17 Jun 2022 04:02:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrl+Er1GbwVnF2EfagbXzpVeEsnXyeknhzxoI7syjv6S3yxm+1wOc0XP849K+/8yys6OUzvg==
X-Received: by 2002:a05:600c:1d94:b0:39c:68c0:403b with SMTP id p20-20020a05600c1d9400b0039c68c0403bmr20288821wms.125.1655463739205;
        Fri, 17 Jun 2022 04:02:19 -0700 (PDT)
Received: from redhat.com ([2.54.189.19])
        by smtp.gmail.com with ESMTPSA id f15-20020a5d568f000000b00213b93cff5fsm4121938wrv.98.2022.06.17.04.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 04:02:18 -0700 (PDT)
Date:   Fri, 17 Jun 2022 07:02:13 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Lei He <helei.sig11@bytedance.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dhowells@redhat.com, arei.gonglei@huawei.com, jasowang@redhat.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        pizhenwei@bytedance.com, f4bug@amsat.org, berrange@redhat.com
Subject: Re: [PATCH 0/4] virtio-crypto: support ECDSA algorithm
Message-ID: <20220617070201-mutt-send-email-mst@kernel.org>
References: <20220617070754.73667-1-helei.sig11@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617070754.73667-1-helei.sig11@bytedance.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 03:07:49PM +0800, Lei He wrote:
> From: lei he <helei.sig11@bytedance.com>
> 
> This patch supports the ECDSA algorithm for virtio-crypto:
> 1. fixed the problem that the max_signature_size of ECDSA is
> incorrectly calculated.
> 2. make pkcs8_private_key_parser can identify ECDSA private keys.
> 3. implement ECDSA algorithm for virtio-crypto device

virtio bits:

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> lei he (4):
>   crypto: fix the calculation of max_size for ECDSA
>   crypto: pkcs8 parser support ECDSA private keys
>   crypto: remove unused field in pkcs8_parse_context
>   virtio-crypto: support ECDSA algorithm
> 
>  crypto/Kconfig                                |   1 +
>  crypto/Makefile                               |   2 +
>  crypto/akcipher.c                             |  10 +
>  crypto/asymmetric_keys/pkcs8.asn1             |   2 +-
>  crypto/asymmetric_keys/pkcs8_parser.c         |  46 +++-
>  crypto/ecdsa.c                                |   3 +-
>  crypto/ecdsa_helper.c                         |  45 +++
>  .../virtio/virtio_crypto_akcipher_algs.c      | 259 ++++++++++++++++--
>  include/crypto/internal/ecdsa.h               |  15 +
>  include/linux/asn1_encoder.h                  |   2 +
>  lib/asn1_encoder.c                            |   3 +-
>  11 files changed, 360 insertions(+), 28 deletions(-)
>  create mode 100644 crypto/ecdsa_helper.c
>  create mode 100644 include/crypto/internal/ecdsa.h
> 
> -- 
> 2.20.1

