Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3DA50B0F6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 08:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444600AbiDVHBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 03:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389262AbiDVHBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 03:01:33 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1921050E2F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 23:58:41 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id x191so6646364pgd.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 23:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ilKMohUyCVfP3cDqrVw2LdFD9mYpqar2wJSPIf9OKBA=;
        b=2f7kR5hrJh3MurGD6PTL+aTZYNv/GAgABQCqmAi1wf/jUtevyutOHHAAkLnwNK/TiF
         hI4IxRca1WEjgA3lmLueTRqkH9ObwBxIAE6wpmq1N/Dnpy80j+WXSXihAXn/3R3SjdjU
         XAU4udqLPqBVPGiGNp3Ou+agh3I5f9v1MESSh9NHPEs7Vpfy0JQMx5sWS26M36QrT2y8
         dWfVkRqvRRKmw2QYdxf0UB+KF51lMIZMtOw2YnRlq16vJLRSpJwu7WUAJfOzmD3FNF+8
         AysH2x0WajWEoqxLOY7s/1JaUqEpn0zC0iiAJ4d2Oc4ZKv+cBrrzN+Vk2fUieFdwM1B6
         hTiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ilKMohUyCVfP3cDqrVw2LdFD9mYpqar2wJSPIf9OKBA=;
        b=kXgmv82Jeq/7nRjLPVN7uCKMqPx0+AL6C/up68RwcdiUzTc4RtoOEd00hsL9yRPXnM
         ZxePoMPoltv5sb8GzCZ/YR/1uGoSH56q/CdSIwcFByzpZzTkkTf65CjNV2F+Jhcswa0T
         31kTOoRFDn1bhLX02u+9Wxn+WVvyjacushlhMcLy6E6LoXscx0MSUYDup84da9X6u1/V
         dN8/nNu8qXnCR/hXt81bthp4PwwsGMwmmQdxPMW+cljwcrxB551YqhvM43rYYHRIj+2R
         n89StlgKZlws17BJzUkgRJb50+ww7NCAHUeN7SNmt77GrhFLQOpvDlY9riivTI+bcrpi
         b3dw==
X-Gm-Message-State: AOAM532kICjWf7sZffftK6U4DhUa03miot0WvPGrWIA7PF8OViF0btV6
        uZUAL4CUC5z6X28hRh+TH3zizA==
X-Google-Smtp-Source: ABdhPJwAxvRXOUtp5mektbxoAMvMclDpwduv3JT8wNDZcxAmMT1Qefc5+E5HUvI054mZm0L51/Y1Xg==
X-Received: by 2002:a63:5859:0:b0:3aa:4cf7:fbfd with SMTP id i25-20020a635859000000b003aa4cf7fbfdmr2753287pgm.522.1650610720608;
        Thu, 21 Apr 2022 23:58:40 -0700 (PDT)
Received: from [10.76.43.148] ([61.120.150.78])
        by smtp.gmail.com with ESMTPSA id x23-20020a17090a0bd700b001cd498dc152sm5139199pjd.2.2022.04.21.23.58.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Apr 2022 23:58:40 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [External] [PATCH v3 4/5] virtio-crypto: adjust dst_len at ops
 callback
From:   =?utf-8?B?5L2V56OK?= <helei.sig11@bytedance.com>
In-Reply-To: <4edf9c3d37f1435a8a6701a7429a3aba@huawei.com>
Date:   Fri, 22 Apr 2022 14:58:33 +0800
Cc:     =?utf-8?B?5L2V56OK?= <helei.sig11@bytedance.com>,
        zhenwei pi <pizhenwei@bytedance.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7B16C43E-1C25-44B6-A4F0-B546935ECA27@bytedance.com>
References: <20220421104016.453458-1-pizhenwei@bytedance.com>
 <20220421104016.453458-5-pizhenwei@bytedance.com>
 <4edf9c3d37f1435a8a6701a7429a3aba@huawei.com>
To:     "Gonglei (Arei)" <arei.gonglei@huawei.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 21, 2022, at 9:46 PM, Gonglei (Arei) <arei.gonglei@huawei.com> =
wrote:
>=20
>=20
>=20
>> -----Original Message-----
>> From: zhenwei pi [mailto:pizhenwei@bytedance.com]
>> Sent: Thursday, April 21, 2022 6:40 PM
>> To: Gonglei (Arei) <arei.gonglei@huawei.com>; mst@redhat.com
>> Cc: jasowang@redhat.com; herbert@gondor.apana.org.au;
>> linux-kernel@vger.kernel.org; =
virtualization@lists.linux-foundation.org;
>> linux-crypto@vger.kernel.org; helei.sig11@bytedance.com;
>> davem@davemloft.net; zhenwei pi <pizhenwei@bytedance.com>
>> Subject: [PATCH v3 4/5] virtio-crypto: adjust dst_len at ops callback
>>=20
>> From: lei he <helei.sig11@bytedance.com>
>>=20
>> For some akcipher operations(eg, decryption of pkcs1pad(rsa)), the =
length of
>> returned result maybe less than akcipher_req->dst_len, we need to =
recalculate
>> the actual dst_len through the virt-queue protocol.
>>=20
> OK ...
>=20
>> Cc: Michael S. Tsirkin <mst@redhat.com>
>> Cc: Jason Wang <jasowang@redhat.com>
>> Cc: Gonglei <arei.gonglei@huawei.com>
>> Signed-off-by: lei he <helei.sig11@bytedance.com>
>> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
>> ---
>> drivers/crypto/virtio/virtio_crypto_akcipher_algs.c | 5 ++++-
>> 1 file changed, 4 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
>> b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
>> index 9561bc2df62b..82db86e088c2 100644
>> --- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
>> +++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
>> @@ -90,9 +90,12 @@ static void
>> virtio_crypto_dataq_akcipher_callback(struct virtio_crypto_request *
>> 	}
>>=20
>> 	akcipher_req =3D vc_akcipher_req->akcipher_req;
>> -	if (vc_akcipher_req->opcode !=3D VIRTIO_CRYPTO_AKCIPHER_VERIFY)
>> +	if (vc_akcipher_req->opcode !=3D VIRTIO_CRYPTO_AKCIPHER_VERIFY) =
{
>> +		/* actuall length maybe less than dst buffer */
>> +		akcipher_req->dst_len =3D len - sizeof(vc_req->status);
>=20
> ...but why minus sizeof(vc_req->status)?

The len here indicates the total length of data written by the device. =
for encrypt/decrypt/sign,
the virt crypto device writes two parts of data: dst_data and =
status(virtio_crypto_inhdr).=20
To obtain dst_len, the size of status needs to be subtracted.

>=20
>=20
> Regards,
> -Gonglei

