Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F764906ED
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 12:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbiAQLJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 06:09:14 -0500
Received: from azure-sdnproxy.icoremail.net ([52.175.55.52]:46398 "HELO
        azure-sdnproxy-2.icoremail.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with SMTP id S231462AbiAQLJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 06:09:13 -0500
X-Greylist: delayed 106296 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Jan 2022 06:09:12 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=A4rxap7D7W0NV3KRRx4mhrWTTta+gRdKYYvLiJ1kGq8=; b=n
        4tPhhyShJi6eKZEk2nRR3lgWTWNLVtRNO8WhSnbnFCXeTz6Ze4yW04cG5BWvnauj
        Eq8K9SUcivuOAtPpQSMvzz0gibMDmpaGuomSFlzZ8DVqJ6mcM0lKanRL6H+fF/oa
        ejhPTcdPsGzKcyX//HIB4I+gB54pd6dfrHU8glC/Ks=
Received: from localhost (unknown [10.129.21.144])
        by front02 (Coremail) with SMTP id 54FpogBXXQHZTeVhvx1nAA--.43502S2;
        Mon, 17 Jan 2022 19:07:05 +0800 (CST)
From:   Yongzhi Liu <lyz_cs@pku.edu.cn>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, lyz_cs@pku.edu.cn
Subject: [PATCH] driver core: Add missing pm_runtime_put_noidle
Date:   Mon, 17 Jan 2022 03:07:03 -0800
Message-Id: <1642417623-5393-1-git-send-email-lyz_cs@pku.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: 54FpogBXXQHZTeVhvx1nAA--.43502S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYF7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE-syl42xK
        82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VWkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnU
        UI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: irzqijirqukmo6sn3hxhgxhubq/1tbiAwEEBlPy7t9+qgAWsS
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pm_runtime_get_noresume() in device_shutdown increments the
runtime PM usage counter, thus a matching decrement is needed
to keep the counter balanced.

Signed-off-by: Yongzhi Liu <lyz_cs@pku.edu.cn>
---
 drivers/base/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index fd034d7..29950bd 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4523,6 +4523,8 @@ void device_shutdown(void)
 			dev->driver->shutdown(dev);
 		}
 
+		pm_runtime_put_noidle(dev);
+
 		device_unlock(dev);
 		if (parent)
 			device_unlock(parent);
-- 
2.7.4

