Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520624F1BCA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381489AbiDDVXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379176AbiDDQk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:40:58 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D551CB09
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 09:39:00 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id d5so18331602lfj.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 09:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to;
        bh=f48IzbdBz845MsLZuGRp0JSze2mRq5AWOQgZcmuy9m8=;
        b=oqABKViXVOmRRp3lNfNO/U0mipIFONFrxC+FmzokdpIugTQFWYCd9A0gdMvNuwvbGv
         I0SR5USGwRM01uG6iascMUnnpC637ZzqUIIJ81pudOKgF8VhY55akFTBmhO38aGkQRgc
         fyC1cnVSHkmHv+xfbTCYUm9U2vNtsebL/KAfcC6gBzFUtHrETL60Szk9AFgXFRQkGJrT
         77GEKMY7s94yNanf8wzo6KcmrgLqNLwCfjzU8zWP67WX9QU7feQwtEY99nGNhg8/ojvv
         JDh7VLuxGpoWTiE6+p17c49ktcOBdHsI6nSZV2143QKkG7mWE3DXy8JU6X6iwXE7MNAY
         QarQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to;
        bh=f48IzbdBz845MsLZuGRp0JSze2mRq5AWOQgZcmuy9m8=;
        b=Tw3fHqPDw658oZwyTB+Ezhq+VNtPKVqnhFX9KDgRDxzitg/2jNAxncUdVJitV6CWst
         rkJ+NaCzFoPCIz5Tg65Qyn6slPO2Y5DM67RHMObWvJYO99FC5zlhQ6w7yNb5SJP+xYo1
         OhgWZS5JxPCq3gHCJ+0LRlDBsfIiHqNpvAjpA67vFz2rAfCOTCtew2AZi1aenucwScvK
         BYbrsczkptk8hTbgqG0CnBt4RxvZ0TR5mTjvdHR2nbke/sO8fmSlY2N/jD1qQGu4hqmF
         ebC0Rs46slmVZ9VPMJzan2F3I5ztm5W5Tfcexqk2F92v//5UeXHWvPkqrmEajmAEt/cC
         Bu4g==
X-Gm-Message-State: AOAM531dfFilU7xGPqFAIYkS+jtED8MjZYXGM3Gr+kRgm3WFo99z4Uxs
        opNpSxosGLSmBi3ksG6GO9Q=
X-Google-Smtp-Source: ABdhPJyhDsVJM31ary8b+4NPbVlKXCSWqF8poo6kekmka4GL7V0gVe226UZh9QzWOMxMj0dm4s5Ueg==
X-Received: by 2002:a05:6512:4006:b0:44a:7434:9829 with SMTP id br6-20020a056512400600b0044a74349829mr187616lfb.661.1649090338007;
        Mon, 04 Apr 2022 09:38:58 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.67.247])
        by smtp.gmail.com with ESMTPSA id h14-20020a2e900e000000b0024b14fa6038sm513048ljg.12.2022.04.04.09.38.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 09:38:57 -0700 (PDT)
Message-ID: <3c8b6454-6b52-fe62-8db1-c76bdbeb2df0@gmail.com>
Date:   Mon, 4 Apr 2022 19:38:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: staging: r8188eu: how to handle nested mutex under spinlock
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        Michael Straube <straube.linux@gmail.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <356c24cf-625b-eea2-2c04-ce132d881cac@gmail.com>
 <4412825.cEBGB3zze1@leap> <26ac4c2d-91cf-656d-2b7e-21a95e500e70@gmail.com>
 <2029549.KlZ2vcFHjT@leap> <7d3d23c3-1839-3e6a-27bf-85bad384e5e4@gmail.com>
 <942c0fbd-f8b2-4cae-dd21-79bc55c54902@gmail.com>
 <26a91705-f721-03d1-f4c8-7f00ce0e65a8@gmail.com>
 <4ef1e90716e64fd78ebbc222bbb7e597@AcuMS.aculab.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <4ef1e90716e64fd78ebbc222bbb7e597@AcuMS.aculab.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------TSUrFrVmzrfCzbLpC7evl2Y1"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------TSUrFrVmzrfCzbLpC7evl2Y1
Content-Type: multipart/mixed; boundary="------------ne0JqlCpjJz5NLvN4rBcfCm9";
 protected-headers="v1"
From: Pavel Skripkin <paskripkin@gmail.com>
To: David Laight <David.Laight@ACULAB.COM>,
 Michael Straube <straube.linux@gmail.com>,
 "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Phillip Potter <phil@philpotter.co.uk>,
 "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <3c8b6454-6b52-fe62-8db1-c76bdbeb2df0@gmail.com>
Subject: Re: staging: r8188eu: how to handle nested mutex under spinlock
References: <356c24cf-625b-eea2-2c04-ce132d881cac@gmail.com>
 <4412825.cEBGB3zze1@leap> <26ac4c2d-91cf-656d-2b7e-21a95e500e70@gmail.com>
 <2029549.KlZ2vcFHjT@leap> <7d3d23c3-1839-3e6a-27bf-85bad384e5e4@gmail.com>
 <942c0fbd-f8b2-4cae-dd21-79bc55c54902@gmail.com>
 <26a91705-f721-03d1-f4c8-7f00ce0e65a8@gmail.com>
 <4ef1e90716e64fd78ebbc222bbb7e597@AcuMS.aculab.com>
In-Reply-To: <4ef1e90716e64fd78ebbc222bbb7e597@AcuMS.aculab.com>

--------------ne0JqlCpjJz5NLvN4rBcfCm9
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgRGF2aWQsDQoNCk9uIDQvNC8yMiAxMTo1MCwgRGF2aWQgTGFpZ2h0IHdyb3RlOg0KPj4g
DQo+PiA+IAkJd2hpbGUgKHB3cnByaXYtPmJJblN1c3BlbmQgJiYNCj4+IA0KPj4gSSd2ZSBs
b29rZWQgaW50byB3aGF0IGdjYzExIHByb2R1Y2VkIGZyb20gdGhpcyBmdW5jdGlvbiBhbmQg
bG9va3MgbGlrZQ0KPj4gbXkgY29tcGlsZXIgaXMgc21hcnQgZW5vdWdoIHRvIG5vdCBjYWNo
ZSB0aGF0IHZhbHVlLCBidXQgSSBhbSBhZnJhaWQgbm90DQo+PiBhbGwgY29tcGlsZXJzIGFy
ZSB0aGF0IHNtYXJ0Lg0KPiANCj4gVGhlIGNvbXBpbGVyIGNhbid0IGNhY2hlIHRoZSB2YWx1
ZSBiZWNhdXNlIG9mIHRoZSBmdW5jdGlvbiBjYWxsLg0KPiANCg0KSG0sIEkgYW0gYSBuZXdi
aWUgaW4gY29tcGlsZXJzLCBzbyBjYW4geW91LCBwbGVhc2UsIGV4cGxhaW4gKG9yIGdpdmUg
YSANCmxpbmsgdG8gYW55IHJlc291cmNlIHdoZXJlIEkgY2FuIHJlYWQgYWJvdXQgaXQpIGhv
dyBmdW5jdGlvbiBjYWxsIGhlcmUgDQpwcmV2ZW50IGNhY2hpbmcuDQoNCklJVUMgY29tcGls
ZXIgZ2VuZXJhdGVzIGNvZGUgdGhhdCB3b3JrcyB3ZWxsIGluIHNjb3BlIG9mIHNpbmdsZS10
aHJlYWRlZCANCmFwcGxpY2F0aW9uLCBzbyB3aHkgY2FuJ3QgY29tcGlsZXIgY2FjaGUgdGhh
dCB2YWx1ZSBpbnN0ZWFkIG9mIGFjY2Vzc2luZyANCm1lbW9yeSBvbiBlYWNoIGl0ZXJhdGlv
bi4uLiBJc24ndCByZWdpc3RlciBhY2Nlc3MgYSB3YXkgZmFzdGVyIHRoYW4gZXZlbiANCmNh
Y2hlIGhpdD8NCg0KDQpUaGFua3MhDQoNCldpdGggcmVnYXJkcywNClBhdmVsIFNrcmlwa2lu
DQo=

--------------ne0JqlCpjJz5NLvN4rBcfCm9--

--------------TSUrFrVmzrfCzbLpC7evl2Y1
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEER3XL3TplLQE8Qi40bk1w61LbBA0FAmJLHx8FAwAAAAAACgkQbk1w61LbBA0g
mA//UbJy8VwtDJXIQ4H8+xxbbX334f8JocZMMupYuJBcLWs/C87gboedB9e5q9c/vQtMOfzxGXPO
sF3HDC5S1Xc2aeufi3ibVTvbsKFnGNacbbbpr5Ltwssdgjq+F3pdWWmSEg8XdwCxn6lSQK0FNlUx
YTXVzl3ojvYY768hSq3c2u2M3y7b4p0/TDmk1oBicZRKeMk5cSbb2foPG70f4464g++gCpTBTywU
qj0cgtlSAX1kb7A8jiYcZQGQ7wiExEyak+pU47pb5ueA35ttKfqMG6xmLVSc89zw9qwd5xQ6v4qX
WVnpYxab3s0PeVFr1vf+UQeTBi0vGU4GiBR5x0KAAunJAclcOdpevcd4gRfrzhz5QV9DEMLZM8hm
OlNzJsWt4EQS/cnogC/PZY0MZaYew8WAy4R3H4Tiw9/5oGtWdcHQyMXcNHwk1v0SoP1++iYWyyMI
QKFQLzQ3xN2/LeoGMsxsHJEmAUzbqTjAdP+uHuaVmUGaxtLpo+HAjAy8fNEXVWiMwXzX88jLxHSY
Cm2YJXlis8wf20hPVgEMELesviVAXviSo+S3KckruZlgRQ0p7MNqmQwqKcJy7g9H9rwKLn7Rbebh
Jg+MfIoWiaWcniNOXJ9+KS16ce035FWBhovFTmG19QXr1QKA5+1u0Ci9gxmH4G0Hz6TtroLv7DXV
7Uk=
=OSBD
-----END PGP SIGNATURE-----

--------------TSUrFrVmzrfCzbLpC7evl2Y1--
