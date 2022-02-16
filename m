Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8BAB4B7BC2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 01:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245037AbiBPATk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 19:19:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244972AbiBPATS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 19:19:18 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B35DCE38;
        Tue, 15 Feb 2022 16:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644970721;
        bh=Tt2p+xBICfmPSy8m5S6zW8vENc8fwomto2cjA2t2EVo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=i/tKOBvLBEEFkFBYQ0nT9tO9nGYqtIz9t162BQLFhPkYdU3hK+cFr9Bo3PLPyDX6c
         5bIAvEF03nYIIvUH7eINBG878X7982n0brjw5LYMF8UveEW5IbbqEDazowMW3iu/Xq
         KGOSIM/FecwpSk3lFuPIjBfSI2ntkZO/2Vf9l12k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([149.172.237.68]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MF3DW-1nVBiD00Pg-00FVKl; Wed, 16
 Feb 2022 01:18:41 +0100
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
Subject: [PATCH 2 4/9] serial: sc16is7xx: remove redundant check in rs485_config
Date:   Wed, 16 Feb 2022 01:17:58 +0100
Message-Id: <20220216001803.637-5-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220216001803.637-1-LinoSanfilippo@gmx.de>
References: <20220216001803.637-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:EEaXsoGNJ4qUV1f9eq7vhlIcz4++hzNSBNP5W6lbbP2Yw6cQmbm
 tA87Jtta6/ZlyhZO9ogHIAF/n9pqVFOLp16HL+//jSckxHHVHYCCrcR77wyR01fS9pF0yY3
 krEZv5p0efq4nUIaQgbuVtYEItqqxTUyNFFX16maBiceUizax+8xYb8yLJzzVomeA3FI3Pq
 L5FDLGuDpZS2xLqih+2ew==
X-UI-Out-Filterresults: notjunk:1;V03:K0:l/iG3p3tGsM=:h/qmikgE8v2UxCaxs/kOE/
 R0yuOR4tZdltGDU1QPIJKb75yyQkBxuFPSZ0Fpsm12GQr2lUusfm/gWcRgjviurIRTMBrJlUe
 qGYuJcf30DLT4qCgg2g6ktC/qv0E6lhJzMd/1ikErW4d0uXgxS4XtWz1RXhzZLC6pmhfTJr3/
 HGpFB4N5o7b3oDZAKiSutSfh3B0m/7ZigkFp14J37S1b6Hg/R+WXqXfgTf6HbV+7enSge72IW
 vL0u6xv1ld17UHrweBdqz/b7yvQEjk1Cn/1EGYZxn1OySL3HZjFfl0PN6JUW0E2JgUuIUfK7N
 OETd7gW3J18ZKWXWUj/i+bbfVSp95FaOd858JiHtcjGfCIGoCDOd6ojA0YKaG/pLaFxxLxs5v
 wjJSPGyvXG95buWpCRbZ3PLThIzLytG9+pQ19B9/g9N8bkKPVuX5S9sZxlJFTL4mFr+ehxQSd
 evQvoJLkY9Jhs+a/ABTE7yA3Qr4l+oxU9ZcQijIqX9LcK07RdXXMbUerCeIKao91IjWV8Bs2d
 aq36BMefiwRAdWwD6XNPfeGkL6Zol62pKt6Nq0RFR5EQSxDMt2atHEp2ErNQ3TVFZZIeMPZDz
 r0UTNn8Q+HHBtYszbG33G+I+XDc7IMuLRnedGsWb8YPKPPujoRtYPDm4lLvZbpIlt26GLfSpe
 croDMY1Sbjle+Mn6z3NGsGj6oc0E7jlweKl6vjj/2LyxiDP1VEdpyzgNojvaq73v7Z6Nih1Pi
 xZbuIV9ba02MeLAHu/UW9vXCXXUP/hTdlqEPnh6KtNa3s47sXIrCzz+0+nmDLrEQvFRRJEe89
 2dyZGL8jYZypmZqrRAbzLZXbB03aLN2qgWWuQBMMetnOxd51nn/jjWTsMRsVOjH6vtC0k0Ay9
 wrhVOuSMc+Kt8QWEwL05ugkEKXyWk8cJvNcZ/pJsnHUwFGqih392OmbMbPPQvv27uG+xPBv2n
 4Spi5UoDvMjKrLJyaMSrDfWAkUMIGD+LTeWgkY+rDOuSa7fMo0fS0lnj9eXvgUmvSOWzHsj7Y
 SFB2VtQSQWCaIe06JgWJ+GJKU+Ts8/DiSTOZtpFTduwSDXqH0Fmq4W6gJvTLnHkNqn/0aAaIO
 kql0RB99FA4JN0=
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
cyB1c2VmdWwgdG8gZGVsYXkgVFggZXZlbiB3aXRob3V0IFJUUwotLSAKMi4zNC4xCgo=
