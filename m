Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B454C6152
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 03:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbiB1ClT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 21:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbiB1ClH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 21:41:07 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98886E36A;
        Sun, 27 Feb 2022 18:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646015995;
        bh=iSIbiqQY+am1M73zZEjjrGJSzNxevmnnhXm36hRIfqw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=f6CP4unmD1KZ6N3RFfl8UvbOK2ln9OziJUJ24F+mj9VZ9nCuIc8mraxGLehVELvKf
         yklplZE/IoQHmUEMq56NkwrbP+0C6ZhdyAVOdkUlLN7Bo6FFPyCuWr777QIomqSKuQ
         6Rz5IoGASlXLfwJ/GyUcW+iZ2/XNOep/ky6pwQrk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([149.172.237.68]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7sDq-1nKeKX020A-004yWo; Mon, 28
 Feb 2022 03:39:55 +0100
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
Subject: [PATCH v4 6/9] serial: max310: remove redundant memset in rs485_config
Date:   Mon, 28 Feb 2022 03:39:25 +0100
Message-Id: <20220228023928.1067-7-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220228023928.1067-1-LinoSanfilippo@gmx.de>
References: <20220228023928.1067-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:UyxTOKZGWZ8nWvI2z/fzQ/YFBYocUp7YsypBgL9evAkOXKLDvLG
 jqIYO6zgCFPAOEYbCgIhAs3A3H7FnznWX/T/BescrY0+tQ3zgaJfbVj0wv+a3jJ7hUhmprd
 OD6EWw1ppf0YKRpLSfBN9X9yYNxjecYR2BAbmo2d5P4PnXyTsewWCoXpHXE4Hmts8sBD84q
 t4V4L9fgC5B8tfs42BLQg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k2oBVy4zoV4=:mwK/Xpc21jlTi3xDXhNs2k
 eqhAzjMrEQaaTinvJFPpT8+PG3BscULCtOOD2Q46zirOe2wo6XfuQP61Xx3lktvHDMplBWKmA
 89Bbigh9VGvMOLJPXZwGVJlXqKXIsewde0aglzDzEAvy+h2lic23Nzhjg8SlnLc/YScv5tjHz
 CcIzXvZ5wNWhnvNcyQIYCUL77vqCOWEIaQKruVurPFbxP7C5EiLXGMw67l4WvmEo2CavqZrjj
 1EZT9gqxbYqfqPdGxxOydReXgJJWLLLiRGVpB3r2+PoWjVSqMINHCzbzNDtLMC5jfBJkgN0zs
 bgCh67fbI/DRI2oxV32dJgZoJiPzlikQcktPkNnaU9Zj6ivDQRn/VORadsjBnsXqI7jTx2jY6
 4awBVAbJccqZm+Samr5Tloem4nb1ewNaO6enTJswzrAgETXv2sm0HZZAbLfX0EffpsDDlU2l3
 yflCFuLpd/Y4Xo/0l1F5llnA2zcsTMwFxrgqfZCvnxPqE6hGQbAc4xZKvorbVfwnHwJwaH8GV
 Sl1mntBp+aZGwIDUTR3+tDkGGZKgZvLpI+cbmsKVHpBQh/tCC7HzkwyWd1ODVBGuWEC5ZpH5N
 GsbJfWP1agNrRoxSbF5HvcUggtS/cJjDE1AZQllBD4n7GHYRIFj1tLQYFW2oLwicJjx3Q7Gdp
 7kLPRlqdFhivB4MbSTIYhMkE4gWdU7yINiWkIOxloQMIB7/d4nmLEnYdCsr9QN1CNX7VprmWi
 sTGYqnzfklFeqLedSZHOFF+A00A/W9q7UMvPizVDzAFmlcscKwSOlPrdzaGqpkmWYWuhgVwP0
 ANcRRw8fc+a2961XI8CTc56EUo8SzP/VPGnSo68DhmuL8KyHzrgmBOcwVEKXP5jJ6WYnR8bMh
 oglr6yhgaAx/rIw95OddFzEgtMshc6O7lUdGBvZzQB9ieeKEEuqBH/OmBp/CxcY4NchZZSd/U
 R5ud+PnMUobadXESaVlN6VKbdEGFAMlVYvp4ejTpwGPkUuOvDDAMPnJN3lTie/QpfN0RMKPxa
 3SssHCffvI+xYJOi6utjrhCMiPEKlRlLAyjq03DRf6WVS00OHS/NQRdXJEIbXuVI2M+P99dtV
 KWx/tkZ9TZjLXg=
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
