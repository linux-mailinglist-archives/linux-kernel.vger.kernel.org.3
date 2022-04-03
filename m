Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339D04F0C95
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 23:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356990AbiDCVRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 17:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiDCVRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 17:17:10 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A360255B3
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 14:15:15 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id h11so10611509ljb.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 14:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to;
        bh=0VMA9dSUTpLCb6xWZrmY1SOl3mR04sovoHbxgbSlKCY=;
        b=aFGkE9KT8GWKejenrGuUh7DISUGy9cu45NTcDbgVmLzFcxJ5gZ41A4/X6n/7Scf6d8
         qKDHY4sfZNF1yjy64GR9+5jtfD/iMBbgo6RWPuVMpiSzS8M2Y6fJ+yDXCzlojxNJEKB6
         AVlOI2QbfdrLl3DrfbQC1+cJEKB3dhtuEzp9n2VFJklYcacr1N+IvOX+7SN1yx4eiwjG
         3dzkf6np4Fzoe1bcD0/VRTZqUSR6Ke/bnqU73rM4Ll8q8vV2+hcvHCv1arNFWnqKGwRE
         JOcg0oyYp7acZZLAtO9FUaDlKo6O6xiAqX/Nq05NyBEKMFQSCTWl9xr0GnRiwGDclwGy
         4F7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to;
        bh=0VMA9dSUTpLCb6xWZrmY1SOl3mR04sovoHbxgbSlKCY=;
        b=Eq1idG4zqiEpeeIyxPec4pULO22uT0WCKTGr5fpSq9oVzYkuYosrT0GqTvAL7cL9eQ
         2arxBu+w+NWQl6KaGM1tpUr3UNBlm4BRYrNzwI1/IaeLrhB6idLwHM+6zRazWGjM00eN
         9voQjlbqwXGp3x3+DGJtu4I29yWnasOlIYzS08Q5hKpMQrCWXxFbCp2qyRH0LcZlDlqX
         SruqQVHnoDzsZmfn6FYvCld9DOUx50RCLkv4VUSnljEowko9wl0fCsALHdidwQaI70wD
         cRM200ZYjlqKqSHbLAbjmTqTq4qpYfFUqka6lrzCH5CeQfV3SBQ11vW+8dTN/t6kGd9t
         NhOg==
X-Gm-Message-State: AOAM5318SxOTRZaThQsuae92NjMIGMI9qDV8+ztRBb+3zbvxfga5j0g7
        MN91CRcEwohbX3AyAszDIo8=
X-Google-Smtp-Source: ABdhPJxUffZ8c0gA4w9uGLIG33OOlYbfwhJJ2m+2I7dPPoQbezZ1O0U6dM1DnPdBkClQF3FbydVE4A==
X-Received: by 2002:a2e:968e:0:b0:24b:125b:f399 with SMTP id q14-20020a2e968e000000b0024b125bf399mr3838883lji.67.1649020513369;
        Sun, 03 Apr 2022 14:15:13 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.67.247])
        by smtp.gmail.com with ESMTPSA id u21-20020a056512129500b0044a51b85576sm921220lfs.21.2022.04.03.14.15.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Apr 2022 14:15:12 -0700 (PDT)
Message-ID: <26a91705-f721-03d1-f4c8-7f00ce0e65a8@gmail.com>
Date:   Mon, 4 Apr 2022 00:15:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: staging: r8188eu: how to handle nested mutex under spinlock
Content-Language: en-US
To:     Michael Straube <straube.linux@gmail.com>,
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
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <942c0fbd-f8b2-4cae-dd21-79bc55c54902@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------zH4AhstN0hmrhzV5ODHhhnQq"
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
--------------zH4AhstN0hmrhzV5ODHhhnQq
Content-Type: multipart/mixed; boundary="------------khzppFhuE5jRIu4GaNSU6LLR";
 protected-headers="v1"
From: Pavel Skripkin <paskripkin@gmail.com>
To: Michael Straube <straube.linux@gmail.com>,
 "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Phillip Potter <phil@philpotter.co.uk>,
 "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <26a91705-f721-03d1-f4c8-7f00ce0e65a8@gmail.com>
Subject: Re: staging: r8188eu: how to handle nested mutex under spinlock
References: <356c24cf-625b-eea2-2c04-ce132d881cac@gmail.com>
 <4412825.cEBGB3zze1@leap> <26ac4c2d-91cf-656d-2b7e-21a95e500e70@gmail.com>
 <2029549.KlZ2vcFHjT@leap> <7d3d23c3-1839-3e6a-27bf-85bad384e5e4@gmail.com>
 <942c0fbd-f8b2-4cae-dd21-79bc55c54902@gmail.com>
In-Reply-To: <942c0fbd-f8b2-4cae-dd21-79bc55c54902@gmail.com>

--------------khzppFhuE5jRIu4GaNSU6LLR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgTWljaGFlbCwNCg0KT24gNC8zLzIyIDIzOjUxLCBNaWNoYWVsIFN0cmF1YmUgd3JvdGU6
DQo+PiANCj4+IElNTywgdGhlIGJlc3QgYW5zd2VyIGlzIGp1c3QgcmVtb3ZlIHRoaXMgbG9v
cCwgc2luY2UgaXQgZG9lcyBub3RoaW5nLiBPciANCj4+IHJlZGVzaWduIGl0IHRvIGJlIG1v
cmUgc2FuZQ0KPj4gDQo+PiBJdCB3YWl0cyBmb3IgcHNfcHJvY2Vzc2luZyB0byBiZWNvbWUg
MCBmb3IgMzAwMCBtcywgYnV0IGlmIDMwMDAgbXMgDQo+PiBleHBpcmVzLi4uIGV4ZWN1dGlv
biBnb2VzIGZvcndhcmQgbGlrZSBhcyBwc19wcm9jZXNzaW5nIHdhcyAwIGZyb20gdGhlIA0K
Pj4gYmVnaW5uaW5nDQo+PiANCj4+IE1heWJlIGl0J3Mgc29tZXRoaW5nIGh3IHJlbGF0ZWQs
IGxpa2Ugd2FpdCBmb3IgMzAwMCBtcyBhbmQgYWxsIHdpbGwgYmUgDQo+PiBvay4gQ2FuJ3Qg
c2F5Li4uDQo+PiANCj4gDQo+IEhpIFBhdmVsLA0KPiANCj4gc2FtZSB3aXRoIHRoZSBsb29w
IHRoYXQgZm9sbG93czoNCj4gDQo+IAkvKiBTeXN0ZW0gc3VzcGVuZCBpcyBub3QgYWxsb3dl
ZCB0byB3YWtldXAgKi8NCj4gCWlmIChwd3Jwcml2LT5iSW5TdXNwZW5kKSB7DQoNCgkgICBe
Xl5eDQoNCmJ0dywgdGhpcyBwYXJ0IGlzIHVzZWxlc3MgdG8NCg0KDQo+IAkJd2hpbGUgKHB3
cnByaXYtPmJJblN1c3BlbmQgJiYNCg0KSSd2ZSBsb29rZWQgaW50byB3aGF0IGdjYzExIHBy
b2R1Y2VkIGZyb20gdGhpcyBmdW5jdGlvbiBhbmQgbG9va3MgbGlrZSANCm15IGNvbXBpbGVy
IGlzIHNtYXJ0IGVub3VnaCB0byBub3QgY2FjaGUgdGhhdCB2YWx1ZSwgYnV0IEkgYW0gYWZy
YWlkIG5vdCANCmFsbCBjb21waWxlcnMgYXJlIHRoYXQgc21hcnQuDQoNCkFuZCBsb29rcyBs
aWtlIGl0IHdpbGwgYmUgYmV0dGVyIHRvIHdhaXQgb24gbXV0ZXhfbG9jaygmcHdycHJpdi0+
bG9jayk7IA0KcmF0aGVyIHRoYW4gb2RkIGxvb3BzLiBBaCwgd2UgY2FuJ3Qgd2FpdCBoZXJl
Li4uDQoNCkluIGZpcnN0IHBsYWNlLCB3aHkgdGhpcyBmdW5jdGlvbiBjYXJlcyBhYm91dCB1
c2Igc3VzcGVuZCBjYWxsYmFjaz8NCg0KSSd2ZSBnb3QgdG9vIG1hbnkgcXVlc3Rpb25zIHRv
IHRoYXQgY29kZS4uLiBJJ2QgYmV0dGVyIHN0b3ANCg0KPiAJCSAgICAgICAocnR3X2dldF9w
YXNzaW5nX3RpbWVfbXMoc3RhcnQpIDw9IDMwMDAgfHwNCj4gCQkgICAgICAgKHJ0d19nZXRf
cGFzc2luZ190aW1lX21zKHN0YXJ0KSA8PSA1MDApKSkNCj4gCQkJCW1zbGVlcCgxMCk7DQo+
IAl9DQo+IA0KPiBJIGp1c3Qgd2FpdHMgNTAwbXMgaWYgcHdycHJpdi0+YkluU3VzcGVuZCBp
cyB0cnVlLiBBZGRpdGlvbmFseSB0aGUNCj4gPD0gMzAwMCBoYXMgbm8gZWZmZWN0IGhlcmUg
YmVjYXVzZSBvZiB0aGUgb3JlZCA8PSA1MDAuDQo+IA0KDQpZZWFoLCBhbmQgdW5mb3J0dW5h
dGVseSBpdCB3b24ndCBiZSBvcHRpbWl6ZWQgb3V0IDooDQoNCj4gRXZlbiB3b3JzZSB0aGUg
Y29tbWVudCBzZWVtcyBtaXNsZWFkaW5nIGJlY2F1c2UgcHdycHJpdi0+YkluU3VzcGVuZA0K
PiBpbmRpY2F0ZXMgdXNiIGF1dG9zdXNwZW5kIGJ1dCBub3Qgc3lzdGVtIHN1c3BlbmQuDQo+
IA0KDQoNCg0KDQoNCg0KV2l0aCByZWdhcmRzLA0KUGF2ZWwgU2tyaXBraW4NCg==

--------------khzppFhuE5jRIu4GaNSU6LLR--

--------------zH4AhstN0hmrhzV5ODHhhnQq
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEER3XL3TplLQE8Qi40bk1w61LbBA0FAmJKDl8FAwAAAAAACgkQbk1w61LbBA2F
CQ/+Lezdqmz1Jux9DjMbQXe3dTUaICPfCq/2TS0KwjLgNcNhtA2zkUjWeKk1qYnk0i3prcU/vIcl
LmmBgVxKWlgBIfAukuaxRormobtXWGaLauEFqt/FHlPA1qmPXfSAq/Q1LDAvrwB4OpjpQWp/Rimv
2miub4BjvPV5X85wxxgVFO/YWlecub3cht2nKXhKmhliW47TLCQnHY1bn3cZNZScrEI3aDlbQT6J
sut2wptTcIQHigLe0eSYFsam0opb6DPIs78eKFu5EjrZFXCgnF0ugD5LkYcbyhYOw8o3mqEz1nbF
lg4PCx3H1v8cFilkLK/NapVIYFwLg1FMxh9MH+/NKpHoq6m3pH6kmeiwC4piMpGyFHOKVEGMfASs
l1XSqs76LBo6/qgSaBF5jNbWuQxF6mWdPYOmU/CFfe+IPItWujW/7GeEEhoBktMno1LbTc0v1hv/
izkEDKJJinqqKsG8281SCNHIxUODQrkWe5YugTnb5xblKEZNcBgZIsqXFtAuYE1dA4+sUlOsPm1h
fxnuN9WnD1nBUKfrEU+/+WtYVoNPcfZdHiClIJxRtJLNtXbDeUFfK0DOvsmcv2Wizt/AyAmIpV3z
73bWr7o8Y7UhLDAURQvr/IjT19F/SG9CysBhV1ta2DjHBEYgj0I6MNUUgCpAFved+o8C7cSVP+Rb
8F4=
=16uw
-----END PGP SIGNATURE-----

--------------zH4AhstN0hmrhzV5ODHhhnQq--
