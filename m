Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A501535E13
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 12:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350909AbiE0KVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 06:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241726AbiE0KVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 06:21:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB58E12814A
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 03:21:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4DC8A1F936;
        Fri, 27 May 2022 10:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653646861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xAM3Ec0PKi3Ngq/xxr1XceNguttOrlHFme46602QGLY=;
        b=YsbUSIhDUXjWsYbpBNMVvCyZukqf8EvB0zvuQ4yH+d7GjCleieDYelNA2cGP0F//99s+Ue
        ToJ6FTLSJ6VFOkq4EfPNrmAKWkNgVS027oCLQFUyL7simZTXq/XJz9Po5YWhud2gVobnVm
        4zcqgJ+yoLudnYatHInVTsfIpHwYYFw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E3F7213A84;
        Fri, 27 May 2022 10:21:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TScpNgymkGLIagAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 27 May 2022 10:21:00 +0000
Message-ID: <520d410e-7e71-971e-d21b-2c6dba20cd54@suse.com>
Date:   Fri, 27 May 2022 12:21:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/2] x86/pat: fix x86_has_pat_wp()
Content-Language: en-US
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jbeulich@suse.com, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20220503132207.17234-1-jgross@suse.com>
 <20220503132207.17234-2-jgross@suse.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20220503132207.17234-2-jgross@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------MkRkfbgkkUf00fAmq0kPBdET"
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------MkRkfbgkkUf00fAmq0kPBdET
Content-Type: multipart/mixed; boundary="------------yEQlXVLdARc0U5tAjrkATLvX";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: xen-devel@lists.xenproject.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: jbeulich@suse.com, Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <520d410e-7e71-971e-d21b-2c6dba20cd54@suse.com>
Subject: Re: [PATCH 1/2] x86/pat: fix x86_has_pat_wp()
References: <20220503132207.17234-1-jgross@suse.com>
 <20220503132207.17234-2-jgross@suse.com>
In-Reply-To: <20220503132207.17234-2-jgross@suse.com>

--------------yEQlXVLdARc0U5tAjrkATLvX
Content-Type: multipart/mixed; boundary="------------TQoYAv19500hJH39vxNvHQJG"

--------------TQoYAv19500hJH39vxNvHQJG
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

UGluZz8NCg0KT24gMDMuMDUuMjIgMTU6MjIsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+IHg4
Nl9oYXNfcGF0X3dwKCkgaXMgdXNpbmcgYSB3cm9uZyB0ZXN0LCBhcyBpdCByZWxpZXMgb24g
dGhlIG5vcm1hbA0KPiBQQVQgY29uZmlndXJhdGlvbiB1c2VkIGJ5IHRoZSBrZXJuZWwuIElu
IGNhc2UgdGhlIFBBVCBNU1IgaGFzIGJlZW4NCj4gc2V0dXAgYnkgYW5vdGhlciBlbnRpdHkg
KGUuZy4gQklPUyBvciBYZW4gaHlwZXJ2aXNvcikgaXQgbWlnaHQgcmV0dXJuDQo+IGZhbHNl
IGV2ZW4gaWYgdGhlIFBBVCBjb25maWd1cmF0aW9uIGlzIGFsbG93aW5nIFdQIG1hcHBpbmdz
Lg0KPiANCj4gRml4ZXM6IDFmNmY2NTVlMDFhZCAoIng4Ni9tbTogQWRkIGEgeDg2X2hhc19w
YXRfd3AoKSBoZWxwZXIiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jv
c3NAc3VzZS5jb20+DQo+IC0tLQ0KPiAgIGFyY2gveDg2L21tL2luaXQuYyB8IDMgKystDQo+
ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L21tL2luaXQuYyBiL2FyY2gveDg2L21tL2luaXQu
Yw0KPiBpbmRleCBkOGNmY2UyMjEyNzUuLjcxZTE4MmViY2VkMyAxMDA2NDQNCj4gLS0tIGEv
YXJjaC94ODYvbW0vaW5pdC5jDQo+ICsrKyBiL2FyY2gveDg2L21tL2luaXQuYw0KPiBAQCAt
ODAsNyArODAsOCBAQCBzdGF0aWMgdWludDhfdCBfX3B0ZTJjYWNoZW1vZGVfdGJsWzhdID0g
ew0KPiAgIC8qIENoZWNrIHRoYXQgdGhlIHdyaXRlLXByb3RlY3QgUEFUIGVudHJ5IGlzIHNl
dCBmb3Igd3JpdGUtcHJvdGVjdCAqLw0KPiAgIGJvb2wgeDg2X2hhc19wYXRfd3Aodm9pZCkN
Cj4gICB7DQo+IC0JcmV0dXJuIF9fcHRlMmNhY2hlbW9kZV90YmxbX1BBR0VfQ0FDSEVfTU9E
RV9XUF0gPT0gX1BBR0VfQ0FDSEVfTU9ERV9XUDsNCj4gKwlyZXR1cm4gX19wdGUyY2FjaGVt
b2RlX3RibFtfX2NhY2hlbW9kZTJwdGVfdGJsW19QQUdFX0NBQ0hFX01PREVfV1BdXSA9PQ0K
PiArCSAgICAgICBfUEFHRV9DQUNIRV9NT0RFX1dQOw0KPiAgIH0NCj4gICANCj4gICBlbnVt
IHBhZ2VfY2FjaGVfbW9kZSBwZ3Byb3QyY2FjaGVtb2RlKHBncHJvdF90IHBncHJvdCkNCg0K

--------------TQoYAv19500hJH39vxNvHQJG
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------TQoYAv19500hJH39vxNvHQJG--

--------------yEQlXVLdARc0U5tAjrkATLvX--

--------------MkRkfbgkkUf00fAmq0kPBdET
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmKQpgwFAwAAAAAACgkQsN6d1ii/Ey+f
pgf+O+x9fAmzNw6KOMEcBnXM36W9TO48WOHg93MQ/X/sOJRjoFGE5FO6HlhjSRagWLRi8pY2WBqm
JuyvszHZSzBmyq683HgFmz6x+2GuXQM9AO39NFHILOe8MgaW1BcKxi/sjgtMHT6El/A/0NNRtheA
LtDuZKaLgU/Sny0wCpXn/1VvBkXwcXTg6X0SG+1qWyUhbL9rzl6rfLDP5HjlbBEg6zmDiwfWb4rs
pr1NYDeUeQcXMUlfn6B7CTx4zJO7+dS5ufmITV5oeFH6pzd0rpr/lYHu/tpfhWOEYa0sM3Zskhg+
/BxBPHiBPiU5jKQWIwPGnXKcWl5kG8zrPJqU3/Fpkg==
=p1bd
-----END PGP SIGNATURE-----

--------------MkRkfbgkkUf00fAmq0kPBdET--
