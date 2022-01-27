Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02BC049E3D8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237044AbiA0Nvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236379AbiA0Nvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:51:42 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E5DC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:51:42 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id s13so6050605ejy.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=veVm+gQt5sjCeq1O1VzpT6WlH1+BdZhmzMjg8s2pTjM=;
        b=FlANeMdq3cmMQ5oDRx8g+r/hiepixVE5817FHP8RuzR6dcfC7GDHHq8NNHE3moRaAI
         +bEpe0ysiR7GO5aUcykARU4YvD1mxVhDTEai0hVpf+0EEzBzSN4Gymr75If7zAj/wUT7
         H9E1y6lJGP6SjJlkuBeH0b80ZX8Jhs+q0iFAyAalXzSbuakoRTJmpcbQLeM0lLekW+Im
         IHH1px4l5Mq5GNg8GWawx/lBHVPA+FWnx2moeSJgywixD0ONwW2oZALDT+RQhPQt4uRW
         CtB6tIx8GdF7iKolW4YnlWBmF/CrZkJVFtPBTPo3G9EF2Jppequ2Bn/0gv365R6jS2+7
         trpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=veVm+gQt5sjCeq1O1VzpT6WlH1+BdZhmzMjg8s2pTjM=;
        b=f1eSFzEpwHJVHEsnMjh+lcmMzBLTm00pe9ckjgz7PHAmqy7UOOGKNJBU/4L7vPG1tY
         siX63bw9Sg8H6aGKSGLbcQZ/H2XdnQKjuqQTMsnEAD/V6AspyKbISuPbg+yEubLxANb3
         wg83/A+NStpNVLaq9yci7+IJ0oCOaXfq2tXgHuIuqBseXsSFUOV/qRC2DS9cvf9Fx3w4
         z+hqBRfAslW/6kCZbTB1niYkNPid+t5AkJpIBdiNC42TBm2Tq4X+fnvRFbFWB4CI9/TY
         BzzwBN452rmin9L/ReDmqfCdpBWwSJQSwqOhdwnTK9vdBipoqDF1IMoA1oJkrWc7rjlS
         SBeA==
X-Gm-Message-State: AOAM530HMqA9nUewhZJxmM2DJOYcKuOVMmtq5i7wBegza+Qwq0e6w4WO
        G/u63QEkTdvsFNHn4oLdQSc=
X-Google-Smtp-Source: ABdhPJx6Q6xB2YU207TDY+V0hMtyaWpxK/BU9Ecg6Rfnz4k8np8Tv0VuonNy82xvOx3sCzWXHbuhLg==
X-Received: by 2002:a17:906:4fd6:: with SMTP id i22mr3000028ejw.502.1643291500757;
        Thu, 27 Jan 2022 05:51:40 -0800 (PST)
Received: from localhost (cable-89-216-134-246.dynamic.sbb.rs. [89.216.134.246])
        by smtp.gmail.com with ESMTPSA id v5sm11573315edb.15.2022.01.27.05.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 05:51:39 -0800 (PST)
From:   =?UTF-8?q?Aleksa=20Vu=C4=8Dkovi=C4=87?= <aleksav013@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     salah.triki@gmail.com, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Aleksa=20Vu=C4=8Dkovi=C4=87?= <aleksav013@gmail.com>
Subject: [PATCH 1/7] drivers: dio: Use <linux/io.h> instead <asm/io.h>
Date:   Thu, 27 Jan 2022 14:50:48 +0100
Message-Id: <20220127135054.27281-1-aleksav013@gmail.com>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl warning:

< WARNING: Use #include <linux/io.h> instead of <asm/io.h>
< #36: FILE: drivers/dio/dio.c:36:
< +#include <asm/io.h>                             /* readb() */

Signed-off-by: Aleksa Vučković <aleksav013@gmail.com>
---
 drivers/dio/dio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dio/dio.c b/drivers/dio/dio.c
index 4c06c93c93d3..831f36ab6e2b 100644
--- a/drivers/dio/dio.c
+++ b/drivers/dio/dio.c
@@ -33,7 +33,7 @@
 #include <linux/dio.h>
 #include <linux/slab.h>                         /* kmalloc() */
 #include <linux/uaccess.h>
-#include <asm/io.h>                             /* readb() */
+#include <linux/io.h>                           /* readb() */
 
 struct dio_bus dio_bus = {
 	.resources = {
-- 
2.35.0

