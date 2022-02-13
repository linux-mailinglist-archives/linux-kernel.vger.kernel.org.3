Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98D24B3E1B
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 23:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238662AbiBMWeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 17:34:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238628AbiBMWd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 17:33:56 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA9954BC0;
        Sun, 13 Feb 2022 14:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644791628;
        bh=n1QSAdLWsAQBxZRJC/gnWpm6+lTx/Zgz/1kXnTeWbTk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Euvc0QJs5qieCLnv9C6/YUVPLjBNeYOTXTteefGmLXgCboPOrB8Nc0N2t5d99rahC
         sQi58eRP3vSQ7RSFe7zZLFnRDEJuGzgk5Onds7fSrTPgUV8Dj5anXTZYQPgtd16kQf
         1bQUxA1+wejOhYged7FtqMi8wWKqNq+AzcsophYI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([149.172.237.68]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mk0NU-1nz4sc49Zg-00kOyf; Sun, 13
 Feb 2022 23:28:11 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux@armlinux.org.uk, richard.genoud@gmail.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, lukas@wunner.de,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: [PATCH 8/9] serial: fsl_lpuart: remove redundant code in rs485_config functions
Date:   Sun, 13 Feb 2022 23:27:36 +0100
Message-Id: <20220213222737.15709-9-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220213222737.15709-1-LinoSanfilippo@gmx.de>
References: <20220213222737.15709-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:C/eQLJontq2RLt02NobbFgS16JscCgWH9ptxRkHS5Z0m9OOZox8
 QJGSADIVHCm1oXdpAIolH0IZm4dSg8gHv3aQgY5IRT0JMcQLYAzrw6FPiw1+XnQmDkw/xGA
 W1WYjAcv3FUh6R5QieabywvgR65jtD6wAJRB1A7LCgqcjvv7kUdIfMTyYwJm6rwuRAh/fiw
 3G7H1DWGTLFL4eHAtVtHw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U16uzVtWgXY=:tZVo3I7KjrLD55/IVEQz9A
 i0uiAt7g6CbjcxV7+YCGedN6AYeKUSm43jNjorEj8neySgcdg2sVwwxduc2CQQC70PmccQ5tq
 XrOW027kGd/ArvGgTfP6tgcddHDalQjca+c0/qe9SdRge7vq2sTvtBl6XrYXAD4+L361S+OfO
 rAAxjOb75fpa97uFUEzubcYPbPLH3MLqBR+n8ns0xJPGJHzugbHimrRC8vy3YxlumiJQ30j+d
 pIjoZjojcfUNkITgJJ21dm146N02KV7RwgnSROLHZ5jdsZRid1HKYYry+JvWhXGtKbrsYA7Ds
 E1aXunqXLQtroV/II3YKhT3DPvBVz/5VU6NT1CNIPoK2wMY2KRDlg2MIzKPr0rh+BMyiEDLPo
 E7D8I7POIZAj+N4/1NLTcBYr3QJ0zRDUmwLOhN4Q8+iMtsYzGcmEBi+kVepLJXYbowMTrdHzx
 xl3I2BCmGsMyW9iLeoQQYPOMDsdJmDOZ0TTZcLNYW3HTnX0H7KiwJoxqunqLnlR3z6tWS/VVo
 lRp7xMt+DqhD80CM2ga2SnUTwj03EVL40FwAlYzBJxFA4VcPhefsrI0Nq9rP1bTwkp6b7bHoj
 7OjkX/pcn6/A8qphaA3jLWajFBLhAw+FivtuQl3aNjxW1NLRGE9QNCxl8n/eHwEm3av1i5rEv
 yBp01gmQMIH8erJH8PfN/9a+kkMsx3AHOpKmq5DKhNct+nyFdmPs5QJ0vwsHMuxSYp22hDWz4
 rRnXE8gf7cfgOl1WNAXcUfjFPfJXev0K7WPKPB0UOGLUh7CFBV8QQ3TuYwYwRBJd+XbdtFxBz
 CmQo5IrTfu0aBLIm5KTgI3ZXmI5xjQeK8OPHp+Pj6tBN4g1Pg4qyu5BNJoNoZ2HMDxgRD/QwS
 IJU4wXn1V5tUjpxC/EtFLuTPvApg8swNJfKoIl8GDfVAGZidy6ZmlCWBaqftmBC6o5XSM8cwU
 ix3r4gTyaQ4kXmnFHcY7Pspvk9t7d4QSyXSvEI1gv29Vz0lijy0DWLnR0Y/SLaJOYv2NexX8r
 1e0Wnraa0NTxvBYc5MsuzaJiMDQ/PCNr9sRuVidg8qGK3pt/gmlJwkclrDThrsoszVJINsdrW
 3fHqSgh8a/wqHM=
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2hlbiBSUzQ4NSBpcyBjb25maWd1cmVkIGJ5IHVzZXJzcGFjZSB0aGUgc2VyaWFsIGNvcmUgYWxy
ZWFkeSBjaGVja3MgZm9yCnZhbGlkIFJUUyBzZXR0aW5ncyBhbmQgYXNzaWducyB0aGUgY29uZmln
dXJhdGlvbiB0byB0aGUgdWFydCBwb3J0LiBTbwpyZW1vdmUgYm90aCB0YXNrcyBmcm9tIHRoZSBj
b2RlIG9mIHRoZSBscHVhcnRfY29uZmlnX3JzNDg1IGFuZCB0aGUKbHB1YXJ0MzJfY29uZmlnX3Jz
NDg1IGZ1bmN0aW9uIHRvIGF2b2lkIHJlZHVuZGFuY3kuCgpTaWduZWQtb2ZmLWJ5OiBMaW5vIFNh
bmZpbGlwcG8gPExpbm9TYW5maWxpcHBvQGdteC5kZT4KLS0tCiBkcml2ZXJzL3R0eS9zZXJpYWwv
ZnNsX2xwdWFydC5jIHwgMzIgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIDEgZmls
ZSBjaGFuZ2VkLCAzMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJp
YWwvZnNsX2xwdWFydC5jIGIvZHJpdmVycy90dHkvc2VyaWFsL2ZzbF9scHVhcnQuYwppbmRleCA3
ZDkwYzVhNTMwZWUuLmEyMDFiZTQ0ZDY4YSAxMDA2NDQKLS0tIGEvZHJpdmVycy90dHkvc2VyaWFs
L2ZzbF9scHVhcnQuYworKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvZnNsX2xwdWFydC5jCkBAIC0x
Mzc3LDE5ICsxMzc3LDYgQEAgc3RhdGljIGludCBscHVhcnRfY29uZmlnX3JzNDg1KHN0cnVjdCB1
YXJ0X3BvcnQgKnBvcnQsCiAJCS8qIEVuYWJsZSBhdXRvIFJTLTQ4NSBSVFMgbW9kZSAqLwogCQlt
b2RlbSB8PSBVQVJUTU9ERU1fVFhSVFNFOwogCi0JCS8qCi0JCSAqIFJUUyBuZWVkcyB0byBiZSBs
b2dpYyBISUdIIGVpdGhlciBkdXJpbmcgdHJhbnNmZXIgX29yXyBhZnRlcgotCQkgKiB0cmFuc2Zl
ciwgb3RoZXIgdmFyaWFudHMgYXJlIG5vdCBzdXBwb3J0ZWQgYnkgdGhlIGhhcmR3YXJlLgotCQkg
Ki8KLQotCQlpZiAoIShyczQ4NS0+ZmxhZ3MgJiAoU0VSX1JTNDg1X1JUU19PTl9TRU5EIHwKLQkJ
CQlTRVJfUlM0ODVfUlRTX0FGVEVSX1NFTkQpKSkKLQkJCXJzNDg1LT5mbGFncyB8PSBTRVJfUlM0
ODVfUlRTX09OX1NFTkQ7Ci0KLQkJaWYgKHJzNDg1LT5mbGFncyAmIFNFUl9SUzQ4NV9SVFNfT05f
U0VORCAmJgotCQkJCXJzNDg1LT5mbGFncyAmIFNFUl9SUzQ4NV9SVFNfQUZURVJfU0VORCkKLQkJ
CXJzNDg1LT5mbGFncyAmPSB+U0VSX1JTNDg1X1JUU19BRlRFUl9TRU5EOwotCiAJCS8qCiAJCSAq
IFRoZSBoYXJkd2FyZSBkZWZhdWx0cyB0byBSVFMgbG9naWMgSElHSCB3aGlsZSB0cmFuc2Zlci4K
IAkJICogU3dpdGNoIHBvbGFyaXR5IGluIGNhc2UgUlRTIHNoYWxsIGJlIGxvZ2ljIEhJR0gKQEAg
LTE0MDIsOSArMTM4OSw2IEBAIHN0YXRpYyBpbnQgbHB1YXJ0X2NvbmZpZ19yczQ4NShzdHJ1Y3Qg
dWFydF9wb3J0ICpwb3J0LAogCQkJbW9kZW0gfD0gVUFSVE1PREVNX1RYUlRTUE9MOwogCX0KIAot
CS8qIFN0b3JlIHRoZSBuZXcgY29uZmlndXJhdGlvbiAqLwotCXNwb3J0LT5wb3J0LnJzNDg1ID0g
KnJzNDg1OwotCiAJd3JpdGViKG1vZGVtLCBzcG9ydC0+cG9ydC5tZW1iYXNlICsgVUFSVE1PREVN
KTsKIAlyZXR1cm4gMDsKIH0KQEAgLTE0MjgsMTkgKzE0MTIsNiBAQCBzdGF0aWMgaW50IGxwdWFy
dDMyX2NvbmZpZ19yczQ4NShzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0LAogCQkvKiBFbmFibGUgYXV0
byBSUy00ODUgUlRTIG1vZGUgKi8KIAkJbW9kZW0gfD0gVUFSVE1PREVNX1RYUlRTRTsKIAotCQkv
KgotCQkgKiBSVFMgbmVlZHMgdG8gYmUgbG9naWMgSElHSCBlaXRoZXIgZHVyaW5nIHRyYW5zZmVy
IF9vcl8gYWZ0ZXIKLQkJICogdHJhbnNmZXIsIG90aGVyIHZhcmlhbnRzIGFyZSBub3Qgc3VwcG9y
dGVkIGJ5IHRoZSBoYXJkd2FyZS4KLQkJICovCi0KLQkJaWYgKCEocnM0ODUtPmZsYWdzICYgKFNF
Ul9SUzQ4NV9SVFNfT05fU0VORCB8Ci0JCQkJU0VSX1JTNDg1X1JUU19BRlRFUl9TRU5EKSkpCi0J
CQlyczQ4NS0+ZmxhZ3MgfD0gU0VSX1JTNDg1X1JUU19PTl9TRU5EOwotCi0JCWlmIChyczQ4NS0+
ZmxhZ3MgJiBTRVJfUlM0ODVfUlRTX09OX1NFTkQgJiYKLQkJCQlyczQ4NS0+ZmxhZ3MgJiBTRVJf
UlM0ODVfUlRTX0FGVEVSX1NFTkQpCi0JCQlyczQ4NS0+ZmxhZ3MgJj0gflNFUl9SUzQ4NV9SVFNf
QUZURVJfU0VORDsKLQogCQkvKgogCQkgKiBUaGUgaGFyZHdhcmUgZGVmYXVsdHMgdG8gUlRTIGxv
Z2ljIEhJR0ggd2hpbGUgdHJhbnNmZXIuCiAJCSAqIFN3aXRjaCBwb2xhcml0eSBpbiBjYXNlIFJU
UyBzaGFsbCBiZSBsb2dpYyBISUdICkBAIC0xNDUzLDkgKzE0MjQsNiBAQCBzdGF0aWMgaW50IGxw
dWFydDMyX2NvbmZpZ19yczQ4NShzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0LAogCQkJbW9kZW0gfD0g
VUFSVE1PREVNX1RYUlRTUE9MOwogCX0KIAotCS8qIFN0b3JlIHRoZSBuZXcgY29uZmlndXJhdGlv
biAqLwotCXNwb3J0LT5wb3J0LnJzNDg1ID0gKnJzNDg1OwotCiAJbHB1YXJ0MzJfd3JpdGUoJnNw
b3J0LT5wb3J0LCBtb2RlbSwgVUFSVE1PRElSKTsKIAlyZXR1cm4gMDsKIH0KLS0gCjIuMzQuMQoK
