Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFF3497E14
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 12:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237656AbiAXLd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 06:33:26 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:59560 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237628AbiAXLdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 06:33:24 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CDB411F38F;
        Mon, 24 Jan 2022 11:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643024002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QKBHCDMPU2sJF52iG3y1dGtFPo4VlBO67jsotRm8e/0=;
        b=Ln5PL1tZA37VQlxptJx/GbMttynQPahbqiT+Z4Se+vFUkREn1RmVMN7pAHmXecliguG6BS
        QPAnqSZNuBNURKDy1Ia3nNkQyiMdKuIfPvxkh7I7Jnt95yZIZXxJGlnkKMU5Po/YxYlAjv
        r1fL+NAiMwvnnXIaK6x0BBxSDjhUzpQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643024002;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QKBHCDMPU2sJF52iG3y1dGtFPo4VlBO67jsotRm8e/0=;
        b=flG+rXfAfOJfxShiDJEylKkcOkjPd+VMyJpOyRWbwWv2EBhYG1CYqy45bliOAex03Qt/I9
        q5Cz7gqPDm8BtkCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7BE6213B5C;
        Mon, 24 Jan 2022 11:33:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zD7CHIKO7mGjEQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 24 Jan 2022 11:33:22 +0000
Message-ID: <d23800b4-503c-a6e2-2c51-2c07a736dffc@suse.de>
Date:   Mon, 24 Jan 2022 12:33:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] Revert "fbcon: Disable accelerated scrolling"
Content-Language: en-US
To:     Helge Deller <deller@gmx.de>, Gerd Hoffmann <kraxel@redhat.com>
Cc:     linux-fbdev@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Sam Ravnborg <sam@ravnborg.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sven Schnelle <svens@stackframe.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Claudio Suarez <cssk@net-c.es>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20220119110839.33187-1-deller@gmx.de>
 <20220119110839.33187-3-deller@gmx.de> <YelyGDNDTn1Aq/hm@phenom.ffwll.local>
 <6c000477-002b-d125-b945-2c4831bad8a5@gmx.de>
 <20220121072006.ylw2hdl7jbkbwnre@sirius.home.kraxel.org>
 <64fd46cb-9746-3fd0-ec92-c64dba76875a@gmx.de>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <64fd46cb-9746-3fd0-ec92-c64dba76875a@gmx.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------sd4BwwbAVtJnuPUN1A0pHCXE"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------sd4BwwbAVtJnuPUN1A0pHCXE
Content-Type: multipart/mixed; boundary="------------yogKbDJYwJBKFuJ7jue6tqub";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Helge Deller <deller@gmx.de>, Gerd Hoffmann <kraxel@redhat.com>
Cc: linux-fbdev@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
 Sam Ravnborg <sam@ravnborg.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sven Schnelle <svens@stackframe.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Claudio Suarez <cssk@net-c.es>, Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Daniel Vetter <daniel.vetter@intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <d23800b4-503c-a6e2-2c51-2c07a736dffc@suse.de>
Subject: Re: [PATCH 2/2] Revert "fbcon: Disable accelerated scrolling"
References: <20220119110839.33187-1-deller@gmx.de>
 <20220119110839.33187-3-deller@gmx.de> <YelyGDNDTn1Aq/hm@phenom.ffwll.local>
 <6c000477-002b-d125-b945-2c4831bad8a5@gmx.de>
 <20220121072006.ylw2hdl7jbkbwnre@sirius.home.kraxel.org>
 <64fd46cb-9746-3fd0-ec92-c64dba76875a@gmx.de>
In-Reply-To: <64fd46cb-9746-3fd0-ec92-c64dba76875a@gmx.de>

--------------yogKbDJYwJBKFuJ7jue6tqub
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMjQuMDEuMjIgdW0gMTI6MTAgc2NocmllYiBIZWxnZSBEZWxsZXI6DQpbLi4u
XQ0KPiANCj4gSGVyZSBpcyBteSBwcm9wb3NlZCB3YXkgZm9yd2FyZDoNCj4gYSkgSSB3aWxs
IHJlc2VuZCB0aGUgcGF0Y2hlcyB3aGljaCByZXZlcnRzIHRoZSByZW1vdmUtZmJjb24taGFy
ZHdhcmUtc2NvbGxpbmcgcGF0Y2hlcw0KPiAgICAgdG8gdGhlIG1haWxpbmcgbGlzdHMuIEkn
bGwgYWRqdXN0IHRoZSBzdGFibGUgdGFncyBhbmQgdXBkYXRlIHRoZSBjb21taXQgbWVzc2Fn
ZXMuDQo+IGIpIFRoZW4gYWZ0ZXIgc29tZSBkYXlzIEknbGwgaW5jbHVkZSBpdCBpbiB0aGUg
ZmJkZXYgZm9yLW5leHQgZ2l0IGJyYW5jaC4gVGhhdCB3YXkgaXQncw0KPiAgICAgaW5jbHVk
ZWQgaW4gdGhlIHZhcmlvdXMgYnVpbGQgJiB0ZXN0IGNoYWlucy4NCj4gYykgSWYgZXZlcnl0
aGluZyBpcyB3b3JraW5nIHdlbGwsIEknbGwgcHVzaCB0aGF0IGNoYW5nZSBkdXJpbmcgdGhl
IG5leHQgbWVyZ2Ugd2luZG93DQo+ICAgICBmb3Iga2VybmVsIDUuMTguIElmIHByb2JsZW1z
IGFyaXNlIHdlIHdpbGwgbmVlZCB0byBkaXNjdXNzLg0KPiANCj4gV2hpbGUgdGhlIHBhdGNo
ZXMgYXJlIGluIHRoZSBmYmRldiBnaXQgdHJlZSB3ZSBzaG91bGQgZGVjaWRlIGhvdyB0byBl
eGNsdWRlIGNvZGUNCj4gd2hpY2ggaXMgbm90IG5lZWRlZCBmb3IgRFJNLg0KPiANCj4gV2hh
dCBhYm91dCB0aGlzIHByb3Bvc2FsOg0KPiBhKSBhZGRpbmcgYSBLY29uZmlnIG9wdGlvbiBs
aWtlOg0KPiAgICAgQ09ORklHX0ZCX0RSSVZFUlMgLSBlbmFibGUgaWYgeW91IG5lZWQgdGhl
IGZiZGV2IGRyaXZlcnMuIEZvciBEUk0tb25seSB0aGlzIHNob3VsZCBiZSBkaXNhYmxlZC4N
Cj4gYikgQWRkIHRvIGV2ZXJ5IG5hdGl2ZSBmYmRldiBkcml2ZXIgYSAiZGVwZW5kcyBvbiBG
Ql9EUklWRVJTIiBpbiB0aGUgS2NvbmZpZyBmaWxlcy4NCj4gYykgVGhhdCB3YXkgd2UgY2Fu
IHVzZSAiI2lmIGRlZmluZWQoQ09ORklHX0ZCX0RSSVZFUlMpLi4iIHRvIGV4Y2x1ZGUgY29k
ZSBpbiBmYmNvbiB3aGljaA0KPiAgICAgaXNuJ3QgbmVlZGVkIGJ5IERSTS4NCj4gDQo+IFRo
b3VnaHRzPw0KDQpJIGNhbid0IHNheSBJIGFwcHJvdmUga2VlcGluZyBmYmRldiBhbGl2ZSwg
YnV0Li4uDQoNCldpdGggZmJkZXYgZW11bGF0aW9uLCBldmVyeSBEUk0gZHJpdmVyIGlzIGFu
IGZiZGV2IGRyaXZlciB0b28uIFNvIA0KQ09ORklHX0ZCX0RSSVZFUiBpcyBzb21ld2hhdCBt
aXNsZWFkaW5nLiBCZXR0ZXIgYWRkIGFuIG9wdGlvbiBsaWtlIA0KQ09ORklHX0ZCQ09OX0hX
X1NDUk9MTElORyBhbmQgaGF2ZSBpdCBzZWxlY3RlZCBieSB0aGUgZmJkZXYgZHJpdmVycyB0
aGF0IA0KYWJzb2x1dGVseSBuZWVkIEhXIGFjY2VsZXJhdGlvbi4gVGhhdCBvcHRpb24gd291
bGQgdGhlbiBwcm90ZWN0IHRoZSByc3AgDQpjb2RlLg0KDQpCZXN0IHJlZ2FyZHMNClRob21h
cw0KDQo+IA0KPiBIZWxnZQ0KDQotLSANClRob21hcyBaaW1tZXJtYW5uDQpHcmFwaGljcyBE
cml2ZXIgRGV2ZWxvcGVyDQpTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgN
Ck1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZywgR2VybWFueQ0KKEhSQiAzNjgwOSwg
QUcgTsO8cm5iZXJnKQ0KR2VzY2jDpGZ0c2bDvGhyZXI6IEl2byBUb3Rldg0K

--------------yogKbDJYwJBKFuJ7jue6tqub--

--------------sd4BwwbAVtJnuPUN1A0pHCXE
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmHujoEFAwAAAAAACgkQlh/E3EQov+Dx
uBAAvLFcf747FdolJECw3QdAUXffyAmibH0iQVH1sBtC+lSiTsh3XzZ8jBpyB+iHaiGvRD1pGSGZ
nemZn0ZVCocL/P5R3ZB46FzZRAJvwomu2VaHtBwcnyxkxRWMDJIrMrXSAnmQl3auVsxYABinOyHW
XzXota9KKTSK2+1gRNnzR3VqCekB7r10Q1zhe4Mtqy7ZOtWWV2Baq8UTwj2R0OImu00WJg/iew9/
GCe8f5fzs9RvPzjqp5k7oZCKBlUZBPU3hsC/k7wQ5WCF8My31SNSYWL4UBJ5Kqd0xGUzb2vGXn1t
7FPXHKliIXAc8hOxFVdId8H5KhO3IZhh0FAKjuhi+n/KkCih2OuTS/JPJvA+ZlVeRHeWWBYTnP1f
rwfozNwnGTru1kTYn7f+IvhwfP9g7q7AitFd5aaOLx9wNTwgM25JlyGGt+v4pAoDgzxxHHqGI98H
BMxtFhAT8Sw/zNDsnBEEkQ2hs1GgxnmjHOay8mdrpI7Wd7EhG4dJJ+B7jqWIZheoa+ENjO99QnR8
nhLQ/NY4IMtqMA5NQJLQBNfHaoCyD3d64ehIN88w5hi0j0sRFLdaPnFB5SJWaSviWOalRkayzF25
67RGxexizLDIoFAbCNfrg4SBkaMLac7nH63unaC4nkyY9bEpg7rbr2KvzcCkDYUPC5PZ93DM8MnF
wkE=
=DlvH
-----END PGP SIGNATURE-----

--------------sd4BwwbAVtJnuPUN1A0pHCXE--
