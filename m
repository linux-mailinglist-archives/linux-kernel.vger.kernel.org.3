Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E79A4CB014
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 21:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244139AbiCBUlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 15:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236431AbiCBUlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 15:41:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62F0D5579;
        Wed,  2 Mar 2022 12:40:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 867A0B821E6;
        Wed,  2 Mar 2022 20:40:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28097C004E1;
        Wed,  2 Mar 2022 20:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646253651;
        bh=ll2MUZHgns3RPDcCVAmCrFf5Bkbbo9H/IV2mRJtbEko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rwX9Fqzsx+fQj4w51VWd0qdZnzNwuFMmE5ujLT7Ahyr0SG3X+iq2JjxWc6Dn42V9p
         oW9QgT3IkZqM6Mj2vajKmBlgFuXx8hndz0MzZb5KZGX//rOYLt2ASEdDihgWyZ0Uxl
         VLXdCcC4JdRgVrBNg/v5YItZ8iSpWriv2iD/0Lcaw7fJCCi+QMTSCIE2XIIM51tBni
         +defzfk6e14ValIUvOMUn7aOsm8zlckfZOi3d0e8tWbsXJjzSa42QXT+P9N1it51LG
         n6hXeEHTjSG+6xxESj5VISVPuJAklkJzFlleAEPX5IMq5AWJ0MCez/rJA3Bkaulbis
         LsoKoTpod+mcA==
Date:   Wed, 2 Mar 2022 20:40:49 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     arei.gonglei@huawei.com, mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        herbert@gondor.apana.org.au, helei.sig11@bytedance.com
Subject: Re: [PATCH v3 0/4] Introduce akcipher service for virtio-crypto
Message-ID: <Yh/WUSBesj/tRncT@gmail.com>
References: <20220302033917.1295334-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302033917.1295334-1-pizhenwei@bytedance.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 11:39:13AM +0800, zhenwei pi wrote:
> v2 -> v3:
>   Rename virtio_crypto_algs.c to virtio_crypto_skcipher_algs.c, and
>     minor changes of function name.
>   Minor changes in virtio_crypto_akcipher_algs.c: no need to copy from
>     buffer if opcode is verify.
> 
> v1 -> v2:
>   Fix 1 compiling warning reported by kernel test robot <lkp@intel.com>
>   Put "__le32 akcipher_algo;" instead of "__le32 reserve;" field of
>     struct virtio_crypto_config directly without size change.
>   Add padding in struct virtio_crypto_ecdsa_session_para to keep
>     64-bit alignment.
>   Remove irrelevant change by code format alignment.
> 
>   Also CC crypto gurus Herbert and linux-crypto@vger.kernel.org.
> 
>   Test with QEMU(patched by the v2 version), works fine.
> 
> v1:
>   Introduce akcipher service, implement RSA algorithm, and a minor fix.
> 
> zhenwei pi (4):
>   virtio_crypto: Introduce VIRTIO_CRYPTO_NOSPC
>   virtio-crypto: introduce akcipher service
>   virtio-crypto: implement RSA algorithm
>   virtio-crypto: rename skcipher algs
> 
>  drivers/crypto/virtio/Makefile                |   3 +-
>  .../virtio/virtio_crypto_akcipher_algs.c      | 585 ++++++++++++++++++
>  drivers/crypto/virtio/virtio_crypto_common.h  |   7 +-
>  drivers/crypto/virtio/virtio_crypto_core.c    |   6 +-
>  drivers/crypto/virtio/virtio_crypto_mgr.c     |  15 +-
>  ...o_algs.c => virtio_crypto_skcipher_algs.c} |   4 +-
>  include/uapi/linux/virtio_crypto.h            |  82 ++-
>  7 files changed, 693 insertions(+), 9 deletions(-)
>  create mode 100644 drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
>  rename drivers/crypto/virtio/{virtio_crypto_algs.c => virtio_crypto_skcipher_algs.c} (99%)

Why is this patchset useful?  That isn't explained anywhere.

- Eric
