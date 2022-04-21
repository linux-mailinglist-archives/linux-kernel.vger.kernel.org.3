Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F1E50A11E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 15:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387000AbiDUNt1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 21 Apr 2022 09:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237031AbiDUNtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 09:49:19 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F5B30F7C;
        Thu, 21 Apr 2022 06:46:29 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Kkf2g3HgzzhXXd;
        Thu, 21 Apr 2022 21:46:19 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Apr 2022 21:46:26 +0800
Received: from dggpemm500006.china.huawei.com ([7.185.36.236]) by
 dggpemm500006.china.huawei.com ([7.185.36.236]) with mapi id 15.01.2375.024;
 Thu, 21 Apr 2022 21:46:26 +0800
From:   "Gonglei (Arei)" <arei.gonglei@huawei.com>
To:     zhenwei pi <pizhenwei@bytedance.com>,
        "mst@redhat.com" <mst@redhat.com>
CC:     "jasowang@redhat.com" <jasowang@redhat.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "helei.sig11@bytedance.com" <helei.sig11@bytedance.com>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [PATCH v3 4/5] virtio-crypto: adjust dst_len at ops callback
Thread-Topic: [PATCH v3 4/5] virtio-crypto: adjust dst_len at ops callback
Thread-Index: AQHYVWzCHH3d5qDstUGT+mENWfA3Lqz6YBsQ
Date:   Thu, 21 Apr 2022 13:46:26 +0000
Message-ID: <4edf9c3d37f1435a8a6701a7429a3aba@huawei.com>
References: <20220421104016.453458-1-pizhenwei@bytedance.com>
 <20220421104016.453458-5-pizhenwei@bytedance.com>
In-Reply-To: <20220421104016.453458-5-pizhenwei@bytedance.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.149.11]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: zhenwei pi [mailto:pizhenwei@bytedance.com]
> Sent: Thursday, April 21, 2022 6:40 PM
> To: Gonglei (Arei) <arei.gonglei@huawei.com>; mst@redhat.com
> Cc: jasowang@redhat.com; herbert@gondor.apana.org.au;
> linux-kernel@vger.kernel.org; virtualization@lists.linux-foundation.org;
> linux-crypto@vger.kernel.org; helei.sig11@bytedance.com;
> davem@davemloft.net; zhenwei pi <pizhenwei@bytedance.com>
> Subject: [PATCH v3 4/5] virtio-crypto: adjust dst_len at ops callback
> 
> From: lei he <helei.sig11@bytedance.com>
> 
> For some akcipher operations(eg, decryption of pkcs1pad(rsa)), the length of
> returned result maybe less than akcipher_req->dst_len, we need to recalculate
> the actual dst_len through the virt-queue protocol.
> 
OK ...

> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Gonglei <arei.gonglei@huawei.com>
> Signed-off-by: lei he <helei.sig11@bytedance.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  drivers/crypto/virtio/virtio_crypto_akcipher_algs.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> index 9561bc2df62b..82db86e088c2 100644
> --- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> +++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> @@ -90,9 +90,12 @@ static void
> virtio_crypto_dataq_akcipher_callback(struct virtio_crypto_request *
>  	}
> 
>  	akcipher_req = vc_akcipher_req->akcipher_req;
> -	if (vc_akcipher_req->opcode != VIRTIO_CRYPTO_AKCIPHER_VERIFY)
> +	if (vc_akcipher_req->opcode != VIRTIO_CRYPTO_AKCIPHER_VERIFY) {
> +		/* actuall length maybe less than dst buffer */
> +		akcipher_req->dst_len = len - sizeof(vc_req->status);

...but why minus sizeof(vc_req->status)?


Regards,
-Gonglei


