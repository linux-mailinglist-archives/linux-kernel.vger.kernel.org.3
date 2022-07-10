Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A725856D026
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 18:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiGJQpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 12:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiGJQpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 12:45:17 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFEA11C30;
        Sun, 10 Jul 2022 09:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657471498;
        bh=RTaQ8P1MotigS/r/NqnxH6+EynGn170u76xP3S9I5PA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=JxeSvcSdkqv3BaJH4LQDBCT/fwR0ffuhsG6H+xYLXBynkukG8JsFoH8x0T2x48uR3
         HUC1ebF5Qjtr2BTZIqzOqi1BrT+HhJgYPYGwNl/DaDT6Hn3SISZBDJyxLhCBQH/zSX
         Rq9qBS61DGAHMVVjueTDJYDXdGJjdOq9/6sbi1w8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([46.223.3.243]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Md6R1-1nah8T17MR-00aANz; Sun, 10 Jul 2022 18:44:58 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     ilpo.jarvinen@linux.intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH v4 7/8] serial: 8250_dwlib: remove redundant sanity check for RS485 flags
Date:   Sun, 10 Jul 2022 18:44:41 +0200
Message-Id: <20220710164442.2958979-8-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220710164442.2958979-1-LinoSanfilippo@gmx.de>
References: <20220710164442.2958979-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:PnpKOWOjc/EdccU37ZkkrSh+yct+U+f+NYjM3bA6D95h50QRPz8
 KAZA7zSJojNMW/TCRQ1rgGfTyETfN1kOG5xTYltHvR0AaQWYWuEvsJCo4Tfupd8k2nV1Zy+
 mpBhByN4WkFO1MW/QcRyqUwy+/lNcVcTCDIe2p4LbZGIniyQQ5EjSBldI+SpDZLuRc7hQRU
 mOMoY+aobdAJ3om9Mgvtg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1A5lePXI1Rc=:GEmAi2PBZUQK5JyVPMBAhY
 bY2LYMVfEqN+KcqXJRhvV72aA7F17Oa5AD8a24WAqoS0UVzKkmrGO7ED+GgnESL9Il4TeZIaT
 ARE9srLaL8xzAd5j6s+fJffPhm2jnocTvj7SvLuW8/aTIHJbYJXq9pstH8F3o4fkuulqu+Pmt
 rh+FTilyW+Lb8p+jB8BM0qA61//N1wM0pHV8VKEwh/xVzXTvnOnjXEKjRToBhjlrPo6VsRUTh
 qDxzwRFOey5prMfxFuSEi7xBm/mlMUL5zk5o4DtPG+isETwgSPLUZEt3/vrdV5vuUWF2ZhwcQ
 D/d2OknbmtKPYRvA8SlEyEH2ElRx4zTzLVKowI2m0EGNCDE0PJkxJBukTo3UbXNEWgPtfIUF/
 gEjKRE2/XxvFq8Epd5wuJ9s3LTMmLXkNK9zWruDkfUQvVbVRUQ8Z1hwkN9lZW9Wve0Y2/deJm
 Ux57IYWdGS/D8f+Q6GP6F9iWjqEEZaIDCppFJX32cLVidn+r2a85r78gECpgtgBzMq2TF8Q2l
 DVw6xFAX7MFwZpGiv5zK2LG3hh5uMHtThYt3koH18SPgJjLcpgfpLtlYNxC6MemrqAScbkFrj
 x7WsFtXDispnw83tWZUs5SlcuDcSlkUw920Zbu5oGQR/ZcCwtsUqkVXFtnQ/M28tFQQfwHr/o
 5dIJysy03QMldHKVXXh947CQ6lsEAhI8rvymQSQTey3QNLs9IAoVOmaQiObRNnlWNnx+YSNW/
 FgYoaN18DPUtkDV8APCgVwn4Lf15zQB86Iniehx68QHn+vwTME4NnoJc1DcRl7HaLbDvtG+vV
 PTi0rWed9UGIKEiQSNp8r2n4J4Cos9OGXgHBnn5zj75Kf5oKqMZ/YTdCrAokiB49YJE/CBLT9
 y2IZxraJ83kDHN8aOHF1LrkH2WbTJF5+AsYGHZcklN+3XdYMP6dy4LOheIlRIm+YlwPskAJXJ
 /09tbze74OP9vRymiRX+DZAUX+Pfjb366grrcCAt97FysnPnvW22uZDLz0ildP46DWt1Ukv8M
 0WDI6jsAxV3K9aoVW5h9+BnJzKOGPgiYFdr0CY2qDurPLeSt3SU/5PWwPY/enuSgyDFUptANK
 8IXP1W3Nd6m8Q6HUdkqHRDawtPzSYOHkgMjHrxqYe1NW1EM2Ko5fNzMfQ==
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
