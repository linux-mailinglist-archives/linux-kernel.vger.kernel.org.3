Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38C651D739
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 14:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391616AbiEFMF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 08:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391609AbiEFMF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 08:05:57 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB397644FF
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 05:02:13 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id w19so12184769lfu.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 05:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to;
        bh=K7Vk2RGVrRCy30cK1Y/ttu7NoGtQ9PBn6qYa8UKo550=;
        b=FiAc4AkWmx2gGK2W4DlhulgwU7J1QEFJWjPkFVD0JPSHxOa1guJFVJkH67VHeLXVRW
         3L3WNMzn6l5uAKdE39TMVYsIBLYU76/1752QHLHhvzHfYoS9PBD6YsYOH6hyNu4HkvRU
         DuCfPQRYfT6t65U+gFqCDn/4m5bK7X3paOIjJUgVwsXzhdDh/DuRcLPdjG840UJVAISZ
         7FDka0xi1w4ETg+14gT8oAPxX6tD0dggcEpj1K56FcgDatz7B7VKtWKr4mwEj5WGw34k
         FLb3kgyMsRUBxvpFiqHtEzQc9eKiAkZ7pR1+oMFsNG/zCuGQaC9dImd9iRxFvVZgrJzJ
         Lrug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to;
        bh=K7Vk2RGVrRCy30cK1Y/ttu7NoGtQ9PBn6qYa8UKo550=;
        b=4owPwrpjxPElmTcnxA8DPAnSeUvTACs4RbHAmIiMtsA7mcPLQppUqz0THvBPHft3zl
         wWxJhHPyALTGAHtMvd98hQoLBfG1E4rqoB+fVPvjpPwZvkw/ceMFkMB5/AzpNUlpI6w6
         ojltfmMD+md+IPfkWX8zhPWQhqVsd8hNEsuy0nEDUwiH36c0mhB+GjN4BCDKIK3RH1Mr
         Eky5+ehfM/Ac6AoC2KF66DOFr9xXYLoHiQPhFBQcxvMW1uU/Y+4Qunl8t4FIlflLx/SL
         RbZoSbauCwTI33ALpEFet4yRSY/mEtHH1t1GhHVwh9UAbDyrMCkNNhh4iP7HiKo/WbUA
         VLAg==
X-Gm-Message-State: AOAM533YdoWOBI/9vfFeUT7c7otbvMy4ACiE1yLvHQ/zBc4sdKeMFlAq
        SfYegghKstRNERSKiqtdboM=
X-Google-Smtp-Source: ABdhPJz+vWr1fb0Vh6bkG+kOn++y4APV3wckrAXe40irG/2Mjl8jXGIcPbkLI5g8kp+vVp+8fNeD/Q==
X-Received: by 2002:a05:6512:3984:b0:473:a6ee:5ef2 with SMTP id j4-20020a056512398400b00473a6ee5ef2mr2253227lfu.416.1651838529800;
        Fri, 06 May 2022 05:02:09 -0700 (PDT)
Received: from [192.168.1.11] ([217.117.246.114])
        by smtp.gmail.com with ESMTPSA id g17-20020ac24d91000000b0047255d211d1sm655830lfe.256.2022.05.06.05.02.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 05:02:08 -0700 (PDT)
Message-ID: <a5483e41-b5f7-d86b-21b9-2a9c3e602855@gmail.com>
Date:   Fri, 6 May 2022 15:02:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/2] staging: rtl8712: fix uninit-value in
 r871xu_drv_init()
Content-Language: en-US
To:     Wang Cheng <wanngchenng@gmail.com>
Cc:     dan.carpenter@oracle.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <cover.1651760402.git.wanngchenng@gmail.com>
 <14c3886173dfa4597f0704547c414cfdbcd11d16.1651760402.git.wanngchenng@gmail.com>
 <46b89616-5ec7-fb04-f561-2647efd968c4@gmail.com>
 <20220506113320.gc6zryhm7uqnbva5@ppc.localdomain>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20220506113320.gc6zryhm7uqnbva5@ppc.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------bn7JyRrybmPrWB3R9z0ba4SS"
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
--------------bn7JyRrybmPrWB3R9z0ba4SS
Content-Type: multipart/mixed; boundary="------------0t0obMxZS1mkT8KtRvOSPtuU";
 protected-headers="v1"
From: Pavel Skripkin <paskripkin@gmail.com>
To: Wang Cheng <wanngchenng@gmail.com>
Cc: dan.carpenter@oracle.com, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Message-ID: <a5483e41-b5f7-d86b-21b9-2a9c3e602855@gmail.com>
Subject: Re: [PATCH v2 2/2] staging: rtl8712: fix uninit-value in
 r871xu_drv_init()
References: <cover.1651760402.git.wanngchenng@gmail.com>
 <14c3886173dfa4597f0704547c414cfdbcd11d16.1651760402.git.wanngchenng@gmail.com>
 <46b89616-5ec7-fb04-f561-2647efd968c4@gmail.com>
 <20220506113320.gc6zryhm7uqnbva5@ppc.localdomain>
In-Reply-To: <20220506113320.gc6zryhm7uqnbva5@ppc.localdomain>

--------------0t0obMxZS1mkT8KtRvOSPtuU
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgV2FuZywNCg0KT24gNS82LzIyIDE0OjMzLCBXYW5nIENoZW5nIHdyb3RlOg0KPiBPbiAy
Mi8wNS8wNiAxMDo0MUFNLCBQYXZlbCBTa3JpcGtpbiB3cm90ZToNCj4+IEhpIFdhbmcsDQo+
PiANCj4+IE9uIDUvNi8yMiAwNjoxNiwgV2FuZyBDaGVuZyB3cm90ZToNCj4+IA0KPj4gW3Nu
aXBdDQo+PiANCj4+ID4gDQo+PiA+IFJlcG9ydGVkLWFuZC10ZXN0ZWQtYnk6IHN5emJvdCs2
ZjVlY2QxNDQ4NTRjMGQ4NTgwYkBzeXprYWxsZXIuYXBwc3BvdG1haWwuY29tDQo+PiA+IFNp
Z25lZC1vZmYtYnk6IFdhbmcgQ2hlbmcgPHdhbm5nY2hlbm5nQGdtYWlsLmNvbT4NCj4+ID4g
LS0tDQo+PiA+ICAgZHJpdmVycy9zdGFnaW5nL3J0bDg3MTIvdXNiX2ludGYuYyB8IDYgKysr
LS0tDQo+PiA+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlv
bnMoLSkNCj4+ID4gDQo+PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvcnRsODcx
Mi91c2JfaW50Zi5jIGIvZHJpdmVycy9zdGFnaW5nL3J0bDg3MTIvdXNiX2ludGYuYw0KPj4g
PiBpbmRleCBlZTRjNjFmODVhMDcuLjUwZGNkM2VjYjY4NSAxMDA2NDQNCj4+ID4gLS0tIGEv
ZHJpdmVycy9zdGFnaW5nL3J0bDg3MTIvdXNiX2ludGYuYw0KPj4gPiArKysgYi9kcml2ZXJz
L3N0YWdpbmcvcnRsODcxMi91c2JfaW50Zi5jDQo+PiA+IEBAIC01MzgsMTMgKzUzOCwxMyBA
QCBzdGF0aWMgaW50IHI4NzF4dV9kcnZfaW5pdChzdHJ1Y3QgdXNiX2ludGVyZmFjZSAqcHVz
Yl9pbnRmLA0KPj4gPiAgIAkJfSBlbHNlIHsNCj4+ID4gICAJCQlBdXRvbG9hZEZhaWwgPSBm
YWxzZTsNCj4+ID4gICAJCX0NCj4+ID4gLQkJaWYgKCgobWFjWzBdID09IDB4ZmYpICYmICht
YWNbMV0gPT0gMHhmZikgJiYNCj4+ID4gKwkJaWYgKCghQXV0b2xvYWRGYWlsKSB8fA0KPj4g
PiArCQkgICAgKChtYWNbMF0gPT0gMHhmZikgJiYgKG1hY1sxXSA9PSAweGZmKSAmJg0KPj4g
PiAgIAkJICAgICAobWFjWzJdID09IDB4ZmYpICYmIChtYWNbM10gPT0gMHhmZikgJiYNCj4+
ID4gICAJCSAgICAgKG1hY1s0XSA9PSAweGZmKSAmJiAobWFjWzVdID09IDB4ZmYpKSB8fA0K
Pj4gPiAgIAkJICAgICgobWFjWzBdID09IDB4MDApICYmIChtYWNbMV0gPT0gMHgwMCkgJiYN
Cj4+ID4gICAJCSAgICAgKG1hY1syXSA9PSAweDAwKSAmJiAobWFjWzNdID09IDB4MDApICYm
DQo+PiA+IC0JCSAgICAgKG1hY1s0XSA9PSAweDAwKSAmJiAobWFjWzVdID09IDB4MDApKSB8
fA0KPj4gPiAtCQkgICAgICghQXV0b2xvYWRGYWlsKSkgew0KPj4gPiArCQkgICAgIChtYWNb
NF0gPT0gMHgwMCkgJiYgKG1hY1s1XSA9PSAweDAwKSkpIHsNCj4+IA0KPj4gDQo+PiBUaGF0
IGxvb2tzIHVnbHkuIEkgbWVhbiBtYWMgY2hlY2tzLiBDYW4gd2UsIHBsZWFzZSwgdXNlIHNh
bmUga2VybmVsIEFQSSBsaWtlDQo+PiBpc192YWxpZF9ldGhlcl9hZGRyKCk/DQo+IA0KPiBH
b29kIGlkZWEhIEJ1dCB3aWxsIGlzX3ZhbGlkX2V0aGVyX2FkZHIoKSBjaGVjayBhIGxhcmdl
ciByYW5nZT8NCj4gVGhlIGNvbW1lbnQgb2YgaXNfdmFsaWRfZXRoZXJfYWRkcigpKGluY2x1
ZGUvbGludXgvZXRoZXJkZXZpY2UuaCkgc2F5czoNCj4gICAgQ2hlY2sgdGhhdCB0aGUgRXRo
ZXJuZXQgYWRkcmVzcyAoTUFDKSBpcyBub3QgMDA6MDA6MDA6MDA6MDA6MDAsIGlzIG5vdA0K
PiAgICBhICptdWx0aWNhc3QgYWRkcmVzcyosIGFuZCBpcyBub3QgRkY6RkY6RkY6RkY6RkY6
RkYuDQo+IA0KDQpJIGFtIG5vdCBnb29kIGFuIGV4cGVydCBhdCBuZXR3b3JraW5nIHN0dWZm
LCBidXQgY2FuIG11bHRpY2FzdCBtYWMgDQphZGRyZXNzIGJlIHZhbGlkIGZvciBwdXJwb3Nl
IG9mIFdpLUZpIGFkYXB0ZXI/IElJVUMgaXQncyBjYW4ndCwgYnV0IGFzIEkgDQpzYWlkIGJl
Zm9yZSwgSSBhbSBub3QgYW4gZXhwZXJ0DQoNCg0KDQpXaXRoIHJlZ2FyZHMsDQpQYXZlbCBT
a3JpcGtpbg0K

--------------0t0obMxZS1mkT8KtRvOSPtuU--

--------------bn7JyRrybmPrWB3R9z0ba4SS
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEER3XL3TplLQE8Qi40bk1w61LbBA0FAmJ1Dj0FAwAAAAAACgkQbk1w61LbBA1q
fw/+OxI54ebjhrBJEMRhRQxaigqln4eLUmJ/ePWJOBKbdLm2O03b0TwxdRGMyI3Q/aZreuXIMd9K
tHeh9wDZLxnlBpxbH8OPeCkgouUdTUcPcVyZIE2Ew5N0pdlM8rcXj5QaYn91p71LDi96RQ6JJjgz
J0aiBqxbnj6RG1giYc64Y/4E+SSzomqLlW3azO0+QyV7fNnzWRUmt+u5z3jzl4UZXGFsV6mzzEHv
HcaWqDi+t3pnAXR1Q2COSal5TywNrrNurEWw4IjJ2zbU6Czx4Gm6Pn5OCh/rXxVLajKnqK0p0wby
rFe/FeGqxmv73bxwZHG3X3+m/BtWZLKoJk6wfkDEEod1162GhR2XZQDzxyS9M8imriYSABYTFoHp
NSDmJEnWwg1/dT6deuJ9CW4zIl6E6Rxk77RERhIlmUVRBymbqMpTPoJUM4K0w57MBbONlwfmTRxu
XBNIisdltZcaHST+wMr8FZ57Ix/4pcs6j3AKcnA+w9yYWIVEpLQB2zRF0e3xiltCPqVVGBhnUmlx
SPElEPjrv1OrLZhM3EswYsxi3obSji/SoZj/KoaeXnzC+GhC4cfvRN397n6+OzLQZlRnUShznXtq
h8qRbVyq/dz+8xKVUQqDafoH+OqvCVmA0bLc+Uc2/eDylr8dbddFJlGFdTwhS72PjpsB5L32Vu3B
ypU=
=gGru
-----END PGP SIGNATURE-----

--------------bn7JyRrybmPrWB3R9z0ba4SS--
