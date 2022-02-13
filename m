Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988AF4B3E02
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 23:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238597AbiBMW2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 17:28:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238583AbiBMW2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 17:28:36 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9D354693;
        Sun, 13 Feb 2022 14:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644791286;
        bh=8vbc9twoUnggUtV10g7Mb1U2iiUeZXUFcj4fWWaxiwc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=KzjfhcAZczeP42Kc+7eSyADZ3vwREiZGBp9roVilY9ewt2ksqSuI/JvJg2j5kMVxa
         mJDR7n9ljR6OFNZ3KdB8vhU++9m8WQ/rMSzQELa4K0OgzDUbYM/bDEcT2TBNAGaquk
         vUaRBtGXKbKYyVlN/aGhNYikGke8j2X9kjaga7M4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([149.172.237.68]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mz9Ux-1oEnO23kPb-00wEQc; Sun, 13
 Feb 2022 23:28:06 +0100
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
Subject: [PATCH 2/9] serial: amba-pl011: remove redundant code in rs485_config
Date:   Sun, 13 Feb 2022 23:27:30 +0100
Message-Id: <20220213222737.15709-3-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220213222737.15709-1-LinoSanfilippo@gmx.de>
References: <20220213222737.15709-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:c6+Ys0/CKTSgWjVeoHGhXE+C7sk8b465AsFJvqvT7hz8+wtDILI
 NE3k60+XHiuNHEj2TtJpphtCYkCMo4QEpfjehlyIIi44xqXykt7VEWB7Quwjm++QSW9C1ok
 c0kE/CShtmVL3c5kTMdNm8WfIiYMVLwau6yNXOYtsq7yd9HvNp4HA/7w2J5S5dvZYxf5XwA
 zu8cffo7aTS44giQMVBbg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:akt+BNB8rAE=:Bij2tUiEnDYYUcmCI8CH+u
 A4X+QoGrJhbTtvO81tUsSGH35FOJ9hYG/4EkmBjBWlUTdmgiDY90LejjQ1T1DOWbbD9nPP9ho
 0kMwdXf83JZ07EDk9e8rEFIEUkPTA5YQ76+KUyd2PTsk+krztvyEZUgIl8tVw+OvZ5aGXGPkU
 WEeyn5ENHzR6Bl7wDAz0XqLz9huU49AAUcCqUG3RQn39totfHr338TqD0HRJD6MLpPpw50xUO
 fn+H19tJ7/L7XojyykiBUoxb0U/CkH6b4AdUkcx27iN/sOPuy3CmMM+EOb22PlE3+A2cy8m5f
 jRjbW5XYBz1LWtjetZSfMhldFJUenIkLCIcxl9HfNEKPJIjwt6IaNatq3AxzvD/W6qGqbJPoj
 fc/0DDAQYcghgn32ByxAcVQcxr+ygvkbAdKHTHzjJ+fwHfHDv/a/SeK+YNVagaXmRqlPk810V
 ziIOIamhRohN/Niu2k+n3mlxrwehLBKh9USfwKT8DfgrnOO2DEdT6srG1qzkARKlto1Qj36gS
 MJwcGmlPJ+tiIg50bibbbXG3ktSP3j6o142XKCAnGH5NYR8+T+fSrnjr6OtzTaEceQLoPXp88
 CnO21q1/l3XdwCgOOF02PbPAl7TwNqP7ClB86ki+c4Ez7ExHt7eklnwxe0+JzA0mo+lFWUB2U
 ojqgyfDEpcLsZwSKvJ6Vg2e+HZuU0ok3DlnwiePXZhMekSJZW/8Oey4sUIAKrAGJVvcOlCxFQ
 I5ADBW0EPpxT4xG3XfUefQnfFfsfKiJ+GqdcIXuJ0EBkQ9bzrGmDF77fzKr9qKQh6cd8l1fTy
 tcs79czwiFw9j6JZ1RP5Z5HaOjUvPf5MrHyAPKDV2MBf5XvyxdPH3XEejYXsYbkz3xqqL6+Cy
 CNRj5KfoxNsrUxk9G1Ir3wQkCoJc7mhJWP5bcNN97Y/dvxrkBwUKvJnKnSBGvbC8ybIYMy1Nb
 CAfcQ1+KoVarO2W2L1P5VZPyIucsCrCP3n8UaUAIZW3R8ra41iTBKZ4uuIgPZ/BrMy2TEbjUT
 spGalwnWvT8DIdqumYaFRpCpAjvrGbx/KtUvYOJ1h1Fn/KT1JUI0yW6PLNFfXWaNJilrNcEtI
 S8gqQvcwhLJ36g=
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
ZWFkeQoKLSBjaGVja3MgZm9yIHZhbGlkIFJUUyBzZXR0aW5ncwotIG51bGxpZmllcyB0aGUgcGFk
ZGluZyBmaWVsZCBvZiB0aGUgcGFzc2VkIHNlcmlhbF9yczQ4NSBzdHJ1Y3QKLSBjbGFtcHMgdGhl
IFJUUyBkZWxheXMKLSBhc3NpZ25zIHRoZSBwYXNzZWQgY29uZmlndXJhdGlvbiB0byB0aGUgdWFy
dCBwb3J0IHN0cnVjdAoKU28gcmVtb3ZlIHRoZXNlIHRhc2tzIGZyb20gdGhlIGNvZGUgb2YgdGhl
IHJzNDg1X2NvbmZpZyBmdW5jdGlvbiB0byBhdm9pZApyZWR1bmRhbmN5LgoKU2lnbmVkLW9mZi1i
eTogTGlubyBTYW5maWxpcHBvIDxMaW5vU2FuZmlsaXBwb0BnbXguZGU+Ci0tLQogZHJpdmVycy90
dHkvc2VyaWFsL2FtYmEtcGwwMTEuYyB8IDE2ICstLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMTUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy90dHkvc2VyaWFsL2FtYmEtcGwwMTEuYyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9hbWJhLXBsMDEx
LmMKaW5kZXggYmEwNTNhNjg1MjlmLi4zNWM2MzM3Mzk5NzUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
dHR5L3NlcmlhbC9hbWJhLXBsMDExLmMKKysrIGIvZHJpdmVycy90dHkvc2VyaWFsL2FtYmEtcGww
MTEuYwpAQCAtMjE3MCwyNSArMjE3MCwxMSBAQCBzdGF0aWMgaW50IHBsMDExX3JzNDg1X2NvbmZp
ZyhzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0LAogCXN0cnVjdCB1YXJ0X2FtYmFfcG9ydCAqdWFwID0K
IAkJY29udGFpbmVyX29mKHBvcnQsIHN0cnVjdCB1YXJ0X2FtYmFfcG9ydCwgcG9ydCk7CiAKLQkv
KiBwaWNrIHNhbmUgc2V0dGluZ3MgaWYgdGhlIHVzZXIgaGFzbid0ICovCi0JaWYgKCEocnM0ODUt
PmZsYWdzICYgU0VSX1JTNDg1X1JUU19PTl9TRU5EKSA9PQotCSAgICAhKHJzNDg1LT5mbGFncyAm
IFNFUl9SUzQ4NV9SVFNfQUZURVJfU0VORCkpIHsKLQkJcnM0ODUtPmZsYWdzIHw9IFNFUl9SUzQ4
NV9SVFNfT05fU0VORDsKLQkJcnM0ODUtPmZsYWdzICY9IH5TRVJfUlM0ODVfUlRTX0FGVEVSX1NF
TkQ7Ci0JfQotCS8qIGNsYW1wIHRoZSBkZWxheXMgdG8gWzAsIDEwMG1zXSAqLwotCXJzNDg1LT5k
ZWxheV9ydHNfYmVmb3JlX3NlbmQgPSBtaW4ocnM0ODUtPmRlbGF5X3J0c19iZWZvcmVfc2VuZCwg
MTAwVSk7Ci0JcnM0ODUtPmRlbGF5X3J0c19hZnRlcl9zZW5kID0gbWluKHJzNDg1LT5kZWxheV9y
dHNfYWZ0ZXJfc2VuZCwgMTAwVSk7Ci0JbWVtc2V0KHJzNDg1LT5wYWRkaW5nLCAwLCBzaXplb2Yo
cnM0ODUtPnBhZGRpbmcpKTsKLQogCWlmIChwb3J0LT5yczQ4NS5mbGFncyAmIFNFUl9SUzQ4NV9F
TkFCTEVEKQogCQlwbDAxMV9yczQ4NV90eF9zdG9wKHVhcCk7CiAKLQkvKiBTZXQgbmV3IGNvbmZp
Z3VyYXRpb24gKi8KLQlwb3J0LT5yczQ4NSA9ICpyczQ4NTsKLQogCS8qIE1ha2Ugc3VyZSBhdXRv
IFJUUyBpcyBkaXNhYmxlZCAqLwotCWlmIChwb3J0LT5yczQ4NS5mbGFncyAmIFNFUl9SUzQ4NV9F
TkFCTEVEKSB7CisJaWYgKHJzNDg1LT5mbGFncyAmIFNFUl9SUzQ4NV9FTkFCTEVEKSB7CiAJCXUz
MiBjciA9IHBsMDExX3JlYWQodWFwLCBSRUdfQ1IpOwogCiAJCWNyICY9IH5VQVJUMDExX0NSX1JU
U0VOOwotLSAKMi4zNC4xCgo=
