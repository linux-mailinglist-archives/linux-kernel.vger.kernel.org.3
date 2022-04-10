Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA36D4FAD6D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 12:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237321AbiDJKua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 06:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237178AbiDJKty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 06:49:54 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E1B5370B;
        Sun, 10 Apr 2022 03:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649587635;
        bh=Z6/2/nnSkxxUcKhu74YF466O1KxzujfZbQWyYubnQSY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Sn1ycp2W/rpoPkZ8SxAeRsGs9vBrWbT1C/lgveHldaY1JkrIA9KdIOV4lwj5JrXB9
         2F7yqA0G6ENJ2gNOitGBiTG9NQ114nCR774Lsbs4cYaKm4BY5oYM6bCw0xKerAk2bn
         BvbxGc9VWsp4CHtkB8YS+DjjFKClP7DTnkUw6Qyg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([46.223.3.230]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQv8n-1nINLJ3Tvj-00O0ft; Sun, 10
 Apr 2022 12:47:14 +0200
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
Subject: Move RS485 implementation from drivers to serial core (v4 RESEND)
Date:   Sun, 10 Apr 2022 12:46:33 +0200
Message-Id: <20220410104642.32195-1-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:HJBFMAK0JfWk5nA9U+NMWUeXctqAt8MuD7XqHlVkkV6Ko0mfc+q
 lElLK5n5asHe+7ROnK1JHV5CVPKuim3JlnzNqB6Nu36ttILYZwNOxSHUJdq3/99qblix4Qz
 5mB6k2pV3zjSmMqPaetu9SZ5SbPEbhyWo1m2bwcjYYqK9dtZ5Enm3EZL0DkrTNLDYvnBcGR
 qqM8AdlS8wBS3SxhinfOQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eLGG9ig2nu4=:gxkZ+kk7aI2LDrthqRIqik
 Qg4DJndisPKmEbQW+aveyUBzhZ6MeOrCcTXSd6qegI9k6a0nGgMxGYj4kUIkPVjQ/KqDAws2s
 gnC+L1qoGQK+YMv78fbNAy4JWpUxgPQH8kymPw+XkKGTAsfaXi1eyiwNw3KqHhvLKF2vMzLwe
 GIII+Cn7rq9nRgF8Ilj/BacguUcP9UbhYS4EkLRGcWj6RwAChFKZiZkfkIgQilWwSJZnwQeLT
 k4Kha6iykeP80dsExaGCuXLrrZ1UX0cF2z8JQuVXSpRfqwtfzlpatZJ0qRF6YkQBV9LPZcBuf
 zExX8fNI0x6sMPYHFpyy5FAxTbQ37zij4RQWLj9unEVwlTcetOeH6ZH52ga2RC/Gdwp/wbCET
 8FrfCK6V26mBxujle+jU1DxRyo30eg2PgXAsTF+h5aWKpRDoTxWoz12jFs5dDIXVWON9yYJHp
 ORre2Bjxyl/wjjFdFZUM8mvgNsoypJJvmGi7lnHiA7aOK2wfM0x37SdPhHnWoS39j6/oSLeox
 gi8w2dD+Zjg+XlDLN+iFovzEXwB4yjd6qCYca6C3DpJYv2qXwvMmZWgvL8TO5XwDyH7RhP2KB
 FT9ccd96Lh4n72LRX+mYPT8bSUwzxAsX2MIVxNajvep4j0TzUI1HrGz7T0a+vrJTWstatH+hK
 ElszTX7cEp/fEIp/5Nw6OnjpPonkz/uucOR9ahfRqn0DWtOAo4FaX1hI/DuVMXWS0l2sdb7NK
 0breh6nEg3IPVXG0SvoG88d1EGJPo25P3LJaWNUJO+oYMM4Do1CMwWaAnBNUTitQcn5QENSDd
 Uekb1efbqpQNC2jnrSZ/yPGStYqXoQsxoxbzFgeLo4x/dYINwShQ+EnDuVFImBjwqv7J5H7I4
 fyB4SEsba6miyQkUifmNTIO6URR5HWOjNF4AdRML//ChfTdWa8ago9SkHHtSwNB1WAvGqaBst
 ubxGF3kf9lInl8JTbOhw+NsyoCVxH5qbvzzxygWdCdNrloza+bZCgsv2O+GJ+AjQKHpLQTlVy
 p9vtL1CKDLbz69gPtQdbezi0iVyBWBYMx+zta3kMU8N7H4yXHxGLbXm0mFy2otv3YpJqsA1y9
 ttzdSkt6qnAjcc=
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
SmlyaSkKCgoK
