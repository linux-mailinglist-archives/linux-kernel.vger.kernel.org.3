Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B951B4FAD69
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 12:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237530AbiDJKuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 06:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237177AbiDJKty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 06:49:54 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5990652E70;
        Sun, 10 Apr 2022 03:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649587636;
        bh=Xte7M1bRnOD5NSoYEInJ1WmZeV38/NX0bKYXCdSsO2o=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=DVGhTTm/NXu0o+/g2bdw8brZgxrBTHybd3BWNaJh1kJr2rsKXxHb3m9oR4uxcIDSk
         ui93ZJ3LM5rRgM0fSH4BPQjJVhsr8rX1EK1jNYOiQ7PwLzRsPySIYR1BWW9QydItQR
         L3DBIlxHkupItI1WSbl1J87DGbDB0eQBqzAjjP3U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([46.223.3.230]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOREi-1nKJHm0RKQ-00PwU8; Sun, 10
 Apr 2022 12:47:16 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        u.kleine-koenig@pengutronix.de
Cc:     linux@armlinux.org.uk, richard.genoud@gmail.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, lukas@wunner.de,
        p.rosenberger@kunbus.com, Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: [PATCH v4 RESEND 2/9] serial: amba-pl011: remove redundant code in rs485_config
Date:   Sun, 10 Apr 2022 12:46:35 +0200
Message-Id: <20220410104642.32195-3-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220410104642.32195-1-LinoSanfilippo@gmx.de>
References: <20220410104642.32195-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:5XcnLtG0AFB8aIZrVZAD7/6S88KFrH/NQwP2XxSsUivAQ80QcYo
 FUHjHq0w+heXuQeMfsMKG7JLE/49rcVvEHtmP41JpRy6UIx0sI/G3+dB44ex+qC8AwD+ohX
 KlU2SampZVORw8/lr9P0HpL11vxnHZdd6RS+gfL7FIZOnP8uKzMYYMvRmVf3EnCTd+kJif4
 SqczGChNFdFZiTyqItqPw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jhGmW4ADquU=:y2fQmYcM4VbvPb4zc+cqsG
 /Ak+a0WpsOnQWTpEsfQUCMHmF3kVuovmyQtM3TsbpBaVrbTWeAI10W9798RO98lXjpXTberKq
 x3qXcW0wPOBiZv52DQrtetnkbXW6JZewTY2H4qzOluWIWSfe87Zmq1MhLpWUvdl7B7g9D5kAV
 wxTnr3zycG9/zyLIcd+q2sX6wSyb1T0wcdzSK84zup2hWxA/Hv7In+zFFkD5DexASHlxt8I3M
 ruPWtjCsq1fcP8iGeHIpN/d5Po6gogK3fN78FDGssh9kyRVcAois6vuFV+8yoCMGTH1Dg5Vvv
 EqLE7lbVN7ZSe1Aeq586lc2FsVRG8bOJmflOdYDoCnrBLN4VyJ8OWtuBlKUMbj6iRpr3mG69G
 AQd8PP9WJttk1kFnqCUDw2QWCkJsh77M/pism41BlEfB7LHKfSt2iKxukc9BElZ4BCV6aZ8d8
 gLVuH5MVd4bfhxibi5Wzye6s7oBr+X/coJ/rVD1PKm6WmTHdo8tjr0lLq/il+I/9hBzK3hYT3
 rB4wr8ivyDwZrILjWzBnS+0XHh42tQF0th+6uEgJi+d3g4cEp5D4QokzsEHlxIORDvsgRZ8r9
 ZbRbclE58bJZ5wVBlTmOxFMl3G7VqAV4xjLh+C0kukKx0QPiw3V26SbxYuBkEvD8wsoYKHnQJ
 Mcdd6JFCEsAiQESGXgkDCWlPRoMCMFwXOUbnZbE1oQiKg/Oj5oGkZxZFDTm10he8ZguR6y5J7
 MSsI3WUeLOE44OAuGs58SvZfr9SXDX3mZTgaRj6qmJ5kEpODnf6EUc6B4sW9d6o2bKXuB0cxq
 /Izlk1HDm6u94jdCbf+8s66ZnIwullfwXH+OFA0oVB7zornhfyg6uzEj61EZIaej977b+iPbp
 pScoCIUdz72M/moKPwD8d1P2WGXOTilrl3lyTVcZ15sICMj64nJ6GTST7vu0tuGwEQU+flnt1
 ljDSXQyHZEUhyS/TUcy9pGMteXKB5eb67qX3BH44tvwRpmcwvz8paM69/drwkTw6fSytAfzZy
 lL4IDyAYLKCAINdeeyljVfHKKrnY4bVGVO38Tto9bb7DVAXbdWUjMmzSbRPvJh/u/qmzlR82Z
 r/gj5BTfWTmpSo=
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW4gdWFydF9zZXRfcnM0ODVfY29uZmlnKCkgdGhlIHNlcmlhbCBjb3JlIGFscmVhZHkKCi0gZW5z
dXJlcyB0aGF0IG9ubHkgb25lIG9mIGJvdGggb3B0aW9ucyBSVFMgb24gc2VuZCBvciBSVFMgYWZ0
ZXIgc2VuZCBpcwogIHNldAoKLSBudWxsaWZpZXMgdGhlIHBhZGRpbmcgZmllbGQgb2YgdGhlIHBh
c3NlZCBzZXJpYWxfcnM0ODUgc3RydWN0CgotIGNsYW1wcyB0aGUgUlRTIGRlbGF5cwoKLSBhc3Np
Z25zIHRoZSBwYXNzZWQgc2VyaWFsX3JzNDg1IHN0cnVjdCB0byB0aGUgdWFydCBwb3J0CgpTbyBy
ZW1vdmUgdGhlc2UgdGFza3MgZnJvbSB0aGUgY29kZSBvZiB0aGUgZHJpdmVycyByczQ4NV9jb25m
aWcoKSBmdW5jdGlvbgp0byBhdm9pZCByZWR1bmRhbmN5LgoKU2lnbmVkLW9mZi1ieTogTGlubyBT
YW5maWxpcHBvIDxMaW5vU2FuZmlsaXBwb0BnbXguZGU+Ci0tLQogZHJpdmVycy90dHkvc2VyaWFs
L2FtYmEtcGwwMTEuYyB8IDE2ICstLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMTUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2Vy
aWFsL2FtYmEtcGwwMTEuYyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9hbWJhLXBsMDExLmMKaW5kZXgg
NTFlY2IwNTBhZTQwLi5kZTJjNGRjNjI1N2UgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdHR5L3Nlcmlh
bC9hbWJhLXBsMDExLmMKKysrIGIvZHJpdmVycy90dHkvc2VyaWFsL2FtYmEtcGwwMTEuYwpAQCAt
MjE3MCwyNSArMjE3MCwxMSBAQCBzdGF0aWMgaW50IHBsMDExX3JzNDg1X2NvbmZpZyhzdHJ1Y3Qg
dWFydF9wb3J0ICpwb3J0LAogCXN0cnVjdCB1YXJ0X2FtYmFfcG9ydCAqdWFwID0KIAkJY29udGFp
bmVyX29mKHBvcnQsIHN0cnVjdCB1YXJ0X2FtYmFfcG9ydCwgcG9ydCk7CiAKLQkvKiBwaWNrIHNh
bmUgc2V0dGluZ3MgaWYgdGhlIHVzZXIgaGFzbid0ICovCi0JaWYgKCEocnM0ODUtPmZsYWdzICYg
U0VSX1JTNDg1X1JUU19PTl9TRU5EKSA9PQotCSAgICAhKHJzNDg1LT5mbGFncyAmIFNFUl9SUzQ4
NV9SVFNfQUZURVJfU0VORCkpIHsKLQkJcnM0ODUtPmZsYWdzIHw9IFNFUl9SUzQ4NV9SVFNfT05f
U0VORDsKLQkJcnM0ODUtPmZsYWdzICY9IH5TRVJfUlM0ODVfUlRTX0FGVEVSX1NFTkQ7Ci0JfQot
CS8qIGNsYW1wIHRoZSBkZWxheXMgdG8gWzAsIDEwMG1zXSAqLwotCXJzNDg1LT5kZWxheV9ydHNf
YmVmb3JlX3NlbmQgPSBtaW4ocnM0ODUtPmRlbGF5X3J0c19iZWZvcmVfc2VuZCwgMTAwVSk7Ci0J
cnM0ODUtPmRlbGF5X3J0c19hZnRlcl9zZW5kID0gbWluKHJzNDg1LT5kZWxheV9ydHNfYWZ0ZXJf
c2VuZCwgMTAwVSk7Ci0JbWVtc2V0KHJzNDg1LT5wYWRkaW5nLCAwLCBzaXplb2YocnM0ODUtPnBh
ZGRpbmcpKTsKLQogCWlmIChwb3J0LT5yczQ4NS5mbGFncyAmIFNFUl9SUzQ4NV9FTkFCTEVEKQog
CQlwbDAxMV9yczQ4NV90eF9zdG9wKHVhcCk7CiAKLQkvKiBTZXQgbmV3IGNvbmZpZ3VyYXRpb24g
Ki8KLQlwb3J0LT5yczQ4NSA9ICpyczQ4NTsKLQogCS8qIE1ha2Ugc3VyZSBhdXRvIFJUUyBpcyBk
aXNhYmxlZCAqLwotCWlmIChwb3J0LT5yczQ4NS5mbGFncyAmIFNFUl9SUzQ4NV9FTkFCTEVEKSB7
CisJaWYgKHJzNDg1LT5mbGFncyAmIFNFUl9SUzQ4NV9FTkFCTEVEKSB7CiAJCXUzMiBjciA9IHBs
MDExX3JlYWQodWFwLCBSRUdfQ1IpOwogCiAJCWNyICY9IH5VQVJUMDExX0NSX1JUU0VOOwotLSAK
Mi4zNS4xCgo=
