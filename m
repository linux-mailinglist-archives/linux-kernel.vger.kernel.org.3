Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C95CD49EC01
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 21:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343917AbiA0UDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 15:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343894AbiA0UCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 15:02:42 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1DFC06177D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 12:02:38 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id g2so3219055pgo.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 12:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ckuMr+Ncb/jcw9TvP8N13lANp/qUitpt+atxz271bCg=;
        b=VCDCJ2XXoEo5R2boVBxoQIPLBYXRZ4ygF5m58BNpDlZWi0b2RKflooEmM0NvSKn47v
         M8K2o4X4DejnrnAjIJ9q3+1sECxzMIDHOFpFmOMgT91R+rXZdeyhn45ubWI9MY4y+lGt
         LQpRvpFof698nsHlX6PxiqwGND/FxZPe/vWmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ckuMr+Ncb/jcw9TvP8N13lANp/qUitpt+atxz271bCg=;
        b=RP8Ntov9hl6odgiIATU5ATORlm+TgnlQxlaEFXrZYoFbOtfiJPAVxdO+CSTuKKykCh
         8Q635EEKiOl7p7lRATnIEV90ezNww/vjR0fG1G8CWW5SKHuAHhPMx6ikrLY1OTGov6n7
         V5Vz279H+bPe2nQ4XECAq4Jtw30ClfhNyyGkEPri2Plq+CPvP/TJHcpLUzKPGBXfyEmZ
         BPgpxK63yu/NeGXceZO47vELEp9uk68OBBM1yZwi8oe9V2PaY0yckvC349zasiqRLOh/
         MncKn71XSU/chzvXtvgWuM3DkabbqIt5nM/pci1ms6mk2qztZp3ks6X4TxRUN14lRVEl
         Hqrw==
X-Gm-Message-State: AOAM530D0g8atGX2LJNGGAPFvQ4n9/a7YbgWVCII6f76YqGZ07gNhPDC
        o8/6JAzmlkq8dfOjKBpFDP2rEQ==
X-Google-Smtp-Source: ABdhPJzi7TeBcTmXGNEgo6gqdKnb0pcCN6RMeqZ8Q6M/Rim3Xa3q76WIvhpg51Dhu0lKrNyj5S5Unw==
X-Received: by 2002:a62:e116:: with SMTP id q22mr4473788pfh.48.1643313757782;
        Thu, 27 Jan 2022 12:02:37 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:9246:1838:3243:3071])
        by smtp.gmail.com with ESMTPSA id k21sm6561190pff.33.2022.01.27.12.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 12:02:37 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH v6 32/35] usb: typec: port-mapper: Migrate to aggregate driver
Date:   Thu, 27 Jan 2022 12:01:38 -0800
Message-Id: <20220127200141.1295328-33-swboyd@chromium.org>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220127200141.1295328-1-swboyd@chromium.org>
References: <20220127200141.1295328-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use an aggregate driver instead of component ops so that we can get
proper driver probe ordering of the aggregate device with respect to all
the component devices that make up the aggregate device.

Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Saravana Kannan <saravanak@google.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/usb/typec/port-mapper.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/typec/port-mapper.c b/drivers/usb/typec/port-mapper.c
index 07d307418b47..33fbebc6a85b 100644
--- a/drivers/usb/typec/port-mapper.c
+++ b/drivers/usb/typec/port-mapper.c
@@ -11,19 +11,27 @@
 
 #include "class.h"
 
-static int typec_aggregate_bind(struct device *dev)
+static int typec_aggregate_probe(struct aggregate_device *adev)
 {
+	struct device *dev = aggregate_device_parent(adev);
+
 	return component_bind_all(dev, NULL);
 }
 
-static void typec_aggregate_unbind(struct device *dev)
+static void typec_aggregate_remove(struct aggregate_device *adev)
 {
+	struct device *dev = aggregate_device_parent(adev);
+
 	component_unbind_all(dev, NULL);
 }
 
-static const struct component_master_ops typec_aggregate_ops = {
-	.bind = typec_aggregate_bind,
-	.unbind = typec_aggregate_unbind,
+static struct aggregate_driver typec_aggregate_driver = {
+	.probe = typec_aggregate_probe,
+	.remove = typec_aggregate_remove,
+	.driver = {
+		.name = "typec_aggregate",
+		.owner = THIS_MODULE,
+	},
 };
 
 struct each_port_arg {
@@ -69,10 +77,10 @@ int typec_link_ports(struct typec_port *con)
 	 * improvements to the component framework. Right now you can only have
 	 * one master per device.
 	 */
-	return component_master_add_with_match(&con->dev, &typec_aggregate_ops, arg.match);
+	return component_aggregate_register(&con->dev, &typec_aggregate_driver, arg.match);
 }
 
 void typec_unlink_ports(struct typec_port *con)
 {
-	component_master_del(&con->dev, &typec_aggregate_ops);
+	component_aggregate_unregister(&con->dev, &typec_aggregate_driver);
 }
-- 
https://chromeos.dev

