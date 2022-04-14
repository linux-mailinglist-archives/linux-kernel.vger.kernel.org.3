Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1489501C59
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 22:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346068AbiDNUGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 16:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345049AbiDNUGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 16:06:47 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4FFDD972;
        Thu, 14 Apr 2022 13:04:19 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id n17so2469465ljc.11;
        Thu, 14 Apr 2022 13:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to;
        bh=g4kANU1VrK5acPJfKF6VYK1C9MNjlYkxbsqsZ+dk1U8=;
        b=SbibftoqrxWV6J74m1gNZFi5thbDewd2r8zTQBKR+BB+F+KD+q4rVf05zXQKo9iXTu
         Y1hQ6MAkc9EKxb7xP2kbsLfiJx+a8AilKBu1O3LQFeA+IDFkS1otQUKWVlUW3FHX/RxW
         5CPrQxlT+vkGMKlzfqERsvXAmIN9WTsX/hs4qR9CUM1itGAuTz1BQ3Z4yZcqqvPHRu1/
         aJ4NPcdSqa+wOucLiAJ2gU+fmJkNSy89IeHc4+yOXxCAeM+vWmnGO10L8iRVZkEUHh3t
         Y20+2oRWK2DnEW7DxSgUZ0ZH3z7tN45+IS6/IR/vhoWNhkZdTvNwA16YJ0TTHmn8ThgL
         VXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to;
        bh=g4kANU1VrK5acPJfKF6VYK1C9MNjlYkxbsqsZ+dk1U8=;
        b=P/23Wa9qyoNMYvAqEAebEBtUV8hwfyRuIxqfYKOq734NgKwptT2LKSSwYSNAdpqljC
         6m4Ii3YGYDKWioyMb2qRYRBAoNEtIkmJ9NpKTxeNIDZf4J0ZFBO0WoasPUE5Hs+V6nSt
         RO6Rj9e/u0BWKwHvdWlGHc73O9gBcTEH2UQjs7Q+6DyO28Sv0ZC0ycDEGCFiehPbXqqt
         VXMwFSFSn71CFtj4oBSV90L6Wlz752hop7Q5y1SUGgbCoMarul+QaeMNCOWj2+fT+f26
         Mws1v+u/qRFyC0JlQBUgCFNgQI+cAxUfD7l1d0c0zpqJnttuwqGqWIfSYOy8cubWU2NA
         QDmA==
X-Gm-Message-State: AOAM533WVfFqP31Q7cP5Zk9ILApCN2hsXGpOL1smdoBUu3LQJxz/y4yz
        nm/McD1NJvgXq2L/pPX1/8M=
X-Google-Smtp-Source: ABdhPJyNduebeKAYirHCHZy0TMHnJfN8W2+1JamFviOCGGg/rCftjpXGvo9ro7uxahUNdMIzmaIoVw==
X-Received: by 2002:a05:651c:b29:b0:24b:6aaf:f200 with SMTP id b41-20020a05651c0b2900b0024b6aaff200mr2565867ljr.168.1649966657409;
        Thu, 14 Apr 2022 13:04:17 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.225.17])
        by smtp.gmail.com with ESMTPSA id z1-20020a0565120c0100b00447a7c10e4dsm96776lfu.31.2022.04.14.13.04.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 13:04:16 -0700 (PDT)
Message-ID: <88a47762-fac7-6158-1730-344bb2905fc9@gmail.com>
Date:   Thu, 14 Apr 2022 23:04:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [syzbot] UBSAN: array-index-out-of-bounds in pvr2_i2c_core_init
Content-Language: en-US
To:     syzbot <syzbot+1a247e36149ffd709a9b@syzkaller.appspotmail.com>,
        isely@pobox.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, mchehab@kernel.org,
        syzkaller-bugs@googlegroups.com
References: <0000000000005abf2305dca1b91b@google.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <0000000000005abf2305dca1b91b@google.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------1f0fk0wUrqaOEQ48gXJZmBL0"
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
--------------1f0fk0wUrqaOEQ48gXJZmBL0
Content-Type: multipart/mixed; boundary="------------VmOfhKFvgmUO7hSsgrL0vC8P";
 protected-headers="v1"
From: Pavel Skripkin <paskripkin@gmail.com>
To: syzbot <syzbot+1a247e36149ffd709a9b@syzkaller.appspotmail.com>,
 isely@pobox.com, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 mchehab@kernel.org, syzkaller-bugs@googlegroups.com
Message-ID: <88a47762-fac7-6158-1730-344bb2905fc9@gmail.com>
Subject: Re: [syzbot] UBSAN: array-index-out-of-bounds in pvr2_i2c_core_init
References: <0000000000005abf2305dca1b91b@google.com>
In-Reply-To: <0000000000005abf2305dca1b91b@google.com>

--------------VmOfhKFvgmUO7hSsgrL0vC8P
Content-Type: multipart/mixed; boundary="------------KR92So9sVH1iAdRDL7JOqcYI"

--------------KR92So9sVH1iAdRDL7JOqcYI
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgU3l6Ym90LA0KDQpPbiA0LzE0LzIyIDIxOjQ3LCBzeXpib3Qgd3JvdGU6DQo+IEhlbGxv
LA0KPiANCj4gc3l6Ym90IGZvdW5kIHRoZSBmb2xsb3dpbmcgaXNzdWUgb246DQo+IA0KPiBI
RUFEIGNvbW1pdDogICAgNGVhM2M2NDI1MjY5IE1lcmdlIHRhZyAncG93ZXJwYy01LjE4LTIn
IG9mIGdpdDovL2dpdC5rZXJuZS4uDQo+IGdpdCB0cmVlOiAgICAgICB1cHN0cmVhbQ0KPiBj
b25zb2xlIG91dHB1dDogaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20veC9sb2cudHh0
P3g9MTQ4Y2I4MjRmMDAwMDANCj4ga2VybmVsIGNvbmZpZzogIGh0dHBzOi8vc3l6a2FsbGVy
LmFwcHNwb3QuY29tL3gvLmNvbmZpZz94PTMwN2JhZWNmZDVlODdjZWQNCj4gZGFzaGJvYXJk
IGxpbms6IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL2J1Zz9leHRpZD0xYTI0N2Uz
NjE0OWZmZDcwOWE5Yg0KPiBjb21waWxlcjogICAgICAgZ2NjIChEZWJpYW4gMTAuMi4xLTYp
IDEwLjIuMSAyMDIxMDExMCwgR05VIGxkIChHTlUgQmludXRpbHMgZm9yIERlYmlhbikgMi4z
NS4yDQo+IHN5eiByZXBybzogICAgICBodHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS94
L3JlcHJvLnN5ej94PTE3Mjc5YTcwZjAwMDAwDQo+IEMgcmVwcm9kdWNlcjogICBodHRwczov
L3N5emthbGxlci5hcHBzcG90LmNvbS94L3JlcHJvLmM/eD0xMjFkYzEyNGYwMDAwMA0KPiAN
Cj4gQmlzZWN0aW9uIGlzIGluY29uY2x1c2l2ZTogdGhlIGlzc3VlIGhhcHBlbnMgb24gdGhl
IG9sZGVzdCB0ZXN0ZWQgcmVsZWFzZS4NCj4gDQo+IGJpc2VjdGlvbiBsb2c6ICBodHRwczov
L3N5emthbGxlci5hcHBzcG90LmNvbS94L2Jpc2VjdC50eHQ/eD0xNDI3NTNkZjcwMDAwMA0K
PiBmaW5hbCBvb3BzOiAgICAgaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20veC9yZXBv
cnQudHh0P3g9MTYyNzUzZGY3MDAwMDANCj4gY29uc29sZSBvdXRwdXQ6IGh0dHBzOi8vc3l6
a2FsbGVyLmFwcHNwb3QuY29tL3gvbG9nLnR4dD94PTEyMjc1M2RmNzAwMDAwDQo+IA0KPiBJ
TVBPUlRBTlQ6IGlmIHlvdSBmaXggdGhlIGlzc3VlLCBwbGVhc2UgYWRkIHRoZSBmb2xsb3dp
bmcgdGFnIHRvIHRoZSBjb21taXQ6DQoNCg0KanVzdCBndWVzc2luZw0KDQoNCiNzeXogdGVz
dDoNCmdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2
YWxkcy9saW51eC5naXQgbWFzdGVyDQoNCg0KDQoNCldpdGggcmVnYXJkcywNClBhdmVsIFNr
cmlwa2luDQo=
--------------KR92So9sVH1iAdRDL7JOqcYI
Content-Type: text/plain; charset=UTF-8; name="ph"
Content-Disposition: attachment; filename="ph"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWVkaWEvdXNiL3B2cnVzYjIvcHZydXNiMi1oZHcuYyBi
L2RyaXZlcnMvbWVkaWEvdXNiL3B2cnVzYjIvcHZydXNiMi1oZHcuYwppbmRleCBjZDdiMTE4
ZDU5MjkuLjJhMWEwYTBjYTIyNSAxMDA2NDQKLS0tIGEvZHJpdmVycy9tZWRpYS91c2IvcHZy
dXNiMi9wdnJ1c2IyLWhkdy5jCisrKyBiL2RyaXZlcnMvbWVkaWEvdXNiL3B2cnVzYjIvcHZy
dXNiMi1oZHcuYwpAQCAtMjU2OSw2ICsyNTY5LDkgQEAgc3RydWN0IHB2cjJfaGR3ICpwdnIy
X2hkd19jcmVhdGUoc3RydWN0IHVzYl9pbnRlcmZhY2UgKmludGYsCiAJfSB3aGlsZSAoMCk7
CiAJbXV0ZXhfdW5sb2NrKCZwdnIyX3VuaXRfbXR4KTsKIAorCWlmIChoZHctPnVuaXRfbnVt
YmVyID09IC0xKQorCSAgCWdvdG8gZmFpbDsKKwogCWNudDEgPSAwOwogCWNudDIgPSBzY25w
cmludGYoaGR3LT5uYW1lK2NudDEsc2l6ZW9mKGhkdy0+bmFtZSktY250MSwicHZydXNiMiIp
OwogCWNudDEgKz0gY250MjsK

--------------KR92So9sVH1iAdRDL7JOqcYI--

--------------VmOfhKFvgmUO7hSsgrL0vC8P--

--------------1f0fk0wUrqaOEQ48gXJZmBL0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEER3XL3TplLQE8Qi40bk1w61LbBA0FAmJYfj8FAwAAAAAACgkQbk1w61LbBA1S
2hAAsSCDq9Yv0tQK2KjATljoi6L3CbL9ocJQbncn8VEM/Qk+BAnVT/GcZqiv6sBc2nZSF8GLJR5u
XXpodO0lGisa/wHLtVMixTxPP9YcSWhoyyY2D5sobEQVjh0Sn5mEXfuGc5y7J1BJJdd/Tpd5DtaM
GPN+1ic7KS9lwffJ+W3TC8/gES+jDtggcErTIW2juhBPsjrfHm4xyT63wxqrtTcgE3gBiu3+Dwl2
/wQYhG9jqGvrK8TbaM5e0hhmLq2+fxt5X/wQfpsFHHuYpGee4RsR+PmoOQ7cqsm13Pie5DNg8Pmk
qRl3jsnyfqnJcB+Q3T1M7mLmvkQ+cRGtHebSL3+VVbjY8A5KgRtsJDZr7tnkAAkfQAvMaIB97J7W
tX/rGgwNKsdvUMj3bEMN3pD6KDt+NjOIziArRUXqYhQSdINLA/+6QjL/ma5e839VWaeQON2UP77K
/Fp/eyaXu/rahOcQYSLPnMkntllzKBJfgzuOpNXQCDZt5+huDaB09awG+8hqoYX1LvujBrtf4hgG
91Cp0SyEM1yPxme0fvLLqxB4DWueYUneBeOLv5cwT+vyPu+ToN28vR0tjpFHm2tReHu78rW09bfx
Ig4dPfTFFiR0SV5dTso9x60ly3aVcTuAIjND7ecgNv7ejcKYtiebUymkrYVnhGihBVuLndStkoiW
FG4=
=NSZE
-----END PGP SIGNATURE-----

--------------1f0fk0wUrqaOEQ48gXJZmBL0--
