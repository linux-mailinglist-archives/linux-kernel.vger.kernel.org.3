Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E764AB189
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 19:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347261AbiBFS7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 13:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbiBFS66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 13:58:58 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E880C06173B;
        Sun,  6 Feb 2022 10:58:58 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id r29so3249851wrr.13;
        Sun, 06 Feb 2022 10:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D1XGDo7HWBYqlIqWiIbQqMrJ0Zd1l02kRDCl5/xbN/E=;
        b=Kdm5D/r38tPmeacBocAQqjmMHMH/diSFSp5O4m8liTUwABbg5i2BPMEfqPIcAlsamz
         yypWEbbga1Hbh92mHAN7DcHS4sDoAyuRcD6L5yP0krVJq0+Klwyysh5sStL1wG+mNAwT
         HTwk9kQRguKlaAqfGQ53B+diRmwiiOVSRLzG0vcVBgBz6PTvI4g6oIrlXjKVvNXpCsn0
         zRqPVyoPzp/dsNeyoDAInBt+1D8KkpCNJVpr7OK1T4eCBRN9ZOuqFiQ/zKPvkzrDIomM
         jjnAvAh4D3OFnJj9aYEGtZB8BgvA7bFXpONQwpRoXj2nFBJhyPIhp5UZTNMl60iudCF6
         7bZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D1XGDo7HWBYqlIqWiIbQqMrJ0Zd1l02kRDCl5/xbN/E=;
        b=vwFk/DQxrEs0+3v2PyFtziKVzL+1HD0KP3XMD2F4iut8A4IeOQcpCLq88bSdJQCLTe
         vzuMGOS7JbZNU2WScC32SvKnbRdZUURjg1e5CINzFYXA4Nm0+kxhzsZ62htcVnJDa79y
         Qx1YRyJXx4x0D1STONzn7bRAu8Xuk9Ba4dOAFEg845tOwb20G4+pfYx9ggjFa5+P34P/
         iYzyL78g9udfhU2vAHAlBpWwbI0n2KCY0voN8S94jHWvTIT7+ISINk28/UPzlAi65agw
         RROJPYJ/nVGwRjQpVYvABRPeXWVniBMNKVsQUFhPwCJ4COVIXFgPnAR8XhpAav4CAgKI
         Oh3g==
X-Gm-Message-State: AOAM530zcE78LFBQtzQOf47GPr0kH7kRgyE2edyc8Ywn5+i24jrWJlwb
        /Ol8S5sDFJTRXsmIq2121UYCT0Q68Q1jhw==
X-Google-Smtp-Source: ABdhPJwwbd5/AolYOzqZ6pAHSDpsUDxjmIcqRaDKWBU+u9WWNliS9a0giPbbPdTKY/wg40OAQ1ev9Q==
X-Received: by 2002:a05:6000:1144:: with SMTP id d4mr2580636wrx.716.1644173936560;
        Sun, 06 Feb 2022 10:58:56 -0800 (PST)
Received: from localhost.localdomain ([141.72.243.13])
        by smtp.gmail.com with ESMTPSA id j5sm7498008wrq.31.2022.02.06.10.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 10:58:56 -0800 (PST)
From:   Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
To:     mosescb.dev@gmail.com
Cc:     andriy.shevchenko@linux.intel.com, gregkh@linuxfoundation.org,
        joe@perches.com, kitakar@gmail.com,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        mchehab@kernel.org, sakari.ailus@linux.intel.com,
        tomi.valkeinen@ideasonboard.com, dan.carpenter@oracle.com
Subject: [PATCH] staging: media: atomisp: Use GENMASK instead of manual masking
Date:   Sun,  6 Feb 2022 19:58:30 +0100
Message-Id: <20220206185830.39360-1-mosescb.dev@gmail.com>
X-Mailer: git-send-email 2.30.2
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

There is a GENMASK macro available in linux/bits.h, for masking.

Example: GENMASK(3, 0) = 0b00001111 (same as (1 << 4) - 1)

Signed-off-by: Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
---
 drivers/staging/media/atomisp/pci/atomisp_compat_css20.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c b/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c
index 1173be0e72b0..a345fa1d7de9 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c
@@ -40,6 +40,7 @@
 
 #include <linux/io.h>
 #include <linux/pm_runtime.h>
+#include <linux/bits.h>
 
 /* Assume max number of ACC stages */
 #define MAX_ACC_STAGES	20
@@ -1913,11 +1914,11 @@ void atomisp_css_input_set_mode(struct atomisp_sub_device *asd,
 			    &asd->stream_env[ATOMISP_INPUT_STREAM_GENERAL].stream_config;
 		s_config->mode = IA_CSS_INPUT_MODE_TPG;
 		s_config->source.tpg.mode = IA_CSS_TPG_MODE_CHECKERBOARD;
-		s_config->source.tpg.x_mask = (1 << 4) - 1;
+		s_config->source.tpg.x_mask = GENMASK(3, 0);
 		s_config->source.tpg.x_delta = -2;
-		s_config->source.tpg.y_mask = (1 << 4) - 1;
+		s_config->source.tpg.y_mask = GENMASK(3, 0);
 		s_config->source.tpg.y_delta = 3;
-		s_config->source.tpg.xy_mask = (1 << 8) - 1;
+		s_config->source.tpg.xy_mask = GENMASK(7, 0);
 		return;
 	}
 
-- 
2.30.2

