Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51DF656CF8A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 17:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiGJPDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 11:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJPDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 11:03:52 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB78664C9;
        Sun, 10 Jul 2022 08:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657465411;
        bh=+fmYvZVXamDwJB1kParFdNMn3bLBWfn1dkqM/yC5mIQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=f9oarPSz50faR9fqgIqFdwEidGXgoWiiLKWRC8ZULN3yoLiaufw6nG5kbt+oUY5my
         ernFkTEptbd0oqiSAuky8iZkJ6Qjh86ns1mtZcbN/XELLhzUfBH8NTExnKhkXY/xmf
         oE/9MejjkU+jrQl8GsTTUCTPNPl+TKpFruPAZYH4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([46.223.3.243]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M4s4r-1oBNoa1hUV-001xh4; Sun, 10 Jul 2022 17:03:31 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     ilpo.jarvinen@linux.intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH v3 5/8] serial: core: sanitize RS485 delays read from device tree
Date:   Sun, 10 Jul 2022 17:03:19 +0200
Message-Id: <20220710150322.2846170-6-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220710150322.2846170-1-LinoSanfilippo@gmx.de>
References: <20220710150322.2846170-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:2ZsPcOiZ5Mc/6S7zDjUbGiEU3WBBNjfP8QdAjZZG7E/rqnT/FJa
 vIYzeakLH3ICKvf5VHkJEPkjnoYSn66Pi0rvxgOUtCRfjSzmukj4YcewZSbPIckLL7BDzqB
 AN3HuyAfZF7sVMCnW0EOVrYsyswLNxDj7HxMkgRtovGkKvRmcsEQwY9FrOf/60baCc7sWRz
 N8Vq7yJeJ+2A/TpWYwrQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6j6GiID7VR0=:p7QB+QX/zyq23lxlxhIM3Z
 RIg6TG4+oAUUv1saM4BNFwtW93qiPJkDIU10hl8XkFKiBF9qNcPPHywvBSeI4jxpGMxt+UQ5o
 Ha2Z1qD1FTtercN0Npu8BJTJ9Fns2/uYDEiYxip5b3qCDw5Z05T0p6ruyHcoZjRZWBZEqcOos
 PiliK6ncvMDJCJ1MaqYTdGZr9X9pwCe4vPXe+Ilwp0/PQDhLyht3vAbZc8V5Jd1Uxr6DegM4+
 Ox6o8CKYAXPtcEasa+GxhvPnnqwxaEi7n4YuAoBRliG8cLlSTqqk40gMaCvujkg61os6PPLrU
 NxR6dPA/aF81TtKrSZmMcRH6G0i4tvJavlZBohGLdAVmRlWvpeoZJHv0wXV7awQJQT1sFvotY
 NSUrOBpf/TiaSZsF0b/afdGaaN5g5CTIFwhacgfoTiDJ6EPY5Y1V6+FJLEzl0qqhnIrnVgo8b
 LNa8CG4aHbFfHta6NRVL6/7NNxP8n/UZzz6pj/GfLRqe/rq5jE1gKaGh7AsNUmgQZAcqmdtVX
 ANIXU8Mt8pkPiIcxk5prLHw2Kn9GYN69p5q+kLlfSmIg6x/skPXZQDInjZJJQYfaDSLeoWsMd
 72Qh82yMJEExhLIT7nkW1xwpYWkWFNcvMNQvWWMXTXXq+ALBBI5VqC16lXkD6/VyBiG1c1Mod
 iNmYvwhf7jZ1ekH8JhEDJKJ4WtLYZxTkTP/OL9eKk5ZPS2M4jc2tga+MOVEAQ3Q/KPLDZFEYV
 ZCgOGwM34r4u4dLvkVJIAvv4KvZYrExz9Se+QTIQyuwNdG2KCgl9dLMcQ0E54Z7833OF0addm
 +HZ+unJ3aBN4JwK0bbNyWdiVJeKOFuQtJg4cYUgMlMixszlj7QyWOI/hWw97ecSkz2s9g5moR
 IF1BZ8Bz4C3RnpPbShCN2ITZdf4XbEPtdzpLN+EtbWyw/xHfRJdWgTdfrdkC7MOBbtwpGUQv3
 EHz477JHLFq9991NlTGBWBpD0nsV/S7Z5IjD/0eIdAo++v/vBU+JI7d8G9oCXzXRRGLf/ceKt
 jy43ZKwSWX/FvD9ZpfQzKIcKf7PejunyIniEwWMwMhuwH22VnNG0o29v7VHqSQ5voVHWRkLo0
 QsGYqT7FG3ROLCNFyUAzuWjl50V6qTEGzJhXrQtzDYVl7F/FvOwC1yY9g==
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCkN1cnJlbnRs
eSB0aGUgUlRTIGRlbGF5cyBzZXQgdmlhIGRldmljZSB0cmVlIGFyZSBub3QgY2xhbXBlZCB0byBh
IG1heGltdW0KdmFsdWUgYWx0aG91Z2ggdGhlIGRldmljZSB0cmVlIGJpbmRpbmdzIGRvY3VtZW50
YXRpb24gZm9yIFJTNDg1IGNsYWltcyB0aGF0Cm9ubHkgYSBtYXhpbXVtIG9mIDEwMDAgbXNlY3Mg
aXMgYWxsb3dlZC4KClNvIGNsYW1wIHRoZSB2YWx1ZXMgdG8gYXZvaWQgYXJiaXRyYXJ5IGhpZ2gg
ZGVsYXkgc2V0dGluZ3MuIEhvd2V2ZXIgY2xhbXAKdGhlIHZhbHVlcyB0byAxMDAgaW5zdGVhZCBv
ZiAxMDAwIG1zZWNzIHRvIGJlIGNvbnNpc3RlbnQgd2hpY2ggdGhlIG1heGltdW0KdGhhdCBpcyBh
bGxvd2VkIHdoZW4gc2V0dGluZyB0aGUgZGVsYXlzIGZyb20gdXNlcnNwYWNlIHZpYSB0aGUgVUFS
VCBpb2N0bApUSU9DU1JTNDg1LgoKU2lnbmVkLW9mZi1ieTogTGlubyBTYW5maWxpcHBvIDxsLnNh
bmZpbGlwcG9Aa3VuYnVzLmNvbT4KLS0tCiBkcml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUu
YyB8IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUuYyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9zZXJp
YWxfY29yZS5jCmluZGV4IDU5NDNjYjM1NTU2Zi4uMmM0ZDUyYjM3NTk2IDEwMDY0NAotLS0gYS9k
cml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUuYworKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwv
c2VyaWFsX2NvcmUuYwpAQCAtMzM5NSw2ICszMzk1LDggQEAgaW50IHVhcnRfZ2V0X3JzNDg1X21v
ZGUoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCkKIAkJcnM0ODVjb25mLT5kZWxheV9ydHNfYWZ0ZXJf
c2VuZCA9IDA7CiAJfQogCisJdWFydF9zYW5pdGl6ZV9zZXJpYWxfcnM0ODVfZGVsYXlzKHBvcnQs
IHJzNDg1Y29uZik7CisKIAkvKgogCSAqIENsZWFyIGZ1bGwtZHVwbGV4IGFuZCBlbmFibGVkIGZs
YWdzLCBzZXQgUlRTIHBvbGFyaXR5IHRvIGFjdGl2ZSBoaWdoCiAJICogdG8gZ2V0IHRvIGEgZGVm
aW5lZCBzdGF0ZSB3aXRoIHRoZSBmb2xsb3dpbmcgcHJvcGVydGllczoKLS0gCjIuMjUuMQoK
