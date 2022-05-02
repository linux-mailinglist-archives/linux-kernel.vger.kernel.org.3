Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D59517034
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 15:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236178AbiEBNY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 09:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385309AbiEBNYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 09:24:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946CB13B;
        Mon,  2 May 2022 06:20:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DA987210E3;
        Mon,  2 May 2022 13:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651497623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d2Ek6JLvpHBKhP9xYjX+TNERo7MBjYhMMbP3fK5HvYQ=;
        b=amXr9iXgmhXMym3/MvAWFma/GlvWTX7dVs4HHaCPxfkUJDzwkqoU3Ih/XFUizusV+PaB2b
        2/Kr0uU+F06Gqh0nQSrQsaBk807NIsTlSunRiPNOH6SaPsiCs4w5h+k/xbSa2TnerTzdlF
        pCcrCdkqhYh7HrvPCnAJDnOlbJ9kfbA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651497623;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d2Ek6JLvpHBKhP9xYjX+TNERo7MBjYhMMbP3fK5HvYQ=;
        b=ttDojIWHIPmEPHkL6F/jIP5EWJSbGL8YHK50uR+2k5VqBgHE1hF5t5G0Aw/znHGG9wwkqh
        EurWKJiuigRCUkBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 99E19133E5;
        Mon,  2 May 2022 13:20:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wC+VJJfab2LXEgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 02 May 2022 13:20:23 +0000
Message-ID: <193c9eef-af13-219c-e5e0-2cc9469bf562@suse.de>
Date:   Mon, 2 May 2022 15:20:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] fbdev: Make fb_release() return -ENODEV if fbdev was
 unregistered
Content-Language: en-US
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-fbdev@vger.kernel.org, Helge Deller <deller@gmx.de>,
        Zheyu Ma <zheyuma97@gmail.com>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        dri-devel@lists.freedesktop.org, Maxime Ripard <maxime@cerno.tech>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Guenter Roeck <linux@roeck-us.net>
References: <20220502130944.363776-1-javierm@redhat.com>
 <20220502130944.363776-3-javierm@redhat.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <20220502130944.363776-3-javierm@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------iz1bNvbGdLcki36S08vCV0oM"
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------iz1bNvbGdLcki36S08vCV0oM
Content-Type: multipart/mixed; boundary="------------q1K1zep9Mqp7z0IfDOIbTW60";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Javier Martinez Canillas <javierm@redhat.com>,
 linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, Helge Deller <deller@gmx.de>,
 Zheyu Ma <zheyuma97@gmail.com>, Changcheng Deng
 <deng.changcheng@zte.com.cn>, dri-devel@lists.freedesktop.org,
 Maxime Ripard <maxime@cerno.tech>, Zhen Lei <thunder.leizhen@huawei.com>,
 Alex Deucher <alexander.deucher@amd.com>, Sam Ravnborg <sam@ravnborg.org>,
 Guenter Roeck <linux@roeck-us.net>
Message-ID: <193c9eef-af13-219c-e5e0-2cc9469bf562@suse.de>
Subject: Re: [PATCH 2/2] fbdev: Make fb_release() return -ENODEV if fbdev was
 unregistered
References: <20220502130944.363776-1-javierm@redhat.com>
 <20220502130944.363776-3-javierm@redhat.com>
In-Reply-To: <20220502130944.363776-3-javierm@redhat.com>

--------------q1K1zep9Mqp7z0IfDOIbTW60
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQoNCkFtIDAyLjA1LjIyIHVtIDE1OjA5IHNjaHJpZWIgSmF2aWVyIE1hcnRpbmV6IENhbmls
bGFzOg0KPiBBIHJlZmVyZW5jZSB0byB0aGUgZnJhbWVidWZmZXIgZGV2aWNlIHN0cnVjdCBm
Yl9pbmZvIGlzIHN0b3JlZCBpbiB0aGUgZmlsZQ0KPiBwcml2YXRlIGRhdGEsIGJ1dCB0aGlz
IHJlZmVyZW5jZSBjb3VsZCBubyBsb25nZXIgYmUgdmFsaWQgYW5kIG11c3Qgbm90IGJlDQo+
IGFjY2Vzc2VkIGRpcmVjdGx5LiBJbnN0ZWFkLCB0aGUgZmlsZV9mYl9pbmZvKCkgYWNjZXNz
b3IgZnVuY3Rpb24gbXVzdCBiZQ0KPiB1c2VkIHNpbmNlIGl0IGRvZXMgc2FuaXR5IGNoZWNr
aW5nIHRvIG1ha2Ugc3VyZSB0aGF0IHRoZSBmYl9pbmZvIGlzIHZhbGlkLg0KPiANCj4gVGhp
cyBjYW4gaGFwcGVuIGZvciBleGFtcGxlIGlmIHRoZSBmYmRldiBkcml2ZXIgd2FzIG9uZSB0
aGF0IGlzIHVzaW5nIGENCj4gZnJhbWVidWZmZXIgcHJvdmlkZWQgYnkgdGhlIHN5c3RlbSBm
aXJtd2FyZS4gSW4gdGhhdCBjYXNlLCB0aGUgZmJkZXYgY29yZQ0KPiBjb3VsZCB1bnJlZ2lz
dGVyIHRoZSBmcmFtZWJ1ZmZlciBkZXZpY2UgaWYgYSByZWFsIHZpZGVvIGRyaXZlciBpcyBw
cm9iZWQuDQo+IA0KPiBSZXBvcnRlZC1ieTogTWF4aW1lIFJpcGFyZCA8bWF4aW1lQGNlcm5v
LnRlY2g+DQo+IFNpZ25lZC1vZmYtYnk6IEphdmllciBNYXJ0aW5leiBDYW5pbGxhcyA8amF2
aWVybUByZWRoYXQuY29tPg0KDQpSZXZpZXdlZC1ieTogVGhvbWFzIFppbW1lcm1hbm4gPHR6
aW1tZXJtYW5uQHN1c2UuZGU+DQoNClRoaXMgc2VlbXMgbGlrZSB0aGUgY29ycmVjdCB0aGlu
ZyB0byBkbyBpbiBhbnkgY2FzZS4gVGhhbmtzIGZvciB0aGUgDQpwYXRjaC4gQmVmb3JlIG1l
cmdpbmcsIHlvdSBzaG91bGQgYWxzbyBhZGQNCg0KRml4ZXM6IDI3NTk5YWFjYmFlZiAoImZi
ZGV2OiBIb3QtdW5wbHVnIGZpcm13YXJlIGZiIGRldmljZXMgb24gZm9yY2VkIA0KcmVtb3Zh
bCIpDQpSZXBvcnRlZC1ieTogSnVueGlhbyBDaGFuZyA8anVueGlhby5jaGFuZ0BpbnRlbC5j
b20+DQoNCkJlc3QgcmVnYXJkcw0KVGhvbWFzDQoNCj4gLS0tDQo+IA0KPiAgIGRyaXZlcnMv
dmlkZW8vZmJkZXYvY29yZS9mYm1lbS5jIHwgNSArKysrLQ0KPiAgIDEgZmlsZSBjaGFuZ2Vk
LCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3ZpZGVvL2ZiZGV2L2NvcmUvZmJtZW0uYyBiL2RyaXZlcnMvdmlkZW8vZmJkZXYv
Y29yZS9mYm1lbS5jDQo+IGluZGV4IDIwZDg5MjlkZjc5Zi4uZDY4MDk3MTA1ZjkzIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL3ZpZGVvL2ZiZGV2L2NvcmUvZmJtZW0uYw0KPiArKysgYi9k
cml2ZXJzL3ZpZGVvL2ZiZGV2L2NvcmUvZmJtZW0uYw0KPiBAQCAtMTQzOSw3ICsxNDM5LDEw
IEBAIGZiX3JlbGVhc2Uoc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGZpbGUgKmZpbGUp
DQo+ICAgX19hY3F1aXJlcygmaW5mby0+bG9jaykNCj4gICBfX3JlbGVhc2VzKCZpbmZvLT5s
b2NrKQ0KPiAgIHsNCj4gLQlzdHJ1Y3QgZmJfaW5mbyAqIGNvbnN0IGluZm8gPSBmaWxlLT5w
cml2YXRlX2RhdGE7DQo+ICsJc3RydWN0IGZiX2luZm8gKiBjb25zdCBpbmZvID0gZmlsZV9m
Yl9pbmZvKGZpbGUpOw0KPiArDQo+ICsJaWYgKCFpbmZvKQ0KPiArCQlyZXR1cm4gLUVOT0RF
VjsNCj4gICANCj4gICAJbG9ja19mYl9pbmZvKGluZm8pOw0KPiAgIAlpZiAoaW5mby0+ZmJv
cHMtPmZiX3JlbGVhc2UpDQoNCi0tIA0KVGhvbWFzIFppbW1lcm1hbm4NCkdyYXBoaWNzIERy
aXZlciBEZXZlbG9wZXINClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdlcm1hbnkgR21iSA0K
TWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnLCBHZXJtYW55DQooSFJCIDM2ODA5LCBB
RyBOw7xybmJlcmcpDQpHZXNjaMOkZnRzZsO8aHJlcjogSXZvIFRvdGV2DQo=

--------------q1K1zep9Mqp7z0IfDOIbTW60--

--------------iz1bNvbGdLcki36S08vCV0oM
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmJv2pcFAwAAAAAACgkQlh/E3EQov+AA
lRAAs9/I2Ec7f8mNoik0X1EWbynPc59K/6jn7nozsTzUx5/rlqt+e+JHAG1YFmij8tuCaS3qVJC3
WxtXCy2/UDPeCljwWxikOf47gPWrOEIQgB2IVYFT/vD9RCptLiNWfGdluUuwcqE8TeV2LbgI0XKi
h5STdRPudu4NxX5VUdo7MjapwOJA6n2NcRvATKicaTJPsSKAc66B+8vIzlMjCHlj908zGOfjR7Op
ZU7n47LMQJJLDKlTFmfhDK04FApaI7V2Hh1inLRQUXMKbSkyWQqZsOTg/USxOdalOdzVAN8gDaPR
vzo5pzbFMv9jfaPkgqCTqM4s720FD3on2+Xb+IB7T7dOZMuBfild5BeZ5Havxx8o/qBnQgHWq/zI
34oipAxGZjK9NHAH1FGgswtDhheI8DVBE75Pe2sMkWtAT9j2bl4Mieb7qZDa0iMxkTry5OG6o/fJ
5Z9Y3ZInNityIZDooom+a2LLYpeQa8tWZFRC7V9e8Z0hlX4uWYbFeHOCKCmX0XAJ+oF8C6K0lsP2
+tMjYdUla5aRwNIMUv2/KNKfntqMPf3hUoFhTdgky/3/2tVyFpnhvhMscANbNpD5M09jghyo6jSn
7q58EbVMH0NQGCMl4Z0JSndaMqNm5vaj+oXuiPKuxn+ysjDU0eadlTSfOvVVng9wPn59Td7UPVsx
uc0=
=hMuj
-----END PGP SIGNATURE-----

--------------iz1bNvbGdLcki36S08vCV0oM--
