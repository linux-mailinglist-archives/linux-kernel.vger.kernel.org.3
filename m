Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218A64C8769
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 10:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbiCAJIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 04:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbiCAJIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 04:08:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903D613CF2;
        Tue,  1 Mar 2022 01:07:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 312CFB817F7;
        Tue,  1 Mar 2022 09:07:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73901C340EE;
        Tue,  1 Mar 2022 09:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646125653;
        bh=2u98asnBmPKIGgO3EIdj0rvNyZeALdXhp3s7aF1sT0s=;
        h=From:To:Cc:Subject:Date:From;
        b=HpNol1ar3qyK5CZCPYkworAtpi3XK2nfDDIfXHNkFWmDyFWhqxW40zojZKAMKBi2q
         yL6UWuw0DW8j2JVoIJ0Wg3IIOUF9EvNlQN/O3SVpYIn+JjMkNPndeYtIeySu1ZThyA
         +TVZyOUIt6EHrHSG18mAOvUUqUJNkzYQi4CK6WkzXs4ycIBUwQZvzslb7pxq7VUX2N
         jmi+3Vo2TqSJ40qB/jTQnDIiiGFkV1+DQZxG9zhs/6brTjm5HvXRHYfy67fQ2xM+lE
         RVcqFdjYZugtAdsXXQybeu3dU55KLY8qIrHlYAbb+f4G7VPQWqy6EclNa2Sq7h1wfd
         gMuYTw3aVZM9A==
From:   Georgi Djakov <djakov@kernel.org>
To:     elder@linaro.org, djakov@kernel.org
Cc:     bjorn.andersson@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] interconnect: Add stubs for the bulk API
Date:   Tue,  1 Mar 2022 11:07:35 +0200
Message-Id: <20220301090735.26599-1-djakov@kernel.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add stub functions for the bulk API to allow compile testing.

Signed-off-by: Georgi Djakov <djakov@kernel.org>
---
 include/linux/interconnect.h | 36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
index f2dd2fc8d3cd..f685777b875e 100644
--- a/include/linux/interconnect.h
+++ b/include/linux/interconnect.h
@@ -38,13 +38,6 @@ struct icc_bulk_data {
 	u32 peak_bw;
 };
 
-int __must_check of_icc_bulk_get(struct device *dev, int num_paths,
-				 struct icc_bulk_data *paths);
-void icc_bulk_put(int num_paths, struct icc_bulk_data *paths);
-int icc_bulk_set_bw(int num_paths, const struct icc_bulk_data *paths);
-int icc_bulk_enable(int num_paths, const struct icc_bulk_data *paths);
-void icc_bulk_disable(int num_paths, const struct icc_bulk_data *paths);
-
 #if IS_ENABLED(CONFIG_INTERCONNECT)
 
 struct icc_path *icc_get(struct device *dev, const int src_id,
@@ -58,6 +51,12 @@ int icc_disable(struct icc_path *path);
 int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw);
 void icc_set_tag(struct icc_path *path, u32 tag);
 const char *icc_get_name(struct icc_path *path);
+int __must_check of_icc_bulk_get(struct device *dev, int num_paths,
+				 struct icc_bulk_data *paths);
+void icc_bulk_put(int num_paths, struct icc_bulk_data *paths);
+int icc_bulk_set_bw(int num_paths, const struct icc_bulk_data *paths);
+int icc_bulk_enable(int num_paths, const struct icc_bulk_data *paths);
+void icc_bulk_disable(int num_paths, const struct icc_bulk_data *paths);
 
 #else
 
@@ -112,6 +111,29 @@ static inline const char *icc_get_name(struct icc_path *path)
 	return NULL;
 }
 
+static inline int of_icc_bulk_get(struct device *dev, int num_paths, struct icc_bulk_data *paths)
+{
+	return 0;
+}
+
+static inline void icc_bulk_put(int num_paths, struct icc_bulk_data *paths)
+{
+}
+
+static inline int icc_bulk_set_bw(int num_paths, const struct icc_bulk_data *paths)
+{
+	return 0;
+}
+
+static inline int icc_bulk_enable(int num_paths, const struct icc_bulk_data *paths)
+{
+	return 0;
+}
+
+static inline void icc_bulk_disable(int num_paths, const struct icc_bulk_data *paths)
+{
+}
+
 #endif /* CONFIG_INTERCONNECT */
 
 #endif /* __LINUX_INTERCONNECT_H */
