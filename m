Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323634BEF14
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 02:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238139AbiBVBQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 20:16:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237108AbiBVBQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 20:16:02 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C4524F3C;
        Mon, 21 Feb 2022 17:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645492510;
        bh=iSIbiqQY+am1M73zZEjjrGJSzNxevmnnhXm36hRIfqw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=AeyV7Qm6vKSfQKXhoeUcb75P59CSBGm947hqdfZBUF3+8x0Dk9TccuMYRoRHWaaJJ
         8Y2IBs/tws3+mtRJRolcpLDMt8YG/+CHXDbhDg4kd5ppeY95IlK9efawH85QjnYP+j
         GkW7mpqWW7Z7xEU2ZMfLs2Ddi6SzTXRUJNOGDEtE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([149.172.237.68]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MF3DW-1nSrDS1nUu-00FV8u; Tue, 22
 Feb 2022 02:15:10 +0100
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
Subject: [PATCH v3 6/9] serial: max310: remove redundant memset in rs485_config
Date:   Tue, 22 Feb 2022 02:14:30 +0100
Message-Id: <20220222011433.8761-7-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220222011433.8761-1-LinoSanfilippo@gmx.de>
References: <20220222011433.8761-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:wKGwZ92bvJ8eZUe5xx6uvTWNLasLSuFKw+u6quzZxtU7poVTk55
 j5s9fonP6abJ9aj5k/Sjxn3klkZB8Js5Q0q+3sm8bNDETNs+k5npnVX2gd2LISm9IaWbw6G
 sLf1UEY4o+wPHOY5D7hkdejw6Ls8wPRst3CS1nOE/zl/1BRfFsi5+zXEU/RMvac4OlA/+b7
 rUiTgtWlLCkFRpRlfwGWw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lhyAliQH69Q=:2hUiu6M3Dm94AHqmQ4FPRp
 ahirSDrA+IJixDhwZQiB0t+u99J1K/k82eQ1OSlPa4jUi8JIvroXaHdVknRxGCmRPP+Ze1X+h
 QjAfY9vGn+0XjiKMEBlrdO+M8y3UmmiCwkZfabIApB+2u1Ff6i2VgN4PTiDE5aQbT+bsBdgsS
 +QNf3kvPnPUnHAW7ec8EYxVW32yZp7Jrp8yh1eZoa5wMsVn8HnEoBV02s0diIcfoRGbl0nRZx
 xpdWGuJzF++IGWPHz29WqEP3VJtUMp5653u76OTxLpzmum6YpuieANHIlOnLtavQeJJDC52aB
 b1s1v1rm2Fv/Vxvtd7PhHCwt1e03dO1DaUBUL+PIgCTlRS9RB14mZBVq+libkgrdbgtTKMzuw
 m/aRkORAAv2JOk1zlNqi+QAZdvTHI7/KCaQmNtpllP6HI1lCwsm2O6ZBSUtsJQ5FWaDXtxN+8
 BFESbX/RnLyazLIQRRCf6CMhLu0/2ajsapGBvDAYupXIlE7LYvEBo3o6aBb/Xo0ADIg8tgWo0
 ReYgPJe/6ib8zbx0CKeWGlqsMy2Jf2Ih3/BqRpLm80E8DaMi7Dgi9+uo7GDToK0OQ++nrmZM6
 XZYFu8No3ZnnDR3dpOUju1sAOaZCnn+Tu73AqvuBJmiabSpbrO2k7T5RLIgpLR0aEKt5oRC4i
 4emJzgVs8lLyZJY/LjWMHraZTcTS4pZww7jBl1DLOXtlN+mxWeEJ0x0deyH8SAY+ZjLkl4rEP
 Rw4WAWMy77+qUoWDb79xurw9oqOVP8rEWD4/9NCIzpZ//Jk8EFFaFFW0IbEHQwdv+ezvg+X5x
 jc4kPLuuMSpd/E94wd3e8FdRTErdjtaunV70arGJKx6j3zzlKU0Mre2J6voR70Zd8Ab/OwSDi
 xPbwH3KGf+FwQUL14+NIoK/GSkOg9FB0CFOwV+2S5cUpe7uRuO6ZJdFMMmk7ED/RaX2xHcsIY
 BGioZ4n3t9x8jSUTGR1AWMhv3nKFVUdhwhQMFYt9xWnIP+BhnPcbH0rYCzx77QRNpqxO9fznm
 9sUGlz7WzjYqlXmLqE9hggrVqHlNU65er/5l5YV3poCd86/TpB8i6qd3EPGbkGmRqMqW00FAs
 YuewyqJeGHl0tk=
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
KTsKLS0gCjIuMzUuMQoK
