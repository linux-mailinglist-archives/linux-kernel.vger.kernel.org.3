Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24A04B3E18
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 23:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238684AbiBMWeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 17:34:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238637AbiBMWd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 17:33:57 -0500
X-Greylist: delayed 323 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 13 Feb 2022 14:33:51 PST
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1362454BD6;
        Sun, 13 Feb 2022 14:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644791629;
        bh=uj5taIEdJ6Lv1V75u7KWN5Qj+Nh06Is1dtaFBls+PDY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=CTG8Sw17VXH1dXBgd7XO8lA5iO8LRKSx/RwMomjWsTby1GNXsn1dmqQKglxi6i4V5
         H1tG7i6TqgeNMZhkzW8JqpvJVTNx0BNfaDQdh+A9KiKOSj+JQyGbGSFvZpxVwivuBl
         Mwf15NzvvAvWfO3pdssL8YICVFEHkNaMzxs7fhk0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([149.172.237.68]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMXQF-1ncPlv1wIB-00Jbos; Sun, 13
 Feb 2022 23:28:08 +0100
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
Subject: [PATCH 5/9] serial: omap: remove redundant code in rs485_config
Date:   Sun, 13 Feb 2022 23:27:33 +0100
Message-Id: <20220213222737.15709-6-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220213222737.15709-1-LinoSanfilippo@gmx.de>
References: <20220213222737.15709-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:X9sHYupZQvrcHlgLqYrbYPQwoslXDrcL7/CgGZCd85CUEbScmXQ
 dgeYkd3PBvcxbJEL7xGCejBKonr9VJtpen2Uv4WLxIm7wRH4tITAaHpboYWG1qTt2Lefm3F
 8tzfOiBftGiTUQ9A1ydNYN7oQlx8OzcyCs9JElxoTYJHcceogCLGQaxeOGIQaa2Lv8aSOjM
 7Bo8+KL6CI45Lzyb57W0Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6hGdG+shHWU=:pT8CMStpVcrJz4pINuk08B
 MPoqK4zLd7ZLhT/kAWB6vQZBpB6pl4CusigobQcZWpyI7Bx60TDtAZIbENGzWQxR1UO3DGCBK
 C8AZx43Cd6SmN1psDvxuL/p9+Ri3SHSDY8Td7lvlkbWASKK8TfPReuSFY4tPTuDUN26knK0jU
 +2+ZaumyxlcvSyp6wTWj4xoHKan5DhKCc2OlJ9L1iqf9iuI+1sJgad3uFyFyH5aMrz1g8Rat8
 e0xUsWPA7vyXq7g7uDXI9daDqcNQ3oBSSkQLRZSI8Cf7MXbsPOdnb/ZoRUNNtnXtNZesha9Xn
 loleNxDyrNGUp1zfnFYXdBWFnHUhdqo4jkdXFEfcd/+SgJRzC4txF/lCfaeuujfJTe4dmNnIW
 jo9FVuncOqKyha8INkX+RhRV9/RIFltV3ETCL5pjGmmTdWXifSNVY0X9sSBnYJSAyPqQyyylz
 EawSll7V3ed4OFuHX9T70fq/LhKAsBfLzZvhJmf1i/9g6KiqtjkcTTwytNgur4tnzhA3NlJ2z
 D5LIFYeNr66YAVugX6BJN9G5D+TfqxDIV4SnPZ1CF4N/bs9RKiIIWW1uItz5lzUBg7SvPH/sC
 AtyvHdPEZpA3MyrUDEt1gykyEFZxrXJu+Cqwq9jpcokYxfHeuj2S/lh6CczADKCuBsgXEcLy9
 0g9khs0Pl3LoHg6pkeGq4sWdnC7UJf1V4YYoxaYZcy0/Gwj1ozYW0667BKSYAyuGy1xVTmRSX
 TLtp2bmp41EU31OYjt6j8qirv+MM4+5QKxMxu9lVupvwEYvonxsfZuPNgthnf6pkvFzvnJUNB
 IGOdHRX7ITLh+wPuvI67a0tqPY6FC9PSvbMDz+77k4DzBAs2pYl25I5ILfl4lYjKnk0fiM7b6
 qtyPmOsDTsrz9IlLhtBjaqMvEyDv1U+n7rWQh8FXB0Ku9dmpWHrKVNXVRA2W7ti8Lo/WJz4v/
 oce4IZdAN2cet+wkLSc8aA81VdKo1Yv7O5RBXPorVJNC/zAH9EL25qGl33MGriKV8dU4gk0ee
 5CgXdm6RIo2kYzQMke3TTd2ETg+M+CErJ+s/2ac/rrX2W4mqjISV0GGm5kR3BG1cnOpn68YsZ
 gDA665Gp9zMLCc=
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2hlbiBSUzQ4NSBpcyBjb25maWd1cmVkIGJ5IHVzZXJzcGFjZSB0aGUgc2VyaWFsIGNvcmUgYWxy
ZWFkeSBjbGFtcHMgdGhlClJUUyBkZWxheXMgYW5kIGFzc2lnbnMgdGhlIGNvbmZpZ3VyYXRpb24g
dG8gdGhlIHVhcnQgcG9ydC4gU28gcmVtb3ZlIHRoZXNlCnRhc2tzIGZyb20gdGhlIGNvZGUgb2Yg
dGhlIGRyaXZlcnMgcnM0ODVfY29uZmlnIGZ1bmN0aW9uIHRvIGF2b2lkCnJlZHVuZGFuY3kuCgpT
aWduZWQtb2ZmLWJ5OiBMaW5vIFNhbmZpbGlwcG8gPExpbm9TYW5maWxpcHBvQGdteC5kZT4KLS0t
CiBkcml2ZXJzL3R0eS9zZXJpYWwvb21hcC1zZXJpYWwuYyB8IDEzICsrKy0tLS0tLS0tLS0KIDEg
ZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdHR5L3NlcmlhbC9vbWFwLXNlcmlhbC5jIGIvZHJpdmVycy90dHkvc2VyaWFs
L29tYXAtc2VyaWFsLmMKaW5kZXggMDg2Mjk0MTg2MmM4Li5hM2FmY2NjZmJkOTYgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvdHR5L3NlcmlhbC9vbWFwLXNlcmlhbC5jCisrKyBiL2RyaXZlcnMvdHR5L3Nl
cmlhbC9vbWFwLXNlcmlhbC5jCkBAIC0xMzUwLDE4ICsxMzUwLDExIEBAIHNlcmlhbF9vbWFwX2Nv
bmZpZ19yczQ4NShzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0LCBzdHJ1Y3Qgc2VyaWFsX3JzNDg1ICpy
czQ4NSkKIAl1cC0+aWVyID0gMDsKIAlzZXJpYWxfb3V0KHVwLCBVQVJUX0lFUiwgMCk7CiAKLQkv
KiBDbGFtcCB0aGUgZGVsYXlzIHRvIFswLCAxMDBtc10gKi8KLQlyczQ4NS0+ZGVsYXlfcnRzX2Jl
Zm9yZV9zZW5kID0gbWluKHJzNDg1LT5kZWxheV9ydHNfYmVmb3JlX3NlbmQsIDEwMFUpOwotCXJz
NDg1LT5kZWxheV9ydHNfYWZ0ZXJfc2VuZCAgPSBtaW4ocnM0ODUtPmRlbGF5X3J0c19hZnRlcl9z
ZW5kLCAxMDBVKTsKLQotCS8qIHN0b3JlIG5ldyBjb25maWcgKi8KLQlwb3J0LT5yczQ4NSA9ICpy
czQ4NTsKLQogCWlmICh1cC0+cnRzX2dwaW9kKSB7CiAJCS8qIGVuYWJsZSAvIGRpc2FibGUgcnRz
ICovCi0JCXZhbCA9IChwb3J0LT5yczQ4NS5mbGFncyAmIFNFUl9SUzQ4NV9FTkFCTEVEKSA/CisJ
CXZhbCA9IChyczQ4NS0+ZmxhZ3MgJiBTRVJfUlM0ODVfRU5BQkxFRCkgPwogCQkJU0VSX1JTNDg1
X1JUU19BRlRFUl9TRU5EIDogU0VSX1JTNDg1X1JUU19PTl9TRU5EOwotCQl2YWwgPSAocG9ydC0+
cnM0ODUuZmxhZ3MgJiB2YWwpID8gMSA6IDA7CisJCXZhbCA9IChyczQ4NS0+ZmxhZ3MgJiB2YWwp
ID8gMSA6IDA7CiAJCWdwaW9kX3NldF92YWx1ZSh1cC0+cnRzX2dwaW9kLCB2YWwpOwogCX0KIApA
QCAtMTM3Miw3ICsxMzY1LDcgQEAgc2VyaWFsX29tYXBfY29uZmlnX3JzNDg1KHN0cnVjdCB1YXJ0
X3BvcnQgKnBvcnQsIHN0cnVjdCBzZXJpYWxfcnM0ODUgKnJzNDg1KQogCS8qIElmIFJTLTQ4NSBp
cyBkaXNhYmxlZCwgbWFrZSBzdXJlIHRoZSBUSFIgaW50ZXJydXB0IGlzIGZpcmVkIHdoZW4KIAkg
KiBUWCBGSUZPIGlzIGJlbG93IHRoZSB0cmlnZ2VyIGxldmVsLgogCSAqLwotCWlmICghKHBvcnQt
PnJzNDg1LmZsYWdzICYgU0VSX1JTNDg1X0VOQUJMRUQpICYmCisJaWYgKCEocnM0ODUtPmZsYWdz
ICYgU0VSX1JTNDg1X0VOQUJMRUQpICYmCiAJICAgICh1cC0+c2NyICYgT01BUF9VQVJUX1NDUl9U
WF9FTVBUWSkpIHsKIAkJdXAtPnNjciAmPSB+T01BUF9VQVJUX1NDUl9UWF9FTVBUWTsKIAkJc2Vy
aWFsX291dCh1cCwgVUFSVF9PTUFQX1NDUiwgdXAtPnNjcik7Ci0tIAoyLjM0LjEKCg==
