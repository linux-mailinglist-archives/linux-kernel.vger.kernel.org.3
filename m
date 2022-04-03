Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E584F0980
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 14:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358240AbiDCMrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 08:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357593AbiDCMrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 08:47:47 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4C137002
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 05:45:53 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id b21so2057765lfb.5
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 05:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to;
        bh=xlsY5r2nglBsMWJUdySSrJiJJXcQpr5JPOvALISjTM4=;
        b=OIZAowJljiV+zy99qIdwj5PLH+4xbGpavxkWt08LMxmcbI+ZqkZE26/4zCJ1lx8eUv
         kP/q9tfUL0nYhMmkwe6NQnlI1I/qsciYhVOyI4kaZZ44HfkqOBeiZELYZcQRQA3xPNF+
         xV5VhrF5gEZ+jdfesVy4m7ZQJq2EW39D8l4A/cM0zeCu+yvZUqlBnmutKtG6c/n4miHB
         PrEcYVpZ89Thg98sqH8gQZ4fwpRzoo1kmkc0knM9QgenYToWSMrFOdWaXfAC7AFn0dJ/
         rvvd2Bo4jdaiFQMPBhdFv7zK7A+me+MeTwecv/dV88FS2S8EhqYItcW7860TxAVKH4C5
         BlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to;
        bh=xlsY5r2nglBsMWJUdySSrJiJJXcQpr5JPOvALISjTM4=;
        b=Dc7zf0a0onfefcIZ1ba2ifYJGvaKh69EFCmyodWHVKQnqdcCWKLmnG6F/aNQdUM8HA
         bghcB0b9NXx5X/J6LIM/EcVZ7HGxMofChjtvwG1kjCbw7A59MsvPwVACjZ/nFSxQnvUc
         iSimcTsvO2kMjl6h9j+1U0eSJ2A0ViOBnwVHUuxqgDzBqhiXapOb3rty6g45H1Bp8XLv
         ARGithwWkTGcuyNfbWhzte2IWpgxpYlG0LD0wSDYbrYJy/gIqNHd/LIbLUqOIu35Ua9z
         2jeg2A7sC6ESlWGMo0ZRiLpc7hf3GoKOZv3QTDZwlFHCRSaAQBj3MkJblU/WxITwxClX
         0UGw==
X-Gm-Message-State: AOAM532VR38Y/NgboOM3cYZlFT8ExhETT86bsJgH0sdVXt7r9VtpTKUG
        ANqEBribp3bTvfmilshh5hs=
X-Google-Smtp-Source: ABdhPJxX4Uk7PP9Y9hcr1wt42MQjB3eSjeqek9I0OZd2yekHYuCgJJwwWALg1jmGtKsQ/OE+8t72kw==
X-Received: by 2002:a05:6512:3d04:b0:44a:43e8:5b46 with SMTP id d4-20020a0565123d0400b0044a43e85b46mr19524052lfv.476.1648989951605;
        Sun, 03 Apr 2022 05:45:51 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.67.247])
        by smtp.gmail.com with ESMTPSA id y37-20020a0565123f2500b0044a1e1c6b37sm817148lfa.53.2022.04.03.05.45.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Apr 2022 05:45:51 -0700 (PDT)
Message-ID: <26ac4c2d-91cf-656d-2b7e-21a95e500e70@gmail.com>
Date:   Sun, 3 Apr 2022 15:45:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: staging: r8188eu: how to handle nested mutex under spinlock
Content-Language: en-US
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Michael Straube <straube.linux@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <356c24cf-625b-eea2-2c04-ce132d881cac@gmail.com>
 <3fb13fee-a605-7f2e-81ad-45148082a733@gmail.com>
 <fd356230-c9b1-2824-d073-83975bd31be9@gmail.com> <4412825.cEBGB3zze1@leap>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <4412825.cEBGB3zze1@leap>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------HBEBferClgyWmVBB7Kek60ZS"
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------HBEBferClgyWmVBB7Kek60ZS
Content-Type: multipart/mixed; boundary="------------CAwiyjxSYFWrSmp4pZ7jml8B";
 protected-headers="v1"
From: Pavel Skripkin <paskripkin@gmail.com>
To: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
 Michael Straube <straube.linux@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Phillip Potter <phil@philpotter.co.uk>,
 "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <26ac4c2d-91cf-656d-2b7e-21a95e500e70@gmail.com>
Subject: Re: staging: r8188eu: how to handle nested mutex under spinlock
References: <356c24cf-625b-eea2-2c04-ce132d881cac@gmail.com>
 <3fb13fee-a605-7f2e-81ad-45148082a733@gmail.com>
 <fd356230-c9b1-2824-d073-83975bd31be9@gmail.com> <4412825.cEBGB3zze1@leap>
In-Reply-To: <4412825.cEBGB3zze1@leap>

--------------CAwiyjxSYFWrSmp4pZ7jml8B
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgRmFiaW8sDQoNCk9uIDQvMy8yMiAxNTozNywgRmFiaW8gTS4gRGUgRnJhbmNlc2NvIHdy
b3RlOg0KPj4gPiANCj4+ID4gZHJpdmVycy9zdGFnaW5nL3I4MTg4ZXUvY29yZS9ydHdfcHdy
Y3RybC5jOjM3OQ0KPj4gPiANCj4+ID4gICAgCWlmIChwd3Jwcml2LT5wc19wcm9jZXNzaW5n
KSB7DQo+PiA+ICAgIAkJd2hpbGUgKHB3cnByaXYtPnBzX3Byb2Nlc3NpbmcgJiYgcnR3X2dl
dF9wYXNzaW5nX3RpbWVfbXMoc3RhcnQpIDw9IDMwMDApDQo+PiA+ICAgIAkJCW1zbGVlcCgx
MCk7DQo+PiA+ICAgIAl9DQo+PiA+IA0KPj4gDQo+PiBIbSwganVzdCB3b25kZXJpbmcsIHNo
b3VsZG4ndCB3ZSBhbm5vdGF0ZSBsb2FkIGZyb20gDQo+PiBwd3Jwcml2LT5wc19wcm9jZXNz
aW5nIHdpdGggUkVBRF9PTkNFKCkgaW5zaWRlIHdoaWxlIGxvb3A/DQo+PiBJSVVDIGNvbXBp
bGVyIG1pZ2h0IHdhbnQgdG8gY2FjaGUgZmlyc3QgbG9hZCBpbnRvIHJlZ2lzdGVyIGFuZCB3
ZSB3aWxsIA0KPj4gc3R1Y2sgaGVyZSBmb3JldmVyLg0KPiANCj4gWW91J3JlIHJpZ2h0LiBU
aGlzIGNhbiBiZSBjYWNoZWQuIEluIHNpdHVhdGlvbnMgbGlrZSB0aGVzZSBvbmUgc2hvdWxk
IHVzZQ0KPiBiYXJyaWVycyBvciBvdGhlciBBUEkgdGhhdCB1c2UgYmFycmllcnMgaW1wbGlj
aXRseSAoY29tcGxldGlvbnMsIGZvciBleGFtcGxlKS4NCj4gDQoNCk5vdCBzdXJlIGFib3V0
IGNvbXBsZXRpb25zLCBzaW5jZSB0aGV5IG1heSBzbGVlcC4NCg0KQWxzbywgZG9uJ3QgdGhp
bmsgdGhhdCBiYXJyaWVycyBhcmUgbmVlZGVkIGhlcmUsIHNpbmNlIHRoaXMgY29kZSBqdXN0
IA0Kd2FpdGluZyBmb3Igb2JzZXJ2aW5nIHZhbHVlIDEuIE1pZ2h0IGJlIGJhcnJpZXIgd2ls
bCBzbGlnaHRseSBzcGVlZCB1cCANCndhaXRpbmcgdGhyZWFkLCBidXQgd2lsbCBhbHNvIHNs
b3cgZG93biBvdGhlciB0aHJlYWQNCg0KDQo+IEluIHRoaXMgbGlzdCwgYSBjb3VwbGUgb2Yg
d2Vla3MgYWdvLCBJIHN1Z2dlc3RlZCBzb21lb25lIHRvIHVzZSB0aGVtLiBIZS9zaGUNCj4g
cmUtc3VibWl0dGVkIGhpcy9oZXIgcGF0Y2hlcyB3aXRoIHdhaXRfZm9yX2NvbXBsZXRpb24o
KSAvIGNvbXBsZXRlKCksIEkgcGxhY2VkDQo+IG15IFJldmlld2VkLWJ5IHRhZyBhbmQgR3Jl
ZyB3YXMgaGFwcHkgdG8gYWNjZXB0IGl0IGFuZCBtZXJnZS4NCj4gDQo+IE5vdCBzdXJlIGFi
b3V0IFJFQURfT05DRSgpLCBiZWNhdXNlLCBhcyBmYXIgYXMgSSBrbm93LCBpdCBpcyB1c2Vk
IG9ubHkgdG8NCj4gcHJldmVudCBsb2FkIHRlYXJpbmcuIEJ1dCBJIG1pZ2h0IGJlIHdyb25n
IGhlcmUuDQo+IA0KPiBGYWJpbw0KPiANCj4gUC5TLjogSXMgUGF1bCdzIGJvb2sgc3RpbGwg
dW4tcmVhZD8gVW5mb3J0dW5hdGVseSwgSSBhbSBub3QgeWV0IGRvbmUgOigNCj4gDQoNCklm
IEkgY291bGQgcmVhZCBpdCAyNC83IEkgd2lsbCBiZSB0aGUgaGFwcGllc3QgcGVyc29uIGV2
ZXIgOikgQXMgeW91IA0KbWlnaHQgZXhwZWN0IEkgYW0gbm90IHlldCBkb25lIGFzIHdlbGwN
Cg0KDQoNCg0KV2l0aCByZWdhcmRzLA0KUGF2ZWwgU2tyaXBraW4NCg==

--------------CAwiyjxSYFWrSmp4pZ7jml8B--

--------------HBEBferClgyWmVBB7Kek60ZS
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEER3XL3TplLQE8Qi40bk1w61LbBA0FAmJJlv0FAwAAAAAACgkQbk1w61LbBA3r
SRAAmkqrHFWPddRcFAshBxkzBKvDsuuB9kbaUrSIItvyc9pHeZeJHzLuHIEU7a5ouUrdNgIibaRU
Ex2uJVau+fS963RYaLKyIeol3PlQBk2p2tlUn2LjgQciamS86/nU5aBtbQNg7Uh462w4BQKaRy/9
9v29OfxuSYd4Lf8UYJY0GLAp68aQT+P0qGnX1fkL2EOw776WFPAd+lb/aHsD1FXeywbpFMI2oAMQ
yeGFqy7oc3Fk8hVzycycRP649NpgtjbUDcMcF6Up8fnr5Ru+nPsKbSByFER5g1ziadwlPP59Ay7T
RixPUA1avbeHnc9uxbcm1vXG56lNJZ0jpCaUWVqIg/Szu76utbA4O5f9QlABV7acU1qsIVpzuPHI
wtCkPqwijPKsBer/mYzkaNZUUnzQ6ai01WFMuj1AbStVMLpLWr4SQktrg99SroRhYZ6SHKdyJMb/
deCx6fubnpXZ0PTLERLW/6vjD2jteHp9YZ7EoApcG8bTqxNYfV70URpUaz8uGezBczkWDWmMTf9o
ON4EnD59PZbeRbfxD9fpspyanuS2Mowdyc//TbX23CAl4iJJ3iPbSpWVE5Zs7mRCJEqyap4RLtFR
HeijvAQ7XKm+0DphtE7egNXhxHEuHp/pt+uMPsooa0Lp2hLrGsSh4bEPeD/+fWRyp3YXbnEmblWa
prc=
=0ZZc
-----END PGP SIGNATURE-----

--------------HBEBferClgyWmVBB7Kek60ZS--
