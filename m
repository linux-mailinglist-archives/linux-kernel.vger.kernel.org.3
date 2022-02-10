Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDBE4B18FA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 00:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345383AbiBJXCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 18:02:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345039AbiBJXCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 18:02:49 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EDD27A;
        Thu, 10 Feb 2022 15:02:49 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id k10so7163472ljq.2;
        Thu, 10 Feb 2022 15:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=utz0VRFK/Z4T1V8Xj6WH93qgAKh3TJKNnOSR9iLg9ic=;
        b=Tohe9kBajf8I3Veod2AThoiouhOpdws6koyqaGcfiM/5AatC8ADlPeXTzP9K+U7xxy
         nJ7/DV2KZ+ptjt+NxZi5y53elUaAiebmmRh8/SeVhccMpPgz0kxuAiiqtZ+ejtUbBmnd
         i5eiHBSHABKrj5GEbYs2eCMpkP2ZDJcFCw4odvV7AtdAHNUQOCrvWj80PVkANMngwvUC
         /FOv+S5rzmyB/6a0c+1t4GLz7MIry0fLnQh+TujqNdH88vunQDBt+KnEa7zyFjCI2bFb
         IV+z2yxuudte9uaS2Zb3BJQqL0dbpHL7i0wr7W3bCAArLumz2C3mARUsq3Bk50L3q9X0
         KV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=utz0VRFK/Z4T1V8Xj6WH93qgAKh3TJKNnOSR9iLg9ic=;
        b=VkZOrX4HNSJg2Rb4M1blTWkb8vtbU+2JCdqoyHT7CQj7uEOIKKK1sfRrpGatGmU3x6
         5weQqFyw5ya2tVKNRty/+Sgzm31sQ09qPOpjzUelIjokPw/SyJWF+8vOBTEdrAmvspcN
         ZeBlsHTyeP+0xulgIX+a2AQGMOI19zUrXA915GdmvQxSz+j8JXnDXTmlCmPO1OEGGoVR
         fmCikixmG21aBhQ2Hl35daHFvHX3qbeqcMoPTJTUcBhZsl29W84Nl7/sbaQFkgbrGmZH
         63kJJf4BayP6jQdfmdwo+y0xTOdmElFUQ/Ec3ftf5RKAau5Y3kLILdVtEjsEOGZGDrLP
         fxxw==
X-Gm-Message-State: AOAM531WhAF3nTDPA+JZc+V3HEzu6cyyhnaaF/QzNZgHROQG2lzORbVO
        fAxGJl4x5PspnlBMX2HDxtYCSkq3D3A=
X-Google-Smtp-Source: ABdhPJwfh/ttJ3hH2u54w//qvoPdv8NShKMDdgORtEo/D2Hw/LBLfo4X5Pv/kZbgdNawQJjTDHP0fw==
X-Received: by 2002:a2e:9916:: with SMTP id v22mr6014431lji.232.1644534167305;
        Thu, 10 Feb 2022 15:02:47 -0800 (PST)
Received: from localhost.localdomain (h-155-4-221-129.NA.cust.bahnhof.se. [155.4.221.129])
        by smtp.gmail.com with ESMTPSA id h2sm1022378lfv.10.2022.02.10.15.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 15:02:46 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] cxl/core: Constify static attribute_group structs
Date:   Fri, 11 Feb 2022 00:02:35 +0100
Message-Id: <20220210230235.4463-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.35.1
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

The only usage of these is to put their address in arrays of pointers to
const struct attribute_group, so make them const to allow the compiler
to put them in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/cxl/core/bus.c    | 8 ++++----
 drivers/cxl/core/core.h   | 2 +-
 drivers/cxl/core/memdev.c | 6 +++---
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index 3f9b98ecd18b..4532ef8b806f 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -38,7 +38,7 @@ static struct attribute *cxl_base_attributes[] = {
 	NULL,
 };
 
-struct attribute_group cxl_base_attribute_group = {
+const struct attribute_group cxl_base_attribute_group = {
 	.attrs = cxl_base_attributes,
 };
 
@@ -136,7 +136,7 @@ static struct attribute *cxl_decoder_base_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group cxl_decoder_base_attribute_group = {
+static const struct attribute_group cxl_decoder_base_attribute_group = {
 	.attrs = cxl_decoder_base_attrs,
 };
 
@@ -148,7 +148,7 @@ static struct attribute *cxl_decoder_root_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group cxl_decoder_root_attribute_group = {
+static const struct attribute_group cxl_decoder_root_attribute_group = {
 	.attrs = cxl_decoder_root_attrs,
 };
 
@@ -164,7 +164,7 @@ static struct attribute *cxl_decoder_switch_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group cxl_decoder_switch_attribute_group = {
+static const struct attribute_group cxl_decoder_switch_attribute_group = {
 	.attrs = cxl_decoder_switch_attrs,
 };
 
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index e0c9aacc4e9c..1c0562cc9297 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -7,7 +7,7 @@
 extern const struct device_type cxl_nvdimm_bridge_type;
 extern const struct device_type cxl_nvdimm_type;
 
-extern struct attribute_group cxl_base_attribute_group;
+extern const struct attribute_group cxl_base_attribute_group;
 
 struct cxl_send_command;
 struct cxl_mem_query_commands;
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 61029cb7ac62..ac2d40741686 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -106,16 +106,16 @@ static struct attribute *cxl_memdev_ram_attributes[] = {
 	NULL,
 };
 
-static struct attribute_group cxl_memdev_attribute_group = {
+static const struct attribute_group cxl_memdev_attribute_group = {
 	.attrs = cxl_memdev_attributes,
 };
 
-static struct attribute_group cxl_memdev_ram_attribute_group = {
+static const struct attribute_group cxl_memdev_ram_attribute_group = {
 	.name = "ram",
 	.attrs = cxl_memdev_ram_attributes,
 };
 
-static struct attribute_group cxl_memdev_pmem_attribute_group = {
+static const struct attribute_group cxl_memdev_pmem_attribute_group = {
 	.name = "pmem",
 	.attrs = cxl_memdev_pmem_attributes,
 };
-- 
2.35.1

