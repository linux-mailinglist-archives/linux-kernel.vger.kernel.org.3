Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A3C4B24D2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 12:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349634AbiBKLyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 06:54:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349676AbiBKLy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 06:54:29 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1841F4F;
        Fri, 11 Feb 2022 03:54:28 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 82D691F385;
        Fri, 11 Feb 2022 11:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644580467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y1etk9kWi0O5NdwycnlO0BFYUzATcmm0rxiF8RNzGc8=;
        b=Pf26MYOO3Jz+DVrD3iRjQQ/ihbMjAgtdzGeIPKqgUJ7j1W9cp4s3HmrVOLr2tQhZclqPcU
        lzvh+XC1jUxgtLl1VbaNQdm7zpWAvE82ooW8Rkysxb/VGxIGAthdMlhxffUM28ASUpnPVH
        5lNLO5sVzZ+9N9tzac3CeB4jroebIoE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644580467;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y1etk9kWi0O5NdwycnlO0BFYUzATcmm0rxiF8RNzGc8=;
        b=HIAqNt3ia2fSOQ5iGIvGRWshDG4kYev6ACoVqLRipEC9PRWHKkJpRS3S66sk8jdg3/cFUa
        dtTQyhjDcHJg6NCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 36DF513C27;
        Fri, 11 Feb 2022 11:54:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rzhiDHNOBmIbXQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Fri, 11 Feb 2022 11:54:27 +0000
Message-ID: <7560cd10-0a7c-3fda-da83-9008833e3901@suse.de>
Date:   Fri, 11 Feb 2022 12:54:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 1/6] drm/format-helper: Add
 drm_fb_xrgb8888_to_gray8_line()
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
 <20220211091927.2988283-2-javierm@redhat.com>
 <YgY6OqN+guBlt/ED@smile.fi.intel.com>
 <4fa465d9-4fac-4199-9a04-d8e09d164308@redhat.com>
 <YgZEuXvJ2ZiOyNS+@smile.fi.intel.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <YgZEuXvJ2ZiOyNS+@smile.fi.intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0xO1K6N2o3kisbYAJxbZXbB0"
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
--------------0xO1K6N2o3kisbYAJxbZXbB0
Content-Type: multipart/mixed; boundary="------------qUmUJ7AssDV84KsRHJz5xQ9D";
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
Message-ID: <7560cd10-0a7c-3fda-da83-9008833e3901@suse.de>
Subject: Re: [PATCH v4 1/6] drm/format-helper: Add
 drm_fb_xrgb8888_to_gray8_line()
References: <20220211091927.2988283-1-javierm@redhat.com>
 <20220211091927.2988283-2-javierm@redhat.com>
 <YgY6OqN+guBlt/ED@smile.fi.intel.com>
 <4fa465d9-4fac-4199-9a04-d8e09d164308@redhat.com>
 <YgZEuXvJ2ZiOyNS+@smile.fi.intel.com>
In-Reply-To: <YgZEuXvJ2ZiOyNS+@smile.fi.intel.com>

--------------qUmUJ7AssDV84KsRHJz5xQ9D
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMTEuMDIuMjIgdW0gMTI6MTIgc2NocmllYiBBbmR5IFNoZXZjaGVua286DQo+
IE9uIEZyaSwgRmViIDExLCAyMDIyIGF0IDExOjQwOjEzQU0gKzAxMDAsIEphdmllciBNYXJ0
aW5leiBDYW5pbGxhcyB3cm90ZToNCj4+IE9uIDIvMTEvMjIgMTE6MjgsIEFuZHkgU2hldmNo
ZW5rbyB3cm90ZToNCj4+PiBPbiBGcmksIEZlYiAxMSwgMjAyMiBhdCAxMDoxOToyMkFNICsw
MTAwLCBKYXZpZXIgTWFydGluZXogQ2FuaWxsYXMgd3JvdGU6DQo+IA0KPiAuLi4NCj4gDQo+
Pj4+ICtzdGF0aWMgdm9pZCBkcm1fZmJfeHJnYjg4ODhfdG9fZ3JheThfbGluZSh1OCAqZHN0
LCBjb25zdCB1MzIgKnNyYywgdW5zaWduZWQgaW50IHBpeGVscykNCj4+Pj4gK3sNCj4+Pj4g
Kwl1bnNpZ25lZCBpbnQgeDsNCj4+Pj4gKw0KPj4+PiArCWZvciAoeCA9IDA7IHggPCBwaXhl
bHM7IHgrKykgew0KPj4+PiArCQl1OCByID0gKCpzcmMgJiAweDAwZmYwMDAwKSA+PiAxNjsN
Cj4+Pj4gKwkJdTggZyA9ICgqc3JjICYgMHgwMDAwZmYwMCkgPj4gODsNCj4+Pj4gKwkJdTgg
YiA9ICAqc3JjICYgMHgwMDAwMDBmZjsNCj4+Pj4gKw0KPj4+PiArCQkvKiBJVFUgQlQuNjAx
OiBZID0gMC4yOTkgUiArIDAuNTg3IEcgKyAwLjExNCBCICovDQo+Pj4+ICsJCSpkc3QrKyA9
ICgzICogciArIDYgKiBnICsgYikgLyAxMDsNCj4+Pj4gKwkJc3JjKys7DQo+Pj4+ICsJfQ0K
Pj4+DQo+Pj4gQ2FuIGJlIGRvbmUgYXMNCj4+Pg0KPj4+IAl3aGlsZSAocGl4ZWxzLS0pIHsN
Cj4+PiAJCS4uLg0KPj4+IAl9DQo+Pj4NCj4+PiBvcg0KPj4+DQo+Pj4gCWRvIHsNCj4+PiAJ
CS4uLg0KPj4+IAl9IHdoaWxlICgtLXBpeGVscyk7DQo+Pj4NCj4+DQo+PiBJIGRvbid0IHNl
ZSB3aHkgYSB3aGlsZSBsb29wIHdvdWxkIGJlIGFuIGltcHJvdmVtZW50IGhlcmUgVEJILg0K
PiANCj4gTGVzcyBsZXR0ZXJzIHRvIHBhcnNlIHdoZW4gcmVhZGluZyB0aGUgY29kZS4NCg0K
SXQncyBhIHNpbXBsZSByZWZhY3RvcmluZyBvZiBjb2RlIHRoYXQgaGFzIHdvcmtlZCB3ZWxs
IHNvIGZhci4gTGV0J3MgDQpsZWF2ZSBpdCBhcy1pcyBmb3Igbm93Lg0KDQpCZXN0IHJlZ2Fy
ZHMNClRob21hcw0KDQo+IA0KPj4gSW4gYW55IGNhc2UsIEkganVzdCBwdWxsZWQgdGhlIGxp
bmUgY29udmVyc2lvbiBsb2dpYyBhcyBhIHNlcGFyYXRlDQo+PiBmdW5jdGlvbiB3aXRoIG1p
bmltYWwgY29kZSBjaGFuZ2VzIHNpbmNlIGRvaW5nIHRoYXQgc2hvdWxkIGJlIGluIGENCj4+
IHNlcGFyYXRlIHBhdGNoLg0KPiANCj4gDQo+PiBGZWVsIGZyZWUgdG8gcG9zdCBhIHBhdGNo
IGlmIHlvdSB3YW50IHRvIGNoYW5nZSB0aGF0IHdoaWxlIGxvb3AuDQo+IA0KPiBQZXJoYXBz
IHNvbWUgZGF5IDotKQ0KPiANCg0KLS0gDQpUaG9tYXMgWmltbWVybWFubg0KR3JhcGhpY3Mg
RHJpdmVyIERldmVsb3Blcg0KU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR2VybWFueSBHbWJI
DQpNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcsIEdlcm1hbnkNCihIUkIgMzY4MDks
IEFHIE7DvHJuYmVyZykNCkdlc2Now6RmdHNmw7xocmVyOiBJdm8gVG90ZXYNCg==

--------------qUmUJ7AssDV84KsRHJz5xQ9D--

--------------0xO1K6N2o3kisbYAJxbZXbB0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmIGTnIFAwAAAAAACgkQlh/E3EQov+AX
XQ//QRVvwLs+E6EBTsewgmTs0gsqiBem8AGlHBDXCG7X0k2+MJaQcJs6hCbPs8Qf+Fqd9+YRLWkG
oT4B8qlellyBKrooec4g1AZ4aogboDZI4Whvp0MLRnmk804Ftu0HzmMUFXtMtXGNwmUDbA1Cl2go
FIhVr1Nh1KCbUusJcdoiv2669X7GRr/S3nKhu3yrN5jOvl1vKJGuaND66trG9hikUEmSuQqUx58F
0PNqG/EbdOMF9wfsRDTnWEzzgt8eR/NSaQv+egAGlAGrP4sLIVBFs4pJoaR6AWu6BW6Le2YMA2vO
K2S3uGZwLvTBpt1H39Q0Mu3uCACw47j+GpogllUU6Ooqe24nb27x/4/JC8DJCEEj2Bnt71MpJMk4
kjid5FQr1tCOeu8lXYWHNBmf27FfM0EnS6ZrS9UrHCDgGryde0B7L6Du54ul8oEKczrGXiiBvYRc
h1ZV87XDLrvVSuvnDHNx0zw1N1gEc+5LaW6QsEbcidLHTHwv3btwOyAWRrLkV4oyTHsNsn9gXNEi
pDP4Lu+rUqW1GR4EN5yt6Ub0k8jj1hhdtaXQJcAnSryjGjiWTAf2t+egvSPMSiHme47+CqX11huv
1XVQ5ra/83FhNdzhsl4IlWmlg/GN+W33m+KyMchjFoKFn0mLCeTxWBaNPrIVmdSWhuoMortch14F
wD8=
=K1oE
-----END PGP SIGNATURE-----

--------------0xO1K6N2o3kisbYAJxbZXbB0--
