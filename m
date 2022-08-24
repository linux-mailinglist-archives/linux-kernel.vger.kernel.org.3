Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4302259F56A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 10:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235113AbiHXIiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 04:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiHXIiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 04:38:08 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2203869F4B
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 01:38:07 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id f21so16377014pjt.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 01:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject:cc
         :user-agent:mime-version:date:message-id:from:to:cc;
        bh=+N+UE2X7qHP/k3D28KNJuWxXPnW1fj++zF37MMUkZvs=;
        b=l2mLLuW96AUMrOkw1NO9NyPlFA+5vidq2XHQ1XGYHXAt58pkEkSdmTrVB0bq+Ij/Dd
         NFPq5Cq03M7jUOl1bFfiHiNld5AxAk4ZmpQne5kyZRDzmeoODLxiYLskI1xUM3NFwrpC
         LvtoN33HZeFUOKjFrOmeNvlTVuG0HLWbjBnip//tNSPxhZWyC7fYydTJ2bfH1WCXRii4
         dz/xsMiJr7y/pEWxjKOuNiFVwOtVe7tyS+HkhpGhwzvj57iP6pT7n68x5VmhGp+EZvDn
         bk2xuQN/peZCsxoaMfNN/MChuqiB6M+yXj+4NGzNnLTWFIVoQHOpHTY3HVyQ4X+jecC5
         om1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject:cc
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=+N+UE2X7qHP/k3D28KNJuWxXPnW1fj++zF37MMUkZvs=;
        b=rNpf37mrIsPewYDWJFnio8x3PzHoy2LzIUIPvvMVarA+vVLfPvyMwwCOZz72WvmJ2H
         /U7FlmipOklMsYihUF7Evl/rbyLr0btQcRWj8wdU7ybeRtpsdvY0AIRnVnlauawMvzfH
         3OzBCD+wCOt1kv+j6lu3AHXtrlyrYJxpC1tS910F3BZm+jmJ88MAnNBAvm8wpp2ieJRs
         1GzCLFWEACoc7TBudgxjB8hTIFlM7c87H8fvbX4axhw6MBSh8OldUo+nxsEzojh/yWW+
         ZdPuFECi+tKVUbTpUMztHsOQpmKVo/bbMUlOW4WMj8CQ8x7IOTmEB1knosQoo9TvVoyf
         vTFw==
X-Gm-Message-State: ACgBeo1Q4TVi6BgdpIk1aWHnxdY8wQ77TnDzdRw/3Wh49kcZNCGofskl
        fWTnsEBSVRy7BFddtGLh8kRaUw==
X-Google-Smtp-Source: AA6agR792mm220wXVOY8iINInSkP7OO47CDQTqD6ox3ALgicSewvh8sQM/dCrRGc3T1Cpg9MYRL/XA==
X-Received: by 2002:a17:902:aa03:b0:172:9b18:ebb1 with SMTP id be3-20020a170902aa0300b001729b18ebb1mr26730429plb.24.1661330286451;
        Wed, 24 Aug 2022 01:38:06 -0700 (PDT)
Received: from [10.76.43.148] ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id lp12-20020a17090b4a8c00b001fa8b909ef0sm843210pjb.7.2022.08.24.01.38.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 01:38:06 -0700 (PDT)
Message-ID: <95f6eec3-62f7-46d8-9bb1-664fb9e36534@bytedance.com>
Date:   Wed, 24 Aug 2022 16:38:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.2
Cc:     helei.sig11@bytedance.com,
        virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        pizhenwei@bytedance.com
Subject: PING: [PATCH v2] virtio-crypto: fix memory-leak
To:     mst@redhat.com, herbert@gondor.apana.org.au,
        arei.gonglei@huawei.com
References: <20220816094336.27806-1-helei.sig11@bytedance.com>
From:   Lei He <helei.sig11@bytedance.com>
In-Reply-To: <20220816094336.27806-1-helei.sig11@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/16 下午5:43, Lei He wrote:
> From: lei he <helei.sig11@bytedance.com>
> 
> Fix memory-leak for virtio-crypto akcipher request, this problem is
> introduced by 59ca6c93387d3(virtio-crypto: implement RSA algorithm).
> The leak can be reproduced and tested with the following script
> inside virtual machine:
> 
> Signed-off-by: lei he <helei.sig11@bytedance.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Gonglei <arei.gonglei@huawei.com>
> ---
>   drivers/crypto/virtio/virtio_crypto_akcipher_algs.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> index 2a60d0525cde..168195672e2e 100644
> --- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> +++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> @@ -56,6 +56,10 @@ static void virtio_crypto_akcipher_finalize_req(
>   	struct virtio_crypto_akcipher_request *vc_akcipher_req,
>   	struct akcipher_request *req, int err)
>   {
> +	kfree(vc_akcipher_req->src_buf);
> +	kfree(vc_akcipher_req->dst_buf);
> +	vc_akcipher_req->src_buf = NULL;
> +	vc_akcipher_req->dst_buf = NULL;
>   	virtcrypto_clear_request(&vc_akcipher_req->base);
>   
>   	crypto_finalize_akcipher_request(vc_akcipher_req->base.dataq->engine, req, err);
> 
> base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868

PING.

Best regards,
Lei He
--
helei.sig11@bytedance.com

