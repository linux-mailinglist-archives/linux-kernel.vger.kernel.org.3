Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFB85648C4
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 19:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbiGCRCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 13:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbiGCRBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 13:01:55 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C905E627B;
        Sun,  3 Jul 2022 10:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656867693;
        bh=r3dNDUDIuUE3Q0qRG27sRGL8QSUVi1dKmu2o/TP38+o=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=IrAd30hI+KUcO22l6V3kbwW5xHgsijSs1p/i71c27LXUsdMOpa0ypTKskAHkDFHpj
         JE/09dEVOj9gGtf7+J2t/ZqJyOpZUjJpM5FA1195w5TIH9wL6esbljwXYQL4PRcvLB
         WQyMBuSrwWdviCLV4NsgrRp/f5h69xVNUikzLV18=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([46.223.3.210]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M5QJD-1o8sJs2ocP-001Oya; Sun, 03 Jul 2022 19:01:33 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     ilpo.jarvinen@linux.intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH v2 9/9] serial: 8250: lpc18xx: Remove redundant sanity check for RS485 flags
Date:   Sun,  3 Jul 2022 19:00:39 +0200
Message-Id: <20220703170039.2058202-10-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220703170039.2058202-1-LinoSanfilippo@gmx.de>
References: <20220703170039.2058202-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:KjAB4TazV/OvuLGClQIL62mGEv/0G6rRtTs5pe+N09lU9C9u8xm
 81tPPKgUO4gFQ/640DbtwTghVkeUew/lXZ132Zx7lpMa7HbYuUo6nPX3HNBwTFf8pgXyXUR
 1nuiwWq2ftAkbP7ADU8L6aiMNKMOe6wQAf0wbvKqGxPKe1TKDE8k2BjTm+ExZ1L9ivWvJKN
 o6I+B9izQFtUuVJ8eR+sw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:t+3L/KYJQ68=:Idxt9qmFJMRusII+8L49Aa
 zSEABMSFoylvJHtAm0y/CS9YVujhvonXNXu1GJTkyShWG1tLqw89/VpBtdaF2c66TTiJUgOwm
 KI6+f5TGj7Sjd7B0mmIFPwRVrJWSrHO3vM7edcNHpTa0JM3+RmZ3sNi8pjTpNCDuCgE5XlD2h
 mrm9uXPMIPy8tph8lpaYpiRBVaP7a6QTnNpWFOzQYCGe/8F6UbvMQX2oRT7BDQPOVytP02UVY
 YOVbhq3oqeAgMAptgRoq5CzPBVEWcvg9atN6dkcRD0mbqILD/eTf1NngAiLdn3xOlCKC4CxpV
 b7K0AZG7oKsqqmBarzoMIxTIObjF7JGsVyFewDGrLmOHu6UvXrKKD+M5xniRFzQaIu0378Ayn
 l9OH3QXdyePodceFWxarQrhf9GjXbzyVfh+YUILaK66fCx3LQft7Fhs95ccWKhpSY8Lms/RjF
 oRaGf0tZRFvnWA0rG4FoyI/tfd2Gb1iXqJkvC5VU1XQvcLDHmSDGo2fucc75oMYg9mD+zgu0b
 zoUGA4hSinXPuCh9TNIZOO6FVjA2Tw1dpnedxUfdcoSFziSRa8ZSYbVHGb1h3gGHx2TvXwoRr
 4punAqCmgyhw/2/ug6fo7J4XW1Rqnp/nObBb3v3Mj0XfDN73Mcu5BvDuzpcne86IAjsKaX8km
 j3s4M96Mn72DBI+KiGyZS7wbiTLx/3dHJO4TZwLGMVOq7DuH6kfDfoah10cmEL4rEvPiX9Jph
 cPuQp1f4KdPpcu3jlt2m8Mc4P1hzY7bF924o6/Q6V5kSX5os8/S5uygtT/O8NjWCrfpSHIYvA
 ttZh7Kuiuasvf5BU3ZwBriZXY+oPOYCSO/aNB9B/BmmFpdJYcSVZTYKxqcbM2qY/sbazuHT94
 uKvBfT88apH4yV1gcuhKhapJfubzTZl0DF46zvBeH89MH7ohbCBE/8tAJDUi5lkPNEYBboYuP
 IkUAB7IH7MJFUvrbj7S7wI4HGgW2TNPi+IvwqXAwfbJbuyw4/fXty4WBMHthI46HvQnULV1l4
 N617UjZIHNOtqa1OkMSiAlUb3GPobKsTfHmbGXaziwEo8xCgHURaTxPLbz8vaAfpZ4Jyr7OFm
 7yElBeI/pR2ocJKJx826lpW4oRhiwYe0BsN/13CYajy+gHb9xgBdcVngw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCkJlZm9yZSB0
aGUgZHJpdmVycyByczQ4NV9jb25maWcoKSBmdW5jdGlvbiBpcyBjYWxsZWQgdGhlIHNlcmlhbCBj
b3JlCmFscmVhZHkgZW5zdXJlcyB0aGF0IG9ubHkgb25lIG9mIGJvdGggb3B0aW9ucyBSVFMgb24g
c2VuZCBvciBSVFMgYWZ0ZXIgc2VuZAppcyBzZXQuIFNvIHJlbW92ZSB0aGUgY29uY2VybmluZyBz
YW5pdHkgY2hlY2sgaW4gdGhlIGRyaXZlciBmdW5jdGlvbiB0bwphdm9pZCByZWR1bmRhbmN5LgoK
U2lnbmVkLW9mZi1ieTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4K
UmV2aWV3ZWQtYnk6IElscG8gSsOkcnZpbmVuIDxpbHBvLmphcnZpbmVuQGxpbnV4LmludGVsLmNv
bT4KLS0tCiBkcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX2xwYzE4eHguYyB8IDYgKy0tLS0t
CiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9scGMxOHh4LmMgYi9kcml2ZXJzL3R0
eS9zZXJpYWwvODI1MC84MjUwX2xwYzE4eHguYwppbmRleCBkN2NiM2JiNTIwNjkuLmZiYTBiYjE3
ZTUzNiAxMDA2NDQKLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9scGMxOHh4LmMK
KysrIGIvZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9scGMxOHh4LmMKQEAgLTQ0LDEyICs0
NCw4IEBAIHN0YXRpYyBpbnQgbHBjMTh4eF9yczQ4NV9jb25maWcoc3RydWN0IHVhcnRfcG9ydCAq
cG9ydCwgc3RydWN0IGt0ZXJtaW9zICp0ZXJtaW9zCiAJCXJzNDg1X2N0cmxfcmVnIHw9IExQQzE4
WFhfVUFSVF9SUzQ4NUNUUkxfTk1NRU4gfAogCQkJCSAgTFBDMThYWF9VQVJUX1JTNDg1Q1RSTF9E
Q1RSTDsKIAotCQlpZiAocnM0ODUtPmZsYWdzICYgU0VSX1JTNDg1X1JUU19PTl9TRU5EKSB7CisJ
CWlmIChyczQ4NS0+ZmxhZ3MgJiBTRVJfUlM0ODVfUlRTX09OX1NFTkQpCiAJCQlyczQ4NV9jdHJs
X3JlZyB8PSBMUEMxOFhYX1VBUlRfUlM0ODVDVFJMX09JTlY7Ci0JCQlyczQ4NS0+ZmxhZ3MgJj0g
flNFUl9SUzQ4NV9SVFNfQUZURVJfU0VORDsKLQkJfSBlbHNlIHsKLQkJCXJzNDg1LT5mbGFncyB8
PSBTRVJfUlM0ODVfUlRTX0FGVEVSX1NFTkQ7Ci0JCX0KIAl9CiAKIAlpZiAocnM0ODUtPmRlbGF5
X3J0c19hZnRlcl9zZW5kKSB7Ci0tIAoyLjI1LjEKCg==
