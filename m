Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDD24B3E17
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 23:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238705AbiBMWeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 17:34:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238652AbiBMWd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 17:33:58 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192705468F;
        Sun, 13 Feb 2022 14:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644791630;
        bh=bZh7fD3BxcL0U4ga7XTlAYTEC0EPT7y619IUOjTzv7Y=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=fJ2J1ZE0XlMRdlW52TUFV8Rls4Wt+oe23eSYWj7DXJWajS3kefqY7OCtnrdOilFc7
         +T37tZ8LTjRw72zk+aSv3KVno7C/iOCRieNKqGQ84DjZPXdaPjR6KYIBReP1lx6OSn
         BVRc9RvsMGN77rACYFoIg6aiL+c+u2qWoXGV4770=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([149.172.237.68]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N9Mtg-1oORt22z8W-015L7F; Sun, 13
 Feb 2022 23:28:05 +0100
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
Subject: [PATCH 1/9] serial: core: move RS485 configuration tasks from drivers into core
Date:   Sun, 13 Feb 2022 23:27:29 +0100
Message-Id: <20220213222737.15709-2-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220213222737.15709-1-LinoSanfilippo@gmx.de>
References: <20220213222737.15709-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:a70uNS3aT4SFE/6OuZPcmU57hS9z6lw3Arpt/2q+1Rn1DqngY4I
 cqop7d/eCjPhLHz9sZAYXp8ibRRdjqeKMEGk6i8ckZI+xCeYiAixStK8vfEAdAWCt5bZW84
 pGb79r9pJC9KWgmT7d2YGAKs5egMFgBpJUZOpsIxXRwVf4VSjo2bXW3br64Ayb/nGyae5pI
 kWJYGVzKhf3TfZQ3c5gGQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WISNCh6R/yA=:sVlZs0DWuHUGARQn/S3+aK
 zd59Brdk98FRPHtjNCIj67dB3yZj9E5b+LYZhLTpVVm0twqHHmcruORuTyLEZEEIRRfPbSSbW
 ZgqggRyclent0AWivDhkySKXNprFXcyH3sjtEBrcigV1Lmz26t8gT4qcdZSc0lZcJcMuaTqgQ
 TCjjF2z/7nkqoIG36h5kCM1pVZD46mRahcDLQemzyQT3r9ReH6XAk6YuFmz/kGZ7aDIkBgnlK
 HS6Ojs9BRDudMNxxIxF/yDHaqrRndvwVaqULS5tRHNbdlfG9SbXd8tHGevNhezmL4Jtq+22x+
 Dtdb8txG5ry5CPfofYwKG+LGlN1R6/KiJ6EgeMDhhswThOVX6F7+LhOmUFSDJedLpU7IaxpJH
 HdLqydKblOr5ZACttW1UnusNsgc5Gnr80DtWXT49puMknGy6iCRksJZEWyqyhAnYX5wAPYSq4
 RyacO4M4BMjQXvYBBRDajYH7U7nd7VAlSYqlsl80iKFwAiaf+s1VFA0sfawi9xQPMeFvkCAti
 kt4UvBK7tM1t8MlR+9OZtik7l40ThCct043pcnXvAq2WpN+og438rjTrUYrmqGtq8VGLLcR8H
 Qg4HjdVwTdEgwiZVzITuneRLiNaVPRcEKDXu54DVxBi3SxZsXrtb2e79Lo1KXQdnIZ4UT/x8p
 BhuYIgllQmuBRgcIGcCbvZiwyjEiDaSZT3IiavF8R6RDxfvHUrfihiO4I8jDCSc/JU1f+XFXf
 6Fnhy6JJTGgVL1v6FMMAHDvUAJTBJAm8weKDLboi2GFitZa1Zyc/X/fCwrIyJJvkFBJ+iB+4e
 nbfKOvPuyXTLdoP+9NouO4eysr9Y4gNIOU97iYqsLA7rna1Y+m+0/yTgQ8KIPclkVBVB6fdUN
 aLSDn/P0xP9X/g/kE3ach3bLknEpqGm37qAba4/7DADSUErhSDtOLAjjLehqaNiOASPsDGBl4
 Q+TOG+WUz7dVNdm1BbOtuwtVyZSDxdk6IgLfFhoEL3cjlMaH59anz4lqxik39gcDMlDvoJl3l
 f/meXFdtKSzjdPzHC5rM8JVDEwdSoM6/LQicSYaQu3oNCJEvL6ph5lP0xusLD6BBW09KGKxTo
 jUS2wR4UmLz2wo=
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U2V2ZXJhbCBkcml2ZXJzIHRoYXQgc3VwcG9ydCBzZXR0aW5nIHRoZSBSUzQ4NSBjb25maWd1cmF0
aW9uIHZpYSB1c2Vyc3BhY2UKaW1wbGVtZW50IG9uIG9yIG1vcmUgb2YgdGhlIGZvbGxvd2luZyB0
YXNrczoKCi0gaW4gY2FzZSBvZiBhbiBpbnZhbGlkIFJUUyBjb25maWd1cmF0aW9uIChib3RoIFJU
UyBhZnRlciBzZW5kIGFuZCBSVFMgb24KICBzZW5kIHNldCBvciBib3RoIHVuc2V0KSBmYWxsIGJh
Y2sgdG8gZW5hYmxlIFJUUyBvbiBzZW5kIGFuZCBkaXNhYmxlIFJUUwogIGFmdGVyIHNlbmQKCi0g
bnVsbGlmeSB0aGUgcGFkZGluZyBmaWVsZCBvZiB0aGUgcmV0dXJuZWQgc2VyaWFsX3JzNDg1IHN0
cnVjdAoKLSBjb3B5IHRoZSBjb25maWd1cmF0aW9uIGludG8gdGhlIHVhcnQgcG9ydCBzdHJ1Y3QK
Ci0gbGltaXQgUlRTIGRlbGF5cyB0byAxMDAgbXMKCk1vdmUgdGhlc2UgdGFza3MgaW50byB0aGUg
c2VyaWFsIGNvcmUgdG8gbWFrZSB0aGVtIGdlbmVyaWMgYW5kIHRvIHByb3ZpZGUKYSBjb25zaXN0
ZW50IGJlaGV2aW91ciBhbW9uZyBhbGwgZHJpdmVycy4KClNpZ25lZC1vZmYtYnk6IExpbm8gU2Fu
ZmlsaXBwbyA8TGlub1NhbmZpbGlwcG9AZ214LmRlPgotLS0KIGRyaXZlcnMvdHR5L3NlcmlhbC9z
ZXJpYWxfY29yZS5jIHwgMTMgKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDEzIGluc2Vy
dGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUuYyBi
L2RyaXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxfY29yZS5jCmluZGV4IDg0NjE5MmE3YjRiZi4uM2Zh
YjQwNzAzNTljIDEwMDY0NAotLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUuYwor
KysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUuYwpAQCAtMTI4Miw4ICsxMjgyLDIx
IEBAIHN0YXRpYyBpbnQgdWFydF9zZXRfcnM0ODVfY29uZmlnKHN0cnVjdCB1YXJ0X3BvcnQgKnBv
cnQsCiAJaWYgKGNvcHlfZnJvbV91c2VyKCZyczQ4NSwgcnM0ODVfdXNlciwgc2l6ZW9mKCpyczQ4
NV91c2VyKSkpCiAJCXJldHVybiAtRUZBVUxUOwogCisJLyogcGljayBzYW5lIHNldHRpbmdzIGlm
IHRoZSB1c2VyIGhhc24ndCAqLworCWlmICghKHJzNDg1LmZsYWdzICYgU0VSX1JTNDg1X1JUU19P
Tl9TRU5EKSA9PQorCSAgICAhKHJzNDg1LmZsYWdzICYgU0VSX1JTNDg1X1JUU19BRlRFUl9TRU5E
KSkgeworCQlyczQ4NS5mbGFncyB8PSBTRVJfUlM0ODVfUlRTX09OX1NFTkQ7CisJCXJzNDg1LmZs
YWdzICY9IH5TRVJfUlM0ODVfUlRTX0FGVEVSX1NFTkQ7CisJfQorCS8qIGNsYW1wIHRoZSBkZWxh
eXMgdG8gWzAsIDEwMG1zXSAqLworCXJzNDg1LmRlbGF5X3J0c19iZWZvcmVfc2VuZCA9IG1pbihy
czQ4NS5kZWxheV9ydHNfYmVmb3JlX3NlbmQsIDEwMFUpOworCXJzNDg1LmRlbGF5X3J0c19hZnRl
cl9zZW5kID0gbWluKHJzNDg1LmRlbGF5X3J0c19hZnRlcl9zZW5kLCAxMDBVKTsKKwltZW1zZXQo
cnM0ODUucGFkZGluZywgMCwgc2l6ZW9mKHJzNDg1LnBhZGRpbmcpKTsKKwogCXNwaW5fbG9ja19p
cnFzYXZlKCZwb3J0LT5sb2NrLCBmbGFncyk7CiAJcmV0ID0gcG9ydC0+cnM0ODVfY29uZmlnKHBv
cnQsICZyczQ4NSk7CisJaWYgKCFyZXQpCisJCXBvcnQtPnJzNDg1ID0gcnM0ODU7CiAJc3Bpbl91
bmxvY2tfaXJxcmVzdG9yZSgmcG9ydC0+bG9jaywgZmxhZ3MpOwogCWlmIChyZXQpCiAJCXJldHVy
biByZXQ7CgpiYXNlLWNvbW1pdDogYWQzMGQxMDhhNTEzNWFmNTg0ZmY0N2Y1ZmY4MWJlOTcxYjZj
MjZmMQotLSAKMi4zNC4xCgo=
