Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB18F554FCE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 17:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359528AbiFVPru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 11:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359494AbiFVPro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 11:47:44 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10EB3D4A3;
        Wed, 22 Jun 2022 08:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655912842;
        bh=HDosJRHefTht65c4ercr1KFDzqhI1YXcq1slYta5z4A=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=gByAjzYHwj4ZyQkpGUFpq2uQ5SMSXICPzeymxulNVo0O4C2dKCaiIZi+rG6f4KwBZ
         kqX9CZuqhn2odbA+UDyazL6ZKDn+XGECwtULsCVXgMoCVyyxPSIyLVV4eci29hsS2l
         vsDTHqA+3i07RXKqBrZkCwywtnlFiqHr24HR/9Cw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([46.223.2.22]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYNNo-1o7uUF3WbK-00VMn8; Wed, 22
 Jun 2022 17:47:21 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     ilpo.jarvinen@linux.intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH 6/8] serial: 8250_dwlib: remove redundant sanity check for RS485 flags
Date:   Wed, 22 Jun 2022 17:46:57 +0200
Message-Id: <20220622154659.8710-7-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220622154659.8710-1-LinoSanfilippo@gmx.de>
References: <20220622154659.8710-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:Hhv7t15Eh6FTG+Idf1JKlreiNJd1OLyuJVNyAobctRorPGG09eB
 UhUhe6n7MDFCBmzjH7Cn5SP/HmdAMOH/OZ48WDsdTRdcLnINiFwqpzfo1IvmwwAFDVNMqq1
 8mh7tVmlaIn7JlvTneV+7JF90o0FRhA/oAKgU7uDQpr5zY3vEok4j2ldH0YchU0Awq0Gpyp
 olizn3mofXHuiEJpSRiiA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uV4EiirzX/k=:tzUAkIh9Yxc0fagdAnUphy
 iyaTAnKFLbOzbmLlEZMC0tV3E93zqEGVbaASD1I4ZH0m1QsQDiFesL00LqnzCyeLugbm2g/1H
 tOS/+Aka+/QDu7leK5WD1gZI6mgoe0nNEghrJAPMDpvLjd3keHMDQzkDQDtxEyIBBP+OQtmuw
 kSfmXSIHM5wWOSUgLxGZVW0lBmr8ykW6pF+kpdttijmUJPCaPaYIAvzN/rTZ5bYrgl7NnU98p
 mfRS5H1bUEyjqRb6dP4slqACQMjl1Q4HvoZSpxFjrbcUg70UHcQSwpIO8Kj2izhJim65/NDWt
 UNLLRb8JAdB5XHPMjT8EO/sk0HpML0kc7O+72dZcaweHgXuHnoQq5+rUMy5pn9l7VEiIFKibr
 Nz5YezbJ+9F5/ek6CmlruMTZLOpgsdzlxokuHdoitPYZcET0W06Jc3oh4Ln5j8ZLelfj3sa5v
 s3T52RxQoreKAv457PzxBqHDag6x6XaYmbdekh/2VCGWZxr6Yn7u6cwL+r6zCdmLEInKjwZgt
 3wNKFk7zdrUvuee/pJuACL+8OKh4iqOXHQEJcpPCQwY+WDaUwDRCVL4vD6ur14g3mD6nWZDBQ
 cqbo9flzA50PSNa76khoJDVkY81Kp4jrG6ZbSh/bV7JCd5bVWkkMG+9oxbljiePGNWfeRcvvv
 Zl8gvYDBDvu2aqsb5EEDkSUxV0MFRKYZNLIDc1VtrW158GV/2n4qj4RPHZar8MIKm83O5/I9o
 OTT0lQameMWIJBov8gOiExgBdAtkMq8YJyYU0nl+I+HG7ie7Rrq4LIKr5d6vzUe+c2Ed93mWA
 7Oxod68SqB45ZoPjV/L9gxeqR3WI25yCKQLDkBJjd1kwFolF05IoTnBhH0KzaA/Cc2c+Mp/UG
 uDnAh3X0RZQM10qrvvbQEr2M/6egoYmTH7/0hnC4hhQE9QcwmP0nfvHOy3sMzXnACEDOmpZT/
 UjrVtaJVSTjits3L3l4OUGLh5DbqJ+92Zi9zbpB9HrFrLr6fr6Cq0/aKEi/6Pm7mr2qh/HIOa
 UmguVQgCt4MwKaM156/5A1fwj9oSZG5N18PP0EqheOLR8dmCTMLE0C0WWsuHjJ9StVIBH1k9z
 CuzzlNJmuYJrV5zGK15YzazLzGfOYNscI8n4BHV3/Jl3AA73UpkweZg8w==
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
LS0tCiBkcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX2R3bGliLmMgfCAxMCArKy0tLS0tLS0t
CiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfZHdsaWIuYyBiL2RyaXZlcnMvdHR5
L3NlcmlhbC84MjUwLzgyNTBfZHdsaWIuYwppbmRleCBjODNlN2VhZjM4NzcuLmJlZDJiZDZiN2Ew
MSAxMDA2NDQKLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9kd2xpYi5jCisrKyBi
L2RyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfZHdsaWIuYwpAQCAtOTUsMTYgKzk1LDEwIEBA
IHN0YXRpYyBpbnQgZHc4MjUwX3JzNDg1X2NvbmZpZyhzdHJ1Y3QgdWFydF9wb3J0ICpwLCBzdHJ1
Y3Qgc2VyaWFsX3JzNDg1ICpyczQ4NSkKIAlpZiAocnM0ODUtPmZsYWdzICYgU0VSX1JTNDg1X0VO
QUJMRUQpIHsKIAkJdGNyIHw9IERXX1VBUlRfVENSX1JTNDg1X0VOOwogCi0JCWlmIChyczQ4NS0+
ZmxhZ3MgJiBTRVJfUlM0ODVfUlhfRFVSSU5HX1RYKSB7CisJCWlmIChyczQ4NS0+ZmxhZ3MgJiBT
RVJfUlM0ODVfUlhfRFVSSU5HX1RYKQogCQkJdGNyIHw9IERXX1VBUlRfVENSX1hGRVJfTU9ERV9E
RV9EVVJJTkdfUkU7Ci0JCX0gZWxzZSB7Ci0JCQkvKiBIVyBkb2VzIG5vdCBzdXBwb3J0IHNhbWUg
REUgbGV2ZWwgZm9yIHR4IGFuZCByeCAqLwotCQkJaWYgKCEocnM0ODUtPmZsYWdzICYgU0VSX1JT
NDg1X1JUU19PTl9TRU5EKSA9PQotCQkJICAgICEocnM0ODUtPmZsYWdzICYgU0VSX1JTNDg1X1JU
U19BRlRFUl9TRU5EKSkKLQkJCQlyZXR1cm4gLUVJTlZBTDsKLQorCQllbHNlCiAJCQl0Y3IgfD0g
RFdfVUFSVF9UQ1JfWEZFUl9NT0RFX0RFX09SX1JFOwotCQl9CiAJCWR3ODI1MF93cml0ZWxfZXh0
KHAsIERXX1VBUlRfREVfRU4sIDEpOwogCQlkdzgyNTBfd3JpdGVsX2V4dChwLCBEV19VQVJUX1JF
X0VOLCAxKTsKIAl9IGVsc2UgewotLSAKMi4zNi4xCgo=
