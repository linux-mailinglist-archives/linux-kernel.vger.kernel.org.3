Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A19F4E6FB1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 09:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343692AbiCYI6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 04:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiCYI57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 04:57:59 -0400
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1998CD321
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 01:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1648198581;
        bh=DgLAnYgqjoM4AGSmu3Sc6+ngc8WyuI9dDOEV/Xp0GDY=;
        h=From:To:Cc:Subject:Date;
        b=Y+jcMMOY3yb/9VPHBubyBshdnPAe+XQmJ1yhT52uEE9Fm7szyoiPl9dMpsu3zDObi
         tVmA+EHaZcOCuJu/6sEfVmb8i1/G0QxLBpMXY1oygO8Gtp4Bvc16e2x40gTutoGKRz
         LS70+zv/6EC2zXDXPJYffoKDNwI2gxBhn/yXs+Io=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrszc11.qq.com (NewEsmtp) with SMTP
        id E0F8E616; Fri, 25 Mar 2022 16:56:15 +0800
X-QQ-mid: xmsmtpt1648198575tr71poz2m
Message-ID: <tencent_1D9E7394538085872BE9FD6780483137E70A@qq.com>
X-QQ-XMAILINFO: NQR8mRxMnur9+4HHGI5DBsw11FVsz9FqPSQt4NfwIwKTIa/TEmwAEoWffMfTS9
         6mQPgPCzRKkTXdfKK5A/b5bddX6a/8pLe+oGAO6tgN8xJdbouFE/D3ICYynyVFtVVFHTDNmWAwQF
         3d9hdo+MzrPNvkGjUyad1+bgEQ0H0jgn/ixA940rReW+kH6V1jRopguw6BmWgummK9Lt5CyEOPOw
         3IaqVlgP1qQPvFp7PmAnIChv2ChFb/Od9pcTwkso0KPraMqL0z4LtKDpa4gcS9v0dUryZqJp2OkA
         G8d/rXhEyMdB16SsECYUzVVpC83NHPttTBiDHME81zpGbNelWWyv6Zgwbh5dQpKWkiBh0T8mzBdr
         wuNERk2CEoQIc1y3dVlc6nOr6/Hik+t+AZ7mfzuage5O4LfHi7Sf9RQMIZRxkY9SjQ0PxJHIm+oy
         oQjgOacNfpwwin1hBrtO07yaPtt29oY5aqv+mV4rCGz287ymmR7lL9CyEEnOL1XAJDRtBuFSF0vi
         qOUiEKSFN5E33hwBRpW+zJR1paR1XHGjRpeEjNfw23j0J38NCA7Db7VoaTqkmJoTAkCcmqVvmXYF
         uPT/j320DYscqlDTA2KcEXyhLSM0te4+oQGWBst4Ky3uTzN+04+PKWP90Y0bp9QdAyS6LIiMQYsI
         tGKxoucmdbp3XDfzuG3LQardQLf93pWe13HgnAsuxmQ8FttbZwTRidDNJXCb+L6Ux+0YMY5bDCvG
         MGFUtDqMCp5VAigOEUy/DNbRXDQyR0tPTv1ZMNJKc0B05wmgTtMMyNTpzBcLUM0OhTzN2wV0W77g
         u09knU6bm6jK+Eok/mKCDHSmoKMQdNv2fRqm7G9TYP375HfyAN2jV9RV65xPmuP6xZUNee0VHAtf
         BaCXkhSbH/OpvburTa3CYcc8KqiTOYUmil8aDdpBF5r/WxK6/rtulM3HNDsZiCnOr8Mw+qN9iGqp
         iRRbtAUcA=
From:   xkernel.wang@foxmail.com
To:     andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com
Cc:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] ARM: mvebu: check the validation of memory allocation
Date:   Fri, 25 Mar 2022 16:55:18 +0800
X-OQ-MSGID: <20220325085518.4016-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

kzalloc() and kstrdup() are memory allocation functions which can return
NULL when some internal memory errors happen. So it is better to check
the return value of them to prevent potential wrong memory access or
memory leak.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 arch/arm/mach-mvebu/board-v7.c  | 8 ++++++++
 arch/arm/mach-mvebu/coherency.c | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
index d2df5ef..86d1f4e 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -128,11 +128,19 @@ static void __init i2c_quirk(void)
 		struct property *new_compat;
 
 		new_compat = kzalloc(sizeof(*new_compat), GFP_KERNEL);
+		if (!new_compat)
+			continue;
 
 		new_compat->name = kstrdup("compatible", GFP_KERNEL);
 		new_compat->length = sizeof("marvell,mv78230-a0-i2c");
 		new_compat->value = kstrdup("marvell,mv78230-a0-i2c",
 						GFP_KERNEL);
+		if (!new_compat->name || !new_compat->value) {
+			kfree(new_compat->name);
+			kfree(new_compat->value);
+			kfree(new_compat);
+			continue;
+		}
 
 		of_update_property(np, new_compat);
 	}
diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
index 49e3c8d..eb6b349 100644
--- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -194,7 +194,13 @@ static void __init armada_375_380_coherency_init(struct device_node *np)
 		struct property *p;
 
 		p = kzalloc(sizeof(*p), GFP_KERNEL);
+		if (!p)
+			continue;
 		p->name = kstrdup("arm,io-coherent", GFP_KERNEL);
+		if (!p->name) {
+			kfree(p);
+			continue;
+		}
 		of_add_property(cache_dn, p);
 	}
 }
-- 
