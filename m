Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1012495222
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 17:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376912AbiATQPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 11:15:04 -0500
Received: from box.trvn.ru ([194.87.146.52]:40881 "EHLO box.trvn.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346641AbiATQPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 11:15:03 -0500
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 4D5C240CAF;
        Thu, 20 Jan 2022 21:15:00 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1642695300; bh=qRBTVa7l5ff9cDGlC0cX/AXh5ZL9DuXAiZdGpUFlRDY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EcTC13JvJaGcwHmO/Cwi99a6NtK7ub1sifv+M8uupubmAPN7sbxQQnnXVe014k5Uf
         FdjJ9yl9DZG2v4GilGKXGnybJLG55IQPH9iIIkl5GCnXEMeXK4pOLd7cUW9MLzpdoJ
         kCR9dGPIDlDzTO6EV5eJag5q9dyhhgL2S/I8bOTSboskUYwqwOaEfPaf3o3mgepylj
         UN5qMnr/UyiwXriimO/i8LTWFZ41iRn58PHNpTnctz5A1iLLmbvsie2H/iMgU62TAO
         ZGij6xiEqGE8qI2cKwY7wMf3Fcv+RG/xS6LbGZLCLfdAS1AMkJN1/SIIUUpNu5EewG
         7L6E86pYCa8xA==
From:   Nikita Travkin <nikita@trvn.ru>
To:     thierry.reding@gmail.com, lee.jones@linaro.org
Cc:     u.kleine-koenig@pengutronix.de, robh+dt@kernel.org,
        sboyd@kernel.org, krzk@kernel.org, linus.walleij@linaro.org,
        masneyb@onstation.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v3 1/3] dt-bindings: pwm: Fix node name pattern
Date:   Thu, 20 Jan 2022 21:14:40 +0500
Message-Id: <20220120161442.140800-2-nikita@trvn.ru>
In-Reply-To: <20220120161442.140800-1-nikita@trvn.ru>
References: <20220120161442.140800-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like it was intended to allow two types of node names with the
binding:

 - With unit address, e.g. pwm@1f000000
 - With a suffix, e.g. pwm-clk

However the pattern regex only correctly matches the first variant,
as well as some incorrect ones.

Fix the regex to match only two patterns shown above. (Either unit
address starting with @ and following with one or more hexademical
digit or arbitrary suffix stating with - and at least one symbol long)

Fixes: 89650a1e3b6f ("dt-bindings: pwm: Convert PWM bindings to json-schema")
Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 Documentation/devicetree/bindings/pwm/pwm.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm.yaml b/Documentation/devicetree/bindings/pwm/pwm.yaml
index 3c01f85029e5..4926fe65886f 100644
--- a/Documentation/devicetree/bindings/pwm/pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm.yaml
@@ -13,7 +13,7 @@ select: false
 
 properties:
   $nodename:
-    pattern: "^pwm(@.*|-[0-9a-f])*$"
+    pattern: "^pwm(@[0-9a-f]+|-.+)?$"
 
   "#pwm-cells":
     description:
-- 
2.30.2

