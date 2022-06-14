Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB06B54BAFB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 21:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbiFNTxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 15:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349829AbiFNTxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 15:53:30 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070A335A9D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 12:53:29 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id j20so10927148ljg.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 12:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to;
        bh=ZLxgom5g1jrS0n4H42Ud+kQMNKQ+7GbbdBbd6Asgiq8=;
        b=cIaLsymmckzG/dC0HPTqbRe0GjfjEnoQi8Xc3DdoZhT0ggSpafkdBEgk+IhM074iwD
         OmGKzwG5OlGFkj3dg9sV2gyDZ1kg9XNjdjGnKnxam8PCNEaeGRL/6lz0JyBSr8QLys2a
         6suJQEwIab63ruxwTh4Rld5NTW6JwjHpQOIRkvWuSbWwZAmA2dhYgSTZE/jdlqwiFqsA
         Cv5x4AjYkZRsFcxo5jfB6/gklzYS1RCFImCBdGdglDfp/ytIETqHdpdleP/penueShYG
         mJA3rDCwQuQ7JUB6pj4YdNqfe6FMNHYJqBVRXTEJx90N0a8vgNQYFH6irh9cqonwKgZm
         Cvcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to;
        bh=ZLxgom5g1jrS0n4H42Ud+kQMNKQ+7GbbdBbd6Asgiq8=;
        b=e8I1GEtdFJZyDn4k3C+FUuYQGGI/4jOhgCnwZLxAll+CUhjyaI7b8mrDAPvwQJ7J3f
         uCloJTt+0U7BOC4F9O4vR26UMC5xf24P6qo6BbDgHieBpHXgUxG5z2uOjASWD9VrOFoZ
         shly5GUMYu2SBydimiY94vAorPTx/tWJYkWNSbqzy4IIr1MHWnTP71omgsrh0fqPoaKN
         xDL5Y5f33Q4WfflVhUZtfWYt54QtbPMZKtOiDkDg+QSuf1HNUPtlH4dzYypFan9VCBJR
         g4RxDWVCWAN1pWBRSzcMLqzJd61ZsFy0zHlRh0S2sxq5RL0zyxSQCGwW8MGFgwzsRzba
         Ixsg==
X-Gm-Message-State: AJIora9ekIM9WxV/+6lq1KHz94b/RNqKXt3tI251t9VZEW+X1O5oFGZr
        2M79mfqzJwodYLEHE+6legXUh6PTeWs=
X-Google-Smtp-Source: AGRyM1uMXHthEpOq2+sQirHZ4pvj0A3xPPkJRxrygZDKdcug1KCvjdA+R+qq7kt6JjDMk+Cy+E3gog==
X-Received: by 2002:a2e:954e:0:b0:255:3768:9986 with SMTP id t14-20020a2e954e000000b0025537689986mr3549987ljh.516.1655236407088;
        Tue, 14 Jun 2022 12:53:27 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.229.27])
        by smtp.gmail.com with ESMTPSA id n6-20020a056512388600b0047c8ae642d5sm1505267lft.99.2022.06.14.12.53.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 12:53:26 -0700 (PDT)
Message-ID: <a47b250f-4008-321d-fca6-73f766115a8b@gmail.com>
Date:   Tue, 14 Jun 2022 22:53:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [syzbot] KASAN: stack-out-of-bounds Read in __show_regs
Content-Language: en-US
To:     syzbot <syzbot+b17d3e853d5dce65f981@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000ebb59305e16d1627@google.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <000000000000ebb59305e16d1627@google.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------3DXHU2mT1UMOQMT8VHtRpUuN"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------3DXHU2mT1UMOQMT8VHtRpUuN
Content-Type: multipart/mixed; boundary="------------gCLNlPWu3jF0gAKKm8gg96TM";
 protected-headers="v1"
From: Pavel Skripkin <paskripkin@gmail.com>
To: syzbot <syzbot+b17d3e853d5dce65f981@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Message-ID: <a47b250f-4008-321d-fca6-73f766115a8b@gmail.com>
Subject: Re: [syzbot] KASAN: stack-out-of-bounds Read in __show_regs
References: <000000000000ebb59305e16d1627@google.com>
In-Reply-To: <000000000000ebb59305e16d1627@google.com>

--------------gCLNlPWu3jF0gAKKm8gg96TM
Content-Type: multipart/mixed; boundary="------------jU5FeDM6M2JktTY6AkBKIl8B"

--------------jU5FeDM6M2JktTY6AkBKIl8B
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgU3l6Ym90LA0KDQpPbiA2LzE0LzIyIDIyOjA1LCBzeXpib3Qgd3JvdGU6DQo+IHN5emJv
dCBoYXMgZm91bmQgYSByZXByb2R1Y2VyIGZvciB0aGUgZm9sbG93aW5nIGlzc3VlIG9uOg0K
PiANCj4gSEVBRCBjb21taXQ6ICAgIDJmMzA2NDU3NDI3NSBSRUFETUUubWQ6IE9SQyBpcyBu
byBtb3JlIGEgcHJvYmxlbQ0KPiBnaXQgdHJlZTogICAgICAgaHR0cHM6Ly9naXRodWIuY29t
L2dvb2dsZS9rbXNhbi5naXQgbWFzdGVyDQo+IGNvbnNvbGUgb3V0cHV0OiBodHRwczovL3N5
emthbGxlci5hcHBzcG90LmNvbS94L2xvZy50eHQ/eD0xNjlhMjMxMDA4MDAwMA0KPiBrZXJu
ZWwgY29uZmlnOiAgaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20veC8uY29uZmlnP3g9
OGU2MjkzNTI5NTMxZTljYQ0KPiBkYXNoYm9hcmQgbGluazogaHR0cHM6Ly9zeXprYWxsZXIu
YXBwc3BvdC5jb20vYnVnP2V4dGlkPWIxN2QzZTg1M2Q1ZGNlNjVmOTgxDQo+IGNvbXBpbGVy
OiAgICAgICBjbGFuZyB2ZXJzaW9uIDE1LjAuMCAoaHR0cHM6Ly9naXRodWIuY29tL2xsdm0v
bGx2bS1wcm9qZWN0LmdpdCA5ZmZiNTk0NGE2OTliNmEwZDY5YzE2OWNlZmY5NzYzNjM5NWVl
MzBmKSwgR05VIGxkIChHTlUgQmludXRpbHMgZm9yIERlYmlhbikgMi4zNS4yDQo+IHN5eiBy
ZXBybzogICAgICBodHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS94L3JlcHJvLnN5ej94
PTE0OTE3YzJmZjAwMDAwDQo+IEMgcmVwcm9kdWNlcjogICBodHRwczovL3N5emthbGxlci5h
cHBzcG90LmNvbS94L3JlcHJvLmM/eD0xMzAzNzUyZmYwMDAwMA0KPiANCj4gSU1QT1JUQU5U
OiBpZiB5b3UgZml4IHRoZSBpc3N1ZSwgcGxlYXNlIGFkZCB0aGUgZm9sbG93aW5nIHRhZyB0
byB0aGUgY29tbWl0Og0KPiBSZXBvcnRlZC1ieTogc3l6Ym90K2IxN2QzZTg1M2Q1ZGNlNjVm
OTgxQHN5emthbGxlci5hcHBzcG90bWFpbC5jb20NCj4gDQo+IEhhcmR3YXJlIG5hbWU6IEdv
b2dsZSBHb29nbGUgQ29tcHV0ZSBFbmdpbmUvR29vZ2xlIENvbXB1dGUgRW5naW5lLCBCSU9T
IEdvb2dsZSAwMS8wMS8yMDExDQo+IFJJUDogMDAxMDpqMTkzOV9zZXNzaW9uX2RlYWN0aXZh
dGUgbmV0L2Nhbi9qMTkzOS90cmFuc3BvcnQuYzoxMDkwIFtpbmxpbmVdDQo+IFJJUDogMDAx
MDpqMTkzOV9zZXNzaW9uX2RlYWN0aXZhdGVfYWN0aXZhdGVfbmV4dCsweDI3MS8weDQ4MCBu
ZXQvY2FuL2oxOTM5L3RyYW5zcG9ydC5jOjExMDANCj4gQ29kZTogZjQgZTkgZWQgZmQgZmYg
ZmYgOGIgN2QgZDQgZTggZmIgMzEgMTMgZjQgZTkgMjQgZmUgZmYgZmYgNDQgODkgZmYgZTgg
ZWUgMzEgMTMgZjQgNDEgODMgZmMgMDIgMGYgODMgNjggZmUgZmYgZmYgZTggZGYgNzAgODIg
ZjMgPDBmPiAwYiBlOSA2MSBmZSBmZiBmZiA4YiA3ZCBkNCBlOCBkMCAzMSAxMyBmNCBlOSA2
OCBmZSBmZiBmZiA0NCA4OQ0KPiBSU1A6IDAwMTg6ZmZmZjg4ODEwMmUzZjVjOCBFRkxBR1M6
IDAwMDEwMjQ2DQo+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09DQo+IEJVRzogS01TQU46IHVuaW5pdC12YWx1ZSBpbiBfX3Nob3dfcmVn
cysweGU2LzB4MTA0MCBhcmNoL3g4Ni9rZXJuZWwvcHJvY2Vzc182NC5jOjc2DQoNClRoaXMg
YnVnIGxvb2tzIHVucmVsYXRlZCB0byBpbml0aWFsIGBzdGFjay1vdXQtb2YtYm91bmRzIFJl
YWQgaW4gDQpfX3Nob3dfcmVnc2ANCg0KPiAgIF9fc2hvd19yZWdzKzB4ZTYvMHgxMDQwIGFy
Y2gveDg2L2tlcm5lbC9wcm9jZXNzXzY0LmM6NzYNCj4gICBzaG93X3JlZ3MrMHhjMC8weDE2
MCBhcmNoL3g4Ni9rZXJuZWwvZHVtcHN0YWNrLmM6NDYzDQo+ICAgX193YXJuKzB4M2MyLzB4
NzMwIGtlcm5lbC9wYW5pYy5jOjU5Ng0KPiAgIHJlcG9ydF9idWcrMHg4ZWIvMHhhZTAgbGli
L2J1Zy5jOjE5OQ0KPiAgIGhhbmRsZV9idWcrMHg0MS8weDcwIGFyY2gveDg2L2tlcm5lbC90
cmFwcy5jOjMxNQ0KPiAgIGV4Y19pbnZhbGlkX29wKzB4MWIvMHg1MCBhcmNoL3g4Ni9rZXJu
ZWwvdHJhcHMuYzozMzUNCj4gICBhc21fZXhjX2ludmFsaWRfb3ArMHgxMi8weDIwDQo+ICAg
ajE5Mzlfc2Vzc2lvbl9kZWFjdGl2YXRlX2FjdGl2YXRlX25leHQrMHgyNzEvMHg0ODAgbmV0
L2Nhbi9qMTkzOS90cmFuc3BvcnQuYzoxMTAwDQo+ICAgajE5MzlfeHRwX3J4X2Fib3J0X29u
ZSsweDg2MS8weDkwMCBuZXQvY2FuL2oxOTM5L3RyYW5zcG9ydC5jOjEzNDANCj4gICBqMTkz
OV94dHBfcnhfYWJvcnQgbmV0L2Nhbi9qMTkzOS90cmFuc3BvcnQuYzoxMzUxIFtpbmxpbmVd
DQo+ICAgajE5MzlfdHBfY21kX3JlY3YgbmV0L2Nhbi9qMTkzOS90cmFuc3BvcnQuYzoyMTAw
IFtpbmxpbmVdDQo+ICAgajE5MzlfdHBfcmVjdisweDE1MzQvMHgxY2QwIG5ldC9jYW4vajE5
MzkvdHJhbnNwb3J0LmM6MjEzMw0KPiAgIGoxOTM5X2Nhbl9yZWN2KzB4ZWQwLzB4MTA3MCBu
ZXQvY2FuL2oxOTM5L21haW4uYzoxMDgNCj4gICBkZWxpdmVyIG5ldC9jYW4vYWZfY2FuLmM6
NTc0IFtpbmxpbmVdDQo+ICAgY2FuX3Jjdl9maWx0ZXIrMHg3NGIvMHgxMTEwIG5ldC9jYW4v
YWZfY2FuLmM6NjA4DQo+ICAgY2FuX3JlY2VpdmUrMHg0ZmIvMHg2ZDAgbmV0L2Nhbi9hZl9j
YW4uYzo2NjUNCj4gICBjYW5fcmN2KzB4MWYwLzB4NDkwIG5ldC9jYW4vYWZfY2FuLmM6Njk2
DQo+ICAgX19uZXRpZl9yZWNlaXZlX3NrYl9vbmVfY29yZSBuZXQvY29yZS9kZXYuYzo1NDA1
IFtpbmxpbmVdDQo+ICAgX19uZXRpZl9yZWNlaXZlX3NrYisweDFmMS8weDY0MCBuZXQvY29y
ZS9kZXYuYzo1NTE5DQo+ICAgcHJvY2Vzc19iYWNrbG9nKzB4NGU3LzB4YjUwIG5ldC9jb3Jl
L2Rldi5jOjU4NDcNCj4gICBfX25hcGlfcG9sbCsweDE0ZS8weGI4MCBuZXQvY29yZS9kZXYu
Yzo2NDEzDQo+ICAgbmFwaV9wb2xsIG5ldC9jb3JlL2Rldi5jOjY0ODAgW2lubGluZV0NCj4g
ICBuZXRfcnhfYWN0aW9uKzB4N2U4LzB4MTgzMCBuZXQvY29yZS9kZXYuYzo2NTY3DQo+ICAg
X19kb19zb2Z0aXJxKzB4MjA2LzB4ODA5IGtlcm5lbC9zb2Z0aXJxLmM6NTU4DQo+ICAgcnVu
X2tzb2Z0aXJxZCsweDM3LzB4NTAga2VybmVsL3NvZnRpcnEuYzo5MjENCj4gICBzbXBib290
X3RocmVhZF9mbisweDYyNi8weGJmMCBrZXJuZWwvc21wYm9vdC5jOjE2NA0KPiAgIGt0aHJl
YWQrMHgzYzcvMHg1MDAga2VybmVsL2t0aHJlYWQuYzozNzYNCj4gICByZXRfZnJvbV9mb3Jr
KzB4MWYvMHgzMA0KPiANCj4gTG9jYWwgdmFyaWFibGUgbWljIGNyZWF0ZWQgYXQ6DQo+ICAg
aWVlZTgwMjExX3J4X2hfbWljaGFlbF9taWNfdmVyaWZ5KzB4NTQvMHgxMGYwIG5ldC9tYWM4
MDIxMS93cGEuYzoxMDANCj4gICBpZWVlODAyMTFfcnhfaGFuZGxlcnMrMHgyZDMxLzB4ZjE3
MCBuZXQvbWFjODAyMTEvcnguYzozOTI5DQo+IA0KDQpBbnl3YXksIGxvb2tzIGxpa2UgbWlz
c2luZyBlcnJvciBoYW5kbGluZyBvZiBtaWNoYWVsX21pYy4gYG1pY2hhZWxfbWljYCANCm1h
eSBmYWlsIGluIGEgbG90IG9mIGNhc2VzIGFuZCBtaWMgd2lsbCBiZSB1bmluaXRpYWxpemVk
IGluIGNhc2Ugb2YgDQptaWNoYWVsX21pYyBmYWlsdXJlLg0KDQoNCiNzeXogdGVzdDogaHR0
cHM6Ly9naXRodWIuY29tL2dvb2dsZS9rbXNhbi5naXQgbWFzdGVyDQoNCg0KDQoNCldpdGgg
cmVnYXJkcywNClBhdmVsIFNrcmlwa2luDQo=
--------------jU5FeDM6M2JktTY6AkBKIl8B
Content-Type: text/plain; charset=UTF-8; name="ph"
Content-Disposition: attachment; filename="ph"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL25ldC9tYWM4MDIxMS93cGEuYyBiL25ldC9tYWM4MDIxMS93cGEuYwpp
bmRleCA1ZmQ4YTNlOGI1YjQuLjJiYTAwNWRmZDYxNCAxMDA2NDQKLS0tIGEvbmV0L21hYzgw
MjExL3dwYS5jCisrKyBiL25ldC9tYWM4MDIxMS93cGEuYwpAQCAtMTU5LDcgKzE1OSw4IEBA
IGllZWU4MDIxMV9yeF9oX21pY2hhZWxfbWljX3ZlcmlmeShzdHJ1Y3QgaWVlZTgwMjExX3J4
X2RhdGEgKnJ4KQogCWRhdGEgPSBza2ItPmRhdGEgKyBoZHJsZW47CiAJZGF0YV9sZW4gPSBz
a2ItPmxlbiAtIGhkcmxlbiAtIE1JQ0hBRUxfTUlDX0xFTjsKIAlrZXkgPSAmcngtPmtleS0+
Y29uZi5rZXlbTkw4MDIxMV9US0lQX0RBVEFfT0ZGU0VUX1JYX01JQ19LRVldOwotCW1pY2hh
ZWxfbWljKGtleSwgaGRyLCBkYXRhLCBkYXRhX2xlbiwgbWljKTsKKwlpZiAobWljaGFlbF9t
aWMoa2V5LCBoZHIsIGRhdGEsIGRhdGFfbGVuLCBtaWMpIDwgMCkKKwkJZ290byBtaWNfZmFp
bDsKIAlpZiAoY3J5cHRvX21lbW5lcShtaWMsIGRhdGEgKyBkYXRhX2xlbiwgTUlDSEFFTF9N
SUNfTEVOKSkKIAkJZ290byBtaWNfZmFpbDsKIAo=

--------------jU5FeDM6M2JktTY6AkBKIl8B--

--------------gCLNlPWu3jF0gAKKm8gg96TM--

--------------3DXHU2mT1UMOQMT8VHtRpUuN
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEER3XL3TplLQE8Qi40bk1w61LbBA0FAmKo5zQFAwAAAAAACgkQbk1w61LbBA1n
XRAAo+1ZUwiVI00EHtu0h+U+y5qxG7YVCvFvKyzTo5g2KFCb3eA5fvZFoUoxs4dz/a0wxQAFhlzS
rG73KspGHWFbPaEpsR2aeh8canmpRWzKSaUL0Xij4l8RXFzHoNo6/dxsMYcD7cF+/6TekdtvYsZz
1S9JtUYsJ2kw+lWEvPhi+4mP5nXoSS2Y241TmHCRjZ78HNWT6HI0dYmZO5WhmPy0+jtkYl83Ub3P
k/KIiFeuwRy2zwsU2lK3+nglD9B0wvmnigdQYzEKibZipnhdREZZUlaYI88o2n5pfftJfn4t8N2g
Kl/SWP05rn5OE0NTR7mCv9bmyoznpE63vvfaocrBueJI0nvzzuKsOfK2YmVEXq9LmlZrkSAOfLCC
ltzCrJLdf/j5WKI3fEK9yf/2uQH/lxoi6jRpV0NOpYjWckQKWTdbGkTz+o37SL7Ixmzh7fCOHFZ/
Ipoz0tg6XyB1wgngrWwkudmPosmpLutVeh6mpaAyKzrvBzmy/xIyxGXplno2rL5bZx9goMq1eso5
KzH66aoeAvhA0A7qoQaaR3n0X4xNkLM2blge9KtfTkYXqfgnTu+GLDGb1W4qwuR74L22bH+I5jB/
RhtN6Jj0J+ZvbIEdkTJVxnsN4eZMMOnuQwsWeqq0CVkMX0xdh5z1LNTuh4zcaMSccVH9wOqIjXeG
J+Y=
=1jcz
-----END PGP SIGNATURE-----

--------------3DXHU2mT1UMOQMT8VHtRpUuN--
