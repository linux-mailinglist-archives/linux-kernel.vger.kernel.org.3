Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCA84FAD6F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 12:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237791AbiDJKuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 06:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237207AbiDJKtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 06:49:55 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC46C5371E;
        Sun, 10 Apr 2022 03:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649587638;
        bh=MiPI5RKIJn/QCYR3f9zV844luaLp3IqrvICdIRruXKQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=YCE7m4uQyVmiOV393SJYDNtn5tRhOW8LWsWDHZkGI6aFSABKvQWtBAqGu9TrIyowS
         RcMR8OWpAZfI0V7wYypxgZKdWhfgnMVoZi3HdvUCE/4SnfedgId8adEVL7JwamHH9w
         1++Wc15lzFnWbW6JWmM5jVZj6tJEMho2XIiXA4vo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([46.223.3.230]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1wlv-1o6HHj2DeL-012KMt; Sun, 10
 Apr 2022 12:47:18 +0200
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
Subject: [PATCH v4 RESEND 6/9] serial: max310: remove redundant memset in rs485_config
Date:   Sun, 10 Apr 2022 12:46:39 +0200
Message-Id: <20220410104642.32195-7-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220410104642.32195-1-LinoSanfilippo@gmx.de>
References: <20220410104642.32195-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:r4lBTsfdu2dXPObxKTZw9/+yYZ5MEP6+WV8dRsHu8tb5Ck8lo1t
 JI3S6XRC0iGI/jRA1w5UE4ixYbc+u31owPilNMVoKAZrd1cwdDbeo/Ct4WoxVCmFln3EHZt
 Gthf1FPFW2fsK/jglPkgM7dKnNFhYQiffbhPebHZPMgNFQXFMqqbeQUi+2I1cUgos85MvbH
 T/5uY/4B+rxTDWCrU30lw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:INNgmzCAPqQ=:0S4SiF3Xwrb6/shF3UJJBC
 e3r9atNNylb5GkdA2xMdBPWrHZLUlW9GERV67ADaSshMxbmKJYTAtIbPGdb1ofl2rBXooVmzC
 sVERsD+5P9fIUOucep86CNF7qbPJTgmEGZFXi4PxKVP+Fa/GIMhsGZLH7m3a4EGIU3okiH9P0
 owdHZD6W31a44gBDZnu0yqi9xcosa7l+4sm7p9JoxePrg00vanE+V1j4SQ6z0UJeDvff7VVh8
 a9a6pd6OmCYEh2a7UglMX2TKHUxhZb1i/6SL7gIaqiHqgd2MUKR7GRTnvMeRasVxrr5H/OdoG
 OCacE9b1RPmjIw0VTzcH6F1Qo0WMyZFZ3tJE9aImsfwkZn+qvHhjCMeY9+TDlRn/wIVvgAl98
 dO7wihaA6yt/KsTNDJmzXKTmbpYzRhWL7gZeQ2v2HLxHMRvB9Hdx7Gfa2bvsdJ75T0d2mmD36
 0G6e/qlmjlGqac4PKftp/+SSnBpVEBfhdeBx+l78xPKPWjO2K3RPsPgUY7w1xOkXLobXuIq7o
 8jNlAjBDNffBzinjfRiwkLjYDynP6wSxJOF4JMzxGQmlo9sG21kyskeJ3WSFUnGyaiNoxvhte
 WKrc7PuKrvjTtRJXznUVkK+XAAtHQimJqT6zIMx4uc9iX41P5bPg3SOLO8qO8JXfb+QHP/GIl
 g7H5mae6M2kJau3wkj/gtePlq3ZkBmfxaoleY+0WF6y3bd7Sm05Iuuolls4f3O68tdGQMkpQu
 EYogtAOsOXjIXPwfc4xSbLuY8iemvuj9AOYvZElDIZotHbJ3n9s98Hidzfgk+Pe4kDu+iH/pJ
 wN8V3Gcrxr2byqAz8SgTZU1VP06C5F6ZVjakZ/anlJZGMKMHMOPETuB2hL7v32+v490KQnmzi
 GWLpxU1XOYkZP+ic0ZhMuqlNs94IABW66fO8GYDxir8bw3pnWq4CJVlt4eNCyyePby8rcpZHY
 qxsX9mzqGWMuFDBlR4mNr1EWXciDJNblmHkuO5m/MUgtX3mXmZTwxTfOgx5GNiPO2x07W2etY
 TCeqk3oCqOA4QKsaGjFrZlMcgn60FWcYHWzTX3QH+cj512yM+gLor1l7dJaYPrd0Wd21XfSNW
 VUJOclbCzVCgN8=
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
L21heDMxMHguYwppbmRleCAzMTEyYjRhMDU0NDguLmEwYjZlYTUyZDEzMyAxMDA2NDQKLS0tIGEv
ZHJpdmVycy90dHkvc2VyaWFsL21heDMxMHguYworKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvbWF4
MzEweC5jCkBAIC0xMDM3LDcgKzEwMzcsNiBAQCBzdGF0aWMgaW50IG1heDMxMHhfcnM0ODVfY29u
ZmlnKHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQsCiAKIAlyczQ4NS0+ZmxhZ3MgJj0gU0VSX1JTNDg1
X1JUU19PTl9TRU5EIHwgU0VSX1JTNDg1X1JYX0RVUklOR19UWCB8CiAJCQlTRVJfUlM0ODVfRU5B
QkxFRDsKLQltZW1zZXQocnM0ODUtPnBhZGRpbmcsIDAsIHNpemVvZihyczQ4NS0+cGFkZGluZykp
OwogCXBvcnQtPnJzNDg1ID0gKnJzNDg1OwogCiAJc2NoZWR1bGVfd29yaygmb25lLT5yc193b3Jr
KTsKLS0gCjIuMzUuMQoK
