Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED5C56D023
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 18:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiGJQpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 12:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiGJQpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 12:45:19 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7AA13E13;
        Sun, 10 Jul 2022 09:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657471497;
        bh=o+W8ytMepE42gQF0QexTyH8iX1o8DL+6k2p2ZnfEFk0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=JMIVFwwesErimfQUonJfmRcoSxOfdrl41iOeYkn1BO35NjjxibV44eIAl+tb1Y5bY
         LJuzI8zHM8jg9R4z0aodSebEWWHLeJrZk8XBaCzAJVJxtDoh64f9fr+b9VBrLflTdH
         dJkWplFgOKHx2InAIcKn0m1Jm2ILT4/4u5iVDg38=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([46.223.3.243]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MMGNC-1ntbQt1ba2-00JJtC; Sun, 10 Jul 2022 18:44:57 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     ilpo.jarvinen@linux.intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH v4 5/8] serial: core: sanitize RS485 delays read from device tree
Date:   Sun, 10 Jul 2022 18:44:39 +0200
Message-Id: <20220710164442.2958979-6-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220710164442.2958979-1-LinoSanfilippo@gmx.de>
References: <20220710164442.2958979-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:BmyX5I0qt+OesHVxffLQ/vKe7NwrSCOmcs5z8TkhMlNjqTio3Bg
 dJfSZy76tfO6/ooi+mv9cEpVLH/02a+wL9nR+oItjKClHXcbrg8mr8PiXXxtLjOyHG4Qf5l
 0NnfIwpYhzISa8MTQuKj4S3IwUTKH2eLM6S6FiIQnHsMg2/88jkKTdititWojJvdn36qsx9
 nBOLgWTbbAbxF71M5YAiw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ya4pN4diymI=:kl+/LelUjlM4BTT4Ugt+LO
 rKUM5oSNJeLUqW19kw36LgNFqbF85JGwHMo8cfxcGMJ2AGY92gz9hvLumPqy7PqkcB6uJ1RnM
 mGpDxTMqUDpD5MsmjliyF8HCuZyuHzXgN/oTK6qkauG25KTJrSBZu1ShGbwWJfBsW+rtGItC0
 STM+tphrmp0Ylj6MvQ/soJyQl7wDdgjf5d7OE5Lm5rxUnWhHxiHL+KWb+rzxaS4xQfU2C5hk/
 E5kC6No2zl281vgmMnBM7WzB2TWvkzRA1Uf7Wat6lhvaQ27+ZE+8Qd+cS5zsG5OSwAB4sDm7X
 k8HQIF3c4Sw22Kqq6G/1L/Ms8IHRG+ES3gTM3h+GprixZWS7C0qGCpgvHLrVa+f7uhxahS8r6
 2jSt/9d1Ozw7GLhDDlGv9dIXHx+nl8ccWKoOv3vzbFw30fsjk8y/XQ17Fj24jlKjHVxc+dedk
 aCNt9d3mENQZRaPwfT5xG7Ir2FHFcJEru+ZK8J/LcptFHiF6Eh7V/ySFyRL0RkvsUg6usho3v
 DipBL3fcDqAz6bSjYwbvLDoifAXbCFKlEoBQUPDezPunmIHiduv2xEl/yruwPo1Mu2cVTWq12
 ACmYxPzyVps9f/ab+38WsDpWb1BVcZaLJiznX0e3sWVG9Lh6zHQ9J/DrnV3LlK39YtgehytPp
 /Ilmo4n6ZHcmLctHk+wpysz4dvxztCbzgfcIey8D9VyRdycNRz/Xvv9mhJ+fbKOuc67CRgqfQ
 OjfH7wNyaAMz55GyuNFqCRI62h5dRcBoBSFi94kEz9K4DVvMy28kfZ1sg5Ft6kkn6CjiHNETI
 g3LTaj7pWWYnPevaVcOSmNgRAqhQjBri7fBHZT3vgW0jMNZjxKw7ukXsAHaAE2KhEaobt6WTk
 Sat3kz9IS4RDtj8WbfM9VvA2xpMFPAyN43rHWoV9Mw8J0ZT1xKAWWZfxLJoI9iub/Vu3c5Y/H
 yLWB/+FZpXkoSA3V/Ni4rwrpv2o4WpygYcVCYM1UiPfvW8mdeTmYEsUuy2N9PlP2dXGD/mZV8
 nQw3qgPKB6cvDOP6qie8cAsdpHVSbF8BMoHeZqGkXIx2RxfYuJ0SlSzP+4V4u3u51K9GKMbiu
 Ot3zsSWaB68U3UUyfKuLXNV/Oannn//xMk1IGYC/5u+ShCNmFd4Yt6B8Q==
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
YWxfY29yZS5jCmluZGV4IDMxNThmMDVhMzI4Yy4uYWMxOThkMGQ0YzgwIDEwMDY0NAotLS0gYS9k
cml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUuYworKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwv
c2VyaWFsX2NvcmUuYwpAQCAtMzM5NSw2ICszMzk1LDggQEAgaW50IHVhcnRfZ2V0X3JzNDg1X21v
ZGUoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCkKIAkJcnM0ODVjb25mLT5kZWxheV9ydHNfYWZ0ZXJf
c2VuZCA9IDA7CiAJfQogCisJdWFydF9zYW5pdGl6ZV9zZXJpYWxfcnM0ODVfZGVsYXlzKHBvcnQs
IHJzNDg1Y29uZik7CisKIAkvKgogCSAqIENsZWFyIGZ1bGwtZHVwbGV4IGFuZCBlbmFibGVkIGZs
YWdzLCBzZXQgUlRTIHBvbGFyaXR5IHRvIGFjdGl2ZSBoaWdoCiAJICogdG8gZ2V0IHRvIGEgZGVm
aW5lZCBzdGF0ZSB3aXRoIHRoZSBmb2xsb3dpbmcgcHJvcGVydGllczoKLS0gCjIuMjUuMQoK
