Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F094051849F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 14:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbiECM54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 08:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbiECM5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 08:57:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4BC1EEF6
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 05:54:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AC9E71F74B;
        Tue,  3 May 2022 12:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651582455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OZcRYDL4mo/Uhq/Ypcn1akCbXvaz/7KYmlPdJUuwMeo=;
        b=biIOAekYyM13tqEMQ28BFriAekeD8a8AL/u0Thmc3kejLomQk8x2mqufl//RjpRJeKs/wv
        FMbdjUnDp7papJ/a10PQHD0jcN0KjaPcfSTpCUVcp+hZqquEHVst6HhCQc0AXUnTx/ywJI
        V/RjrV380KENZxqZIUyTpGa7Vg+SrIc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 77C8713ABE;
        Tue,  3 May 2022 12:54:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PoIyG/clcWIcOgAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 03 May 2022 12:54:15 +0000
Message-ID: <b8b559d6-3599-849b-e031-72b4ef76859e@suse.com>
Date:   Tue, 3 May 2022 14:54:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] x86/PAT: have pat_enabled() properly reflect state when
 running on e.g. Xen
Content-Language: en-US
To:     Jan Beulich <jbeulich@suse.com>,
        Andrew Lutomirski <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
References: <9385fa60-fa5d-f559-a137-6608408f88b0@suse.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <9385fa60-fa5d-f559-a137-6608408f88b0@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------aJOfws9bZypWvjfxLcnIg1K0"
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------aJOfws9bZypWvjfxLcnIg1K0
Content-Type: multipart/mixed; boundary="------------oBvhHoX6mHtzA39drHHbQU0z";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Jan Beulich <jbeulich@suse.com>, Andrew Lutomirski <luto@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Message-ID: <b8b559d6-3599-849b-e031-72b4ef76859e@suse.com>
Subject: Re: [PATCH] x86/PAT: have pat_enabled() properly reflect state when
 running on e.g. Xen
References: <9385fa60-fa5d-f559-a137-6608408f88b0@suse.com>
In-Reply-To: <9385fa60-fa5d-f559-a137-6608408f88b0@suse.com>

--------------oBvhHoX6mHtzA39drHHbQU0z
Content-Type: multipart/mixed; boundary="------------Md7kWjLHF562CX34UgSWxu3K"

--------------Md7kWjLHF562CX34UgSWxu3K
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjguMDQuMjIgMTY6NTAsIEphbiBCZXVsaWNoIHdyb3RlOg0KPiBUaGUgbGF0ZXN0IHdp
dGggY29tbWl0IGJkZDhiNmM5ODIzOSAoImRybS9pOTE1OiByZXBsYWNlIFg4Nl9GRUFUVVJF
X1BBVA0KPiB3aXRoIHBhdF9lbmFibGVkKCkiKSBwYXRfZW5hYmxlZCgpIHJldHVybmluZyBm
YWxzZSAoYmVjYXVzZSBvZiBQQVQNCj4gaW5pdGlhbGl6YXRpb24gYmVpbmcgc3VwcHJlc3Nl
ZCBpbiB0aGUgYWJzZW5jZSBvZiBNVFJScyBiZWluZyBhbm5vdW5jZWQNCj4gdG8gYmUgYXZh
aWxhYmxlKSBoYXMgYmVjb21lIGEgcHJvYmxlbTogVGhlIGk5MTUgZHJpdmVyIG5vdyBmYWls
cyB0bw0KPiBpbml0aWFsaXplIHdoZW4gcnVubmluZyBQViBvbiBYZW4gKGk5MTVfZ2VtX29i
amVjdF9waW5fbWFwKCkgaXMgd2hlcmUgSQ0KPiBsb2NhdGVkIHRoZSBpbmR1Y2VkIGZhaWx1
cmUpLCBhbmQgaXRzIGVycm9yIGhhbmRsaW5nIGlzIGZsYWt5IGVub3VnaCB0bw0KPiAoYXQg
bGVhc3Qgc29tZXRpbWVzKSByZXN1bHQgaW4gYSBodW5nIHN5c3RlbS4NCj4gDQo+IFlldCBl
dmVuIGJleW9uZCB0aGF0IHByb2JsZW0gdGhlIGtleWluZyBvZiB0aGUgdXNlIG9mIFdDIG1h
cHBpbmdzIHRvDQo+IHBhdF9lbmFibGVkKCkgKHNlZSBhcmNoX2Nhbl9wY2lfbW1hcF93Yygp
KSBtZWFucyB0aGF0IGluIHBhcnRpY3VsYXINCj4gZ3JhcGhpY3MgZnJhbWUgYnVmZmVyIGFj
Y2Vzc2VzIHdvdWxkIGhhdmUgYmVlbiBxdWl0ZSBhIGJpdCBsZXNzDQo+IHBlcmZvcm1hbnQg
dGhhbiBwb3NzaWJsZS4NCj4gDQo+IEFycmFuZ2UgZm9yIHRoZSBmdW5jdGlvbiB0byByZXR1
cm4gdHJ1ZSBpbiBzdWNoIGVudmlyb25tZW50cywgd2l0aG91dA0KPiB1bmRlcm1pbmluZyB0
aGUgcmVzdCBvZiBQQVQgTVNSIG1hbmFnZW1lbnQgbG9naWMgY29uc2lkZXJpbmcgUEFUIHRv
IGJlDQo+IGRpc2FibGVkOiBTcGVjaWZpY2FsbHksIG5vIHdyaXRlcyB0byB0aGUgUEFUIE1T
UiBzaG91bGQgb2NjdXIuDQo+IA0KPiBGb3IgdGhlIG5ldyBib29sZWFuIHRvIGxpdmUgaW4g
LmluaXQuZGF0YSwgaW5pdF9jYWNoZV9tb2RlcygpIGFsc28gbmVlZHMNCj4gbW92aW5nIHRv
IC5pbml0LnRleHQgKHdoZXJlIGl0IGNvdWxkL3Nob3VsZCBoYXZlIGxpdmVkIGFscmVhZHkg
YmVmb3JlKS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEphbiBCZXVsaWNoIDxqYmV1bGljaEBz
dXNlLmNvbT4NCg0KSSB0aGluayB0aGlzIGFwcHJvYWNoIGlzbid0IHRoZSBiZXN0IHdheSB0
byB0YWNrbGUgdGhlIGlzc3VlLg0KDQpJdCBjYW4gYmUgc29sdmVkIHJhdGhlciBlYXNpbHkg
Ynkgbm90IGRlcml2aW5nIHRoZSBzdXBwb3J0ZWQgY2FjaGluZw0KbW9kZXMgdmlhIHBhdF9l
bmFibGVkKCksIGJ1dCBieSBhZGRpbmcgc3BlY2lmaWMgZnVuY3Rpb25zIHRvIHF1ZXJ5DQp0
aGUgbmVlZGVkIGNhY2hpbmcgbW9kZSBmcm9tIHRoZSBQQVQgdHJhbnNsYXRpb24gdGFibGVz
LCBhbmQgdG8gdXNlDQp0aG9zZSBmdW5jdGlvbnMgaW5zdGVhZCBvZiBwYXRfZW5hYmxlZCgp
Lg0KDQpJJ20gcHJlcGFyaW5nIGEgcGF0Y2ggZm9yIHRoYXQgcHVycG9zZS4NCg0KDQpKdWVy
Z2VuDQo=
--------------Md7kWjLHF562CX34UgSWxu3K
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------Md7kWjLHF562CX34UgSWxu3K--

--------------oBvhHoX6mHtzA39drHHbQU0z--

--------------aJOfws9bZypWvjfxLcnIg1K0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmJxJfcFAwAAAAAACgkQsN6d1ii/Ey+3
Igf7BpIQ8c6ysulqPCIkyEw3p1kCKxgP8JBGblJfEGGMlO+cXYd7OFSAs/ANtJ+zR+pwlHZiAfn5
f7LPqjkF4EEyuixC8yTApbuqf+6N4mB4IvG/V/yAv29LT4H9mZCa7kPjrCWVdKFBWDZgP2UNXvUJ
60WWO1Bq8L7yLNKTfuxZj08Zk6AqIy8NMWBN7JeGeKqxa09IDcDVakEsmA2jAqQ4qbZVSf3X7+hl
Bqccd+byU5CuC34hELfGdu2h1tU6d9u53Qxr0AqmE74QqlFLH4RnBOtoaKOkjUoFhk2cpsebumt2
h3AhEncj3eX/WsYkbkdtHPm2K6n7ELaehRcqrDjbjw==
=EF2j
-----END PGP SIGNATURE-----

--------------aJOfws9bZypWvjfxLcnIg1K0--
