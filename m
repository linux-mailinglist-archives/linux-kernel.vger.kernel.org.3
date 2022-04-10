Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD454FAD6B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 12:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237577AbiDJKuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 06:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237063AbiDJKty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 06:49:54 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A30532E9;
        Sun, 10 Apr 2022 03:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649587636;
        bh=lkxJVJmba/8nGWmkZt8VLyvvaLEgdx0YvxHumaFHroI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=jDJ18xjT48BEajopxGlSKFpbKHA+3XowB+XmZzxZFcGrtKYV+DeU5HXDpMRoHRX42
         cLWreO79tiZssHyxeMPMAroFC/+XLbP4/M8hi1wC6+hCfwB6LRydeDYYAIixkN4UZs
         kXYGtNLUfaO8odIMMfCgEVbBLVH7A0RrW8+t9iSU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([46.223.3.230]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgNcz-1oBAp12tBf-00ht0f; Sun, 10
 Apr 2022 12:47:16 +0200
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
Subject: [PATCH v4 RESEND 3/9] serial: stm32: remove redundant code in rs485_config
Date:   Sun, 10 Apr 2022 12:46:36 +0200
Message-Id: <20220410104642.32195-4-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220410104642.32195-1-LinoSanfilippo@gmx.de>
References: <20220410104642.32195-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:J+WiHeBDacS1zu76ddyWcxiEI6alS3VWYM45BJKJNo7Z/NgiA24
 DyRk1Uw03xCS1+EyxzLFhwIJvxVfnM4gZSu3Knb6AV5pD8INpqoi7V5Qo4ozq/QfqaJOU2u
 9r7lnpSUW1yU7ndR5t5x4kxpLAY1XjmTeUjKrZuudM3BowK/1EOsDHi+qyOx4JtpD0e2cpk
 lI8+ZMBM8TH7DSjhF86Qg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lVJiE9ZGsJ0=:+savRGCYH+KQc9hqcGVhtg
 Vrk90sQ5NgkPsCXZGCGz0jgUQeZUSYIjYEXboaKVGHuE5Q8vMvrbitNcGLrWUdMLsdu2sNVGu
 U9ER86HGerZxQeh3E/lr2JocJVZ4kg5MkuYUwltMPNIIxLaudPHFJ8IAK6xpUCITOfoYArjgu
 jwLf1dJ45as2eCwWwT5+l7Ut+1BPQ/MjtaAXwJFNhKnI8+RvkZSOXUvdnf5qd4uFrAL/kYzoC
 +AiUgiz6BEoYQ+j1J8wHbVm5+FmRmtqGsaNvhlPV7XU7stNMPH00UY7/pibFb0SClMFLlO/Kj
 0ZMK1rf+vdNskQlYO1cVou2AIJVfMgeduWqwZkle47XdbUjOWUdS0TgDRgsmL4Ct8zMKNAa7W
 ZojutqSPRMecJocT5m4dPKg7hiQqCrd5zfRMlV6gv9SZaYFHuN8VbwbHTKwJY5kgeY5yEzUnt
 s7g0n9I/mbvxCO9QzBk4eKiAyNAcBzl7t3b4I9P3ojzMgZb8u1Leo94dsN9U58QQchvZWJ/yq
 Kl7/fzWAF0FFJdMkLyM7q7RMLuoFH+096jJmFjxViQiewATL12CCv5ef7niYSMD0wQdMTGeVL
 ar4AwBVZ03ZVuKbewbu7qT4JN6w11vqZv/Rq0def/3hZexDm6AQCbyu/CQD1l2eBOPrbff4v0
 BRlJcufKDX8e1v7hNMeTnOclXLgfU7FWQJJUfIDDRUG/ZGi5X9JNfVeaW0xUysFPgQ8UPBjr1
 R15CUYqweeKTNrVvtf9NOS/7LuETIxp0JG/peM975vCXYNvzxf+laBKf2D9Q92+I9DBFX6oxW
 5NHsWclb8C5WYQCiKceMnTxTFCgTpILb/V1JbuM6WS79vqpPmKZnKGoBsny1nFDebja/vM6ZV
 V0mUQs976GRQzQC7XcC/NyfDdj2/azWhDmabHmdwMBEJ/OIpti4XNSSSmSJMX3MdDj0w/RloO
 SEBpLhFvfBrydzl71TvQpbSDs/L/tkytN4WVWD+iNX1GObHXHbEfpyAT4hI/XIQfD9bnwBDD/
 jHMlogCNG7Z7GAh2ymyReSg82VF4ssbfIzfaqcwUJW5vJrwm145AYhtAz6EaQiFsOqb6zsHP9
 O2+3XLkCPQmA+E=
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
ZXJpYWwvc3RtMzItdXNhcnQuYwppbmRleCA4N2I1Y2Q0Yzk3NDMuLmY4ODY5NzZkYWVmNiAxMDA2
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
