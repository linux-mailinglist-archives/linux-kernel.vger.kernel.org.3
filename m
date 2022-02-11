Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4824B252B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 13:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349879AbiBKMDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 07:03:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234446AbiBKL7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 06:59:33 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C7BE6D;
        Fri, 11 Feb 2022 03:59:32 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0F46721128;
        Fri, 11 Feb 2022 11:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644580771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=82bEkV738p0W29VbjyF60qz4BZYeSV7Ls+JNqujf5to=;
        b=HQO77/as2ivaGhrIjJtbRQhL+buQ9hfTbBwcvt63szl7/XyZk/3BG5sJV+RWkdntkb/fh2
        hbXWuiweS3V9dW28WsywJsTMnDtde4pQnHTxBHAHqPucgngcoHcxJOpiJPH3o2+bSLXxNw
        k4Da9fhwIbAThUSim9l4/sEgui7IVAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644580771;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=82bEkV738p0W29VbjyF60qz4BZYeSV7Ls+JNqujf5to=;
        b=jixyRZmUOYK/DKJofMNj8E0blkoPOWiGj2XKnLnK4oav3NwRIgtOT0m62yB220HC8YRQlR
        75jfaIvh/lLAgDAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B330913C29;
        Fri, 11 Feb 2022 11:59:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JzYbKqJPBmJ6XwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Fri, 11 Feb 2022 11:59:30 +0000
Message-ID: <5cffc63b-c42a-df4c-7270-488735c9e014@suse.de>
Date:   Fri, 11 Feb 2022 12:59:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 2/6] drm/format-helper: Add
 drm_fb_xrgb8888_to_mono_reversed()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Sam Ravnborg <sam@ravnborg.org>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>
References: <20220211091927.2988283-1-javierm@redhat.com>
 <20220211091927.2988283-3-javierm@redhat.com>
 <YgZEPo0ERFRloDyA@smile.fi.intel.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <YgZEPo0ERFRloDyA@smile.fi.intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------wbwTiEBTVkRaFTBgyEmt2ZN1"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------wbwTiEBTVkRaFTBgyEmt2ZN1
Content-Type: multipart/mixed; boundary="------------xgrGKoD6EvNiq5zk7QMh2zal";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>, Maxime Ripard
 <maxime@cerno.tech>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 dri-devel@lists.freedesktop.org, Sam Ravnborg <sam@ravnborg.org>,
 =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>
Message-ID: <5cffc63b-c42a-df4c-7270-488735c9e014@suse.de>
Subject: Re: [PATCH v4 2/6] drm/format-helper: Add
 drm_fb_xrgb8888_to_mono_reversed()
References: <20220211091927.2988283-1-javierm@redhat.com>
 <20220211091927.2988283-3-javierm@redhat.com>
 <YgZEPo0ERFRloDyA@smile.fi.intel.com>
In-Reply-To: <YgZEPo0ERFRloDyA@smile.fi.intel.com>

--------------xgrGKoD6EvNiq5zk7QMh2zal
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMTEuMDIuMjIgdW0gMTI6MTAgc2NocmllYiBBbmR5IFNoZXZjaGVua286DQo+
IE9uIEZyaSwgRmViIDExLCAyMDIyIGF0IDEwOjE5OjIzQU0gKzAxMDAsIEphdmllciBNYXJ0
aW5leiBDYW5pbGxhcyB3cm90ZToNCj4+IEFkZCBzdXBwb3J0IHRvIGNvbnZlcnQgZnJvbSBY
UjI0IHRvIHJldmVyc2VkIG1vbm9jaHJvbWUgZm9yIGRyaXZlcnMgdGhhdA0KPj4gY29udHJv
bCBtb25vY2hyb21hdGljIGRpc3BsYXkgcGFuZWxzLCB0aGF0IG9ubHkgaGF2ZSAxIGJpdCBw
ZXIgcGl4ZWwuDQo+Pg0KPj4gVGhlIGZ1bmN0aW9uIGRvZXMgYSBsaW5lLWJ5LWxpbmUgY29u
dmVyc2lvbiBkb2luZyBhbiBpbnRlcm1lZGlhdGUgc3RlcA0KPj4gZmlyc3QgZnJvbSBYUjI0
IHRvIDgtYml0IGdyYXlzY2FsZSBhbmQgdGhlbiB0byByZXZlcnNlZCBtb25vY2hyb21lLg0K
Pj4NCj4+IFRoZSBkcm1fZmJfZ3JheThfdG9fbW9ub19yZXZlcnNlZF9saW5lKCkgaGVscGVy
IHdhcyBiYXNlZCBvbiBjb2RlIGZyb20NCj4+IGRyaXZlcnMvZ3B1L2RybS90aW55L3JlcGFw
ZXIuYyBkcml2ZXIuDQo+IA0KPiAuLi4NCj4gDQo+PiArc3RhdGljIHZvaWQgZHJtX2ZiX2dy
YXk4X3RvX21vbm9fcmV2ZXJzZWRfbGluZSh1OCAqZHN0LCBjb25zdCB1OCAqc3JjLCB1bnNp
Z25lZCBpbnQgcGl4ZWxzLA0KPj4gKwkJCQkJICAgICAgIHVuc2lnbmVkIGludCBzdGFydF9v
ZmZzZXQsIHVuc2lnbmVkIGludCBlbmRfbGVuKQ0KPj4gK3sNCj4+ICsJdW5zaWduZWQgaW50
IHhiLCBpOw0KPj4gKw0KPj4gKwlmb3IgKHhiID0gMDsgeGIgPCBwaXhlbHM7IHhiKyspIHsN
Cj4+ICsJCXVuc2lnbmVkIGludCBzdGFydCA9IDAsIGVuZCA9IDg7DQo+PiArCQl1OCBieXRl
ID0gMHgwMDsNCj4gDQo+PiArCQlpZiAoeGIgPT0gMCAmJiBzdGFydF9vZmZzZXQpDQo+PiAr
CQkJc3RhcnQgPSBzdGFydF9vZmZzZXQ7DQo+IA0KPiBUaGlzIGlzIGludmFyaWFudCB0byB0
aGUgbG9vcCwgY2FuIGJlIG1vdmVkIG91dC4NCj4gDQo+PiArCQlpZiAoeGIgPT0gcGl4ZWxz
IC0gMSAmJiBlbmRfbGVuKQ0KPj4gKwkJCWVuZCA9IGVuZF9sZW47DQo+IA0KPiBEaXR0by4g
SG93ZXZlciBpdCBtYXkgcmVxdWlyZSB0byBmYWN0b3Igb3V0IHRoZSBmb2xsb3dpbmcgbG9v
cCB0byBhIGhlbHBlci4NCg0KU3BsaXR0aW5nIHRoZSBsb29wIGlzIG11Y2ggbmljZXIsIGJ1
dCBsZWF2ZXMgY29ybmVyIGNhc2VzIHdoZXJlIHN0YXJ0IA0KYW5kIGVuZCBpcyBpbiB0aGUg
c2FtZSBieXRlLiBEb2luZyB0aGlzIHNvdW5kcyBsaWtlIGEgcHJlbWF0dXJlIA0Kb3B0aW1p
emF0aW9uIHRvIG1lLg0KDQpCZXN0IHJlZ2FyZHMNClRob21hcw0KDQo+IA0KPj4gKwkJZm9y
IChpID0gc3RhcnQ7IGkgPCBlbmQ7IGkrKykgew0KPj4gKwkJCXVuc2lnbmVkIGludCB4ID0g
eGIgKiA4ICsgaTsNCj4+ICsNCj4+ICsJCQlieXRlID4+PSAxOw0KPj4gKwkJCWlmIChzcmNb
eF0gPj4gNykNCj4+ICsJCQkJYnl0ZSB8PSBCSVQoNyk7DQo+PiArCQl9DQo+PiArCQkqZHN0
KysgPSBieXRlOw0KPj4gKwl9DQo+PiArfQ0KPiANCj4gLi4uDQo+IA0KPj4gKwkvKg0KPj4g
KwkgKiBUaGUgcmV2ZXJzZWQgbW9ubyBkZXN0aW5hdGlvbiBidWZmZXIgY29udGFpbnMgMSBi
aXQgcGVyIHBpeGVsDQo+PiArCSAqIGFuZCBkZXN0aW5hdGlvbiBzY2FubGluZXMgaGF2ZSB0
byBiZSBpbiBtdWx0aXBsZSBvZiA4IHBpeGVscy4NCj4+ICsJICovDQo+PiArCWlmICghZHN0
X3BpdGNoKQ0KPj4gKwkJZHN0X3BpdGNoID0gRElWX1JPVU5EX1VQKGxpbmVwaXhlbHMsIDgp
Ow0KPiANCj4gcm91bmRfdXAoKSA/DQo+IA0KPj4gKwlXQVJOX09OQ0UoZHN0X3BpdGNoICUg
OCAhPSAwLCAiZHN0X3BpdGNoIGlzIG5vdCBhIG11bHRpcGxlIG9mIDhcbiIpOw0KPiANCj4g
DQo+IEkgd291bGQgbW92ZSB0aGlzIHRvIHRoZSBpZiBjb25kaXRpb25hbCwgaS5lLg0KPiAN
Cj4gCWlmIChkc3RfcGl0Y2gpDQo+IAkJV0FSTl9PTkNFKGRzdF9waXRjaCAlIDggIT0gMCwg
ImRzdF9waXRjaCBpcyBub3QgYSBtdWx0aXBsZSBvZiA4XG4iKTsNCj4gCWVsc2UNCj4gCQlk
c3RfcGl0Y2ggPSByb3VuZF91cChsaW5lcGl4ZWxzLCA4KTsNCj4gDQo+PiArCS8qDQo+PiAr
CSAqIFRoZSBjbWEgbWVtb3J5IGlzIHdyaXRlLWNvbWJpbmVkIHNvIHJlYWRzIGFyZSB1bmNh
Y2hlZC4NCj4gDQo+IENNQQ0KPiANCj4+ICsJICogU3BlZWQgdXAgYnkgZmV0Y2hpbmcgb25l
IGxpbmUgYXQgYSB0aW1lLg0KPj4gKwkgKg0KPj4gKwkgKiBBbHNvLCBmb3JtYXQgY29udmVy
c2lvbiBmcm9tIFhSMjQgdG8gcmV2ZXJzZWQgbW9ub2Nocm9tZQ0KPj4gKwkgKiBhcmUgZG9u
ZSBsaW5lLWJ5LWxpbmUgYnV0IGFyZSBjb252ZXJ0ZWQgdG8gOC1iaXQgZ3JheXNjYWxlDQo+
PiArCSAqIGFzIGFuIGludGVybWVkaWF0ZSBzdGVwLg0KPj4gKwkgKg0KPj4gKwkgKiBBbGxv
Y2F0ZSBhIGJ1ZmZlciB0byBiZSB1c2VkIGZvciBib3RoIGNvcHlpbmcgZnJvbSB0aGUgY21h
DQo+PiArCSAqIG1lbW9yeSBhbmQgdG8gc3RvcmUgdGhlIGludGVybWVkaWF0ZSBncmF5c2Nh
bGUgbGluZSBwaXhlbHMuDQo+PiArCSAqLw0KPj4gKwlzcmMzMiA9IGttYWxsb2MobGVuX3Ny
YzMyICsgbGluZXBpeGVscywgR0ZQX0tFUk5FTCk7DQo+IA0KPiBzaXplX2FkZCgpID8NCj4g
DQo+PiArCWlmICghc3JjMzIpDQo+PiArCQlyZXR1cm47DQo+IA0KPiAuLi4NCj4gDQo+PiAr
CS8qDQo+PiArCSAqIEZvciBkYW1hZ2UgaGFuZGxpbmcsIGl0IGlzIHBvc3NpYmxlIHRoYXQg
b25seSBwYXJ0cyBvZiB0aGUgc291cmNlDQo+PiArCSAqIGJ1ZmZlciBpcyBjb3BpZWQgYW5k
IHRoaXMgY291bGQgbGVhZCB0byBzdGFydCBhbmQgZW5kIHBpeGVscyB0aGF0DQo+PiArCSAq
IGFyZSBub3QgYWxpZ25lZCB0byBtdWx0aXBsZSBvZiA4Lg0KPj4gKwkgKg0KPj4gKwkgKiBD
YWxjdWxhdGUgaWYgdGhlIHN0YXJ0IGFuZCBlbmQgcGl4ZWxzIGFyZSBub3QgYWxpZ25lZCBh
bmQgc2V0IHRoZQ0KPj4gKwkgKiBvZmZzZXRzIGZvciB0aGUgcmV2ZXJzZWQgbW9ubyBsaW5l
IGNvbnZlcnNpb24gZnVuY3Rpb24gdG8gYWRqdXN0Lg0KPj4gKwkgKi8NCj4+ICsJc3RhcnRf
b2Zmc2V0ID0gY2xpcC0+eDEgJSA4Ow0KPj4gKwllbmRfbGVuID0gY2xpcC0+eDIgJSA4Ow0K
PiANCj4gQUxJR04oKSA/DQo+IA0KDQotLSANClRob21hcyBaaW1tZXJtYW5uDQpHcmFwaGlj
cyBEcml2ZXIgRGV2ZWxvcGVyDQpTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdt
YkgNCk1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZywgR2VybWFueQ0KKEhSQiAzNjgw
OSwgQUcgTsO8cm5iZXJnKQ0KR2VzY2jDpGZ0c2bDvGhyZXI6IEl2byBUb3Rldg0K

--------------xgrGKoD6EvNiq5zk7QMh2zal--

--------------wbwTiEBTVkRaFTBgyEmt2ZN1
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmIGT6IFAwAAAAAACgkQlh/E3EQov+Bh
JxAAzw9ZS4lQkX6R1q0bqL7cId/VnhuQWrOOxTgWTiH6aKmpJxttqfouigR7W5Qll7luDvgUctHt
BMCO7JcWSoQngWYB5SY3Z5Q31WYfPlk0IkblcQszuLEiBMLuoAqw3kLZO0y3iDbDwCY9ymyMuBor
1eKtf1wB0dEsOowmjKWWivrWry6QqNi/X+PZQzKXlkzny5B1adBHXK1lazvDFY2YGFHZPi8Hxs7Z
LoeprBg1KqCWby5bEVSC9nPUGThM0gPY7wvkHhLoHH+h43y3aqafipiA517bpawaKMjnymsQcdFS
UdqgJvi87gX/P9NQBiUcUwVnuljrVLrA5VP4QH6CNE3+oolzKV3SYV4AbSPo0cAbJU9X7WP9vxt1
qnT5GX566sdjWkFjBYR5l+iaGvn0CJgfBHC/wByG4KjT7XHDoWafZ/lKf4GJX+FV/elJT4xE/GKV
4UALuQSSUv95IocQ3hI6pxUGkGZ3BZVaHDyg3PrRCfRYuTn2bA0Jrm00zq+nVExUho3LHiJRtQQ/
v0w0yLxvf8eDbV6y340EPBTxL156ve5kerJrcGEEkMsgSKS3t9lmfpqyJpcaaUBw/35piet+7U/I
m2R21zgayG67Shn0+n327g6G3jb+nmzYt+Uuvkuk5gO6ErWUv3q+4/QHKnUtlAgH1xWF3zUV5hMa
4rU=
=aP3o
-----END PGP SIGNATURE-----

--------------wbwTiEBTVkRaFTBgyEmt2ZN1--
