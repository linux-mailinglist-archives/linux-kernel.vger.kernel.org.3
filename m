Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D2956CF9C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 17:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbiGJPES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 11:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiGJPDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 11:03:54 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537E164E7;
        Sun, 10 Jul 2022 08:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657465412;
        bh=RTaQ8P1MotigS/r/NqnxH6+EynGn170u76xP3S9I5PA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=VYmgRHD9guwyTr685kbRDCBjTxEvllfCEKiU4vomDHEk0ZWjDSho4zlby82R9EouY
         e37GubREDnBIVqtKTwMivFON9fgTUvkj7nTpVzSdajq9b6lg/+4D/8CVdY/6QPv7cO
         7V1WXAt0fg82zgiV4E5zlUdjfWz+Luu8B9NOmypc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([46.223.3.243]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MD9X9-1oJb1h0oxF-0094ya; Sun, 10 Jul 2022 17:03:32 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     ilpo.jarvinen@linux.intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH v3 7/8] serial: 8250_dwlib: remove redundant sanity check for RS485 flags
Date:   Sun, 10 Jul 2022 17:03:21 +0200
Message-Id: <20220710150322.2846170-8-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220710150322.2846170-1-LinoSanfilippo@gmx.de>
References: <20220710150322.2846170-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:EPdF0klEap6nJ86G0oJae4XIa8U0Q/ceU7Qt23QVOLeQ4UiT8uR
 dmCPatGoEK3YtJWoGzzLM7JIcd/t5f3BvzNKAKILdR3OorSjDYC5tvDkFipvefM2VULRyDj
 Hz06G7hptyBdRJ7TRci/EhuZIBz0V82nXM7ElZWo5Y++Z/K19LkJVCwnHg7kk2nG8h02ipj
 MiQJx0dmy4yEGHdL4zvSQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iEZJw3xE6Ww=:l1Jp2MziPcH061eoQq1b2/
 UgUcDDyGvGmWwVxjRdqKA9ncT58txCaqYd7D8x50IpXqm1qTzMXLrzMMyVKoa0lvcTXEZvTD7
 9OGtMl9MwuPyejAl7dR+H0odkyIppM2QUYxyFPKnD2DznPkFBbeh29sUbRv5y9Lwx8o6JDFlK
 ZyjW8/R1IdvY4gWvqAP/uiDq3h6Z718quCceGQto1X+MpYJKk9/anSfbRI9gWy+S5L/cygngp
 9UyjGbxr1N2bnvVrC7EF19oGr83yxTcJgKsjZaRYPjEZKilt1KsQyIGFjin/c6FPYBqpfkDPn
 Zw96lecNyHmzIiMrJAvCd/gPVD/flOoECr1P8prYl1rhqg6oNH/xv1Zp5t1sIbk2RaF6GT01o
 MKdCc+pDFcYDGPa+eVUEtZpU3Dl3Swz/pmixfW05JoYcH+HfDtQS1cbQgi4hK4vXLk0YHjWug
 j6r2DS6Xl3Qv4YzFh5PYm/qUQ1jIx6pwYueimMa2CSMeP9cC4fx7wb8lxAvh2kDRltm7OOmIY
 slejUngqIUvu7kGGxRIDFTT4J7EYheQ4COjlMmo3QN5O+KLM6aS2Tm6zcC0/qquea0NQWMcFQ
 i60sI5VlwOd6n7O1ggOBu7VQkiqTalqovGtTjGprJGt71jflvYSQGgcYRqVtWEW5vokj2LIne
 KIKZX1wzeCH45JE9wCN9f12rgbel+xa/xVApMe6sjHYmUpS0y0+5SZeR8xx9nB/hdTVBbZR31
 zjMhLW1p5hmFLcUQn120b49GVlZCeSRy+R1njqAkWtJbWBLnx2E8yPYlJckLRL27udNBODn2w
 z5wirR/xGrgkfcmolIfILEWEsjTkNg0vQBeDC6cmTqBlItlt/ih8xNIi+ADeTSK84yvRscJZP
 Nx6ZzNrH/Uw8odj6uIbKO1dSXz6sseT0MA911MbR43kNtXJIApKpVfPHDQDDOIz75XmjcsKFZ
 6cBYQejyIIFsXG3ANhzuoZl6RhlmBSDcpXZE4ksqrh3j3VtS7piAW27uCE/zNDyZa0VNURC6v
 K6Hacxu+bBExQphZoPC9j9etDejiOUBN9Sqh9v/Ez9HT614UBz1CKaaXox+rtT15GtqCZZGwg
 b6ClXKMqR6wWD9rchb8ragRm/25uyl9PTviFVobAmTmCYQTunH/+h9OvQ==
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
bT4KLS0tCiBkcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX2R3bGliLmMgfCAxMCArKy0tLS0t
LS0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfZHdsaWIuYyBiL2RyaXZlcnMv
dHR5L3NlcmlhbC84MjUwLzgyNTBfZHdsaWIuYwppbmRleCAyYzNiMTQ2OGJkODguLmRiZTRkNDRm
NjBkNCAxMDA2NDQKLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9kd2xpYi5jCisr
KyBiL2RyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfZHdsaWIuYwpAQCAtMTg3LDE2ICsxODcs
MTAgQEAgc3RhdGljIGludCBkdzgyNTBfcnM0ODVfY29uZmlnKHN0cnVjdCB1YXJ0X3BvcnQgKnAs
IHN0cnVjdCBrdGVybWlvcyAqdGVybWlvcywKIAlpZiAocnM0ODUtPmZsYWdzICYgU0VSX1JTNDg1
X0VOQUJMRUQpIHsKIAkJdGNyIHw9IERXX1VBUlRfVENSX1JTNDg1X0VOOwogCi0JCWlmIChyczQ4
NS0+ZmxhZ3MgJiBTRVJfUlM0ODVfUlhfRFVSSU5HX1RYKSB7CisJCWlmIChyczQ4NS0+ZmxhZ3Mg
JiBTRVJfUlM0ODVfUlhfRFVSSU5HX1RYKQogCQkJdGNyIHw9IERXX1VBUlRfVENSX1hGRVJfTU9E
RV9ERV9EVVJJTkdfUkU7Ci0JCX0gZWxzZSB7Ci0JCQkvKiBIVyBkb2VzIG5vdCBzdXBwb3J0IHNh
bWUgREUgbGV2ZWwgZm9yIHR4IGFuZCByeCAqLwotCQkJaWYgKCEocnM0ODUtPmZsYWdzICYgU0VS
X1JTNDg1X1JUU19PTl9TRU5EKSA9PQotCQkJICAgICEocnM0ODUtPmZsYWdzICYgU0VSX1JTNDg1
X1JUU19BRlRFUl9TRU5EKSkKLQkJCQlyZXR1cm4gLUVJTlZBTDsKLQorCQllbHNlCiAJCQl0Y3Ig
fD0gRFdfVUFSVF9UQ1JfWEZFUl9NT0RFX0RFX09SX1JFOwotCQl9CiAJCWR3ODI1MF93cml0ZWxf
ZXh0KHAsIERXX1VBUlRfREVfRU4sIDEpOwogCQlkdzgyNTBfd3JpdGVsX2V4dChwLCBEV19VQVJU
X1JFX0VOLCAxKTsKIAl9IGVsc2UgewotLSAKMi4yNS4xCgo=
