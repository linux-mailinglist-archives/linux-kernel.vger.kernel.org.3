Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6499E58517D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 16:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbiG2OX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 10:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbiG2OXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 10:23:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551106D9DC
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 07:23:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BF4E934B1C;
        Fri, 29 Jul 2022 14:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659104601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=41yTqV34Y9S/L+H/w43+RTmir3H4LTje1VGve6f4RDU=;
        b=g4e8RkVotq+qshmeZR5PldOGSHDtXeCHF643L5YFJSvubFf8NpSSh02YreA7qWwBK5oaq7
        t+KznGB12iPdKHpj57zBPmmZCBLbbS8S4AnFJeDZk8zKkhBA66scK9HwUunEE25bWWpSgR
        KnPKszz7TFJwx1bp0Eha+ZaakGxpU94=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659104601;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=41yTqV34Y9S/L+H/w43+RTmir3H4LTje1VGve6f4RDU=;
        b=tG9PlLHEzBx4R6SnDnH8mnJ2jtVkxqABaeWviAc6YFeCL5OdXahdIrxFrgU/cADu1ktln/
        mb6ke0H4wYMftOBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 851AE13A1B;
        Fri, 29 Jul 2022 14:23:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qjxKH1nt42JzZAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Fri, 29 Jul 2022 14:23:21 +0000
Message-ID: <a68022f4-28d0-7743-27fe-6df652082184@suse.de>
Date:   Fri, 29 Jul 2022 16:23:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/kmb: fix dereference before NULL check in
 kmb_plane_atomic_update()
Content-Language: en-US
To:     Zeng Jingxiang <zengjx95@gmail.com>, anitha.chrisanthus@intel.com,
        edmund.j.dea@intel.com, airlied@linux.ie, daniel@ffwll.ch,
        laurent.pinchart@ideasonboard.com, maxime@cerno.tech,
        ville.syrjala@linux.intel.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Zeng Jingxiang <linuszeng@tencent.com>
References: <20220729030711.2117849-1-zengjx95@gmail.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <20220729030711.2117849-1-zengjx95@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------dFxj7YZV00EUycLoniKD5Q4Y"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------dFxj7YZV00EUycLoniKD5Q4Y
Content-Type: multipart/mixed; boundary="------------sj5f9zrJyPyQK1Z5Zze4SzFW";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Zeng Jingxiang <zengjx95@gmail.com>, anitha.chrisanthus@intel.com,
 edmund.j.dea@intel.com, airlied@linux.ie, daniel@ffwll.ch,
 laurent.pinchart@ideasonboard.com, maxime@cerno.tech,
 ville.syrjala@linux.intel.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Zeng Jingxiang <linuszeng@tencent.com>
Message-ID: <a68022f4-28d0-7743-27fe-6df652082184@suse.de>
Subject: Re: [PATCH] drm/kmb: fix dereference before NULL check in
 kmb_plane_atomic_update()
References: <20220729030711.2117849-1-zengjx95@gmail.com>
In-Reply-To: <20220729030711.2117849-1-zengjx95@gmail.com>

--------------sj5f9zrJyPyQK1Z5Zze4SzFW
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMjkuMDcuMjIgdW0gMDU6MDcgc2NocmllYiBaZW5nIEppbmd4aWFuZzoNCj4g
RnJvbTogWmVuZyBKaW5neGlhbmcgPGxpbnVzemVuZ0B0ZW5jZW50LmNvbT4NCj4gDQo+IFRo
ZSAicGxhbmUiIHBvaW50ZXIgd2FzIGFjY2VzcyBiZWZvcmUgY2hlY2tpbmcgaWYgaXQgd2Fz
IE5VTEwuDQo+IA0KPiBUaGUgZHJtX2F0b21pY19nZXRfb2xkX3BsYW5lX3N0YXRlKCkgZnVu
Y3Rpb24gd2lsbCBkZXJlZmVyZW5jZQ0KPiB0aGUgcG9pbnRlciAicGxhbmUiLg0KPiAzNDUJ
c3RydWN0IGRybV9wbGFuZV9zdGF0ZSAqb2xkX3BsYW5lX3N0YXRlID0NCj4gCQlkcm1fYXRv
bWljX2dldF9vbGRfcGxhbmVfc3RhdGUoc3RhdGUsIHBsYW5lKTsNCj4gMzQ2CXN0cnVjdCBk
cm1fcGxhbmVfc3RhdGUgKm5ld19wbGFuZV9zdGF0ZSA9DQo+IAkJZHJtX2F0b21pY19nZXRf
bmV3X3BsYW5lX3N0YXRlKHN0YXRlLCBwbGFuZSk7DQo+IA0KPiBBIE5VTEwgY2hlY2sgZm9y
ICJwbGFuZSIgaW5kaWNhdGVzIHRoYXQgaXQgbWF5IGJlIE5VTEwNCj4gMzYzCWlmICghcGxh
bmUgfHwgIW5ld19wbGFuZV9zdGF0ZSB8fCAhb2xkX3BsYW5lX3N0YXRlKQ0KDQpJcyB0aGlz
IGFuIGFjdHVhbCBidWcgdGhhdCBoYXBwZW5zPw0KDQpBbGwgcGxhbmVzIHNob3VsZCBhbHdh
eXMgaGF2ZSBhIHN0YXRlLiBUaGVyZWZvcmUgdGhlIHRlc3RzIGZvciANCiFuZXdfcGxhbmVf
c3RhdGUgYW5kICFvbGRfcGxhbmVfc3RhdGUgY2FuIGJlIHJlbW92ZWQsIEknZCBzYXkuDQoN
CkJlc3QgcmVnYXJkcw0KVGhvbWFzDQoNCj4gDQo+IEZpeGVzOiA5Nzc2OTdlMjBiM2QgKCJk
cm0vYXRvbWljOiBQYXNzIHRoZSBmdWxsIHN0YXRlIHRvIHBsYW5lcyBhdG9taWMgZGlzYWJs
ZSBhbmQgdXBkYXRlIikNCj4gRml4ZXM6IDM3NDE4YmYxNGMxMyAoImRybTogVXNlIHN0YXRl
IGhlbHBlciBpbnN0ZWFkIG9mIHRoZSBwbGFuZSBzdGF0ZSBwb2ludGVyIikNCj4gU2lnbmVk
LW9mZi1ieTogWmVuZyBKaW5neGlhbmcgPGxpbnVzemVuZ0B0ZW5jZW50LmNvbT4NCj4gLS0t
DQo+ICAgZHJpdmVycy9ncHUvZHJtL2ttYi9rbWJfcGxhbmUuYyB8IDEzICsrKysrKysrLS0t
LS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9rbWIva21iX3BsYW5lLmMg
Yi9kcml2ZXJzL2dwdS9kcm0va21iL2ttYl9wbGFuZS5jDQo+IGluZGV4IDI3MzViOGViMzUz
Ny4uZDJiYzk5OGI2NWNlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0va21iL2tt
Yl9wbGFuZS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9rbWIva21iX3BsYW5lLmMNCj4g
QEAgLTM0MiwxMCArMzQyLDcgQEAgc3RhdGljIHZvaWQga21iX3BsYW5lX3NldF9hbHBoYShz
dHJ1Y3Qga21iX2RybV9wcml2YXRlICprbWIsDQo+ICAgc3RhdGljIHZvaWQga21iX3BsYW5l
X2F0b21pY191cGRhdGUoc3RydWN0IGRybV9wbGFuZSAqcGxhbmUsDQo+ICAgCQkJCSAgICBz
dHJ1Y3QgZHJtX2F0b21pY19zdGF0ZSAqc3RhdGUpDQo+ICAgew0KPiAtCXN0cnVjdCBkcm1f
cGxhbmVfc3RhdGUgKm9sZF9wbGFuZV9zdGF0ZSA9IGRybV9hdG9taWNfZ2V0X29sZF9wbGFu
ZV9zdGF0ZShzdGF0ZSwNCj4gLQkJCQkJCQkJCQkgcGxhbmUpOw0KPiAtCXN0cnVjdCBkcm1f
cGxhbmVfc3RhdGUgKm5ld19wbGFuZV9zdGF0ZSA9IGRybV9hdG9taWNfZ2V0X25ld19wbGFu
ZV9zdGF0ZShzdGF0ZSwNCj4gLQkJCQkJCQkJCQkgcGxhbmUpOw0KPiArCXN0cnVjdCBkcm1f
cGxhbmVfc3RhdGUgKm9sZF9wbGFuZV9zdGF0ZSwgKm5ld19wbGFuZV9zdGF0ZTsNCj4gICAJ
c3RydWN0IGRybV9mcmFtZWJ1ZmZlciAqZmI7DQo+ICAgCXN0cnVjdCBrbWJfZHJtX3ByaXZh
dGUgKmttYjsNCj4gICAJdW5zaWduZWQgaW50IHdpZHRoOw0KPiBAQCAtMzYwLDcgKzM1Nywx
MyBAQCBzdGF0aWMgdm9pZCBrbWJfcGxhbmVfYXRvbWljX3VwZGF0ZShzdHJ1Y3QgZHJtX3Bs
YW5lICpwbGFuZSwNCj4gICAJc3RhdGljIGRtYV9hZGRyX3QgYWRkcltNQVhfU1VCX1BMQU5F
U107DQo+ICAgCXN0cnVjdCBkaXNwX2NmZyAqaW5pdF9kaXNwX2NmZzsNCj4gICANCj4gLQlp
ZiAoIXBsYW5lIHx8ICFuZXdfcGxhbmVfc3RhdGUgfHwgIW9sZF9wbGFuZV9zdGF0ZSkNCj4g
KwlpZiAoIXBsYW5lKQ0KPiArCQlyZXR1cm47DQo+ICsNCj4gKwlvbGRfcGxhbmVfc3RhdGUg
PSBkcm1fYXRvbWljX2dldF9vbGRfcGxhbmVfc3RhdGUoc3RhdGUsIHBsYW5lKTsNCj4gKwlu
ZXdfcGxhbmVfc3RhdGUgPSBkcm1fYXRvbWljX2dldF9uZXdfcGxhbmVfc3RhdGUoc3RhdGUs
IHBsYW5lKTsNCj4gKw0KPiArCWlmICghbmV3X3BsYW5lX3N0YXRlIHx8ICFvbGRfcGxhbmVf
c3RhdGUpDQo+ICAgCQlyZXR1cm47DQo+ICAgDQo+ICAgCWZiID0gbmV3X3BsYW5lX3N0YXRl
LT5mYjsNCg0KLS0gDQpUaG9tYXMgWmltbWVybWFubg0KR3JhcGhpY3MgRHJpdmVyIERldmVs
b3Blcg0KU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR2VybWFueSBHbWJIDQpNYXhmZWxkc3Ry
LiA1LCA5MDQwOSBOw7xybmJlcmcsIEdlcm1hbnkNCihIUkIgMzY4MDksIEFHIE7DvHJuYmVy
ZykNCkdlc2Now6RmdHNmw7xocmVyOiBJdm8gVG90ZXYNCg==

--------------sj5f9zrJyPyQK1Z5Zze4SzFW--

--------------dFxj7YZV00EUycLoniKD5Q4Y
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmLj7VkFAwAAAAAACgkQlh/E3EQov+Ad
Zg//R4VYlh2BljVqjozhuI2AHSb42lYJ4w8vMJigf0CR6rHQNj3t4FVREFRA6Mgru5ekCUz9+vFy
SFUwg0kZjMr57vT/iWBzm60DNkUSiizkyNXPpwUxW82m11dhtPjsp7nh5rgHVXlbrTjnQNi2M0QJ
Qya+EySc8bUy4Oytczg2pGrJXlY48UlNOnLyUI8ZY8B9Qzm7UlqkMmxqrAeFEfhoPDP/jIG27whs
Y2ip3XcCPtY62+Xj3EiHOsWvCq6cKmJ20u8YRUypij6VuoJWOrJ/vrfj4VwVlEZkP/K/KhOo+5BH
cK75WSOPzzvIZLkuy/qkwHc8NL941+F2gu4d2BPmjgVNwU3QiTW9ezol8XvS+nB5typ0sEN/LTZ+
mFfh8BBoY3aGY1eU1LMOBhC6YO0KGglfuDtedFKXYiHim2AvPLt36uvMjDcEfPOLo2HCmx25mlqT
kkqh0Moe/GR48GW6/soiexuF1NslXd+xvMtOnv+TP0E5e5p4mCysZ6txEmwmJTMpMYwt4VBY32T0
8fPMTSPi8wE+Ej64reX4Ash+ULxBBpW2S61cVknUajrkZiRFrY7Jph1zNeMslOW7A5t0chx3exIQ
sPD0xb2VfKH65x9MTsBqfWpS0aiXn9DWdzXsJrbjYvAPS5/YCnkAhEasCX49WyCsmIshjk2TP9p/
pY0=
=VE1D
-----END PGP SIGNATURE-----

--------------dFxj7YZV00EUycLoniKD5Q4Y--
