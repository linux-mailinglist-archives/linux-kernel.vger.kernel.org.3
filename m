Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6765AB643
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 18:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237528AbiIBQLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 12:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236761AbiIBQLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 12:11:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354FE474C3
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 09:05:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0A2001FD29;
        Fri,  2 Sep 2022 16:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1662134706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=joTR8qfjqAfodo09bAqbI7din/cD411BxLLo9KKbVlY=;
        b=BN6HiEeZfWEg3N2usH+xNC5y0ctWslPR5QLPPjXEgRghf3jlxB8KjbVIopEB0XPtCKPYNh
        TJU9yausM8WOOBNX0V7ZOV662manWlaoBtr5g7K4LryGMRoLuZ1uVvNvq0dpgm/oepmYMr
        SjayV8uk0Fr20PxLR2dNCTyK5AQLj5o=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6E6981330E;
        Fri,  2 Sep 2022 16:05:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YCTSGLEpEmNSQwAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 02 Sep 2022 16:05:05 +0000
Message-ID: <72fdfc26-470b-75e3-cfc4-ffce0045b458@suse.com>
Date:   Fri, 2 Sep 2022 18:05:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 01/59] x86/paravirt: Ensure proper alignment
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Eric Dumazet <edumazet@google.com>
References: <20220902130625.217071627@infradead.org>
 <20220902130946.457567054@infradead.org>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20220902130946.457567054@infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------cHQ6nx80DIBVTT99esfI2Gg8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------cHQ6nx80DIBVTT99esfI2Gg8
Content-Type: multipart/mixed; boundary="------------PG3h0UJHf0suwc8jxpCx4sWe";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Tim Chen <tim.c.chen@linux.intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Andrew Cooper <Andrew.Cooper3@citrix.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Johannes Wikner <kwikner@ethz.ch>,
 Alyssa Milburn <alyssa.milburn@linux.intel.com>, Jann Horn
 <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
 Joao Moreira <joao.moreira@intel.com>,
 Joseph Nuzman <joseph.nuzman@intel.com>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 K Prateek Nayak <kprateek.nayak@amd.com>, Eric Dumazet <edumazet@google.com>
Message-ID: <72fdfc26-470b-75e3-cfc4-ffce0045b458@suse.com>
Subject: Re: [PATCH v2 01/59] x86/paravirt: Ensure proper alignment
References: <20220902130625.217071627@infradead.org>
 <20220902130946.457567054@infradead.org>
In-Reply-To: <20220902130946.457567054@infradead.org>

--------------PG3h0UJHf0suwc8jxpCx4sWe
Content-Type: multipart/mixed; boundary="------------0KwzoNt0R5DBcJ5Vj7U8cHFY"

--------------0KwzoNt0R5DBcJ5Vj7U8cHFY
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDIuMDkuMjIgMTU6MDYsIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPiBGcm9tOiBUaG9t
YXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCj4gDQo+IFRoZSBlbnRyaWVzIGlu
IHRoZSAucGFyYWluc3RyIHNlY3Rpb25zIGFyZSA4IGJ5dGUgYWxpZ25lZCBhbmQgdGhlDQo+
IGNvcnJlc3BvbmRpbmcgQyBzdHJ1Y3QgbWFrZXMgdGhlIGFycmF5IG9mZnNldCAxNiBieXRl
cy4NCj4gDQo+IFRob3VnaCB0aGUgcHVzaGVkIGVudHJpZXMgYXJlIG9ubHkgdXNpbmcgMTIg
Ynl0ZXMuIC5wYXJhaW5zdHJfZW5kIGlzDQo+IHRoZXJlZm9yZSA0IGJ5dGVzIHNob3J0Lg0K
PiANCj4gVGhhdCB3b3JrcyBieSBjaGFuY2UgYmVjYXVzZSBpdCdzIG9ubHkgdXNlZCBpbiBh
IGxvb3A6DQo+IA0KPiAgICAgICBmb3IgKHAgPSBzdGFydDsgcCA8IGVuZDsgcCsrKQ0KPiAN
Cj4gQnV0IHRoaXMgZmFsbHMgZmxhdCB3aGVuIGNhbGN1bGF0aW5nIHRoZSBudW1iZXIgb2Yg
ZWxlbWVudHM6DQo+IA0KPiAgICAgIG4gPSBlbmQgLSBzdGFydA0KPiANCj4gVGhhdCdzIG9i
dmlvdXNseSBvZmYgYnkgb25lLg0KPiANCj4gRW5zdXJlIHRoYXQgdGhlIGdhcCBpcyBmaWxs
ZWQgYW5kIHRoZSBsYXN0IGVudHJ5IGlzIG9jY3VweWluZyAxNiBieXRlcy4NCj4gDQo+IENj
OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFRo
b21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPg0KPiBTaWduZWQtb2ZmLWJ5OiBQ
ZXRlciBaaWpsc3RyYSAoSW50ZWwpIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4NCg0KUmV2aWV3
ZWQtYnk6IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4NCg0KDQpKdWVyZ2VuDQo=

--------------0KwzoNt0R5DBcJ5Vj7U8cHFY
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------0KwzoNt0R5DBcJ5Vj7U8cHFY--

--------------PG3h0UJHf0suwc8jxpCx4sWe--

--------------cHQ6nx80DIBVTT99esfI2Gg8
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmMSKbEFAwAAAAAACgkQsN6d1ii/Ey/x
Twf+MPDKMp+PGlyFbRm0A3sKwpQ9CSydynr5WTg0/wDIJObjqHc8F0LbmOWoDxMbibIB6r8nz9zQ
igpPHEerEny6WD+G/8HflM6Uy7lB68sfwm0ZUM9NM4J2dzGSoD7ztcnwgM1X+McT7h8XOIojqkXP
QbyjaCInBJHiz/QXBD+kql/VHsN+JHpLFkutAmMFF2F1S1FnOXEIjrXTVVE3UnaEkiElQvo+HEIT
+K7F98RQYuuHZWQItQn28NnnJwK31cOX3Ym9RpoGAOlsS6L4jE3NPvw9A/PreYYelXdj+6WxM2cC
3US5DRhOxgAaZToiIhIWLyWz+JDCQ/Q4nUbwlDP+BQ==
=Wvdr
-----END PGP SIGNATURE-----

--------------cHQ6nx80DIBVTT99esfI2Gg8--
