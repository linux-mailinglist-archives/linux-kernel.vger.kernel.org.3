Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B011E55211C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbiFTPer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 11:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbiFTPep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:34:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B243BCE00
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 08:34:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 69BD121A37;
        Mon, 20 Jun 2022 15:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655739283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ACoOTC2stnarzxryygTxid+tfZOlr5PbEG8RRUFLwi8=;
        b=H3a/JMLM1Dr5ocBo4uC4Ohfb/QWojMoWb6FZRQfCFMKGr9SBY4x6Jp9IT9avM7jfOYh9tE
        cthAzt5hRvfOCtsBsMiSzNg6hslRkSWmp4FPU0XDZXD4IxhDaqG9pWYBnJZ8GJlYu2djbq
        M77Z4uBU6VoCGZp5x0uWx6hCbp9rUH0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1145513638;
        Mon, 20 Jun 2022 15:34:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id a+HBApOTsGJ3fwAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 20 Jun 2022 15:34:43 +0000
Message-ID: <ddb0cc0d-cefc-4f33-23f8-3a94c7c51a49@suse.com>
Date:   Mon, 20 Jun 2022 17:34:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/2] x86/pat: fix x86_has_pat_wp()
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, jbeulich@suse.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20220503132207.17234-1-jgross@suse.com>
 <20220503132207.17234-2-jgross@suse.com> <YrBLU2C5cJoalnax@zn.tnic>
 <1cfde4bf-241f-d94c-ffd7-2a11cf9aa1f2@suse.com>
 <63ccccac-2aa7-8850-9cd3-a8b7b89e1872@intel.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <63ccccac-2aa7-8850-9cd3-a8b7b89e1872@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0we9pLFkJBVTNxTMON0yDeQD"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------0we9pLFkJBVTNxTMON0yDeQD
Content-Type: multipart/mixed; boundary="------------iPeeSZwKgEsGXEdaV0RlhR0A";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Dave Hansen <dave.hansen@intel.com>, Borislav Petkov <bp@alien8.de>
Cc: xen-devel@lists.xenproject.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, jbeulich@suse.com,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <ddb0cc0d-cefc-4f33-23f8-3a94c7c51a49@suse.com>
Subject: Re: [PATCH 1/2] x86/pat: fix x86_has_pat_wp()
References: <20220503132207.17234-1-jgross@suse.com>
 <20220503132207.17234-2-jgross@suse.com> <YrBLU2C5cJoalnax@zn.tnic>
 <1cfde4bf-241f-d94c-ffd7-2a11cf9aa1f2@suse.com>
 <63ccccac-2aa7-8850-9cd3-a8b7b89e1872@intel.com>
In-Reply-To: <63ccccac-2aa7-8850-9cd3-a8b7b89e1872@intel.com>

--------------iPeeSZwKgEsGXEdaV0RlhR0A
Content-Type: multipart/mixed; boundary="------------Ik6WguhLVV1z6SqwyzSmNVps"

--------------Ik6WguhLVV1z6SqwyzSmNVps
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjAuMDYuMjIgMTc6MjcsIERhdmUgSGFuc2VuIHdyb3RlOg0KPiBPbiA2LzIwLzIyIDAz
OjQxLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPj4+IEJ1dCBJJ20gb25seSBndWVzc2luZyAt
IHRoaXMgbmVlZHMgYSAqbG90KiBtb3JlIGVsYWJvcmF0aW9uIGFuZA0KPj4+IGV4cGxhbmF0
aW9uIHdoeSBleGFjdGx5IHRoaXMgaXMgbmVlZGVkLg0KPj4NCj4+IEkgd2lsbCBjb3JyZWN0
IHRoZSBjb2RlIGFuZCB1cGRhdGUgdGhlIGNvbW1pdCBtZXNzYWdlLg0KPiANCj4gSXQgd291
bGQgYWxzbyBiZSBncmVhdCB0byBjb3ZlciB0aGUgZW5kLXVzZXItdmlzaWJsZSBpbXBhY3Qg
b2YgdGhlIGJ1Zw0KPiBhbmQgdGhlIGZpeC4gIEl0IF9sb29rc18gbGlrZSBpdCB3aWxsIHBy
b2JhYmx5IG9ubHkgYWZmZWN0IGFuIFNFVg0KPiBzeXN0ZW0ncyBhYmlsaXR5IHRvIHJlYWQg
c29tZSBFRkkgZGF0YS4gIFRoYXQgd2lsbCBwcmVzdW1hYmx5IGJlIHByZXR0eQ0KPiBiYWQg
YmVjYXVzZSBpdCBlbmRzIHVwIHJlYWRpbmcgZnJvbSBhbiBlbmNyeXB0ZWQgbWFwcGluZyBp
bnN0ZWFkIG9mIGENCj4gZGVjcnlwdGVkIG9uZS4NCg0KWGVuIGRvZXNuJ3Qgc3VwcG9ydCBT
RVYgZ3Vlc3RzIHlldC4gU28gdGhlIG9ubHkgY2F2ZWF0IGhlcmUgd291bGQgYmUgRUZJDQpz
ZXR0aW5nIHVwIFBBVCBieSBpdHNlbGYuDQoNCk5vdCBzdXJlIHRoaXMgaXMgcmVhbGx5IGEg
cmVhbCB3b3JsZCBpc3N1ZS4NCg0KDQpKdWVyZ2VuDQo=
--------------Ik6WguhLVV1z6SqwyzSmNVps
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------Ik6WguhLVV1z6SqwyzSmNVps--

--------------iPeeSZwKgEsGXEdaV0RlhR0A--

--------------0we9pLFkJBVTNxTMON0yDeQD
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmKwk5IFAwAAAAAACgkQsN6d1ii/Ey8c
oAf/Tm/GXq1f93iDng9MUWcolmpgjyI+fikteB4dq/37A/h/SsPHjcq5sNH3u1wDAOBPGmG0VCjt
1o6GeZZTPbTwbhKzScy5GZEMRvxVi3CtLc4DTNnJdENnYFAraKRftqEX82hBkqWBiW8OxpT7yl7m
bW+zbuE76dGSxAs8uw9jjTjK+f82NVtBpOR2qluCpnoGvOY7MOS3NW6Jeoj6NaITJmosY+iBQa8h
1yMY307n1KqB3Djz4Lwv/sISeS6uxroVIs0aCieke/7lmbnCl48zYL+24kSFWZ17j05LuJNwKYLN
X9Xu8Y9X5Afhs4A5zxjwlrLbF1MWtNIXlExtJ+McgQ==
=OupB
-----END PGP SIGNATURE-----

--------------0we9pLFkJBVTNxTMON0yDeQD--
