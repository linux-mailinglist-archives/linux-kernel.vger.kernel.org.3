Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 742EF484CBA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 04:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237201AbiAEDNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 22:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237196AbiAEDNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 22:13:20 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F5AC061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 19:13:20 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id bp39so35945415qtb.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 19:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=howett-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F6zyq73HTm/un92FVOEIYcp2e6RteV0rl4PLFbEb9o0=;
        b=UiwTf0JrOyjTyS5MJgqHOYcgOJhrdUgIGkR47DtOpl9TR86oZ/U68sNEQ9VFGcTEsW
         IosEv5FC+6sa73lD2sr4LsdnVSQhSMpL//8p9tq5n2zy923F4JMgFp0ISXv4NnMxOTGU
         nEWS25LqjZO1EMuYSMIt+WWw7rtFXLK+1UoTd9vVVrcGopWsT03dQtCKalpkYLOSPYB8
         8Q1yhnQwr6N0kAYLnWFo1e3q4V0fTCwFftCWHkFszp6zYYEnkeBsB20UWW9sTvXrmksw
         2EETWuB7P1+/d+bpMIUqVZ3urgMEvGgGmkKkwLEOXAnF9YDMang2jZWhQSeo/5CrmF87
         AnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F6zyq73HTm/un92FVOEIYcp2e6RteV0rl4PLFbEb9o0=;
        b=c2/9a265q+erPOEXKg0tj7sY8zFeT2ANrX3ofqzj+qgGDPLllT9o7l7cMtN5z4klo1
         pgrBfc30sys6ipdg2LRpinj9/u7m7W/8MjPwpliCFXc/lb1LOD2FaJW1rxoMWYGDHYRM
         VHyLB4lJz/XVX4mzb5QOokidrBV/Bn9VZUqcbr2NQC/xlT35nBEO34a8oae+u8XjZ3dw
         i/bSJ/dYqp5tIyEy8rdDLMQcFfGFy0RmKFiQYpLtU0Hzc8kicLnnxYdbj4qs7J2E4nDD
         AGBN7V0b12tk8JYV2aCsltxo8ZfiLNMgjC9I96N/dhJBXPYbJOZu49DLc3bQ3VFI3H67
         bRVQ==
X-Gm-Message-State: AOAM531lWSxTodwX943rkhlqgtdl6r2+fKXT2gE7CFTw+LbD5cXEHJEu
        KXjXbwVE+JRov/+FMik+g+WU7S+aXQD+PA==
X-Google-Smtp-Source: ABdhPJx7pUqJXRi0d4rIyCUa4H2v36BtZk6CoMKjZulCyNZTQWmxJb/SzG1uVwvS2G5OHSzWBPu+XA==
X-Received: by 2002:ac8:47cb:: with SMTP id d11mr46588544qtr.446.1641352399281;
        Tue, 04 Jan 2022 19:13:19 -0800 (PST)
Received: from rigel.delfino.n.howett.net ([2600:1700:df50:a7cf::725])
        by smtp.googlemail.com with ESMTPSA id s6sm32629632qki.23.2022.01.04.19.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 19:13:18 -0800 (PST)
From:   "Dustin L. Howett" <dustin@howett.net>
To:     linux-kernel@vger.kernel.org
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Dustin L. Howett" <dustin@howett.net>
Subject: [PATCH 1/2] platform/chrome: cros-ec: detect the Framework Laptop
Date:   Tue,  4 Jan 2022 21:12:41 -0600
Message-Id: <20220105031242.287751-2-dustin@howett.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220105031242.287751-1-dustin@howett.net>
References: <20220105031242.287751-1-dustin@howett.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Framework Laptop identifies itself in DMI with manufacturer
"Framework" and product "Laptop".

Signed-off-by: Dustin L. Howett <dustin@howett.net>
---
 drivers/platform/chrome/cros_ec_lpc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index d6306d2a096f..458eb59db2ff 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -500,6 +500,14 @@ static const struct dmi_system_id cros_ec_lpc_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Glimmer"),
 		},
 	},
+	/* A small number of non-Chromebook/box machines also use the ChromeOS EC */
+	{
+		/* the Framework Laptop */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Framework"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Laptop"),
+		},
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(dmi, cros_ec_lpc_dmi_table);
-- 
2.34.1

