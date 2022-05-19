Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4A352CBA2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 07:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbiESFtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 01:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiESFtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 01:49:02 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AC5BA998
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 22:49:01 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id l13so583671lfp.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 22:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to;
        bh=peOhkg9g/SR7ONyeisgfjz80C4clFhjwNajd1oZKUZc=;
        b=STnFvKRFRQ/s/FF7doanQ1jN8sXXfkhYbn5lO3GJdogCN118rhknAi04n10M8M2sHd
         NpyekZmFeNMFUz1Lpm6vv6AkVyBOpUHL2A7ya/r0m0iOczFSH4fU9KUZgEOhjqkifWH8
         GA5W3xqR8cZ/Fek8vZaXxzLS1D7iT3TeMArp9U2PkmMa6FhN9ca1C8qFcp2J4Gndc4KH
         KBuCbjYj7mB7WvTq5zRUEya99fTDQ38/0SQl0p5QpF5GeJ5e7GAGozjybkQYRiGOwbW5
         HSBB2n4aibKVQZUq7UHGT4ew2segq4Vynr9Su1Dz1uNzbo3Cd+8pQgBXjM2ZvLUUk39C
         I1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to;
        bh=peOhkg9g/SR7ONyeisgfjz80C4clFhjwNajd1oZKUZc=;
        b=W036DqFSx3+Uab4KO0FUCMuL3XKX1jHpsWLqt4JbdQrJ9YEs5/EazAIOUARpyrNwKz
         86+/5KG1lN6vl8loRiuoUKwlGE1KL3LCyMTYGZtmSutj10T8nmkh6xH0OzVAIsuHEvXQ
         L2yeRGiOZVMcqSFmQ+KZXxETC9eQT3JPVi0jyf2uiHs4eZN9QGNXiQpqXfGuaJvWAklJ
         F12EMZyE+++mZU19xv89VRYn+ogtN+Zsi7mY3/0TlwzLdgrqpqib9mPG24K0kPMgPn8D
         cZxIaKE2OanBudi1ObrPvluhoXxOwSpJM8pXtmP3ngVQDpzR+6yCjTRpa3PRlxcLMHWw
         PMIw==
X-Gm-Message-State: AOAM531dpNcEtubBAbQ1CNtjuH+0ijcM2P8cRfjC7oe9PZke94uJ4YwU
        bqJaVxKrh5mqcJ8OmLLRHHo=
X-Google-Smtp-Source: ABdhPJxyhShYeSNt1m6fN5CYIh6TCQwZuH+LL4Y01DzU+ZEf1TsUbjN5UekG3cAjSpwDIDdbGIxRMg==
X-Received: by 2002:ac2:4a78:0:b0:472:2106:4b94 with SMTP id q24-20020ac24a78000000b0047221064b94mr2072494lfp.632.1652939339945;
        Wed, 18 May 2022 22:48:59 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.67.4])
        by smtp.gmail.com with ESMTPSA id b10-20020ac247ea000000b00477b2fa5d30sm159300lfp.96.2022.05.18.22.48.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 22:48:59 -0700 (PDT)
Message-ID: <46d39974-05ae-193a-7602-556fbf28fa48@gmail.com>
Date:   Thu, 19 May 2022 08:48:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 3/4] staging: r8188eu: add error handling of rtw_read32
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com,
        fmdefrancesco@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
References: <cover.1652911343.git.paskripkin@gmail.com>
 <5cab10528fed7d440ee57f93183d18c9de998adb.1652911343.git.paskripkin@gmail.com>
 <20220519054356.GU4009@kadam>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20220519054356.GU4009@kadam>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------8I26OPU0qP7r9K9JYyPaS9dr"
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------8I26OPU0qP7r9K9JYyPaS9dr
Content-Type: multipart/mixed; boundary="------------7QQ376naFXwNyWnyQwu5yHNl";
 protected-headers="v1"
From: Pavel Skripkin <paskripkin@gmail.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
 phil@philpotter.co.uk, straube.linux@gmail.com, fmdefrancesco@gmail.com,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Message-ID: <46d39974-05ae-193a-7602-556fbf28fa48@gmail.com>
Subject: Re: [PATCH 3/4] staging: r8188eu: add error handling of rtw_read32
References: <cover.1652911343.git.paskripkin@gmail.com>
 <5cab10528fed7d440ee57f93183d18c9de998adb.1652911343.git.paskripkin@gmail.com>
 <20220519054356.GU4009@kadam>
In-Reply-To: <20220519054356.GU4009@kadam>

--------------7QQ376naFXwNyWnyQwu5yHNl
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgRGFuLA0KDQpPbiA1LzE5LzIyIDA4OjQzLCBEYW4gQ2FycGVudGVyIHdyb3RlOg0KPiBP
biBUaHUsIE1heSAxOSwgMjAyMiBhdCAwMToxMjowMUFNICswMzAwLCBQYXZlbCBTa3JpcGtp
biB3cm90ZToNCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvcjgxODhldS9jb3Jl
L3J0d19lZnVzZS5jIGIvZHJpdmVycy9zdGFnaW5nL3I4MTg4ZXUvY29yZS9ydHdfZWZ1c2Uu
Yw0KPj4gaW5kZXggYTI2OTFjN2Y5NmY2Li43MTA1MTIyYzJiYTAgMTAwNjQ0DQo+PiAtLS0g
YS9kcml2ZXJzL3N0YWdpbmcvcjgxODhldS9jb3JlL3J0d19lZnVzZS5jDQo+PiArKysgYi9k
cml2ZXJzL3N0YWdpbmcvcjgxODhldS9jb3JlL3J0d19lZnVzZS5jDQo+PiBAQCAtNDcsOSAr
NDcsMTggQEAgUmVhZEVGdXNlQnl0ZSgNCj4+ICANCj4+ICAJLyogQ2hlY2sgYml0IDMyIHJl
YWQtcmVhZHkgKi8NCj4+ICAJcmV0cnkgPSAwOw0KPj4gLQl2YWx1ZTMyID0gcnR3X3JlYWQz
MihBZGFwdGVyLCBFRlVTRV9DVFJMKTsNCj4+IC0Jd2hpbGUgKCEoKCh2YWx1ZTMyID4+IDI0
KSAmIDB4ZmYpICYgMHg4MCkgICYmIChyZXRyeSA8IDEwMDAwKSkgew0KPj4gLQkJdmFsdWUz
MiA9IHJ0d19yZWFkMzIoQWRhcHRlciwgRUZVU0VfQ1RSTCk7DQo+PiArCXJlcyA9IHJ0d19y
ZWFkMzIoQWRhcHRlciwgRUZVU0VfQ1RSTCwgJnZhbHVlMzIpOw0KPj4gKwlpZiAocmVzKQ0K
Pj4gKwkJcmV0dXJuOw0KPj4gKw0KPj4gKwl3aGlsZSAocmV0cnkgPCAxMDAwMCkgew0KPj4g
KwkJcmVzID0gcnR3X3JlYWQzMihBZGFwdGVyLCBFRlVTRV9DVFJMLCAmdmFsdWUzMik7DQo+
PiArCQlpZiAocmVzKQ0KPj4gKwkJCWNvbnRpbnVlOw0KPiANCj4gRm9yZXZlciBsb29wLiAg
QWx3YXlzIHB1dCB0aGUgKysgaW4gc2lkZSB0aGUgd2hpbGUgKCkuICBBcHBhcmVudGx5LA0K
PiBTbWF0Y2ggZG9lcyBub3QgY2F0Y2ggdGhpcy4gICNJZGVhICNPcHB1cnR1bml0eQ0KPiAN
Cg0KSSBoYXZlIG1pc3NlZCBpdCBldmVyeSBzaW5nbGUgbG9vcC4uLiA6KA0KDQpUaGF0J3Mg
d2h5IEkgZG9uJ3QgbGlrZSAnd2hpbGUnIGxvb3BzLCAnZm9yJyBzdWl0cyBtdWNoIGJldHRl
ciBmb3IgdGhpcyANCmtpbmQgb2YgdGhpbmdzLg0KDQoNClRoYW5rcyB5b3UgZm9yIHlvdXIg
cmV2aWV3ISBXaWxsIGFkZHJlc3MgeW91ciBjb21tZW50cyBpbiBuZXh0IHZlcnNpb24NCg0K
DQoNCg0KV2l0aCByZWdhcmRzLA0KUGF2ZWwgU2tyaXBraW4NCg==

--------------7QQ376naFXwNyWnyQwu5yHNl--

--------------8I26OPU0qP7r9K9JYyPaS9dr
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEER3XL3TplLQE8Qi40bk1w61LbBA0FAmKF2koFAwAAAAAACgkQbk1w61LbBA0U
Wg/+O/hoj2xPE7uEVscF462XvyCZJXaJqdsYCEJPE7+SBviieh1pcx13O7YhIHNhQXDVLHObD6mX
JcLJgUcHVJBZpJJ0Mw1rhhbbnEbmjtILNRNgXK+FAfPpkqAW4rdc+3AnHLLY3v9oGdUMh/GdTeeg
kM6O/W1XMAqwiAVM0280vZPNYEAiEralWRa0FH5vE2lAqHXF5Z5/BhCdeVZy+c7htyJTPQzt/4xK
5/aGNEFKVT9Yio/8keWqkOtXKBGFDlh76C95fzIoJdsrJmxa5w53ZGHRhv84C9TZKNPL3IrlKxlQ
oTkuiJEh9w4BV+qfLbfQoeC7R3LaKOxX7eJV9wxmQKBVrpnQVeqB2zreNpt8ix31tGOGadFg3koU
6RldGSXyUcfj1FXw7MuTsdHllj674aqHsOX9Gxs27H7KVSvm2JBDdRYzm3IUV1WluHEo93ddoc/x
/9TQkBv8xT2DVNFVbTJYFqKAGawn50jPv18QLURFh5MW5/9shMhtY4pSwla3MHKdI2h7DXhjbE0F
fLPgzyMosmn+KP97Xld9eQip+bp2H/tB4iXVvZK2TBo8HPzibtexa8Jdb3Zlz3YE/wEgf+DnVLhw
jqmNwuU2uirTNOGy7lvD+Dtd8sUvsXN6e9nadByGDe2bWr0MSElEMUi/TE/X6+4cRE48XjMR5NC4
oH4=
=p/Hs
-----END PGP SIGNATURE-----

--------------8I26OPU0qP7r9K9JYyPaS9dr--
