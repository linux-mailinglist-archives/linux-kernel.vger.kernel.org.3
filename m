Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1AC14B3E16
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 23:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238674AbiBMWeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 17:34:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238648AbiBMWd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 17:33:58 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DBB54BC0;
        Sun, 13 Feb 2022 14:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644791630;
        bh=u821ZeufKC1vgSSd268mPpvvDOICAs/3gToqbHdVQwA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=i3JLcOLWJn6l60EJJH1jUovqFSb44GojvwcFQmCoZyNEs0iR3u2s+rJRev45pgaf4
         i8i38xuopBeWyA7tp5EU7o7431159IblEl9uAv+YY0iRxYcelK8kX3qlepuaPOdnVg
         eqDizKdrS9S9A8wm/SbNkvUDz5dl4hb4VvQUVveU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([149.172.237.68]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5wLT-1nLsS52Jel-007R7i; Sun, 13
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
Subject: [PATCH 3/9] serial: stm32: remove redundant code in rs485_config
Date:   Sun, 13 Feb 2022 23:27:31 +0100
Message-Id: <20220213222737.15709-4-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220213222737.15709-1-LinoSanfilippo@gmx.de>
References: <20220213222737.15709-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:sRdxeSRpCIAmn+my6vWuOVRB84leThgA0NX64DL3hpPO+tdh91W
 TkrXZLeAshkj2yoQmJj3uD2KRkZruMzX/KMtxlhgSTzxJltILw8O9ZQgFpHE2zqSjLW0fkw
 1ZyhFd3k5xZEyeR9yC3h5LyinJdGCylV7yxXMLp8PyYNL2srQU+aiwHqhzDOZ/XVFnf8YNw
 Y/9rDt6YIDtM28DRYlWsg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:P+htqvP/0bk=:Mjgx7eHObxIB7CmQ+hSXs/
 sQpS090clZh4qOdXkRDfuvBbfdEYK2a8PmIqZI/YZB+USFxzieaH8OZ9FV3Xr8GoR0GBoKCON
 ek2NxzlTpcCSTeg9msCGHVhR42k5kBwqNvDUU+6LiwhsrjqBZaQFvzcyttFhWu+0RMVFpPPlN
 I/I4IXc2yt/nefTYEm7uvwNyg5tsSGSXVuG/Dq+Yeowm94gX598AO26ZKlU6afG4xUE0sx7SG
 v6yBrgQdPCroocKfjEmGvLbYXe9yI2/cAFzGywu5uUTsaPvXGGwWLVO/RlIPhW0gAWSh4Mijx
 TCksHkAFMrj8oKxghZkTahZ+1TH6DvBXRuhhMfsXmprxpnjrbYHRDSdG1dWEdvSlSxOypBKEa
 c+VccwOX2riuwMr5WVE739DFKnpIbUxyaDketErRV87e6kJ6kkthaTYFOgAM4GODv9/I7Ua6W
 g6sIsrDZ4M64MgUDiZ+/jChz8Y+tITjIHrSJt9ZryYWUSk+7l8n4QUQvoZN1yZ6KL1C+fcegj
 A+FjmUfzUC9A7xetklHTlcz1lPWr9b63kbkYiBJS2HAzWJdg+V17PwWKb8tecu6cBnGibPV0E
 uab6t2ycxnYkglO1Kg64Hc7BLPXK6Ck1QoR0Aioo5pz0MWyKJJbLQy5H/sy4eBz0jFzODxJId
 re024dGmE4yyka5LeL7uczrNr+wmjSwwUV1e9IDLCHzDnmK4vSy55pLUcLDy/YSOGlgLhiylK
 +7hYmnXzY+9G8WqUGhS7EifiY9DMbPUXT/JM5pIcZ/lsyoqcJZGCaFsbWILSn3HR0nbumrwDO
 7h/7+hGR9w87vGQZwjHinsYd64RKHZ2WtZ+VEBwVKuD02xj8WdVOf0o3+Njt8B1ygdpoWBiDS
 C/98VBjbYnWOekVdZDeAIHEWi2hnFzm9V+aeX9sc+RwSMCcVKORjuDr1Gs0a1qK1c+OHSGYH7
 xbzygAGEPFNc7QDedzF+4rxYGXmJ2uSZwSNcAuHwUzAkKtGaCi7x6M+kS4eeTquIGl+Gyh270
 9wqt1yHIVVd/J6KJXEQ5Ex5ufVtfQuytK2zBMNRS1xfpCuJTUGbutdzUYf1s424jUB6dyB+US
 aevS3JgSD+ZYB4=
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
ZWFkeSBlbnN1cmVzIHZhbGlkClJUUyBzZXR0aW5ncyBhbmQgYXNzaWducyB0aGUgY29uZmlndXJh
dGlvbiB0byB0aGUgdWFydCBwb3J0LiBTbyByZW1vdmUKdGhlc2UgdGFza3MgZnJvbSB0aGUgY29k
ZSBvZiB0aGUgZHJpdmVycyBjb25maWdfcnM0ODUgZnVuY3Rpb24gdG8gYXZvaWQKcmVkdW5kYW5j
eS4KClNpZ25lZC1vZmYtYnk6IExpbm8gU2FuZmlsaXBwbyA8TGlub1NhbmZpbGlwcG9AZ214LmRl
PgotLS0KIGRyaXZlcnMvdHR5L3NlcmlhbC9zdG0zMi11c2FydC5jIHwgOSArKy0tLS0tLS0KIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy90dHkvc2VyaWFsL3N0bTMyLXVzYXJ0LmMgYi9kcml2ZXJzL3R0eS9zZXJpYWwv
c3RtMzItdXNhcnQuYwppbmRleCAxYjNhNjExYWMzOWUuLjZhMDE0MTY4MTAyYyAxMDA2NDQKLS0t
IGEvZHJpdmVycy90dHkvc2VyaWFsL3N0bTMyLXVzYXJ0LmMKKysrIGIvZHJpdmVycy90dHkvc2Vy
aWFsL3N0bTMyLXVzYXJ0LmMKQEAgLTEwNyw4ICsxMDcsNiBAQCBzdGF0aWMgaW50IHN0bTMyX3Vz
YXJ0X2NvbmZpZ19yczQ4NShzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0LAogCiAJc3RtMzJfdXNhcnRf
Y2xyX2JpdHMocG9ydCwgb2ZzLT5jcjEsIEJJVChjZmctPnVhcnRfZW5hYmxlX2JpdCkpOwogCi0J
cG9ydC0+cnM0ODUgPSAqcnM0ODVjb25mOwotCiAJcnM0ODVjb25mLT5mbGFncyB8PSBTRVJfUlM0
ODVfUlhfRFVSSU5HX1RYOwogCiAJaWYgKHJzNDg1Y29uZi0+ZmxhZ3MgJiBTRVJfUlM0ODVfRU5B
QkxFRCkgewpAQCAtMTI4LDEzICsxMjYsMTAgQEAgc3RhdGljIGludCBzdG0zMl91c2FydF9jb25m
aWdfcnM0ODUoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCwKIAkJCQkJICAgICByczQ4NWNvbmYtPmRl
bGF5X3J0c19hZnRlcl9zZW5kLAogCQkJCQkgICAgIGJhdWQpOwogCi0JCWlmIChyczQ4NWNvbmYt
PmZsYWdzICYgU0VSX1JTNDg1X1JUU19PTl9TRU5EKSB7CisJCWlmIChyczQ4NWNvbmYtPmZsYWdz
ICYgU0VSX1JTNDg1X1JUU19PTl9TRU5EKQogCQkJY3IzICY9IH5VU0FSVF9DUjNfREVQOwotCQkJ
cnM0ODVjb25mLT5mbGFncyAmPSB+U0VSX1JTNDg1X1JUU19BRlRFUl9TRU5EOwotCQl9IGVsc2Ug
eworCQllbHNlCiAJCQljcjMgfD0gVVNBUlRfQ1IzX0RFUDsKLQkJCXJzNDg1Y29uZi0+ZmxhZ3Mg
fD0gU0VSX1JTNDg1X1JUU19BRlRFUl9TRU5EOwotCQl9CiAKIAkJd3JpdGVsX3JlbGF4ZWQoY3Iz
LCBwb3J0LT5tZW1iYXNlICsgb2ZzLT5jcjMpOwogCQl3cml0ZWxfcmVsYXhlZChjcjEsIHBvcnQt
Pm1lbWJhc2UgKyBvZnMtPmNyMSk7Ci0tIAoyLjM0LjEKCg==
