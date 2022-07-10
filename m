Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8568756D018
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 18:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiGJQpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 12:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGJQpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 12:45:17 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE6511C2D;
        Sun, 10 Jul 2022 09:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657471498;
        bh=0HR3Zv5yqKQt68jtTzgddRrz6zgVoGHjCf/opyPjVSw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=igYmmq57v09yY5TCm/EEXRWHE2BDQ0q2qoXUJuwBy5/Fa23GX3Wd3aFauWp+nL5JO
         jg8RO1c4w/lPru6wVhYj0YqUprMmCb0hZvjmTRzcTUUV4QLRu7ZDopd38tHCEL1hyj
         qfyiwhta6G3m2H7MIs5Pi+nm20hFVnFqVNoZpFi0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([46.223.3.243]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Mk0JM-1niAC230BM-00kNno; Sun, 10 Jul 2022 18:44:58 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     ilpo.jarvinen@linux.intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH v4 8/8] serial: 8250: lpc18xx: Remove redundant sanity check for RS485 flags
Date:   Sun, 10 Jul 2022 18:44:42 +0200
Message-Id: <20220710164442.2958979-9-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220710164442.2958979-1-LinoSanfilippo@gmx.de>
References: <20220710164442.2958979-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:utoOmTsnfe/Q24WFmaru+XmVgFVIdOtiXrB3erIIRDRENkVZzm7
 edqUoy/EUeaB5WiZx42ILFdtsA8P6fdMkjzqTlE+ty6zC7Qc400H/KX/VG1jcXahq/0+kLr
 LbDOcrdcpuzoYpQD728PIsNmo7C4mSAefduXs+mpLQFyTn7on/Lc8EAuisOXTobz5/DwKyC
 693B854VYP0yoFVDWZMow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KkTfvqotrcM=:GhmoW+RnNyay85NkMwVp11
 /izaJC+pMyDx8YtkIu3hzLuTxuZSarXmbIc764KoMtKCvEyX4efCiX2W/N6dRJsNJj8Y+z5Fq
 LJNDo+bCn+hnY+WOabNKXE9VJeAxDKrGJotvUTToRo12DGGpk+P+KHqUUfMKSiKIzHeG4PJhq
 QMKC9jG38UQDuI8qFNGERX3qiI7v8QHBAPZnMabCc9zft/w3ldU9WhfsagEqkvPmiWUimVOgt
 tQAZXsmRHCJfk27RMXgi4yDLOxzGcRN7hRmU88yzDMnW1S2nW9x+rLudH/NruoaeZT3AB6K44
 9hgFyONhy9Gh6KBQ2TQ3CXlDa26qdHm/HeTKVm0WhfoVA/SV4DVuJYq6OREMgbXkn3ERRTc7z
 7lYswfynj4pdCdaP0QKwyaIe44fGdkmuhRyurKnRVtl8ukv7NUV+/Gb+ZdhUpC2xtp9nUAFdj
 o0ZxK/1N8lzqi86tuub2ILjDmHllcOr8NiBsulqbLfzpDd5nQudSdQBQA/aPFThemZxsA3xLv
 vxnqvnJXJeqhrb6w7uhTBrsY0HHUzn7AC7AWkPFDX4DqBALelzgCSQbkQT2rgvuE/88bwJ6Ch
 kLhnVMRjzgSFEzGOnYpsG2u12eMdCCYJqSfYKWfCxNyJENQTUIOwbhaZlg4KLltTgsuXXWmuq
 P2wI5fwIcmE9YpXi09viaAdYfVtwDxEChSCxFbT60sovwN59qicqlGKg3IwtY3Trs8R7+3vPA
 oK2AIdbzcJzaAQE2zAl5lRZAU4XX95JH7jttdEavax0bVtOmxYY0GKnvsjfB1nsSQITB30zMG
 1fh6BnA66Y4+vdJwDkq4QsCcBb51tMSCxtGZgseYDoaH0xye605WHM0hSV6jSkMcfCO8eakPh
 7jZW09TE4RY7PLXmMrnO5646WaKszx+mo/tcFiZ7h7B5t7a970eoC0uh8e7p1jfQenkJ7y7kJ
 Bg9eCTHpdGFWfZMAe/lGbGSeLVyjuvINmR8v9ijXB6DJIvS8DG1zb9rxtbDYI1xNzs3316U90
 fwuxyu9kP/t20cxrI8rBu4wsy/AF5nBOH6ByyFn6Zb8MKBEzpm73vDVWykLXCfBgVfy5rFCsG
 vR+UNLqutUVULFiOdTL8ae6PrGVjkZz0FTM89iR8GAJusXeFkuGVNf+ng==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCkJlZm9yZSB0
aGUgZHJpdmVycyByczQ4NV9jb25maWcoKSBmdW5jdGlvbiBpcyBjYWxsZWQgdGhlIHNlcmlhbCBj
b3JlCmFscmVhZHkgZW5zdXJlcyB0aGF0IG9ubHkgb25lIG9mIGJvdGggb3B0aW9ucyBSVFMgb24g
c2VuZCBvciBSVFMgYWZ0ZXIgc2VuZAppcyBzZXQuIFNvIHJlbW92ZSB0aGUgY29uY2VybmluZyBz
YW5pdHkgY2hlY2sgaW4gdGhlIGRyaXZlciBmdW5jdGlvbiB0bwphdm9pZCByZWR1bmRhbmN5LgoK
U2lnbmVkLW9mZi1ieTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4K
UmV2aWV3ZWQtYnk6IElscG8gSsOkcnZpbmVuIDxpbHBvLmphcnZpbmVuQGxpbnV4LmludGVsLmNv
bT4KLS0tCiBkcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX2xwYzE4eHguYyB8IDYgKy0tLS0t
CiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9scGMxOHh4LmMgYi9kcml2ZXJzL3R0
eS9zZXJpYWwvODI1MC84MjUwX2xwYzE4eHguYwppbmRleCBkNmNhMGQ0N2U5ZDUuLjZkYzg1YWFi
YTVkMCAxMDA2NDQKLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9scGMxOHh4LmMK
KysrIGIvZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9scGMxOHh4LmMKQEAgLTQ0LDEyICs0
NCw4IEBAIHN0YXRpYyBpbnQgbHBjMTh4eF9yczQ4NV9jb25maWcoc3RydWN0IHVhcnRfcG9ydCAq
cG9ydCwgc3RydWN0IGt0ZXJtaW9zICp0ZXJtaW9zCiAJCXJzNDg1X2N0cmxfcmVnIHw9IExQQzE4
WFhfVUFSVF9SUzQ4NUNUUkxfTk1NRU4gfAogCQkJCSAgTFBDMThYWF9VQVJUX1JTNDg1Q1RSTF9E
Q1RSTDsKIAotCQlpZiAocnM0ODUtPmZsYWdzICYgU0VSX1JTNDg1X1JUU19PTl9TRU5EKSB7CisJ
CWlmIChyczQ4NS0+ZmxhZ3MgJiBTRVJfUlM0ODVfUlRTX09OX1NFTkQpCiAJCQlyczQ4NV9jdHJs
X3JlZyB8PSBMUEMxOFhYX1VBUlRfUlM0ODVDVFJMX09JTlY7Ci0JCQlyczQ4NS0+ZmxhZ3MgJj0g
flNFUl9SUzQ4NV9SVFNfQUZURVJfU0VORDsKLQkJfSBlbHNlIHsKLQkJCXJzNDg1LT5mbGFncyB8
PSBTRVJfUlM0ODVfUlRTX0FGVEVSX1NFTkQ7Ci0JCX0KIAl9CiAKIAlpZiAocnM0ODUtPmRlbGF5
X3J0c19hZnRlcl9zZW5kKSB7Ci0tIAoyLjI1LjEKCg==
