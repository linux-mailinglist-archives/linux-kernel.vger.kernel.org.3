Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4AC94F1E1A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381151AbiDDVtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379094AbiDDQfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:35:03 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCDF37ABA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 09:33:06 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id q14so13592300ljc.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 09:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to;
        bh=rjLGczWizbWUdGnSt0vDUWu3PXooLXjZ1ROSEOwEXPw=;
        b=DNZ2DwfWAf4BHizBXbAlRFMmpWXTQ2dudtm88Dc1mxCOpZPp4IPiKKcuATTK+vA1IR
         sJLz24EaEP/06uYuX/G5rx/17ig/SKqLLsWsyHS4IjPL+VRjFNLFGdMJVYYzrxZQpEzR
         Nznc0wmV91LXxMs1YjC6pxoV8IWA1FbbRNBIz12Y7jVwAHDlunrvFSLb01SjkTeb1PNw
         9tjrAOCZCF8zE9YaL8H/5/Yd/9euGu6w1of16YDyjOApo4sL7sGMzFsOP1rFRpGBEIi7
         8wWxgpMUbFgKEZ1oejWLcEn8OP2wulupUyAqgruzcMTysgJotHP1xvx6Bo8sQmUe7Kll
         z5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to;
        bh=rjLGczWizbWUdGnSt0vDUWu3PXooLXjZ1ROSEOwEXPw=;
        b=zJthJbZ0Wleo8UCvh7e1dfeAPAzjc/ppDpWmxff56r1EUNfcIHRW2B42fe8mfustSu
         cTj2VVYTsbzXzhg3/EBd1lfXC5LvD8ZEfC5cBxx4pOBxFSqnSaoNC5SPQFPBHFWL9tFh
         mlSAahhRcKi7ORI/2iBRyln5bcaBYr5woM/eERuqu+Zwk6G9qpl/qNWJ9HxfMMzNhVzJ
         n2npcYNFVqnwuTRRqwvfcL5C2+BnC8BgJn9eXC9LwI4GprfRFO4Tztq4MKYwtmGpQj8O
         wk2RmZ0GxSGuTquzUCJJCQ6i/3+Z5O6t/4wTfgt447PrbrkmtZs/386KVcW3xSTP1b58
         fn7w==
X-Gm-Message-State: AOAM531yzp7vzzcHA8/HX0fEhTyD5WfKRyxXIeouh9EpsWC1KkRuYp5S
        IvIu6Y2yrownSclOctueYLQ=
X-Google-Smtp-Source: ABdhPJyLRVGEt3HCyLJ4WVcpR4rBK6a3Sq7xwxEjLpfYkIlc1sPj4VpSgi2qlbHvfZkrR4WV0I4f9A==
X-Received: by 2002:a2e:9886:0:b0:24a:c13b:5337 with SMTP id b6-20020a2e9886000000b0024ac13b5337mr238380ljj.409.1649089983374;
        Mon, 04 Apr 2022 09:33:03 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.67.247])
        by smtp.gmail.com with ESMTPSA id e9-20020ac25ca9000000b0044aa5a3ee87sm1178514lfq.216.2022.04.04.09.33.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 09:33:02 -0700 (PDT)
Message-ID: <c14c23a0-6b0b-04b3-e58d-786c77726874@gmail.com>
Date:   Mon, 4 Apr 2022 19:33:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V2] Fix unsafe memory access by memcmp
Content-Language: en-US
To:     Charlie Sands <sandsch@northvilleschools.net>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <YkpdVyuQguGzPSNE@sckzor-linux.localdomain>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <YkpdVyuQguGzPSNE@sckzor-linux.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0keD35HDBLORUGAFMhGHGDNw"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------0keD35HDBLORUGAFMhGHGDNw
Content-Type: multipart/mixed; boundary="------------hiTqVXIq4pvg0wCRJw8hfCxM";
 protected-headers="v1"
From: Pavel Skripkin <paskripkin@gmail.com>
To: Charlie Sands <sandsch@northvilleschools.net>, gregkh@linuxfoundation.org
Cc: Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Message-ID: <c14c23a0-6b0b-04b3-e58d-786c77726874@gmail.com>
Subject: Re: [PATCH V2] Fix unsafe memory access by memcmp
References: <YkpdVyuQguGzPSNE@sckzor-linux.localdomain>
In-Reply-To: <YkpdVyuQguGzPSNE@sckzor-linux.localdomain>

--------------hiTqVXIq4pvg0wCRJw8hfCxM
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgQ2hhcmxpZSwNCg0KT24gNC80LzIyIDA1OjUyLCBDaGFybGllIFNhbmRzIHdyb3RlOg0K
PiBUaGlzIHBhdGNoIGZpeGVzIHNwYXJzZSB3YXJuaW5ncyBhYm91dCB0aGUgbWVtY21wIGZ1
bmN0aW9uIHVuc2FmZWx5DQo+IGFjY2Vzc2luZyB1c2Vyc3BhY2UgbWVtb3J5IHdpdGhvdXQg
Zmlyc3QgY29weWluZyBpdCB0byBrZXJuZWwgc3BhY2UuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBDaGFybGllIFNhbmRzIDxzYW5kc2NoQG5vcnRodmlsbGVzY2hvb2xzLm5ldD4NCj4gLS0t
DQo+IA0KPiBWMjogRml4ZWQgY2hlY2twYXRjaC5wbCB3YXJuaW5nIGFuZCBjaGFuZ2VkIHZh
cmlhYmxlIG5hbWUgYXMgc3VnZ2VzdGVkDQo+IGJ5IEdyZWcgSy4gSC4gYW5kIGltcHJvdmVk
IGVycm9yIGNoZWNraW5nIG9uIHRoZSAiY29weV9mcm9tX3VzZXIiIGZ1bmN0aW9uIGFzDQo+
IHN1Z2dlc3RlZCBieSBQYXZlbCBTa3JpcGtpbi4NCj4gDQoNCllvdSBkaWQgbm90IGltcHJv
dmVkIGVycm9yIGhhbmRsaW5nIG9mIGNvcHlfZnJvbV91c2VyKCkgYXMgSSBzdWdnZXN0ZWQu
IA0KaWYgKGV4cHIpIGFuZCBpZiAoZXhwciAhPSAwKSBhcmUgZXhhY3RseSB0aGUgc2FtZQ0K
DQo+ICAgZHJpdmVycy9zdGFnaW5nL3I4MTg4ZXUvb3NfZGVwL2lvY3RsX2xpbnV4LmMgfCAy
MSArKysrKysrKysrKystLS0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRp
b25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3Rh
Z2luZy9yODE4OGV1L29zX2RlcC9pb2N0bF9saW51eC5jIGIvZHJpdmVycy9zdGFnaW5nL3I4
MTg4ZXUvb3NfZGVwL2lvY3RsX2xpbnV4LmMNCj4gaW5kZXggN2RmMjEzODU2ZDY2Li40YjRl
ZWMyYmRlOTYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc3RhZ2luZy9yODE4OGV1L29zX2Rl
cC9pb2N0bF9saW51eC5jDQo+ICsrKyBiL2RyaXZlcnMvc3RhZ2luZy9yODE4OGV1L29zX2Rl
cC9pb2N0bF9saW51eC5jDQo+IEBAIC0zMjMzLDIzICszMjMzLDI4IEBAIHN0YXRpYyBpbnQg
cnR3X3AycF9nZXQoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwNCj4gICAJCQkgICAgICAgc3Ry
dWN0IGl3X3JlcXVlc3RfaW5mbyAqaW5mbywNCj4gICAJCQkgICAgICAgdW5pb24gaXdyZXFf
ZGF0YSAqd3JxdSwgY2hhciAqZXh0cmEpDQo+ICAgew0KPiAtCWlmICghbWVtY21wKHdycXUt
PmRhdGEucG9pbnRlciwgInN0YXR1cyIsIDYpKSB7DQo+ICsJY2hhciB3cnF1X2RhdGFbOV07
DQo+ICsNCj4gKwlpZiAoY29weV9mcm9tX3VzZXIod3JxdV9kYXRhLCB3cnF1LT5kYXRhLnBv
aW50ZXIsIDkpICE9IDApDQo+ICsJCXJldHVybiAwOw0KPiArDQoNCkkndmUgc3VnZ2VzdGVk
IHRvIHJldHVybiAtRUZBVUxUIGhlcmUNCg0KDQoNCg0KV2l0aCByZWdhcmRzLA0KUGF2ZWwg
U2tyaXBraW4NCg==

--------------hiTqVXIq4pvg0wCRJw8hfCxM--

--------------0keD35HDBLORUGAFMhGHGDNw
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEER3XL3TplLQE8Qi40bk1w61LbBA0FAmJLHb0FAwAAAAAACgkQbk1w61LbBA3z
pQ//Wde8u9034ulRbYOwjNRUgTJcxoSK95ldwvPteBws9c6XsRzvo6DIFMyWalcMphgdfPiC7xHT
yeamsXXp13pe6i9gnF7r49OBzgoIeM4KH5bBX/fgNHC/nJHr06qpTsjoyTWP2gcM7D+3UNY72bNi
MFBdxGE9qNqO/wsduSYeDEk9835xsFDx/2W818+m6moper/jnxUTuOGIpaomBU0cX1g7ZWs/2hG0
TT1CbZ5Sh+VQDhvcewC1rka7zG4jgmNwksVHv9NYfqqsR/HDygAUggjbeMwvJPVgUgyoqMisp3Zn
AaNYnxZvmKJ/9iPfbVXX2ZHDFnahIyDpISB8YmGf7LC01wrR7Ls0Gvjw0s3hi4NacOkDUvwr/VMq
OqDO1JBWEzWHbbYnOhqRFgu45AfjiiiGdpHd/gpxYrQWkpEnCaJYpKlhsm9/N/d+PgO/kGA1wibK
4YDlVoO1PZYN+vuuzmdX9dftpXBo6KS3di5qU2152Xk5RmYMe090BPXtAkR1O/d/N8anhaK9zUBk
v6qyEhFJpiivNl7Bh1Sddq3oTrTAg+wIl66RL6dPBd1Ju26ZUp6jYDBTY9nFYA/LPmIqoEC3JnaR
eJQIFlp0/qiMz7n6u/sqYv7MTT7N14jYZPDfhsJN8cL8yi0cxj3AW/SxKCMGPD30Fgq3iU/AZsM5
tME=
=381l
-----END PGP SIGNATURE-----

--------------0keD35HDBLORUGAFMhGHGDNw--
