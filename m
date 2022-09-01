Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204F35AA06B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 21:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234587AbiIATvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 15:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233680AbiIATvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 15:51:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA72445F56
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 12:51:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 75513B82933
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 19:51:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D788C433D6;
        Thu,  1 Sep 2022 19:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662061864;
        bh=ek561zrci+T240jIRlvhhGht6fexDVv5DyBcQ95A8eQ=;
        h=From:To:Cc:Subject:Date:From;
        b=eOfQWYh+HJ+GIyfaZcOMEBACc4xr2LnMz3ApFSvfQaS3B4qarCBf/2bnRUIIgMd1J
         PO7tyNwhFPYBCLmyh+2h6ZLOwGXfnU0fp9mrGIfjOpOz9cQNB79/JLWl4MBGjBjoBa
         d8G4tIOXKksBA3BD87+xqnZJqtvQvezkpYQ6XEaG2Jf5CrKIfSP43kiZc91sZz9jQt
         w8CbyuCiQK+6xwUt5nVZp5UpGUv9H337SrOED2gRkr943hWRkcx7ohePiy4TRnyQ8E
         Co66Urd8RxpVpvCdC//OQLnXOyLsaKpjUcsvz4aOuBDq06BGj4v4b3ca+TxBuHaE8C
         TZFtE2vHuIcsA==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] coresight: cti-sysfs: Mark coresight_cti_reg_store() as __maybe_unused
Date:   Thu,  1 Sep 2022 12:50:55 -0700
Message-Id: <20220901195055.1932340-1-nathan@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building without CONFIG_CORESIGHT_CTI_INTEGRATION_REGS, there is a
warning about coresight_cti_reg_store() being unused in the file:

  drivers/hwtracing/coresight/coresight-cti-sysfs.c:184:16: warning: 'coresight_cti_reg_store' defined but not used [-Wunused-function]
    184 | static ssize_t coresight_cti_reg_store(struct device *dev,
        |                ^~~~~~~~~~~~~~~~~~~~~~~

This is expected as coresight_cti_reg_store() is only used in the
coresight_cti_reg_rw macro, which is only used in a block guarded by
CONFIG_CORESIGHT_CTI_INTEGRATION_REGS. Mark coresight_cti_reg_store() as
__maybe_unused to clearly indicate that the function may be unused
depending on the configuration.

Fixes: fbca79e55429 ("coresight: cti-sysfs: Re-use same functions for similar sysfs register accessors")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/hwtracing/coresight/coresight-cti-sysfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-cti-sysfs.c b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
index 478b8d38b744..6d59c815ecf5 100644
--- a/drivers/hwtracing/coresight/coresight-cti-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
@@ -181,9 +181,9 @@ static ssize_t coresight_cti_reg_show(struct device *dev,
 }
 
 /* Write registers with power check only (no enable check). */
-static ssize_t coresight_cti_reg_store(struct device *dev,
-				       struct device_attribute *attr,
-				       const char *buf, size_t size)
+static __maybe_unused ssize_t coresight_cti_reg_store(struct device *dev,
+						      struct device_attribute *attr,
+						      const char *buf, size_t size)
 {
 	struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct cs_off_attribute *cti_attr = container_of(attr, struct cs_off_attribute, attr);

base-commit: 0a98181f805058773961c5ab3172ecf1bf1ed0e1
-- 
2.37.3

