Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED43D4BEF16
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 02:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238347AbiBVBQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 20:16:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238063AbiBVBQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 20:16:03 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D2B2558B;
        Mon, 21 Feb 2022 17:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645492509;
        bh=q9DO7/fg2xOZjFdAWb9ykKHQwvph2xk9kVhhmi9Mufs=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Vcz55CeNnKecxWsY+LSbi5KyAgYWgOUaC+5bzPg02gy6zvnVqvpKeiH5u60J0AOXk
         PBjuPunYbsTgBiqT0LVTPpOdZ3LWPBvZLg2zeTqIdg89iUX7lVXaK9A8tAibNkNTDJ
         oUKy8y/xQzO0smKEl2ZsHp2X1IIPlNNLatRLRhjQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([149.172.237.68]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdefD-1nvvZM0rVh-00ZhnZ; Tue, 22
 Feb 2022 02:15:09 +0100
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
Subject: [PATCH v3 4/9] serial: sc16is7xx: remove redundant check in rs485_config
Date:   Tue, 22 Feb 2022 02:14:28 +0100
Message-Id: <20220222011433.8761-5-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220222011433.8761-1-LinoSanfilippo@gmx.de>
References: <20220222011433.8761-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:tIxe3R5aj/xYwDMk5u7jQ2OEUfwHp37Mnn4DCv39EdTF+0G+o5M
 pLpdSq4pgFPgrfW4xSi751av18e2KtauIOlv7UXbD/fDH1JN/jTwkEzNbs4iOWcvdgwDnwJ
 RLIhXw87ndd1GoRidcjfIYjEJer3zgfvim4JrDSLBi6iqMDAOv5LfrgMU0sfbI0rCOz3IZJ
 ENvjOnwU/p70MF415thaw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Bk6LWvT7BT4=:BslbZxIX6vuRNgXN3BK4wz
 GLwX5BTmDqY+375EAHBAkqyFRY8SCNG3HQIv/DIycN56bToaVt3oKr/H96sdfNoh/KNEVrL5u
 o9YN2HZPIPcaABkeSgPrh09qpRVJVgPDZsQJV+ZpsIvmKX9E2UJqdtyA5r1+5BJam9w0zjDKC
 0wAEm8nw0Yl6wURxRD4yJ/PiABUMrOS6G5Ap1Rud6HDX7URdOxV/FU5sykaswCEfEIzl88DMa
 9vipAjrnxx6aIAQpOG6vDG+kNQ0enb5Bzkt1oK3mL3o4iDRMum7uLb4BJZqQDZKY++5k0mAjt
 KfSfjnM7HrdukJQPz8Y72R2wysxLE+/AHPdjqSrJPH9Uuf4pFRoye4upP1tGSwdbsXO9+PyzF
 1E7TA76PwnAN2WgIWtqPmIdooE0g7vz4dUYNAVvhWZf90rPIvHgEFpF6LGVgjgaW62iu7g/Bx
 eaCaIBDpTfK/HZddEmoIAsgRP1xrhdxQY+Oky0w9O9UyeyAfYOz0PPavz9wkiOLHshhLB7YMp
 w2UfoKnP+EZkLSBsd15Z+o9dzY0OnL5KJsrCOjl7XbKeWLaOa7jghJka6+7KJmrkO6g8AX3cC
 zQDcDWoZwYBJnqMuFlbc5aVjnfEPlzhHEGaLZuYyrM8p5izrwHd8CBSOVDGc7krQxre2Mj6Ye
 MTQV/TWSMS6NzV2JtVmZghVYrivo4ovqy/tsM284SdIJpXsXgjIvdbahrmAZ1cSJHHAAqN0lG
 8zWJSMvu24AU2lQYS4SgOdohZGqh2gaIsM2jZ+J9ckeTymMSB2kF/g7xjbAOD3FAqy+LETPCh
 WsV7YJwHuy55+eUHcApoxtS2EScjRfX8P/0Befgqnm/lS2XDhPdZDp1wGLBpEJMfgz8N7Bct1
 WxI35vzXE4c7XFW7okDJ+WwM6UQ7yUQFRP3nkkJtLY0hgRERYt2S3QpL3GIwlrdMRSaff0vTe
 CvN0mUWtWzS9VtC95tphM9nXhsvv/cFne7y5oI7JKCyk1kZRGyM8iK2ocYlme0A5yDgzg6Z5V
 EkAXVwtcRoytlbZ/Ww/RDtkAHM55nIaglzmaD5a8KsNtmROG4DUj0YNt0LrJzTWuNol+4IJGY
 LkJ3VDMGqDk7i0=
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
ZHJpdmVycy90dHkvc2VyaWFsL3NjMTZpczd4eC5jCmluZGV4IDY0ZTdlNmM4MTQ1Zi4uNzMwZjY5
N2JiNTE3IDEwMDY0NAotLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvc2MxNmlzN3h4LmMKKysrIGIv
ZHJpdmVycy90dHkvc2VyaWFsL3NjMTZpczd4eC5jCkBAIC05NTksMTYgKzk1OSw2IEBAIHN0YXRp
YyBpbnQgc2MxNmlzN3h4X2NvbmZpZ19yczQ4NShzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0LAogCXN0
cnVjdCBzYzE2aXM3eHhfb25lICpvbmUgPSB0b19zYzE2aXM3eHhfb25lKHBvcnQsIHBvcnQpOwog
CiAJaWYgKHJzNDg1LT5mbGFncyAmIFNFUl9SUzQ4NV9FTkFCTEVEKSB7Ci0JCWJvb2wgcnRzX2R1
cmluZ19yeCwgcnRzX2R1cmluZ190eDsKLQotCQlydHNfZHVyaW5nX3J4ID0gcnM0ODUtPmZsYWdz
ICYgU0VSX1JTNDg1X1JUU19BRlRFUl9TRU5EOwotCQlydHNfZHVyaW5nX3R4ID0gcnM0ODUtPmZs
YWdzICYgU0VSX1JTNDg1X1JUU19PTl9TRU5EOwotCi0JCWlmIChydHNfZHVyaW5nX3J4ID09IHJ0
c19kdXJpbmdfdHgpCi0JCQlkZXZfZXJyKHBvcnQtPmRldiwKLQkJCQkidW5zdXBwb3J0ZWQgUlRT
IHNpZ25hbGxpbmcgb25fc2VuZDolZCBhZnRlcl9zZW5kOiVkIC0gZXhhY3RseSBvbmUgb2YgUlM0
ODUgUlRTIGZsYWdzIHNob3VsZCBiZSBzZXRcbiIsCi0JCQkJcnRzX2R1cmluZ190eCwgcnRzX2R1
cmluZ19yeCk7Ci0KIAkJLyoKIAkJICogUlRTIHNpZ25hbCBpcyBoYW5kbGVkIGJ5IEhXLCBpdCdz
IHRpbWluZyBjYW4ndCBiZSBpbmZsdWVuY2VkLgogCQkgKiBIb3dldmVyLCBpdCdzIHNvbWV0aW1l
cyB1c2VmdWwgdG8gZGVsYXkgVFggZXZlbiB3aXRob3V0IFJUUwotLSAKMi4zNS4xCgo=
