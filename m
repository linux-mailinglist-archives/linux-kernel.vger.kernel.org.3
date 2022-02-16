Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2288D4B7BBD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 01:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244994AbiBPATV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 19:19:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiBPATR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 19:19:17 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485FE70332;
        Tue, 15 Feb 2022 16:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644970719;
        bh=9lwKvrStVOccoHp+PLQwpjNTIUqYC6p1OopT1OpjSik=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=jJrdsNDsGjNDALmaTOHlXec73KfDH3yQsQ/G2Ps/pQMWBCWc3+59U1VaqZwBds1Re
         XvvkfySyJ3GcQanUTRRbbN9Ki6x90nrcBItn9iVOUoauH4TZBT7a99jZyZASvsPg39
         /SRoq89ZfDOMo7pnNPyVeLqlJrx+I7S9dQaMpC4U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([149.172.237.68]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MatVh-1ns5zw1wJH-00cRhI; Wed, 16
 Feb 2022 01:18:39 +0100
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
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: [PATCH 2 2/9] serial: amba-pl011: remove redundant code in rs485_config
Date:   Wed, 16 Feb 2022 01:17:56 +0100
Message-Id: <20220216001803.637-3-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220216001803.637-1-LinoSanfilippo@gmx.de>
References: <20220216001803.637-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:nlUm6+8IP+H8OyDSlYvKBHsZIXLMdKTnPNVnV93RqHp2sapA+yB
 4dCFcJu02oLHrtNEFIpZZuMWTXbgM3k+/VVlqH7K/QBcwAfuGT26+ZLwBCE649vwRwf2+qm
 FwHmtjgv3Kv3r1n1QpSLvvqoOoQOYhpgNdo65VSs3MCvJ59MskMqXaYr/zv0DKrAuB2UV0G
 OyVfyp+DBzQl0jdru8SUA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AlySP49HIQA=:SLMi1GsmDrZnp8QAjxu15K
 RbN/rs0B8QYBdXbqjNqkMHsb7r0M4U6DtYKmbdx+IsIhfTrCNqSUGDgO+O9hlHHhwfU+S1wVq
 5asFCz+geCSdlMg8185mc7hUw9BoIaAVK4HUlF8zwBCpUj0esK5/axT3yqd2E2zTiB58pgBdJ
 uMVvEVN4uOgBMLkfC4ZZsMKK9Almakt64rCKlPyLzMiPXBXDWs+U3q5XG0rsOef2F3JYyPvm9
 rmEZ4x8jZ6EECabqm5o58NSjOalicEoZ+E2FxlxnSp4v81j10F/jTiY6xQmbymFvapbYJCxS7
 f+kNP5tQOyhFZcEVLhYgIWGqW8L5j6m0uTPSivL1LDIupCNOV8ZIj46Bq2LXegaWmDl+QNyaX
 v9hPKYwkwJZstsj1ycvXIPsChO9ypJbvdEG5VhC1pGMZwaXCsB8RHGlfarxgn3JY37cO0VIcZ
 xiw5dw1zNJYWDJ3Y1USfV97okuNvsKhI9JSKtjZehGNFulqTixpXEEoyEScrv9zezvd8k3tW1
 ms5ydWop3XOKx9GcpYyDYqp7ZEKCS/2R3y+D+si7M2CziQ46M8DBgyUOi8qQH4AEZVW3lfFW7
 GwZCHZdhIDpKiOYf/mPusAVadR7vxIdGdIIS+q/ZHdTnuWyYac5GXCY3DIIotqfenR/KtLRmb
 EkBW2KUBBsAGr9pGrhGAEE0rLNa7gJiAtXCH0x6JWeosvR714lx4dRo6+xZMci9zCDTblR8c5
 d+1gm0fRFKSnPDXK0tlsXdCnoq9JvhkDN9A30hK2JfU1fYGuviaKkfMnrQ4BdGm2LJjdy20r9
 RGJ7aQYiw+LhKB0iEuRAGA8dYo+V0IiSfDj3hBg1l/tGnyj3w3OhGfGtwtWCH4teP7WDqNz/+
 0AmrXJJ9wAR1tfDyripx5SN10kdwJ7Vv9GEfV8igt92rGVXEZPPwc1eHdP29cEkQu1R5GNu03
 Kiq/UdNHb5zM2EqXjDdiNoDGzi8VMTvTHqAtaZVFhOj+VQeWaZLBGnVLsBkxTASuAsJ7KEYQN
 ENfGxmDP42HVZ4JitNKx78zLO/SAMyDrUVgPRThPE5GBKsAgmW4A+fGm4TSFUmc0zLJaemOsU
 ZQmHs8PRLjLz08=
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
Mi4zNC4xCgo=
