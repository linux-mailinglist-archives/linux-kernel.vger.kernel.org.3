Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E04751D951
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 15:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392622AbiEFNnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 09:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237300AbiEFNna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 09:43:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F249E5C876;
        Fri,  6 May 2022 06:39:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9264E1F8DA;
        Fri,  6 May 2022 13:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651844385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h4aY0Lsx3imt0jV3NDC4D9DAhwDOGA7UNL6mxEQqvk4=;
        b=X4nrqHBV1THKLZX+AmrUU5ZyxIQU1PB9IsN8b9QwwaDPhd6+Z4c+oS4Ocjb9LPpIsAF5F2
        JZOaHhPjg9J+9WhWWS+CItSypznJqJqu/9PClF43R+FLoEw19AVPrRPQNh3uv/cqkSRses
        4UniK8daBoPVd60cEBzsI0LPIdYt5g0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651844385;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h4aY0Lsx3imt0jV3NDC4D9DAhwDOGA7UNL6mxEQqvk4=;
        b=U+Zh/EVZ0Ewh4JbElwUDlv6+0fiuZItz5QBS8KyhFTHB41xBnX8djaDeZCEkI95219CZIh
        DRhi2al9+6LAisAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6093713AA2;
        Fri,  6 May 2022 13:39:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FLieFiEldWLmWQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Fri, 06 May 2022 13:39:45 +0000
Message-ID: <c2dcaff2-df32-b4a8-2f28-c31cbf2c5715@suse.de>
Date:   Fri, 6 May 2022 15:39:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] fbdev: efifb: Fix a use-after-free due early fb_info
 cleanup
Content-Language: en-US
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        intel-gfx@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Helge Deller <deller@gmx.de>, Peter Jones <pjones@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20220506132225.588379-1-javierm@redhat.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <20220506132225.588379-1-javierm@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------mhL0gUPSrk4f7zq6G9SeQHiX"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------mhL0gUPSrk4f7zq6G9SeQHiX
Content-Type: multipart/mixed; boundary="------------O92hj00bA01kfyO5mM0pT6ih";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Javier Martinez Canillas <javierm@redhat.com>,
 linux-kernel@vger.kernel.org
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 intel-gfx@lists.freedesktop.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Helge Deller <deller@gmx.de>, Peter Jones <pjones@redhat.com>,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Message-ID: <c2dcaff2-df32-b4a8-2f28-c31cbf2c5715@suse.de>
Subject: Re: [PATCH] fbdev: efifb: Fix a use-after-free due early fb_info
 cleanup
References: <20220506132225.588379-1-javierm@redhat.com>
In-Reply-To: <20220506132225.588379-1-javierm@redhat.com>

--------------O92hj00bA01kfyO5mM0pT6ih
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpBbSAwNi4wNS4yMiB1bSAxNToyMiBzY2hyaWViIEphdmllciBNYXJ0aW5leiBDYW5pbGxh
czoNCj4gQ29tbWl0IGQyNThkMDBmYjljNyAoImZiZGV2OiBlZmlmYjogQ2xlYW51cCBmYl9p
bmZvIGluIC5mYl9kZXN0cm95IHJhdGhlcg0KPiB0aGFuIC5yZW1vdmUiKSBhdHRlbXB0ZWQg
dG8gZml4IGEgdXNlLWFmdGVyLWZyZWUgZXJyb3IgZHVlIGRyaXZlciBmcmVlaW5nDQo+IHRo
ZSBmYl9pbmZvIGluIHRoZSAucmVtb3ZlIGhhbmRsZXIgaW5zdGVhZCBvZiBkb2luZyBpdCBp
biAuZmJfZGVzdHJveS4NCj4gDQo+IEJ1dCBpcm9uaWNhbGx5IHRoYXQgY2hhbmdlIGludHJv
ZHVjZWQgeWV0IGFub3RoZXIgdXNlLWFmdGVyLWZyZWUgc2luY2UgdGhlDQo+IGZiX2luZm8g
d2FzIHN0aWxsIHVzZWQgYWZ0ZXIgdGhlIGZyZWUuDQo+IA0KPiBUaGlzIHNob3VsZCBmaXgg
Zm9yIGdvb2QgYnkgZnJlZWluZyB0aGUgZmJfaW5mbyBhdCB0aGUgZW5kIG9mIHRoZSBoYW5k
bGVyLg0KPiANCj4gRml4ZXM6IGQyNThkMDBmYjljNyAoImZiZGV2OiBlZmlmYjogQ2xlYW51
cCBmYl9pbmZvIGluIC5mYl9kZXN0cm95IHJhdGhlciB0aGFuIC5yZW1vdmUiKQ0KPiBSZXBv
cnRlZC1ieTogVmlsbGUgU3lyasOkbMOkIDx2aWxsZS5zeXJqYWxhQGxpbnV4LmludGVsLmNv
bT4NCj4gUmVwb3J0ZWQtYnk6IEFuZHJ6ZWogSGFqZGEgPGFuZHJ6ZWouaGFqZGFAaW50ZWwu
Y29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBKYXZpZXIgTWFydGluZXogQ2FuaWxsYXMgPGphdmll
cm1AcmVkaGF0LmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFRob21hcyBaaW1tZXJtYW5uIDx0emlt
ZW1ybWFubkBzdXNlLmRlPg0KDQo+IC0tLQ0KPiANCj4gICBkcml2ZXJzL3ZpZGVvL2ZiZGV2
L2VmaWZiLmMgfCA0ICsrLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlkZW8vZmJk
ZXYvZWZpZmIuYyBiL2RyaXZlcnMvdmlkZW8vZmJkZXYvZWZpZmIuYw0KPiBpbmRleCBjZmEz
ZGMwYjRlZWUuLmIzZDVmODg0YzU0NCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy92aWRlby9m
YmRldi9lZmlmYi5jDQo+ICsrKyBiL2RyaXZlcnMvdmlkZW8vZmJkZXYvZWZpZmIuYw0KPiBA
QCAtMjU5LDEyICsyNTksMTIgQEAgc3RhdGljIHZvaWQgZWZpZmJfZGVzdHJveShzdHJ1Y3Qg
ZmJfaW5mbyAqaW5mbykNCj4gICAJCQltZW11bm1hcChpbmZvLT5zY3JlZW5fYmFzZSk7DQo+
ICAgCX0NCj4gICANCj4gLQlmcmFtZWJ1ZmZlcl9yZWxlYXNlKGluZm8pOw0KPiAtDQo+ICAg
CWlmIChyZXF1ZXN0X21lbV9zdWNjZWVkZWQpDQo+ICAgCQlyZWxlYXNlX21lbV9yZWdpb24o
aW5mby0+YXBlcnR1cmVzLT5yYW5nZXNbMF0uYmFzZSwNCj4gICAJCQkJICAgaW5mby0+YXBl
cnR1cmVzLT5yYW5nZXNbMF0uc2l6ZSk7DQo+ICAgCWZiX2RlYWxsb2NfY21hcCgmaW5mby0+
Y21hcCk7DQo+ICsNCj4gKwlmcmFtZWJ1ZmZlcl9yZWxlYXNlKGluZm8pOw0KPiAgIH0NCj4g
ICANCj4gICBzdGF0aWMgY29uc3Qgc3RydWN0IGZiX29wcyBlZmlmYl9vcHMgPSB7DQoNCi0t
IA0KVGhvbWFzIFppbW1lcm1hbm4NCkdyYXBoaWNzIERyaXZlciBEZXZlbG9wZXINClNVU0Ug
U29mdHdhcmUgU29sdXRpb25zIEdlcm1hbnkgR21iSA0KTWF4ZmVsZHN0ci4gNSwgOTA0MDkg
TsO8cm5iZXJnLCBHZXJtYW55DQooSFJCIDM2ODA5LCBBRyBOw7xybmJlcmcpDQpHZXNjaMOk
ZnRzZsO8aHJlcjogSXZvIFRvdGV2DQo=

--------------O92hj00bA01kfyO5mM0pT6ih--

--------------mhL0gUPSrk4f7zq6G9SeQHiX
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmJ1JSAFAwAAAAAACgkQlh/E3EQov+BI
OxAAlt52zYzL0xgU7QkrsxpiPGjP98De5tt7Or57DiB41jN8xNPWI/mtxgi00UOiWsjLPaY1VRFc
+b4LdABtJzjnw6g8Kif9qNLKPxvCfMSCvXqxSKXA/gFfSbn9vG7otaahsSij8t2M8tLJ7dl5zc87
mYA/8dshv1xj6E16kkl0zmTnqfGf91tI4pGuVfB9BcpA50OMOECzCdleL5Mq9sqTvcbHdMvWaos4
lBfW+puArXa1d3kMi3yodwX5F8mcRipXVRxfPZ7JBk6NaSZiXsrUydaZeMHl55ZShowE9cUWAejZ
4MiS+4H8kkMGPz4HAxyzfFgL0iDdr1Re+jcpT7j+gDFSGxYh9ov3YIPr/HPUpCSZSfGcVUopxwN1
BLl+lALTRkZZZQYudqBT6mBnN8shPKx5rT7LNdemqj7RjHAxtZ4qMvudMB2HhoiQNqRV0N3hYCYA
HzUsNxBN1PryQbmvJr6jmAliFVrkfisVRTqHM2qLv37jobmjbOPIcVdGsgF3qQmNhsU831fL5nkF
QYgyJh8itZwfxXLizf7gY/K4PzBGCJdkEkxAH/KETNerqj7pdgtVCuUGU0uHK6IeZic3GTLIT+mz
BHlGEJxrVb9Cc1fOm/4GKwyxL1aqiKf3XoWBRKwFJc/DmcMOezvqfMly4c7qPqVdPzHryR35Wqro
/Vo=
=pjpy
-----END PGP SIGNATURE-----

--------------mhL0gUPSrk4f7zq6G9SeQHiX--
