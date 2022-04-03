Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964204F0990
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 15:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358350AbiDCNEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 09:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbiDCNEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 09:04:14 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900F221E0D
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 06:02:20 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id k21so12667478lfe.4
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 06:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to;
        bh=o/5H3hQU1bKGnfI2Eizpq3URJjhLApS4+nGYxyH5uXs=;
        b=W7oxCgG6rhTffSg1LkpIKdY7Tv/R9el64FWQVlZ3J9FZvla3/k9q+OePlgqJ/aaa0J
         js8FBngRi4H7nZ83cKHEUEn930EH4zgb0z//euOzyTgqxE81Ug1UPCaJ4UYEzV6/aByU
         EJquYtZJwQA4RJ+skVTlRN569zpgMZxknHn3y2ShLGOyVSXBAzb+Q8B68v9svZR1ibrv
         RLl2OGRPtpOM6qIdxAVOzkODHLcBZuQ/EXJWmDfz3qZqn60INBTRD11hU6x1sCYoCJXZ
         +Vn+906bdVtH/wu7RAkhnZhMNg4VKfOfHvCkSHy+U3Ka/DRM2Bm1XgmHJXsfDyIrnigT
         4SjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to;
        bh=o/5H3hQU1bKGnfI2Eizpq3URJjhLApS4+nGYxyH5uXs=;
        b=jTDFT0lv+H3uEsDPHGQFklfbsjhHnJqpXgpfjzevLRrAzpfx5HgBarggOvDz/K536l
         qfjK7umZRiddiqzAr5VNtsAnwFli2WJTjcMxzbqFyMaY0DYM3+9/9K/JyH3omhj7Gbnf
         m8mXBYHDiHO0z3X4iUAxJkbUMXfID2xQafxamIYkE1cRzfZShkGAuKOUE5acudnFOayf
         DK12fciEfPkjfaktVBmBqHtXvBQjQ4kfnBd/Tggb9Gu/oCq2lup/+/eIpzWvGvyLUzY7
         802GudyXpR+r7iZb2Dgrh8a/nbV9wYxNDwyc3ruS/SlS2WlAfBcEfzYPnUK/lOnjdFYS
         IqAQ==
X-Gm-Message-State: AOAM530YJLvIewYcPrTayc2NuH+W8UQofBQOh9UjMRuNYCZgbl2pzP7k
        lm9iiY3EV8K1qvVtkvPNNr0=
X-Google-Smtp-Source: ABdhPJzGfiC8zqn5uOwjALa8g6t/F+vMzacLRWQSs3RMZx4dD54eKbz1qtF5XguEYryQ6UftY2UHrQ==
X-Received: by 2002:a05:6512:3056:b0:44a:5117:2b2b with SMTP id b22-20020a056512305600b0044a51172b2bmr19532934lfb.275.1648990938668;
        Sun, 03 Apr 2022 06:02:18 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.67.247])
        by smtp.gmail.com with ESMTPSA id z23-20020a2e8857000000b00249a15d93b8sm786112ljj.125.2022.04.03.06.02.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Apr 2022 06:02:18 -0700 (PDT)
Message-ID: <7d3d23c3-1839-3e6a-27bf-85bad384e5e4@gmail.com>
Date:   Sun, 3 Apr 2022 16:02:16 +0300
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
 <4412825.cEBGB3zze1@leap> <26ac4c2d-91cf-656d-2b7e-21a95e500e70@gmail.com>
 <2029549.KlZ2vcFHjT@leap>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <2029549.KlZ2vcFHjT@leap>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ztQ7hFqw52D7RmjZ5Zza2Sdv"
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
--------------ztQ7hFqw52D7RmjZ5Zza2Sdv
Content-Type: multipart/mixed; boundary="------------kEZEa3yRzqeY92pR2tN00X09";
 protected-headers="v1"
From: Pavel Skripkin <paskripkin@gmail.com>
To: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
 Michael Straube <straube.linux@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Phillip Potter <phil@philpotter.co.uk>,
 "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <7d3d23c3-1839-3e6a-27bf-85bad384e5e4@gmail.com>
Subject: Re: staging: r8188eu: how to handle nested mutex under spinlock
References: <356c24cf-625b-eea2-2c04-ce132d881cac@gmail.com>
 <4412825.cEBGB3zze1@leap> <26ac4c2d-91cf-656d-2b7e-21a95e500e70@gmail.com>
 <2029549.KlZ2vcFHjT@leap>
In-Reply-To: <2029549.KlZ2vcFHjT@leap>

--------------kEZEa3yRzqeY92pR2tN00X09
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgRmFiaW8sDQoNCk9uIDQvMy8yMiAxNTo1NSwgRmFiaW8gTS4gRGUgRnJhbmNlc2NvIHdy
b3RlOg0KPiBPbiBkb21lbmljYSAzIGFwcmlsZSAyMDIyIDE0OjQ1OjQ5IENFU1QgUGF2ZWwg
U2tyaXBraW4gd3JvdGU6DQo+PiBIaSBGYWJpbywNCj4+IA0KPj4gT24gNC8zLzIyIDE1OjM3
LCBGYWJpbyBNLiBEZSBGcmFuY2VzY28gd3JvdGU6DQo+PiA+PiA+IA0KPj4gPj4gPiBkcml2
ZXJzL3N0YWdpbmcvcjgxODhldS9jb3JlL3J0d19wd3JjdHJsLmM6Mzc5DQo+PiA+PiA+IA0K
Pj4gPj4gPiAgICAJaWYgKHB3cnByaXYtPnBzX3Byb2Nlc3NpbmcpIHsNCj4+ID4+ID4gICAg
CQl3aGlsZSAocHdycHJpdi0+cHNfcHJvY2Vzc2luZyAmJiBydHdfZ2V0X3Bhc3NpbmdfdGlt
ZV9tcyhzdGFydCkgPD0gMzAwMCkNCj4+ID4+ID4gICAgCQkJbXNsZWVwKDEwKTsNCj4+ID4+
ID4gICAgCX0NCj4+ID4+ID4gDQo+PiA+PiANCj4+ID4+IEhtLCBqdXN0IHdvbmRlcmluZywg
c2hvdWxkbid0IHdlIGFubm90YXRlIGxvYWQgZnJvbSANCj4+ID4+IHB3cnByaXYtPnBzX3By
b2Nlc3Npbmcgd2l0aCBSRUFEX09OQ0UoKSBpbnNpZGUgd2hpbGUgbG9vcD8NCj4+ID4+IElJ
VUMgY29tcGlsZXIgbWlnaHQgd2FudCB0byBjYWNoZSBmaXJzdCBsb2FkIGludG8gcmVnaXN0
ZXIgYW5kIHdlIHdpbGwgDQo+PiA+PiBzdHVjayBoZXJlIGZvcmV2ZXIuDQo+PiA+IA0KPj4g
PiBZb3UncmUgcmlnaHQuIFRoaXMgY2FuIGJlIGNhY2hlZC4gSW4gc2l0dWF0aW9ucyBsaWtl
IHRoZXNlIG9uZSBzaG91bGQgdXNlDQo+PiA+IGJhcnJpZXJzIG9yIG90aGVyIEFQSSB0aGF0
IHVzZSBiYXJyaWVycyBpbXBsaWNpdGx5IChjb21wbGV0aW9ucywgZm9yIGV4YW1wbGUpLg0K
Pj4gPiANCj4+IA0KPj4gTm90IHN1cmUgYWJvdXQgY29tcGxldGlvbnMsIHNpbmNlIHRoZXkg
bWF5IHNsZWVwLg0KPiANCj4gTm8gY29tcGxldGlvbnMgaW4gdGhpcyBzcGVjaWFsIGNvbnRl
eHQuIFRoZXkgZm9yIF9zdXJlXyBtaWdodCBzbGVlcC4gSSB3YXMNCj4gdGFsa2luZyBhYm91
dCBnZW5lcmFsIGNhc2VzIHdoZW4geW91IGFyZSBpbiBhIGxvb3AgYW5kIHdhaXQgZm9yIHN0
YXR1cyBjaGFuZ2UuDQo+IA0KPj4gDQo+PiBBbHNvLCBkb24ndCB0aGluayB0aGF0IGJhcnJp
ZXJzIGFyZSBuZWVkZWQgaGVyZSwgc2luY2UgdGhpcyBjb2RlIGp1c3QgDQo+PiB3YWl0aW5n
IGZvciBvYnNlcnZpbmcgdmFsdWUgMS4gTWlnaHQgYmUgYmFycmllciB3aWxsIHNsaWdodGx5
IHNwZWVkIHVwIA0KPj4gd2FpdGluZyB0aHJlYWQsIGJ1dCB3aWxsIGFsc28gc2xvdyBkb3du
IG90aGVyIHRocmVhZA0KPiANCj4gSGVyZSwgSSBjYW5ub3QgaGVscCB3aXRoIGEgMTAwJSBn
b29kIGFuc3dlci4gTWF5YmUgR3JlZyB3YW50cyB0byBzYXkgc29tZXRoaW5nDQo+IGFib3V0
IGl0Pw0KPiANCg0KSU1PLCB0aGUgYmVzdCBhbnN3ZXIgaXMganVzdCByZW1vdmUgdGhpcyBs
b29wLCBzaW5jZSBpdCBkb2VzIG5vdGhpbmcuIE9yIA0KcmVkZXNpZ24gaXQgdG8gYmUgbW9y
ZSBzYW5lDQoNCkl0IHdhaXRzIGZvciBwc19wcm9jZXNzaW5nIHRvIGJlY29tZSAwIGZvciAz
MDAwIG1zLCBidXQgaWYgMzAwMCBtcyANCmV4cGlyZXMuLi4gZXhlY3V0aW9uIGdvZXMgZm9y
d2FyZCBsaWtlIGFzIHBzX3Byb2Nlc3Npbmcgd2FzIDAgZnJvbSB0aGUgDQpiZWdpbm5pbmcN
Cg0KTWF5YmUgaXQncyBzb21ldGhpbmcgaHcgcmVsYXRlZCwgbGlrZSB3YWl0IGZvciAzMDAw
IG1zIGFuZCBhbGwgd2lsbCBiZSANCm9rLiBDYW4ndCBzYXkuLi4NCg0KDQoNCg0KV2l0aCBy
ZWdhcmRzLA0KUGF2ZWwgU2tyaXBraW4NCg==

--------------kEZEa3yRzqeY92pR2tN00X09--

--------------ztQ7hFqw52D7RmjZ5Zza2Sdv
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEER3XL3TplLQE8Qi40bk1w61LbBA0FAmJJmtgFAwAAAAAACgkQbk1w61LbBA3I
aA//SU9SjnbUrWUShxTLqLoxLRi3zL08861r8rC+JoNWBbYNmReFX+ENZYz3OKSiEsxWIZys2X/r
PB1sCOTqB4TK32xkkC61552ChAXy3hNyhzpM+ox+ZPcbHq/3SidHEt2DvOvJxGL7yqdKF+t50drv
7XLVjPYS+cIqzxggxt7Hkf6r7MzOr/zbNhKD51JJxny4/K3hgtv3BZlJILvz0AkaW/2jpvT8H88m
9ZDpj/SklO5+NuaBd4mdGAdJgoHyVuSwOYk6JtCAgH31flRAvyi6CnR0L3tWAbpG0czBeGgJn3Yi
JKhPY9juqVVrPsIn+QvtW/5Ao4eXNuVCAiwVd3DsWHP6OzI6h80xWg046XMYthy6mOJQ5dt4sDjp
NVZAAk/r9t1Zk2ujtX+GrL1UsMmGjALneMXJTAquEHk8mrVL9NMANtmpLutvQrVj+Zn+Pnd+RFdr
G0lvHP6xXdo8cvh/w6NFYVExgPISY9z2us36LeDGYr0ZTAhlLbYDPrsSEq/10DPr5VcPqU202EiV
26uHceFRBzOLDA0aDFWfiBn08qqma3w1W8VRYygv2mHSAC1HDFTaL8DIGswi9A3SMqVuWNNzP9Xm
dwMXI86VR+RQowpoSgyq/pH2CcdkGV4x7SCJBEQrB9ukI8+KU5Lj7154Opce02BuG/N6YEA3C/z8
xdY=
=wfyk
-----END PGP SIGNATURE-----

--------------ztQ7hFqw52D7RmjZ5Zza2Sdv--
