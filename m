Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04AE44ECB30
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 19:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349647AbiC3SBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 14:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349585AbiC3SAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 14:00:49 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450D310BBF9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:58:56 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id 72-20020a62154b000000b004fb53e16d5dso6057601pfv.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=vbOqH58T9uDB8od+8YQ9Z51JI1I/pGP28S9y2SbYsyA=;
        b=UhrB8aJly3NKo9FusXLwvbqHoxzYwGH/mI8Y0hBLQMwXQV9fE3RNKrri8a3Bpo2+8z
         kRbxEuyCBMMJZW7FYGpSmfFAc7lfbORUYaqgmhR2WlMx+HziBQeUuMjgF+lfs04nC3yS
         iTIqwLb3hc07JtazjnXZ/ubI8unpgOvZ+eHWBRTKzWvoh353ZVftSp/aO4QM5HGdeKDz
         qdQ2rR+sdW54fiWEkhPD0hgiUO3UgZTDEzoH1YAUJsRZ/PEDfFWOvTYD03b6ProRrXdJ
         X2jxVy910a24N07Z/JDQ43lT7GVOtHhICZqwafO70c464cldx6y7gg1hs2ShF2Jni7Ul
         CXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=vbOqH58T9uDB8od+8YQ9Z51JI1I/pGP28S9y2SbYsyA=;
        b=ZMzQGjLv+pojXvioIg0ZZvNrId/ZnHz7stcieqoPfNkDPexEXL790hCCAcsxAmtuj7
         8eIonoxT+Pn/f326GtjGZesjJDy6p4vbrnp/m9cNmc8N67cSh4tExKcTqStzn7GW+3QS
         dQYiDidZWYpmz8zY7Z14gg949hlyVTsugXTqBID4/M/ijafHMnk2XVaD9AAsvABCh9y2
         gs3CNMTHBUDQ3wNiDJ+rG1tws8BmYwBTAeB3Rp2dylf5hA4wOq814DS82L/ahalIxOr1
         piNzue1OiiginxZDUw6l0qqu2yk9iGRilhSk5Kaa4aCUWjC5ijPFNm+VHKxpUJW9MMKX
         6cBw==
X-Gm-Message-State: AOAM532T91D7qe4IJeK/QiOJmqn/gKJ+JywuNbZh2RLzYMXWrYb5ZoUd
        SqBRq5Y0juvDXK85eF1a1NLkH+Z9Ryc0CA==
X-Google-Smtp-Source: ABdhPJx4e3g65Tj1Um8sG6Sr4wYKhbwQHH5rE7kbBP4L3kIlZtKo3ehuQxIKPPMAx541ktFZjJ2psIVbKu9cGg==
X-Received: from wonchungspecialist.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1440])
 (user=wonchung job=sendgmr) by 2002:a05:6a00:815:b0:4fb:e46:511c with SMTP id
 m21-20020a056a00081500b004fb0e46511cmr634719pfk.54.1648663135675; Wed, 30 Mar
 2022 10:58:55 -0700 (PDT)
Date:   Wed, 30 Mar 2022 17:58:50 +0000
Message-Id: <20220330175850.2030509-1-wonchung@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH] misc/mei: Add NULL check to component match callback functions
From:   Won Chung <wonchung@google.com>
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benson Leung <bleung@google.com>,
        Prashant Malani <pmalani@google.com>,
        linux-kernel@vger.kernel.org, Won Chung <wonchung@google.com>
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

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Won Chung <wonchung@google.com>
---
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

