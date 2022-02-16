Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D3F4B7BC7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 01:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245000AbiBPATX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 19:19:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244848AbiBPATR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 19:19:17 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E680D5F4D;
        Tue, 15 Feb 2022 16:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644970724;
        bh=lQa+jzYKtWp6KPdLT/a3HxqzMlHwKAFbTOnPK9FsF40=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=XZQ+M+AO+wB74+I1fnj8BkEb+9CR3jpL3CTOnF2YHrX3pJ66yddgdz3mjzNT1UGgq
         oDrfImn6Dv0cHTzDLDEW6w47mTXazsKIAxLd1s2Ui4EQ/FyJAcswqSv14mj3INzMdU
         ctPus1IPg5EXKD+DDrzGEVLBs9hwk8Z3ai94w/pw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([149.172.237.68]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2f9h-1nHfK93YRL-004DLI; Wed, 16
 Feb 2022 01:18:44 +0100
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
Subject: [PATCH 2 6/9] serial: max310: remove redundant memset in rs485_config
Date:   Wed, 16 Feb 2022 01:18:00 +0100
Message-Id: <20220216001803.637-7-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220216001803.637-1-LinoSanfilippo@gmx.de>
References: <20220216001803.637-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:28MycnKYVIB7UlJrdb5FGLVDDUI7YjCcJKyT8XyTdj3c1KUUJzM
 yHQYiA0dsl5qqPPMN1Cb3K5J18csfM44YW3gGHUDdUEP8UfU2F0y/O3WpJKfaqgdPrH0bsJ
 QW0mOmLfrK9F7f59Z7Uw6WlEetyWbFfcVZ0bQkpWI+nF16kGriZ8GzkDzCC1Dq6kOHEsXRM
 es/oIPpaWxTNtIODzYBOQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2PraAB5/itw=:tiTHeVTo7ob0QfR/7R4HK/
 jZtFrlwS14tTg/dSVs4zj+8VMP1VlVYYCEi12Mr/LTKG2EkBUEKrq4vxOP1Hn0yJui7t59Dca
 WxrXIMsm23aIL358IhO1JSRnE4oNvFvEV+9swKKG6MSEaCLkHVrbUXeeco+5OxtyUVoK4qBwK
 qOJpr3cDFshGEVew++ZM3V1unvTOZXAKfwy0iwP6uW9WFEr7yEW6MIfs8r2cAbw5J6QwokkSl
 huTsO/kyx6l62dV9+jHEHeL6hSHxHFCzTPWS6aOFNIM2kL941XSDOtolzUC4zVxvsuIkpOzwE
 zU3qYZm4HjYpDHgirPtLVxNtNyPppkuR43IrBn+Nr3EIC/YtdJcDwcs0B9iZPw9Hyt3SVikM8
 +A0x51gb50Z6Bf3SRSJof85sjlGfPkHQBwaZiNPioHxzVITqBPcGbKeBWzORuEZj1KqOtuSPB
 jSWM+gU48wkstHvoIrLn/9QKKEU66k76xtfYO8yDzKwEZxKLn0jUaitj7NNrH2eW/+oWUQ1W1
 bvgtMjEK/bIMtzKqNcul9euXLUgG0RvnwXKudV7QfkQZukN4YXRIjv52hoFBzxlrzl6JzVOqR
 KgwCsVRiNbgxMg6vk7NlzKSBXhc4luADcrlkorfG8T3zfqB3+XXrTd/tDrxtsh7I+F1/CdVQV
 NLq9lhzvLm9fVdwKH8l0bdsuNDgdNHzOaKtKam75lvzURDMFociCKxz+fKTYbq4jrjxJajTA0
 kO7NpmoBcfiNBVXR3hjqtWztr3IU4k4LD4TKOGDmTIvK9C+Uc9QXHzrAW5GXvFZi8xwJBotYc
 mzeD5qfMNSZlI4qErtbYLKJG5lpSqKhH3tPuLCy5se4lmPmzAFryOi6b2OD9/ggDPyEfwPT6Z
 Yc8fTtaNLofjeLwYqPe/Z/AGs9OpBa/htBF0QcoiI9fyGhv0t2Je55mWTNlwb9QpW5uct/JM8
 MLu07J0hPwWxFEwDdJuu1yKGWhlwGHbQZN8xqR388Y6QJUNKOIkyni3XOdrLmXnG7vYvcCOeW
 +EIf4gEG3fXyuR5d/s5ftMahNH7WysBHqGgBaKn2iWii1t4QaNTC+OpZy2XGLxD/lQhbSWaa/
 fDsgft+HJFPxyA=
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW4gdWFydF9zZXRfcnM0ODVfY29uZmlnKCkgdGhlIHNlcmlhbCBjb3JlIGFscmVhZHkgbnVsbGlm
aWVzIHRoZSBwYWRkaW5nCmZpZWxkIG9mIHRoZSBwYXNzZWQgc2VyaWFsX3JzNDg1IHN0cnVjdCBi
ZWZvcmUgcmV0dXJuaW5nIGl0IHRvIHVzZXJzcGFjZS4KCkRvaW5nIHRoZSBzYW1lIGluIHRoZSBk
cml2ZXJzIHJzNDg1X2NvbmZpZygpIGZ1bmN0aW9uIGlzIHJlZHVuZGFudCwgc28KcmVtb3ZlIHRo
ZSBjb25jZXJuaW5nIG1lbXNldCBpbiB0aGlzIGZ1bmN0aW9uLgoKU2lnbmVkLW9mZi1ieTogTGlu
byBTYW5maWxpcHBvIDxMaW5vU2FuZmlsaXBwb0BnbXguZGU+Ci0tLQogZHJpdmVycy90dHkvc2Vy
aWFsL21heDMxMHguYyB8IDEgLQogMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvbWF4MzEweC5jIGIvZHJpdmVycy90dHkvc2VyaWFs
L21heDMxMHguYwppbmRleCBkZGUwODI0YjJmYTUuLjJlY2M1ZjY2ZGVhZiAxMDA2NDQKLS0tIGEv
ZHJpdmVycy90dHkvc2VyaWFsL21heDMxMHguYworKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvbWF4
MzEweC5jCkBAIC0xMDM3LDcgKzEwMzcsNiBAQCBzdGF0aWMgaW50IG1heDMxMHhfcnM0ODVfY29u
ZmlnKHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQsCiAKIAlyczQ4NS0+ZmxhZ3MgJj0gU0VSX1JTNDg1
X1JUU19PTl9TRU5EIHwgU0VSX1JTNDg1X1JYX0RVUklOR19UWCB8CiAJCQlTRVJfUlM0ODVfRU5B
QkxFRDsKLQltZW1zZXQocnM0ODUtPnBhZGRpbmcsIDAsIHNpemVvZihyczQ4NS0+cGFkZGluZykp
OwogCXBvcnQtPnJzNDg1ID0gKnJzNDg1OwogCiAJc2NoZWR1bGVfd29yaygmb25lLT5yc193b3Jr
KTsKLS0gCjIuMzQuMQoK
