Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E344C614C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 03:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbiB1ClK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 21:41:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbiB1Ck6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 21:40:58 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A076E283;
        Sun, 27 Feb 2022 18:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646015992;
        bh=KEo4sc077TnUumY/3jbiNcL70WXfdFpW/wOHZwtSo+c=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=U8CVLIYXiQfrqrF3Yjy3gpn+AQC6h/ZJaZXpURCtDMlv0KBmxLHwtcKmvzcXGV5hV
         2pkN3IXlsTjoYCAhdygXc/xNawFZIWBuFadKOsOG/xBKU7fvAB5Ovgd4Uhesq12CoD
         PJ8L+cm8gO4UrISqst0Jo+UDBrdm9YohgxLPhzgY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([149.172.237.68]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M6DWi-1nHuEq0Vho-006cQK; Mon, 28
 Feb 2022 03:39:52 +0100
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
Subject: [PATCH v4 2/9] serial: amba-pl011: remove redundant code in rs485_config
Date:   Mon, 28 Feb 2022 03:39:21 +0100
Message-Id: <20220228023928.1067-3-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220228023928.1067-1-LinoSanfilippo@gmx.de>
References: <20220228023928.1067-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:eg1D8cY8KvkEzDEdzcKaQNPZTMDNYQmE/sDotx9MDKb/I31DIL0
 5CKcm4uTNggqI8C/ofN5Vew1u4vsHYN32jItoVnblyIFScaWN41z7y/v8WH4gqDk3bH5EEx
 J2G+EoxpAJ1kBGuF1nvCb/F9kG2+zGQWn6nTjHzWTZTFErY3dfhXr78tLI82jw6GrLsnLiT
 7QhnLoJMJ1+Sm3KV9ogqQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:85DxpLLInRs=:wCHmfG21c7gZ19Wv6Kv/81
 T+8dRdhkRFJ3tDbkjy6xMhKIlQtKJIqq1YP0ep+UvQBNxaxI7EHq05x3bJpm7++PIwxi/CZeq
 Zjs6Vv+l+zVZEspzxlWhGkjZMQfNoFkFIyCx4wEo/RP2G1fRGCCQwm6K1lWK4hk+ARUAV1xXV
 AcSzQM1UHfCcRsGOhquQ99qiiCeZ+c9xs+5RER5yKn0gv25gdM8vXy2NaDPxMD/Oy1Oj86zPb
 Yhr0gw4fjn1a0Vaak0tFnEdxiC2X6KoY/hig0QQmijZXiAP0ZX63tXZdwPmyqq/tepxLdxFY+
 64K3m364CnWWCqqELzq0B4IzrtXuj8UJ+vElufO5J/1nFj9b/ru7yP55nIq7HFXjItlLfJHeL
 pgJhNbf1E99+5/sJ6CFo7Rntvpj0bct7dZDTkh+MQ8RNIZkOPWS6BU7z7dDZbV80/5AdWE0nY
 1OwafnyGkxJBoupSp4QgFw6omBN7jtIN1H8eBawCtJIeOJLFOGsZID0A8hX8nms7/soxw8xzM
 o0uzChZqM3GvjQI2oc4mLfPlDo/eN/LcT4UqkBlvflTONi6QAQJL9hn4sLGn/W8o5hqexpb2i
 Tf8YlscPdo6sK/tdrLjdtfYltLL3e6WA5i6v0zEimcvLAVd+J/aquiKQkYp3iwoOGvtgazi13
 w3pJU4v9BRy4+M+BAmxe6a3qWCDnq/5I4J3uneYQgLIBIN2yOTd/al+RAVGwroqYSUZyV+gMX
 8VFKNByCC5VqfpdeGUexA1YcYCecnTb9SpBSJonXZlk+ozWh12IUCzWmsuDu7IHX32L09GDFY
 PegosY5pPmApKqpokaXkIVA4CkAvjwJ+6nwui/y2aoJB90+lcXKym0s2rlyMiMYh9fnEYmE+3
 WcHPu1nFad3LZrVl160rHC/hKrjzVS7VFdB28Ra7Dn1UKtH5QmS/J7Oh577c9y3JZI3jMdsq2
 sz37jZgoxbjMTagnMKzu3tUw2a5ypuR7CBebq8nvkT96tzVyrCVsSHeCvps4On5yjkW+EOF84
 ginoopQbntbPgGgQW5XQSCGmWmUD18dpgw6uZfBYXYLs9kHeMnkhrqS1HJGN09donLovKo3xU
 ZLMPaQbO9K9WLc=
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
YmEwNTNhNjg1MjlmLi4zNWM2MzM3Mzk5NzUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdHR5L3Nlcmlh
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
