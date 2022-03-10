Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8143C4D5267
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 20:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244349AbiCJTDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 14:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbiCJTD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 14:03:28 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E92BED
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 11:02:25 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AF1AF1F381;
        Thu, 10 Mar 2022 19:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646938943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VvuxtOkRTYe6y27Po/1nErjm/dM9kXlHT4HNL9PVo00=;
        b=h7pIh4eLaWzgkaI2p833yncJUhkX9aylvhTUlrji0Wa6KUgmBcDx5GsBivnV4CHgXyZJAJ
        nN0QeKx4SW3t/3hxvKNXt2SEISGHrT58J29q3Glpc1uUwnduBhNW5T5JXXpocvg5bAvh1D
        z2zfTxerc+h1Nmx+WDTF69G2lZGAebA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646938943;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VvuxtOkRTYe6y27Po/1nErjm/dM9kXlHT4HNL9PVo00=;
        b=iuJ2YCVbYLpYcDF0VrQP3c/Ot3qB8OqqkPdpQBhTK8m1aknrovDZBmbMYf3tDQ5JbxC6QG
        Uy+hW3T9oCDjloBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6086F13FA3;
        Thu, 10 Mar 2022 19:02:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PbzeFT9LKmIXVAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 10 Mar 2022 19:02:23 +0000
Message-ID: <3caec8f4-1bc8-bd52-4a36-5223b633704e@suse.de>
Date:   Thu, 10 Mar 2022 20:02:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v1 0/5] Add memory shrinker to VirtIO-GPU DRM driver
Content-Language: en-US
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gert Wollny <gert.wollny@collabora.com>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        dri-devel@lists.freedesktop.org, Dmitry Osipenko <digetx@gmail.com>
References: <20220308131725.60607-1-dmitry.osipenko@collabora.com>
 <4ce1e172-799c-cba3-0a72-4a6fdf2c6d2f@suse.de>
 <caa9a2ea-d1b4-fa96-0e90-37a89aa0c000@collabora.com>
 <d1169f34-ccd8-299d-af1f-f45da37556db@suse.de>
 <c9b344ab-b674-d600-da13-94b329a9d46b@collabora.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <c9b344ab-b674-d600-da13-94b329a9d46b@collabora.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------NNe0wuk0PVOqaesrUKI5pL6A"
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
--------------NNe0wuk0PVOqaesrUKI5pL6A
Content-Type: multipart/mixed; boundary="------------jixjnh6q6q1yWxdpMDOQzT0K";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 dri-devel@lists.freedesktop.org, Dmitry Osipenko <digetx@gmail.com>
Message-ID: <3caec8f4-1bc8-bd52-4a36-5223b633704e@suse.de>
Subject: Re: [PATCH v1 0/5] Add memory shrinker to VirtIO-GPU DRM driver
References: <20220308131725.60607-1-dmitry.osipenko@collabora.com>
 <4ce1e172-799c-cba3-0a72-4a6fdf2c6d2f@suse.de>
 <caa9a2ea-d1b4-fa96-0e90-37a89aa0c000@collabora.com>
 <d1169f34-ccd8-299d-af1f-f45da37556db@suse.de>
 <c9b344ab-b674-d600-da13-94b329a9d46b@collabora.com>
In-Reply-To: <c9b344ab-b674-d600-da13-94b329a9d46b@collabora.com>

--------------jixjnh6q6q1yWxdpMDOQzT0K
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMDkuMDMuMjIgdW0gMjM6MjUgc2NocmllYiBEbWl0cnkgT3NpcGVua286DQo+
Pg0KPj4gVGhlIHJlYXNvbiBmb3IgdGhpcyB3b3JrIGlzIHRvIGtlZXAgR0VNIHNobWVtIHBh
Z2VzIG1hcHBlZCBhbmQgYWxsb2NhdGVkDQo+PiBldmVuIHdoaWxlIHRoZSBCTyBpcyBuZWl0
aGVyIG1hcHBlZCBub3IgcGlubmVkLsKgIEFzIGl0IGlzIG5vdywgR0VNIFNITUVNDQo+PiBj
cmVhdGVzIGFuZCByZWxlYXNlcyBwYWdlcyBvbiBlYWNoIHBpbiBhbmQgdW5waW4sIGFuZCBt
YXBzIGFuZCB1bm1hcHMNCj4+IG1lbW9yeSByYW5nZXMgb24gZWFjaCB2bWFwIGFuZCB2dW5t
YXAuwqAgSXQncyBhbGwgd2FzdGVmdWwuIE9ubHkgdGhlDQo+PiBmaXJzdCBwaW4gYW5kIHZt
YXAgY2FsbHMgc2hvdWxkIGVzdGFibGlzaCBwYWdlcyBhbmQgbWFwcGluZ3MgYW5kIG9ubHkN
Cj4+IHRoZSBwdXJnZSBhbmQgZnJlZSBmdW5jdGlvbnMgc2hvdWxkIHJlbGVhc2UgdGhlbS4N
Cj4gDQo+IEhtLCBhcmVuJ3QgbWFwcyBhbmQgcGlucyBhbHJlYWR5IHJlZmNvdW50ZWQ/DQoN
ClRoZXkgYXJlLiBCdXQgZXZlbiB3aGVuIHRoZSByZWZjb3VudGVyIHJlYWNoZXMgMCBvbiBk
ZXJlZiwgdGhlcmUncyBubyANCm5lZWQgdG8gcmVtb3ZlIHRoZSBtYXBwaW5nIG9yIGZyZWUg
dGhlIG1lbW9yeSBwYWdlcy4gV2UgY2FuIGtlZXAgdGhlbSANCmFyb3VuZCBmb3IgdGhlIG5l
eHQgcmVmIG9wZXJhdGlvbi4gIE9ubHkgdGhlIHNocmlua2VyJ3MgcHVyZ2Ugb3IgZnJlZWlu
ZyANCnRoZSBvYmplY3QgaGFzIHRvIGRvIHN1Y2ggY2xlYW4tdXAgb3BlcmF0aW9ucy4gIFN1
Y2ggYmVoYXZpb3IgaXMgDQpzdXBwb3J0ZWQgYnkgVFRNIGFuZCB3ZSBhbHJlYWR5IHVzZSBp
dCBpbiBWUkFNIGhlbHBlcnMgYXMgd2VsbC4NCg0KQmVzdCByZWdhcmRzDQpUaG9tYXMNCg0K
PiANCj4+IFRoZSBwYXRjaHNldCBhZGRzIG5ldyBoZWxwZXJzIGZvciBCTyBwdXJnaW5nIHRv
IHN0cnVjdA0KPj4gZHJtX2dlbV9vYmplY3RfZnVuY3MuIFdpdGggdGhpcywgSSB0aGluayBp
dCBtaWdodCBiZSBwb3NzaWJsZSB0byBoYXZlDQo+PiBvbmUgZ2xvYmFsIERSTSBzaHJpbmtl
ciBhbmQgbGV0IGl0IGhhbmRsZSBhbGwgQk9zOyBpbmRlcGVuZGVudCBvZiBlYWNoDQo+PiBC
TydzIG1lbW9yeSBtYW5hZ2VyLg0KPiANCj4gVGhhbmsgeW91LCBJJ2xsIGdpdmUgaXQgYSB0
cnkuDQoNCi0tIA0KVGhvbWFzIFppbW1lcm1hbm4NCkdyYXBoaWNzIERyaXZlciBEZXZlbG9w
ZXINClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdlcm1hbnkgR21iSA0KTWF4ZmVsZHN0ci4g
NSwgOTA0MDkgTsO8cm5iZXJnLCBHZXJtYW55DQooSFJCIDM2ODA5LCBBRyBOw7xybmJlcmcp
DQpHZXNjaMOkZnRzZsO8aHJlcjogSXZvIFRvdGV2DQo=

--------------jixjnh6q6q1yWxdpMDOQzT0K--

--------------NNe0wuk0PVOqaesrUKI5pL6A
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmIqSz4FAwAAAAAACgkQlh/E3EQov+At
9g//Z9letBO6G3sE8aowjvZbpoZsrIyVdjoy+W6UDaqOrF3j938fYly4mcECyifSvmPTkt4gqyOf
EBtirJ+muEGKtJhVGI384pw0yT86VYb0Avhv9y0Ev+zzoXbd+QSL4i7M12ne6P7/gbIpb/qMEtfV
IRInAJ3VOKcYDAc/nveXusnJHRvghCqiyc6seLqWaZhtvSirTIrW4uihFd9N0Ol0Ix/WrT/EH2VO
CP9AHptSWTGikCb/7lN9SvbeAZAbOKwLiYkldCuGzpydabmIXEE8R7dFSJPcrjZ9+bSftMZYWErs
VYaXUZ3OcRRIAE4Y1GsvCBFyzfVtBCJH4QsajTa4Pu/U2Aa0obmKhtHlkNPIhMUAM60Uo50JtRut
PhohOZXqLEE3Z4glpCzEgEarAY/nMm19cMU3TPyBt1PdjMWhpzn/gIwHz7JwlY4ki1QHn5WaY1Nx
5//5GPSZtSSkSgPqKJOjTCv5gGyLOcvy+0DAGlH4AWncdhS79pjDtA+X5WEafy0YgB3aCApp+qnX
HA4Rby5o7fOm+RdcLPvDWfwHLUHWPABbRrK+EyD0sTi0DIo/XCz2HMHeK1nJuSbbaDu0XshvM9CZ
VcrCiaQDH8GTMhAvN0ZEiPIKBp1yRtOhVBXDwbkrHerz6KIjGLGicRn9O/APnd4K2yw8VhjH8+7b
v7c=
=7O5g
-----END PGP SIGNATURE-----

--------------NNe0wuk0PVOqaesrUKI5pL6A--
