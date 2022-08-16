Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDF759582F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234544AbiHPK2J convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 16 Aug 2022 06:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234451AbiHPK11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:27:27 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F5A4C605;
        Tue, 16 Aug 2022 02:15:47 -0700 (PDT)
Received: from kwepemi500011.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4M6QQd51zkz1M8yg;
        Tue, 16 Aug 2022 17:12:25 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 kwepemi500011.china.huawei.com (7.221.188.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 16 Aug 2022 17:15:44 +0800
Received: from dggpemm500006.china.huawei.com ([7.185.36.236]) by
 dggpemm500006.china.huawei.com ([7.185.36.236]) with mapi id 15.01.2375.024;
 Tue, 16 Aug 2022 17:15:44 +0800
From:   "Gonglei (Arei)" <arei.gonglei@huawei.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Lei He <helei.sig11@bytedance.com>
CC:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pizhenwei@bytedance.com" <pizhenwei@bytedance.com>
Subject: RE: [PATCH] crypto-virtio: fix memory-leak
Thread-Topic: [PATCH] crypto-virtio: fix memory-leak
Thread-Index: AQHYsUY0nKlBM3YWoEWBnWo9iL/j1q2wr84AgACNxNA=
Date:   Tue, 16 Aug 2022 09:15:44 +0000
Message-ID: <0a675c21c1dc4e699d542c2f4f92f729@huawei.com>
References: <20220816075916.23651-1-helei.sig11@bytedance.com>
 <20220816044118-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220816044118-mutt-send-email-mst@kernel.org>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Michael S. Tsirkin [mailto:mst@redhat.com]
> Sent: Tuesday, August 16, 2022 4:43 PM
> To: Lei He <helei.sig11@bytedance.com>
> Cc: Gonglei (Arei) <arei.gonglei@huawei.com>;
> herbert@gondor.apana.org.au; virtualization@lists.linux-foundation.org;
> linux-crypto@vger.kernel.org; linux-kernel@vger.kernel.org;
> pizhenwei@bytedance.com
> Subject: Re: [PATCH] crypto-virtio: fix memory-leak
> 

Pls 's/crypto-virtio/virtio-crypto' in order to keep consistency.

Reviewed-by: Gonglei <arei.gonglei@huawei.com>

Regards,
-Gonglei

> On Tue, Aug 16, 2022 at 03:59:16PM +0800, Lei He wrote:
> > From: lei he <helei.sig11@bytedance.com>
> >
> > Fix memory-leak for virtio-crypto akcipher request, this problem is
> > introduced by 59ca6c93387d3(virtio-crypto: implement RSA algorithm).
> > The leak can be reproduced and tested with the following script inside
> > virtual machine:
> >
> > #!/bin/bash
> >
> > LOOP_TIMES=10000
> >
> > # required module: pkcs8_key_parser, virtio_crypto modprobe
> > pkcs8_key_parser # if CONFIG_PKCS8_PRIVATE_KEY_PARSER=m modprobe
> > virtio_crypto # if CONFIG_CRYPTO_DEV_VIRTIO=m rm -rf /tmp/data dd
> > if=/dev/random of=/tmp/data count=1 bs=230
> >
> > # generate private key and self-signed cert openssl req -nodes -x509
> > -newkey rsa:2048 -keyout key.pem \
> > 		-outform der -out cert.der  \
> > 		-subj
> "/C=CN/ST=GD/L=SZ/O=vihoo/OU=dev/CN=always.com/emailAddress=yy@
> always.com"
> > # convert private key from pem to der
> > openssl pkcs8 -in key.pem -topk8 -nocrypt -outform DER -out key.der
> >
> > # add key
> > PRIV_KEY_ID=`cat key.der | keyctl padd asymmetric test_priv_key @s`
> > echo "priv key id = "$PRIV_KEY_ID PUB_KEY_ID=`cat cert.der | keyctl
> > padd asymmetric test_pub_key @s` echo "pub key id = "$PUB_KEY_ID
> >
> > # query key
> > keyctl pkey_query $PRIV_KEY_ID 0
> > keyctl pkey_query $PUB_KEY_ID 0
> >
> > # here we only run pkey_encrypt becasuse it is the fastest interface
> > function bench_pub() {
> > 	keyctl pkey_encrypt $PUB_KEY_ID 0 /tmp/data
> enc=pkcs1 >/tmp/enc.pub }
> >
> > # do bench_pub in loop to obtain the memory leak for (( i = 0; i <
> > ${LOOP_TIMES}; ++i )); do
> > 	bench_pub
> > done
> >
> > Signed-off-by: lei he <helei.sig11@bytedance.com>
> 
> trash below pls drop.
> 
> 
> > # Please enter the commit message for your changes. Lines starting #
> > with '#' will be kept; you may remove them yourself if you want to.
> > # An empty message aborts the commit.
> > #
> > # Date:      Tue Aug 16 11:53:30 2022 +0800
> > #
> > # On branch master
> > # Your branch is ahead of 'origin/master' by 1 commit.
> > #   (use "git push" to publish your local commits)
> > #
> > # Changes to be committed:
> > #	modified:   drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> > #
> > # Untracked files:
> > #	cert.der
> > #	key.der
> > #	key.pem
> > #
> >
> > # Please enter the commit message for your changes. Lines starting #
> > with '#' will be kept; you may remove them yourself if you want to.
> > # An empty message aborts the commit.
> > #
> > # Date:      Tue Aug 16 11:53:30 2022 +0800
> > #
> > # On branch master
> > # Your branch is ahead of 'origin/master' by 1 commit.
> > #   (use "git push" to publish your local commits)
> > #
> > # Changes to be committed:
> > #	modified:   drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> > #
> > # Untracked files:
> > #	cert.der
> > #	key.der
> > #	key.pem
> > #
> >
> > # Please enter the commit message for your changes. Lines starting #
> > with '#' will be kept; you may remove them yourself if you want to.
> > # An empty message aborts the commit.
> > #
> > # Date:      Tue Aug 16 11:53:30 2022 +0800
> > #
> > # On branch master
> > # Your branch is ahead of 'origin/master' by 1 commit.
> > #   (use "git push" to publish your local commits)
> > #
> > # Changes to be committed:
> > #	modified:   drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> > #
> > # Untracked files:
> > #	cert.der
> > #	key.der
> > #	key.pem
> > #
> > ---
> 
> with commit log fixed:
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> >  drivers/crypto/virtio/virtio_crypto_akcipher_algs.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> > b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> > index 2a60d0525cde..168195672e2e 100644
> > --- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> > +++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> > @@ -56,6 +56,10 @@ static void virtio_crypto_akcipher_finalize_req(
> >  	struct virtio_crypto_akcipher_request *vc_akcipher_req,
> >  	struct akcipher_request *req, int err)  {
> > +	kfree(vc_akcipher_req->src_buf);
> > +	kfree(vc_akcipher_req->dst_buf);
> > +	vc_akcipher_req->src_buf = NULL;
> > +	vc_akcipher_req->dst_buf = NULL;
> >  	virtcrypto_clear_request(&vc_akcipher_req->base);
> >
> >
> > crypto_finalize_akcipher_request(vc_akcipher_req->base.dataq->engine,
> > req, err);
> > --
> > 2.20.1

