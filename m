Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242AF4F1BE9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381933AbiDDVY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379479AbiDDROc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 13:14:32 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A9913D16
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 10:12:34 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id bx37so10053113ljb.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 10:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to;
        bh=oo8RE32nCoCnJcNuvIDU6kj6dR7jI6fh9JBXKwfUBHo=;
        b=S/DawjrTHpwGGbpG+dCODzMvOUlxdV8xj+b4tNbbVnOQuZy5XLBD7WPUTkCNRvNY6R
         FjlWtNIJBDmHMR5WwBu4mG1DnHYCI3RvDeLIzVDyyuEmjWshmiJeAA1pVUNwNWKOiAvS
         JuIcVMYunN+8EAr90Ft4D2gZOyowPTsiLhhnrMFqllFu+5ggIrS7xV9GBHHuzt7KFCfW
         EGV+CVqzCvD9ybtuiz7J+M0jO16h7+rT14kkzOCemY3l2PO+HYWna55A9K0TH9yJDDBv
         NW1fL0lCh9uOnoOJ39tcwG85zKMX5bhGicPqm8MUxNo0boipgt/Lmy/ChFcZoE+0cUBL
         0a+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to;
        bh=oo8RE32nCoCnJcNuvIDU6kj6dR7jI6fh9JBXKwfUBHo=;
        b=DtCu947YiJt7F1SfnNzYJbrBTQ48Se7MusVQqtb2ICXeKT5esVq0cUqGF/K9ng+UGe
         sUcV+UiCQFPDPr+WgYT6tO/lT16Aj+PyCIkXtXrZ0ILt73CdhqIycQxR/LSTy/L2iePs
         pskP5Z0Qm6IGZETBs3A48L3GnsfPd+E0ztcqi2re/um5+gHUXlaS2c2Ewx7xIsiszK0I
         zH1dkIZmL1VsIrTj6GPboaxReIm5lTbj9GTGNn3COfKdwg8TmNVjN7WKVMxmA2unO/Jg
         dSdg7B35aPcEH5dtUZBXLem/xwc4Ypt9koDWq+8gJJhzkLS4h8KoZW6Ytg5G4PU2p2RK
         A3PQ==
X-Gm-Message-State: AOAM530HWH2d0JPHZpIgo1bg+xgr1qrReiSR9dsF6GOheWzt2Br2eMsl
        qoa8wQSSZG5NWUJec9ifw+o=
X-Google-Smtp-Source: ABdhPJx81uhHW84j2KnF0Ehait9D2NCQPoIz8xM0zxXJuwkk2hiBcst8/kwCDgqf0hKfQ17VHOlSPA==
X-Received: by 2002:a2e:bf12:0:b0:249:3a3b:e91a with SMTP id c18-20020a2ebf12000000b002493a3be91amr359298ljr.343.1649092353019;
        Mon, 04 Apr 2022 10:12:33 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.67.247])
        by smtp.gmail.com with ESMTPSA id p15-20020a19f10f000000b0044a36e3cc33sm1188334lfh.298.2022.04.04.10.12.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 10:12:32 -0700 (PDT)
Message-ID: <6771d68a-5251-4fb1-cecb-a0d2f32faf36@gmail.com>
Date:   Mon, 4 Apr 2022 20:12:31 +0300
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
 <3c8b6454-6b52-fe62-8db1-c76bdbeb2df0@gmail.com>
 <e1ab34f940234eecb91b9b262062eda5@AcuMS.aculab.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <e1ab34f940234eecb91b9b262062eda5@AcuMS.aculab.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ojgS2yDN6b8jEpOHeVgba6OW"
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
--------------ojgS2yDN6b8jEpOHeVgba6OW
Content-Type: multipart/mixed; boundary="------------f4ntLhnd0DATl3FwdBkEaOwo";
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
Message-ID: <6771d68a-5251-4fb1-cecb-a0d2f32faf36@gmail.com>
Subject: Re: staging: r8188eu: how to handle nested mutex under spinlock
References: <356c24cf-625b-eea2-2c04-ce132d881cac@gmail.com>
 <4412825.cEBGB3zze1@leap> <26ac4c2d-91cf-656d-2b7e-21a95e500e70@gmail.com>
 <2029549.KlZ2vcFHjT@leap> <7d3d23c3-1839-3e6a-27bf-85bad384e5e4@gmail.com>
 <942c0fbd-f8b2-4cae-dd21-79bc55c54902@gmail.com>
 <26a91705-f721-03d1-f4c8-7f00ce0e65a8@gmail.com>
 <4ef1e90716e64fd78ebbc222bbb7e597@AcuMS.aculab.com>
 <3c8b6454-6b52-fe62-8db1-c76bdbeb2df0@gmail.com>
 <e1ab34f940234eecb91b9b262062eda5@AcuMS.aculab.com>
In-Reply-To: <e1ab34f940234eecb91b9b262062eda5@AcuMS.aculab.com>

--------------f4ntLhnd0DATl3FwdBkEaOwo
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgRGF2aWQsDQoNCk9uIDQvNC8yMiAxOTo1OSwgRGF2aWQgTGFpZ2h0IHdyb3RlOg0KPiBG
cm9tOiBQYXZlbCBTa3JpcGtpbg0KPj4gU2VudDogMDQgQXByaWwgMjAyMiAxNzozOQ0KPj4g
DQo+PiBIaSBEYXZpZCwNCj4+IA0KPj4gT24gNC80LzIyIDExOjUwLCBEYXZpZCBMYWlnaHQg
d3JvdGU6DQo+PiA+Pg0KPj4gPj4gPiAJCXdoaWxlIChwd3Jwcml2LT5iSW5TdXNwZW5kICYm
DQo+PiA+Pg0KPj4gPj4gSSd2ZSBsb29rZWQgaW50byB3aGF0IGdjYzExIHByb2R1Y2VkIGZy
b20gdGhpcyBmdW5jdGlvbiBhbmQgbG9va3MgbGlrZQ0KPj4gPj4gbXkgY29tcGlsZXIgaXMg
c21hcnQgZW5vdWdoIHRvIG5vdCBjYWNoZSB0aGF0IHZhbHVlLCBidXQgSSBhbSBhZnJhaWQg
bm90DQo+PiA+PiBhbGwgY29tcGlsZXJzIGFyZSB0aGF0IHNtYXJ0Lg0KPj4gPg0KPj4gPiBU
aGUgY29tcGlsZXIgY2FuJ3QgY2FjaGUgdGhlIHZhbHVlIGJlY2F1c2Ugb2YgdGhlIGZ1bmN0
aW9uIGNhbGwuDQo+PiA+DQo+PiANCj4+IEhtLCBJIGFtIGEgbmV3YmllIGluIGNvbXBpbGVy
cywgc28gY2FuIHlvdSwgcGxlYXNlLCBleHBsYWluIChvciBnaXZlIGENCj4+IGxpbmsgdG8g
YW55IHJlc291cmNlIHdoZXJlIEkgY2FuIHJlYWQgYWJvdXQgaXQpIGhvdyBmdW5jdGlvbiBj
YWxsIGhlcmUNCj4+IHByZXZlbnQgY2FjaGluZy4NCj4+IA0KPj4gSUlVQyBjb21waWxlciBn
ZW5lcmF0ZXMgY29kZSB0aGF0IHdvcmtzIHdlbGwgaW4gc2NvcGUgb2Ygc2luZ2xlLXRocmVh
ZGVkDQo+PiBhcHBsaWNhdGlvbiwgc28gd2h5IGNhbid0IGNvbXBpbGVyIGNhY2hlIHRoYXQg
dmFsdWUgaW5zdGVhZCBvZiBhY2Nlc3NpbmcNCj4+IG1lbW9yeSBvbiBlYWNoIGl0ZXJhdGlv
bi4uLiBJc24ndCByZWdpc3RlciBhY2Nlc3MgYSB3YXkgZmFzdGVyIHRoYW4gZXZlbg0KPj4g
Y2FjaGUgaGl0Pw0KPiANCj4gQmVjYXVzZSBjYWxscyB0byBleHRlcm5hbCBmdW5jdGlvbnMg
YXJlIGFsbG93ZWQgdG8gY2hhbmdlDQo+IGFueSBkYXRhIHZpYSAnb3RoZXInIHJlZmVyZW5j
ZXMuDQo+IEZvciBpbnN0YW5jZSB0aGUgc3RydWN0dXJlIHBvaW50ZXIgdGhlIGZ1bmN0aW9u
IGhhcyBjb3VsZA0KPiBhbHNvIGJlIGluIGdsb2JhbCBkYXRhIHNvbWV3aGVyZS4NCj4gDQoN
Ck1ha2Ugc2Vuc2UsIHRoYW5rIHlvdSBmb3IgZXhwbGFuYXRpb24hDQoNCg0KDQoNCldpdGgg
cmVnYXJkcywNClBhdmVsIFNrcmlwa2luDQo=

--------------f4ntLhnd0DATl3FwdBkEaOwo--

--------------ojgS2yDN6b8jEpOHeVgba6OW
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEER3XL3TplLQE8Qi40bk1w61LbBA0FAmJLJv8FAwAAAAAACgkQbk1w61LbBA2Y
FQ/+JO/v68k6xBMFzpBxhJLs8DsUg3auoVNTFLCilloTOAqlQVIp3JfgCf2tnc3i89vjphOtAYh5
6QbtMCJyMigxcAIYq/AVEFHVMg1IuX2fiCYF0l7QFLSyuzZi4hya4WEQoXO762mR2wgpBqBbcySj
uJ2nWSDPJaqBp5HXEYoV6/8mTSgTfIZfGax1PxLAIC+/aPb3CD37wkRGT3yH5d70gvSUku3zfD6f
Ije3k4ypAoVTo6SPOwVxt0zNDgWeKkmlqIrvi6XD96vHmJujTmDyIPT5Vln3K1iHpzf6Mi3HpL9D
dttDjLexS/WIpNrmDY3ks8O8FJlkMvymizj4EeCGg2F+SDVqEodU+bUZ7T/25rR7C0cUuVdSxgT8
WYvNqr4HXI9bVEYjtNCL9OF4b0X7DXPOq0nY8ZvoyN+QAIaJcHWOdoLns9weqgNNmFTcQ70L+2Wz
+TKEsfOfLE9wtoOSeHweDUmO2GqJ/obwHELXHvB5KYBgITdl2kvFJiuZ5mE62Q8VqS62oTmqnMxE
TIKh2WkvckIWoMIvIWmuacF/dZL9bjelNvYoF3H7FnKR1/8Qua3rTrtEWzQ/Z+h1MTKe3kRIU+ho
6/YxgL646R9SLNt1rk9xj8ZJCz4eCTzbM+Xyu4c8WsHcCMH65IAxZi4xm0Vz851FrTnD3wrvC619
Lfo=
=7pMo
-----END PGP SIGNATURE-----

--------------ojgS2yDN6b8jEpOHeVgba6OW--
