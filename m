Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2A44C6159
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 03:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbiB1Clc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 21:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbiB1Ck6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 21:40:58 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD3A6D84C;
        Sun, 27 Feb 2022 18:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646015993;
        bh=TpdW3ujSzU0TXKj+hjSJqItA5IWaO0lajrfotqHvNTE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=SHDpFx/t87YD4N39Vn0qmonme2X2chHIAI7X3OefweS/IUkys5tCyBcHo7Td1Lv7v
         8L+mKBznQMuaBoBuDtrf4Nuqxi5yDdtCt5jJgVYzMG9mWinpHOQbCBb/hEmb65u1xV
         jZ6CS6XQaXj7nlhKdn94u+MPeC3k9hRRsihy9jBM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([149.172.237.68]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mg6Zq-1nqglD2Osw-00hbbS; Mon, 28
 Feb 2022 03:39:53 +0100
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
Subject: [PATCH v4 4/9] serial: sc16is7xx: remove redundant check in rs485_config
Date:   Mon, 28 Feb 2022 03:39:23 +0100
Message-Id: <20220228023928.1067-5-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220228023928.1067-1-LinoSanfilippo@gmx.de>
References: <20220228023928.1067-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:oSVWg5rBCqpWa6pMX1jUqajlxQKq82aAt/AFQNSu3Xr1YF5rLO9
 gIRovRZ9arcEguHqRVmFa3sxRXd6jVcPN07+t4pnm2iAQK+CpO+iRq9oIssAlL98vv+w0Pa
 x0WkPFDbMq2uF4t1IG+E98MuZpzZJYyVNe1FdI38bQMUme4ePfskpdr9xmdBh3Z/S3kxt/Y
 A4UthJuyuD4JeA4DkJvWw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:46l4yZiWaho=:rgAJEltv7CEBl925Gvl0Ze
 1Fq0F86+Azyy+VB5eCzIfVhub8QX2MJqWr/D2X5AXXjZkiLpn4FV1fnsr0pAv+yDc91HPlL9Y
 nqZWCNMiNfyelGzNfyIqwc760ISN9pBZv0JLt77KXDYnP6dzwiGE0wfowNzkHcQapWKUbxwy8
 YUckouXi++aouCIoCRZCwZUp3HWmcQp8lNprg1ixTNCqbtBNAxfPa+ndFTHzaHScYZTrogD3X
 yQT4Yw/KHM8+2v8o0SjZ5FxLgP2b1FQkN/RXvz1jCKYEfB/YMFTVmsAaOsnQeIND0ce5vPoFE
 r9ND3ZgBMNAed3kDr53GDHvvMwJqHx8LOKlfggds7Inm08/vIrEa/vx8i/EzoygAXs7uUW0kF
 Wssz4AbeXclEQYj5ebrInEzC6UdZEqhilOatkUQPyvLgDTHxQ4fuzRpEMIHp4XNK6N/t174MH
 Cn93zISM7GPL5+lgcdO5hmr+L0rEtSMU6DgieP2no/XuXiAwDHmYXOZqKNNDpV0AMMBTjg/IK
 6jYKzcXlGhsCLWkWbAHkvuu1mgYMKLjg/J5BLWZNt7QwWcaIphn6R5jZeTnYfCHK+ULZ1jhH8
 f4pmlH20WmnlD0jBrpzX15U4imbKzFAh+BhIeNpxAzy5A25APWDtFQNrEuYokC12cj1Au8J/3
 6WHhJI81t6aNVLLWtvD5LOzubHNrvzOXo3rSxyiYTcLTvbPlMXjvdBAlfzIi5PZYsIA3J/0XU
 Zp/uE/Au+tMn8rnrQ6SEUIbdY3yckErUWQTPIm60ZxQpF3P8eGTgyngam4OtdaA9PN4njY+5O
 so5BT5310JJoe3R49rHyEXTepsUreB2uKm8sKkaU9o/7KpQkgLOBnCsTrXhPirHSmQtf+j3dv
 fIfD4Ye/9gGYqE0qOBjm3edIfRSi5yVevTNkFdvkqAyMip81Op8bcfwCXsy3X6j0FDHNGXs6+
 I7kjs+7gIReooFF0KZwm5xgYWYpq3aMe1XiwMDyGaNyJku4Vh3HJeQ3wryzSK7JZ8vRd11c94
 GwoqbsymVyx4KbVM1fyuywBSP2sBYkxznP0SvCT0MoNmctMlvnZ95TlsGhLyW2geBCOa1e3Gw
 +J2WXUMF8vHeyA=
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
ZHJpdmVycy90dHkvc2VyaWFsL3NjMTZpczd4eC5jCmluZGV4IGI3YTJkYjljMDNlMi4uYjRlNjZh
MzIyYTU4IDEwMDY0NAotLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvc2MxNmlzN3h4LmMKKysrIGIv
ZHJpdmVycy90dHkvc2VyaWFsL3NjMTZpczd4eC5jCkBAIC05ODMsMTYgKzk4Myw2IEBAIHN0YXRp
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
