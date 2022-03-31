Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D970F4ED177
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 03:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352425AbiCaCAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 22:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241393AbiCaCAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 22:00:12 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152A46405;
        Wed, 30 Mar 2022 18:58:25 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id d30so5575431pjk.0;
        Wed, 30 Mar 2022 18:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=qbepWknWAIx3U4lZWaC4n3p6Chx94Z3VQB0ZwMzdJMk=;
        b=h7ijxiAvouZL8iZgZWu7eaWS/RH+wjTdZKm3b6c99deOb8Vnal6qnndGjq9ibGkEnJ
         m9Vrbd1b0gMK97gnesAM2/CwID3OiuHbPWy36wLugfDoXSHgs8Lcw2FehNNJaqRPuDEK
         FtunEwqdsp7eV/dPA9PRHnmXTZr6PodRRVaelzn8v3skl4IRxVZBgp7ekYMIDNbpq5xH
         oW+Lh+Z8WTP9K3u5EdM4poos1UFzOOinTi9IuTJK7OJGhvV9HSFbEiQROjMGru46qDeU
         eP3uznYuhzi9L2MnekolSo09RxyOIlI8NcpnGPYjjIA0mHGeVeuZ4B7SXjtRyWInEG27
         fhkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qbepWknWAIx3U4lZWaC4n3p6Chx94Z3VQB0ZwMzdJMk=;
        b=N6Igq6muFlVekHV8KEUmH6j+roKR8zaNsfJiAqIM8ytUUHfQQkLksSFnmpxIv9LN/x
         ZUb0CZ3FVDNIuiDhh6BI8PCspgOlCEyFnaLIUzHexGtVQOqw0qyl/YTrq6OS1Q7LPEL/
         Ghm9MN5UOnSXegxV10xq7WWaS1nTiUEZ+ON86eMo2AfWkxF4tSPkW6AQ7u6vrCWwMfoz
         eX5yLCx2FbJqcETMTjtGjvp5+YOCGdNfl2sxeUnBxAHQffu2dKS/urVbvKiP0bOQHegW
         XU3IqCbCeUPXOwGg7wisZu7oC0PbTPivIG9FTGWKOczK1a2VkIAgf1yrxbCqXlfnFM3L
         iiNg==
X-Gm-Message-State: AOAM532wr9876s5JZCxNuBa2B4zWtdRpawhVlb3Jl7Iwe0d3sjxqFQ41
        hdyT3PPvnLgwBcTCOecySiQ=
X-Google-Smtp-Source: ABdhPJy2BE5OpsL1Gb6vbNqQBQaGTpQazhKtwLsJneD7r49h5PoVSruOJV6pWM7b9DonkRNprQd+gQ==
X-Received: by 2002:a17:903:32ce:b0:155:db89:e3ee with SMTP id i14-20020a17090332ce00b00155db89e3eemr2589769plr.164.1648691904467;
        Wed, 30 Mar 2022 18:58:24 -0700 (PDT)
Received: from ubuntu.huawei.com ([119.3.119.18])
        by smtp.googlemail.com with ESMTPSA id w13-20020a17090a5e0d00b001c7d4099670sm7568639pjf.28.2022.03.30.18.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 18:58:23 -0700 (PDT)
From:   Xiaomeng Tong <xiam0nd.tong@gmail.com>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaomeng Tong <xiam0nd.tong@gmail.com>
Subject: [PATCH] opp: use list iterator only inside the loop
Date:   Thu, 31 Mar 2022 09:58:18 +0800
Message-Id: <20220331015818.28045-1-xiam0nd.tong@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    dev = new_dev->dev;

As discussed before, we should avoid to use a list iterator variable
outside the loop which is considered harmful[1].

In this case, use a new variable 'iter' as the list iterator, while
use the old variable 'new_dev' as a dedicated pointer to point to the
found entry.

[1]:  https://lkml.org/lkml/2022/2/17/1032

Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
---
 drivers/opp/debugfs.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
index 596c185b5dda..a4476985e4ce 100644
--- a/drivers/opp/debugfs.c
+++ b/drivers/opp/debugfs.c
@@ -187,14 +187,19 @@ void opp_debug_register(struct opp_device *opp_dev, struct opp_table *opp_table)
 static void opp_migrate_dentry(struct opp_device *opp_dev,
 			       struct opp_table *opp_table)
 {
-	struct opp_device *new_dev;
+	struct opp_device *new_dev = NULL, *iter;
 	const struct device *dev;
 	struct dentry *dentry;
 
 	/* Look for next opp-dev */
-	list_for_each_entry(new_dev, &opp_table->dev_list, node)
-		if (new_dev != opp_dev)
+	list_for_each_entry(iter, &opp_table->dev_list, node)
+		if (iter != opp_dev) {
+			new_dev = iter;
 			break;
+		}
+
+	if (!new_dev)
+		return;
 
 	/* new_dev is guaranteed to be valid here */
 	dev = new_dev->dev;
-- 
2.17.1

