Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7674A5B14EC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 08:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbiIHGpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 02:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiIHGpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 02:45:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EEFD0755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 23:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662619542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vUaj/TzGiYURsXpCpPVqXBkUIT39jUWVTBNjFRgF1Ys=;
        b=P7ImJZN27arXd9LGp8jeItorzm+BVmdPZOkHeRjcNsSvlZPv2lnLQU6WuAwL1Bycnv0SKU
        U18iLeAmLw+MdaMWuvUxbiC9Z+3+xFIaN/Tl5KdkILrEHtvcboHE/y2R1RHUmXaa5fV6ru
        uMXbf0QVvXfoetHY3mY0+0WGnMGE3z8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-479-7umu2adGPaO8InLovUJwTw-1; Thu, 08 Sep 2022 02:45:41 -0400
X-MC-Unique: 7umu2adGPaO8InLovUJwTw-1
Received: by mail-wm1-f70.google.com with SMTP id c25-20020a05600c0ad900b003a5ebad295aso176331wmr.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 23:45:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:subject:from:references:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=vUaj/TzGiYURsXpCpPVqXBkUIT39jUWVTBNjFRgF1Ys=;
        b=nqv5X2pkmmq9Rf6z+1JsUDWoDHw7GtWEdY3gdj54QD659mv/0dEY65DHAlmofNZ+ej
         5jHC7uKRRu5mCJGJjcWqqY21xet1stVMmj1wxCyhc+jps95Y76jFGxsBNiKR4dFbfdg9
         67CXR1W0l5Bm3QUdvTe3T8IV9WNx2cKMCUpbceJUdcfnDwmKBEz2JnNXU8kdNAGAnAJ1
         gvCKbWCrGpMoV4zrR4WWmYHUacfO3gVxPBhnfk1o3fOFRVXTH8E41IRBw5eC1VhopxYY
         lxVfHQ5PK/xonWVGDkYasELBySX+ISxdziNzz4BbCiHWLI+f6hndvkFy3aY35KEWR4nr
         7KMw==
X-Gm-Message-State: ACgBeo0LUh3mMMi0lYQYmvHoq00l2Si44PcE7JECveKaSwbdeUhT9cd6
        pqrERlLCCHSzUlo3DD66IH3859o6o7AB5YZKhdnUV1PA4XgC03HHaubBwKh5taRMN3i74Jy6eHJ
        AVHBss4391HnlqIgEEqaYclq3
X-Received: by 2002:a5d:4f8e:0:b0:228:c692:126f with SMTP id d14-20020a5d4f8e000000b00228c692126fmr3962483wru.315.1662619540338;
        Wed, 07 Sep 2022 23:45:40 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4QfTzl5V9tPYuu1S4M+nDUBmuqDN+jRgu3jwV2Ic+jSt96UMnSRaQTCgD/djN7A2Vk/vz+3w==
X-Received: by 2002:a5d:4f8e:0:b0:228:c692:126f with SMTP id d14-20020a5d4f8e000000b00228c692126fmr3962463wru.315.1662619540118;
        Wed, 07 Sep 2022 23:45:40 -0700 (PDT)
Received: from [192.168.1.40] (82-64-217-13.subs.proxad.net. [82.64.217.13])
        by smtp.gmail.com with ESMTPSA id m2-20020a05600c3b0200b003a5ee64cc98sm1605020wms.33.2022.09.07.23.45.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 23:45:39 -0700 (PDT)
Message-ID: <b1673cd8-dd6d-8b50-6c5a-c715f368f12d@redhat.com>
Date:   Thu, 8 Sep 2022 08:45:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Content-Language: fr-FR, en-US
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Oleksandr Natalenko <oleksandr@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Will Deacon <will@kernel.org>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Stephen Kitt <steve@sk2.org>, Rob Herring <robh@kernel.org>,
        Joel Savitz <jsavitz@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Grzegorz Halat <ghalat@redhat.com>, Qi Guo <qguo@redhat.com>
References: <20220903064330.20772-1-oleksandr@redhat.com>
 <Yxi+dQkuV2zdBzk3@bombadil.infradead.org>
From:   =?UTF-8?Q?Renaud_M=c3=a9trich?= <rmetrich@redhat.com>
Subject: Re: [PATCH] core_pattern: add CPU specifier
In-Reply-To: <Yxi+dQkuV2zdBzk3@bombadil.infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------k8la8Uj55ngffJ2zzB3njW3t"
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------k8la8Uj55ngffJ2zzB3njW3t
Content-Type: multipart/mixed; boundary="------------ozI1oNvwj07SgA7LzGWdRxR4";
 protected-headers="v1"
From: =?UTF-8?Q?Renaud_M=c3=a9trich?= <rmetrich@redhat.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
 Oleksandr Natalenko <oleksandr@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>, Huang Ying
 <ying.huang@intel.com>, "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Will Deacon <will@kernel.org>, "Guilherme G . Piccoli"
 <gpiccoli@igalia.com>, Laurent Dufour <ldufour@linux.ibm.com>,
 Stephen Kitt <steve@sk2.org>, Rob Herring <robh@kernel.org>,
 Joel Savitz <jsavitz@redhat.com>, "Eric W . Biederman"
 <ebiederm@xmission.com>, Kees Cook <keescook@chromium.org>,
 Xiaoming Ni <nixiaoming@huawei.com>, Oleg Nesterov <oleg@redhat.com>,
 Grzegorz Halat <ghalat@redhat.com>, Qi Guo <qguo@redhat.com>
Message-ID: <b1673cd8-dd6d-8b50-6c5a-c715f368f12d@redhat.com>
Subject: Re: [PATCH] core_pattern: add CPU specifier
References: <20220903064330.20772-1-oleksandr@redhat.com>
 <Yxi+dQkuV2zdBzk3@bombadil.infradead.org>
In-Reply-To: <Yxi+dQkuV2zdBzk3@bombadil.infradead.org>

--------------ozI1oNvwj07SgA7LzGWdRxR4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGVsbG8sDQoNCkkgaGF2ZSBiZWVuIHdvcmtpbmcgY2xvc2VseSB3aXRoIE9sZWtzYW5kciBv
biBhIGNvdXBsZSBvZiBjYXNlcyB3aGVyZSANCmN1c3RvbWVycyBjb3VsZCBzZWUgc2VnZmF1
bHRzIGZvciB2YXJpb3VzIHByb2Nlc3NlcywgaW5jbHVkaW5nIGJhc2ljIA0KdG9vbHMgKCJn
cmVwIiwgImN1dCIsIGV0Yy4pIHRoYXQgdXN1YWxseSBkb24ndCBkaWUuDQoNClRoZSBjb3Jl
ZHVtcHMgc2hvd2VkIG9mIGNvdXJzZSBub3RoaW5nIGJlY2F1c2UgZnJvbSB1c2VybGFuZCdz
IA0KcGVyc3BlY3RpdmUgdGhlcmUgd2FzIG5vdGhpbmcgd3JvbmcsIGJ1dCBqdXN0IGEgYmFk
IHBvaW50ZXIgd2hpY2ggDQpjb3VsZG4ndCBiZSBleHBsYWluZWQuDQoNCk1lbW9yeSB0ZXN0
aW5nIChlLmcuIE1lbXRlc3Q4NispIGFuZCBDUFUgdGVzdGluZyAodXN1YWxseSBmcm9tIGhh
cmR3YXJlIA0KdmVuZG9yKSBuZXZlciBzaG93ZWQgYW55IGlzc3VlIHdpdGggdGhlIGhhcmR3
YXJlIGFzIHdlbGwsIGV2ZW4gdGhvdWdoIA0KdGhlcmUgd2FzLCBwcm9iYWJseSBiZWNhdXNl
IGl0IHJlcXVpcmVkIHNwZWNpYWwgY29uZGl0aW9ucywgc3VjaCBhcyANCnNwZWNpZmljIGxv
YWQgYW5kL29yIHRoZXJtYWwgY29uZGl0aW9ucy4NCg0KVGhlIHRyb3VibGVzaG9vdGluZyBv
ZiBzdWNoIGNhc2VzIHRha2VzIHNldmVyYWwgd2Vla3Mgb3IgZXZlbiBtb250aHMsIA0KdW50
aWwgd2UgaGF2ZSBlbm91Z2ggZXZpZGVuY2UgaXQncyBub3QgdGhlIE9TIHRoYXQgaXMgZmF1
bHR5LCBhbmQgaXQncyANCmFsd2F5cyBzdHJ1Z2dsaW5nLg0KDQpVc3VhbGx5IHdoZW4gd2Ug
c3RhcnQgZ2V0dGluZyBrZXJuZWwgY3Jhc2hlcywgd2UgYXJlIHRoZW4gaGFwcHkgYmVjYXVz
ZSANCmtlcm5lbCBjcmFzaGVzIGluZGljYXRlIHRoZSBDUFUgdGhlIHRhc2sgd2FzIHJ1bm5p
bmcgb24sIGFuZCBpdCBzZWVtcyB0byANCmFsd2F5cyBiZSByZWxpYWJsZSBlbm91Z2ggaW5m
b3JtYXRpb24gdG8gcG9pbnQgdG8gZmF1bHR5IENQVS4gRm9yIG90aGVyIA0KY2FzZXMgd2hl
cmUgbm8ga2VybmVsIGNyYXNoIGNvdWxkIGJlIG9ic2VydmVkLCB0aGVzZSBhcmUgc29sdmVk
IGFmdGVyIA0KcmVxdWVzdGluZyB0aGUgY3VzdG9tZXIgdG8gcmVwbGFjZSB0aGUgaGFyZHdh
cmUgY29tcG9uZW50cywgd2hpY2ggaXMgDQpzb21ldGhpbmcgZGlmZmljdWx0IHRvIGV4cGxh
aW4gc2luY2UgaXQgdXN1YWxseSBjb3N0cyB0aGUgY3VzdG9tZXIgbW9uZXkgDQphbmQgdGlt
ZS4NCg0KSSBob3BlIHN1Y2ggZmVhdHVyZSB3aWxsIGJlIGhlbHBmdWwgZm9yIGV2ZXJ5Ym9k
eSBkb2luZyBMaW51eCBzdXBwb3J0Lg0KDQpSZW5hdWQuDQoNCkxlIDkvNy8yMiDDoCAxNzo1
MywgTHVpcyBDaGFtYmVybGFpbiBhIMOpY3JpdMKgOg0KPiBPbiBTYXQsIFNlcCAwMywgMjAy
MiBhdCAwODo0MzozMEFNICswMjAwLCBPbGVrc2FuZHIgTmF0YWxlbmtvIHdyb3RlOg0KPj4g
U3RhdGlzdGljYWxseSwgaW4gYSBsYXJnZSBkZXBsb3ltZW50IHJlZ3VsYXIgc2VnZmF1bHRz
IG1heSBpbmRpY2F0ZSBhIENQVSBpc3N1ZS4NCj4gQ2FuIHlvdSBlbGFib3JhdGUgb24gdGhp
cz8gSG93IGNvbW1vbiBpcyB0aGlzIG9ic2VydmVkIHRvIGJlIHRydWU/IEFyZQ0KPiB0aGVy
ZSBhbnkgcHVibGljIGZpbmRpbmdzIG9yIGJ1Z3Mgd2hlcmUgaXQgc2hvd2VkIHRoaXM/DQo+
DQo+ICAgIEx1aXMNCj4NCg==

--------------ozI1oNvwj07SgA7LzGWdRxR4--

--------------k8la8Uj55ngffJ2zzB3njW3t
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEDdWGHF0SM+2VX5h9XRKQlPtuQyYFAmMZj5IFAwAAAAAACgkQXRKQlPtuQyaR
khAAmf9a/W12v18Qz3c/Bl2ZaGGvfFY8ZiTpDH9/yVW+7zych78DMDKACnaYUE9AYseqYQ3Ldgc7
jX2sn3WCT3s5Fk6TtpPaklmtyegMGgHBQo/m15xx2U6Gb7NevsJ/0sCMcvrRpTaxeuNn1a2yY2v5
Xo4XSs0T6rUnU8Tg82DgHogURsIcsku/yVhR70H6KjbV7SjUbfAsqqDMFqTnbIStqly1W9Z6jVqH
xuzQ0d+Z+DYrBl0b8rtQrfWvPqA1Z0q9CtQIek+caUzAFbVQoI+hepiFSqdbB2ZhoWRiGJwiF+Di
HDFUgn/pvucFcfJXDnklBQQ1RLwF5XSLcAUJ55Scq3hsFpJ9+3dc1oNOfBmuIr3hPuSi84+tQyXu
QFY6Djph3LLa4acWu7IGeh+7BjQdXKrRfCKFq86NoF1GYHTgREwCA3g3pMm9v+0odlOcUSJY3phe
UZ9DSV8q+KHvbf4a5XmcY51NpablPMtZxc9EY4z9YZ9tDtJ2IJa+OyVwyl/p52cS2ga9zcsIanif
AS9x20tM9BW2AFacyXR+UdSYbLWIs0fJyPd7/45A9u4v9UyNkyBpa4rOIKNHF7j6wCGabp4zJvnp
6MZ9+6DW6FW8S01aPpZedM8JKCaXqJzl2sBRGcOS39QPuzQBKRoy0Zi8BflLdKH2EPjVv/1HXYGn
QbQ=
=eLrW
-----END PGP SIGNATURE-----

--------------k8la8Uj55ngffJ2zzB3njW3t--

