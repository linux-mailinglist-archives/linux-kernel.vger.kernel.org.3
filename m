Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE0E5648CB
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 19:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbiGCRC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 13:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbiGCRB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 13:01:58 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7936E624F;
        Sun,  3 Jul 2022 10:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656867691;
        bh=jkKzvX9K2yUOdQWW1Ju0XywTrAt4odrCEHF4kNehvBc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=UsQY0Eai123tThH18I4L+xXnQcNKmJgvkHWxF8zb4fdxOkrVUwgCizd6xALGqoQq5
         1spIcHUfMHUlCcc30Axgx7q+OxCdmdaDt14Z1Pp3DQ9bPq6sh8jxy7nD/GQSOUoKcv
         DmyjNLzs403GFvdxsFfK8t1JpRu9sBolhFuI5kb8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([46.223.3.210]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MTAFh-1o2mQ805Dr-00Uduo; Sun, 03 Jul 2022 19:01:31 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     ilpo.jarvinen@linux.intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH v2 3/9] serial: core: move sanitizing of RS485 delays into own function
Date:   Sun,  3 Jul 2022 19:00:33 +0200
Message-Id: <20220703170039.2058202-4-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220703170039.2058202-1-LinoSanfilippo@gmx.de>
References: <20220703170039.2058202-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:qyH35UB6OgK9aAsVjM0R4uFEO6UXYWIXW/DoeHKNA3Jzn0ON7NF
 HlAakeLXfnswVxGUTkH0ckJFuTnc+GsUF8aIYaQ7io/vr3twlSjDNY3Wx4d4v+TQn45uEER
 ZEHHM141I6Px3YC7/bZyXYZp/b4YwMH6iPkrbwd52ZGMdVAg3c5tthynG4o1aSqjAWElLtz
 AB0lmeed15siiWjKhy3zg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BTn1/O5BXtw=:l42TZAJHEvnFUeUpI7Ge7Q
 hrCdO5OC+J2dpYG9om6hc2QquHWMenwZyiETFBSuH+hlir4rmNazsfv8ni7W8Oadc2FGfioLk
 2kFzGyusvkL6DGEPyv1mMUWqYji3MQBMBTt8iqPQIRoZgfaocUuZMPrWFAH+7HDyBaGV/QqkF
 1gwF6KAg39pz7GXcQlM16Z0VXvPf+UMOg5Dc3xjWeBhn/YwW8K2CmrVzGOyvYfSLeGfcetQiF
 yl5O2NjXCUqz1UaaA13uNAZRa7dcMbrHA3qA5tPWrw7ZRGzvsklRW6A7CHsxgIywIhEpSf8fu
 Qj9nOTbNqFghDSxg+10vFYndBtImo2XnVQHmtlhylF8k9rF4QdOcRKNgj/wRvLfE78SrEFqY4
 mwh5qOpcCfYARxPg9veH+ClBMnH8oukL5ZYIN1ga2+K+q7M/zrtC6EwMVYk3KOkfDxCXErEon
 BpelQo/l+MQH9FXHULf3f/BwdGT6vy0nbhYUwel3IjjF0GuFuivgO0R9YWS/knYXk3e6DbncK
 K6570yZiW4t3lW+ZN3xqxSiw/OvuTwtVgQds/V+ru9mFfb6WNduBxB8iGMGtdt9RffC/7unRf
 +y925rk5IXM1xmjZ8rXwlwckvFGNypCmhktkulKzjaqwj+uOgdD7+2lNhhoyw18gUccC37PqB
 60ncuGo4B2ymiQsSa0pE5Ld5ddqz/g0ss9e4X8e3D0KQhGJQe1uBPvpA6uqA83Ujv1UOI0zqs
 kEnwPo9SXeRecy2j7lTm9K39f6IVUB2dZ+6Sa01/X6y4jwk0e2TSNuuKQaAF7G/dF6mhPBo9S
 b0/u1M2qPPzWorvxHYU/u4VkBmx3AGXJDAhkTU5nyt3BZ0TimWcKrUq0foNksNwHzhY6vGDC8
 l1tHudumo7mx88Chc4dbxNO1o9ogoEvH87HnoKvZ8/qg/iz3ccrHjEzQpBfHg3y4Dt/Y24YxJ
 +6bCos7IRBbKlgrXReSLDRbXRkENHLoG/a6blFNyh8Kcs2Nhd4IQqVy3bNyGdsyIFqgK4422F
 0wA36G1RHePgcNP86hn6/QEQziIrGbx/i+IaKTJ59qU6BrIe6MBZ56vjbu6ll3bDU4lyDW6aV
 h7Ua8nDsH1H19zG06xBk2LDhaGL5he2BflcVjwwrf+jPZ0WsImSZ4JgsQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCk1vdmUgdGhl
IHNhbml0aXppbmcgb2YgUlM0ODUgZGVsYXlzIG91dCBvZiB1YXJ0X3Nhbml0aXplX3NlcmlhbF9y
czQ4NSgpCmludG8gdGhlIG5ldyBmdW5jdGlvbiB1YXJ0X3Nhbml0aXplX3NlcmlhbF9yczQ4NV9k
ZWxheXMoKS4KClNpZ25lZC1vZmYtYnk6IExpbm8gU2FuZmlsaXBwbyA8bC5zYW5maWxpcHBvQGt1
bmJ1cy5jb20+ClJldmlld2VkLWJ5OiBJbHBvIErDpHJ2aW5lbiA8aWxwby5qYXJ2aW5lbkBsaW51
eC5pbnRlbC5jb20+Ci0tLQogZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMgfCA0NiAr
KysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDI2IGluc2Vy
dGlvbnMoKyksIDIwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3Nlcmlh
bC9zZXJpYWxfY29yZS5jIGIvZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMKaW5kZXgg
OWMyOWQwMzFiNDA0Li4wNWVkM2FjYWQwOWEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdHR5L3Nlcmlh
bC9zZXJpYWxfY29yZS5jCisrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxfY29yZS5jCkBA
IC0xMzAyLDI3ICsxMzAyLDkgQEAgc3RhdGljIGludCB1YXJ0X2NoZWNrX3JzNDg1X2ZsYWdzKHN0
cnVjdCB1YXJ0X3BvcnQgKnBvcnQsIHN0cnVjdCBzZXJpYWxfcnM0ODUgKnIKIAlyZXR1cm4gMDsK
IH0KIAotc3RhdGljIHZvaWQgdWFydF9zYW5pdGl6ZV9zZXJpYWxfcnM0ODUoc3RydWN0IHVhcnRf
cG9ydCAqcG9ydCwgc3RydWN0IHNlcmlhbF9yczQ4NSAqcnM0ODUpCitzdGF0aWMgdm9pZCB1YXJ0
X3Nhbml0aXplX3NlcmlhbF9yczQ4NV9kZWxheXMoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCwKKwkJ
CQkJICAgICAgc3RydWN0IHNlcmlhbF9yczQ4NSAqcnM0ODUpCiB7Ci0JdTMyIHN1cHBvcnRlZF9m
bGFncyA9IHBvcnQtPnJzNDg1X3N1cHBvcnRlZC0+ZmxhZ3M7Ci0KLQlpZiAoIShyczQ4NS0+Zmxh
Z3MgJiBTRVJfUlM0ODVfRU5BQkxFRCkpIHsKLQkJbWVtc2V0KHJzNDg1LCAwLCBzaXplb2YoKnJz
NDg1KSk7Ci0JCXJldHVybjsKLQl9Ci0KLQkvKiBwaWNrIHNhbmUgc2V0dGluZ3MgaWYgdGhlIHVz
ZXIgaGFzbid0ICovCi0JaWYgKChzdXBwb3J0ZWRfZmxhZ3MgJiAoU0VSX1JTNDg1X1JUU19PTl9T
RU5EfFNFUl9SUzQ4NV9SVFNfQUZURVJfU0VORCkpICYmCi0JICAgICEocnM0ODUtPmZsYWdzICYg
U0VSX1JTNDg1X1JUU19PTl9TRU5EKSA9PQotCSAgICAhKHJzNDg1LT5mbGFncyAmIFNFUl9SUzQ4
NV9SVFNfQUZURVJfU0VORCkpIHsKLQkJZGV2X3dhcm5fcmF0ZWxpbWl0ZWQocG9ydC0+ZGV2LAot
CQkJIiVzICglZCk6IGludmFsaWQgUlRTIHNldHRpbmcsIHVzaW5nIFJUU19PTl9TRU5EIGluc3Rl
YWRcbiIsCi0JCQlwb3J0LT5uYW1lLCBwb3J0LT5saW5lKTsKLQkJcnM0ODUtPmZsYWdzIHw9IFNF
Ul9SUzQ4NV9SVFNfT05fU0VORDsKLQkJcnM0ODUtPmZsYWdzICY9IH5TRVJfUlM0ODVfUlRTX0FG
VEVSX1NFTkQ7Ci0JCXN1cHBvcnRlZF9mbGFncyB8PSBTRVJfUlM0ODVfUlRTX09OX1NFTkR8U0VS
X1JTNDg1X1JUU19BRlRFUl9TRU5EOwotCX0KLQogCWlmICghcG9ydC0+cnM0ODVfc3VwcG9ydGVk
LT5kZWxheV9ydHNfYmVmb3JlX3NlbmQpIHsKIAkJaWYgKHJzNDg1LT5kZWxheV9ydHNfYmVmb3Jl
X3NlbmQpIHsKIAkJCWRldl93YXJuX3JhdGVsaW1pdGVkKHBvcnQtPmRldiwKQEAgLTEzNTAsOSAr
MTMzMiwzMyBAQCBzdGF0aWMgdm9pZCB1YXJ0X3Nhbml0aXplX3NlcmlhbF9yczQ4NShzdHJ1Y3Qg
dWFydF9wb3J0ICpwb3J0LCBzdHJ1Y3Qgc2VyaWFsX3JzNAogCQkJIiVzICglZCk6IFJUUyBkZWxh
eSBhZnRlciBzZW5kaW5nIGNsYW1wZWQgdG8gJXUgbXNcbiIsCiAJCQlwb3J0LT5uYW1lLCBwb3J0
LT5saW5lLCByczQ4NS0+ZGVsYXlfcnRzX2FmdGVyX3NlbmQpOwogCX0KK30KKworc3RhdGljIHZv
aWQgdWFydF9zYW5pdGl6ZV9zZXJpYWxfcnM0ODUoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCwgc3Ry
dWN0IHNlcmlhbF9yczQ4NSAqcnM0ODUpCit7CisJdTMyIHN1cHBvcnRlZF9mbGFncyA9IHBvcnQt
PnJzNDg1X3N1cHBvcnRlZC0+ZmxhZ3M7CisKKwlpZiAoIShyczQ4NS0+ZmxhZ3MgJiBTRVJfUlM0
ODVfRU5BQkxFRCkpIHsKKwkJbWVtc2V0KHJzNDg1LCAwLCBzaXplb2YoKnJzNDg1KSk7CisJCXJl
dHVybjsKKwl9CisKKwkvKiBQaWNrIHNhbmUgc2V0dGluZ3MgaWYgdGhlIHVzZXIgaGFzbid0ICov
CisJaWYgKChzdXBwb3J0ZWRfZmxhZ3MgJiAoU0VSX1JTNDg1X1JUU19PTl9TRU5EfFNFUl9SUzQ4
NV9SVFNfQUZURVJfU0VORCkpICYmCisJICAgICEocnM0ODUtPmZsYWdzICYgU0VSX1JTNDg1X1JU
U19PTl9TRU5EKSA9PQorCSAgICAhKHJzNDg1LT5mbGFncyAmIFNFUl9SUzQ4NV9SVFNfQUZURVJf
U0VORCkpIHsKKwkJZGV2X3dhcm5fcmF0ZWxpbWl0ZWQocG9ydC0+ZGV2LAorCQkJIiVzICglZCk6
IGludmFsaWQgUlRTIHNldHRpbmcsIHVzaW5nIFJUU19PTl9TRU5EIGluc3RlYWRcbiIsCisJCQlw
b3J0LT5uYW1lLCBwb3J0LT5saW5lKTsKKwkJcnM0ODUtPmZsYWdzIHw9IFNFUl9SUzQ4NV9SVFNf
T05fU0VORDsKKwkJcnM0ODUtPmZsYWdzICY9IH5TRVJfUlM0ODVfUlRTX0FGVEVSX1NFTkQ7CisJ
CXN1cHBvcnRlZF9mbGFncyB8PSBTRVJfUlM0ODVfUlRTX09OX1NFTkR8U0VSX1JTNDg1X1JUU19B
RlRFUl9TRU5EOworCX0KIAogCXJzNDg1LT5mbGFncyAmPSBzdXBwb3J0ZWRfZmxhZ3M7CiAKKwl1
YXJ0X3Nhbml0aXplX3NlcmlhbF9yczQ4NV9kZWxheXMocG9ydCwgcnM0ODUpOworCiAJLyogUmV0
dXJuIGNsZWFuIHBhZGRpbmcgYXJlYSB0byB1c2Vyc3BhY2UgKi8KIAltZW1zZXQocnM0ODUtPnBh
ZGRpbmcwLCAwLCBzaXplb2YocnM0ODUtPnBhZGRpbmcwKSk7CiAJbWVtc2V0KHJzNDg1LT5wYWRk
aW5nMSwgMCwgc2l6ZW9mKHJzNDg1LT5wYWRkaW5nMSkpOwotLSAKMi4yNS4xCgo=
