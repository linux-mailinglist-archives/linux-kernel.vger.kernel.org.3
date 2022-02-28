Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D434C6148
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 03:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbiB1Ck5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 21:40:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiB1Ck4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 21:40:56 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B0F6D4F2;
        Sun, 27 Feb 2022 18:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646015993;
        bh=iPI9Eyd+3C6S85WoH/RH9YiOHOKEC2bR9K+d8H8925A=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=B2rz/X9piz6OIHopWLOnR1oRrBHZcoepl1hpJNpfcIm+OiUYTw6smz/pw8AB3R3/a
         r55CrB35v7qGgwzM5kYLiE1rHZxQea60z3wcibVZZ3LnzvtzuigJJDCWwCDOGLQ8LQ
         YSHdfcPMvqhgB8dKcOG5rvMJsaZIEFf+Kd8YvqXM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([149.172.237.68]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBUqF-1nUoGl3ZVv-00CxpP; Mon, 28
 Feb 2022 03:39:52 +0100
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
Subject: [PATCH v4 3/9] serial: stm32: remove redundant code in rs485_config
Date:   Mon, 28 Feb 2022 03:39:22 +0100
Message-Id: <20220228023928.1067-4-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220228023928.1067-1-LinoSanfilippo@gmx.de>
References: <20220228023928.1067-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:Lr8oCML/RhTrktKji37TkXyhwoDx/xbf6v8vFT7o7L2qTyz8hit
 oKCSc08BFqYzX5GwZKq9lLExSpUiQhfFLT5EOci7KGo+LUkxPUou2t97Lv1wM3WcyyGZvfV
 l/91l524sXYL8NTToK57V4ZpiG2plg+RpFsv2TQmMnQi6N3Ot+Q8I8o2Pe+YMZCVCowIlkM
 Kv3+qEqAJvy4CY8Y4w5SQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:93hJ3foLheM=:31mi6t4gTO0FiQ+HU+tJpE
 Y5ApMv+V91qhpjpM8p6XwWY6rnTyF8EV/1mzKd2814MgpsFsif1pFJjKjFk+KkAJJAplpgBEp
 gZZiIlt4+XUnXvlPIsPJfBG8rE9fFnt7T98iXi/fu7ZXViWpjKcrCJN1FoEw9vBimsADRnYJQ
 LDUAZFYgwnD/ger09u29aj9vdDTDOrvmagFKVcVLuM/maf+V/dlbfaj2LtfNtl/OW1oOC4yhs
 3JnhQuWhMXwMJx8OqGp1w3VoTeP/7gOAZx4FVr6vFLsAKW4rDVoOtOnbtxfu0ew7iHiWilZkZ
 hZvjVjNMnCi/ph2jpLFWfeLWdSzR/8eUvA9zd/f4xgaLY5BBFlC2fZZcPQlkIzbCAhKRAJFO8
 BsLpkvz3riLcRvOaAANXNpm6yZl2kVyS/yRn+pdsamctncHw2XiPuUnXJ2yYqmTvASfM1oARN
 G747mNJGaZ1gk0LHh6qfEyCeO6V0kNfdyWbIxEoMji0XKGBUHf9VDO+X8tx9FIC9Wg8cjT6uY
 04SQEdaBvFwlkKvpE1GiTFhSuxIpZAyeawhp9qblDu9BgxnbBTrKmUZQ3sI5wJ1j4HwtWSNPY
 4qTdaWsqwWwfHf53lJ2Xtpkg/SwiOtrBPduNftDUrUBlicJOYS+cENHI0aLnnKW4O0vg5EfNO
 zbw7Fzvuqq5hDrWiHWugKULxY1p1AjxOcFefgZ3E8y5HJUGrHOORueTYV9HFGpFiOECNBmBx3
 eHd2dqaMRv94ud9Nj16g26AqmOX4URVwKkdByV+ZT14Kw70V+AZamPfxx5zvaCTmCKAgn0Dqb
 KAAcaTrwxrNFg1BHB4BTBv7EeHLVWOtL8Ha+S9GYgjrg4z06ZwKklXkJKVAPiP7wE5juP2sOl
 bVcooI3JRAttvCFMfJKf0wlwXoL03kp4u2UMjWdVP/gHuKCxELS+XjB8OUtDZtP9eWWg3eISU
 M3xsOA9VELAYVOopFuLdXI+aCo7/qUmuDtUKBbIK8ZA8myTp/x9GeWw6YthWkjjqjTpMgxrE5
 kOcaCVY2Cl4g5w0cODFb8K3oB2Dxk5yeq0g5J2/M6ibtuT8YGpku9IyAnP5AM8CYa+ZOSi38n
 dq7QFOS27y3MB8=
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW4gdWFydF9zZXRfcnM0ODVfY29uZmlnKCkgdGhlIHNlcmlhbCBjb3JlIGFscmVhZHkgZW5zdXJl
cyB0aGF0IG9ubHkgb25lIG9mCmJvdGggb3B0aW9ucyBSVFMgb24gc2VuZCBvciBSVFMgYWZ0ZXIg
c2VuZCBpcyBzZXQuIEl0IGFsc28gYXNzaWducyB0aGUKcGFzc2VkIHNlcmlhbF9yczQ4NSBzdHJ1
Y3QgdG8gdGhlIHVhcnQgcG9ydC4KClNvIHJlbW92ZSB0aGUgY2hlY2sgYW5kIHRoZSBhc3NpZ25t
ZW50IGZyb20gdGhlIGRyaXZlcnMgcnM0ODVfY29uZmlnKCkKZnVuY3Rpb24gdG8gYXZvaWQgcmVk
dW5kYW5jeS4KClNpZ25lZC1vZmYtYnk6IExpbm8gU2FuZmlsaXBwbyA8TGlub1NhbmZpbGlwcG9A
Z214LmRlPgotLS0KIGRyaXZlcnMvdHR5L3NlcmlhbC9zdG0zMi11c2FydC5jIHwgOSArKy0tLS0t
LS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFsL3N0bTMyLXVzYXJ0LmMgYi9kcml2ZXJzL3R0eS9z
ZXJpYWwvc3RtMzItdXNhcnQuYwppbmRleCAxYjNhNjExYWMzOWUuLjZhMDE0MTY4MTAyYyAxMDA2
NDQKLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsL3N0bTMyLXVzYXJ0LmMKKysrIGIvZHJpdmVycy90
dHkvc2VyaWFsL3N0bTMyLXVzYXJ0LmMKQEAgLTEwNyw4ICsxMDcsNiBAQCBzdGF0aWMgaW50IHN0
bTMyX3VzYXJ0X2NvbmZpZ19yczQ4NShzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0LAogCiAJc3RtMzJf
dXNhcnRfY2xyX2JpdHMocG9ydCwgb2ZzLT5jcjEsIEJJVChjZmctPnVhcnRfZW5hYmxlX2JpdCkp
OwogCi0JcG9ydC0+cnM0ODUgPSAqcnM0ODVjb25mOwotCiAJcnM0ODVjb25mLT5mbGFncyB8PSBT
RVJfUlM0ODVfUlhfRFVSSU5HX1RYOwogCiAJaWYgKHJzNDg1Y29uZi0+ZmxhZ3MgJiBTRVJfUlM0
ODVfRU5BQkxFRCkgewpAQCAtMTI4LDEzICsxMjYsMTAgQEAgc3RhdGljIGludCBzdG0zMl91c2Fy
dF9jb25maWdfcnM0ODUoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCwKIAkJCQkJICAgICByczQ4NWNv
bmYtPmRlbGF5X3J0c19hZnRlcl9zZW5kLAogCQkJCQkgICAgIGJhdWQpOwogCi0JCWlmIChyczQ4
NWNvbmYtPmZsYWdzICYgU0VSX1JTNDg1X1JUU19PTl9TRU5EKSB7CisJCWlmIChyczQ4NWNvbmYt
PmZsYWdzICYgU0VSX1JTNDg1X1JUU19PTl9TRU5EKQogCQkJY3IzICY9IH5VU0FSVF9DUjNfREVQ
OwotCQkJcnM0ODVjb25mLT5mbGFncyAmPSB+U0VSX1JTNDg1X1JUU19BRlRFUl9TRU5EOwotCQl9
IGVsc2UgeworCQllbHNlCiAJCQljcjMgfD0gVVNBUlRfQ1IzX0RFUDsKLQkJCXJzNDg1Y29uZi0+
ZmxhZ3MgfD0gU0VSX1JTNDg1X1JUU19BRlRFUl9TRU5EOwotCQl9CiAKIAkJd3JpdGVsX3JlbGF4
ZWQoY3IzLCBwb3J0LT5tZW1iYXNlICsgb2ZzLT5jcjMpOwogCQl3cml0ZWxfcmVsYXhlZChjcjEs
IHBvcnQtPm1lbWJhc2UgKyBvZnMtPmNyMSk7Ci0tIAoyLjM1LjEKCg==
