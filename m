Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F504BBD94
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 17:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237947AbiBRQdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 11:33:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiBRQd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 11:33:29 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07346207FE4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:33:13 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id 10so7592227plj.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H/uvUOlzgu7E24r5QEdLevzWEd8lLd8nM8VcgKvELNA=;
        b=FXF0/Fza6sK6cvL+St88kZZabLCdML0OeO223BGa1SzRlyr4MGJ58NzWL+hbDLc2v7
         Or8G0auvC8WPsxEaE5VJHEDDv028Na/ogvPcWUeNGxNVEl29/omxHODVv4wG7NZ2oX3Y
         BFNEqPNMUr13wRmM29v6HIAtGJAwPamG8HIsKjD3+pdUj/NqmiPiqXZRtWzxpKL7WwMi
         dBO83zMKOEeJXnc1g6jGWVOFsa+4q98Tq1aAdbB1gBVPwGb/gFIAFzj7Luu8/SBTkrNd
         HGI3R4ResJbYayDylt5pGuUHL6cpX6xMM7gj0PFW4CUUh62wyrt3z0NHS4wnqCsLvdMS
         soog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H/uvUOlzgu7E24r5QEdLevzWEd8lLd8nM8VcgKvELNA=;
        b=QNrF0z0bfGhTH9jWul2DsKPk7raDmPmQnowe5l0tIJbFUJuEc3zAnmgmbVwvFII5oW
         +ltedzzPv9O48PE2UyWNspFcWp+zQRCEebXx9J36jr4jjMPxId5SO5JkPpMv5cOVS+FL
         fCyqDp9/HptBshqKj0M59gvPl+9b/RcU5Ss6c+faZ4GJfGJVxVFg/lihgyU+B/iFdmUi
         s9MspvtBzMn+h0FYfJR3buSSpTAYDvJVTt9IyrbOy4nfEVq8J/xKU+gz77MLReAy4uRW
         XScMubGY4PbJYrRGy9l7C2xjFlkgwr7cZgHd2JWEZJEpPGhhT51OE29oxRMIjxhzKN3Q
         YtJA==
X-Gm-Message-State: AOAM5332qRCbpZ2unRza+bJLsve1D68+wiZquTM1NDhj3NMDvG1WpCYp
        Kc8C6Xzz6GsaUoO8UD6jMAk=
X-Google-Smtp-Source: ABdhPJzBLHb36gu+M6PJfFcde8bWIL4/8LlgT2QnnY6F0lsQ+lsZ6001H//ihGsYTTIqNBsqCsgoVw==
X-Received: by 2002:a17:902:f78d:b0:14d:522e:deb3 with SMTP id q13-20020a170902f78d00b0014d522edeb3mr7940668pln.173.1645201992479;
        Fri, 18 Feb 2022 08:33:12 -0800 (PST)
Received: from localhost.localdomain ([2405:201:9005:88cd:8c06:953a:a435:bc37])
        by smtp.gmail.com with ESMTPSA id s42sm3405724pfg.180.2022.02.18.08.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 08:33:11 -0800 (PST)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     tglx@linutronix.de, maz@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] irqchip: nvic: release nvic_base upon failure
Date:   Fri, 18 Feb 2022 22:03:03 +0530
Message-Id: <20220218163303.33344-1-jrdr.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>

smatch warning was reported as below ->

smatch warnings:
drivers/irqchip/irq-nvic.c:131 nvic_of_init()
warn: 'nvic_base' not released on lines: 97.

Release nvic_base upon failure.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Souptick Joarder (HPE) <jrdr.linux@gmail.com>
---
 drivers/irqchip/irq-nvic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-nvic.c b/drivers/irqchip/irq-nvic.c
index 125f9c1cf0c3..ba6332b00a0a 100644
--- a/drivers/irqchip/irq-nvic.c
+++ b/drivers/irqchip/irq-nvic.c
@@ -94,6 +94,7 @@ static int __init nvic_of_init(struct device_node *node,
 
 	if (!nvic_irq_domain) {
 		pr_warn("Failed to allocate irq domain\n");
+		iounmap(nvic_base);
 		return -ENOMEM;
 	}
 
@@ -103,6 +104,7 @@ static int __init nvic_of_init(struct device_node *node,
 	if (ret) {
 		pr_warn("Failed to allocate irq chips\n");
 		irq_domain_remove(nvic_irq_domain);
+		iounmap(nvic_base);
 		return ret;
 	}
 
-- 
2.25.1

