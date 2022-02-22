Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567814BEF09
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 02:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238233AbiBVBQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 20:16:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237123AbiBVBQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 20:16:02 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0817225585;
        Mon, 21 Feb 2022 17:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645492508;
        bh=iPI9Eyd+3C6S85WoH/RH9YiOHOKEC2bR9K+d8H8925A=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=jjT42f6heZiJwoGFdqhGVNEsThg3FASN9KHgvZ82tGkVa01YSvpMnI7qFnQoX0401
         d7c/u/kromWD/RY+B0UKGLmRhORjvzkJ4zs7exioVzkNWMO7NVWIdUnjffL/9FMWfP
         IbBJOINbX3DOuEXrkq8nH82EZTINm2KG7jOJwXbM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([149.172.237.68]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMGN2-1ndRTm0MWk-00JHRS; Tue, 22
 Feb 2022 02:15:08 +0100
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
Subject: [PATCH v3 3/9] serial: stm32: remove redundant code in rs485_config
Date:   Tue, 22 Feb 2022 02:14:27 +0100
Message-Id: <20220222011433.8761-4-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220222011433.8761-1-LinoSanfilippo@gmx.de>
References: <20220222011433.8761-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:Yr0zSx6AgYnin7QmZqOIPPMUBfNDEjL9oTFYL5o617rgkNvXuDB
 hlhQpzkCAQ+uDw+7QhFXeoWxgexLrBgiOLiyof+cafoviC/NV7CqNcO6MeEYhWkiopEYsuQ
 yqARWg2J5T9jbHbUp4UFulMt7F3NS1/U5wcUMZ42ctgEIAmWIfi6xPLQs807ORTkEqgtj57
 6wahqPtwNc2UuUgOIbi3g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CglKYrDvqsU=:yLxwhJW99Zwnj5ZRfhd/tF
 d3ykjhn+uHspulRZ9LdoSS8eRrQfXsW48Zqu5y7LbRHUjqtWsOJTZ7bcDHTCm5Z/feEBZmG9g
 QTTw+NBMyReQAVYfymSY/X2Nca3LTaUqurSolHvSkNpdq0V0H7bh8KcUuCSM3lVJlzgHW7WBX
 wrLBMIugfPyIiib7XyW8wPhSyGhjrQtbd5aBOJ+N7Ugxiw+nFHyreDFhM9FLTGckowPmch17X
 ndYBkaQCFuVU57Suo0xhitzaF7g91xr5W1VFzMuPQpiA4PEe/Uz0A1gp5743pfs7ozDjm9oU/
 5DYjjYj6xXk20vWVew2AmDTpXgfIfz6lFC4Yz0HnVJEQp4e38/kZ0rXrdxkCmP/Z9QoYxSp/v
 MXwe6KV69iKtBalllBMaLNGUfoWpNG0x8SullFMxnXAzG3iiMAo54EOiyCdEeZZZMRwywPr1j
 E27AKp0Dx+oKC2frvW2k3uJ35+2y9hqTmTMmezv7fLO2LuzRhwY8BAEQICZCCnSfAsvsIx0wM
 MDoUndbZ7ynHj7xhVZR71JyHpo2EHZbvPGo+kNwcrLJ/xgB83fK/sH8GH3hqpP8p8V7F/DFKr
 vhAZVH6T+s9sE/zoqmaoRsD2Pgr9fWAoaCRlH56tr6EFLQA+lR/yXZdVpgXUHVfBfiCwrYcKJ
 zj74IvsFO4AKWU9HE7IrMsh29j2SbsXMm7xGkN9A1ZSq3Y4kIRRGFt/aa+zkvhtwddehk5/Bk
 IHilBEYPe+qRnqW1ARDjUev7suh18E7xI/AJNKe7t3d/1MtgDKAv3MHvkcVzkpEwqtb+3crzZ
 R5mC50LfZnHm5k/dtbALO4DX2Cs1gfiin+nOcxQq1JIWROZcWBb2J9dOpjZAmIV/DCHiIugNB
 7PiOcvN71WsaUoOtVdE2MJcTZ9JXhrnl04/ojga6eMhCslBwjfCY7F50zFOetRLlrhGSNeOUO
 D+CdlP+aYvqypGXw7CGnIMJ8RdLNKEIOLrlTUxq6iYg6gEu8sDDQbY5K4z2pmSLZXzKtAxjKY
 9X0H1WXHKoSVcnQIJEo2Eiz6fZjohQqfClAxXADR2+e5N4jc0aDtVUh3ErcoAZwHLDfQZ315x
 X6diRwpdLWdmow=
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
IHBvcnQtPm1lbWJhc2UgKyBvZnMtPmNyMSk7Ci0tIAoyLjM1LjEKCg==
