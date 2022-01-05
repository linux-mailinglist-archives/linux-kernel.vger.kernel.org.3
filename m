Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9DC84851A3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 12:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239605AbiAELLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 06:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbiAELLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 06:11:05 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB96C061761;
        Wed,  5 Jan 2022 03:11:05 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id z3so29072912plg.8;
        Wed, 05 Jan 2022 03:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=cj+3WFPJnAOOnxE9gT1YnUYxUZOyVzd9YncNCKeilCU=;
        b=Z5UWgzuNH1dCoyvrV4977X1iPqZaStrCEQTeUl3WbtuV9qk4jS49h72PYgskI2nX8E
         Jj3rz2uyAiKgyc+DJiDPSUnDfGPmcEHMoOoZbcaB9KRwsNZ2p1ATAOMkkmW8UJflp+56
         RlLB2kfhC5bn7WkofAC3eJGQI9xEN/llI1ajtuKy6tuaM9t8ExXjfl20JNK+PKY+jgKZ
         k1cucehwH+6m9CbeAVzsBrbPvA5S/OGgKHnUAC4FNkeDswgIhQqg4R5nZSQo2365VfYz
         9nM+4fuKgD5vVqHbB0aZdnl/DPTeqRhsP7yaFqcp80M2V2E8uQ/NxRJQG6Clif1o+WK8
         XbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cj+3WFPJnAOOnxE9gT1YnUYxUZOyVzd9YncNCKeilCU=;
        b=ZtlbiRsxltqYEOWeBQEINpxtlXmw0zEErk9ryT1LMCO6RYmoWWbg23CPwm+1v/9mvh
         X3E3qJAWcmkxqoJDBwE8BZH2axFD3h8F+CWF0nwyLeIRRjqXj/biaqbRgQm8BqUsM5UA
         1r7oixb13mnWPqTTLQCozd1H/oni/8gkMhrO0h1iSjY/CH/JHrsm42MMAiUF34XivSZ7
         iKpTbaBIR7m6Cyodut0XscAL5MBR437qoGxg3Rw6014wjLX2nJNBdppG/UYuuRJpdm3i
         cNdgb5zIslUrJcYLjeLi1iya6e9DkUOR5ChQMpyDd0sCwLqNljzU0b+C1QLzu0Hr8izB
         tUPg==
X-Gm-Message-State: AOAM5334rm1ruQ+FOERCoBtY90Kx6ijBRAbppfJCKSJqsT4pF5Jj/s6B
        h1ONp3M7avxbvt1sZ5OIws4=
X-Google-Smtp-Source: ABdhPJxofkPppi25LMe8AAwDgRDJyINVLZDgzMqLZ+7DQfA8juXDY9/3OxdzF6Npl94UtTXgyuu6nA==
X-Received: by 2002:a17:902:b787:b0:148:fa6a:c748 with SMTP id e7-20020a170902b78700b00148fa6ac748mr53350313pls.167.1641381064566;
        Wed, 05 Jan 2022 03:11:04 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id k23sm1856651pji.3.2022.01.05.03.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 03:11:04 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Eugen Hristev <eugen.hristev@microchip.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: atmel: atmel-isc: Fix PM disable depth imbalance in atmel_isc_probe
Date:   Wed,  5 Jan 2022 11:10:54 +0000
Message-Id: <20220105111056.4662-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pm_runtime_enable will increase power disable depth.
If the probe fails, we should use pm_runtime_disable() to balance
pm_runtime_enable().

Fixes: 0a0e265 ("media: atmel: atmel-isc: split driver into driver base and isc")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/media/platform/atmel/atmel-sama5d2-isc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/platform/atmel/atmel-sama5d2-isc.c b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
index 1b2063cce0f7..88a81c3ada90 100644
--- a/drivers/media/platform/atmel/atmel-sama5d2-isc.c
+++ b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
@@ -559,6 +559,9 @@ static int atmel_isc_probe(struct platform_device *pdev)
 cleanup_subdev:
 	isc_subdev_cleanup(isc);
 
+disable_pm_runtime:
+	pm_runtime_disable(dev);
+
 unregister_v4l2_device:
 	v4l2_device_unregister(&isc->v4l2_dev);
 
-- 
2.17.1

