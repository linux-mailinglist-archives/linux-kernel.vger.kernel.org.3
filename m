Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4589D5956DA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbiHPJn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233907AbiHPJn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:43:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E8635AA2A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 01:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660639405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lQ8+OX5Xxy8OFHIKMeBXHvilaHMyPM9qIfwd9KvB9T8=;
        b=gtMNqOWiEL6TkHDwAkt9qCMq6GAZmLsiV+ntWAf+B1f+XfrrTx9ma98+kOYHv7zBVUX2W8
        czBvY7oTJGmQbC7Qk07g0uD22GGffqd1IturOD2ozgxMdG4XxhBmMbQUHCedz5lZK7ylHE
        68fSmFBDTe7aTW9hpX2UAFUVrXWsh1A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-641-cbhRiZV3PguJjCeQwKK7pw-1; Tue, 16 Aug 2022 04:43:24 -0400
X-MC-Unique: cbhRiZV3PguJjCeQwKK7pw-1
Received: by mail-wm1-f69.google.com with SMTP id j22-20020a05600c485600b003a5e4420552so4501004wmo.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 01:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=lQ8+OX5Xxy8OFHIKMeBXHvilaHMyPM9qIfwd9KvB9T8=;
        b=xcFWUU90FKwQFauG2pqSbACxSILD53rw7yJHSs3dDtwhXNII17sqjk/c3VNtlaeORT
         2vYHHyzVsCZfD80GlcznHtsu0L4Xralbs3J52vLqDSN0JaYBKyzBH3lJZbTC/D8GHYhJ
         GXTq3Kakvn8i9zT9cSNXHZoAR6kek/PynMyeFfL5Whs4byKH7bdEpBhay26S7X0UdO01
         d67TNtnozDyzzj3EU6NUE0+oJREx/Fzl6kZCmamh3edVYCVILiEZT0NcHga/g+/Tdw3v
         Uwr2lW7c+ATav8iJ8uqBtZKffMkVvig0mjl8g84y/96TZRdP61L3jPc7y6BAoiXNgmVt
         qTgQ==
X-Gm-Message-State: ACgBeo1C6xMTvMon8hPp70eEt8lCMWUvovWgcvtwSBWme/UzCYyZHyj+
        xqmBfUL5bywdMp+nwQNoXzQzf/3qqEE2JGeifkjTRfZGmM4OYJCLadF5a71gmJNixQjtO1SzSAC
        6NJrpHw2+sLNJiiIwmeQTrBU9
X-Received: by 2002:a05:6000:a1a:b0:21f:10a3:924 with SMTP id co26-20020a0560000a1a00b0021f10a30924mr11187432wrb.650.1660639403152;
        Tue, 16 Aug 2022 01:43:23 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6cDAFFABxm0UC6KHn6bIybMZn2ombgjhUlsi97ISnZjBMZOQIY2aI+6s7bBLYzIu9Hq0irDw==
X-Received: by 2002:a05:6000:a1a:b0:21f:10a3:924 with SMTP id co26-20020a0560000a1a00b0021f10a30924mr11187420wrb.650.1660639402874;
        Tue, 16 Aug 2022 01:43:22 -0700 (PDT)
Received: from redhat.com ([2.55.43.215])
        by smtp.gmail.com with ESMTPSA id u8-20020a05600c19c800b003a5f3de6fddsm7193442wmq.25.2022.08.16.01.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 01:43:22 -0700 (PDT)
Date:   Tue, 16 Aug 2022 04:43:18 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Lei He <helei.sig11@bytedance.com>
Cc:     arei.gonglei@huawei.com, herbert@gondor.apana.org.au,
        virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        pizhenwei@bytedance.com
Subject: Re: [PATCH] crypto-virtio: fix memory-leak
Message-ID: <20220816044118-mutt-send-email-mst@kernel.org>
References: <20220816075916.23651-1-helei.sig11@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816075916.23651-1-helei.sig11@bytedance.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 03:59:16PM +0800, Lei He wrote:
> From: lei he <helei.sig11@bytedance.com>
> 
> Fix memory-leak for virtio-crypto akcipher request, this problem is
> introduced by 59ca6c93387d3(virtio-crypto: implement RSA algorithm).
> The leak can be reproduced and tested with the following script
> inside virtual machine:
> 
> #!/bin/bash
> 
> LOOP_TIMES=10000
> 
> # required module: pkcs8_key_parser, virtio_crypto
> modprobe pkcs8_key_parser # if CONFIG_PKCS8_PRIVATE_KEY_PARSER=m
> modprobe virtio_crypto # if CONFIG_CRYPTO_DEV_VIRTIO=m
> rm -rf /tmp/data
> dd if=/dev/random of=/tmp/data count=1 bs=230
> 
> # generate private key and self-signed cert
> openssl req -nodes -x509 -newkey rsa:2048 -keyout key.pem \
> 		-outform der -out cert.der  \
> 		-subj "/C=CN/ST=GD/L=SZ/O=vihoo/OU=dev/CN=always.com/emailAddress=yy@always.com"
> # convert private key from pem to der
> openssl pkcs8 -in key.pem -topk8 -nocrypt -outform DER -out key.der
> 
> # add key
> PRIV_KEY_ID=`cat key.der | keyctl padd asymmetric test_priv_key @s`
> echo "priv key id = "$PRIV_KEY_ID
> PUB_KEY_ID=`cat cert.der | keyctl padd asymmetric test_pub_key @s`
> echo "pub key id = "$PUB_KEY_ID
> 
> # query key
> keyctl pkey_query $PRIV_KEY_ID 0
> keyctl pkey_query $PUB_KEY_ID 0
> 
> # here we only run pkey_encrypt becasuse it is the fastest interface
> function bench_pub() {
> 	keyctl pkey_encrypt $PUB_KEY_ID 0 /tmp/data enc=pkcs1 >/tmp/enc.pub
> }
> 
> # do bench_pub in loop to obtain the memory leak
> for (( i = 0; i < ${LOOP_TIMES}; ++i )); do
> 	bench_pub
> done
> 
> Signed-off-by: lei he <helei.sig11@bytedance.com>

trash below pls drop.


> # Please enter the commit message for your changes. Lines starting
> # with '#' will be kept; you may remove them yourself if you want to.
> # An empty message aborts the commit.
> #
> # Date:      Tue Aug 16 11:53:30 2022 +0800
> #
> # On branch master
> # Your branch is ahead of 'origin/master' by 1 commit.
> #   (use "git push" to publish your local commits)
> #
> # Changes to be committed:
> #	modified:   drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> #
> # Untracked files:
> #	cert.der
> #	key.der
> #	key.pem
> #
> 
> # Please enter the commit message for your changes. Lines starting
> # with '#' will be kept; you may remove them yourself if you want to.
> # An empty message aborts the commit.
> #
> # Date:      Tue Aug 16 11:53:30 2022 +0800
> #
> # On branch master
> # Your branch is ahead of 'origin/master' by 1 commit.
> #   (use "git push" to publish your local commits)
> #
> # Changes to be committed:
> #	modified:   drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> #
> # Untracked files:
> #	cert.der
> #	key.der
> #	key.pem
> #
> 
> # Please enter the commit message for your changes. Lines starting
> # with '#' will be kept; you may remove them yourself if you want to.
> # An empty message aborts the commit.
> #
> # Date:      Tue Aug 16 11:53:30 2022 +0800
> #
> # On branch master
> # Your branch is ahead of 'origin/master' by 1 commit.
> #   (use "git push" to publish your local commits)
> #
> # Changes to be committed:
> #	modified:   drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> #
> # Untracked files:
> #	cert.der
> #	key.der
> #	key.pem
> #
> ---

with commit log fixed:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

>  drivers/crypto/virtio/virtio_crypto_akcipher_algs.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> index 2a60d0525cde..168195672e2e 100644
> --- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> +++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> @@ -56,6 +56,10 @@ static void virtio_crypto_akcipher_finalize_req(
>  	struct virtio_crypto_akcipher_request *vc_akcipher_req,
>  	struct akcipher_request *req, int err)
>  {
> +	kfree(vc_akcipher_req->src_buf);
> +	kfree(vc_akcipher_req->dst_buf);
> +	vc_akcipher_req->src_buf = NULL;
> +	vc_akcipher_req->dst_buf = NULL;
>  	virtcrypto_clear_request(&vc_akcipher_req->base);
>  
>  	crypto_finalize_akcipher_request(vc_akcipher_req->base.dataq->engine, req, err);
> -- 
> 2.20.1

