Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CA34C6151
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 03:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbiB1ClW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 21:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbiB1Ck6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 21:40:58 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE576E2AA;
        Sun, 27 Feb 2022 18:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646015990;
        bh=V/wGp+G2pTyXDb4+jdBY8qODO5TCY8jft6x/5fyt1MI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=MuHRnmktUX1JB7Kzq2uXcT/BLonc7pPkW1eropMd8wlVp5ZsGsh6+w4rgOzShZYNU
         ach0CN12vdx8sVc/3mu0oZyJxLuBYLxM9RYvhQwwOUy5zDArvttWGvj8B05AWL4Vt8
         9nnZXE1jEw8cDZLWGVqesTQDL5083pjTbToTltCQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([149.172.237.68]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQvD5-1nbUDx1ry3-00O1Tz; Mon, 28
 Feb 2022 03:39:50 +0100
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
        p.rosenberger@kunbus.com
Subject: Move RS485 implementation from drivers to serial core (v4)
Date:   Mon, 28 Feb 2022 03:39:19 +0100
Message-Id: <20220228023928.1067-1-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:Fd0ako0QTKO8TY2IaGJzF0tKjpC3R3VaGpiLtXqHh6ESVFhyIJ3
 vdEnDEx9TLif8A1pKe5zI2v+rp460XCuRZQ33h1Jr0Ouf1RLt25hWh8aUqd05470v5qZRqb
 llyQCTDfG5m3IK4T9tI1GrnQltF56Am4n3S/WMAC/hxWGmrwBiuyCkSC6HkaumeB2DuFJ5H
 Xh1CGOoapemzcPa0LHD9w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YIy7rX8/a/A=:EFNEH3QlzSe5A3O9XR6qYL
 WpKiT8W8rIvZ7HGI500FaIh6yMRxj07sgI2WzsNW9P5jeFYopkmY/VwMTSPQVnKPSL3DnyNn+
 IbIUZfsd1uG6iYAAV9TXlHWio0vBSl8M3YXsRxpWYmmSrLIi9emyiuJkhewzXsOpcwW9fvU9X
 qH8GszlmTaMX3fZMQdJAsKlMXHR57YqqVcfKwxUuX/sGwwe5TG4VKDM5tOK/nmn1J5rj+vZyn
 vg7MzHoZX2ceWPvBEPRgc5eTBBcimVUN0njogtU3udj3VQJOf0r9qLMYYJLMemkbh9BXk0Rzs
 iBogRNB4USr5QmwGpbmSN4MudUZ5gvX2w/CUWS22AcqocqR5C51IepzzYa3JTVjMmHVzhSUda
 +QbPaSARKSWT5AkgLhdba1G5GE2+rUKmZobTKyeszWMmJVSAlWEhs7pixy6J14dEpC5T3xxE0
 lnZVRmE5VfB6RtxXUOm/UY09GK8B52yg4GHoAlcDqtdqMCOnJDNquXcgwMBYXq29rBT676Oy8
 P+tlKHQBNmpSDc2IzmxlBIQzikX2jbjw3m3Qj9CIQlDgEcSw1UkLHDOjiEV3dl3ED4sHCKfWm
 X1K8M/8i4nN0N4Hkc20ihbSyDhBzNSmxFv7E4BbW5hzcbZnqK5nCieZgeIRsTx2aTWjbcOHq8
 7RbPdeYzXSVWRrfr453PdXahsjkPqPPRA3CGn7ovoRCZbOWSbSM/CevplCuJPcheaHN8FXGE5
 ZcvYkv3LizNPId3Q/Muk3fOoN1WO31O1VgHgOux2ttHP4ZOb/Y0+1qm87C20eq26rHXEwPwpu
 3kokKiiu0+2SQmvB68CJreoOlK6Brmv6yaubvCjZfggLpNxVxBvYkuqAPwxdWKb5XCFUCHu7g
 fKCaKgNeBwPrlMGpUht1bFu0SgIIFAyiOAwk7hU/fpSXzUnPKltV9/Ubj2uo39IKx/wDr5xLD
 Jy87Dx+EPKc9pDhYrwuUupX44vmLNgrnf7yVfe3+JLikbzMzoHZY0Phnd+12kSipYfRFoK1UA
 SzefRACCzuAsKXL4AYbnDDMLh/jVxK2ebplBvL8KiLToYEsuFKMLEdqQDgnHNth3sQj8EkJp+
 p04qCeNe2e2FDQ=
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBzZXJpZXMgaXMgYW4gYXR0ZW1wdCB0byBzaW1wbGlmeSByczQ4NSBpbXBsZW1l
bnRhdGlvbiBpbiBkcml2ZXJzCmJ5IG1vdmluZyB0aGUgZm9sbG93aW5nIHRhc2tzIG91dCBvZiB0
aGUgZHJpdmVycyBpbnRvIHRoZSBzZXJpYWwgY29yZToKCi0gZW5zdXJlIHNhbmUgUlRTIHNldHRp
bmdzOiBpbiBjYXNlIG9mIGFuIGludmFsaWQgY29uZmlndXJhdGlvbiAoYm90aCBSVFMKICBhZnRl
ciBzZW5kIGFuZCBSVFMgb24gc2VuZCBzZXQgb3IgYm90aCB1bnNldCkgZW5hYmxlIFJUUyBvbiBz
ZW5kIGFuZAogIGRpc2FibGUgUlRTIGFmdGVyIHNlbmQKCi0gbnVsbGlmeSB0aGUgcGFkZGluZyBm
aWVsZCBvZiB0aGUgc2VyaWFsX3JzNDg1IHN0cnVjdCBiZWZvcmUgaXQgaXMKICByZXR1cm5lZCB0
byB1c2Vyc3BhY2UKCi0gY29weSB0aGUgY29uZmlndXJhdGlvbiBzdG9yZWQgaW4gdGhlIHNlcmlh
bF9yczQ4NSBzdHJ1Y3QgdG8gdGhlIHBvcnQKICBjb25maWd1cmF0aW9uIGlmIHNldHRpbmcgdGhl
IGNvbmZpZ3VyYXRpb24gaW4gdGhlIGRyaXZlciB3YXMgc3VjY2Vzc2Z1bGwKCi0gbGltaXQgdGhl
IFJUUyBkZWxheSB0byAxMDBtcwoKClJlZHVuZGFudCBjb2RlIGhhcyBiZWVuIHJlbW92ZWQgZnJv
bSB0aGUgZm9sbG93aW5nIGRyaXZlcnMgZm9yIG5vdzoKCi0gYXRtZWwKLSBmc2xfbHB1YXJ0Ci0g
YW1iYQotIGlteAotIG1heDMxMHgKLSBvbWFwLXNlcmlhbAotIHNjMTZpczd4eAotIHN0bTMyLXVz
YXJ0CgpUaGUgY29kZSBoYXMgYmVlbiB0ZXN0ZWQgd2l0aCB0aGUgYW1iYSBwbDAxMSBkcml2ZXIu
IFRoaXMgc2VyaWVzIGFwcGxpZXMKYWdhaW5zdCBHcmVncyB0dHktdGVzdGluZyBicmFuY2guCgpD
aGFuZ2VzIGluIHYyOgotIHVzZSBhIG1ha3JvIGZvciBtYXggUlRTIGRlbGF5cyBhbmQgY29tbWVu
dCBpdCAoYXMgcmVxdWVzdGVkIGJ5IEppcmkpCi0gYWRkIGEgY29tbWVudCBjb25jZXJuaW5nIHRo
ZSBtZW1zZXQgb2YgYSBzdHJ1Y3R1cmVzIHBhZGRpbmcgZmllbGQgLSBjb3JyZWN0CiAgdHlwb3Mg
aW4gdGhlIGNvbW1pdCBtZXNzYWdlIChmb3VuZCBieSBVd2UpIAotIHJlcGhyYXNlIGFsbCBjb21t
aXQgbWVzc2FnZXMgdG8gbWFrZSBtb3JlIGNsZWFyIHRoYXQgZnVuY3Rpb24KICB1YXJ0X3NldF9y
czQ4NV9jb25maWcoKSBoYXMgYmVlbiBleHRlbmRlZCBieSBjaGVja3MgYW5kIG90aGVyIGZ1bmN0
aW9uYWxpdGllcwogIChhcyByZXF1ZXN0ZWQgYnkgVXdlKQoKQ2hhbmdlcyBpbiB2MzoKLSBhZGQg
d2FybmluZyBtZXNzYWdlcyBpZiB0aGUgc2VyaWFsIGNvcmUgY29ycmVjdHMgUlM0ODUgdmFsdWVz
IChhcyByZXF1ZXN0ZWQgYnkKICBMdWthcyBXdW5uZXIpCi0gZG9udCBleHBvc2UgdGhlIG1hY3Jv
IGZvciBtYXggUlRTIGRlbGF5cyB0byB1c2Vyc3BhY2UgKGFzIHJlcXVlc3RlZCBieSBHcmVnKQoK
Q2hhbmdlcyBpbiB2NDoKLSB1c2UgcmF0ZWxpbWl0IHdhcm5pbmcgbWVzc2FnZXMgYW5kIGFsc28g
cHJpbnQgZGV2aWNlLCB1YXJ0IHBvcnQgbmFtZSBhbmQgbGluZQogIChhcyByZXF1ZXN0ZWQgYnkg
SmlyaSkKCgo=
