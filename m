Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CCE4F0B2F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 18:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357815AbiDCQSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 12:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359428AbiDCQSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 12:18:10 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F1A36300
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 09:16:15 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id y36so10258922lfa.6
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 09:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to;
        bh=IgtAeZTQuNIa9y3vwgxr//chaauIDEBJQtopnOwTxf4=;
        b=E458HEUBWZfmfR+luit7HwR2waRN/yZo+jmNIrF0m2lR0ej+sIuFUMxq/rwldRPrCr
         T/2gRZtgYtcI6tzNHtZDnRjWWFiad1tlWpCw/Y8QEeQwN3D2UvDq3lRocKfTCPA81qAc
         mqDgsrkqfRVaYhpJqlrQSPu00dIo/y9AFnwJEazArzu/HA1YjRG6nAkspoUcuIhH2/CD
         D9X1ZETDuJi6YHPjDddzWvun07fBvoLEZSeXxA+NFQSKHfML5C0ZBhHXLukdWBK6UXZ7
         DuaWdniCHLIAIFqIkXCvZmALtdV6OPdyi0NT+PpSvuBFAEg9RO68/4rNdCtRJZyDuipN
         HctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to;
        bh=IgtAeZTQuNIa9y3vwgxr//chaauIDEBJQtopnOwTxf4=;
        b=1xR88arW0TW1rP1p7GXyjYGJ1cRRPxNWSQxvgFdGRiPn30SVYI5Ugqr2q4s1/kF/Dd
         6XzCHwokdtB/W49EEak494UAoPIBygt8V3uq57e1f2gu/4dcn13MIIoGoE7xd1qKsmYw
         UDOgSe3i7XcNkE6F/R6mNcozyDHiI5gEyTwTJk61MYPrQpw5PYAfWIJrKX+mWXp56TrV
         vMWdZYOXdBb4+FDetcKYrrTbrtcUdC6lUuNbi0od7ae1qAtdck6YclPo0t5E/TRkPFN3
         31kP8BypVFHXtF++kgu0VEoA074JkOdlZ4EEoD/HIZia7FYl6BSSNcobqqgP7jfRYQyR
         OlYg==
X-Gm-Message-State: AOAM533QURODmhYdXgkZ+7oLtIS805dntNqDy4QHOpx7LZ9PJs4c/V+i
        qT4EK7hEw7thY27ot0PEyh52aMjEqis=
X-Google-Smtp-Source: ABdhPJz316ecGmF83YClGNQ/6k8qgckPw2Y53KWHlACTaqvIV+oZ7xqdXFsSvev18+B8275OvRCQyQ==
X-Received: by 2002:a05:6512:1108:b0:44a:4ad0:433a with SMTP id l8-20020a056512110800b0044a4ad0433amr20086232lfg.16.1649002572173;
        Sun, 03 Apr 2022 09:16:12 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.67.247])
        by smtp.gmail.com with ESMTPSA id cf19-20020a056512281300b0044aee581708sm484694lfb.261.2022.04.03.09.16.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Apr 2022 09:16:11 -0700 (PDT)
Message-ID: <4ccc9ac3-c542-cd32-0cbb-7cdabbf0dbf9@gmail.com>
Date:   Sun, 3 Apr 2022 19:16:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] staging: r8188eu: simplify control flow
Content-Language: en-US
To:     Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
References: <20220403155111.GA333187@euclid>
 <ed0e9f7b-9ba9-b0c8-8261-397bf793b9b9@gmail.com>
 <CAMWRUK6K77KpRkCkruL=RQcmA1opbvapyPJOA-EFpYdXxY8ujQ@mail.gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <CAMWRUK6K77KpRkCkruL=RQcmA1opbvapyPJOA-EFpYdXxY8ujQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------HP4oSgxHM6RwE5D0K0e7s0Hx"
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------HP4oSgxHM6RwE5D0K0e7s0Hx
Content-Type: multipart/mixed; boundary="------------tysZAGg9x0vZfgtw07lIyWLA";
 protected-headers="v1"
From: Pavel Skripkin <paskripkin@gmail.com>
To: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 outreachy@lists.linux.dev
Message-ID: <4ccc9ac3-c542-cd32-0cbb-7cdabbf0dbf9@gmail.com>
Subject: Re: [PATCH] staging: r8188eu: simplify control flow
References: <20220403155111.GA333187@euclid>
 <ed0e9f7b-9ba9-b0c8-8261-397bf793b9b9@gmail.com>
 <CAMWRUK6K77KpRkCkruL=RQcmA1opbvapyPJOA-EFpYdXxY8ujQ@mail.gmail.com>
In-Reply-To: <CAMWRUK6K77KpRkCkruL=RQcmA1opbvapyPJOA-EFpYdXxY8ujQ@mail.gmail.com>

--------------tysZAGg9x0vZfgtw07lIyWLA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgU2V2aW5qLA0KDQpPbiA0LzMvMjIgMTk6MTIsIFNldmluaiBBZ2hheWV2YSB3cm90ZToN
Cj4+DQo+PiBMb29rcyBnb29kLCBidXQgbGV0J3Mgbm90IGludHJvZHVjZSBuZXcgY2hlY2tw
YXRjaCBpc3N1ZToNCj4+DQo+PiBDSEVDSzogQWxpZ25tZW50IHNob3VsZCBtYXRjaCBvcGVu
IHBhcmVudGhlc2lzDQo+PiAjNjI6IEZJTEU6IGRyaXZlcnMvc3RhZ2luZy9yODE4OGV1L2Nv
cmUvcnR3X21sbWUuYzoxNjQ1Og0KPj4gKyAgICAgICAgICAgICAgIGlmICgocC0+UE1LSURM
aXN0W2ldLmJVc2VkKSAmJg0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAo
IW1lbWNtcChwLT5QTUtJRExpc3RbaV0uQnNzaWQsIGJzc2lkLCBFVEhfQUxFTikpKQ0KPiAN
Cj4gVGhhbmtzIGZvciBjYXRjaGluZyB0aGlzLiBJIHdhc24ndCBzZWVpbmcgdGhpcyBpbiBt
eSBjaGVja3BhdGNoDQo+IG91dHB1dCwgYW5kIGFmdGVyIHNvbWUgZGlnZ2luZywgSSBjb3Vs
ZCByZXByb2R1Y2UgaXQgd2l0aCAtLXN0cmljdA0KPiBvcHRpb24uIEkgdGhpbmsgdGhlIHR1
dG9yaWFsIGF0DQo+IGh0dHBzOi8va2VybmVsbmV3Ymllcy5vcmcvUGF0Y2hQaGlsb3NvcGh5
IGRvZXNuJ3QgbWVudGlvbiB0aGlzIG9wdGlvbiwNCj4gc28gcGVyaGFwcyB3ZSBzaG91bGQg
dXBkYXRlIGl0PyENCj4gDQoNClRvIGJlIGhvbmVzdCwgSSBhbSBub3QgY2hlY2twYXRjaCBl
eHBlcnQsIGJ1dCBjaGVja3BhdGNoIG9uIG15IFBDIHNob3dzIA0KdGhpcyB3YXJuaW5nIHcv
byBhbnkgYWRkaXRpb25hbCBvcHRpb25zOg0KDQrilJTilIDilIAkIC4vc2NyaXB0cy9jaGVj
a3BhdGNoLnBsIA0KLi8yMDIyMDQwM19zZXZpbmpfYWdoYXlldmFfc3RhZ2luZ19yODE4OGV1
X3NpbXBsaWZ5X2NvbnRyb2xfZmxvdy5tYnggfCANCnJnIEFsaWdubWVudA0KQ0hFQ0s6IEFs
aWdubWVudCBzaG91bGQgbWF0Y2ggb3BlbiBwYXJlbnRoZXNpcw0KDQoNCg0KDQoNCldpdGgg
cmVnYXJkcywNClBhdmVsIFNrcmlwa2luDQo=

--------------tysZAGg9x0vZfgtw07lIyWLA--

--------------HP4oSgxHM6RwE5D0K0e7s0Hx
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEER3XL3TplLQE8Qi40bk1w61LbBA0FAmJJyEoFAwAAAAAACgkQbk1w61LbBA1C
iRAAoGKkJt1QrQCFV7f6v0yLrMlVv+z66aRtV0/0n5YqG522/V+oCSEbn9UkMBn3U1X4J9nJ+Ny1
Ge9p0MsD3nxv5nT0m7mcmpNRBV/kM2diTwzqNMf+G3Ey2hiSN69gjIWwIlgH2uKi27p794+zwrrd
tNxNqqBxnt2OGUWPISikzZOoAVJg69TuycX6uaGsco1b37NW02FcWOutIibwOqUfob7xGAnvfLQ1
YoBbC9kwp3ziVtJjogJIT92LqRvYNfO5gzcsW5U+WKm/IdnOCYkXwgNk9OTA8hysX98ocztsI+Mc
U7jWzJ2HFG01bMP5mjiTVoa7UNL/yc39dI99rIyxbvnca0SSws5JRY8gRyo1l2z+KhnieMXtCvo7
XSs0tjinQ4KMf0Cwesnt00TkFhDm0ewrNW0r4z3k/4TyRINZSsFNlWUAXBiKpLDNRFLuQd+LxA35
I2djBgmjRmnJ3EoL9QRA4Iq9T5K3I3gTrn9Yo5e/EOBpWrx3Tv0UolA/SFDhb4NSf7xLzoQoopuV
J8JD07k4MiBTQ5AZtUovhxk2enIogqjdW1iY1S/I0l+FdaJ6qyh2HstxNOLN7B4sn3QxGuiE24Ip
FJbMpkE4cy1MbG/t1ZgS5YFrLvlv5zNS2LsZrM+1LZFchl6rSUlo74eF8gnftJ5Htu8ryU7Rd+Jv
fsA=
=fLX7
-----END PGP SIGNATURE-----

--------------HP4oSgxHM6RwE5D0K0e7s0Hx--
