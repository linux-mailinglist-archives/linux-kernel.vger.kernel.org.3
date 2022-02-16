Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977704B7BC5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 01:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245016AbiBPATd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 19:19:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244905AbiBPATS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 19:19:18 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60F4DBD16;
        Tue, 15 Feb 2022 16:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644970720;
        bh=E1/0CBI/y0oOFG0DQ494qpBejRTp/bZTNYxnMsztVd4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=HFuvYcE+MNBWLyomC9FoyVS8iZUVIA35FCPft3kbzOo7mqNpUDxddkaVfQFrxzahc
         XcqQoyg8Aw7TdmwDv0P3gj5REk0YX1ZDscHiKZlJdyO0Ji1Z6TE427uYdE/1us5j8x
         U25SVBYNGbWsdWnabJtsuv5WWoyma4qcZqvFBIW4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([149.172.237.68]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLi8g-1nbesa23oe-00HcxP; Wed, 16
 Feb 2022 01:18:40 +0100
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
Subject: [PATCH 2 3/9] serial: stm32: remove redundant code in rs485_config
Date:   Wed, 16 Feb 2022 01:17:57 +0100
Message-Id: <20220216001803.637-4-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220216001803.637-1-LinoSanfilippo@gmx.de>
References: <20220216001803.637-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:ku9v7EnP2t/0qx1Mhz0lYhcdypUi6rPN81qUlh3w+IMTDfVfTYJ
 qfgUGSK0OQK1tkFHimlY4MVxFZ717ykdkF+hFTcFmLeCgAPbBisXiyEdjPJu88V3L164Zg7
 3LypsFm/mDYGL1DPVUM+aB9399sL+hw7OeFLyRjuELWN7s/VUZB/rEQsMi1mrH5zr0yOU/R
 1RFl5kWCs/RafZsW3lfQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Hvhhztwvj6c=:d3BfR6Ur2uikuPq3XCa6Hc
 uj5wIAomeaMd5dZKOwUL0p4kXoFvYzOrCkorvi8qY20gQJ8D1V5GT0FvQSnJbjMlN5J+UwX2z
 51aGxYnHiukt3+IZ7TC7xorPKvcVF7bWrMF+q2CGIbpangB3blN9xUVmlxOF+McAkQ+va8ZxW
 lebuoS4nEL6brGlQEFhUIfxPdkRT8JUgNQN0gokAmTQo7/P4DqMesHdmr/HeUJFmgV+YT0ZKg
 rq3bI01rU9Bpjf9yrgjRfhrW4WyevnpJA84XLyqmdTjcdjQdLRqRGNkdO+6vDpM1CRwDF16jg
 SQ1wjKbf1ByPJcdAS1KE7lO1g3yVeZxfkbzVuqLngRueImhEnyLEcYL+ACCwfTYFLAiUtQgkB
 VZ2A0M5dXaJp87EFvo58JAoXM9EDDhyzKOAa+vskP9kZ6YqdRJ6JnjbJq8R5jp9cjwqMjXL7u
 Hi+MYuezfMfQoCHoiPxrGGfmvcXc+/FQYngM05REAmwK/mYrF8ENzLYNGNytTmXxFklexXnJU
 bjtmrMNuuwhVS8r70AFdoJBrVRIqj/46q6c+bqKQLAy4s/KTneNnFHAwqDvXsRi4RbgQIYCD6
 2w9+9Yy2NADjsfGE1q4aWJPwVXtCQjWcKrmmB01bS9rgt5/5HdV3jvMi/CeCEgVv48w/HI2ca
 2eOoM1Cqx4RpJUC2D0AbWX9P1MkCcSbW3BGG6TO+/rrpuvyt49zJXATB5x71eIc6a0brWCMn3
 eKR/bcaZH+YsVCQE9VL9/8AgQ9IbccBR5KJiJP23K6qHDt70UcgP6mujekMm+Hn5rpF3Q3l/G
 5C6EE+Hk2z79G8Jg8FzOLh8FE1E4YH6noAcAuBXPDiwmx5ANPJmdPHUHzChQhtZpYbTWG0BFb
 4Sm8zZ8voxi+moabEzyywg8y/u42vjZrPWLnJVx4KwahA7uEQvPZUHumh23WwZo3vMd2PSbqd
 15XP0hawAEd0UV3eJWAgkqEwxIvtT/RRpCcm1QxECLH/S819AMRht677NjjhAU64EBryQiG3j
 84CVJxd0EF8oZv2L3CJHFl9u7ykWf3cf+Gv/JmG6SmDWWV4JA9ewMe11GxghaeC3+qnzk/MaN
 fQYREPQj60EShg=
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
IHBvcnQtPm1lbWJhc2UgKyBvZnMtPmNyMSk7Ci0tIAoyLjM0LjEKCg==
