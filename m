Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D2E4FAD6C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 12:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiDJKuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 06:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237186AbiDJKty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 06:49:54 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD165370C;
        Sun, 10 Apr 2022 03:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649587637;
        bh=sH4GWcet3t8UsheqwmzweMT86DhSlYFlIJ8afvdMkbA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=LTrw3NSD5pR1mT2xtl5BD/JvFX1Q0D1uUHVI1pnqVEhYG5cZc4WG+eQLlfn5x/kJQ
         hJjUzTDy8Q7aE/zJ2Nkgh+CqrohMChOJc5sxsAIP0uYVbWZlyET6T42SJCxrgC4y02
         P2CsiCgGy+2xHDR4ShO84kkvdZmyfANiQsPBli6c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([46.223.3.230]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M9Wys-1naBAv16nc-005WBa; Sun, 10
 Apr 2022 12:47:17 +0200
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
Subject: [PATCH v4 RESEND 4/9] serial: sc16is7xx: remove redundant check in rs485_config
Date:   Sun, 10 Apr 2022 12:46:37 +0200
Message-Id: <20220410104642.32195-5-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220410104642.32195-1-LinoSanfilippo@gmx.de>
References: <20220410104642.32195-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:nxIRW4IpASBzZhIC0wKy6myh05IHHt/dHYiioie/NX+/0nfaj9T
 uNtygXATATV0Qm9fZYh+gE5u5cdUbX57WBaeO5gq7rJfCU1v1tkuvdI8iuVOivsWtIUjTJ1
 OINg7Ky7tb3wwvZsYxKmV9WJf5HBzwME98+GKW14IIW8nTRrmv/LtWOFZ2b3OfOJXQD03XI
 qEa6SLzdia+3YLo316fQQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Rv+ObUgxBd8=:MS/eHE+YbEGx9By85ob2Al
 kgKW/1/ebyasIoMZ7FogvN7E4iRz+HEV1UyCpxdYHSOKap3adVOrfcs7/zMVEgnUd31QXYTmB
 A8Hw3GtqU1+0uYNy05odZ7kiOl+bsKNuCp42wVupTOHlEBaSb8JmkCaAXvptbLWvysWCKu18/
 jSi8CzYtAdFM+9c+a8Nedm51+Ab0vACwf8Huc9s1FCaHAW1FwS31jT/flp5S7q1T+Se9+Vvn5
 4QG+Bjp8qRbaeJSKdfpNAVsAvtAsEYdbLyw4tBfwZ01b6fPcfaTqXftNZz5d8eGOZ8GV3CFoE
 M5gnel3S6R10DrToO8VX+DDm9D7I21yPiDHiP++zqyTFBoxWqxuoJvgRuK1JLtyKL3XbuAu1z
 7z0WWARCPT0uO1nHEt/q50iWkldQimhS7JIZUqMJ5yQYbBHC0qU2JZ5sIMthiMFQukPqqSuKi
 xRlWnl+LU0kGvsikVDOP83xoB3WwQxznagE0WItbHKESAxOdTBF6b5YNCcedLY5m9CF/8sl3G
 WLHeQ6DObfjtQbTv+z7/v+voWjtjcBF7CF/n67p9Cl3UUD638EmDHUZtSlYTBm76vEK6bg/4T
 SbtkGe6RzoTAMwSGTpqkNyI2MQQAdZ3zr8IRfOn24O4qRbm/uHQedKV6vVIwQmLiJjSaIRcay
 vKUGxSUtzRqjcl7higDFlB76UF040unecWD8rmSyheo5U7w6eScNEWz9oewgPWvPjJSYCz5dE
 Qbokol7Ubas8n/obFedoyZrzm4QMSaSfa93t7WN5qiOhuLDWUQG1O2HJeao4aLSL8JjcP2rve
 hdLxCj4PqRsX4JZL36f/W7X8XRuz4RhR9kPJ/vQbUAgThrp5JIvZwBEQNzpjSOCPRHw0QzW7G
 V4Kb/9RTMcCbjkBHGggNQ0JA6F4oFjYU1ds4QJT1BJoA3DITVk//E3MYAd1Oox/3eQ3JoTkEN
 10zBMbuKZzv1YJwTgCGP2O/axAVeuGBZ7AjP/hBschgqwNfiIZp/CGjrl0B2chSx1t2KCL+KQ
 S3ZSq+htgRL8CrXdx9rtN4uxLw33o48fDe1BxhoOLuEiIJZnJ84XFnochqijKQH+0660qSlFw
 7hCUneFyc0ttig=
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW4gdWFydF9zZXRfcnM0ODVfY29uZmlnKCkgdGhlIHNlcmlhbCBjb3JlIGFscmVhZHkgZW5zdXJl
cyB0aGF0IG9ubHkgb25lIG9mCmJvdGggb3B0aW9ucyBSVFMgb24gc2VuZCBvciBSVFMgYWZ0ZXIg
c2VuZCBpcyBzZXQuCgpTbyByZW1vdmUgdGhpcyBjaGVjayBmcm9tIHRoZSBkcml2ZXJzIHJzNDg1
X2NvbmZpZygpIGZ1bmN0aW9uIHRvIGF2b2lkCnJlZHVuZGFuY3kuCgpTaWduZWQtb2ZmLWJ5OiBM
aW5vIFNhbmZpbGlwcG8gPExpbm9TYW5maWxpcHBvQGdteC5kZT4KLS0tCiBkcml2ZXJzL3R0eS9z
ZXJpYWwvc2MxNmlzN3h4LmMgfCAxMCAtLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTAgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFsL3NjMTZpczd4eC5jIGIv
ZHJpdmVycy90dHkvc2VyaWFsL3NjMTZpczd4eC5jCmluZGV4IGU4NTdmYjYxZWZiZi4uYmI5Mzlk
Mjg3N2RiIDEwMDY0NAotLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvc2MxNmlzN3h4LmMKKysrIGIv
ZHJpdmVycy90dHkvc2VyaWFsL3NjMTZpczd4eC5jCkBAIC0xMTM0LDE2ICsxMTM0LDYgQEAgc3Rh
dGljIGludCBzYzE2aXM3eHhfY29uZmlnX3JzNDg1KHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQsCiAJ
c3RydWN0IHNjMTZpczd4eF9vbmUgKm9uZSA9IHRvX3NjMTZpczd4eF9vbmUocG9ydCwgcG9ydCk7
CiAKIAlpZiAocnM0ODUtPmZsYWdzICYgU0VSX1JTNDg1X0VOQUJMRUQpIHsKLQkJYm9vbCBydHNf
ZHVyaW5nX3J4LCBydHNfZHVyaW5nX3R4OwotCi0JCXJ0c19kdXJpbmdfcnggPSByczQ4NS0+Zmxh
Z3MgJiBTRVJfUlM0ODVfUlRTX0FGVEVSX1NFTkQ7Ci0JCXJ0c19kdXJpbmdfdHggPSByczQ4NS0+
ZmxhZ3MgJiBTRVJfUlM0ODVfUlRTX09OX1NFTkQ7Ci0KLQkJaWYgKHJ0c19kdXJpbmdfcnggPT0g
cnRzX2R1cmluZ190eCkKLQkJCWRldl9lcnIocG9ydC0+ZGV2LAotCQkJCSJ1bnN1cHBvcnRlZCBS
VFMgc2lnbmFsbGluZyBvbl9zZW5kOiVkIGFmdGVyX3NlbmQ6JWQgLSBleGFjdGx5IG9uZSBvZiBS
UzQ4NSBSVFMgZmxhZ3Mgc2hvdWxkIGJlIHNldFxuIiwKLQkJCQlydHNfZHVyaW5nX3R4LCBydHNf
ZHVyaW5nX3J4KTsKLQogCQkvKgogCQkgKiBSVFMgc2lnbmFsIGlzIGhhbmRsZWQgYnkgSFcsIGl0
J3MgdGltaW5nIGNhbid0IGJlIGluZmx1ZW5jZWQuCiAJCSAqIEhvd2V2ZXIsIGl0J3Mgc29tZXRp
bWVzIHVzZWZ1bCB0byBkZWxheSBUWCBldmVuIHdpdGhvdXQgUlRTCi0tIAoyLjM1LjEKCg==
