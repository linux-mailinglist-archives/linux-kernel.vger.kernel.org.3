Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321904B4522
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 10:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242586AbiBNJEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 04:04:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbiBNJED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 04:04:03 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C025FF0F;
        Mon, 14 Feb 2022 01:03:55 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8502021102;
        Mon, 14 Feb 2022 09:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644829434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W3lMPiTg57Iko6QmDb0Lnn87uO6or+yWRk31NJauq84=;
        b=0ieHyXIAKW2yHHxjqXfbljyCAnHRnXYTitEbxfEPkFbob1DdWgu5RdjJh/gc8h2RyYB4Zw
        k3CEJNqS9FH+mReJXEc2Kqrh3j1S8o+LOPlgY4ihtxL1sFQMzY5cRtmzb5Jnk3sBnjqhbO
        +Fn46meiQRUZ5Tx0owCpauiPOGew2q0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644829434;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W3lMPiTg57Iko6QmDb0Lnn87uO6or+yWRk31NJauq84=;
        b=m1IJPTAHqiI4DsoaH/y8pmiur/j9G2cpZpciP37DP1HoNg0bDM87tmAT+eFRCkDJF9dWBQ
        PSVavyzuKCSy80Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3F9FC139F7;
        Mon, 14 Feb 2022 09:03:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZHcTDvoaCmJbFwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 14 Feb 2022 09:03:54 +0000
Message-ID: <f87ce2fa-6b18-f985-eb86-506ce7103db3@suse.de>
Date:   Mon, 14 Feb 2022 10:03:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 1/6] drm/format-helper: Add
 drm_fb_xrgb8888_to_gray8_line()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-fbdev@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Sam Ravnborg <sam@ravnborg.org>
References: <20220211091927.2988283-1-javierm@redhat.com>
 <20220211091927.2988283-2-javierm@redhat.com>
 <YgY6OqN+guBlt/ED@smile.fi.intel.com>
 <4fa465d9-4fac-4199-9a04-d8e09d164308@redhat.com>
 <YgZEuXvJ2ZiOyNS+@smile.fi.intel.com>
 <7560cd10-0a7c-3fda-da83-9008833e3901@suse.de> <87pmnt7gm3.fsf@intel.com>
 <YgaDj6Wld4b7S6DF@smile.fi.intel.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <YgaDj6Wld4b7S6DF@smile.fi.intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------9r9vdwQSlsgyB0a0sZnBMljM"
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
--------------9r9vdwQSlsgyB0a0sZnBMljM
Content-Type: multipart/mixed; boundary="------------TOhClv0puf9niKOCohE7Cq0Y";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 linux-fbdev@vger.kernel.org, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, =?UTF-8?Q?Noralf_Tr=c3=b8nnes?=
 <noralf@tronnes.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Maxime Ripard <maxime@cerno.tech>, Sam Ravnborg <sam@ravnborg.org>
Message-ID: <f87ce2fa-6b18-f985-eb86-506ce7103db3@suse.de>
Subject: Re: [PATCH v4 1/6] drm/format-helper: Add
 drm_fb_xrgb8888_to_gray8_line()
References: <20220211091927.2988283-1-javierm@redhat.com>
 <20220211091927.2988283-2-javierm@redhat.com>
 <YgY6OqN+guBlt/ED@smile.fi.intel.com>
 <4fa465d9-4fac-4199-9a04-d8e09d164308@redhat.com>
 <YgZEuXvJ2ZiOyNS+@smile.fi.intel.com>
 <7560cd10-0a7c-3fda-da83-9008833e3901@suse.de> <87pmnt7gm3.fsf@intel.com>
 <YgaDj6Wld4b7S6DF@smile.fi.intel.com>
In-Reply-To: <YgaDj6Wld4b7S6DF@smile.fi.intel.com>

--------------TOhClv0puf9niKOCohE7Cq0Y
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMTEuMDIuMjIgdW0gMTY6NDEgc2NocmllYiBBbmR5IFNoZXZjaGVua286DQpb
Li4uXQ0KPj4gSU1PICphbHdheXMqIHByZWZlciBhIGZvciBsb29wIG92ZXIgd2hpbGUgb3Ig
ZG8td2hpbGUuDQo+Pg0KPj4gVGhlIGZvciAoaSA9IDA7IGkgPCBOOyBpKyspIGlzIHN1Y2gg
YSBzdHJvbmcgcGFyYWRpZ20gaW4gQy4gWW91DQo+PiBpbnN0YW50bHkga25vdyBob3cgbWFu
eSB0aW1lcyB5b3UncmUgZ29pbmcgdG8gbG9vcCwgYXQgYSBnbGFuY2UuIE5vdCBzbw0KPj4g
d2l0aCB3aXRoIHRoZSBhbHRlcm5hdGl2ZXMsIHdoaWNoIHNob3VsZCBiZSB1c2VkIHNwYXJp
bmdseS4NCj4gDQo+IHdoaWxlICgpIHt9ICBfaXNfIGEgcGFyYWRpZ20sIGZvci1sb29wIGlz
IHN5bnRheCBzdWdhciBvbiB0b3Agb2YgaXQuDQoNCk5hdywgdGhhdCdzIG5vdCB0cnVlLiBB
biBpZGlvbWF0aWMgZm9yIGxvb3AsIHN1Y2ggYXMgZm9yIChpID0gLi4uOyBpIDwgDQpOOyAr
K2kpLCBpcyBzdWNoIGEgc3Ryb25nIHBhdHRlcm4gdGhhdCBpdCdzIHdheSBiZXR0ZXIgdGhh
biB0aGUgDQpjb3JyZXNwb25kaW5nIHdoaWxlIGxvb3AuDQoNCkJlc3QgcmVnYXJkcw0KVGhv
bWFzDQoNCj4gDQo+PiBBbmQgeWVzLCB0aGUgZG8td2hpbGUgc3VnZ2VzdGVkIGFib3ZlIGlz
IGJ1Z2d5LCBhbmQgeW91IGFjdHVhbGx5IG5lZWQgdG8NCj4+IHN0b3AgYW5kIHRoaW5rIHRv
IHNlZSB3aHkuDQo+IA0KPiBJdCBkZXBlbmRzIGlmIHBpeGVscyBjYW4gYmUgMCBvciBub3Qg
YW5kIGlmIGl0J3Mgbm90LCB0aGVuIGRvZXMgaXQgY29udGFpbiBsYXN0DQo+IG9yIG51bWJl
ci4NCj4gDQo+IFRoZSBkbyB7fSB3aGlsZSAoLS1waXhlbHMpOyBtaWdodCBiZSBidWdneSBp
ZmYgcGl4ZWxzIG1heSBiZSAwLg0KPiANCg0KLS0gDQpUaG9tYXMgWmltbWVybWFubg0KR3Jh
cGhpY3MgRHJpdmVyIERldmVsb3Blcg0KU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR2VybWFu
eSBHbWJIDQpNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcsIEdlcm1hbnkNCihIUkIg
MzY4MDksIEFHIE7DvHJuYmVyZykNCkdlc2Now6RmdHNmw7xocmVyOiBJdm8gVG90ZXYNCg==


--------------TOhClv0puf9niKOCohE7Cq0Y--

--------------9r9vdwQSlsgyB0a0sZnBMljM
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmIKGvkFAwAAAAAACgkQlh/E3EQov+D1
NRAAl0Tkel7hQbmEBYFBk33mWf2ADjIJdNKtcScF65RHWVgK8fsiKWL9EVPJCuWCMaoPpfCBSMko
H4VQEK2ewznQEWCDiWT2dySckU5ThAbj2PemHophTeOE1AhMEsDQc+NmobiLU9uZNN8xLaLIg65d
CtHxdV/wbfLL0n4kR4azCP6fOuaSlT+Bq6qFd9FioGPxpDGlAPB0ogID82N2iNz50X/nD/c8X/Ka
Pbi1wi9vlS7ZKs2VcPTjEto6o1gGe24TngiOazAH0cFgSoWNEgg2d9E38KEfEkpOCSoz54h8zahU
8i9d6UNiRE+Vjvi5JvZ6NYvNZ2iy1l678hudsR/Qxh2v7/1ybluL4Ve1EITFwip1F1Wa+g9HSi8z
YrUqwSmYKmeoc7/hnRVbTPFehGiUSP0Ipf5uYQfsU7fNwpTDQ6/zT5f1OtLVApYJDzZvWrTXsayz
45hNk/Tna5iRAYRgccftRHsHfNadThv94RkNZz/flTSNwU7U5B1b1Jm9rCoWPt0zgUjc/nr3JOqw
fKANq6/yrd476g+1kwZSVq+DI0Zcc/ApvJZSlei7iFtHZc55kMJFTIFaYAZs25QXjewF/qNTl6rU
V6kOzkXfrBWgynNJlVCb6qn5uuKdqrX44/t75wExhqvxPIY52AwX+Cbav7hXUhpLYmi2cQhjU4dY
hzg=
=2OAQ
-----END PGP SIGNATURE-----

--------------9r9vdwQSlsgyB0a0sZnBMljM--
