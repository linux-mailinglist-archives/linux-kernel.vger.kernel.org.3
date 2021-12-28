Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB1D4480825
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 11:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbhL1KBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 05:01:23 -0500
Received: from out162-62-57-49.mail.qq.com ([162.62.57.49]:46477 "EHLO
        out162-62-57-49.mail.qq.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229570AbhL1KBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 05:01:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1640685679;
        bh=TBSpQyItBAykZu7oiGhVSiruwh3KbwDIPl6+G+LvL1o=;
        h=From:To:Cc:Subject:Date;
        b=BIANpbU+ELEkYtbob1jdBxi/w0zgw3gfUeKK2wYngOG2OyE5bijIYFfv/Uw4MnWf8
         jaHRi/uKQqNicr/yoY8urWrybByjteuPLHuLmvvzmXQFOpmjozZC7L1yqhps2PwOLp
         NI4NGnxJJTkswWLjZcZxyciu+y6ecAVjCrGN/IMw=
Received: from localhost.localdomain ([159.226.95.43])
        by newxmesmtplogicsvrsza7.qq.com (NewEsmtp) with SMTP
        id 503B810; Tue, 28 Dec 2021 18:01:16 +0800
X-QQ-mid: xmsmtpt1640685676t83c8or6d
Message-ID: <tencent_0D5124AF8235001703711A7A09703F918806@qq.com>
X-QQ-XMAILINFO: N4WhQbLQyIqSczlML5IdqYvfl80+xZFFmWJ7+4YTFc2XUxh3kXEHxPxRmAo2VG
         x3Kj/9JGUAudqz4wJEcPlvB8d1qUYPpNKb979EYsSC45dSV2pHUDq2Ox7z841nppA6pHQtRbg3RM
         XOSYhmIB19e7iWQdaSHtJPz3nrMgsOveDvYIgkNqzMO4KHx/o4KLgzgg5AyDsJ3T8avJrJOxKKuy
         0Pexj+ZEK9DT2jvPxszpA7nWX40LKzrhCgCdT2aY/JMqsUPE6O5jNwdPt/i4EHmigCsMHeILU5DB
         zt+2u5SSI0OWBgv6QzAT74toFxon6FEJ+qSQ18OeNXSqSMt6bR+QHNujxZokJWr4lOrRibAyyX5z
         A08zDTwyMHxFPqntW2j6Sd6lUqXwApsDi7+ozPMY2b9kI80ODWEkLpqIdOqjL08HFuFLvQViAtpf
         r5jhf3Era0xTkoUtyOa05+zvj78U4/eqHYo9V7SGaWKpKbmcCmX1MJoXVoaLiAPQLEKiaeIuJlbJ
         xV+aC3NG95gF83L/86rPz3TWLM2QViwP1T80+oEzB7p5iDEDwA+So4VlUfGU/9r1WIF61FklvTTa
         12jOxvR2mrAycCQuEl7tBDBXfHT+wmbWgG5rlpO5E7t4163WL/4lbB5JKXGXJ74LAhGnWQEohA4p
         4BIjhfS7CM39HgOzsd3oCz4Ro8UuPRa5VDgUdWY0f+5uSmZL9M/Sfsjk2qq+0ORaFpiH2ebUMvLy
         89RmpeydA+JiebKU/o6ppITHgj8WTaqApxH1DZSQxf9IcK+TKtP2Qt4XwS51TPPCqC/ilRdspXMz
         5AbE895MXdpYnZ6FW3R5qXBmLiGkEuha4UVVK3LKpuZrpXzPpq1kcU1vC8Yoh2L+RzkvLQiAiM5+
         UlfWSLggYB
From:   Peiwei Hu <jlu.hpw@foxmail.com>
To:     nm@ti.com, kristo@kernel.org, ssantosh@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peiwei Hu <jlu.hpw@foxmail.com>
Subject: [PATCH] firmware: ti_sci: inproper error handling of ti_sci_probe
Date:   Tue, 28 Dec 2021 18:01:03 +0800
X-OQ-MSGID: <20211228100103.1355913-1-jlu.hpw@foxmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

goto out instead of returning directly in error exiting

Signed-off-by: Peiwei Hu <jlu.hpw@foxmail.com>
---
 drivers/firmware/ti_sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 235c7e7869aa..4500456a9a27 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -3412,7 +3412,7 @@ static int ti_sci_probe(struct platform_device *pdev)
 		ret = register_restart_handler(&info->nb);
 		if (ret) {
 			dev_err(dev, "reboot registration fail(%d)\n", ret);
-			return ret;
+			goto out;
 		}
 	}
 
-- 
2.25.1

