Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4262856CF8B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 17:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiGJPDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 11:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiGJPDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 11:03:52 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FE3646A;
        Sun, 10 Jul 2022 08:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657465409;
        bh=hAdqGU4U+jT6aGvJmg4F8iA5nfZQBLISiVM3W5oMaNA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Kil0ihi8CLg1hcV0Bl0c1mDxb2dKaqNRKuE27ch/sIBtNMMhpbYDIn4qMFG63ssip
         Pr66aA3J5hVV7P+361zFUUhhxJ+wUBuYDisn2e4MXCBQGJwXlO3MR2GiQbuu3E7nbi
         guDRiovY02jPKO8mWMKhX4UsP0ZwR7BTe0I7LhS8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([46.223.3.243]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MSt8W-1nzzoN2Ps6-00UKK3; Sun, 10 Jul 2022 17:03:29 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     ilpo.jarvinen@linux.intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH v3 1/8] serial: ar933x: Fix check for RS485 support
Date:   Sun, 10 Jul 2022 17:03:15 +0200
Message-Id: <20220710150322.2846170-2-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220710150322.2846170-1-LinoSanfilippo@gmx.de>
References: <20220710150322.2846170-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:/MJtYd9AOLMxStE6KfPlSbTQ5/sUlYRb1gizfNtMnSPE2eDXq1d
 AHprNBtSvZqtfdaik5Wo4jzS+CQRcd8sR0JrpZ2ximJ390D1vM7Ls4jxarMRh5bvIuIiJbG
 5wh/GkBARbYtEY4oZEnnS8m+kH4ji1piOcMb2h3qtQEKRNruFc4b1EEG6oNZs608MabR3vQ
 RpBtHr6OKqkjKlf4hHAhA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SMNcpCrW+ro=:D8ly5GJ6LkIiAGR6E2Lbb9
 ZSZWX1ruKyu3mKj7vvd3iada97G+Ma+3yiq90E/pLcwm5DugFkiKMpDgIX6oxn0FYJO5dT//m
 5rpuLCwfhJc7PCj9rEBRAdiNYdW/oAyMte2v7S21COWiZCJX5OJBUHBWjk/hl8uJe7SH+jgb2
 f0uO7yHOY5Nc70GaBQlYrP+c6vLYYcknHFkd4mrYONjFxRM9NiZE1LQKxSB76SrgL6MEGSpu+
 fegmOTBzMfdAAeDPG9zpG8kiv/kzqG8k9+D4PiIFhmjyWBCSTz/837ZdrbAkKlbikNOvUN/Lo
 T7/Ld7tXLaO7JhLy8N9wUJKg9kty5Dn3uR1ImgH18Lzc6RLiTn++gkDcZJTVdrkYw/QxkGzQZ
 LVTa+UkrOF8tWiFiLw6bkag1wvPSbazoVMK/wKQogRWXdjfiegUseUlHvMfpjDIcBWT29I0kc
 CstLM9/uGo43sVNKRj643WT0JEY+YQIQK4VBqYNji2IE/HMFnJZFDn+Lf18QFZXrp9p2WXEwU
 3HZ8XLfUXRqXOOoMTcmA5H0NIVKts2m+aeEItZ17Wrrm2DdcqNVXXq6GRaNjFNCjDHaCorr0U
 ZaQu2t7JeV8gHLzDPLcdQ1WSDjKMg1O7CQhyqoEeby/xatCLTUVakeQitNLbBNnq2SjXgjyoc
 pXPlZPecumjoeRux+teq6CHAsX3cHPe7ddc1NqWKOtnIYvbJUK3asHL3xbnVvPu8lCE6CIytA
 6ocdCPBXRrsNPSh0F7AN6B1Nswtb6313oVH1WNWoJophntkCsGHtaareel161m/cMKuYL8bWv
 M5J06TFDUCEvOQSvz4ZnAyfbfGW46RxF/NGeYBU5sk9ooUSMX2xOWiTwY62ogYXKEAXzjHJ7Z
 qB2K7ENeKPXZqMGriOXoR1gQpKYQ2f60HGb/wEtssSH5Q7JjLVrNn4nlcflSp43y9G62Ty3Ab
 B5YJ0fgSPSWcTxziQJa92TXC1gHvWzmTLbjLij6ZWBvJGERLeGPW2AiUNr+s126b6hm32P41i
 gvJVdqTWg7SlvhtUP/xtrl3IaT5KVp2+pPD9rfsdw33dko9Ps8vatENNU6KGwWTX8wz69eYKk
 0DC0ZmjnA4ZLep2WXeO2gBKxlZtTE69CReGIiK9TfOmj1M4S0pb6Ik6vA==
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KClJTNDg1IGlz
IG5vdCBwb3NzaWJsZSB3aXRob3V0IGFuIFJUUyBHUElPIHJlZ2FyZGxlc3Mgb2Ygd2hldGhlciBS
UzQ4NSBpcwplbmFibGVkIGF0IGJvb3QgdGltZSBvciBub3QuIFNvIGNvcnJlY3QgdGhlIGNvbmNl
cm5pbmcgY2hlY2sgaW4gdGhlIHByb2JlKCkKZnVuY3Rpb24uCgpGaXhlczogZTg0OTE0NWUxZmRk
ICgic2VyaWFsOiBhcjkzM3g6IEZpbGwgaW4gcnM0ODVfc3VwcG9ydGVkIikKU2lnbmVkLW9mZi1i
eTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KLS0tCiBkcml2ZXJz
L3R0eS9zZXJpYWwvYXI5MzN4X3VhcnQuYyB8IDkgKysrKystLS0tCiAxIGZpbGUgY2hhbmdlZCwg
NSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5
L3NlcmlhbC9hcjkzM3hfdWFydC5jIGIvZHJpdmVycy90dHkvc2VyaWFsL2FyOTMzeF91YXJ0LmMK
aW5kZXggZjkzMWVjYmMwYmMwLi5mN2I0NjM4ZDY5ZTUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdHR5
L3NlcmlhbC9hcjkzM3hfdWFydC5jCisrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9hcjkzM3hfdWFy
dC5jCkBAIC03OTgsMTEgKzc5OCwxMiBAQCBzdGF0aWMgaW50IGFyOTMzeF91YXJ0X3Byb2JlKHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiAKIAl1cC0+cnRzX2dwaW9kID0gbWN0cmxfZ3Bp
b190b19ncGlvZCh1cC0+Z3Bpb3MsIFVBUlRfR1BJT19SVFMpOwogCi0JaWYgKChwb3J0LT5yczQ4
NS5mbGFncyAmIFNFUl9SUzQ4NV9FTkFCTEVEKSAmJgotCSAgICAhdXAtPnJ0c19ncGlvZCkgewot
CQlkZXZfZXJyKCZwZGV2LT5kZXYsICJsYWNraW5nIHJ0cy1ncGlvLCBkaXNhYmxpbmcgUlM0ODVc
biIpOwotCQlwb3J0LT5yczQ4NS5mbGFncyAmPSB+U0VSX1JTNDg1X0VOQUJMRUQ7CisJaWYgKCF1
cC0+cnRzX2dwaW9kKSB7CiAJCXBvcnQtPnJzNDg1X3N1cHBvcnRlZCA9IGFyOTMzeF9ub19yczQ4
NTsKKwkJaWYgKHBvcnQtPnJzNDg1LmZsYWdzICYgU0VSX1JTNDg1X0VOQUJMRUQpIHsKKwkJCWRl
dl9lcnIoJnBkZXYtPmRldiwgImxhY2tpbmcgcnRzLWdwaW8sIGRpc2FibGluZyBSUzQ4NVxuIik7
CisJCQlwb3J0LT5yczQ4NS5mbGFncyAmPSB+U0VSX1JTNDg1X0VOQUJMRUQ7CisJCX0KIAl9CiAK
ICNpZmRlZiBDT05GSUdfU0VSSUFMX0FSOTMzWF9DT05TT0xFCi0tIAoyLjI1LjEKCg==
