Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19EB347663F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 23:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbhLOW4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 17:56:55 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:41720 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbhLOW4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 17:56:54 -0500
Received: by mail-oi1-f174.google.com with SMTP id u74so33767661oie.8;
        Wed, 15 Dec 2021 14:56:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9QWYnfNPP5VkW+LKnhvvtYRz7R6qpsMFPhXYcWwb4Gc=;
        b=tZ9DJbUW0Uo93oeevakT6jgA4SGTJsSeXlygX+2rSfa7AtV6xyxCmIqCfOkrDe85eg
         QrIbXDaIVaQ/5CaR3OL9i5Pwg4mOrsPLNwNqox7NbiutrR4BT7egXNbp202YAMvPOaR4
         N551N6UB+xxGz3V3fR45YKm0Jfc1Fb0dKgW5XOlnlSKrNQdL1P19zqp9RgZbfXEtAZp5
         NJLPTyeIjm0vHeASa1fSIHli6AKyof1PFjIK8m7MHuNY71SIHNP9tICJDlZ1sF0yi8dV
         GkzjYtwtZz+U2r+0vXsQdqZ/TIjmoEZm4bIRkU+9hgF92TgR1LzCyQOiy49y2KhKqHPq
         1UAQ==
X-Gm-Message-State: AOAM5321cMB517xp0jKrvFiCfK+2p80FtY3IpCysYWlXg3lXgBz5fK3d
        EJXuy4k/ARE7Oul1IHw8Lw==
X-Google-Smtp-Source: ABdhPJxVoFjSihy5pYAMp3p3OB0wH6eiXgzJWqb5QOdfgW5Q9JfxZIQdzj7pTk7BEZEMQH8QoMdP1Q==
X-Received: by 2002:a05:6808:1802:: with SMTP id bh2mr1999500oib.142.1639609013851;
        Wed, 15 Dec 2021 14:56:53 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id r10sm783172ool.1.2021.12.15.14.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 14:56:53 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: chipidea: Set the DT node on the child device
Date:   Wed, 15 Dec 2021 16:56:46 -0600
Message-Id: <20211215225646.1997946-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ChipIdea glue drivers just copy the glue resources to the "ci_hdrc"
child device. Instead, set the child device's DT node pointer to the
parent device's node so that platform_get_irq() can find the IRQ
resources in the DT. This removes the need for statically populating the
IRQ resources from the DT which has been deprecated for some time.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/usb/chipidea/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index a56f06368d14..5359b2a2e4d2 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -864,6 +864,7 @@ struct platform_device *ci_hdrc_add_device(struct device *dev,
 	}
 
 	pdev->dev.parent = dev;
+	device_set_of_node_from_dev(&pdev->dev, dev);
 
 	ret = platform_device_add_resources(pdev, res, nres);
 	if (ret)
-- 
2.32.0

