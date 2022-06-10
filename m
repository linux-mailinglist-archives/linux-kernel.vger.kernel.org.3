Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181265466FE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 15:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235903AbiFJNBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 09:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiFJNBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 09:01:13 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CE7A868F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 06:01:11 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id d18so1129665ljc.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 06:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to;
        bh=JgJmFQ1BbdQmytnpz2iACzkWEtXpChCcsCIr5cGBRFc=;
        b=XBCn4NFLO5ByQWK/r7OTZ9MpLK5JMwCLHwQn4TnQqcVhs0HUZHgmTaK2nFwlDONGQH
         9D2Lj15nQArj95XvVsgqHrvEOtMm7N0I4HawU5sX5xVnUtd2Zk5xJZSRvpVR4pyoxbOh
         92FLfRhucc5ngHNYZW/G9tHiUSRjUiq/6xygn5qwzQzFQTjfE38UPp7R1FKp2fpjLDEn
         dtR7pMb1bV85NjOgMQx+ld6dcuZfE+FLO0oorXMF4m7ZJTfq0D1wSDBtKmiQZebpSmgw
         VKHLokis50te8nAmoECBer51PyhNQUsjX8LI1SMudA0gvqoyn6HMX7dXFMPPmZglCNYW
         aXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to;
        bh=JgJmFQ1BbdQmytnpz2iACzkWEtXpChCcsCIr5cGBRFc=;
        b=CY5P6eE/kZEiykVdULmIalOO14kg/fH+wDaxW34DRStT9Iv8vtmtyhv6UEPMS/YYbS
         4bmOr6e54H2gvq3SrZ81jsgy0NqA4m3Ax15E5ejqf6R6bgbgy3fvdi4VGA7o7iRUfiva
         suWkH5is+5hiffivRuv/UlP16bslo3/wBbHDn86uFsAc6vj1vPGQ4Rnxm4zjs8MxnXw2
         +gB58n22ayEYcpiPlmqiV+vzkA18E+EJfrT9jpWPaHKuzTLJXLdY/7aHnQWB8yiqwce3
         /2CpTegzcbyOYd6t64gMFrMry2zxhZYUrtv8YjlKvvJQkaokd2nQJiIIW1Px9nLoTjBr
         75RQ==
X-Gm-Message-State: AOAM532DIziTKZk5R4WF4d6ZoqeXvTtGJfLXk9Clr+s7C8lo64d0A7Jd
        tCh8sGVXw3WpPa8eA1nRGqI=
X-Google-Smtp-Source: ABdhPJywdUD8C8uJlVBglmZRKACYf8SnrA4KpX0fypfncj+57v1ib2kVTLe/r87TUeYne7WDsL8ulA==
X-Received: by 2002:a2e:5745:0:b0:255:7ae4:c7da with SMTP id r5-20020a2e5745000000b002557ae4c7damr20783468ljd.70.1654866068947;
        Fri, 10 Jun 2022 06:01:08 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.229.27])
        by smtp.gmail.com with ESMTPSA id w20-20020a2e9994000000b0024f3d1dae9csm4136493lji.36.2022.06.10.06.01.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 06:01:08 -0700 (PDT)
Message-ID: <2ee8f6fc-aec1-39a6-e8db-56e5e449ee8e@gmail.com>
Date:   Fri, 10 Jun 2022 16:01:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v5 1/2] ath9k: fix use-after-free in ath9k_hif_usb_rx_cb
Content-Language: en-US
To:     Hillf Danton <hdanton@sina.com>
Cc:     toke@toke.dk, linux-kernel@vger.kernel.org,
        syzbot+c6dde1f690b60e0b9fbe@syzkaller.appspotmail.com
References: <20220522041542.2911-1-hdanton@sina.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20220522041542.2911-1-hdanton@sina.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------JNgkFVSzrWFbeL04HYjxLKaB"
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
--------------JNgkFVSzrWFbeL04HYjxLKaB
Content-Type: multipart/mixed; boundary="------------KVyCCa8ljfLSQdKBabUVtuy5";
 protected-headers="v1"
From: Pavel Skripkin <paskripkin@gmail.com>
To: Hillf Danton <hdanton@sina.com>
Cc: toke@toke.dk, linux-kernel@vger.kernel.org,
 syzbot+c6dde1f690b60e0b9fbe@syzkaller.appspotmail.com
Message-ID: <2ee8f6fc-aec1-39a6-e8db-56e5e449ee8e@gmail.com>
Subject: Re: [PATCH v5 1/2] ath9k: fix use-after-free in ath9k_hif_usb_rx_cb
References: <20220522041542.2911-1-hdanton@sina.com>
In-Reply-To: <20220522041542.2911-1-hdanton@sina.com>

--------------KVyCCa8ljfLSQdKBabUVtuy5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgSGlsbGYsDQoNCk9uIDUvMjIvMjIgMDc6MTUsIEhpbGxmIERhbnRvbiB3cm90ZToNCj4g
DQo+IEluIHRoZSBjYWxsIGNoYWluIGJlbG93DQo+IA0KPiAJYXRoOWtfaGlmX3VzYl9maXJt
d2FyZV9jYigpDQo+IAkgIGF0aDlrX2h0Y19od19hbGxvYygpDQo+IAkgIGF0aDlrX2hpZl91
c2JfZGV2X2luaXQoKQ0KPiAJICByZXQgPSBhdGg5a19odGNfaHdfaW5pdCgpDQo+IAkgICAg
ICAgICAgYXRoOWtfaHRjX3Byb2JlX2RldmljZSgpDQo+IAkJICAgIGh0Y19oYW5kbGUtPmRy
dl9wcml2ID0gcHJpdjsNCj4gCQkgICAgcmV0ID0gYXRoOWtfaHRjX3dhaXRfZm9yX3Rhcmdl
dChwcml2KTsNCj4gCQkgICAgaWYgKHJldCkNCj4gCQkJZ290byBlcnJfZnJlZTsNCj4gCSAg
aWYgKHJldCkNCj4gCQlnb3RvIGVycl9odGNfaHdfaW5pdDsNCj4gDQo+IGVycl9mcmVlOg0K
PiAJaWVlZTgwMjExX2ZyZWVfaHcoaHcpOw0KPiANCj4gDQo+IGVycl9odGNfaHdfaW5pdDoN
Cj4gCWF0aDlrX2hpZl91c2JfZGV2X2RlaW5pdChoaWZfZGV2KTsNCj4gCSAgYXRoOWtfaGlm
X3VzYl9kZWFsbG9jX3VyYnMoKQ0KPiBlcnJfZGV2X2luaXQ6DQo+IAlhdGg5a19odGNfaHdf
ZnJlZShoaWZfZGV2LT5odGNfaGFuZGxlKTsNCj4gZXJyX2Rldl9hbGxvYzoNCj4gCXJlbGVh
c2VfZmlybXdhcmUoZncpOw0KPiBlcnJfZnc6DQo+IAlhdGg5a19oaWZfdXNiX2Zpcm13YXJl
X2ZhaWwoaGlmX2Rldik7DQo+IA0KPiANCj4gaHcgc2hvdWxkIHN1cnZpdmUgZGVhbGxvY2F0
aW5nIHVyYnMsIGFuZCBjaGFuZ2VzIHNob3VsZCBiZSBhZGRlZCBpbnN0ZWFkIHRvDQo+IHRo
ZSByb2xsYmFjayBpbiBhdGg5a19odGNfcHJvYmVfZGV2aWNlKCkgYnkgZGVmZXJyaW5nIGNs
ZWFudXAgb2YgaHcgdG8gaXRzDQo+IGNhbGxzaXRlIGluIGFkZGl0aW9uIHRvIHVyYnMuDQo+
IA0KDQpEb24ndCBnZXQgaXQsIHNvcnJ5LiBJIGFtIG5vdCBjaGFuZ2luZyB0aGUgbGlmZSB0
aW1lIG9mIGBod2AsIEkgYW0ganVzdCANCmRlZmVycmluZyBodGNfaGFuZGxlLT5kcnZfcHJp
diBpbml0aWFsaXphdGlvbi4NCg0KDQoNCg0KV2l0aCByZWdhcmRzLA0KUGF2ZWwgU2tyaXBr
aW4NCg==

--------------KVyCCa8ljfLSQdKBabUVtuy5--

--------------JNgkFVSzrWFbeL04HYjxLKaB
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEER3XL3TplLQE8Qi40bk1w61LbBA0FAmKjQJIFAwAAAAAACgkQbk1w61LbBA1k
xw/+Ifb/UBils+iRORLckbyzbaSm/hs/ANdrGJJgnf6f9KR818T9IThhG3MpOXkKOK9CHuiA4nYp
La46Rnu8I6SYGYEd76cgiSTbJdjkw4LTq3hDByTXx2Y8uQfcI4y8urrTCQClpo9/p17X9pCyIEfd
CLZhLE4vFg/2fJXptGwoVBAbA8O1RW+1NUFgeCKmOiImkc+kdnzNsKcE3BnY2iJOF7rgvAZwo6l8
lQiVdUoyKfRF1PtDuhzBfnj3IbXtEG1BSG3bejELAuycIUVJMmund3YoV/kCy3hP34+GDAKFYTLn
gwZSzjciYbFyU1lVfbjWWzKbWfDSYlFznJwAWzVH79GCoOx0OWZmGvzIWHkFiqK6u9v0tddHOPvX
gMqj1ab6S80UHppqMu7R+YHbytZ5Sjmxr/ZP3BOzZ7kcQP2M8sJU34vQD2nJEqwf86P1t3Z0LXVk
oLI6X9rISjniMQAiAzXFL1J/IVeJHqf98TRFKmc5AL8ADozt1wfzuaVSeElLE4ujdszcJZoyQCwF
Lux42Lel5i2nyfN6/H9iZmlgbk0jCM6DLzGxSohx32NVkIYtv8WX5qAlmf88Zz+XUP3L4ym7wgzx
cX5Sewl0EUo+OKTP4waClw+jZDC2Shs5mUMPNfTepYmeCnml03wIimkK0aWqeuxC7KYgYdYhaLez
MAo=
=vm+1
-----END PGP SIGNATURE-----

--------------JNgkFVSzrWFbeL04HYjxLKaB--
