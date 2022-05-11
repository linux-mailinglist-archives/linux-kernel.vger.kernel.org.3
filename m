Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2CB523443
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 15:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243709AbiEKNc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 09:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243673AbiEKNcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:32:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2059BA9AD
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 06:32:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A2B6F21C93;
        Wed, 11 May 2022 13:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652275968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jwd63v7lM58rzCcC/SeHOGCmmqEIrOQ6hior6FOrAsw=;
        b=RkkG4PsfRkKOQo0aSx0z20CSNuaT2/RKL2+NLM/u3xK9ZSnJS4cDwl1uZNr40hPbQHKfrU
        x3fQtf9Fufmb0lvMZCdfsIqn1LTqGX+LgUAv9nD4DmL8IfEVM46x4ZvGWbBxSGYwj2ufq/
        a4Vd0ymq8LSv/32Nv/O6HflkJlh9Em8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 67BCD139F9;
        Wed, 11 May 2022 13:32:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cKjWFwC7e2KaBwAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 11 May 2022 13:32:48 +0000
Message-ID: <23237c6d-4ec7-fd13-e2bd-4ce4c071ec6b@suse.com>
Date:   Wed, 11 May 2022 15:32:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] x86/PAT: have pat_enabled() properly reflect state when
 running on e.g. Xen
Content-Language: en-US
From:   Juergen Gross <jgross@suse.com>
To:     Jan Beulich <jbeulich@suse.com>,
        Andrew Lutomirski <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
References: <9385fa60-fa5d-f559-a137-6608408f88b0@suse.com>
 <b8b559d6-3599-849b-e031-72b4ef76859e@suse.com>
In-Reply-To: <b8b559d6-3599-849b-e031-72b4ef76859e@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------AavKBMlBKEa0ldRixEb4hmW0"
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------AavKBMlBKEa0ldRixEb4hmW0
Content-Type: multipart/mixed; boundary="------------MPly0KBQY1Zw5ebu8eRMgFFB";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Jan Beulich <jbeulich@suse.com>, Andrew Lutomirski <luto@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Message-ID: <23237c6d-4ec7-fd13-e2bd-4ce4c071ec6b@suse.com>
Subject: Re: [PATCH] x86/PAT: have pat_enabled() properly reflect state when
 running on e.g. Xen
References: <9385fa60-fa5d-f559-a137-6608408f88b0@suse.com>
 <b8b559d6-3599-849b-e031-72b4ef76859e@suse.com>
In-Reply-To: <b8b559d6-3599-849b-e031-72b4ef76859e@suse.com>

--------------MPly0KBQY1Zw5ebu8eRMgFFB
Content-Type: multipart/mixed; boundary="------------Ips0c0oo1GWoitmVNUvRPLrM"

--------------Ips0c0oo1GWoitmVNUvRPLrM
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDMuMDUuMjIgMTQ6NTQsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+IE9uIDI4LjA0LjIy
IDE2OjUwLCBKYW4gQmV1bGljaCB3cm90ZToNCj4+IFRoZSBsYXRlc3Qgd2l0aCBjb21taXQg
YmRkOGI2Yzk4MjM5ICgiZHJtL2k5MTU6IHJlcGxhY2UgWDg2X0ZFQVRVUkVfUEFUDQo+PiB3
aXRoIHBhdF9lbmFibGVkKCkiKSBwYXRfZW5hYmxlZCgpIHJldHVybmluZyBmYWxzZSAoYmVj
YXVzZSBvZiBQQVQNCj4+IGluaXRpYWxpemF0aW9uIGJlaW5nIHN1cHByZXNzZWQgaW4gdGhl
IGFic2VuY2Ugb2YgTVRSUnMgYmVpbmcgYW5ub3VuY2VkDQo+PiB0byBiZSBhdmFpbGFibGUp
IGhhcyBiZWNvbWUgYSBwcm9ibGVtOiBUaGUgaTkxNSBkcml2ZXIgbm93IGZhaWxzIHRvDQo+
PiBpbml0aWFsaXplIHdoZW4gcnVubmluZyBQViBvbiBYZW4gKGk5MTVfZ2VtX29iamVjdF9w
aW5fbWFwKCkgaXMgd2hlcmUgSQ0KPj4gbG9jYXRlZCB0aGUgaW5kdWNlZCBmYWlsdXJlKSwg
YW5kIGl0cyBlcnJvciBoYW5kbGluZyBpcyBmbGFreSBlbm91Z2ggdG8NCj4+IChhdCBsZWFz
dCBzb21ldGltZXMpIHJlc3VsdCBpbiBhIGh1bmcgc3lzdGVtLg0KPj4NCj4+IFlldCBldmVu
IGJleW9uZCB0aGF0IHByb2JsZW0gdGhlIGtleWluZyBvZiB0aGUgdXNlIG9mIFdDIG1hcHBp
bmdzIHRvDQo+PiBwYXRfZW5hYmxlZCgpIChzZWUgYXJjaF9jYW5fcGNpX21tYXBfd2MoKSkg
bWVhbnMgdGhhdCBpbiBwYXJ0aWN1bGFyDQo+PiBncmFwaGljcyBmcmFtZSBidWZmZXIgYWNj
ZXNzZXMgd291bGQgaGF2ZSBiZWVuIHF1aXRlIGEgYml0IGxlc3MNCj4+IHBlcmZvcm1hbnQg
dGhhbiBwb3NzaWJsZS4NCj4+DQo+PiBBcnJhbmdlIGZvciB0aGUgZnVuY3Rpb24gdG8gcmV0
dXJuIHRydWUgaW4gc3VjaCBlbnZpcm9ubWVudHMsIHdpdGhvdXQNCj4+IHVuZGVybWluaW5n
IHRoZSByZXN0IG9mIFBBVCBNU1IgbWFuYWdlbWVudCBsb2dpYyBjb25zaWRlcmluZyBQQVQg
dG8gYmUNCj4+IGRpc2FibGVkOiBTcGVjaWZpY2FsbHksIG5vIHdyaXRlcyB0byB0aGUgUEFU
IE1TUiBzaG91bGQgb2NjdXIuDQo+Pg0KPj4gRm9yIHRoZSBuZXcgYm9vbGVhbiB0byBsaXZl
IGluIC5pbml0LmRhdGEsIGluaXRfY2FjaGVfbW9kZXMoKSBhbHNvIG5lZWRzDQo+PiBtb3Zp
bmcgdG8gLmluaXQudGV4dCAod2hlcmUgaXQgY291bGQvc2hvdWxkIGhhdmUgbGl2ZWQgYWxy
ZWFkeSBiZWZvcmUpLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEphbiBCZXVsaWNoIDxqYmV1
bGljaEBzdXNlLmNvbT4NCj4gDQo+IEkgdGhpbmsgdGhpcyBhcHByb2FjaCBpc24ndCB0aGUg
YmVzdCB3YXkgdG8gdGFja2xlIHRoZSBpc3N1ZS4NCj4gDQo+IEl0IGNhbiBiZSBzb2x2ZWQg
cmF0aGVyIGVhc2lseSBieSBub3QgZGVyaXZpbmcgdGhlIHN1cHBvcnRlZCBjYWNoaW5nDQo+
IG1vZGVzIHZpYSBwYXRfZW5hYmxlZCgpLCBidXQgYnkgYWRkaW5nIHNwZWNpZmljIGZ1bmN0
aW9ucyB0byBxdWVyeQ0KPiB0aGUgbmVlZGVkIGNhY2hpbmcgbW9kZSBmcm9tIHRoZSBQQVQg
dHJhbnNsYXRpb24gdGFibGVzLCBhbmQgdG8gdXNlDQo+IHRob3NlIGZ1bmN0aW9ucyBpbnN0
ZWFkIG9mIHBhdF9lbmFibGVkKCkuDQo+IA0KPiBJJ20gcHJlcGFyaW5nIGEgcGF0Y2ggZm9y
IHRoYXQgcHVycG9zZS4NCg0KVGhhdCBhdHRlbXB0IHdhcyBub3QgYSBjb21wbGV0ZSBzdWNj
ZXNzLg0KDQpFc3BlY2lhbGx5IHRoZXJlIGFyZSBpc3N1ZXMgd2l0aCBteSBhcHByb2FjaCB3
aGVuICJub3BhdCIgaGFzIGJlZW4NCnNwZWNpZmllZCBhcyBib290IHBhcmFtZXRlciwgYXMg
dGhhdCB3b3VsZCBiZSBqdXN0IGlnbm9yZWQuDQoNClNvIHJpZ2h0IG5vdyBJIGNhbid0IHRo
aW5rIG9mIGEgYmV0dGVyIGFwcHJvYWNoIHRoYW4gdGhlIG9uZSBvZiBKYW4ncw0KcGF0Y2gu
DQoNCg0KSnVlcmdlbg0K
--------------Ips0c0oo1GWoitmVNUvRPLrM
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------Ips0c0oo1GWoitmVNUvRPLrM--

--------------MPly0KBQY1Zw5ebu8eRMgFFB--

--------------AavKBMlBKEa0ldRixEb4hmW0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmJ7uwAFAwAAAAAACgkQsN6d1ii/Ey8i
FwgAgUuBfM4xSByIe0K7S4WShhmmmxfycYBb+tJq2OLkFHtV8mWauqEjvmW/DclycEYdoTW/3KeG
Jio7fSP+bxH81f81j0/QV5F0Tv7IIumdzasXKj9H29lrwK/4Gbcbz/1gwQ8wOBackhqWHdJOXzs+
EEDDkHL9H2iOrRZgspdeJhXQ5rcj0Nxf6P5pWfEYRA2dcNTWYpZJxzuwYDm6MYyK4mFFrfbgyqBX
aOjEWBbomjbSZhUDa4wfcj5fV27V7JbC39NvrWf3LF/Qhtwy1m6m6RvmMlvadIY/tPvtA7zTHS5S
uKxom25fc5r+cn6lY2IBbx7crIfcIytjkK17Vl4ZCg==
=NVep
-----END PGP SIGNATURE-----

--------------AavKBMlBKEa0ldRixEb4hmW0--
