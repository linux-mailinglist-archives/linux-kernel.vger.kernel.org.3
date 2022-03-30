Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069444ECE9E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 23:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347665AbiC3VTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 17:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbiC3VTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 17:19:05 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE525882A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 14:17:20 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id b19-20020a621b13000000b004fa68b3677bso12687429pfb.20
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 14:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=/g82k/yLueQhmfK5T8wtfFe4TaWb3pB9z1BLHTV6OJE=;
        b=j21uT8/pXmhxq6ckzyD7U2D1dwXi6tKugXYMhZw2nm4rpUFdNmCmbqk4iHZmSRo4Bx
         u2KCGC+TUYDFyH9zVujbfBX1r2pccMGEKaF/KFvl4fS6cr7YXF8uN8ADF8xvNiZJg067
         SrS2pigJnxnkv1alMvwNmeKMbOs9xe4g/2FqaQBhk7LZIrHobbp5nPydFHC/7+Z4fzgo
         R5bkdBK582OFRDTu0NYQ8pC2PuUWzZAibXi+tQ8b11y/hJEadv6p/uOWL6GS0p//BVrp
         NU7ZrpuJ3eBPKKNcq+GOvMdwcipXd/ca53DWflyKil/YqphkEI+AMcEno9CVXcR3tCOe
         y0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=/g82k/yLueQhmfK5T8wtfFe4TaWb3pB9z1BLHTV6OJE=;
        b=f9wodwrpOxg7MZAikSglBQ83upm1HzDncpalTlvE5Yqtuwwk1xGb9smD6njvK2xt2V
         jahyH4CJumh9GKiGvKp8ceia6w6k5agyL6aeup2+HRR4R+PvIVZRnlZ5WnCeFRIvnWgv
         K1JiGEpYW8dUGxrMMC4Mch29HoWASZ8oUhKh3pkr4SlxRGJmlzAPzjnPaazSoYNHRT/A
         Va/EvWZyw5tLhSgKtuX1mK/VPd009SbRLDbAeUaUx7B6wJd3WCdPeuh1rAl/p4e4AtwB
         QpyOuH00WW4lvsSjgbrm/zG3vbsjhtrmEdr2G52ZkgUJRncKhDnMqXOrECWGjJk5euEv
         yo/A==
X-Gm-Message-State: AOAM53204mQ04CQjDccpT816sWh61hHit4Uv7mQc7hgHdAeDXnPqvP/P
        zxlgs2W0BWyQc5KblZDLTgQhT2VkZIKnCQ==
X-Google-Smtp-Source: ABdhPJyj6MgKePd9IGXRGMOEDrYZUUs0KNEGd9MFx+MzvMwl6JlgtuEbbYak68UFhDwNIuTWzT+v5AaANfhLOw==
X-Received: from wonchungspecialist.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1440])
 (user=wonchung job=sendgmr) by 2002:a17:902:f54c:b0:154:6794:ab18 with SMTP
 id h12-20020a170902f54c00b001546794ab18mr1758684plf.118.1648675039601; Wed,
 30 Mar 2022 14:17:19 -0700 (PDT)
Date:   Wed, 30 Mar 2022 21:17:12 +0000
Message-Id: <20220330211712.2067044-1-wonchung@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v2] misc/mei: Add NULL check to component match callback functions
From:   Won Chung <wonchung@google.com>
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Won Chung <wonchung@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Component match callback functions need to check if expected data is
passed to them. Without this check, it can cause a NULL pointer
dereference when another driver registers a component before i915
drivers have their component master fully bind.

Fixes: 1e8d19d9b0dfc ("mei: hdcp: bind only with i915 on the same PCH")
Fixes: c2004ce99ed73 ("mei: pxp: export pavp client to me client bus")
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Won Chung <wonchung@google.com>
---
Changes from v1:
- Add "Fixes" tag
- Send to stable@vger.kernel.org

 drivers/misc/mei/hdcp/mei_hdcp.c | 2 +-
 drivers/misc/mei/pxp/mei_pxp.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/mei/hdcp/mei_hdcp.c b/drivers/misc/mei/hdcp/mei_hdcp.c
index ec2a4fce8581..843dbc2b21b1 100644
--- a/drivers/misc/mei/hdcp/mei_hdcp.c
+++ b/drivers/misc/mei/hdcp/mei_hdcp.c
@@ -784,7 +784,7 @@ static int mei_hdcp_component_match(struct device *dev, int subcomponent,
 {
 	struct device *base = data;
 
-	if (strcmp(dev->driver->name, "i915") ||
+	if (!base || !dev->driver || strcmp(dev->driver->name, "i915") ||
 	    subcomponent != I915_COMPONENT_HDCP)
 		return 0;
 
diff --git a/drivers/misc/mei/pxp/mei_pxp.c b/drivers/misc/mei/pxp/mei_pxp.c
index f7380d387bab..e32a81da8af6 100644
--- a/drivers/misc/mei/pxp/mei_pxp.c
+++ b/drivers/misc/mei/pxp/mei_pxp.c
@@ -131,7 +131,7 @@ static int mei_pxp_component_match(struct device *dev, int subcomponent,
 {
 	struct device *base = data;
 
-	if (strcmp(dev->driver->name, "i915") ||
+	if (!base || !dev->driver || strcmp(dev->driver->name, "i915") ||
 	    subcomponent != I915_COMPONENT_PXP)
 		return 0;
 
-- 
2.35.1.1021.g381101b075-goog

