Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A161473424
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 19:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241928AbhLMSg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 13:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241925AbhLMSg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 13:36:27 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A033AC061748;
        Mon, 13 Dec 2021 10:36:26 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id t5so54973337edd.0;
        Mon, 13 Dec 2021 10:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D9HDwMRbrHhqS+RAMOtyip5SrGwIhn2OMyxvs6pUsog=;
        b=GyXp1bRpM5xc7y3ovN+XrgnFL/YT1pQGPbuM+V0usMfizPWpZMmuSZYAm48SNUPOk5
         g4YgXhpZfg5FO5IE7PXSLpTCOKM8VwCL7KTGTmZwyt+vABMyB5nq+jbR65GcPQMOsJ71
         n0SXjFiJdEam3BLP/W7+3ujAMM0sTLr5MlW9bk90Na3s719RfbbIcfam7eWlnI2PFmxC
         P2l2+102sXsKIQEHGmD4JBH424gFi+5cCPStTidN8YBf3vTxbVUNgoet0HCvoI+KkurZ
         LhLd4utOgmvpR8I7O/ZmUV3t4ERBurWpOlUbMI/yTYBlh797DHDwsO6OPeygpCqpV3Ri
         9jWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D9HDwMRbrHhqS+RAMOtyip5SrGwIhn2OMyxvs6pUsog=;
        b=vi4o3VkEBYZ1n8zXTZ3l9dOzqRrXgz/wMww8eblZ0SHsMoFHlF4+uFqXpMMFRS/TJL
         UukluViRbTeDg6Puxc/+gBtjJ5avuvuGoG5n8BFUPVjsmTWEcCZi8mvQKF5WhQEI3N5J
         pfWg51wKoDHptDcp+t9XAzwUs4pNTPGT7J0BvksW+E3ulrkQ0VgquBdR8kRdQReRn9i6
         QHzYGChHYNIo1C69u7gekNse2IWaTw8YnLkoSsqwIy4Fg7+lBU++9TNvHjCgHFZVct4C
         uywKbP5KxGoMaKanOtxaR63+XVNowt5uXZnEHsmBWwWoZLcIgrpZn1Qp+HS8HNIU5DOI
         Gjrg==
X-Gm-Message-State: AOAM5305Bn/FP0h1no/kg2FircAot9yQ4plDfXn0Eb6nTBCSqzzM7sUa
        g94CcWwakQwm67ZG8TgiQeg=
X-Google-Smtp-Source: ABdhPJyfwLPxKj8REmRfcQVQFjc+QGvFUevReO93kayGymfoGsxl56jpZ2lRWZeE8qQO7S6N+YTIAw==
X-Received: by 2002:a17:906:9f10:: with SMTP id fy16mr54595ejc.637.1639420585197;
        Mon, 13 Dec 2021 10:36:25 -0800 (PST)
Received: from CLU-56K1TB3.ad.garmin.com ([176.223.64.4])
        by smtp.gmail.com with ESMTPSA id q17sm6816793edd.10.2021.12.13.10.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 10:36:24 -0800 (PST)
From:   Razvan Heghedus <heghedus.razvan@gmail.com>
Cc:     heghedus.razvan@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        Wei Ming Chen <jj251510319013@gmail.com>,
        Peter Chen <peter.chen@nxp.com>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] usb: core: Export usb_device_match_id
Date:   Mon, 13 Dec 2021 20:36:14 +0200
Message-Id: <20211213183617.14156-1-heghedus.razvan@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export usb_device_match_id so that it can be used for easily matching an
usb_device with a table of IDs.

Signed-off-by: Razvan Heghedus <heghedus.razvan@gmail.com>
---
 Changes in v4:
  - make a patch series
 drivers/usb/core/driver.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index 267a134311be..355ed33a2179 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -834,6 +834,7 @@ const struct usb_device_id *usb_device_match_id(struct usb_device *udev,
 
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(usb_device_match_id);
 
 bool usb_driver_applicable(struct usb_device *udev,
 			   struct usb_device_driver *udrv)
-- 
2.34.1

