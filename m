Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBD95593BE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 08:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbiFXGvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 02:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiFXGvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 02:51:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD78767E58
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 23:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656053499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bUnwlqgL9iprRVri7wCkAEBYhV184LNmNjS9YgkzioI=;
        b=f0HJGSMFUrWlfgjknpUmQC6AKxgJ1yE60WhZnMoQkXUkzxbIOWoMaMNYNTg2uZFctEfksk
        fmYE/2lt0TUT/sZH57FubN6CBbDg+iDaTBGxqg2J/N6Mt3dgPgpZDjtCsY+zTk2XGJk71a
        Kw6IQTHtTTen6MHnZfo9LZAOONV0G0c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-3-HmPO0C2EP1mb2fK4bUAW_g-1; Fri, 24 Jun 2022 02:51:29 -0400
X-MC-Unique: HmPO0C2EP1mb2fK4bUAW_g-1
Received: by mail-wm1-f69.google.com with SMTP id v184-20020a1cacc1000000b0039c7efa3e95so633149wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 23:51:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bUnwlqgL9iprRVri7wCkAEBYhV184LNmNjS9YgkzioI=;
        b=WfvSYo/oIk/4dL9EcT/dVeNoTl2td69BiLw8fROjijNn6WnOHuZW3tIObx/LS5/RJy
         UoNalHF2B4k8azyAtqjSB2tSBNczcRZB9QDTkmxYabuHZYrj3eUTJA6nhOwJUx7llkrf
         5a7DczhuT4e0yoWWaJX1YBwuLEDxI6lB1L+nSsW+6i9xcne+BdtY+cN9O6E+rALUv7SJ
         A/mYr2nVQllsKqXqAcDg5SgErW+MtfFh4idhjNk4nGx6ih7k0xhiagirXLX/FaYT1dix
         920QbxJrz5ctygjhvCKXXLqVUq5F7TWddhr20GzzihAY8IYX8j8w6ECBrmVC6IvheDxT
         8pNQ==
X-Gm-Message-State: AJIora90TrnsVFuXOgaLJn9hFdc3vlC8lluHsl58anYSr2Iivdv1UIBu
        VEBHOQBkZDrZFLncBE1UjZQKrnwy+5SKrFlMLMWbXktOr+v2p4m7GcR6hxCXVfLcwi6BO/3IcqT
        kHb+/dn9gOnytEDU9MIM/biqi
X-Received: by 2002:a05:600c:34d0:b0:3a0:2c07:73ac with SMTP id d16-20020a05600c34d000b003a02c0773acmr1959916wmq.85.1656053488599;
        Thu, 23 Jun 2022 23:51:28 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1voXV55tZXi2rNo9MNXfewxWTMRest917EZVoAYp5MZLvuULQPfn1DNEvFjgf71hscyoZ5Pnw==
X-Received: by 2002:a05:600c:34d0:b0:3a0:2c07:73ac with SMTP id d16-20020a05600c34d000b003a02c0773acmr1959895wmq.85.1656053488395;
        Thu, 23 Jun 2022 23:51:28 -0700 (PDT)
Received: from redhat.com ([2.55.188.216])
        by smtp.gmail.com with ESMTPSA id m17-20020a05600c3b1100b0039c5497deccsm8262079wms.1.2022.06.23.23.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 23:51:27 -0700 (PDT)
Date:   Fri, 24 Jun 2022 02:51:24 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Lei He <helei.sig11@bytedance.com>
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au,
        dhowells@redhat.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, berrange@redhat.com,
        pizhenwei@bytedance.com
Subject: Re: [PATCH v2 0/4] virtio-crypto: support ECDSA algorithm
Message-ID: <20220624025114-mutt-send-email-mst@kernel.org>
References: <20220623070550.82053-1-helei.sig11@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623070550.82053-1-helei.sig11@bytedance.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 03:05:46PM +0800, Lei He wrote:
> From: lei he <helei.sig11@bytedance.com>
> 
> This patch supports the ECDSA algorithm for virtio-crypto.

virtio parts:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> V1 -> V2:
> - explicitly specified an appropriate base commit.
> - fixed the link error reported by kernel test robot <lkp@intl.com>.
> - removed irrelevant commits.
> 
> V1:
> - fixed the problem that the max_signature_size of ECDSA is
> incorrectly calculated.
> - make pkcs8_private_key_parser can identify ECDSA private keys.
> - implement ECDSA algorithm for virtio-crypto device
> 
> 
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
>  drivers/crypto/virtio/Kconfig                 |   1 +
>  .../virtio/virtio_crypto_akcipher_algs.c      | 259 ++++++++++++++++--
>  include/crypto/internal/ecdsa.h               |  15 +
>  include/linux/asn1_encoder.h                  |   2 +
>  lib/asn1_encoder.c                            |   3 +-
>  12 files changed, 361 insertions(+), 28 deletions(-)
>  create mode 100644 crypto/ecdsa_helper.c
>  create mode 100644 include/crypto/internal/ecdsa.h
> 
> 
> base-commit: 018ab4fabddd94f1c96f3b59e180691b9e88d5d8
> -- 
> 2.20.1

