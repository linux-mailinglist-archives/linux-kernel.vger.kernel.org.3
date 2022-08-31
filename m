Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDC55A7D0B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiHaMPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbiHaMPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:15:08 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E329275
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 05:15:04 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 76so14225748pfy.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 05:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=CEHcLla5zOmUdu7C07/2cr3gkjbIYdCMWy2aAyX4WRQ=;
        b=qjHhIMdGX4LHayLHwPd4MOgxYtLCiRbfgYD0tczlnTkuJPI0VC3r94TqJqbua0fBLd
         uaLEwIdImBuqWYcUqVjDNC6Mg8fADjT1ENuavE80Q+RpnZbob87g7JpOx8V4PpQh7HlT
         LoCAMH6+hLfKUfGY+5UnhMWvI1lGkBOCNSFCiver5Smc44jRtjAyuCbRfI3koLamxsZS
         9+v8LOYMv131ibZcB54bxcLNn7R4R5An2dE38B5vhduma/7zotn2OOVM4lTTiW0oPNxO
         Ipn72DEgRnG1VxmX7Edm4oPOgBxfPEog9G+LQoBhGfWGrP6Z11dLtTvnLxq/cUOUdxay
         Qkhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=CEHcLla5zOmUdu7C07/2cr3gkjbIYdCMWy2aAyX4WRQ=;
        b=GxlZXcs28/tTE4SNhCwnXZNN3EUm0ZF9/uuaqSy4h7c/nb0X8qQAc1qBsZ7uYj2e6h
         gDGe6uCbSFOEmG20akzALUaKH4DAyTmEFmcZo7qFMWcHU3OcspoL0e207i8jLpqDB/oY
         Io6sXi39n+dMhUNcvzyy7bOz+XYsQVlT8Y0piKS2c0RMpfWzedof7jBpiyG2pABFZgF8
         IFW8xHZgvbk+bDZT003Fh/7QIQwXPrZljPHxWuzxeLAjMxAkeIDJ8RHAtIOrYqVdgEzW
         SN1swrl/Kbuzv0YWjYQCcm70sSfld6bwrS6Lgyliiy5P+32t8wShKMNWrPijoEcaZ6MI
         6ALA==
X-Gm-Message-State: ACgBeo3nYsU3oSk3j98w/ESYNUKCGoTL8Z/FdSsXLYhC0TP+9OyI+mcl
        XQ0zkrg7hPc/cwl3fRuZsVY=
X-Google-Smtp-Source: AA6agR4sHEnU26+YJLDFxANLZw05QQ4XY0fFXUCIRmJZ/hK5foq43d7k+eSnkp4sAl0qYqQwVhr3ZA==
X-Received: by 2002:a63:2365:0:b0:42c:7b67:2377 with SMTP id u37-20020a632365000000b0042c7b672377mr8419068pgm.275.1661948103800;
        Wed, 31 Aug 2022 05:15:03 -0700 (PDT)
Received: from carlis-virtual-machine.localdomain ([156.236.96.164])
        by smtp.gmail.com with ESMTPSA id c197-20020a624ece000000b005363abb6d0bsm11405992pfb.15.2022.08.31.05.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 05:15:03 -0700 (PDT)
From:   Xuezhi Zhang <zhangxuezhi3@gmail.com>
To:     abbotti@mev.co.uk, hsweeten@visionengravers.com,
        gregkh@linuxfoundation.org, zhangxuezhi1@coolpad.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] comedi: sysfs: convert sysfs snprintf to sysfs_emit
Date:   Wed, 31 Aug 2022 20:14:56 +0800
Message-Id: <20220831121456.210835-1-zhangxuezhi3@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhangxuezhi1 <zhangxuezhi1@coolpad.com>

Fix up all sysfs show entries to use sysfs_emit

Signed-off-by: zhangxuezhi1 <zhangxuezhi1@coolpad.com>
---
 drivers/comedi/comedi_fops.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
index 55a0cae04b8d..e2114bcf815a 100644
--- a/drivers/comedi/comedi_fops.c
+++ b/drivers/comedi/comedi_fops.c
@@ -396,7 +396,7 @@ static ssize_t max_read_buffer_kb_show(struct device *csdev,
 	mutex_unlock(&dev->mutex);
 
 	comedi_dev_put(dev);
-	return snprintf(buf, PAGE_SIZE, "%u\n", size);
+	return sysfs_emit(buf, "%u\n", size);
 }
 
 static ssize_t max_read_buffer_kb_store(struct device *csdev,
@@ -452,7 +452,7 @@ static ssize_t read_buffer_kb_show(struct device *csdev,
 	mutex_unlock(&dev->mutex);
 
 	comedi_dev_put(dev);
-	return snprintf(buf, PAGE_SIZE, "%u\n", size);
+	return sysfs_emit(buf, "%u\n", size);
 }
 
 static ssize_t read_buffer_kb_store(struct device *csdev,
@@ -509,7 +509,7 @@ static ssize_t max_write_buffer_kb_show(struct device *csdev,
 	mutex_unlock(&dev->mutex);
 
 	comedi_dev_put(dev);
-	return snprintf(buf, PAGE_SIZE, "%u\n", size);
+	return sysfs_emit(buf, "%u\n", size);
 }
 
 static ssize_t max_write_buffer_kb_store(struct device *csdev,
@@ -565,7 +565,7 @@ static ssize_t write_buffer_kb_show(struct device *csdev,
 	mutex_unlock(&dev->mutex);
 
 	comedi_dev_put(dev);
-	return snprintf(buf, PAGE_SIZE, "%u\n", size);
+	return sysfs_emit(buf, "%u\n", size);
 }
 
 static ssize_t write_buffer_kb_store(struct device *csdev,
-- 
2.25.1

