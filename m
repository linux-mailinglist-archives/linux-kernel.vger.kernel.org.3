Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A272E56D01D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 18:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiGJQp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 12:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiGJQpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 12:45:17 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3F213D47;
        Sun, 10 Jul 2022 09:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657471496;
        bh=ZCtUUJ2Kv6ZjMvVyjn9DfppbcpxqyAsK7G92RHDx1TY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=JGGkWd/jM0pG0LWxjd7k9w7t5glUGXZzlhWE9RRWZZyaFgLTnxEDEP8vU+2dh3MHf
         ZdmE1R1joGkfVkyy2argi/BCJD9nHxat/2pquIoNGhq/f1/V3zhXOvJDefFMSi79sZ
         WNQnHNW53ZheDKXVac4lpxPUyY1iRAmXJvKBYNcU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([46.223.3.243]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MVNB1-1o2A9Q49I7-00SQZn; Sun, 10 Jul 2022 18:44:56 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     ilpo.jarvinen@linux.intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH v4 2/8] serial: ar933x: Remove superfluous code in ar933x_config_rs485()
Date:   Sun, 10 Jul 2022 18:44:36 +0200
Message-Id: <20220710164442.2958979-3-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220710164442.2958979-1-LinoSanfilippo@gmx.de>
References: <20220710164442.2958979-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:r71Y1Fa5+bqyqmrpIVp46cCXbjgLbualWjO7kFiDHpXTHV4AgxL
 y9UmxiUFpQ1S2+KC9WGMkyl8taGMpgAC5JRJ6p6U61xQF3DRerAUoyF68q/NFSmDsToCm7j
 dtIIzPXpVfXwVyHzsmEKcSGpNZTmiIhcnBDATLy+L2gR3aXFgt2VvLS/UKv3DzPUVn7Fci4
 jngSzgZzyFVM81n3hVcUA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FBqw/QsEZZ8=:oJNlPyo1dppbsym9tRb28/
 YOixVQmOZWGxJhk1emE83AqsvTTTXRO83v+Lrk0N+0nIXqgRSwhW11pXxBJMmL54yknZ//Wep
 whPsyoJhXW1ZIDNQsTKEqnwAdsBq+n/SNx3zRC1cKW4Eqd8z5QFzUv+fQ/61A1bZI7bYRFYAi
 Alj5VQkzNpk9SV2OlMWItiOhtt2t4uyRfOVcK06VF7FTRWkaHWbuUfCmtddCV7hdVdomYOWxp
 gJ42E6tB7a9l9KdzVvHxu8CLggJ6ukPV5B1M1l2Wsw0MBfttJd3huUjwch2SmWSlYSy/FNwEF
 O+uR0RftEelJg6Q6UTp39eicHUI0Z7ek2RNXWq0wNRGxfPWeEOfimIoamoqq/48m3dJpNE7S5
 l7mlvc1gMJsL/dSimjfVavELguSnEgVhw6xnfGNVsA3BQf4vQ+haENamd8lb+fjdA99P7p5bi
 e7SLqQj+U7YjotI8kwPlkAotDPTGlhFV3sKIbzOz02JdrClaSaq0PLYxswGx/q48s8T7chIbT
 0p37B4eIEITHOjMcXoo3cIOyVfmHylm/5xKBZc0ZoWW52hmOVhyWNsnWexDC+mR4UxKerrn5H
 IefXm2ZB/6/g+bMo0OyVRY2Ge6H+qvkSwqNOXYNbMKNKEGAbxZ600vaZcMKPM22J+gBIT6Jqt
 NyUubsMeAqOzH3Ym3iCuEb9v89wTR+jEPM4mc4/0lZtcffSafOLKygaM5b449P3v5GFcpoyiW
 y5cVm2v8VMDlSdRptPwEAriRuQPNmE/qgRilQMN0yVXHnwXX3RdpFvAdQHTE9s5LYPxIaVamb
 njwuI2xjsuWrVLN/f30uE8ebjoWYX+6lGdTvbYb8Rgfz4KbpnpfJO9BCVheeodlNo8VYzWoM4
 E3O5498CjdmUvbWwkuo4IS/jfGX/z0CsiQ1IlvY7GOuN77xqIJd+wKrC4GCGmhe4XZSDW81S4
 dWXC0v35YUA+0dxMGB875LZP/du92xWEer9Z5OYGixv8ya1v5eMGMTQq4NkfJDxXSGqiF80rX
 fPV3K8/F33g5rhjbLxdyjqTQOd2rxqVdVnlpOz9C7O0hyyySR1tLwtMwz5kGFFOvm3/8MFbVW
 dNQ/hKHHmZWWwPY+eSw3kGiizegQ+nBikhchkziCuZKwYIisNxCl+zjeA==
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCkluIGFyOTMz
eF9jb25maWdfcnM0ODUoKSB0aGUgY2hlY2sgZm9yIHRoZSBSVFMgR1BJTyBpcyBub3QgbmVlZGVk
IHNpbmNlIGluCmNhc2UgdGhlIEdQSU8gaXMgbm90IGF2YWlsYWJsZSBhdCBkcml2ZXIgaW5pdCBh
cjkzM3hfbm9fcnM0ODUgaXMgYXNzaWduZWQKdG8gcG9ydC0+cnM0ODVfc3VwcG9ydGVkIGFuZCB0
aGlzIGZ1bmN0aW9uIGlzIG5ldmVyIGNhbGxlZC4gU28gcmVtb3ZlIHRoZQpjaGVjay4KCkFsc28g
aW4gdWFydF9zZXRfcnM0ODVfY29uZmlnKCkgdGhlIHNlcmlhbCBjb3JlIGFscmVhZHkgYXNzaWdu
cyB0aGUgcGFzc2VkCnNlcmlhbF9yczQ4NSBzdHJ1Y3QgdG8gdGhlIHVhcnQgcG9ydC4gU28gcmVt
b3ZlIHRoZSBhc3NpZ25tZW50IGluIHRoZQpkcml2ZXJzIHJzNDg1X2NvbmZpZygpIGZ1bmN0aW9u
IHRvIGF2b2lkIHJlZHVuZGFuY3kuCgpTaWduZWQtb2ZmLWJ5OiBMaW5vIFNhbmZpbGlwcG8gPGwu
c2FuZmlsaXBwb0BrdW5idXMuY29tPgotLS0KIGRyaXZlcnMvdHR5L3NlcmlhbC9hcjkzM3hfdWFy
dC5jIHwgOSAtLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA5IGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC9hcjkzM3hfdWFydC5jIGIvZHJpdmVycy90dHkvc2Vy
aWFsL2FyOTMzeF91YXJ0LmMKaW5kZXggZjdiNDYzOGQ2OWU1Li4zMmNhZWFjMTI5ODUgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC9hcjkzM3hfdWFydC5jCisrKyBiL2RyaXZlcnMvdHR5
L3NlcmlhbC9hcjkzM3hfdWFydC5jCkBAIC01ODMsMTUgKzU4Myw2IEBAIHN0YXRpYyBjb25zdCBz
dHJ1Y3QgdWFydF9vcHMgYXI5MzN4X3VhcnRfb3BzID0gewogc3RhdGljIGludCBhcjkzM3hfY29u
ZmlnX3JzNDg1KHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQsIHN0cnVjdCBrdGVybWlvcyAqdGVybWlv
cywKIAkJCQlzdHJ1Y3Qgc2VyaWFsX3JzNDg1ICpyczQ4NWNvbmYpCiB7Ci0Jc3RydWN0IGFyOTMz
eF91YXJ0X3BvcnQgKnVwID0KLQkJY29udGFpbmVyX29mKHBvcnQsIHN0cnVjdCBhcjkzM3hfdWFy
dF9wb3J0LCBwb3J0KTsKLQotCWlmICgocnM0ODVjb25mLT5mbGFncyAmIFNFUl9SUzQ4NV9FTkFC
TEVEKSAmJgotCSAgICAhdXAtPnJ0c19ncGlvZCkgewotCQlkZXZfZXJyKHBvcnQtPmRldiwgIlJT
NDg1IG5lZWRzIHJ0cy1ncGlvXG4iKTsKLQkJcmV0dXJuIDE7Ci0JfQotCXBvcnQtPnJzNDg1ID0g
KnJzNDg1Y29uZjsKIAlyZXR1cm4gMDsKIH0KIAotLSAKMi4yNS4xCgo=
