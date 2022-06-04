Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E13753D694
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 13:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235574AbiFDLm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 07:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbiFDLm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 07:42:26 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0739EBA0
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 04:42:25 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id b12so66505ljq.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 04:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to;
        bh=8SwrRgdR9JzGwBlcOs2mbd+GmNcjHpu3NUyHm9CLdNI=;
        b=fJRtLtsU2bmtIOImkMpo8PQCkECthFAt0naWKfmu7nEPH15Q8RdZ/VI1Q7BX18nzHN
         uhXZge2i3oZNWw+V6FccO72+UoCPRVnm7iflWmQ+7NBOyBunV9/tPpxK3bhgHrwNezzZ
         ZSQV40OJyK5UbIvPil9N67HGSskpGRmvl0Pcu+myI2sVVifo54xjfUFCzAwjZ2CMncB5
         X95snmBkoiuoFcqbkCnspfSVeZtW4y7AI9fI5xTzULyxYK+f+zOKf6lWP5w6WOh0kXQY
         qFJlRWXEWAY14jolG2yFdi9jg/q3k9XEuAkt81VUpYNPNXkaL4yNHitEpuvyqx2EblR5
         5RFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to;
        bh=8SwrRgdR9JzGwBlcOs2mbd+GmNcjHpu3NUyHm9CLdNI=;
        b=WoJ3vqSrtX1COWZ5C+q/o4jsrvtIO+iT6Xc3wDrOUgRn5BNDHYMFJmAlp+O9n+ntY6
         E1wxEhHQQzEd4KunVDaQwn1pmm6ZQsZCId06lsTcUP3HhwUPrD1YVJa8HOeXfS2NUk65
         YL4xJI8wlcHKH/jlOg4hgYm/Qmyt4hi6CpRfJndVSD951KdsxTFYRtuI6oP2OK2e5tqJ
         9v37AWIN+jhcMpwMJDfFvZgxCa//4yy4z25uSdToN+Kh7uRe9pjFdXx2/gR4a3D90WJF
         CDIBYYSGeS9/KB63y94BQEMiPY9iRHjCeVCTJT0Ws+Lha+qsG+ihC9gb/wWjDia8kk+F
         XoRg==
X-Gm-Message-State: AOAM5338R/duuBH6B9MRhzdYtloUswqXhg7lA/sJOJmNamob87uyq5Mw
        /LL9eNdb1ZOhn5DpQ9630iM=
X-Google-Smtp-Source: ABdhPJyypDEAMipFXoT/Ecjg4pAYViLXjBIG5AP/UNOmwVOX4fliozloqTcE4nFaU4qu8xCfDJK5/g==
X-Received: by 2002:a2e:a4da:0:b0:255:799e:218a with SMTP id p26-20020a2ea4da000000b00255799e218amr5695333ljm.195.1654342943139;
        Sat, 04 Jun 2022 04:42:23 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.67.4])
        by smtp.gmail.com with ESMTPSA id l10-20020a056512110a00b004791c4858e0sm743048lfg.114.2022.06.04.04.42.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jun 2022 04:42:22 -0700 (PDT)
Message-ID: <89d2979c-7e8a-f63f-327e-1969a4c03c11@gmail.com>
Date:   Sat, 4 Jun 2022 14:42:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/2] ntfs3: fix NULL deref in ntfs_update_mftmirr
Content-Language: en-US
To:     almaz.alexandrovich@paragon-software.com, ntfs3@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     syzbot+c95173762127ad76a824@syzkaller.appspotmail.com
References: <85293dd018cae78e4d48d74ca77710b11eed59ba.1650574393.git.paskripkin@gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <85293dd018cae78e4d48d74ca77710b11eed59ba.1650574393.git.paskripkin@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------FBHa9shtdytwPV0otyLwX20K"
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------FBHa9shtdytwPV0otyLwX20K
Content-Type: multipart/mixed; boundary="------------5k9b1s0YW701NL8kLjgffOzh";
 protected-headers="v1"
From: Pavel Skripkin <paskripkin@gmail.com>
To: almaz.alexandrovich@paragon-software.com, ntfs3@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: syzbot+c95173762127ad76a824@syzkaller.appspotmail.com
Message-ID: <89d2979c-7e8a-f63f-327e-1969a4c03c11@gmail.com>
Subject: Re: [PATCH 1/2] ntfs3: fix NULL deref in ntfs_update_mftmirr
References: <85293dd018cae78e4d48d74ca77710b11eed59ba.1650574393.git.paskripkin@gmail.com>
In-Reply-To: <85293dd018cae78e4d48d74ca77710b11eed59ba.1650574393.git.paskripkin@gmail.com>

--------------5k9b1s0YW701NL8kLjgffOzh
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gNC8yMS8yMiAyMzo1MywgUGF2ZWwgU2tyaXBraW4gd3JvdGU6DQo+IElmIG50ZnNfZmls
bF9zdXBlcigpIHdhc24ndCBjYWxsZWQgdGhlbiBzYmktPnNiIHdpbGwgYmUgZXF1YWwgdG8g
TlVMTC4NCj4gQ29kZSBzaG91bGQgY2hlY2sgdGhpcyBwdHIgYmVmb3JlIGRlcmVmZXJlbmNp
bmcuIFN5emJvdCBoaXQgdGhpcyBpc3N1ZQ0KPiB2aWEgcGFzc2luZyB3cm9uZyBtb3VudCBw
YXJhbSBhcyBjYW4gYmUgc2VlbiBmcm9tIGxvZyBiZWxvdw0KPiANCj4gRmFpbCBsb2c6DQo+
IG50ZnMzOiBVbmtub3duIHBhcmFtZXRlciAnaW9jaHZyc2V0Jw0KPiBnZW5lcmFsIHByb3Rl
Y3Rpb24gZmF1bHQsIHByb2JhYmx5IGZvciBub24tY2Fub25pY2FsIGFkZHJlc3MgMHhkZmZm
ZmMwMDAwMDAwMDAzOiAwMDAwIFsjMV0gUFJFRU1QVCBTTVAgS0FTQU4NCj4gS0FTQU46IG51
bGwtcHRyLWRlcmVmIGluIHJhbmdlIFsweDAwMDAwMDAwMDAwMDAwMTgtMHgwMDAwMDAwMDAw
MDAwMDFmXQ0KPiBDUFU6IDEgUElEOiAzNTg5IENvbW06IHN5ei1leGVjdXRvcjIxMCBOb3Qg
dGFpbnRlZCA1LjE4LjAtcmMzLXN5emthbGxlci0wMDAxNi1nYjI1MzQzNTc0NmQ5ICMwDQo+
IC4uLg0KPiBDYWxsIFRyYWNlOg0KPiAgIDxUQVNLPg0KPiAgIHB1dF9udGZzKzB4MWVkLzB4
MmEwIGZzL250ZnMzL3N1cGVyLmM6NDYzDQo+ICAgbnRmc19mc19mcmVlKzB4NmEvMHhlMCBm
cy9udGZzMy9zdXBlci5jOjEzNjMNCj4gICBwdXRfZnNfY29udGV4dCsweDExOS8weDdhMCBm
cy9mc19jb250ZXh0LmM6NDY5DQo+ICAgZG9fbmV3X21vdW50KzB4MmI0LzB4YWQwIGZzL25h
bWVzcGFjZS5jOjMwNDQNCj4gICBkb19tb3VudCBmcy9uYW1lc3BhY2UuYzozMzgzIFtpbmxp
bmVdDQo+ICAgX19kb19zeXNfbW91bnQgZnMvbmFtZXNwYWNlLmM6MzU5MSBbaW5saW5lXQ0K
PiANCj4gRml4ZXM6IDgyY2FlMjY5Y2ZhOSAoImZzL250ZnMzOiBBZGQgaW5pdGlhbGl6YXRp
b24gb2Ygc3VwZXIgYmxvY2siKQ0KPiBSZXBvcnRlZC1hbmQtdGVzdGVkLWJ5OiBzeXpib3Qr
Yzk1MTczNzYyMTI3YWQ3NmE4MjRAc3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNvbQ0KPiBTaWdu
ZWQtb2ZmLWJ5OiBQYXZlbCBTa3JpcGtpbiA8cGFza3JpcGtpbkBnbWFpbC5jb20+DQoNCmdl
bnRsZSBwaW5nDQoNCg0KDQoNCldpdGggcmVnYXJkcywNClBhdmVsIFNrcmlwa2luDQo=

--------------5k9b1s0YW701NL8kLjgffOzh--

--------------FBHa9shtdytwPV0otyLwX20K
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEER3XL3TplLQE8Qi40bk1w61LbBA0FAmKbRRwFAwAAAAAACgkQbk1w61LbBA3z
oQ/+IAgmQPRhQh5nW1zoL/BL5+ZXBCnFTdcDlcTKTg1uyaFSML0HBLPrH5JzlUgjCd4KI0KfQ/u9
Qot9iQzJRMzcG5mZhE/4CqinvY4tOkFNiMmHF8Wy7tcFdnvb8gD4dqfCjD8kxjuaFVa6idm07+oP
nRMzeM56W5cWFQ1nNjn9LT3HnEn8DQhWGyWim4+VnR5gMwtQjVjQp836Q/TxdzVOzDANyAZ/DtRk
gBcRPz02VN26u5i57ZX6VV1/w2ghYwcN1kSbvbg2TZCR7r6XWOHv2A+t2N7raT50zjHH5tnpY/WT
e6kqkppR9o5iIYQmJpZ6f9a2YGpKtNVA4klz0ZJDo0SHxSzOgUNtOAscW1N9gm0f6VQYmo3dXJDj
lmVqxCw4Z8VQYHmm7mEEPn6xwX1yP+8phABOBd1STxjO+OaEUbSgIKBB0KdRZ6S6l5TzcORTwhdF
K1i4NcCK0FgsmoEFeVM244+kGH2G+72tgDpx6R0ElCeDmn5TR6IkAvVQctvldfr65xk00OPRpNxQ
jywh/H6ZoAQvb9Z6wgFZd9vivNfYh+jqtJwAmm0YqzTUJqubvJjtH7EVgNI0uS4b4EIMxOXumc/k
Fqy+d4YD/lcUz3Pifl/9UqGYLvNDiEpsM1R69uxDdEo/dZy6sa9JCWEKj8xhddh2ozWwODsnSN7/
nKs=
=DJ2z
-----END PGP SIGNATURE-----

--------------FBHa9shtdytwPV0otyLwX20K--
