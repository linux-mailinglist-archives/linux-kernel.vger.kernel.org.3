Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51531471F85
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 04:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbhLMDP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 22:15:29 -0500
Received: from out162-62-57-64.mail.qq.com ([162.62.57.64]:43921 "EHLO
        out162-62-57-64.mail.qq.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229709AbhLMDP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 22:15:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1639365325;
        bh=+Gfr3qCdN7IP2NvExMEW+dLfIwJGQxhlg72/yD5IiB4=;
        h=From:To:Cc:Subject:Date;
        b=YcDgo1bbg47ORrZJ3HHCKzFGFlQVXv9RA3xvCDFQphwrrZTXRoj3IdLvNxDnU/8+3
         08ejvUi8Sp0rxpwqviHMEaiWjIXbrjlkB+6D6/NxhBU/xk3uvAapOdH29qCJoFqL7O
         pj8goaSNIL4ayJxXuwxXbh8d+dTCYQ4NHUD/k19g=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrszc9.qq.com (NewEsmtp) with SMTP
        id 3888B644; Mon, 13 Dec 2021 11:14:08 +0800
X-QQ-mid: xmsmtpt1639365248t33n4zrsx
Message-ID: <tencent_C1508086CF28C5FD4B834C3393E53271E80A@qq.com>
X-QQ-XMAILINFO: MgAERLP4sJkUP+JKHSJoHh0RTHWD2M4nK5pSbwGUtHmT6ek3hABdk/NezYYL+F
         YJBz7i7KTQW0M68ePrv1brdYeYtMWZj8zT+qguJ/ctwHOJWZWWegn7oh/fY/V8FJwVPoFQ33VRqc
         sHzqEQurg3HrK0v/a6qHv4aF6LqyYVaeE4uYmNwS2wcoU/127Y1xzaw7l2YvDumf5awBHwV938XE
         PEEObUvZqsakuhW7imDvUO9zYoANUoq+yW5Yv1UsyxyF5b5fWWoRKlFsFVRSvWhCRqHxFdRAa4vF
         1pEMFGGZ6xNj16Dnowfv4bEO9amw3sa9/p9fOpLUjNq7y4nGdFcDUQd1LCCX38tpGkiRnXjML+yz
         GREWQ/FONKuQr00hXyRl7TvCpcb1TfVPvmp/IVrO4MiEpK5hYySLOEvFOEccVT33ZPOQaXaOowXi
         t04hlwPD8ZuhQSKiZ/+LYhb7jvTyGbmKHKGeJS3sd0zsBOmfGnz+D3NuYrSDlW2mdj8F9Omj3vKK
         DG4MGzmqQGm4XtKsrsWbHi1uN5OoZjRRrBS0+19ZnhfqoucJWduHqzRuFY/dyxsz63UBYDNNtBqu
         48gSNP5QtMQoixxV3aSxDE+vICEJ34WpuwO/C6zbL6BRw7Q9IdE6xh0G8bnc/2pVe6o7QoGlm9Aq
         wP4hRMLi8bettodFNYVFAwKbDMaj4Txh7zEUwv0pyaRCR4iP5J0GjAOYHiZ6PQmVMLhajZS2ekR/
         cPI8GcLWFF8CJ6JptDqcXiUrCofZ4+7I3GtA7qP9MZcdHpP2yVaFhf+8ZXl44fAYyHPy9cFQjHOB
         UM8REBbScRZhYqcgXnCyMNKifvuiZAl4IQU4QozBVicu10KIY7r0udrk8Rrgs4skHVK0yxvOQc49
         7Ova/ybSykXwXC6MBExx8/o9ribKM77lu9fwDP0qMDi9d406wrjoo=
From:   Xiaoke Wang <xkernel.wang@foxmail.com>
To:     oohall@gmail.com
Cc:     nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] libnvdimm/of_pmem: check the return value of kstrdup()
Date:   Mon, 13 Dec 2021 11:13:05 +0800
X-OQ-MSGID: <20211213031305.3645-1-xkernel.wang@foxmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kstrdup() returns NULL when some internal memory erros happen, it is
better to check the return value of it so to catch the memory error in
time.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 drivers/nvdimm/of_pmem.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
index 10dbdcd..33978d2 100644
--- a/drivers/nvdimm/of_pmem.c
+++ b/drivers/nvdimm/of_pmem.c
@@ -31,6 +31,10 @@ static int of_pmem_region_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	priv->bus_desc.provider_name = kstrdup(pdev->name, GFP_KERNEL);
+	if (!priv->bus_desc.provider_name) {
+		kfree(priv);
+		return -ENOMEM;
+	}
 	priv->bus_desc.module = THIS_MODULE;
 	priv->bus_desc.of_node = np;
 
-- 
