Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3998551D7BC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 14:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392025AbiEFMdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 08:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391962AbiEFMcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 08:32:46 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7187B6AA4A
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 05:27:59 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id g16so9081242lja.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 05:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to;
        bh=7PZ/hV6GDLLZJg7GbrTdwE+sJ+7ZLoEDN0MM8ugfsCg=;
        b=gMPXOgWj7koZhFXbwMbp/RLkJBXE9UhCoKYDcXzKP9VV3c51uIERoUpz5nwnHE/qNN
         qihmqwFaDr5NLZ7XkR+xZBbtcJ5ETvUUKDhzxwNS9eURDmFvuvyFeeXVJu2TfAzeG5o+
         26/9akq0wleAJWg3j6ODIfDWuu1yWMrbPLN4mjV41y9eyRNa9rG4yXr8beKFvitJLG88
         AQL7n9Blx8RW13qveAwpManhzHhq7sbj5SMoh+4je3qpAnpvWuwCmTJyauMhkqhh4I8R
         KCFt9yM4Aqe85SrrYqwe2UVAaZwQm+3cc0c98EAGi6fUCMofpuRYfYxZRK/OAUGb/uVL
         do5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to;
        bh=7PZ/hV6GDLLZJg7GbrTdwE+sJ+7ZLoEDN0MM8ugfsCg=;
        b=AIaph7h9OeVa6GjdMLQ9ZU2fsgMVTLnl55g1KYs17nNK8R6RwB71OBzXttEMsoQu2l
         +mep7NiepNbdpz7lCURhNhn7V26XhDnrFxB/SZ7GW25E/zqpSv/IvSbBV4kxuHpkThdE
         AAVEejPZ5IicOqU7lZ+X6F1Z9RguZZ9NDIZy7kdP+OmqfuULDpasEb1znk/qIWNC5veL
         5anwp3hK2IhB4tJOeWpQotuIwvIIgVmq0tnLPRzyh52R5xgT/SWvs6GOBQjiSRqPAKlh
         6HKpclKvYzOkl2KZoTQuBAiCTLSdXlblMgyG8G64Z9SFGOD1gd50jntG3YzEikwA77F0
         JRpw==
X-Gm-Message-State: AOAM5331kakUbkjE9arczw1gNpGqQ5cSZ/ut4kDfJmXxFAz1vksKZoVS
        9I75fgy4k4g+8ixji2CQjns=
X-Google-Smtp-Source: ABdhPJwjoCAh7Oly+mOokOuY9CTlkkkcFQE0yEKTqYhhkwj2UXjkWPR0FPqDv/SH8gVkw7djAf/nVw==
X-Received: by 2002:a2e:a78f:0:b0:24f:53a4:fc with SMTP id c15-20020a2ea78f000000b0024f53a400fcmr1858207ljf.296.1651840077516;
        Fri, 06 May 2022 05:27:57 -0700 (PDT)
Received: from [192.168.1.11] ([217.117.246.114])
        by smtp.gmail.com with ESMTPSA id d14-20020a05651233ce00b0047255d21136sm669330lfg.101.2022.05.06.05.27.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 05:27:57 -0700 (PDT)
Message-ID: <9f0bf5e0-87e8-ce27-7c2d-8e247e7b5f4f@gmail.com>
Date:   Fri, 6 May 2022 15:27:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 2/3] staging: rtl8712: fix uninit-value in
 r871xu_drv_init()
Content-Language: en-US
To:     Wang Cheng <wanngchenng@gmail.com>, dan.carpenter@oracle.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1651833575.git.wanngchenng@gmail.com>
 <14c3886173dfa4597f0704547c414cfdbcd11d16.1651833575.git.wanngchenng@gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <14c3886173dfa4597f0704547c414cfdbcd11d16.1651833575.git.wanngchenng@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------kV2vvlvdgzPSm9WErIYZ8xjU"
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
--------------kV2vvlvdgzPSm9WErIYZ8xjU
Content-Type: multipart/mixed; boundary="------------cwvi4n4YiDQ988exxsUy9AMT";
 protected-headers="v1"
From: Pavel Skripkin <paskripkin@gmail.com>
To: Wang Cheng <wanngchenng@gmail.com>, dan.carpenter@oracle.com
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Message-ID: <9f0bf5e0-87e8-ce27-7c2d-8e247e7b5f4f@gmail.com>
Subject: Re: [PATCH v3 2/3] staging: rtl8712: fix uninit-value in
 r871xu_drv_init()
References: <cover.1651833575.git.wanngchenng@gmail.com>
 <14c3886173dfa4597f0704547c414cfdbcd11d16.1651833575.git.wanngchenng@gmail.com>
In-Reply-To: <14c3886173dfa4597f0704547c414cfdbcd11d16.1651833575.git.wanngchenng@gmail.com>

--------------cwvi4n4YiDQ988exxsUy9AMT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgV2FuZywNCg0KT24gNS82LzIyIDE0OjU5LCBXYW5nIENoZW5nIHdyb3RlOg0KPiBSZXBv
cnRlZC1hbmQtdGVzdGVkLWJ5OiBzeXpib3QrNmY1ZWNkMTQ0ODU0YzBkODU4MGJAc3l6a2Fs
bGVyLmFwcHNwb3RtYWlsLmNvbQ0KPiBTaWduZWQtb2ZmLWJ5OiBXYW5nIENoZW5nIDx3YW5u
Z2NoZW5uZ0BnbWFpbC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvc3RhZ2luZy9ydGw4NzEy
L3VzYl9pbnRmLmMgfCA2ICsrKy0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlv
bnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFn
aW5nL3J0bDg3MTIvdXNiX2ludGYuYyBiL2RyaXZlcnMvc3RhZ2luZy9ydGw4NzEyL3VzYl9p
bnRmLmMNCj4gaW5kZXggZWU0YzYxZjg1YTA3Li41MGRjZDNlY2I2ODUgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvc3RhZ2luZy9ydGw4NzEyL3VzYl9pbnRmLmMNCj4gKysrIGIvZHJpdmVy
cy9zdGFnaW5nL3J0bDg3MTIvdXNiX2ludGYuYw0KPiBAQCAtNTM4LDEzICs1MzgsMTMgQEAg
c3RhdGljIGludCByODcxeHVfZHJ2X2luaXQoc3RydWN0IHVzYl9pbnRlcmZhY2UgKnB1c2Jf
aW50ZiwNCj4gICAJCX0gZWxzZSB7DQo+ICAgCQkJQXV0b2xvYWRGYWlsID0gZmFsc2U7DQo+
ICAgCQl9DQo+IC0JCWlmICgoKG1hY1swXSA9PSAweGZmKSAmJiAobWFjWzFdID09IDB4ZmYp
ICYmDQo+ICsJCWlmICgoIUF1dG9sb2FkRmFpbCkgfHwNCj4gKwkJICAgICgobWFjWzBdID09
IDB4ZmYpICYmIChtYWNbMV0gPT0gMHhmZikgJiYNCj4gICAJCSAgICAgKG1hY1syXSA9PSAw
eGZmKSAmJiAobWFjWzNdID09IDB4ZmYpICYmDQo+ICAgCQkgICAgIChtYWNbNF0gPT0gMHhm
ZikgJiYgKG1hY1s1XSA9PSAweGZmKSkgfHwNCj4gICAJCSAgICAoKG1hY1swXSA9PSAweDAw
KSAmJiAobWFjWzFdID09IDB4MDApICYmDQo+ICAgCQkgICAgIChtYWNbMl0gPT0gMHgwMCkg
JiYgKG1hY1szXSA9PSAweDAwKSAmJg0KPiAtCQkgICAgIChtYWNbNF0gPT0gMHgwMCkgJiYg
KG1hY1s1XSA9PSAweDAwKSkgfHwNCj4gLQkJICAgICAoIUF1dG9sb2FkRmFpbCkpIHsNCj4g
KwkJICAgICAobWFjWzRdID09IDB4MDApICYmIChtYWNbNV0gPT0gMHgwMCkpKSB7DQo+ICAg
CQkJbWFjWzBdID0gMHgwMDsNCj4gICAJCQltYWNbMV0gPSAweGUwOw0KPiAgIAkJCW1hY1sy
XSA9IDB4NGM7DQoNCkhtbSwNCg0KdGhlIHdob2xlIHI4NzF4dV9kcnZfaW5pdCgpIGxvb2tz
IG9kZCwgYnV0IGl0J3MgdW5yZWxhdGVkLg0KDQpJIHNlZSB0aGF0IHRoaXMgcGF0Y2ggZG9l
cyBub3QgaGVscCB3aXRoIGJlbG93IGtlcm5lbCBwYXRoDQoNCnI4NzF4dV9kcnZfaW5pdCgp
DQogICBpZiAodG1wVTFiICYgX0VFUFJPTV9FTikgPC0gdHJ1ZSBbMV0NCglpZiAoIXI4NzEy
X2luaXRtYWMgfHwgIW1hY19wdG9uKHI4NzEyX2luaXRtYWMsIG1hYykpIDwtICgqKQ0KCQlp
ZiAoKCFBdXRvbG9hZEZhaWwpIHx8CTwtIGZhbHNlLCBzaW5jZSBbMV0gYnJhbmNoIHRha2Vu
DQoJCQlbY29kZSB0b3VjaGVzIHN0YWNrIGRhdGFdDQoNCigqKSBmYWxzZSBiZWNhdXNlIG9m
IHI4NzEyX2luaXRtYWMgaXMgZXF1YWwgdG8gTlVMTA0KDQoNCkkgc2F3LCB0aGF0IHN5emJv
dCBzYWlkIE9LIG9uIHlvdXIgcGF0Y2gsIGJ1dCBpdCdzIGJlY2F1c2UgeW91IGhhdmUganVz
dCANCmhpZGVkIGFuIGVycm9yIGluc2lkZSByZWFkIEFQSQ0KDQoNCg0KV2l0aCByZWdhcmRz
LA0KUGF2ZWwgU2tyaXBraW4NCg==

--------------cwvi4n4YiDQ988exxsUy9AMT--

--------------kV2vvlvdgzPSm9WErIYZ8xjU
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEER3XL3TplLQE8Qi40bk1w61LbBA0FAmJ1FEwFAwAAAAAACgkQbk1w61LbBA0L
hQ//bguLeqWng+fhFqRlYDg+BYyrFuumqplIiZuq3yg+83gz2OMI0y3SNRxzscRVY/kmkHQs5wWC
DnNls1r861TroawbpQXXur5jRFolXZ3q04le2d14sEYHCgz2q7JZSHrdOxuBKndbZZsuFeKHk9ms
RzDbg4puQ062Yk5V2tjQO4bib2C4FGlFLLlmiAbEgJj/iAbTXrexDvtRwX7k+xtKXtPIXOKJIlyb
GWzPl12rW6gCEoYVftGBDhoREAhB6o9pVYtahTTpClRfGbyuBKumI76y4PTo5csLGxJ3GuzTmpGJ
o0s9xWLBfpYDMC3tw1A8neBAaTEOPf+kylP/vwF57zeSRzjD2WbMBKIf49HSpgm352jXCGeBx5UN
04OpxF1IhYGRmUSaT9RqQuWsONTLN1sK+2TeIae2cEPdjFirv7iX5fJPp3Enw22Yk/1VkdNOGlEp
vCJ3qltmQDa2sylwrOaZHrUfrjdpzDM+u/LtiLRYIG7MJ0m4xthq4nV0tzOEAoL1zjfdjz3MwSzp
Zwmk9Kpqs12fXnPQXpcfxKOuFwqvZCLjmMLLidMPVPH/kjqaBMNCFfqxGmZBZATEC/0VnwX/1muh
T29SdGwXBxUZcciDxXO6npOyRSprFHGRgfZWTFs7nh6XIHnO6L3EwgpZC0qFLoiXggs6n4LBFtEL
rQY=
=6Ib9
-----END PGP SIGNATURE-----

--------------kV2vvlvdgzPSm9WErIYZ8xjU--
