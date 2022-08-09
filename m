Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB6058DFA9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 21:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345251AbiHITDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 15:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbiHITCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 15:02:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 99EA32714D
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 11:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660070207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m/RDB/JS2A+rkcJXiycrT7nlqCdePEvztzO47vN60tc=;
        b=bjP9gKPKNXDnqR/ekBciil5YFDVW/i8eL3UtMy988/PWXyDZq9hX30/5zlMnDG2BzKUwnC
        2Tiw34BCe9h4113btUaITaNMZ7LZoGztvtrI2utOErkh3lP4PMuMwzVXlQtE4C8ataa5bj
        82iPhSvXzQXxHG5Jd7XQhjMFpldK9WY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-128-vcLx2b0HM-GamD-3CrIY_w-1; Tue, 09 Aug 2022 14:36:46 -0400
X-MC-Unique: vcLx2b0HM-GamD-3CrIY_w-1
Received: by mail-ej1-f69.google.com with SMTP id js11-20020a17090797cb00b00730d73eac83so3635829ejc.19
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 11:36:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=m/RDB/JS2A+rkcJXiycrT7nlqCdePEvztzO47vN60tc=;
        b=k0h5RjcAYJHzKswgkGIq281vTRnufTOtPQ9wtYMNnItMhoq2GNV7qK+vKPtA4kIe0a
         f7ACUUgRvJtPmLb+GxsLR0G9UvloHENsV/5gXB9/HyjqoDYc6jK7QjU/1pZ/HWh8JNMn
         BrihW1UF+LhHU7vBn3yi7yFMpJX2Rn+gi+bDyEFAQOhoTIZNU4WiH5rYrw2o0lv4+f3i
         8CHKFujqSPsk2V0eRDnr3GsZuadottKEEXgYHvMIKVM1NJAcFyE0R9eZXY6Xkjf+B2b3
         XFn6+Rpl87dptRNDwr0S6GhYnH+8u4P6cCivdjAFe1S4wvg9JnqvlwfuWgYGkfTKrxht
         Iopw==
X-Gm-Message-State: ACgBeo36tmQuqrHz+G7Q1ZccqPZlgTno1G4ejn4lUuLHtPG/3g8TiPbg
        uMQZV0qcVm+qBt2Ue3kfdK/55Wd3FOpbYypWojPHp2SVCygeGCnOmbgUw3sSAbdOfA3eA7438a2
        Y+xBqWqzxvrqOA57mSQQMWuwU
X-Received: by 2002:a17:907:28c9:b0:731:e57:bf27 with SMTP id en9-20020a17090728c900b007310e57bf27mr12916956ejc.451.1660070204929;
        Tue, 09 Aug 2022 11:36:44 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6EzlIwxo5M9CoAjttFlYSxF5sujZStl/jx93pHpz0KHh5xypEXt7HG7RqiC3AKRhj9Vee8qQ==
X-Received: by 2002:a17:907:28c9:b0:731:e57:bf27 with SMTP id en9-20020a17090728c900b007310e57bf27mr12916940ejc.451.1660070204682;
        Tue, 09 Aug 2022 11:36:44 -0700 (PDT)
Received: from redhat.com ([2.52.152.113])
        by smtp.gmail.com with ESMTPSA id o3-20020a170906768300b0072b2ef2757csm1366205ejm.180.2022.08.09.11.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 11:36:43 -0700 (PDT)
Date:   Tue, 9 Aug 2022 14:36:40 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Lei He <helei.sig11@bytedance.com>
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au,
        dhowells@redhat.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, berrange@redhat.com,
        pizhenwei@bytedance.com
Subject: Re: [PATCH v2 0/4] virtio-crypto: support ECDSA algorithm
Message-ID: <20220809143555-mutt-send-email-mst@kernel.org>
References: <20220623070550.82053-1-helei.sig11@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623070550.82053-1-helei.sig11@bytedance.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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
> 
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


So this depends on core crypto changes that need Herbert's ack.
I'll drop this from my radar for now.

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

