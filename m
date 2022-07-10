Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4302956D028
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 18:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiGJQpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 12:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiGJQpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 12:45:20 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928CE13D47;
        Sun, 10 Jul 2022 09:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657471495;
        bh=nYNKgNEFTLWJv70qJTgu0U52c7ApU1mo6Iozs+zcxjw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=YteHhjU8dVZTAIVPpyKB9v/uxHfFWo45uox51wUJ1dj6lJP0/WJelE057EyZmcLx0
         0IqmUFoII0BaY/75ZD5+7SSc7ufs9wtX/0UCZYXcQAHyAfCQo3w7sw/ibwqI8Ocb2V
         Q3+Vlm+/Y21nBLkMbjoCVQ7QYD7x6PP/ZXkvsITI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([46.223.3.243]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MTzb8-1o1Kfl0VWc-00R3fK; Sun, 10 Jul 2022 18:44:55 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     ilpo.jarvinen@linux.intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH v4 0/8] Fixes and cleanup for RS485
Date:   Sun, 10 Jul 2022 18:44:34 +0200
Message-Id: <20220710164442.2958979-1-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:wgkedPKpLWO35Avvm9PJn8OvmcwTt7xznmtVa+nKkgW33M68BHP
 ZOTxah1zmbpI3eJZ60nGpnZCrYBKwHL/83zIjjZQ7oCo6sOo5nI4gSVQhqA0Kr98Tg49Asr
 uh8fsbvXKF15XqwVML5Rb3KvRsFwW2K2RX/xcDgbyUrQ1HjvPwVJfP5CARmU5zGfCAJSTPP
 CDrOsrrZYtojQz8ap0vMQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:X51eDTNwzUE=:CT++cnbYZbV+o/7XPAqieW
 b+xwxsn7b28vk0rFPzsc5i6lQyy1Uy3e/RIVwBoZJwX8XO6sfJQZeNQqyf6lKVyV3Djc7H7iL
 UbM8AAAwWzhSGY1BcbpDu3qBWz0BabXCewxq5hHKrT7fYCESVT66HkXRYt4RNH7eudt06Ido2
 1s2V2j5AAuKawyCktJhzoc/1TzxyEZLqgFS27m5yBvHdmx4B8OhOqm0e/ccUXvVwp+SNRJPyN
 rBY1LU+r5sescb/xl1VUvvxcTY0M9S+ob9Fb7Ed4jwmSF1io974+wO7J+ftHRb9seVo1mvIxn
 HU5zm6fK98qauTO2oLR0S9dzJf2YdPtUMwob10M1HbKfYjzeUgKaZC4/RcgcLOWg8i91JtQzN
 797ZGDf2yMnFBmxw/0lkt8yra7QyAKPkwLj+wHgXpyml8iP2vemFe3Wfw5tv+3xFN6sr1IFMy
 FQE+ihIuf6CaOkDOPNWmST4AJU6qQw8vEMmiFOLNvbw3V2oAfpbNL6UTJ8FfnzSHFQ3wJaZ2Z
 a+NWmdnZaeAsEjIalLZZlPUqPAjveGIeK4k7D7iSXc7enSsGLylkMdFlYw8GE+QeYq9Bb40b5
 Mp5IiAlfKb9mAFPsLR+sGsPxN6EoPoZpVslEzAa8KKPmBH4m64sEFKzxGrDd6uNBt/yrVMjMA
 V7eJekUzYmhxt+/1aEjEiRWB7WjSLwH5+t2NFXvKe9+Vmx4XwkcTyjLLvPfPcKDvKytH/NjR7
 kzJZTJbi3fmPjBY9NqayaAmHqOadG5WUJAmC1V/miRJOHCmaOWvykYVGsAB9MzRxwA+feqZdb
 y+ZWtY+ErCeZeUjsVeOs5kAtfOnITLLodHyY1ru+FvSSG+DMHKVUvoDqGpdW+SF9e/R1w0Th4
 e+GiS+PZUUWADlQaObLnKuHinbxfCMm2G7SLsfUVvvS7syk5LJWcqYTEJbxzClxxtF8Y3Bety
 T8Qg+ay6W4anIs1LBNUxG2NXvazJJ0BKohUfzyT8Uzej/7zt9fWLwdNCzbmtQpM5xP2hGdNJH
 LsAUC9/vXNHBhqpV5QcdEeTXqs/v9GGrvrDzJ7eIP6QOWpHNMT1C3zSw8pmu3rpjqi2QnqxeF
 ynKlTLco88OKfwRf9LxWNUbJU7zZM85RNnlgBDu6MHjUOQ4UjTynvaDgw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KClRoZSBmb2xs
b3dpbmcgc2VyaWVzIGluY2x1ZGVzIGNsZWFudXAgYW5kIGZpeGVzIGFyb3VuZCBSUzQ4NSBpbiB0
aGUgc2VyaWFsCmNvcmUgYW5kIHVhcnQgZHJpdmVyczoKClBhdGNoIDE6IGFyOTMzeDogRml4IGNo
ZWNrIGZvciBSUzQ4NSBzdXBwb3J0ClBhdGNoIDI6IFJlbW92ZSBzdXBlcmZsdW91cyBjb2RlIGlu
IGFyOTMzeC4KUGF0Y2ggMzogU2V0IHRoZSByczQ4NSB0ZXJtaW5hdGlvbiBHUElPIGluIHRoZSBz
ZXJpYWwgY29yZS4gVGhpcyBpcyBuZWVkZWQKCSBzaW5jZSBpZiB0aGUgZ3BpbyBpcyBvbmx5IGFj
Y2Vzc2libGUgaW4gc2xlZXBhYmxlIGNvbnRleHQuIEl0IGFsc28KCSBpcyBhIGZ1cnRoZXIgc3Rl
cCB0byBtYWtlIHRoZSBSUzQ4NSBoYW5kbGluZyBtb3JlIGdlbmVyaWMuClBhdGNoIDQ6IE1vdmUg
c2FuaXRpemluZyBvZiBSUzQ4NSBkZWxheXMgaW50byBhbiBvd24gZnVuY3Rpb24uIFRoaXMgaXMg
aW4gCgkgcHJlcGFyYXRpb24gb2YgcGF0Y2ggNC4KUGF0Y2ggNTogU2FuaXRpemUgUlM0ODUgZGVs
YXlzIHJlYWQgZnJvbSBkZXZpY2UgdHJlZS4KUGF0Y2ggNjogQ29ycmVjdCBSUzQ4NSBkZWxheXMg
aW4gYmluZGluZyBkb2N1bWVudGF0aW9uLgpQYXRjaCA3OiBSZW1vdmUgcmVkdW5kYW50IGNvZGUg
aW4gODI1MF9kd2xpYi4KUGF0Y2ggODogUmVtb3ZlIHJlZHVuZGFudCBjb2RlIGluIDgyNTAtbHBj
MTh4eC4KCkNoYW5nZXMgaW4gdjQ6Ci0gZml4ZWQgbG9naWNhbCBlcnJvciBmb3VuZCBieSAKLSBj
YXBpdGFsaXplICJ1YXJ0IiBhbmQgImdwaW8iIGluIGNvbW1pdCBtZXNzYWdlcwoKQ2hhbmdlcyBp
biB2MzoKLSByZW1vdmUgb2Jzb2xldGUgcGF0Y2ggKGR1ZSB0byBjaGFuZ2VzIGJ5IElscG8pCi0g
Y29ycmVjdGVkIGFuZCByZXBocmFzZSBjb21taXQgbWVzc2FnZXMgKHBvaW50ZWQgb3V0IGJ5IEFu
ZHkpCi0gcmVtb3ZlIHN1cGVyZmx1b3VzIGNoZWNrIChwb2ludGVkIG91dCBieSBBbmR5KQotIHNl
cGFyYXRlIGFyOTMzeCBVQVJUIGJ1Z2ZpeCBhbmQgY2xlYW51cCBpbnRvIGRpZmZlcmVudCBwYXRj
aGVzCiAgKGFzIHN1Z2dlc3RlZCBieSBJbHBvKQotIHB1dCB0aGUgYXI5MzN4IGZpeCBhdCB0aGUg
YmVnaW5uaW5nIG9mIHRoZSBzZXJpZXMgKGFzIHN1Z2dlc3RlZCBieSBBbmR5KQoKQ2hhbmdlcyBp
biB2MjoKLSBwcmludCBhIHdhcm5pbmcgaWYgdGVybWluYXRpb24gR1BJTyBpcyBzcGVjaWZpZWQg
aW4gRFQvQUNQSSBidXQgaXMgbm90CiAgc3VwcG9ydGVkIGJ5IGRyaXZlciAKLSBmaXhlZCBjb21t
aXQgbWVzc2FnZSBmb3IgZGV2dHJlZSBkb2N1bWVudGF0aW9uIChhcyBzdWdnZXN0ZWQgYnkgQW5k
eSkKLSBmaXhlZCBjb2RlIGNvbW1lbnQKLSBhZGRlZCBwYXRjaCA3CgpMaW5vIFNhbmZpbGlwcG8g
KDgpOgogIHNlcmlhbDogYXI5MzN4OiBGaXggY2hlY2sgZm9yIFJTNDg1IHN1cHBvcnQKICBzZXJp
YWw6IGFyOTMzeDogUmVtb3ZlIHN1cGVyZmx1b3VzIGNvZGUgaW4gYXI5MzN4X2NvbmZpZ19yczQ4
NSgpCiAgc2VyaWFsOiBjb3JlLCA4MjUwOiBzZXQgUlM0ODUgdGVybWluYXRpb24gR1BJTyBpbiBz
ZXJpYWwgY29yZQogIHNlcmlhbDogY29yZTogbW92ZSBzYW5pdGl6aW5nIG9mIFJTNDg1IGRlbGF5
cyBpbnRvIG93biBmdW5jdGlvbgogIHNlcmlhbDogY29yZTogc2FuaXRpemUgUlM0ODUgZGVsYXlz
IHJlYWQgZnJvbSBkZXZpY2UgdHJlZQogIGR0X2JpbmRpbmdzOiByczQ4NTogQ29ycmVjdCBkZWxh
eSB2YWx1ZXMKICBzZXJpYWw6IDgyNTBfZHdsaWI6IHJlbW92ZSByZWR1bmRhbnQgc2FuaXR5IGNo
ZWNrIGZvciBSUzQ4NSBmbGFncwogIHNlcmlhbDogODI1MDogbHBjMTh4eDogUmVtb3ZlIHJlZHVu
ZGFudCBzYW5pdHkgY2hlY2sgZm9yIFJTNDg1IGZsYWdzCgogLi4uL2RldmljZXRyZWUvYmluZGlu
Z3Mvc2VyaWFsL3JzNDg1LnlhbWwgICAgIHwgIDQgKy0KIGRyaXZlcnMvdHR5L3NlcmlhbC84MjUw
LzgyNTBfZHdsaWIuYyAgICAgICAgICB8IDEwICstLS0KIGRyaXZlcnMvdHR5L3NlcmlhbC84MjUw
LzgyNTBfbHBjMTh4eC5jICAgICAgICB8ICA2ICstCiBkcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84
MjUwX3BvcnQuYyAgICAgICAgICAgfCAgMyAtCiBkcml2ZXJzL3R0eS9zZXJpYWwvYXI5MzN4X3Vh
cnQuYyAgICAgICAgICAgICAgfCAxOCArKy0tLS0KIGRyaXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxf
Y29yZS5jICAgICAgICAgICAgICB8IDYwICsrKysrKysrKysrKy0tLS0tLS0KIDYgZmlsZXMgY2hh
bmdlZCwgNTAgaW5zZXJ0aW9ucygrKSwgNTEgZGVsZXRpb25zKC0pCgoKYmFzZS1jb21taXQ6IDdl
NWI0MzIyY2RlMDY3ZTFkMGYxYmY4ZjQ5MGU5M2Y2NjRhN2M4NDMKLS0gCjIuMjUuMQoK
