Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2859D4B5966
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 19:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357350AbiBNSK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 13:10:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357344AbiBNSKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 13:10:23 -0500
X-Greylist: delayed 396 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Feb 2022 10:10:12 PST
Received: from mx2.securetransport.de (mx2.securetransport.de [IPv6:2a03:4000:13:6c7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BBAFD65171;
        Mon, 14 Feb 2022 10:10:12 -0800 (PST)
Received: from mail.dh-electronics.com (business-24-134-97-169.pool2.vodafone-ip.de [24.134.97.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.securetransport.de (Postfix) with ESMTPSA id 4AC115E9CC;
        Mon, 14 Feb 2022 19:02:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1644861768;
        bh=7xfalOX+rWD4NJI43BSDKMhWEeNFDqerF9Kf3/7C4RA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=to8ggP9eD3YNDZScXwrMAoJ7D0rCUx1aVHHAh3B9mPByEN5yhJEqPTFVETJyfcnnz
         0mKctBGU5R8Uf0M1uhF41UrMnyS33+YwJc8LFzP6QH0z3qT49pa7uS2R4ATLLSbXZ9
         Zuzxas0DAE+PvKCP3oERtK+zmlIkhiOaTYd9mel4bLbOm2S4gq16Tb3KqWurWSm8nJ
         1lwEvrzorM2VEFjZYEGlToZuoYWyKhMq65nZ/9RB7X57C2UqobSEdpxJH1Pnk2MFc9
         6oJ+DOJKoijgjKD8myR8rq8DIvAyshpgphOXBCkhrCZIpnQdwtMzd7SbVEysn0KACW
         HT822K2+UqA4Q==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 14 Feb 2022 19:02:42 +0100
Received: from DHPWEX01.DH-ELECTRONICS.ORG ([fe80::6ced:fa7f:9a9c:e579]) by
 DHPWEX01.DH-ELECTRONICS.ORG ([fe80::6ced:fa7f:9a9c:e579%6]) with mapi id
 15.02.0986.015; Mon, 14 Feb 2022 19:02:42 +0100
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Andrej Picej <andrej.picej@norik.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Support Opensource <Support.Opensource@diasemi.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH] watchdog: da9062: Correct the timeout values
 [Klartext]
Thread-Topic: [RFC PATCH] watchdog: da9062: Correct the timeout values
 [Klartext]
Thread-Index: AdfwANztWgHN3oJ0TZqwlPeCV8dlmAAIEJYAAALaKlAAD68ZMAxWZv9g
Date:   Mon, 14 Feb 2022 18:02:42 +0000
Message-ID: <3bb120e2fcb649f09cf0f8c881f442ff@dh-electronics.com>
References: <4254747d8cde4c5dbcbfdd00a3ecf701@dh-electronics.com>
 <03871bd3-ea78-52e1-f57b-3e35724c8934@roeck-us.net>
  <a065a23625404ca9853354f9d367a09c@dh-electronics.com>
In-Reply-To: <a065a23625404ca9853354f9d367a09c@dh-electronics.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.51.18]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogbGludXgtYXJtLWtlcm5lbCBbbWFpbHRvOmxpbnV4LWFybS1rZXJuZWwtYm91bmNlc0Bs
aXN0cy5pbmZyYWRlYWQub3JnXQ0KU2VudDogTW9uZGF5LCBEZWNlbWJlciAxMywgMjAyMSAxMTo0
NSBQTQ0KPj4+Pj4+IFRoYW5rcyBhbnl3YXksIHNvIG5vdyBJIGtub3cgaXQgbXVzdCBiZQ0KPj4+
Pj4+IHByb2JsZW0gd2l0aCBteSBEQTkwNjEgY2hpcC4NCj4+Pj4+Pg0KPj4+Pj4+IEBBZGFtDQo+
Pj4+Pj4gV2hlcmUgY2FuIGl0IGNvbWUgZnJvbT8NCj4+Pj4+PiBDYW4geW91IGdpdmUgd2UgYSBo
aW50IHdoYXQgdG8gY2hlY2s/DQo+Pj4+Pg0KPj4+Pj4gSSd2ZSBzcG9rZW4gaW50ZXJuYWxseSBh
bmQgaGF2ZSBiZWVuIGluZm9ybWVkIHRoYXQgdGhpcyBpcyBkb3duIHRvIHRoZSBmYWN0IHRoYXQN
Cj4+Pj4+IERBOTA2MSBydW5zIG9ubHkgZnJvbSBhbiBpbnRlcm5hbCBvc2NpbGxhdG9yIHdoaWNo
IG1heSBiZSBzbG93ZXIuIFRoZSBpbmRpY2F0aW9uDQo+Pj4+PiBpcyB0aGF0IHRoZSB2YWx1ZXMg
Zm9yIFRXRFNDQUxFIGRlc2NyaWJlIHRoZSB3aW5kb3cgd2hlcmUgaWYgYSBraWNrL3Bpbmcgb2Nj
dXJzDQo+Pj4+PiB3aXRoaW4gdGhhdCBwZXJpb2QgdGhlbiB0aGUgd2F0Y2hkb2cgaXMgZ3VhcmFu
dGVlZCAqbm90KiB0byB0aW1lb3V0LiBUaGUgYWN0dWFsDQo+Pj4+PiB0aW1lb3V0IHdvdWxkIGJl
IGF0IHNvbWUgcG9pbnQgYWZ0ZXIgdGhlIHNlbGVjdGVkIHRpbWVvdXQgcGVyaW9kLCBhc3N1bWlu
ZyBubw0KPj4+Pj4gcGluZy9raWNrIG9jY3VycmVkLg0KPj4+Pj4NCj4+Pj4+IFRhYmxlIDggaW4g
dGhlIGRhdGFzaGVldCBzcGVjaWZpZXMgYSBtaW5pbXVtIHdhdGNoZG9nIHRpbWVvdXQgb2YgMi41
cyAodFdETUFYKQ0KPj4+Pj4gdW5kZXIgc3BlY2lmaWMgb3BlcmF0aW5nIGNvbmRpdGlvbnMsIHNv
IGlmIHRoZSBtaW5pbXVtIDJzIHdpbmRvdyB3YXMgY2hvc2VuDQo+Pj4+PiAoVFdEU0NBTEUgPSAx
KSB0aGVuIGVhcmxpZXN0IHRoZSB3YXRjaGRvZyB3b3VsZCBhY3R1YWxseSB0aW1lb3V0LCBmb2xs
b3dpbmcgYQ0KPj4+Pj4gcGluZywgaXMgMi41cywgYXNzdW1pbmcgdGhlIGNvbmRpdGlvbnMgbWF0
Y2hlZCB0aG9zZSBkZXNjcmliZWQuDQo+Pj4+Pg0KPj4+Pj4gSWYgeW91IGhhdmUgZnVydGhlciBx
dWVzdGlvbnMgaXQgcHJvYmFibHkgbWFrZXMgc2Vuc2UgdG8gY29udGFjdCBEaWFsb2cvUmVuZXNh
cw0KPj4+Pj4gc3VwcG9ydCBhcyB0aGV5IHdpbGwgYmUgYWJsZSB0byBwcm92aWRlIG1vcmUgZGV0
YWlsZWQgaW5mbyBvbiB0aGlzLg0KPj4+Pg0KPj4+PiBTbyBhIERBOTA2MSBydW5zIG9ubHkgZnJv
bSBhbiBpbnRlcm5hbCBvc2NpbGxhdG9yLCB3aGVyZWFzIGEgREE5MDYyDQo+Pj4+IGNhbiBydW4g
b24gZWl0aGVyIGFuIGludGVybmFsIG9yIGFuIGV4dGVybmFsIG9zY2lsbGF0b3IuIFNvIHRoaXMN
Cj4+Pj4gbWVhbnMgdGhhdCB0aGUgREE5MDYxIHRpbWVvdXQgdmFsdWVzIGFyZSBkaWZmZXIgZnJv
bSB0aGUgREE5MDYyDQo+Pj4+IHdpdGggYW4gZXh0ZXJuYWwgb3NjaWxsYXRvciBub3Qgb25seSBv
biBteSBkZXZpY2UgYnV0IG9uIGFsbCBEQTkwNjENCj4+Pj4gZGV2aWNlcy4NCj4+Pj4NCj4+Pj4g
VGhpcyBhcmUgdGhlIHZhbHVlcyAoaW4gc2Vjb25kcykgaW4gY29tcGFyaXNvbjoNCj4+Pj4gREE5
MDYyIChmcm9tIGRyaXZlcik6IDAgIDIgIDQgICA4ICAxNiAgMzIgIDY1IDEzMQ0KPj4+PiBEQTkw
NjEgKG1lYXN1cmVkKTogICAgMCAgMyAgNiAgMTIgIDI1ICA1MSAxMDIgMjA0DQo+Pj4+ID09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4+Pj4gRGlmZmVy
ZW5jZTogICAgICAgICAgIDAgKzEgKzIgICs0ICArOSArMTkgKzM3ICs3Mw0KPj4+Pg0KPj4+PiBJ
biBteSBvcGluaW9uLCB0aGUgZGlmZmVyZW5jZXMgaW4gdGhlIGhpZ2hlciB2YWx1ZXMgYXJlIHZl
cnkgaHVnZS4NCj4+Pj4gSWYgSSBleHBlY3QgdGhhdCB0aGUgd2F0Y2hkb2cgdHJpZ2dlcnMgYW5k
IEkgaGF2ZSB0byB3YWl0IG1vcmUgdGhhbg0KPj4+PiBhIG1pbnV0ZSBmb3IgdGhhdCB0byBoYXBw
ZW4gSSBhc2sgbXlzZWxmIGlzIHRoZXJlIHNvbWV0aGluZyB3cm9uZy4NCj4+Pj4NCj4+Pj4gQEFu
ZHJlag0KPj4+PiBJIGd1ZXNzLCB5b3UgYXJlIHVzaW5nIGFuIGV4dGVybmFsIG9zY2lsbGF0b3Is
IGFyZW4ndCB5b3U/DQo+Pj4+DQo+Pj4+IEBBZGFtDQo+Pj4+IElzIHRoZXJlIGEgd2F5IHRvIGNo
ZWNrIGluIHRoZSBkcml2ZXIgd2hpY2ggb3NjaWxsYXRvciBpcyBpbiB1c2U/DQo+Pj4+DQo+Pj4+
IEBNYWludGFpbmVycw0KPj4+PiBJcyBpbiB0aGUgZHJpdmVyIGEgbmVlZCB0byBkaXN0aW5ndWlz
aCBiZXR3ZWVuIGFuIGV4dGVybmFsIGFuZCBhbg0KPj4+PiBpbnRlcm5hbCBvc2NpbGxhdG9yIHRv
IGdldCB0aGUgdGltZW91dCB2YWx1ZXMgbW9yZSBhY2N1cmF0ZT8NCj4+Pj4NCj4+Pg0KPj4+IEl0
IHdvdWxkIGJlIHZlcnkgZGVzaXJhYmxlIHRvIGdldCB0aW1lb3V0IHZhbHVlcyBtb3JlIGFjY3Vy
YXRlLg0KPj4+IEkgd291bGQgbm90IHdhbnQgdG8gZGljdGF0ZSBob3cgdG8gaW1wbGVtZW50IGl0
LCB0aG91Z2guDQo+Pj4gSXQgY291bGQgYmUgYXV0b21hdGljYWxseSBkZXRlY3RlZCBpZiB0aGF0
IGlzIHBvc3NpYmxlLCB0aGVyZQ0KPj4+IGNvdWxkIGJlIGEgZGV2aWNldHJlZSBjbG9jayBwcm9w
ZXJ0eSBwcm92aWRpbmcgdGhlIGNsb2NrDQo+Pj4gZnJlcXVlbmN5LCBvciBtYXliZSB0aGVyZSBp
cyBzb21lIG90aGVyIHNvbHV0aW9uLg0KPj4+DQo+Pj4gR3VlbnRlcg0KPj4NCj4+IEkgYW0gb3Bl
biBmb3IgYSBnb29kIHNvbHV0aW9uLg0KPj4gTWVhbndoaWxlIEkgbWVhc3VyZWQgdGhlIHRpbWVv
dXQgdmFsdWVzIG9mIG15IDggYXZhaWxhYmxlIERBOTA2MQ0KPj4gd2F0Y2hkb2dzLiBJIGRlcml2
ZWQgdGhlIGZvbGxvd2luZyBmb3JtdWxhIGZyb20gdGhlIGdpdmVuIGZvcm11bGENCj4+IGF0IHRo
ZSBkYXRhIHNoZWV0IGFuZCB0aGUgY2xvY2sgZGl2aWRlciBvZiAyXjE2Og0KPj4NCj4+IGYgPSAy
XigxNStUV0RTQ0FMRSkgLyB0DQo+Pg0KPj4gRm9ybXVsYSBjaGVjayB3aXRoIHRoZSBleHRlcm5h
bCBvc2NpbGxhdG9yICgzMmtIeikgVFdEU0NBTEU9NyBAIDEzMXM6DQo+PiBmID0gMl4oMTUrNykg
LyAxMzEgPSAzMjAxN0h6ICg9PiBzaG91bGQgYmUgT0spDQo+Pg0KPj4gVGhlIHRpbWVvdXRzIG9m
IG15IDggd2F0Y2hkb2dzICg5MDYxLUFBKSB3aXRoIFRXRFNDQUxFPTc6DQo+PiB0NyA9IDIxMXMg
PT4gMTk4NzhIeg0KPj4gdDcgPSAxOTdzID0+IDIxMjkxSHoNCj4+IHQ3ID0gMjAzcyA9PiAyMDY2
Mkh6DQo+PiB0NyA9IDIwNHMgPT4gMjA1NjBIeg0KPj4gdDcgPSAyMDZzID0+IDIwMzYxSHoNCj4+
IHQ3ID0gMTk4cyA9PiAyMTY2Mkh6DQo+PiB0NyA9IDIwMHMgPT4gMjA5NzJIeg0KPj4NCj4+IEFj
Y29yZGluZyB0byB0aGUgZGF0YSBzaGVldCB0aGUgaW50ZXJuYWwgb3NjaWxsYXRvciBzaG91bGQg
cnVuIGF0IDI1a0h6Lg0KPj4gVGhlIGF2ZXJhZ2UgZnJlcXVlbmN5IG9mIG15IDggZGV2aWNlcyBp
cyAyMC42a0h6LiBNYXliZSB0aGUgZGF0YSBzaGVldA0KPj4gQ2xvY2sgdmFsdWUgaXMgYSBtYXgg
dmFsdWUuIFRoZSB0aW1lb3V0IGRpZmZlcmVuY2Ugb24gbXkgOCBkZXZpY2VzIGFyZQ0KPj4gMTRz
LiBTbyB0aGUgdmFsdWVzIHZhcnkgZnJvbSBkZXZpY2UgdG8gZGV2aWNlLCBhbmQgbWF5YmUgdGhl
cmUgaXMgYWxzbyBhDQo+PiB0ZW1wZXJhdHVyZSBjb21wb25lbnQuDQo+Pg0KPj4gQEFkYW0NCj4+
IElzIHRoZXJlIGEgd2F5IHRvIGNoZWNrIHdoaWNoIG9zY2lsbGF0b3IgaXMgaW4gdXNlPw0KPj4g
SXMgdGhlcmUgYSB3YXkgdG8gZmluZCB0aGUgY3VycmVudCBvc2NpbGxhdG9yIGZyZXF1ZW5jeT8N
Cj4+IEFyZSB0aGVyZSBhbnkgb3RoZXIgaWRlYXMvc29sdXRpb25zIHRvIGdldCB0aGUgdGltZW91
dCB2YWx1ZXMgbW9yZSBhY2N1cmF0ZT8NCj4gDQo+IEFzIEkgc2VudCBteSBFLU1haWwgSSBkaWRu
J3Qgc2VlIHlvdXIgYW5zd2VyLCBzbyBoZXJlIGl0IGlzOg0KPiANCj4+IEEgcXVpY2sgc2NhbiBv
ZiB0aGUgREE5MDYyIGRhdGFzaGVldCBzaG93cyB0aGF0IHJlZy9maWVsZCBFTl8zMksvQ1JZU1RB
TCB3aWxsDQo+PiBpbmRpY2F0ZSB0aGUgcHJlc2VuY2Ugb2YgYSAzMktIeiBjcnlzdGFsIG9zY2ls
bGF0b3IuIE9idmlvdXNseSBvbiBEQTkwNjEgdGhhdA0KPj4gb3B0aW9uIGlzbid0IGF2YWlsYWJs
ZS4NCj4+DQo+PiBJIHRoaW5rIHRoZSBwcm9ibGVtIHNlZW1zIHRvIGxpZSBhcm91bmQgZGV0ZXJt
aW5pbmcgdGhlIGludGVybmFsIG9zY2lsbGF0b3Incw0KPj4gZnJlcXVlbmN5LiBEYXRhc2hlZXQg
cmVmZXJlbmNlcyAyNU1oeiBpbiBUYWJsZSA5IChXYXRjaGRvZyBFbGVjdHJpY2FsDQo+PiBDaGFy
YWN0ZXJpc3RpY3MpLCBidXQgdGhhdCBkb2Vzbid0IHNlZW0gdG8gdGFsbHkgd2l0aCB5b3VyIHRp
bWluZ3MgYW5kIEkgZG9uJ3QNCj4+IHNlZSBhbiBvYnZpb3VzIHdheSBpbiB0aGUgcmVnbWFwIHRv
IGNhbGN1bGF0ZSB0aGlzIGF0IHJ1biB0aW1lLiAqSWYqIHRoZQ0KPj4gb3NjaWxsYXRvciBmcmVx
dWVuY3kgdmFyaWVzIGZyb20gcGFydCB0byBwYXJ0LCBvciB1bmRlciBkaWZmZXJlbnQgZW52aXJv
bm1lbnRhbA0KPj4gY29uZGl0aW9ucywgdGhlbiBpdCdzIGdvaW5nIHRvIGJlIHRvdWdoIHRvIHRp
ZSB0aGlzIGRvd24sIGFuZCB5b3Ugd291bGRuJ3Qgd2FudA0KPj4gdG8gc3RhdGUgYSB0aW1lb3V0
IHZhbHVlIHRoYXQncyBsb25nZXIgdGhhbiByZWFsaXR5Lg0KPiANCj4gQEFkYW0NCj4gV2hhdCBk
byB5b3UgdGhpbmsgaWYgSSBhZGQgYWxzbyB0aGUgdGltZW91dCB2YWx1ZXMgZm9yIHRoZSBpbnRl
cm5hbA0KPiBvc2NpbGxhdG9yPw0KPiBUaGFuIHRoZSB2YWx1ZXMgd291bGQgYmU6DQo+IA0KPiB0
ID0gMl4oMTUrVFdEU0NBTEUpIC8gZg0KPiANCj4gSW50ZXJuYWwgMjVrSHogb3NjaWxsYXRvcjog
MCAgMiAgNSAgMTAgIDIwICA0MSAgODMgMTY3DQo+IA0KPiBJbiBjb21wYXJpc29uIHRvIHRoZQ0K
PiBleHRlcm5hbCAzMmtIeiBvc2NpbGxhdG9yOiAwICAyICA0ICAgOCAgMTYgIDMyICA2NSAxMzEN
Cj4gDQo+IFNvIHRoZSBkaWZmZXJlbmNlIHRvIG15IG1lYXN1cmVkIHZhbHVlcyB3aWxsIGRlY3Jl
YXNlIGFuZCBpdCB3aWxsIGltcHJvdmUNCj4gdGhlDQo+IGN1cnJlbnQgZHJpdmVyIHRvd2FyZHMg
bW9yZSBhY2N1cmF0ZSB2YWx1ZXMuDQo+IA0KPiBCdHcgaWYgSSBjYWxjdWxhdGUgdGhlIHZhbHVl
cyB3aXRoIDMyNzY4SHogKHRoZSB0eXBpY2FsIDMya0h6IG9zY2lsbGF0b3IpLCBJDQo+IGdldCB0
aGUNCj4gZm9sbG93aW5nIHZhbHVlczoNCj4gMzI3NjhIeiBvc2NpbGxhdG9yOiAgICAgICAgMCAg
MiAgNCAgIDggIDE2ICAzMiAgNjQgMTI4DQoNCkkgY29tZSB0byB0aGUgY29uY2x1c2lvbiB0aGF0
IHVuZGVyIG5vcm1hbCBjb25kaXRpb24gKHJvb20gdGVtcGVyYXR1cmUpIHRoZQ0KdGltZW91dCB2
YWx1ZXMgY291bGQgYmUgaW1wcm92ZWQsIGJ1dCBkdWUgdG8gdGhlIHVzZWQgaW50ZXJuYWwgcmlu
ZyBvc2NpbGxhdG9yDQpvbiB0aGUgREE5MDYxIGNoaXAgdW5kZXIgZXh0cmVtZSBjb25kaXRpb25z
IGxpa2UgYXV0b21vdGl2ZSAoMTI1IGRlZ3JlZXMpIHRoZQ0KdmFsdWVzIGNvbWUgY2xvc2UgdG8g
dGhlIERBOTA2MiB0aW1lb3V0IHZhbHVlcywgaWYgYW4gZXh0ZXJuYWwgb3NjaWxsYXRvcg0KaXMg
dXNlZC4gSW4gb3JkZXIgbm90IHRvIHRyaWdnZXIgdG9vIGVhcmx5IGluIGV4dHJlbWUgc2l0dWF0
aW9ucywgdGhlIHZhbHVlcw0KbXVzdCBiZSBsZWZ0IGFzIHRoZXkgYXJlLiBCdXQgSSB0b2xkIERp
YWxvZyB0byBhZGQgYSBub3RlIGluIHRoZSBkYXRhIHNoZWV0DQpleHBsYWluaW5nIHRoZSBkZXZp
YXRpb24gd2hlbiB0aGUgaW50ZXJuYWwgb3NjaWxsYXRvciBpcyB1c2VkIChEQTkwNjEpLg0KDQpU
aGFua3MgZm9yIGhlbHBpbmcgbWUgYW5kIGJlc3QgcmVnYXJkcw0KQ2hyaXN0b3BoDQo=
