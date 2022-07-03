Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399CF5648C1
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 19:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbiGCRCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 13:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbiGCRBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 13:01:55 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4BC62C2;
        Sun,  3 Jul 2022 10:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656867691;
        bh=jKGdNVXp94SoOUgUewE1NIzx0yJCaYTRp187GnBOMW4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=IdYRVDSfnKdRTqfbijTq75loOiKhXz0iGBmFcIybPlhuEB7WCxUiL1tLQ0TW2/IqD
         RNmBrAQjtiISIkg1lmTQSpL0aaQAVKVedklnB46snDTMFxBXFjC5yBXImMXZCrxGqm
         54SakHGE+SuOiiwOr0Giwy/V1J6YdgOI8L/9TZAc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([46.223.3.210]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N3bWr-1nQ9Lk1rL1-010gwU; Sun, 03 Jul 2022 19:01:31 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     ilpo.jarvinen@linux.intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH v2 4/9] serial: core: sanitize RS485 delays read from device tree
Date:   Sun,  3 Jul 2022 19:00:34 +0200
Message-Id: <20220703170039.2058202-5-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220703170039.2058202-1-LinoSanfilippo@gmx.de>
References: <20220703170039.2058202-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:T7olYTqQ/ItpDdzzZ0sa8NhSXZigBDn8hZLyCYIVpVdN+Yl4A0l
 gKtUUNf/JIQZTpEoIvJ/aWKONaAqk9IYmx6b/2PjYRMG0GKIHWnQR9lFp7DmiBVkINSjXYO
 CKnfNclFkaQkOakE3eRkWU66rWPdchZ5ZcO1UeWB9Gof22isYI9fSAHVLBBJVjEhRBi1hvb
 jHGlOSc2Om9ie9jQwCsDw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wKpdk3bch9s=:7wpOqGIdGZ0su1rFiDQoeA
 mHIWlXxqi0yyXausNIce6//3ZetYWu4UpJ1Pj9r0nl9FsO+dCSXf60Xk+qMcoiVQ8fMURbbxk
 Zz2e4BiefpIi9IIm2oZW4zSE6+kuL1NpRXBwDfFDm4DcvdarhO5v49vpdrqLauytBeJv4plhK
 7twQ/0p+KcRciPUK5/Oh2rIKMzhEJTGtDIqWEOcpjmFj9jrji0Gb/f34NemHYiaOVrNxqyOfF
 9pWVQotKcA1I9N0exCLBf+fD+lnewfyX7vMm2NYo4ya/O+T1Y9WW+izcLFlrLMQ+m8bF3XpZC
 WflnysQ+cR1jBYCxbXJEkS/TK8WB8bMduDT7VMuxPqaOfiOsF4ZZ0X97WPd7BworBzuhuVWDk
 yLbKZfwaGz8QAN451Ztzdmt8bW9XBnw0Asoj4KDl6hFj0bHVFs5GBLTFlO2RlBla5/VeGSqNQ
 D2df0ULrZ+BPG18z0nl25WCBgxNDrXndRB3WhUFmdAOBglWexZGl/ghE4wM/yJn9VW/Q4at1V
 EjQiEWjzh+QGsrdMV/Nh9+30sFeZqEmpcK3GVzJkzbXaOJf7kVbkw9nAVCKQ1wgGeWXjBZp/I
 qOJ/Y1kB/cEfZxF2yD+qykGcxSUbZ1R6P6dTntySgBJcUA+J2SYsUiIwkkOexZNrd6kkdOUYJ
 tbReqgxbj8X8ZCd2RVk0Sdi8mZnYCqHaneuRYzqGfpktbdihT8EkPw3kFT/Qn2CUZC0zJ7Ne5
 j0BZY5Ygm9SVZnK1e70wsB0AKqgKClXe4C/6d5MFgt3bO8CTx34rrFpK6RhFzzH45FgnZm/SS
 zsrzKKwmJiDmTOXfYNiXH4C3XZiAts5ZewHammc4gdxbwnWNnlQa9H9KthRV2BlHh4ZQ0X4y8
 NtQXXus2hZ0NwP/B42FKQk6QXJncDlR3LnjBQeDYmC9QQ+pi0VfQWftusGISxwlTPOpCK7Y5y
 dx9E/ZbSGvdjmYyWzwmd2VL45AU+NklDf7mNIniV7Wxch/WzdfN3QCByZ9VN+3YAv+7SbeP+8
 KFstWGx7uocQzTGw8ty0x4KysRjmobl7U9fEVUefHLx5BKMQerJRgntApNIkorvX1Bmd8z6t7
 tY1pvovH1gi0svjyZQdN0sF7sKm4Wr79g2/kM9IYxN0ggtGXbhsbrOAng==
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCldoZW4gc2V0
dGluZyB0aGUgUlM0ODUgY29uZmlndXJhdGlvbiBmcm9tIHVzZXJzcGFjZSB2aWEgVElPQ1NSUzQ4
NSB0aGUKZGVsYXlzIGFyZSBjbGFtcGVkIHRvIDEwMG1zLiBNYWtlIHRoaXMgY29uc2lzdGVudCB3
aXRoIHRoZSB2YWx1ZXMgcGFzc2VkCmluIGJ5IG1lYW5zIG9mIGRldmljZSB0cmVlIHBhcmFtZXRl
cnMuCgpTaWduZWQtb2ZmLWJ5OiBMaW5vIFNhbmZpbGlwcG8gPGwuc2FuZmlsaXBwb0BrdW5idXMu
Y29tPgotLS0KIGRyaXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxfY29yZS5jIHwgMiArKwogMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3Nlcmlh
bC9zZXJpYWxfY29yZS5jIGIvZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMKaW5kZXgg
MDVlZDNhY2FkMDlhLi41OGNkYWQ1ZjQ1ZGQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdHR5L3Nlcmlh
bC9zZXJpYWxfY29yZS5jCisrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxfY29yZS5jCkBA
IC0zMzk1LDYgKzMzOTUsOCBAQCBpbnQgdWFydF9nZXRfcnM0ODVfbW9kZShzdHJ1Y3QgdWFydF9w
b3J0ICpwb3J0KQogCQlyczQ4NWNvbmYtPmRlbGF5X3J0c19hZnRlcl9zZW5kID0gMDsKIAl9CiAK
Kwl1YXJ0X3Nhbml0aXplX3NlcmlhbF9yczQ4NV9kZWxheXMocG9ydCwgcnM0ODVjb25mKTsKKwog
CS8qCiAJICogQ2xlYXIgZnVsbC1kdXBsZXggYW5kIGVuYWJsZWQgZmxhZ3MsIHNldCBSVFMgcG9s
YXJpdHkgdG8gYWN0aXZlIGhpZ2gKIAkgKiB0byBnZXQgdG8gYSBkZWZpbmVkIHN0YXRlIHdpdGgg
dGhlIGZvbGxvd2luZyBwcm9wZXJ0aWVzOgotLSAKMi4yNS4xCgo=
