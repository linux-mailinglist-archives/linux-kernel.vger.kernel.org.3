Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E569259A615
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 21:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351220AbiHSTI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 15:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351140AbiHSTIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 15:08:36 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FC2520AD
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 12:08:32 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id c2so4902368plo.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 12:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=LRNQZAQfuVWPtn0ySqLWsoQsRuvJYWivZoqggybL5d4=;
        b=OJYjgn5Ecua8yljlsSDpa51lK5T4ff4foNJdIiSLf5dNe6a6frhKr7dxS9Bbj8nSoo
         HnirEUD7kvbmjSOXMm+vZvJWj9rRAvvR6hfXpQowjzOFLjXwmEz0eKisYWgGc6noO/v0
         yHP6AClXhnWajIVHARTyTmYCabfyodtv1lpm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=LRNQZAQfuVWPtn0ySqLWsoQsRuvJYWivZoqggybL5d4=;
        b=J/lPMQ1XOjLM4emE8ROyfGch/2m6tYUbjaQ0SD37kpl5G/OHjn0kOjz/fYPxpZNg/V
         +s21D58bLkbgz1wlony2BdRoG8WmvwO9QsrofIQlsSoMjkE9OrxdHQqQfEDY/YjbIJv7
         C5bmjHDcCeEkegpXZDgs2nwTWuxyDJdu7f4XJ8P5FUI98RR6c/7rScG6OYBuIyIjRzM/
         x8mXbqEwaKkOoMOjhII/pnctDZW8NLy3tJsmncjIy+Gl7BCC/KS1vxLMDEZAMsm68PlX
         j3a6+EDOHep10u4UafanpN6QwiCaRCUfvP1L8Uw0cW/75MNlPXVgAH+m7w1lvivEhHCT
         EKTg==
X-Gm-Message-State: ACgBeo2J/iVKHvU55Aq1BHfRh8M/h0a1bRjxYEd9ou3496Mhj+QIJmk+
        unGlPL6Bw+0y/8nVBxFC/8u4qb6XWIhz9g==
X-Google-Smtp-Source: AA6agR5y8NDxG372IwiHy3L/WeoVZMiJNDnSzObCzFMnj9kywQ5kojSHeAn2uZkfOggsjIO+U3I8Zw==
X-Received: by 2002:a17:903:494:b0:172:9823:e355 with SMTP id jj20-20020a170903049400b001729823e355mr8608235plb.75.1660936112240;
        Fri, 19 Aug 2022 12:08:32 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id b14-20020a170903228e00b00172a567d910sm3499775plh.289.2022.08.19.12.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 12:08:32 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Cc:     bleung@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 3/4] platform/chrome: cros_ec_typec: Stash port driver info
Date:   Fri, 19 Aug 2022 19:08:04 +0000
Message-Id: <20220819190807.1275937-4-pmalani@chromium.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
In-Reply-To: <20220819190807.1275937-1-pmalani@chromium.org>
References: <20220819190807.1275937-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stash port number and a pointer to the driver-specific struct in the
local Type-C port struct.

These can be useful to the port driver to figure out how to communicate
with the ChromeOS EC when an altmode driver related callback is invoked
from the Type-C class code.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index dc5722db2066..7daf4207c11e 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -44,6 +44,7 @@ struct cros_typec_altmode_node {
 /* Per port data. */
 struct cros_typec_port {
 	struct typec_port *port;
+	int port_num;
 	/* Initial capabilities for the port. */
 	struct typec_capability caps;
 	struct typec_partner *partner;
@@ -71,6 +72,8 @@ struct cros_typec_port {
 	struct ec_response_typec_discovery *disc_data;
 	struct list_head partner_mode_list;
 	struct list_head plug_mode_list;
+
+	struct cros_typec_data *typec_data;
 };
 
 /* Platform-specific data for the Chrome OS EC Type C controller. */
@@ -368,6 +371,8 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
 			goto unregister_ports;
 		}
 
+		cros_port->port_num = port_num;
+		cros_port->typec_data = typec;
 		typec->ports[port_num] = cros_port;
 		cap = &cros_port->caps;
 
-- 
2.37.1.595.g718a3a8f04-goog

