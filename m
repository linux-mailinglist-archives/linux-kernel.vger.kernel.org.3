Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C0E501C87
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 22:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346223AbiDNUU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 16:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240555AbiDNUU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 16:20:57 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A381EB0A0;
        Thu, 14 Apr 2022 13:18:31 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id t25so10990163lfg.7;
        Thu, 14 Apr 2022 13:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to;
        bh=vAtFfIdWA18bC09EVBAApspnA64cYo7p/tMAJvgKnUM=;
        b=jGGPE0wdZ1zZtd3wfVhoeC+8E/uvooW1X5lpFWMIvu5xZ83JrTZfEdWI0e2+jMAeWy
         JktXrApu6IG9kveScIQiy13HtyejvFiEcQMP6p7x4ouMGGJlMhC22mAY9BkRSfPKWOQZ
         u7opuOj7YyMeVMwtKuhWNrL6MDXdLCeLmm9gbQvjF7EFiy9VTJnKWpOO1j3J2CfMhK8v
         ASfPq6uvZ32BzTsz/tzXdI6qmHhsS1uTnrSlsUX0sM4LwuMocQLV6xGYTsaOJjYsDNWs
         P9sK3NQFJdNiithgM2IJ6YoITyIBqza/BY0R2mVVnnzenQ7awYLLoB0shygpeLpoOhei
         U5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to;
        bh=vAtFfIdWA18bC09EVBAApspnA64cYo7p/tMAJvgKnUM=;
        b=CdPDAnrj2zkHKu8vd05vatI0yIyL8+z6x0aZkFeK/WY11TztouI0k5utqA+FMOby4m
         uQ3RnHdhnCFIfqZwc434QwfBDZ0zXTjUzqRBqX/VDTa3PwA2QFYbWZehTyrrnIi+uhKK
         D+y22F9uzqtkLBZtbpm99gFQoZI9Q8bdI4UX+Zsbk9LpL5bInNSOzl/kqwmcWfiaNuWz
         avkBHt5Duj74e42PQ2QDFOPOLB8wfNfzY8Gc6RAR/27m7bWwAzyu1WFTe+EM8IQCTgX6
         yIMOr7dq5x6a17Pglk/ixDooHTmtCg1Ln23GFq4PbcbBtsh8mMoyTmcaLakoIXiJ9wkZ
         jiaA==
X-Gm-Message-State: AOAM532M+UH0itar/Ktdl+PKU7fI+63T32JI/2AK9J4UpJvJZgw8wyxr
        GRLOBf66PueT5YQ6e7bGQB9SvBrhhwFXAQ==
X-Google-Smtp-Source: ABdhPJwHnvGoFaCU3O8l3Es1MtMxAtYKO3qrz10KulIC0gs4cGbmUUbZo3kqKlppL4kCepIaBwgceQ==
X-Received: by 2002:a05:6512:2622:b0:448:27b9:5299 with SMTP id bt34-20020a056512262200b0044827b95299mr2844032lfb.86.1649967509660;
        Thu, 14 Apr 2022 13:18:29 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.225.17])
        by smtp.gmail.com with ESMTPSA id f4-20020a056512322400b0046bc4f9445bsm98921lfe.112.2022.04.14.13.18.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 13:18:29 -0700 (PDT)
Message-ID: <9ff91977-a6b5-90f9-3502-58ac641e1307@gmail.com>
Date:   Thu, 14 Apr 2022 23:18:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [syzbot] UBSAN: array-index-out-of-bounds in pvr2_i2c_core_init
Content-Language: en-US
To:     syzbot <syzbot+1a247e36149ffd709a9b@syzkaller.appspotmail.com>,
        isely@pobox.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, mchehab@kernel.org,
        syzkaller-bugs@googlegroups.com
References: <000000000000b48bc305dca2efcd@google.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <000000000000b48bc305dca2efcd@google.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------BJJnBnlb0Luoubk32YGs5Edl"
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------BJJnBnlb0Luoubk32YGs5Edl
Content-Type: multipart/mixed; boundary="------------GTsCy2LE4ruD00I7JXigx5KK";
 protected-headers="v1"
From: Pavel Skripkin <paskripkin@gmail.com>
To: syzbot <syzbot+1a247e36149ffd709a9b@syzkaller.appspotmail.com>,
 isely@pobox.com, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 mchehab@kernel.org, syzkaller-bugs@googlegroups.com
Message-ID: <9ff91977-a6b5-90f9-3502-58ac641e1307@gmail.com>
Subject: Re: [syzbot] UBSAN: array-index-out-of-bounds in pvr2_i2c_core_init
References: <000000000000b48bc305dca2efcd@google.com>
In-Reply-To: <000000000000b48bc305dca2efcd@google.com>

--------------GTsCy2LE4ruD00I7JXigx5KK
Content-Type: multipart/mixed; boundary="------------dLsDU9BLcGSMhKdGClvI2Mb0"

--------------dLsDU9BLcGSMhKdGClvI2Mb0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gNC8xNC8yMiAyMzoxNCwgc3l6Ym90IHdyb3RlOg0KPiBIZWxsbywNCj4gDQo+IHN5emJv
dCBoYXMgdGVzdGVkIHRoZSBwcm9wb3NlZCBwYXRjaCBidXQgdGhlIHJlcHJvZHVjZXIgaXMg
c3RpbGwgdHJpZ2dlcmluZyBhbiBpc3N1ZToNCj4gV0FSTklORyBpbiBwdnIyX2hkd19jcmVh
dGUNCj4gDQo+IHB2cnVzYjI6IEhhcmR3YXJlIGRlc2NyaXB0aW9uOiBPbkFpciBVU0IyIEh5
YnJpZCBVU0IgdHVuZXINCj4gLS0tLS0tLS0tLS0tWyBjdXQgaGVyZSBdLS0tLS0tLS0tLS0t
DQo+IFdBUk5JTkc6IENQVTogMSBQSUQ6IDM2MDcgYXQga2VybmVsL3dvcmtxdWV1ZS5jOjMw
NjYgX19mbHVzaF93b3JrKzB4OTI2LzB4YjEwIGtlcm5lbC93b3JrcXVldWUuYzozMDY2DQo+
IE1vZHVsZXMgbGlua2VkIGluOg0KPiBDUFU6IDEgUElEOiAzNjA3IENvbW06IGt3b3JrZXIv
MTo0IE5vdCB0YWludGVkIDUuMTguMC1yYzItc3l6a2FsbGVyLTAwMTg3LWcxMTVhY2JiNTY5
NzgtZGlydHkgIzANCj4gSGFyZHdhcmUgbmFtZTogR29vZ2xlIEdvb2dsZSBDb21wdXRlIEVu
Z2luZS9Hb29nbGUgQ29tcHV0ZSBFbmdpbmUsIEJJT1MgR29vZ2xlIDAxLzAxLzIwMTENCj4g
V29ya3F1ZXVlOiB1c2JfaHViX3dxIGh1Yl9ldmVudA0KPiBSSVA6IDAwMTA6X19mbHVzaF93
b3JrKzB4OTI2LzB4YjEwIGtlcm5lbC93b3JrcXVldWUuYzozMDY2DQo+IENvZGU6IGZmIDQx
IDg5IGM0IDg5IDhkIDg4IGZlIGZmIGZmIGU4IGQ1IDJiIDc3IDAwIDQ4IDBmIGJhIDJiIDAz
IGU5IDZhIGZhIGZmIGZmIGU4IGM2IDhmIDJiIDAwIDBmIDBiIGU5IDVhIGZjIGZmIGZmIGU4
IGJhIDhmIDJiIDAwIDwwZj4gMGIgNDUgMzEgZjYgZTkgNGIgZmMgZmYgZmYgZTggZWIgMjgg
NzcgMDAgZTkgM2EgZmIgZmYgZmYgZTggYTENCj4gUlNQOiAwMDE4OmZmZmZjOTAwMDNkMWVl
MDAgRUZMQUdTOiAwMDAxMDI5Mw0KPiANCg0KTm90IGJhZCBndWVzcy4NCg0KTW92aW5nIHdv
cmsgaW5pdGlhbGl6YXRpb24gdXBwZXIsIHNpbmNlIHJld3JpdGluZyBlcnJvciBoYW5kbGlu
ZyBpcyBib3JpbmcNCg0KDQojc3l6IHRlc3Q6DQpnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIv
c2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0IG1hc3Rlcg0KDQoNCg0K
DQpXaXRoIHJlZ2FyZHMsDQpQYXZlbCBTa3JpcGtpbg0K
--------------dLsDU9BLcGSMhKdGClvI2Mb0
Content-Type: text/plain; charset=UTF-8; name="ph"
Content-Disposition: attachment; filename="ph"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWVkaWEvdXNiL3B2cnVzYjIvcHZydXNiMi1oZHcuYyBi
L2RyaXZlcnMvbWVkaWEvdXNiL3B2cnVzYjIvcHZydXNiMi1oZHcuYwppbmRleCBjZDdiMTE4
ZDU5MjkuLmYzYTM4ZjEwNjIxMiAxMDA2NDQKLS0tIGEvZHJpdmVycy9tZWRpYS91c2IvcHZy
dXNiMi9wdnJ1c2IyLWhkdy5jCisrKyBiL2RyaXZlcnMvbWVkaWEvdXNiL3B2cnVzYjIvcHZy
dXNiMi1oZHcuYwpAQCAtMjU2OSw2ICsyNTY5LDExIEBAIHN0cnVjdCBwdnIyX2hkdyAqcHZy
Ml9oZHdfY3JlYXRlKHN0cnVjdCB1c2JfaW50ZXJmYWNlICppbnRmLAogCX0gd2hpbGUgKDAp
OwogCW11dGV4X3VubG9jaygmcHZyMl91bml0X210eCk7CiAKKwlJTklUX1dPUksoJmhkdy0+
d29ya3BvbGwscHZyMl9oZHdfd29ya2VyX3BvbGwpOworCisJaWYgKGhkdy0+dW5pdF9udW1i
ZXIgPT0gLTEpCisJCWdvdG8gZmFpbDsKKwogCWNudDEgPSAwOwogCWNudDIgPSBzY25wcmlu
dGYoaGR3LT5uYW1lK2NudDEsc2l6ZW9mKGhkdy0+bmFtZSktY250MSwicHZydXNiMiIpOwog
CWNudDEgKz0gY250MjsKQEAgLTI1ODAsOCArMjU4NSw2IEBAIHN0cnVjdCBwdnIyX2hkdyAq
cHZyMl9oZHdfY3JlYXRlKHN0cnVjdCB1c2JfaW50ZXJmYWNlICppbnRmLAogCWlmIChjbnQx
ID49IHNpemVvZihoZHctPm5hbWUpKSBjbnQxID0gc2l6ZW9mKGhkdy0+bmFtZSktMTsKIAlo
ZHctPm5hbWVbY250MV0gPSAwOwogCi0JSU5JVF9XT1JLKCZoZHctPndvcmtwb2xsLHB2cjJf
aGR3X3dvcmtlcl9wb2xsKTsKLQogCXB2cjJfdHJhY2UoUFZSMl9UUkFDRV9JTklULCJEcml2
ZXIgdW5pdCBudW1iZXIgaXMgJWQsIG5hbWUgaXMgJXMiLAogCQkgICBoZHctPnVuaXRfbnVt
YmVyLGhkdy0+bmFtZSk7CiAKQEAgLTI2MDAsNyArMjYwMyw3IEBAIHN0cnVjdCBwdnIyX2hk
dyAqcHZyMl9oZHdfY3JlYXRlKHN0cnVjdCB1c2JfaW50ZXJmYWNlICppbnRmLAogCW11dGV4
X2luaXQoJmhkdy0+YmlnX2xvY2tfbXV0ZXgpOwogCiAJcmV0dXJuIGhkdzsKLSBmYWlsOgor
ZmFpbDoKIAlpZiAoaGR3KSB7CiAJCWRlbF90aW1lcl9zeW5jKCZoZHctPnF1aWVzY2VudF90
aW1lcik7CiAJCWRlbF90aW1lcl9zeW5jKCZoZHctPmRlY29kZXJfc3RhYmlsaXphdGlvbl90
aW1lcik7Cg==

--------------dLsDU9BLcGSMhKdGClvI2Mb0--

--------------GTsCy2LE4ruD00I7JXigx5KK--

--------------BJJnBnlb0Luoubk32YGs5Edl
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEER3XL3TplLQE8Qi40bk1w61LbBA0FAmJYgZQFAwAAAAAACgkQbk1w61LbBA07
ThAAmJ8oaoF0cgoy4FYQkiitKsy+MA12VLu7nkNU6a0WuS4A6pBRYfcROTGsFAwJVQByF/wXOUd9
0nsgN0BJElulc8RC9X9IkEQqkA/jODsUrlVRAT/EaAN1u2d5mfZlKZNxwD1HYCjhsCUrkz+hy69U
GDpBDVlxCyFGSNnd3KFemf50DIoNUGwL0ewJa1vrT5g+cFechU7544v3o5xa5MpZwu8YOgN2DPl1
mK6G4wv15SHAHMkVgY1+HMOph4cWfUEBp9EYCCIfTXUBbAskBwZkjl8rWOWy6uCWKoZmMOecMC4D
DUPCdWf1MIER5zOvFIBFdLzwsQf2E8Sscz8YmOYoGHFHxgqkPcaOE8BVnefD9Xq8/Aw9R6o67Hye
eDer3K5TBdg1rpZ+KUNAtChSN6crzMPCU7ncOhcHB4YX1IjkUuIX1vSTOD37QqseztD+vkTfgST1
OdzW2NrX3HrLTgrNbS05TM5ACGyn2OttXDq9xHysFbWjyIS9B8N6AIifSyB5R1Cj9k9et6Teuemn
pASlvDPoTElw1qv6dYIkAhmch5DCA98coJKf2YAX8PCX3Q3x9ANGmF2wDDRzDN6JL1At5xFTcITx
XwVeVwNFtq4JtuYSj4rl4XjMEn/wjgIiB9Z7sgTZ8o9lBCnHpQfa4eJvZ+XTPgSKf0gpLA/77Ep6
qHM=
=crIi
-----END PGP SIGNATURE-----

--------------BJJnBnlb0Luoubk32YGs5Edl--
