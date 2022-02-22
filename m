Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2AA4BEF37
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 02:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238182AbiBVBQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 20:16:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237093AbiBVBQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 20:16:02 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A391C24F37;
        Mon, 21 Feb 2022 17:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645492507;
        bh=KEo4sc077TnUumY/3jbiNcL70WXfdFpW/wOHZwtSo+c=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=R321iE05JyltOvTziTJucz7Aha2pQui3BMZ5o3fES3OdohzSi5OMoPakHVdjD1VlB
         ZbT06e/aqiMoRzYJ3e2aRBl1G3gurFIxguG757H8IySbnvfX3EzmH8GUGjfUokgKe5
         cbuUuEOFgTbGukGiaoI8e/pK0msdmRuDy+XckkkM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([149.172.237.68]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MysRk-1o9SNF0rOk-00vtVm; Tue, 22
 Feb 2022 02:15:07 +0100
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
Subject: [PATCH v3 2/9] serial: amba-pl011: remove redundant code in rs485_config
Date:   Tue, 22 Feb 2022 02:14:26 +0100
Message-Id: <20220222011433.8761-3-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220222011433.8761-1-LinoSanfilippo@gmx.de>
References: <20220222011433.8761-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:MRCzCFZwVGuHxJ4XCUOnuQ+k6jJA6DTfVK0pMx7+grgupk352jS
 xmocgmDITGUQJKhjfKpuSW0zwubnakFfr3D4RUaDlmBh7Id8BQ/jPjHYzZS9elgY1WLACnc
 7tSOYpKJEnuoHPzUMbi5/BjccZodi+fjg76bLmAZZTVh5U2rhSRFwrdxTleHx83Xu9VKwqr
 PX0IayxvHad2vb4qRBtSA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AqfelYdZ1ns=:8iaU/xOJxj2wUkOKaGPiZB
 8Dd0SAkrmad1IkGQa0bD7nKfMr8BinRUeEz0f5NOlassvDKA/zluwVnWC3a46driuBB2Au+sf
 Xr0c9VJ+YhkyKYHw65wXQ1JSlS7++qA11IZVWUn151k2B7S1LTgxj9PGWVNXgSTTgmu1l6gVS
 ZqXePddIOithJ5FregzycM6cjRXrxbR1mXM4ZPR/hrcHcjZblEOZljNf0k/Q4hJh2+wcUuLD4
 oXIbRk9VYUAm7yDypPvcPEjdMl6xJPAYjV3zYWiA81YTFL5DZrFuBbz6VBZgn0G088ipgoW7G
 wbj+ycT0rFPk3dJtrNsb5PoRcj45GG6xIOqpG5T9o3QlSFePCn7B9WQjh3xm58Xrpvkm6FgEi
 JY5J582OcKsYSMT9dJXgRsZmjZZvRrX5Xpp2p5IC81EyU/u3Lp1zWGuCp1DTCKDRdPWZcsF0L
 xEuI2jxkwgRaZRmYdcFCwpJTI/4GAuzwKJQCR2ReAttlNdbepVCk9pP3p2OXmqmZDzP/Fhqab
 uua60ggBHPKPtIAi4BtYRHbLMiRh8vvLpq10qmvnEG1RygJPXl8V4ce2Xfcaai69z7PvwOuhb
 10DFNG7TAdxX07G5deC3sw9Th5uBQjBIGwZgta1pzV74hVgVbzr1ObItXeffijQnCn7rXALD/
 Je56MshTG7CLoFiVajKUxtFotuGucKCiK8jfDWaikghiosPuR56L990VclwjjDtmFnj505q8S
 swVQk3sPyX75Kq04YO7iZdHtvIe6CM0mYSed3EJt+uvLQhM8+SxrK/wQqJL38+4C6KcGDHiMH
 WMdCbPaZc/TztadptmNOFLFT10lTY5aJx61Rcm+Pe9pik521NnwR5dAwXfeFuaUVoBLcMrPTh
 X/mR8A6zYvNdiWwdSAJBWSlu8s7fLtd7xPVMnNH9ESFSoxMSbuvkOhKVlt+/7PFlGbuD9DpWK
 gjLhBrJzakLmqgoBZmdEuEFLbQvWdYJq+/Sp2Hs2g3AyoVlXV0Qq3DU8CEJ+oJd4cCeGNuMa5
 u3hJib2lLJncip04WArDNIxJWL1A1wWiWsIxYevSbvGTS6PxmybpMxkZ0JnDbjUFFLUAKTkjI
 NBWMXhnMkbmiL0=
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
