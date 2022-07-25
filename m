Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D16F57FA94
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 09:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbiGYHzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 03:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbiGYHzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 03:55:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837BCDEAE;
        Mon, 25 Jul 2022 00:55:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3A1591F977;
        Mon, 25 Jul 2022 07:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658735749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YwiyINh2YKKLfdtiarw+bQrH30d/PHkMn5lSmx+kcGQ=;
        b=tA25VmyvmgEELAzhlyfRDAFvxqSBUv3xryJB/oEee55eT5gI8mRgFSQ5mTKOsaE/eOtAfd
        nYntkn5UtmsGMnAUc6Rbbp4c2rZl9SUPBGi3wV7kaBIe4Ep69g9fHARn2jV/NU8K4Nu50O
        DDduKs7N8s0CyWdO482oNBfyTNIR5DQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658735749;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YwiyINh2YKKLfdtiarw+bQrH30d/PHkMn5lSmx+kcGQ=;
        b=PrwJJJvcN2c6dT2lvSxBTg4eU8OgQe+pIRIrYr0gVJmFD68qt9FeiHr6HDA+palJKbe5DY
        1PfzpqinkqcCKdBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0068713A8D;
        Mon, 25 Jul 2022 07:55:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JwDROoRM3mK2YAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 25 Jul 2022 07:55:48 +0000
Message-ID: <c06cccc7-9e7d-5659-c23d-40ca386574b0@suse.de>
Date:   Mon, 25 Jul 2022 09:55:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] fbdev: Make registered_fb[] private to fbmem.c
Content-Language: en-US
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-staging@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Sam Ravnborg <sam@ravnborg.org>, linux-fbdev@vger.kernel.org
References: <20220725075400.68478-1-javierm@redhat.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <20220725075400.68478-1-javierm@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------dvvkHpjn000X4YxaH5fi7KPW"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------dvvkHpjn000X4YxaH5fi7KPW
Content-Type: multipart/mixed; boundary="------------IjtmPP6kmUKIFKrGPr0H8Hi0";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Javier Martinez Canillas <javierm@redhat.com>,
 linux-kernel@vger.kernel.org
Cc: linux-staging@lists.linux.dev,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Daniel Vetter <daniel.vetter@intel.com>,
 Alex Deucher <alexander.deucher@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
 Helge Deller <deller@gmx.de>, Sam Ravnborg <sam@ravnborg.org>,
 linux-fbdev@vger.kernel.org
Message-ID: <c06cccc7-9e7d-5659-c23d-40ca386574b0@suse.de>
Subject: Re: [PATCH] fbdev: Make registered_fb[] private to fbmem.c
References: <20220725075400.68478-1-javierm@redhat.com>
In-Reply-To: <20220725075400.68478-1-javierm@redhat.com>

--------------IjtmPP6kmUKIFKrGPr0H8Hi0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMjUuMDcuMjIgdW0gMDk6NTQgc2NocmllYiBKYXZpZXIgTWFydGluZXogQ2Fu
aWxsYXM6DQo+IEZyb206IERhbmllbCBWZXR0ZXIgPGRhbmllbC52ZXR0ZXJAZmZ3bGwuY2g+
DQo+IA0KPiBObyBkcml2ZXIgYWNjZXNzIHRoaXMgYW55bW9yZSwgZXhjZXB0IGZvciB0aGUg
b2xwYyBkY29uIGZiZGV2IGRyaXZlciBidXQNCj4gdGhhdCBoYXMgYmVlbiBtYXJrZWQgYXMg
YnJva2VuIGFueXdheXMgYnkgY29tbWl0IGRlMDk1MmYyNjdmZiAoInN0YWdpbmc6DQo+IG9s
cGNfZGNvbjogbWFyayBkcml2ZXIgYXMgYnJva2VuIikuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBEYW5pZWwgVmV0dGVyIDxkYW5pZWwudmV0dGVyQGludGVsLmNvbT4NCj4gU2lnbmVkLW9m
Zi1ieTogRGFuaWVsIFZldHRlciA8ZGFuaWVsLnZldHRlckBmZndsbC5jaD4NCj4gUmV2aWV3
ZWQtYnk6IEphdmllciBNYXJ0aW5leiBDYW5pbGxhcyA8amF2aWVybUByZWRoYXQuY29tPg0K
PiBTaWduZWQtb2ZmLWJ5OiBKYXZpZXIgTWFydGluZXogQ2FuaWxsYXMgPGphdmllcm1AcmVk
aGF0LmNvbT4NCg0KQWNrZWQtYnk6IFRob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBz
dXNlLmRlPg0KDQpCZXN0IHJlZ2FyZHMNClRob21hcw0KDQo+IC0tLQ0KPiANCj4gICBkcml2
ZXJzL3ZpZGVvL2ZiZGV2L2NvcmUvZmJtZW0uYyB8IDYgKysrLS0tDQo+ICAgaW5jbHVkZS9s
aW51eC9mYi5oICAgICAgICAgICAgICAgfCA2IC0tLS0tLQ0KPiAgIDIgZmlsZXMgY2hhbmdl
ZCwgMyBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdmlkZW8vZmJkZXYvY29yZS9mYm1lbS5jIGIvZHJpdmVycy92aWRlby9mYmRl
di9jb3JlL2ZibWVtLmMNCj4gaW5kZXggNmFlMWM1ZmExOWY5Li4xZTcwZDhjNjc2NTMgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvdmlkZW8vZmJkZXYvY29yZS9mYm1lbS5jDQo+ICsrKyBi
L2RyaXZlcnMvdmlkZW8vZmJkZXYvY29yZS9mYm1lbS5jDQo+IEBAIC01MSwxMCArNTEsMTAg
QEANCj4gICBzdGF0aWMgREVGSU5FX01VVEVYKHJlZ2lzdHJhdGlvbl9sb2NrKTsNCj4gICAN
Cj4gICBzdHJ1Y3QgZmJfaW5mbyAqcmVnaXN0ZXJlZF9mYltGQl9NQVhdIF9fcmVhZF9tb3N0
bHk7DQo+IC1FWFBPUlRfU1lNQk9MKHJlZ2lzdGVyZWRfZmIpOw0KPiAtDQo+ICAgaW50IG51
bV9yZWdpc3RlcmVkX2ZiIF9fcmVhZF9tb3N0bHk7DQo+IC1FWFBPUlRfU1lNQk9MKG51bV9y
ZWdpc3RlcmVkX2ZiKTsNCj4gKyNkZWZpbmUgZm9yX2VhY2hfcmVnaXN0ZXJlZF9mYihpKQkJ
XA0KPiArCWZvciAoaSA9IDA7IGkgPCBGQl9NQVg7IGkrKykJCVwNCj4gKwkJaWYgKCFyZWdp
c3RlcmVkX2ZiW2ldKSB7fSBlbHNlDQo+ICAgDQo+ICAgYm9vbCBmYl9jZW50ZXJfbG9nbyBf
X3JlYWRfbW9zdGx5Ow0KPiAgIA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9mYi5o
IGIvaW5jbHVkZS9saW51eC9mYi5oDQo+IGluZGV4IDQ1M2MzYjJiNmI4ZS4uMGFmZjc2YmNi
YjAwIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2ZiLmgNCj4gKysrIGIvaW5jbHVk
ZS9saW51eC9mYi5oDQo+IEBAIC02MjcsMTYgKzYyNywxMCBAQCBleHRlcm4gaW50IGZiX2dl
dF9jb2xvcl9kZXB0aChzdHJ1Y3QgZmJfdmFyX3NjcmVlbmluZm8gKnZhciwNCj4gICBleHRl
cm4gaW50IGZiX2dldF9vcHRpb25zKGNvbnN0IGNoYXIgKm5hbWUsIGNoYXIgKipvcHRpb24p
Ow0KPiAgIGV4dGVybiBpbnQgZmJfbmV3X21vZGVsaXN0KHN0cnVjdCBmYl9pbmZvICppbmZv
KTsNCj4gICANCj4gLWV4dGVybiBzdHJ1Y3QgZmJfaW5mbyAqcmVnaXN0ZXJlZF9mYltGQl9N
QVhdOw0KPiAtZXh0ZXJuIGludCBudW1fcmVnaXN0ZXJlZF9mYjsNCj4gICBleHRlcm4gYm9v
bCBmYl9jZW50ZXJfbG9nbzsNCj4gICBleHRlcm4gaW50IGZiX2xvZ29fY291bnQ7DQo+ICAg
ZXh0ZXJuIHN0cnVjdCBjbGFzcyAqZmJfY2xhc3M7DQo+ICAgDQo+IC0jZGVmaW5lIGZvcl9l
YWNoX3JlZ2lzdGVyZWRfZmIoaSkJCVwNCj4gLQlmb3IgKGkgPSAwOyBpIDwgRkJfTUFYOyBp
KyspCQlcDQo+IC0JCWlmICghcmVnaXN0ZXJlZF9mYltpXSkge30gZWxzZQ0KPiAtDQo+ICAg
c3RhdGljIGlubGluZSB2b2lkIGxvY2tfZmJfaW5mbyhzdHJ1Y3QgZmJfaW5mbyAqaW5mbykN
Cj4gICB7DQo+ICAgCW11dGV4X2xvY2soJmluZm8tPmxvY2spOw0KDQotLSANClRob21hcyBa
aW1tZXJtYW5uDQpHcmFwaGljcyBEcml2ZXIgRGV2ZWxvcGVyDQpTVVNFIFNvZnR3YXJlIFNv
bHV0aW9ucyBHZXJtYW55IEdtYkgNCk1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZywg
R2VybWFueQ0KKEhSQiAzNjgwOSwgQUcgTsO8cm5iZXJnKQ0KR2VzY2jDpGZ0c2bDvGhyZXI6
IEl2byBUb3Rldg0K

--------------IjtmPP6kmUKIFKrGPr0H8Hi0--

--------------dvvkHpjn000X4YxaH5fi7KPW
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmLeTIQFAwAAAAAACgkQlh/E3EQov+DS
Mw//ZmvlyqJkhxNldf+1ZCiVpgshWANrIAuheUXaPczR4hUmUGlVK18azel+EkNRTRZ0tdzdFLDu
jQ5icc2R/z9w9oEkZu0i3hLIxSq6QJ3mExt0oucX8CNY7uFihvWeAzgJFuv5wwKnuchcsIk/ZIxc
nXotwICnq4bn+JSoC9lM6M3rzrHGYQbJIcuCNDX7S3WAOveXEM40+D06e8SrAd+220sUWJysZaQF
AaihSuBabbTQzn+M1poA94G55m1IMC3t8AvdfnXBP+iyj8EXtQ39RNzyErhdO8xH1UKxe1WjzXBg
oh9/XUQ5WB0QT2tXPAwzndWBqZExyPlLj2fIh/GSgeTmHYUD59ycnCopsRoxz6/T3D/NTOE9DmsO
PWXzP9MdzkI7uPt3HSV/ux2H1xrH/isscPzgOI9uWiMc2eLuNjiNCIwCUbLOgBkQGNW8t7Ehf/NJ
JceL4rrrPhW1tPPU+pmomnJvuu2s4BUq4/QsxfLuzyFodRlAS4Wu/YtBg/BfvKvLb0w7rsptponn
pAaCSBeEFOVG+dCv2WJOIXaoJvy7sdZtrqA4udNZc/kWyZ0d+LVCN4MY2a41unTvBQulprxNhHfz
dEzCxsP6c9X+kCMowLcxB75x5qwsm8D6KQc6eiKDb0WPhwb6N8BQDklrHs66LFlvvqt3pTO32aiH
egw=
=RKox
-----END PGP SIGNATURE-----

--------------dvvkHpjn000X4YxaH5fi7KPW--
