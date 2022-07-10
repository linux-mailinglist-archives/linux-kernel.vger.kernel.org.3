Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAD456CF9B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 17:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiGJPEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 11:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiGJPDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 11:03:54 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C175464D9;
        Sun, 10 Jul 2022 08:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657465410;
        bh=ZCtUUJ2Kv6ZjMvVyjn9DfppbcpxqyAsK7G92RHDx1TY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=jw6XYssfLAglNQGipFi5jLqgdiiMnJ8TdSA/TbmLrPe8j8L88EeCgfX/211cpKG9o
         8Mg8/kyqpcQTVsftNZUCF0EYVIF07y88+W3UdQ73qM+ror61c2hvGkBqnp3E3b7Y/u
         6f6oyDA5R8SFcTjvH+9zWPqFGpCLkDAUh3wQP9VM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([46.223.3.243]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M9o1v-1oGLtk43TZ-005pJ2; Sun, 10 Jul 2022 17:03:30 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     ilpo.jarvinen@linux.intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH v3 2/8] serial: ar933x: Remove superfluous code in ar933x_config_rs485()
Date:   Sun, 10 Jul 2022 17:03:16 +0200
Message-Id: <20220710150322.2846170-3-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220710150322.2846170-1-LinoSanfilippo@gmx.de>
References: <20220710150322.2846170-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:5+Dw2l9RAjF2laNlcFk/awBskO8xgbsTtkjwp1p4X1ML/yUYLsC
 uYpA5UA9E/xyAWxjOhpkVLgrmHBBbK800tPqkHHZWFAl4NPI3aifM0R34o9PONbwnJWOTn8
 XPwJqHpvgmWfa67n+dTla0usEBzOoMcgSHR6lIjnvchK/47CbWjW4t2rO8+YHxNdGajjl/s
 KO5b3VUol/StOq67lcOKQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XU3LuT5bwyE=:oPva1eHjwj68X7wuD47dF6
 pF2kEzoKom312Ga/WZCT/tOkg2HMHNiNo4pt6IFcT/XRQ0pwt1ufsuFwqjuvpm+q5xnmPHrYZ
 5VGbiveauePGnxs9OUpqxo81tyGpgJTlz2gvOa5Y/V1XgG9YRZCom/BNRu5pq5fGRlMF+pY6x
 Gcv+dRCaIsTlNYMmE/ua9Giku/StUmCIT5nVwm+6aXA4fM9jPlWGHsJ5yVYWLRaGSoAgxHnuE
 pYDZNrKpOf37Qwn+fIVViFjmr9uHM7O0UKSBSwtfrQ74aAtA1whsjzq7iOG4Pkpc+dRAIfK2P
 IlKIlKx1TS7jYyLm90NuCTN4Gz5SxMxO3SEDhB6eA4c2hEZeXw3xUH2RHywQ4eYDMXJ7rigJi
 OBGrTdQFUGfhFogcoIdZvDLNLe1PmGjbSiirhHOjV6aJqyjNubgjezlanljAREBkqq8apFTcP
 ZRu+303xgDdwkziojov1l3Di9m9xKQ5uEdT/1dS2xNmyBBturUTi/xmwDDImo2psYtNxexIhS
 pl8Opjubh/W/tLZp0HUBVXbqzc+wGEPY/8ftcs7jWrzAuWqVCwrV0jH1w1IQrB6a9E5rRkvKY
 MF3vi5/0+v1RglZH7YPBhgYEOqdP7UQGtdq9IdzpTsHkmxkCfb4nxMXgjLRiDIINDqxiw+Kqq
 CuhW/n6OrnjarJQVYki3DMOD5SvfvjaxXXBEJth6FsBgTl1+uyh/5ma8u/Yvrdghy428yhArp
 ybvHmYsYJ8aouDhiuBsgr69TMceuX9Hj81OOhkmgdI+yIUBnMbAvrEoyLN81CANnQtAml6wB8
 5DSfR+ODW5T5O3mi7O0TBPaX5r6CsFJ7OWWOQoXzPk7T59X/UcNXJx+bjcsybvAY75uR1SH3N
 2eC6Wk1VhKa4+et+PT8Z+aPZlRngZ8Mb0YVn6ToqYZHyHU/MVVyuyLY9KXddMaFCoZYVVLcsF
 eVt7DGJByLC4zuMd9gnd75gFEV6qVFCSz1y0NHwnyicy6faRs7uXzDgdqb8UBeqg/wgBDhwcs
 5i1/w9DA9WNzfQJ63yeFVHXvj/ZRo645wHZQGjnVGzin5BxsArOv7Tinkv50syZ0SMdj8sHzl
 X1sVZ4KcDYnlaM7HSKZc5O6BB0TDuA00O/vRWFFDA3OvgBFUi7wJHe69g==
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
