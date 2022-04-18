Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7FCF505DCA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 19:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347276AbiDRSCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 14:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347272AbiDRSCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 14:02:23 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C6A35249
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 10:59:40 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id k2-20020a170902ba8200b0015613b12004so8176213pls.22
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 10:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=r4E23OnZATIS+lk5aixNnqKMCFgUPEq6mE0xznooD8Q=;
        b=Ae/sJwaupacpHLx5MtlaO/72tMhwQW3butupk70g0bqlEqW46BfYP642c+RYEnoVpL
         BFdiDTFPTRU5I8o5yvvsKMP5tAzg1uwOJFxadYTreohSBRGoIgKKai0w0OXYRwvU5jI/
         2wur/pyVHg3DwNdOnroCxTijDf3yZOGa/OcXkA6CHfGgfhyI9vuhiROqRmMMHiJLxW1y
         Mq657bhjwfQPnqdb9V0Ep5N8AdQk3f+8ikWwI7aeIANWIY8VpWXTCYxziw8B+nYt9HPu
         lTCYDV1pwDXZb0C+J6vZ7aRMv8JvQma6fBbls9tF0SXKiAnmrYLo5pAd+wSMoWB0GQmm
         K7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=r4E23OnZATIS+lk5aixNnqKMCFgUPEq6mE0xznooD8Q=;
        b=k1rllOR6q035k9b82iRGzk05b2wMCD0fV1fPA5L+2apFtEQW/RJBP2DUT5adzq7odh
         9/f/qjl780+PUVPGZ/NvraJ8INhsVTPef9OAObHyok4jxYQc9iyXQjduwbfGodsaGqHM
         xtw5wvXmlghezySYhT3ypME/8xZRWeO3sz4hYAcHs9D7nMVisnd4cL1iTR5nLRYfpxe/
         u75O54E75bcqAD1O7ntSO4LUDK8/aJmdod8xOGCiisiryVuFBggySq8IWn8zgMCgG0jE
         V0Og0uLtpOdl7eZazNNeuGpmTcuaRS0GVSbRIFF6zcWb1RqfBMF5Jv2SuzSsPRjq00pn
         RPCA==
X-Gm-Message-State: AOAM530lMR1isRHWDQleEtVOGpIVQg2w1uAOiOPkZnBUKVwUnM2y1Hok
        ClY9EdkSnWTnTw1N1Hda+kf5+bTTq9yN0A==
X-Google-Smtp-Source: ABdhPJxQSOxhrr3s0WCAgo0mfNesr2cbbIk81LRgy7vEHC4exxBn2q2r3vHXkXzkq5fWaDDVynSzYZkRwZxsFg==
X-Received: from wonchungspecialist.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1440])
 (user=wonchung job=sendgmr) by 2002:a05:6a00:15c4:b0:50a:7fec:c656 with SMTP
 id o4-20020a056a0015c400b0050a7fecc656mr3854566pfu.62.1650304780282; Mon, 18
 Apr 2022 10:59:40 -0700 (PDT)
Date:   Mon, 18 Apr 2022 17:59:31 +0000
In-Reply-To: <20220418175932.1809770-1-wonchung@google.com>
Message-Id: <20220418175932.1809770-2-wonchung@google.com>
Mime-Version: 1.0
References: <20220418175932.1809770-1-wonchung@google.com>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH 1/2] misc/mei: Add NULL check to component match callback functions
From:   Won Chung <wonchung@google.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Won Chung <wonchung@google.com>
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

Currently, component_match callback functions used in mei refers to the
driver name, assuming that the component device being matched has a
driver bound. It can cause a NULL pointer dereference when a device
without a driver bound registers a component. This is due to the nature
of the component framework where all registered components are matched
in any component_match callback functions. So even if a component is
registered by a totally irrelevant device, that component is also
shared to these callbacks for i915 driver.

To prevent totally irrelevant device being matched for i915 and causing
a NULL pointer dereference for checking driver name, add a NULL check on
dev->driver to check if there is a driver bound before checking the
driver name.

In the future, the string compare on the driver name, "i915" may need to
be refactored too.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Prashant Malani <pmalani@chromium.org>
Signed-off-by: Won Chung <wonchung@google.com>
---
 drivers/misc/mei/hdcp/mei_hdcp.c | 2 +-
 drivers/misc/mei/pxp/mei_pxp.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/mei/hdcp/mei_hdcp.c b/drivers/misc/mei/hdcp/mei_hdcp.c
index ec2a4fce8581..e889a8bd7ac8 100644
--- a/drivers/misc/mei/hdcp/mei_hdcp.c
+++ b/drivers/misc/mei/hdcp/mei_hdcp.c
@@ -784,7 +784,7 @@ static int mei_hdcp_component_match(struct device *dev, int subcomponent,
 {
 	struct device *base = data;
 
-	if (strcmp(dev->driver->name, "i915") ||
+	if (!dev->driver || strcmp(dev->driver->name, "i915") ||
 	    subcomponent != I915_COMPONENT_HDCP)
 		return 0;
 
diff --git a/drivers/misc/mei/pxp/mei_pxp.c b/drivers/misc/mei/pxp/mei_pxp.c
index f7380d387bab..5c39457e3f53 100644
--- a/drivers/misc/mei/pxp/mei_pxp.c
+++ b/drivers/misc/mei/pxp/mei_pxp.c
@@ -131,7 +131,7 @@ static int mei_pxp_component_match(struct device *dev, int subcomponent,
 {
 	struct device *base = data;
 
-	if (strcmp(dev->driver->name, "i915") ||
+	if (!dev->driver || strcmp(dev->driver->name, "i915") ||
 	    subcomponent != I915_COMPONENT_PXP)
 		return 0;
 
-- 
2.36.0.rc0.470.gd361397f0d-goog

