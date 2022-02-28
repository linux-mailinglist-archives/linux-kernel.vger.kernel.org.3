Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486924C6157
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 03:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbiB1ClD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 21:41:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbiB1Ck4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 21:40:56 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3927C6D84C;
        Sun, 27 Feb 2022 18:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646015994;
        bh=Hex8IO2WpX9Y5fu2wHgqKu6/ZEI0eyXNRweluNBil8E=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=MJmRpAW3ELiY6xmT8V4KIe4FskOUjZzBMr+hm7/cHlIfvw81Qje3192nHowzBXVY9
         b5CgdtlH859uTcoXNJ/GyzdvD+/VFlkaCMGoPJlMl8cLbAZMo6I6ICUHRKF0x7BuNn
         XXli6wwUkLOh7DPRPs9uvruS+/RBnJZ5xe20SR5A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([149.172.237.68]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MsHnm-1oDsRs1Bm6-00tkfi; Mon, 28
 Feb 2022 03:39:54 +0100
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
Subject: [PATCH v4 5/9] serial: omap: remove redundant code in rs485_config
Date:   Mon, 28 Feb 2022 03:39:24 +0100
Message-Id: <20220228023928.1067-6-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220228023928.1067-1-LinoSanfilippo@gmx.de>
References: <20220228023928.1067-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:PzdDhAUBSdMJlshR3Bdzn7uubrZ2Nqrom7Xkdt+5MPDni17JylJ
 t3FciW6GtSjmf5Ut97Sks6n4utUOydeU7gnjx6v/Yak2RTSJzHFghZKqpi47SGHBhWCzXQ2
 YWa5kbBtRYJmUZEJLqtzBlBFdaAQl1vPmh+LQhcxMJQ54sGeiw5aXcLiFBku65BSEC7itr0
 VY3LlyMM+54qBAx+XafLw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uHeAU+X1K68=:nK1t7m6GVjwVR6dIW1wsGX
 NOenbdx4BFVOw3CUbblMN0zzCgag2cOsSj3+6s9anpjScW1azi64Nw/uVkWrRK80ddT41u+8Z
 jDJsxPKF2R2zKiEZDYXKq7iNP2EAPcpH1+jWkBNg8vdZzfbYkC2mcummtRvqG+E4B4LEF5HKz
 dmYE9uFF2j5DVF6+UUgW8EWA+bbaVdFYL+mGFCbUxZ8QKa/3u74VFxXr4k3VaiMlsZDy1tGnX
 4U6KwaXLoQF6C5HCQDbVOUfb+JIrLbCuzbhQTACnmN036iLO70VHqB4RQlM3iFKCHrg/6YFCT
 Xv5zDLgv1TkVUEjA44QHFV0sHfTyEovGMJ8NCqzXhnSFOhndSlM22OqqzN2GpUFD44G+HmEI4
 k9TTaWBkg/ya0pFqDXonrUDxG+kMrY0Eo6XsQvnf14maIF4Ny1fhvjL7IZlsL7giCE74c7zzW
 Le5SSzYJmiHs1Io83NQ64upO6mNjqvNuLUqvEBADX3kbjUhBh7iTH8WxlxjmnFzAR+y8kDtAL
 +PSIHUYwZRD0X4NSPADZPOVrWygAromcdV7UFhji1zh2xTuDTgvj/I75h6YXf0JfVbk7lwhAv
 WRldHkBP3kNCfTanjM872Y0lXKHRY3EDXXnkoB6Vw5f1Z9XJSo+TalFOQOeIjTlRgeizaXBLZ
 UW6TQ/Qo5FM7+UX/yfbjN7seeJ40bTu8mb8dEYa+vbV2U2FwjVnM2//t35X/bdqBpmCEAlaFX
 2Xqq64WRIfel2IK2e1i4N41FzH5iWbSF1DKEh46lZfhfIuB+CrC4fzjNw67HSwZm97jjANzo6
 tTEAwGF+umpeQwHecZoHYIIegu5NaR7DGeD9B+g23dTRXJy3dBFvWFhm2dD3Ac6qBUQx9VtGn
 BpQ5zVdmyTCkuYH7M9mRmKaSjm4ry+lvKOLk1xhQGQ8p5zb8Lm2WYYWlv7+bavO9rGj7w3yDq
 L1mlMH7iwaFJSl2McvA6CO7XvWz9Vdsr+rCecwWwXc3uH5OBdd45gTF0MeYytAcZNx6W++2rE
 45WJ96obHqNSYRUWRd4B2gCgTXUs08KJgtq2Cm/ejUQU1A1bDpAcrEkA4jM4v491uREQcru4c
 5BxKbNQwiaQta0=
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW4gdWFydF9zZXRfcnM0ODVfY29uZmlnKCkgdGhlIHNlcmlhbCBjb3JlIGFscmVhZHkgY2xhbXBz
IHRoZSBSVFMgZGVsYXlzLgpJdCBhbHNvIGFzc2lnbnMgdGhlIHBhc3NlZCBzZXJpYWxfcnM0ODUg
c3RydWN0IHRvIHRoZSB1YXJ0IHBvcnQuCgpTbyByZW1vdmUgdGhlc2UgdGFza3MgZnJvbSB0aGUg
ZHJpdmVycyByczQ4NV9jb25maWcoKSBmdW5jdGlvbiB0byBhdm9pZApyZWR1bmRhbmN5LgoKU2ln
bmVkLW9mZi1ieTogTGlubyBTYW5maWxpcHBvIDxMaW5vU2FuZmlsaXBwb0BnbXguZGU+Ci0tLQog
ZHJpdmVycy90dHkvc2VyaWFsL29tYXAtc2VyaWFsLmMgfCAxMyArKystLS0tLS0tLS0tCiAxIGZp
bGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL3R0eS9zZXJpYWwvb21hcC1zZXJpYWwuYyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9v
bWFwLXNlcmlhbC5jCmluZGV4IGI0ZTA2MDIwNWU2MS4uMTVkZGFhMWZkZmE0IDEwMDY0NAotLS0g
YS9kcml2ZXJzL3R0eS9zZXJpYWwvb21hcC1zZXJpYWwuYworKysgYi9kcml2ZXJzL3R0eS9zZXJp
YWwvb21hcC1zZXJpYWwuYwpAQCAtMTMzNiwxOCArMTMzNiwxMSBAQCBzZXJpYWxfb21hcF9jb25m
aWdfcnM0ODUoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCwgc3RydWN0IHNlcmlhbF9yczQ4NSAqcnM0
ODUpCiAJdXAtPmllciA9IDA7CiAJc2VyaWFsX291dCh1cCwgVUFSVF9JRVIsIDApOwogCi0JLyog
Q2xhbXAgdGhlIGRlbGF5cyB0byBbMCwgMTAwbXNdICovCi0JcnM0ODUtPmRlbGF5X3J0c19iZWZv
cmVfc2VuZCA9IG1pbihyczQ4NS0+ZGVsYXlfcnRzX2JlZm9yZV9zZW5kLCAxMDBVKTsKLQlyczQ4
NS0+ZGVsYXlfcnRzX2FmdGVyX3NlbmQgID0gbWluKHJzNDg1LT5kZWxheV9ydHNfYWZ0ZXJfc2Vu
ZCwgMTAwVSk7Ci0KLQkvKiBzdG9yZSBuZXcgY29uZmlnICovCi0JcG9ydC0+cnM0ODUgPSAqcnM0
ODU7Ci0KIAlpZiAodXAtPnJ0c19ncGlvZCkgewogCQkvKiBlbmFibGUgLyBkaXNhYmxlIHJ0cyAq
LwotCQl2YWwgPSAocG9ydC0+cnM0ODUuZmxhZ3MgJiBTRVJfUlM0ODVfRU5BQkxFRCkgPworCQl2
YWwgPSAocnM0ODUtPmZsYWdzICYgU0VSX1JTNDg1X0VOQUJMRUQpID8KIAkJCVNFUl9SUzQ4NV9S
VFNfQUZURVJfU0VORCA6IFNFUl9SUzQ4NV9SVFNfT05fU0VORDsKLQkJdmFsID0gKHBvcnQtPnJz
NDg1LmZsYWdzICYgdmFsKSA/IDEgOiAwOworCQl2YWwgPSAocnM0ODUtPmZsYWdzICYgdmFsKSA/
IDEgOiAwOwogCQlncGlvZF9zZXRfdmFsdWUodXAtPnJ0c19ncGlvZCwgdmFsKTsKIAl9CiAKQEAg
LTEzNTgsNyArMTM1MSw3IEBAIHNlcmlhbF9vbWFwX2NvbmZpZ19yczQ4NShzdHJ1Y3QgdWFydF9w
b3J0ICpwb3J0LCBzdHJ1Y3Qgc2VyaWFsX3JzNDg1ICpyczQ4NSkKIAkvKiBJZiBSUy00ODUgaXMg
ZGlzYWJsZWQsIG1ha2Ugc3VyZSB0aGUgVEhSIGludGVycnVwdCBpcyBmaXJlZCB3aGVuCiAJICog
VFggRklGTyBpcyBiZWxvdyB0aGUgdHJpZ2dlciBsZXZlbC4KIAkgKi8KLQlpZiAoIShwb3J0LT5y
czQ4NS5mbGFncyAmIFNFUl9SUzQ4NV9FTkFCTEVEKSAmJgorCWlmICghKHJzNDg1LT5mbGFncyAm
IFNFUl9SUzQ4NV9FTkFCTEVEKSAmJgogCSAgICAodXAtPnNjciAmIE9NQVBfVUFSVF9TQ1JfVFhf
RU1QVFkpKSB7CiAJCXVwLT5zY3IgJj0gfk9NQVBfVUFSVF9TQ1JfVFhfRU1QVFk7CiAJCXNlcmlh
bF9vdXQodXAsIFVBUlRfT01BUF9TQ1IsIHVwLT5zY3IpOwotLSAKMi4zNS4xCgo=
