Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F23B554FD2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 17:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359610AbiFVPsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 11:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359501AbiFVPrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 11:47:45 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854893A5DF;
        Wed, 22 Jun 2022 08:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655912840;
        bh=8IFGxVS1vl5JLWh0yU8Lv5GqvKfBZ2iqkV27iNYuWh0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=UVO+cw9CkqDJWgg8c2KKc/7SdSzueQAlaGe6XDfOE7FC4NpxX7octk2+fWE+Kr2RX
         cXHgaBmUuvmXdJx+w7v9FLCByTAcz+j6Yhz/pu7eulb/7qLAnvZjBr/6B1CPSkw417
         /1Z97pBU0JgW3m9r3Okn0lI2i6SCiLlp4KgDKFWc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([46.223.2.22]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MV67o-1oDQn33Qnu-00S3PO; Wed, 22
 Jun 2022 17:47:19 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     ilpo.jarvinen@linux.intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH 1/8] serial: core: only get RS485 termination gpio if supported
Date:   Wed, 22 Jun 2022 17:46:52 +0200
Message-Id: <20220622154659.8710-2-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220622154659.8710-1-LinoSanfilippo@gmx.de>
References: <20220622154659.8710-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:Wzux1oUdzW1pI7nfCPbfxqcmfleiTwvPyv2n9VmmFzCZ2/Dzw4V
 a9Sc1f4YAFcUhRs4jBHdjixFcdb4xPhKK3ZFyjOXGeX5mUGXETzXZFsgQollNQX2ZipkO0Q
 FLHbM5HCIlp9mdDiEjp6G0/1hrXNMpyVW3d/PTsBFcRH7g4mKyZo2oehzc2ZOQqK4PLZzvI
 b8zkGeTTbxKpW3/DZSMkQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ObLfviULXH8=:BUFD+zu2z8GYzeCsOjHWqD
 TyrqkX/lOCzkMy+RY/45i+3vUB7nd6K/wkPEAO5Rk6LnO1Two+tFsknemhrIkMUslMU2HJjrB
 AngOpKEV9nuDk4BvfIxTxtla/g8Xijq4dLm7dOBTpkM0vIoyxl8Xq81UYsuvSf1GLMBLjMRCx
 POAfAQyBT4leaA9Bt10Qw3FdewKrpRIC3mu6MM7VBZV6ymYjH3Q8NEC6J3U5hDAEu9ikf4hRr
 Rxi+VwJAACFftmCWGdZYiLO4Ywl7rSxNg6JRkeRcazh3LGy63GZ8puI6a5BjdMkOCe+MivsyH
 BMyiNZNEpSRZ1TvxKQu/6xacUAARfzOQ07LAKGj33rOHWUkL/o0K5RzidoBT3z/Ljox+cWwJq
 KCSaiCBIayfV7PUypWK5DCRHcYUPn0xH7PTKEJnSTgeLebkRxX0nQPmDuYV1ZIiMH7U8G2esi
 THgibLABCTPmhUBirAKgG8Vayb7V98jM91f8fC2FGtWLhHCS9OuJJ/+VAMi9IXKsEPTTLTfqy
 P8Bi80biXYRow0sXFmCOuGVrFtgYvnqkeawk4d+3IthSwfWTwquTZQ8XjLtjRUmycFKAbPtaP
 DSO8EISdXnralXN46F/wan3dwQJEXupLfpYykI6eomP2X7REeSh3/lJUD430R61RKpJlbcaXD
 uaIxC6SGMNq8zA/yqTfR6B8wcj8sD7XrOTkao0xOd6ldEMh9Hl+oOYmEdayJ+xTOA4ac1NQoa
 W/tGmX7kBrfUHa1boVKgWXmqP0zRCVqR3/+b24Tipat2p4JQeCO2DNHEKhY8Zez9COqjyGM42
 qLig8Ymt1r+N9gMWHIxgJwW6mlOzTGio/8FARtTR2KY9r1BfawuJj4TXXzNajc581Bq29gAPk
 JhIj2P1x796luk+pvaaGkX3uh3/LuWAkwwaJjEyRgqH7H2/wvl0kAHuyOkAofTgWl8ci1Eb3i
 c+IG9X+SYsAf8blcz1YMB3S11J3zwf10zEW47ITQcZIMi6izTpz1k89LO0gNX9cMplBDP5m2o
 0SpSlWnxKqbKppyHljPuit5XaqaXHlfpjINBRzqy9EX2Fa6fcBu7KezCLqryGeDqp1yfaiDLG
 AYKzEY6JlRtf5fj5HJRUwih4kjk0ham0LorujXrvE96jqR1uj0cfWOknw==
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCkluIHVhcnRf
Z2V0X3JzNDg1X21vZGUoKSBvbmx5IHRyeSB0byBnZXQgYSB0ZXJtaW5hdGlvbiBHUElPIGlmIFJT
NDg1IGJ1cwp0ZXJtaW5hdGlvbiBpcyBzdXBwb3J0ZWQgYnkgdGhlIGRyaXZlci4KClNpZ25lZC1v
ZmYtYnk6IExpbm8gU2FuZmlsaXBwbyA8bC5zYW5maWxpcHBvQGt1bmJ1cy5jb20+Ci0tLQogZHJp
dmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMgfCAyNSArKysrKysrKysrKysrKy0tLS0tLS0t
LS0tCiAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMgYi9kcml2ZXJzL3R0
eS9zZXJpYWwvc2VyaWFsX2NvcmUuYwppbmRleCAxMzY4YjBlZjdkN2YuLjAxNWY0ZTFkYTY0NyAx
MDA2NDQKLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMKKysrIGIvZHJpdmVy
cy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMKQEAgLTMzODQsMTcgKzMzODQsMjAgQEAgaW50IHVh
cnRfZ2V0X3JzNDg1X21vZGUoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCkKIAkJcnM0ODVjb25mLT5m
bGFncyB8PSBTRVJfUlM0ODVfUlRTX0FGVEVSX1NFTkQ7CiAJfQogCi0JLyoKLQkgKiBEaXNhYmxp
bmcgdGVybWluYXRpb24gYnkgZGVmYXVsdCBpcyB0aGUgc2FmZSBjaG9pY2U6ICBFbHNlIGlmIG1h
bnkKLQkgKiBidXMgcGFydGljaXBhbnRzIGVuYWJsZSBpdCwgbm8gY29tbXVuaWNhdGlvbiBpcyBw
b3NzaWJsZSBhdCBhbGwuCi0JICogV29ya3MgZmluZSBmb3Igc2hvcnQgY2FibGVzIGFuZCB1c2Vy
cyBtYXkgZW5hYmxlIGZvciBsb25nZXIgY2FibGVzLgotCSAqLwotCXBvcnQtPnJzNDg1X3Rlcm1f
Z3BpbyA9IGRldm1fZ3Bpb2RfZ2V0X29wdGlvbmFsKGRldiwgInJzNDg1LXRlcm0iLAotCQkJCQkJ
CUdQSU9EX09VVF9MT1cpOwotCWlmIChJU19FUlIocG9ydC0+cnM0ODVfdGVybV9ncGlvKSkgewot
CQlyZXQgPSBQVFJfRVJSKHBvcnQtPnJzNDg1X3Rlcm1fZ3Bpbyk7Ci0JCXBvcnQtPnJzNDg1X3Rl
cm1fZ3BpbyA9IE5VTEw7Ci0JCXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgcmV0LCAiQ2Fubm90
IGdldCByczQ4NS10ZXJtLWdwaW9zXG4iKTsKKwlpZiAocG9ydC0+cnM0ODVfc3VwcG9ydGVkLT5m
bGFncyAmIFNFUl9SUzQ4NV9URVJNSU5BVEVfQlVTKSB7CisJCS8qCisJCSAqIERpc2FibGluZyB0
ZXJtaW5hdGlvbiBieSBkZWZhdWx0IGlzIHRoZSBzYWZlIGNob2ljZTogIEVsc2UgaWYKKwkJICog
bWFueSBidXMgcGFydGljaXBhbnRzIGVuYWJsZSBpdCwgbm8gY29tbXVuaWNhdGlvbiBpcyBwb3Nz
aWJsZQorCQkgKiBhdCBhbGwuIFdvcmtzIGZpbmUgZm9yIHNob3J0IGNhYmxlcyBhbmQgdXNlcnMg
bWF5IGVuYWJsZSBmb3IKKwkJICogbG9uZ2VyIGNhYmxlcy4KKwkJICovCisJCXBvcnQtPnJzNDg1
X3Rlcm1fZ3BpbyA9IGRldm1fZ3Bpb2RfZ2V0X29wdGlvbmFsKGRldiwgInJzNDg1LXRlcm0iLAor
CQkJCQkJCQlHUElPRF9PVVRfTE9XKTsKKwkJaWYgKElTX0VSUihwb3J0LT5yczQ4NV90ZXJtX2dw
aW8pKSB7CisJCQlyZXQgPSBQVFJfRVJSKHBvcnQtPnJzNDg1X3Rlcm1fZ3Bpbyk7CisJCQlwb3J0
LT5yczQ4NV90ZXJtX2dwaW8gPSBOVUxMOworCQkJcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCBy
ZXQsICJDYW5ub3QgZ2V0IHJzNDg1LXRlcm0tZ3Bpb3NcbiIpOworCQl9CiAJfQogCiAJcmV0dXJu
IDA7Ci0tIAoyLjM2LjEKCg==
