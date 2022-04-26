Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BD650F9D9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348647AbiDZKOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348684AbiDZKNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:13:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3754513CC19
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 02:36:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C2CDB1F388;
        Tue, 26 Apr 2022 09:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650965801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EUQK0UrRdBk8Q2sGZ93kmWFjUqFp5PWkpPtI0Lm2aRY=;
        b=gvWd353VWSRyhGWYpimQX7SXcbn7XsHgb6+XaL3pkb6m2iMa5Q/slz24DEoqEXuAmpQ2yL
        itCgfBRlISGkb0HGvoUHJa+5xwQ4mVJpI1la2KXF1qGAVGJGpMZaLq/KOqDDXoFngrjLHC
        BX6DvnP0D5iUv9fqmoCoExsoLxMcP1I=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3F80D13223;
        Tue, 26 Apr 2022 09:36:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mQLCDSm9Z2IYOwAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 26 Apr 2022 09:36:41 +0000
Message-ID: <cbd4cd8a-0271-5a53-4688-59d6cc6ee3db@suse.com>
Date:   Tue, 26 Apr 2022 11:36:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     Oleksandr <olekstysh@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Julien Grall <julien@xen.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <1650646263-22047-1-git-send-email-olekstysh@gmail.com>
 <1650646263-22047-4-git-send-email-olekstysh@gmail.com>
 <YmQsFb36UEH9BUnN@infradead.org>
 <6c5042fe-dafc-eb4f-c1fa-03b0faf252de@gmail.com>
 <abc5d23d-3d38-d198-4646-e886df2e83d4@suse.com>
 <YmZUpua3hkCPdbfx@infradead.org>
 <147f68f6-7d67-1884-bd14-5040639b3396@suse.com>
 <67c7460a-3001-35a6-8e5b-f367270b257a@gmail.com> <YmcR5bfaYh1z7VUq@zn.tnic>
 <7d89848a-3a1c-415d-957a-564ffdd3712d@suse.com> <YmewJaxWS1KGVkTf@zn.tnic>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH V1 3/6] xen/virtio: Add option to restrict memory access
 under Xen
In-Reply-To: <YmewJaxWS1KGVkTf@zn.tnic>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------MEdTqrYFN27Y5WG0EBQDaTQK"
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------MEdTqrYFN27Y5WG0EBQDaTQK
Content-Type: multipart/mixed; boundary="------------0rFmA268sw5cKzSrXO9Tr00V";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Oleksandr <olekstysh@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Julien Grall <julien@xen.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <cbd4cd8a-0271-5a53-4688-59d6cc6ee3db@suse.com>
Subject: Re: [PATCH V1 3/6] xen/virtio: Add option to restrict memory access
 under Xen
References: <1650646263-22047-1-git-send-email-olekstysh@gmail.com>
 <1650646263-22047-4-git-send-email-olekstysh@gmail.com>
 <YmQsFb36UEH9BUnN@infradead.org>
 <6c5042fe-dafc-eb4f-c1fa-03b0faf252de@gmail.com>
 <abc5d23d-3d38-d198-4646-e886df2e83d4@suse.com>
 <YmZUpua3hkCPdbfx@infradead.org>
 <147f68f6-7d67-1884-bd14-5040639b3396@suse.com>
 <67c7460a-3001-35a6-8e5b-f367270b257a@gmail.com> <YmcR5bfaYh1z7VUq@zn.tnic>
 <7d89848a-3a1c-415d-957a-564ffdd3712d@suse.com> <YmewJaxWS1KGVkTf@zn.tnic>
In-Reply-To: <YmewJaxWS1KGVkTf@zn.tnic>

--------------0rFmA268sw5cKzSrXO9Tr00V
Content-Type: multipart/mixed; boundary="------------xZCHaritzSJ0S00pyzbCiDcg"

--------------xZCHaritzSJ0S00pyzbCiDcg
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjYuMDQuMjIgMTA6NDEsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gVHVlLCBB
cHIgMjYsIDIwMjIgYXQgMDc6MTY6MTZBTSArMDIwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IENocmlzdG9waCBzdWdnZXN0ZWQgKHJhdGhlciBmaXJtbHkpIHRoaXMgd291bGQgYmUg
dGhlIHdheSB0byBnby4NCj4gDQo+IFllYWgsIEkgc2F3IGl0IGJ1dCBJIGRvbid0IHRoaW5r
IGl0IGlzIHRoZSByaWdodCB3YXkgdG8gZ28uDQo+IA0KPiBXaGF0IGhhcHBlbnMgdGhlIG5l
eHQgdGltZSBhIGd1ZXN0IG5lZWRzIHRvIHF1ZXJ5IHRoZSBwbGF0Zm9ybQ0KPiB1bmRlcm5l
YXRoPyBNaXN1c2UgdGhlc2UgaW50ZXJmYWNlcyBhZ2Fpbj8NCj4gDQo+IEJlY2F1c2UgcGVv
cGxlIHdpbGwgc2VlIHRoZSBYZW4gdXNlIGFuZCBzYXksIGhleSwgbG9vaywgSSB3aWxsIHVz
ZSB0aGlzDQo+IGZvciBteSBmdW5reSBIViB0b28uDQo+IA0KPiBFdmVuIHdvcnNlOiB3aGF0
IGhhcHBlbnMgaWYgWGVuIGRlY2lkZXMgdG8gaW1wbGVtZW50IFNFVi9URFg/IFRoZW4NCj4g
eW91J3JlIGluIGZvciBhIHdvcmxkIG9mIGZ1bi4NCg0KQXMgdGhlIHN1Z2dlc3Rpb24gd2Fz
IHRvIGFkZCBhbm90aGVyIGZsYWcgdGhpcyB3b3VsZG4ndCBiZSBhIHByb2JsZW0gSU1PLg0K
DQpCdXQgSSBhZ3JlZSB0aGF0IGNvY28gbWlnaHQgYmUgbm90IHRoZSBiZXN0IHdheSB0byBn
byAoYXMgSSB3cm90ZSBhbHJlYWR5KS4NCg0KPiANCj4gTm93LCBpZiB3ZSB3YW50IHRvICpl
eHRlbmQqIHRoZSBpbnRlcmZhY2VzIHRvIGhhdmUgc29tZXRoaW5nIGFzIGdlbmVyaWMNCj4g
YXMsIHNheSwgcGxhdGZvcm1faGFzKCkgYW5kIHRoYXQgc2hvdWxkIGJlIHRoZSB3YXkgZm9y
IGdlbmVyaWMga2VybmVsDQo+IGNvZGUgcnVubmluZyBpbiB0aGUgZ3Vlc3QgdG8gcXVlcnkg
dGhlIHBsYXRmb3JtIGNhcGFiaWxpdGllcywgdGhlbiBzdXJlLA0KPiBieSBhbGwgbWVhbnMu
DQoNCkkgYWdyZWUuDQoNCj4gDQo+PiBUaGlzIGlzIG5lZWRlZCBvbiBndWVzdCBzaWRlIGF0
IGEgcmF0aGVyIGh5cGVydmlzb3IgaW5kZXBlbmRlbnQgcGxhY2UuDQo+Pg0KPj4gU28gYSBj
YXBhYmlsaXR5IG9mIHNvbWUgc29ydCBzZWVtcyBhcHByb3ByaWF0ZS4NCj4+DQo+PiBBbm90
aGVyIHN1Z2dlc3Rpb24gb2YgbWluZSB3YXMgdG8gaGF2ZSBhIGNhbGxiYWNrIChvciBmbGFn
KSBpbg0KPj4gc3RydWN0IHg4Nl9oeXBlcl9ydW50aW1lIGZvciB0aGF0IHB1cnBvc2UuDQo+
IA0KPiBUaGlzIGJlY29tZXMgYW4gaXNzdWUgaWYgdGhlIEhWIGlzIG5vdCB4ODYgLSB0aGVu
IHlvdSBuZWVkIGEgZGlmZmVyZW50DQo+IG1ldGhvZCBvZiBxdWVyeWluZyBpdCwgd2hpY2gg
dGhlbiB1bmRlcm5lYXRoIHdpbGwgY2FsbCB0aGUgYXJjaC1zcGVjaWZpYw0KPiBpbnRlcmZh
Y2UuDQo+IA0KPiBJIGRvbid0IGtub3cgaG93IG11Y2ggb2YgcXVlcnlpbmcgZ3Vlc3RzIG5l
ZWQgdG8gZG8gYW5kIGhvdyB0aGV5J3ZlIGJlZW4NCj4gZG9pbmcgdGhhdCBzbyBmYXIuIERl
cGVuZGluZyBvbiB0aGUgcmVxdWlyZW1lbnRzLCB3ZSBwcm9iYWJseSBzaG91bGQNCj4gdGhp
bmsgYWJvdXQgYSBjbGVhbiBkZXNpZ24gZnJvbSB0aGUgZ2V0LWdvIGluc3RlYWQgb2YgaG9t
ZWdyb3duIHRoaW5ncy4NCg0KWWVzLg0KDQpwbGF0Zm9ybV9oYXMoKSBkb2Vzbid0IHNlZW0g
dG9vIGJhZCBJTU8uDQoNCkkgd2lsbCB3cml0ZSBhIHBhdGNoIGZvciBzdGFydGluZyB0aGUg
ZGlzY3Vzc2lvbi4NCg0KDQpKdWVyZ2VuDQo=
--------------xZCHaritzSJ0S00pyzbCiDcg
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------xZCHaritzSJ0S00pyzbCiDcg--

--------------0rFmA268sw5cKzSrXO9Tr00V--

--------------MEdTqrYFN27Y5WG0EBQDaTQK
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmJnvSgFAwAAAAAACgkQsN6d1ii/Ey/H
Awf+OWyEuHlu+jo4GkGrpUTd1hChqcn6K5a+V6S7bfOqp0oHIurgszQN9Siz56jgGXrIaHEGsPIh
sc2hEa46FXLZsBUOHbaxma8m0C+nGLw3WPMa2JJBumk2kI6mP2hkZlpgmdVH1Md8+W4J4gA4eV80
lAp/xRqVyuppUbr+BEgxTVlPw0utV/wxP9ZUnvSMFlWEBI83Y3TFZBGyfo0ADIuFYPRkCCs7qRhC
EIHe5sVASG18BlfRy+qmdX9rainyhwK9CESLO3dpFOocsa/gD8VHknmxOssKBpt4b7P8SDQateeL
AmZK/5+s+hS4VLvtwWQysUA8Wgf4tksIB83pXwzvJQ==
=UGmD
-----END PGP SIGNATURE-----

--------------MEdTqrYFN27Y5WG0EBQDaTQK--
