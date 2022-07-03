Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7D85648C8
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 19:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbiGCRCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 13:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbiGCRBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 13:01:55 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108A36367;
        Sun,  3 Jul 2022 10:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656867692;
        bh=Gw9NEaUgWzJlqBYAtK80pixVAewS3QXQKW91nfrstD4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=BCHYoqoDyTIfRPQSP3pz0be+L6Y1yTs6mrMlhnaZnGTDscZFIVEkw8Ftu04175ys3
         X3zc7nRc0Po0E5D37M+aS5FkWDUfPVkbhPftmLfWAY6+hApnEq1P2nxfn48dFJngCK
         J1vXAqZbjgSh0CFbemTj9mVXrrcvMhrEj20bVGow=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([46.223.3.210]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MNswE-1nwzH21HTM-00OH3R; Sun, 03 Jul 2022 19:01:32 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     ilpo.jarvinen@linux.intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH v2 6/9] serial: 8250_dwlib: remove redundant sanity check for RS485 flags
Date:   Sun,  3 Jul 2022 19:00:36 +0200
Message-Id: <20220703170039.2058202-7-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220703170039.2058202-1-LinoSanfilippo@gmx.de>
References: <20220703170039.2058202-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:AgTxFL7r7/KltmrTUlOEyF+V9kwKsTZye9xp8F5aWwyBq8ROOC2
 EYKSeYZn/3j3mXtxqxwFZ1NysE7MZAMpa+L2/MmHtLd6P1vinXWmbw3YgzHVbqZyq5banr3
 WOXMu+dT7Vuo/+aM4npJVetk6Nvg2fYMm6GVIh6cF5D8M8VM3xCdx2p6D9ARd33aeVhH1mN
 yehDL7OmHW3Q/UGXUAe3Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nJntR4xGIIk=:Pls7E2ZPEwkgHAQsyIXXV4
 u/ukUxSVSSvAi/N/kVlpce3DvTZp+9icN7FPaBVPfKmi6l596lpz2JO8VdYVzs3awEQaiYbO8
 9FlJFEYC+ts9u1HkIfHBi0B7RF57Vt41b0za55P4otAB3vpJcyfT3PrspM0gJyz2f59iC4ML5
 sCLZegmqe3LnoFdMfLJqEc3nwqzXlu7MUvxJxLOPhHLBCllnJsvxgohSe9wCTJcjyOoKHsVy1
 qxO9KTm2/xqJudMglYBiQl0CHsNHk6pEwVSThsdyLGrTUsyq0ydEjZ8giwAbf2H0/Cjz6NSOs
 sumuhDhNmostSZeUCHixXw/q4PCHvN5gFzPhPwRpz8EOl7z/tQfBXTEPDZvHQRm+x/ypJT1G5
 kN6FB/eMyJDIGGFxpxPScIQ3znmgSp/HNkCu1bjm76amVb5a3nThvi/MlK9g2yh8Dw1gumDmm
 v03p+ShkXtUU+dp5MxIur+rG0Y94UVG4nWZJO0+MPnFKAEE1WPepxCaAQVxPXhhhrcXeevURx
 huYdyiewGQNkfNR/ux7gIVnklM6vnrLtFfCa2I9XeJ1+T0NRSGt+/v6nu8V1IbK8G/wTdgC6d
 ziPX79u1eHaQWQrt58TiKkK/veuWUaIX+HF94oAy+AbcY5sTzmW019gQj01nsc/N61mAqA2vy
 W/ckBKonz8Vglm6q9yTZgh+FjsoWHNSjwX7Cfn35qhOIKS9STBx4lY6RP4OzsOt9dnzbHsgKg
 KgZHvGfwz81C2DrBOHHwelwPeiOO7tKGMhr/gdSgzVXzu6+DkK2HdhIj+UJm6A59CicVoy2Q/
 Ive5KhtIyJThnK76lqX2UY8xhsPAsdFuyuAV30hux9LDfzD2uC7rUJPQKj9oB1q53PQadaiRk
 ajcrdDjXxoiCSVH7c01xD2YhIj6ZN4Gc99wA4SjQqKnnaRFkfDQSEV/JI693rI3K/IRWUU0C7
 BvW0zP5MGwLrCSN+nu/plLr0Kja7ofBu+nfDfG59AehsFW8yQXowz/SK9MhOQs4Hxis6aMCFM
 JBE19nyxxniF0+LU9YIqvidZY6jbRkyAU8bWo2Uni8nhZHqeGw5u738Ful3ExGQOVKDoExlGx
 MeMPq+bgywM2dUWntvAqS7yBBgyHVIcW4iufZGSRwUhcCYHWMiA1eXf/A==
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
bT4KLS0tCiBkcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX2R3bGliLmMgfCAxMCArKy0tLS0t
LS0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfZHdsaWIuYyBiL2RyaXZlcnMv
dHR5L3NlcmlhbC84MjUwLzgyNTBfZHdsaWIuYwppbmRleCBhOGJiZWQ3NGVhNzAuLmY0YWUyNjJk
MDBmYiAxMDA2NDQKLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9kd2xpYi5jCisr
KyBiL2RyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfZHdsaWIuYwpAQCAtMTg3LDE2ICsxODcs
MTAgQEAgc3RhdGljIGludCBkdzgyNTBfcnM0ODVfY29uZmlnKHN0cnVjdCB1YXJ0X3BvcnQgKnAs
IHN0cnVjdCBrdGVybWlvcyAqdGVybWlvcywKIAlpZiAocnM0ODUtPmZsYWdzICYgU0VSX1JTNDg1
X0VOQUJMRUQpIHsKIAkJdGNyIHw9IERXX1VBUlRfVENSX1JTNDg1X0VOOwogCi0JCWlmIChyczQ4
NS0+ZmxhZ3MgJiBTRVJfUlM0ODVfUlhfRFVSSU5HX1RYKSB7CisJCWlmIChyczQ4NS0+ZmxhZ3Mg
JiBTRVJfUlM0ODVfUlhfRFVSSU5HX1RYKQogCQkJdGNyIHw9IERXX1VBUlRfVENSX1hGRVJfTU9E
RV9ERV9EVVJJTkdfUkU7Ci0JCX0gZWxzZSB7Ci0JCQkvKiBIVyBkb2VzIG5vdCBzdXBwb3J0IHNh
bWUgREUgbGV2ZWwgZm9yIHR4IGFuZCByeCAqLwotCQkJaWYgKCEocnM0ODUtPmZsYWdzICYgU0VS
X1JTNDg1X1JUU19PTl9TRU5EKSA9PQotCQkJICAgICEocnM0ODUtPmZsYWdzICYgU0VSX1JTNDg1
X1JUU19BRlRFUl9TRU5EKSkKLQkJCQlyZXR1cm4gLUVJTlZBTDsKLQorCQllbHNlCiAJCQl0Y3Ig
fD0gRFdfVUFSVF9UQ1JfWEZFUl9NT0RFX0RFX09SX1JFOwotCQl9CiAJCWR3ODI1MF93cml0ZWxf
ZXh0KHAsIERXX1VBUlRfREVfRU4sIDEpOwogCQlkdzgyNTBfd3JpdGVsX2V4dChwLCBEV19VQVJU
X1JFX0VOLCAxKTsKIAl9IGVsc2UgewotLSAKMi4yNS4xCgo=
