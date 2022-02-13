Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246734B3E14
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 23:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238731AbiBMWeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 17:34:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238655AbiBMWd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 17:33:59 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E510054BCC;
        Sun, 13 Feb 2022 14:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644791631;
        bh=VMbcSuC7p0n3hqLa0/U0n6fD5g5ZwGHCadLUz5+JSTo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=hIVdW5vhiEyMbAguqVbYLBrYdLEbTQrtO9hfikEsDNCe/9jFaayRgeyi+mjT1Rkgu
         aHDTNgeVCa6+Jn5R5FsCIZfFSn12mDl1ysujtDwnihcvjNUahMcydHrhSbRTkahS4K
         SEkb6DTnONVin+IWNVVZWlyx9JITRMnKAoDWMSBY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([149.172.237.68]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MdNcG-1nsR3E0FLk-00ZMLp; Sun, 13
 Feb 2022 23:28:04 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux@armlinux.org.uk, richard.genoud@gmail.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, lukas@wunner.de
Subject: Move RS485 implementation from drivers to serial core
Date:   Sun, 13 Feb 2022 23:27:28 +0100
Message-Id: <20220213222737.15709-1-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:s913s5qBkaysiWGAuTn1tH4rldqCkA6d7se/P2ylN3mokt+xD8S
 sWBy0zVPYNQoU7I5IuAbAnIHu4ZJq6FAUSC/Ftgs5OCVQX3xWB1TqbbPkjC1JvtxaMcQeyK
 sWTz3APtcttuWfM0F5VNYEt24Mh3amfwKpEB0zF/GDX+C6U7t4EWr+BcLN4Ar+/BSCwR7FD
 5/u4lZj16gv24srLDYYKQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UYAkBzF9hKw=:c7uCz/ztwSm8AoFjDFHBHL
 awgehg2vgBWfOmxzGgaeNuJF82nznJFd4O7SC6HoDxCkOnxcp9zlB0odSkEulOZH4TYXEkOFr
 R/HycjEYE05LCHtv2jB12UZSzshFiQEe+FUQgwqNTyCqbbV0HerBV99SN3ZnBFc8UQjSdmqps
 nsGMDFXpC3xQIr8ICmge6tNhXGJkHSs2rAoMCmzaNDYjRAyVCKPZtsQ5F0sa2fpiza2Pcx1L8
 eEN8Fnzxz4xpOOXsY7OpuLryw1qbSmYJCiNeItKm5qlB0E9NxEKS5VwmhZjZ1lsg/Takbj4sj
 3fpR9Ur7s+DW0dl2F71pF74QYIwAplLxSw3/YkYxzapXIJ7wtJew6b/JKTGz0IpANQT3b2SJl
 7QfgdpoW38Nf9EdvJZgTq9UMu89ZcOXrWh18j2P+LFfka4Lb7HV65th8MqFkPPwmUFNA1bX7Q
 tB4L0faPQ3jm6j9n0PQ0ncJyHPuZ9odYhNhtQXAAXWH/xNdb9qkqld4d5m5VxKWGpxGptmn/S
 leYIfJ2rdzRfrrZfY+b5tnykZ5H229QZMWp6eJwseDUjIAixItj7R4eSbexpWgxgZlk6RlN+A
 3RygB2++K9udfRqgvRqKWF2vfmrHK6uQtf5JMoqkO1toiw45SR3Vkf4vG+F6PGOQsW+pHA0ld
 gGsNvFW1a553HYgZ2IYVOYFw0Bzha59ApYWl4mC+wfJyxMJJGtkqK57+wsSbwF60jL5T1YyX0
 /sYQ1MpvD7Z+YvlkBbxusakjxtDC648ra+nXR5YJ2O4Kl6ZClXgaclV8BFtXUzWlewL3mVd84
 wy5MnDEZQ+j8kCIPYErQQvcjcERcfsz/4FkkzYh0hFg4R1B+4aaf+/J0n+AAzAAOEsBWuXdms
 WGEZQ1vokquYhzVprNpWZo85XzdD1sc4RoBh/jH3DLQ7aWml94X2xNXSEg7Veg41leYBJqLoW
 REIO2x7qKBNX8i0i35ENxwia3axbeRQkAMRCTMwjI/VXfAz2PhABVe61nLmNB0XCuGlyFjo6S
 EpvvG5p2rY18aLu8GYzpoYHLHzRnfBxZC9I1XOVIAxGwQ2B7UA7lQTT5fo2WP7T6h915bCHsx
 w1RcqEvglNR+4g=
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
IFRoaXMgc2VyaWVzIGFwcGxpZXMKYWdhaW5zdCB0dHktdGVzdGluZy4KCgo=
