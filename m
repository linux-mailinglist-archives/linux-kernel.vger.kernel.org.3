Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B42D4B3E0F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 23:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238690AbiBMWeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 17:34:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238641AbiBMWd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 17:33:57 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAFF546B7;
        Sun, 13 Feb 2022 14:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644791629;
        bh=e4EzhSBd05ZEK5ajCopJGbJXFDfnsrEfcW+jvd6E+EY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=YxwTNWkLhFD03TT5KQxsIOnM0JLeOn4PRCCayDr7YnHyEZlDRAJpwIbswgGQTasW3
         qofz2TAe1ncgIlMRz5EWMvvsA7TNoDjjAQ8zeUlqSBLPFPNWGZCCx1f6nKeD0+7r0h
         bt4cwdEJx+CZfEwGMXEv1ypOYkQcUyStCXePIHWg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([149.172.237.68]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhD6g-1nxP7t2Zs2-00eI2N; Sun, 13
 Feb 2022 23:28:07 +0100
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
Subject: [PATCH 4/9] serial: sc16is7xx: remove redundant code in rs485_config
Date:   Sun, 13 Feb 2022 23:27:32 +0100
Message-Id: <20220213222737.15709-5-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220213222737.15709-1-LinoSanfilippo@gmx.de>
References: <20220213222737.15709-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:dCybVK/xN3+Sufq+aIz+9f9d8QRQ5K5pMV3gwc6qC9O0NCSdf1D
 cunb/0Yy49nK2WJiwnG/+2iYNACFAlKyWdWsfvp1naKMMsRuUqdzTZzl+xqlpHZPw3EmPHH
 cibXWxB0zOOjR1LwlupJz/gBg3u2f9jFJ6mj2wZ/7+fxaGmahcpW28UDocXGZCRFeRNrbCQ
 4yjiBCc3/e+QF/Ah5zyTA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/8qhBW/HGNs=:3NOa0RH3JyLBfCAaVitQ78
 srakgitfNsLlkOTwdZvSIhlA6qBJVExc2i6J+HJTQXSZ00+R6hBHLgIEjZ3b3JOGXLw7yIyDP
 z/dLWf6XMf9Xy/tgVwJWH0r43OamjCRnCY5s6gsUkOtQdZnE2EF/xuQEDTU8K8KH/63sb7bHg
 VvE8gPftT0XqE3wU6rI7lRWclM932FYJ+xVWpCDSQ+pFBJDLk/Fx4T62MTf7CwfPWLbTgQE3b
 8ycmQrzmHg3mvjWvQWOttwgJAI5FcdhF5VsOuDVxH2zaSE0DR056l8nKOEyfdaNW5V8qc55Vu
 +ZK3o4hNFCDti/nzXkX+aqh0XdAN1lanUK3rxGQAW9gscjYtSxbECIeYLNmht+k/ZDKMPWVxy
 jSDelmDv9Th6qVDrel4ZPV/Pu23oVd8Do1zTCehvJ2u+Z5Wv1wclXMIArEsm1A4aRchCvARZt
 Z2gOUxgGpXNyvgG+pjdEPI00MglHymbGWo/rdqAsKKItAYxUVeamYdgyPHPziR4DbUrIkjano
 kYMLqaYGnUcXmR1dNjfgRfLSv/WZzRU7D+diTdq6CYXfE0C4janJIiDJrarfqeswheioi2t5X
 VTPGvXRr51Sn6sP2MN76T09MuSeOlQauVqXw/AZkM58zB58i5nLnrkcgtFGZCWOTRzsR6BOv0
 AJyXSCVrBGbNYhNuyppLETMfdhNkAIGKpYeJk7TpOHs1xksm3d8d0tpAo83/DkWnGAem2xoZa
 53P6IVk6fq1pP+lS5wKSufHCmKDOoVLUQ8+UKCa7upjhuXnKYuPHeeCQrUncBEDPgVnMXv11U
 VoO3EBYBAfdD0yOK7e0zD8smvGHbd4rUvDMcgrWtQAdXCWuCAV7Zs1A56cYy5gpoBAk2CHD6M
 n+qIwuVE9GaSuosY5gK1CakukvSIgeXzKh/jf8y3sfaVanXy9ydXhvb18MNzw0Lci9x2nmlDR
 2OSmNZSiuZLpXr8nMZcQ/HNgWYKXqqUJKEBYv/ugC8s7C/oceyK2nlV/lDN+LPHstugZZe0I1
 Oqyl0UUYvuFanmA3mcrnAKCCjKY49OsjH/QMoRcQDQLWi5sZphn7s5qA4P0yhCLjPSHHoyFsC
 HM/vL9J+qwIFjU=
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
ZWFkeSBjaGVja3MgZm9yCnZhbGlkIFJUUyBzZXR0aW5ncy4gU28gcmVtb3ZlIHRoZSBjaGVjayBm
cm9tIHRoZSBpbXBsZW1lbnRhdGlvbiBvZiB0aGUKc2MxNmlzN3h4IGRyaXZlcnMgcnM0ODVfY29u
ZmlnIGZ1bmN0aW9uIHRvIGF2b2lkIHJlZHVuZGFuY3kuCgpTaWduZWQtb2ZmLWJ5OiBMaW5vIFNh
bmZpbGlwcG8gPExpbm9TYW5maWxpcHBvQGdteC5kZT4KLS0tCiBkcml2ZXJzL3R0eS9zZXJpYWwv
c2MxNmlzN3h4LmMgfCAxMCAtLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTAgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFsL3NjMTZpczd4eC5jIGIvZHJpdmVy
cy90dHkvc2VyaWFsL3NjMTZpczd4eC5jCmluZGV4IDY0ZTdlNmM4MTQ1Zi4uNzMwZjY5N2JiNTE3
IDEwMDY0NAotLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvc2MxNmlzN3h4LmMKKysrIGIvZHJpdmVy
cy90dHkvc2VyaWFsL3NjMTZpczd4eC5jCkBAIC05NTksMTYgKzk1OSw2IEBAIHN0YXRpYyBpbnQg
c2MxNmlzN3h4X2NvbmZpZ19yczQ4NShzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0LAogCXN0cnVjdCBz
YzE2aXM3eHhfb25lICpvbmUgPSB0b19zYzE2aXM3eHhfb25lKHBvcnQsIHBvcnQpOwogCiAJaWYg
KHJzNDg1LT5mbGFncyAmIFNFUl9SUzQ4NV9FTkFCTEVEKSB7Ci0JCWJvb2wgcnRzX2R1cmluZ19y
eCwgcnRzX2R1cmluZ190eDsKLQotCQlydHNfZHVyaW5nX3J4ID0gcnM0ODUtPmZsYWdzICYgU0VS
X1JTNDg1X1JUU19BRlRFUl9TRU5EOwotCQlydHNfZHVyaW5nX3R4ID0gcnM0ODUtPmZsYWdzICYg
U0VSX1JTNDg1X1JUU19PTl9TRU5EOwotCi0JCWlmIChydHNfZHVyaW5nX3J4ID09IHJ0c19kdXJp
bmdfdHgpCi0JCQlkZXZfZXJyKHBvcnQtPmRldiwKLQkJCQkidW5zdXBwb3J0ZWQgUlRTIHNpZ25h
bGxpbmcgb25fc2VuZDolZCBhZnRlcl9zZW5kOiVkIC0gZXhhY3RseSBvbmUgb2YgUlM0ODUgUlRT
IGZsYWdzIHNob3VsZCBiZSBzZXRcbiIsCi0JCQkJcnRzX2R1cmluZ190eCwgcnRzX2R1cmluZ19y
eCk7Ci0KIAkJLyoKIAkJICogUlRTIHNpZ25hbCBpcyBoYW5kbGVkIGJ5IEhXLCBpdCdzIHRpbWlu
ZyBjYW4ndCBiZSBpbmZsdWVuY2VkLgogCQkgKiBIb3dldmVyLCBpdCdzIHNvbWV0aW1lcyB1c2Vm
dWwgdG8gZGVsYXkgVFggZXZlbiB3aXRob3V0IFJUUwotLSAKMi4zNC4xCgo=
