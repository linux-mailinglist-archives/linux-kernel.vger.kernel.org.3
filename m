Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE0D471A31
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 13:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhLLMuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 07:50:01 -0500
Received: from xmbgsz5.mail.qq.com ([113.108.92.87]:43731 "EHLO
        xmbgsz5.mail.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhLLMuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 07:50:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1639313387;
        bh=k1stlU6EVWu2wzaYWiETbC6tqZhu0+niTrh2/gq6ttY=;
        h=From:To:Cc:Subject:Date;
        b=zt51Bg9R5WkuPxzixFR5hBJl5h+5RermXbclu7AU7cldVluCUrkJrFNqPsMampVsm
         pWkLIVlb071aXK/0vE+RdQTO3IJHQn9H3Cn3/ZlsQ4hb8aDu1CM50QkaO6w9cuhCX+
         dQpt9erQo2NqCl9CFdUs2JI+wbYQMpj2QYCWsM1U=
Received: from localhost.localdomain ([43.227.136.188])
        by newxmesmtplogicsvrsza9.qq.com (NewEsmtp) with SMTP
        id B229C805; Sun, 12 Dec 2021 19:44:34 +0800
X-QQ-mid: xmsmtpt1639309474ta5ne42z8
Message-ID: <tencent_765F05E486793F9790A388C2289C5429F705@qq.com>
X-QQ-XMAILINFO: OBvbJS/7aDyUMRq+jMxLd++o3zaqu1/4WeWHFvGjy7uzkKcvfrnxHSKSY2l1KX
         +HYyYNiCbPMseu11dn10t6KB7fkjhQxZZqkFJd90c4bu26Mz3NdzGPklf6e6UchZ5H27Z3jlzHFK
         eAEO9hx8UUrfK2GYIldP6nccwUUjhSpz4aESTteiDZtp04q9U5LwodZRP1hgVdHgWJv0D4gRwhNO
         ArycaQRM9JJwIQc8adZC6FtOquT80lY8XUgY27ZwfmshhDVDVLM2wB+8o90l/P+5hOEXlKIywqF9
         T/z/4dSmlvRvoN4F+HxW14MFEFa/Hna/4l6xZYJVfm4n1fHhuBVtGwWnwNFgnkXHvWYOI41w4/Ar
         m4WSVzXiKcaYaaXNsVrJ0/CJjrKA9e0I2AMv0kTnpEJ9zP9gQyhtFH3acOAOKxBH9GHv5tQ8WV6w
         0heI0sVDDhQ5gvMgJjXnPQMl3MA6TVIWSFJe6cnVlwuDnsHvxt2B8jQrroWNXTLgzpuvVJpfQpTb
         DVVL9OCGu82yK3+kC18t6pyVgn372npmVFDggv5bAZUohwO/Ez9HnH5bMysKOM3xUvxrz+H9kRAF
         C9FJJJKARqYeSbanbLQjMCqube2Z7aBg4bxrUD/1/twl5efuS9OfYo6ZWiD/Nmizs0N24w6EyBeD
         Mz8Y0eCcPPQzyGqnyoOyzgDNpEbytNud6eiCU7EOyM54YZVAJcVhDDmHvUqzkUF0kXmbmXaPMENA
         igQYAL+Dmz0Q23W4L41sUV4FKTaFyTtccUN+SLcAlvcBBRy2K39Ytg5XGuxBEhZe1ndPPXlgJbB7
         jpqwxCs974q9zmVXcJJJSFJ1zZ/+ByjJzz+x7bPqUgHbCSIc7wrr3p9y0jFjOuCan7ANr8d1woz9
         2lbsx5OpKx9MJDyL2fJQw=
From:   xkernel <xkernel.wang@foxmail.com>
To:     agust@denx.de
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        xkernel <xkernel.wang@foxmail.com>
Subject: [PATCH] powerpc: mpc52xx_gpt: fix a potential memory leak
Date:   Sun, 12 Dec 2021 19:43:39 +0800
X-OQ-MSGID: <20211212114339.1693-1-xkernel.wang@foxmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When some internal memory errors happend in of_iomap(), we should free
gpt to prevent memory leak.

Signed-off-by: xkernel <xkernel.wang@foxmail.com>
---
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
index f862b48..c506cfd 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
@@ -722,8 +722,10 @@ static int mpc52xx_gpt_probe(struct platform_device *ofdev)
 	gpt->dev = &ofdev->dev;
 	gpt->ipb_freq = mpc5xxx_get_bus_frequency(ofdev->dev.of_node);
 	gpt->regs = of_iomap(ofdev->dev.of_node, 0);
-	if (!gpt->regs)
+	if (!gpt->regs) {
+		devm_kfree(&ofdev->dev, gpt);
 		return -ENOMEM;
+	}
 
 	dev_set_drvdata(&ofdev->dev, gpt);
 
-- 
