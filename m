Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1ED56D027
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 18:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiGJQpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 12:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiGJQpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 12:45:19 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB7C11C2D;
        Sun, 10 Jul 2022 09:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657471495;
        bh=hAdqGU4U+jT6aGvJmg4F8iA5nfZQBLISiVM3W5oMaNA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=OydU4uFMRVmBaBd5ZGwffSMy5f4n+68pgkh7Iiqjos30Zn3ncHGuPs0ndyTNMT3aG
         sUb7lDfPRJs7yqFGGMUUl/CAbigg5OvLoZO86+8/pSnndhjWjmzS1WoiSsmjuQte1D
         cqPGIZrV3TUun3qbtv0tC3ckcDqYr1v4ko43weno=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([46.223.3.243]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MdNY8-1nbWLf2Mwi-00ZLAi; Sun, 10 Jul 2022 18:44:55 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     ilpo.jarvinen@linux.intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH v4 1/8] serial: ar933x: Fix check for RS485 support
Date:   Sun, 10 Jul 2022 18:44:35 +0200
Message-Id: <20220710164442.2958979-2-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220710164442.2958979-1-LinoSanfilippo@gmx.de>
References: <20220710164442.2958979-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:ZxsMwkh/sJADzwFan2bdA9wzNHS6P+rSo+WssaVRYFj38vGWgMf
 wVi4wI0mpq9PNuOMR76MsXg2GaYhfAJ/BJ6w4brCMstaprAQrglDqlnfDMgU+rTS5NU+fTr
 v9Ya3YqcILGefrM0xiq9v9LufwgIo5SIGd9Wtr2NbWsXFOrQj8ejkfcS+r6uXqjSiM6cqQG
 S9xQzRcpM/PmSDM0XsKag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8guffhWWUw8=:GZ+9TKPh6447V7e/IdCQKx
 QKHA56c6YekXHaCsl5+F4uBa0nI3RhzQn9VbpMtHimASFnU1BdamhtMSu73ek04baiBexwtr+
 EWWQtdyfYLmL5T1xIKQoipZDQb2YDtTK8LXe0b0eIH+sf0DWLGgKKZ0K82K8WT4r3ScFRLhIg
 u3YDYQjGelsBZFt5+BQwpVgRzk45TOJBeK83X6FmlwK4oViAuA8NiMUPhHd6bX/W8QMiTfeu5
 YdgKlATDxQQwIBudiO/SaQqD13yFL3xT2z/A/YoUszLrZUE4lgq2aCX+MjWdpH9ES1nZ+kZBf
 0GaSGy9SISLcdUvkJPXgqTCCGhbB3CKvAwaXbNAmynW/SQNijdiPUeypynukdULSIjLFG+eox
 RyZL1Vhwsg/ycB973Cj0qWjOh65xEz5IHidq1NnmmRT5pePJKFan3vw41uFFq12F6twBW/TmK
 s+8czWivVkj6COdhKynfLwi03TQBvs3XTbkHkU3mQRBeWaXdhwsT4++xVFVbCN1AuT+0c4o1E
 wZ1cZr3ORDIR4vK0IRMapz6iRX1cLWDSA+fzpUzIG51YYRH3eocMGLZ1eS1IbZyeZ1ZGI8fBj
 xN0Rx76lVo4mRKWX4lwd0XbieSi9hDkzZ7kB0ViAHMv1p/g0FG3dcDAXdCa8JHnQcER1QHuta
 dMrKRNJTa3Ns/ZdopV4tYkEhGYraChwqTk1zvxgdZsVTtdcl+NLb2Mo2xsBC+ANk5kyfGsW6s
 HfDGgfuZS4wz3eGFiXVm6sMr5QDeTK9G6wS05WGx5vcuFFlkUU7zWwQhINz4TNWQvPhUkSJab
 Kvy+bM5vP2yEZG0yVOa0cdHyuf3UHyLJs1hkd/oeaHw1VrTag+D3SLAU+Yy5werv8k/iSyHBn
 7BEIzlujnlPFyxx4lqAeJorhQ2PajoavjjtXC1XHqEBTi6mlksMRMIucKXSXDQkBjUXV2MN6N
 Feu/M+ACjvY1eNwCcyu2O0hwLh59ZrV0dPHb+SZAUFzIRdADC6EUpoAcxISoZFFyrud8nmb6p
 tumKGMo/L/7baxD6MAlVEFx7MgQVeqD8UvQxG4UwozsiMUcA02pA9KXqO0i4K5C6VnLfCvu8Z
 L/mF0qSbKIV37YndJpNVkBex/CtwfRPwZ1dMyhvbacRqK+1tFrnSJZILA==
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
