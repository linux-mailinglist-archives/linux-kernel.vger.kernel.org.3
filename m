Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0384951D75A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 14:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391675AbiEFMQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 08:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389887AbiEFMP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 08:15:59 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5386964BC5
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 05:12:16 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id c15so9017585ljr.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 05:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to;
        bh=lRp+ZdqOf1BfS4ApwW+D8fpA+7lY1PPJXrS8z5sasY4=;
        b=PcwPMsgOTxgVrSmdSMLhAw2oKKQ5Ytqa5VNWcPuCMQdrbcus+nlbrOd24h573FJH++
         ESe8ucB4vGaz10X+ymhOnJR40Mm6CVHyiAVs1Y6FCGQRljTrReuSWUHRgxw/4vRyLe4o
         C7zrTtj4KgYGuDDKsyohD4m9NS74CLzEMuVzdEcVORiF3R1m3AT9D8w7Bf8/bjvgaPVn
         cTlxgvA4uWx0CPP+1gEaRIyHJNboTdVPgnxV7RH9WLAF1ITZgACOGXzFOg9e5UfibEBW
         +EWakY3/+PoxVQjVGnq3/RG2sWNJtuAFjL1UxJvtiSGRqsNnSahOuDzmfK1Jyffw0ql1
         Hylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to;
        bh=lRp+ZdqOf1BfS4ApwW+D8fpA+7lY1PPJXrS8z5sasY4=;
        b=7YaerbdZ4iC/0QGVeQl+LlOQsvnlW1Nq5ZbWDo/ZRq2x3vklhI5DMNFq2BxozxFPfH
         zVgSzcTUBFOMoM5L7kztc9OVX4hEYTAI8+YZAoCnp/vmR0CT23SQP97g9VAi8lqrTcPq
         wCPy6b5xiXsyzdQsB5ImBDMxgCEvhS6CMNYi5s5nFv5yJ2JbQRiyGzYggFvCr9UYdCoK
         UxCbg+sWvwIlTmdUEB70Hd6cewO7gk+yN/y0z/AJGhUuVWr/4rUCDv4RFCRypkhSHUQl
         8O5Bz1dChpY8qf5EWNHyrSJuYC3KvL0wNA8jRCKPZKr2aXeOgGbMHLnRsNZOlRPr15bI
         B/+w==
X-Gm-Message-State: AOAM532T40EG44RB43gNwpDqn9fnO3la812kue8Rdbn/LR7j53oQp16z
        M+4k2eFbNTsRDpKjtg1E9Cw=
X-Google-Smtp-Source: ABdhPJw9swqoK7fUcEQU+RBT1wbd2MEms2bg70UDyZbdO8IjUOetuEfBgE1bgae3ry9WaGGUZCdtuQ==
X-Received: by 2002:a2e:b6c6:0:b0:24f:3919:5923 with SMTP id m6-20020a2eb6c6000000b0024f39195923mr1809788ljo.398.1651839134619;
        Fri, 06 May 2022 05:12:14 -0700 (PDT)
Received: from [192.168.1.11] ([217.117.246.114])
        by smtp.gmail.com with ESMTPSA id 185-20020a2e09c2000000b0024b14fa6061sm615392ljj.1.2022.05.06.05.12.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 05:12:14 -0700 (PDT)
Message-ID: <dba1acfa-1e82-7b6b-928a-beff18c51f5b@gmail.com>
Date:   Fri, 6 May 2022 15:12:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 1/3] staging: rtl8712: fix uninit-value in usb_read8()
 and friends
Content-Language: en-US
To:     Wang Cheng <wanngchenng@gmail.com>, dan.carpenter@oracle.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1651833575.git.wanngchenng@gmail.com>
 <b9b7a6ee02c02aa28054f5cf16129977775f3cd9.1651833575.git.wanngchenng@gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <b9b7a6ee02c02aa28054f5cf16129977775f3cd9.1651833575.git.wanngchenng@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------FJJcGAN0o9ZhkgJwa8w9rJRE"
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------FJJcGAN0o9ZhkgJwa8w9rJRE
Content-Type: multipart/mixed; boundary="------------SFZh8FiyaemsHlRV1aEBrGn8";
 protected-headers="v1"
From: Pavel Skripkin <paskripkin@gmail.com>
To: Wang Cheng <wanngchenng@gmail.com>, dan.carpenter@oracle.com
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Message-ID: <dba1acfa-1e82-7b6b-928a-beff18c51f5b@gmail.com>
Subject: Re: [PATCH v3 1/3] staging: rtl8712: fix uninit-value in usb_read8()
 and friends
References: <cover.1651833575.git.wanngchenng@gmail.com>
 <b9b7a6ee02c02aa28054f5cf16129977775f3cd9.1651833575.git.wanngchenng@gmail.com>
In-Reply-To: <b9b7a6ee02c02aa28054f5cf16129977775f3cd9.1651833575.git.wanngchenng@gmail.com>

--------------SFZh8FiyaemsHlRV1aEBrGn8
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgV2FuZywNCg0KT24gNS82LzIyIDE0OjU5LCBXYW5nIENoZW5nIHdyb3RlOg0KPiBSZXBv
cnRlZC1hbmQtdGVzdGVkLWJ5OiBzeXpib3QrNmY1ZWNkMTQ0ODU0YzBkODU4MGJAc3l6a2Fs
bGVyLmFwcHNwb3RtYWlsLmNvbQ0KPiBTaWduZWQtb2ZmLWJ5OiBXYW5nIENoZW5nIDx3YW5u
Z2NoZW5uZ0BnbWFpbC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvc3RhZ2luZy9ydGw4NzEy
L3VzYl9vcHMuYyB8IDI3ICsrKysrKysrKysrKysrKysrKy0tLS0tLS0tLQ0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvc3RhZ2luZy9ydGw4NzEyL3VzYl9vcHMuYyBiL2RyaXZlcnMv
c3RhZ2luZy9ydGw4NzEyL3VzYl9vcHMuYw0KPiBpbmRleCBlNjQ4NDVlNmFkZjMuLmFmOTk2
NmQwMzk3OSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zdGFnaW5nL3J0bDg3MTIvdXNiX29w
cy5jDQo+ICsrKyBiL2RyaXZlcnMvc3RhZ2luZy9ydGw4NzEyL3VzYl9vcHMuYw0KPiBAQCAt
MjksNyArMjksOCBAQCBzdGF0aWMgdTggdXNiX3JlYWQ4KHN0cnVjdCBpbnRmX2hkbCAqaW50
ZmhkbCwgdTMyIGFkZHIpDQo+ICAgCXUxNiB3dmFsdWU7DQo+ICAgCXUxNiBpbmRleDsNCj4g
ICAJdTE2IGxlbjsNCj4gLQlfX2xlMzIgZGF0YTsNCj4gKwlpbnQgc3RhdHVzOw0KPiArCV9f
bGUzMiBkYXRhID0gMDsNCj4gICAJc3RydWN0IGludGZfcHJpdiAqaW50ZnByaXYgPSBpbnRm
aGRsLT5waW50ZnByaXY7DQo+ICAgDQo+ICAgCXJlcXVlc3QgPSAweDA1Ow0KPiBAQCAtMzcs
OCArMzgsMTAgQEAgc3RhdGljIHU4IHVzYl9yZWFkOChzdHJ1Y3QgaW50Zl9oZGwgKmludGZo
ZGwsIHUzMiBhZGRyKQ0KPiAgIAlpbmRleCA9IDA7DQo+ICAgCXd2YWx1ZSA9ICh1MTYpKGFk
ZHIgJiAweDAwMDBmZmZmKTsNCj4gICAJbGVuID0gMTsNCj4gLQlyODcxMl91c2JjdHJsX3Zl
bmRvcnJlcShpbnRmcHJpdiwgcmVxdWVzdCwgd3ZhbHVlLCBpbmRleCwgJmRhdGEsIGxlbiwN
Cj4gLQkJCQlyZXF1ZXN0dHlwZSk7DQo+ICsJc3RhdHVzID0gcjg3MTJfdXNiY3RybF92ZW5k
b3JyZXEoaW50ZnByaXYsIHJlcXVlc3QsIHd2YWx1ZSwgaW5kZXgsDQo+ICsJCQkJCSAmZGF0
YSwgbGVuLCByZXF1ZXN0dHlwZSk7DQo+ICsJaWYgKHN0YXR1cyA8IDApDQo+ICsJCXJldHVy
biAwOw0KDQpXYWl0LCBidXQgd2hhdCBhYm91dCBwYXJ0aWFsIHJlYWRzPyBJIHNlZSB0aGF0
IHI4NzEyX3VzYmN0cmxfdmVuZG9ycmVxKCkgDQp1c2VzIGB1c2JfY29udHJvbF9tc2coKWAg
d2hpY2ggY2FuIHJlYWQgbGVzcyBkYXRhIHRoYW4gd2FzIHJlcXVlc3RlZC4NCg0KU28gaGVy
ZSB5b3UgYXJlIGp1c3QgaGlkaW5nIHRoZXNlIGVycm9yIGJ5IHplcm9pbmcgZGF0YQ0KDQo+
ICAgCXJldHVybiAodTgpKGxlMzJfdG9fY3B1KGRhdGEpICYgMHgwZmYpOw0KPiAgIH0NCj4g
ICANCg0KQW5kIGFzIGkgc2FpZCBpbiBwcmV2aW91cyBlbWFpbDogY2FsbGVyIGNhbid0IHNl
ZSBhbiBlcnJvci4NCg0KSW1hZ2luZSBjYWxsZXIgd2FpdHMgZm9yIHNvbWUgcmVnaXN0ZXIg
dG8gYmVjb21lIDAuIENhbGxlciBzZWVzIHRoYXQgDQp1c2JfcmVhZDgoKSByZXR1cm5lZCAw
LiBJcyBpdCBhbiBlcnJvcj8gSXMgcmVnaXN0ZXIgcmVhbGx5IGJlY29tZSAwPw0KDQoNCkdl
bmVyaWMgcmVhZCBBUEkgcHJvdG90eXBlIGxvb2tzIGxpa2UgZm9sbG93aW5nOg0KDQppbnQg
cmVhZF9zb21ldGhpbmcoc3RydWN0IG15X2Nvb2xfZGV2ICpkZXYsIHZvaWQgKmRhdGEsIHNp
emVfdCBzaXplKTsNCg0KYW5kIGl0IHJldHVybnMgMCBvbiBzdWNjZXNzIGFuZCAtZXJybm8g
b24gZmFpbHVyZSBhbmQgZGF0YSByZXR1cm5lZCB2aWEgDQpwYXNzZWQgcG9pbnRlci4gU28s
IGlmIEFQSSByZXR1cm5lZCBhbiBlcnJvciBjYWxsZXIgc2hvdWxkIG5vdCB0b3VjaCANCkBk
YXRhLCBzaW5jZSBsaWtlbHkgaXQncyB1bmluaXRpYWxpemVkDQoNCg0KDQoNCldpdGggcmVn
YXJkcywNClBhdmVsIFNrcmlwa2luDQo=

--------------SFZh8FiyaemsHlRV1aEBrGn8--

--------------FJJcGAN0o9ZhkgJwa8w9rJRE
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEER3XL3TplLQE8Qi40bk1w61LbBA0FAmJ1EJ0FAwAAAAAACgkQbk1w61LbBA2u
MQ//TaiAIRra7rQavWcOEI4xTKjVtwrDSY3BiF/oI71eeosq0hpqIcE5ZEh0iyAyYu2Srl7PyU51
hQHGY8g2EAxv6LZRFFd3pEljQEzgxCuUrYFxA7NIWL/SgdRaV5ANPLTLtVi5S+eGrfmiK0lOBoWE
DMNNdEa5w3d8+myX8ndNrmu3WAS1GbOAHCn7mivVGWRuu/B+jgLKcfitcFjlkb79LkW4/5KsYpbV
n6FsAVKH5mtyrMK7jLXASjyRyQk+Czlhelxm7IBHyVuQ8hN/fybuN3FYiLpFe2aeSeTakkjn+1IH
xPvqSdxE5kkdH8X9r8VSyRqn1xISdQhS25/a9IgysNB67Ora4h9usMCNFj9vhuhiVBW/vE4DlcUO
ACYC9tst8h837wiF1GdeGV1kWwvF9E0h2r73uoaly5XuiEMoVUFK/DGxBQKxSpizXKf3avexY6lp
ncdOYnqJoM6USd48QRYHThLqOCOzvreXjo9ko4wjVj2ZcplqXNt1VYn7dwZihkv0TaBUvRgM5tYZ
Qp4UOUodNdy2Kcc6XkYvEQn7LRfHZI1t7ktUA3Jdymh23c6U0yFauuqLgptghk14J0HWI/xPoFrb
ZoTbys78mzlZGI6Ckss4oGGhJkfZ8CPgGJDSKccFgCjNujFZuE5YDTSTGlc9EtXHNfXloWH015Ak
5NI=
=R9Qa
-----END PGP SIGNATURE-----

--------------FJJcGAN0o9ZhkgJwa8w9rJRE--
