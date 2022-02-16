Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B0B4B84E4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 10:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbiBPJwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 04:52:39 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbiBPJwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 04:52:32 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 202E4205FD
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 01:52:13 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A42BE113E;
        Wed, 16 Feb 2022 01:52:07 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.47.182])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BEA4E3F718;
        Wed, 16 Feb 2022 01:52:04 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] coresight: Drop unused 'none' enum value for each component
Date:   Wed, 16 Feb 2022 15:21:58 +0530
Message-Id: <1645005118-10561-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CORESIGHT_DEV_TYPE_NONE/CORESIGHT_DEV_SUBTYPE_XXXX_NONE values are not used
any where. Actual enumeration can start from 0. Just drop these unused enum
values.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 drivers/hwtracing/coresight/coresight-core.c | 3 ---
 include/linux/coresight.h                    | 5 -----
 2 files changed, 8 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 88653d1c06a4..af00dca8d1ac 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -1278,9 +1278,6 @@ static struct attribute *coresight_source_attrs[] = {
 ATTRIBUTE_GROUPS(coresight_source);
 
 static struct device_type coresight_dev_type[] = {
-	{
-		.name = "none",
-	},
 	{
 		.name = "sink",
 		.groups = coresight_sink_groups,
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 93a2922b7653..9f445f09fcfe 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -36,7 +36,6 @@
 extern struct bus_type coresight_bustype;
 
 enum coresight_dev_type {
-	CORESIGHT_DEV_TYPE_NONE,
 	CORESIGHT_DEV_TYPE_SINK,
 	CORESIGHT_DEV_TYPE_LINK,
 	CORESIGHT_DEV_TYPE_LINKSINK,
@@ -46,7 +45,6 @@ enum coresight_dev_type {
 };
 
 enum coresight_dev_subtype_sink {
-	CORESIGHT_DEV_SUBTYPE_SINK_NONE,
 	CORESIGHT_DEV_SUBTYPE_SINK_PORT,
 	CORESIGHT_DEV_SUBTYPE_SINK_BUFFER,
 	CORESIGHT_DEV_SUBTYPE_SINK_SYSMEM,
@@ -54,21 +52,18 @@ enum coresight_dev_subtype_sink {
 };
 
 enum coresight_dev_subtype_link {
-	CORESIGHT_DEV_SUBTYPE_LINK_NONE,
 	CORESIGHT_DEV_SUBTYPE_LINK_MERG,
 	CORESIGHT_DEV_SUBTYPE_LINK_SPLIT,
 	CORESIGHT_DEV_SUBTYPE_LINK_FIFO,
 };
 
 enum coresight_dev_subtype_source {
-	CORESIGHT_DEV_SUBTYPE_SOURCE_NONE,
 	CORESIGHT_DEV_SUBTYPE_SOURCE_PROC,
 	CORESIGHT_DEV_SUBTYPE_SOURCE_BUS,
 	CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE,
 };
 
 enum coresight_dev_subtype_helper {
-	CORESIGHT_DEV_SUBTYPE_HELPER_NONE,
 	CORESIGHT_DEV_SUBTYPE_HELPER_CATU,
 };
 
-- 
2.20.1

