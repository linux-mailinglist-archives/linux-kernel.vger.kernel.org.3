Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953C9473322
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 18:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238035AbhLMRhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 12:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbhLMRg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 12:36:59 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19505C061574;
        Mon, 13 Dec 2021 09:36:59 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id e3so55504061edu.4;
        Mon, 13 Dec 2021 09:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=npNJEDwkoOlmwjF9zNsWKMDDzztWN2EkbCA8kte2oyU=;
        b=OiVA9Gwy/aau1qNb4vNLhEM7HPoyqe5ArGvIec/Neq+JtLUv6T1JXOkG9RsgRNlJH0
         2Cy+rhjZy8Yc/Uu3/Jo1mPbf44bvix8o+Cc9lwyGQx/ajSX10I3BhxfOSKuMkg2qd2To
         gZHHluTjrndATYmphJGRLCN2lnmCZV6+QuiiasKvXZJVD9dlg0KzJFWykNUnT6QC+AQh
         gaFhre9k5kajhI6FZ3jMFow+BPVSyIjFps0+fBfOY71/7KJoFzxxZVJWeMxHj8n/dOun
         J7ckGoG08zZ2smJ+9nVkSImPFz24mnB8nqaE9u59KJ22Kg5dlI7HI0OsGnaedLiNQ4mc
         xxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=npNJEDwkoOlmwjF9zNsWKMDDzztWN2EkbCA8kte2oyU=;
        b=rrOXLZ2bI5SrrP4SM5Of2bI2BnaN0jOx2FLcpk0v2TfNzRYAVSOILTLtkUUs6cegKp
         6FbQr0QGE4TqlvEUPw3l95suIVSxAYsFphmm9kssW7VVt3RVgp5APkKNZyJaoElTvD4G
         3/PCOQQCTuExrc4i1MeYWEqLw7VsyGiwhpMFoDU3so6wzjoLFe2z4t3ElvRleJwMRpc1
         XVhZplaQt6YcXprOdTXHH5FBnWBRXtKNtgm21Yv7E1ORSWUAUdjAy+nUf4jSCzMqmPWR
         8NqrTYiEV/sbyPc/fqjsuUKi6S3XnH9EBEC4+SxwpmEVybitQiZW2mW0ddFzhWJZKGJQ
         Il8w==
X-Gm-Message-State: AOAM530riF7lGUZxMQMUOVHvLSXLuSM/jAptOYg4pft2sw6VUjz/FM0o
        iz8cK78VKVwl7rDKRUf/7Hs=
X-Google-Smtp-Source: ABdhPJxbNvbgQGWkqz2J+eJ5C809PVuJgPLm2Wfd8eQFvP8hP3kv6ftgzgIBo9Zo8Ru1V3ZLIrxM0A==
X-Received: by 2002:a50:d606:: with SMTP id x6mr242372edi.124.1639417017748;
        Mon, 13 Dec 2021 09:36:57 -0800 (PST)
Received: from CLU-56K1TB3.ad.garmin.com ([176.223.64.4])
        by smtp.gmail.com with ESMTPSA id p13sm6632293eds.38.2021.12.13.09.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 09:36:57 -0800 (PST)
From:   Razvan Heghedus <heghedus.razvan@gmail.com>
Cc:     heghedus.razvan@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        Wei Ming Chen <jj251510319013@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: core: Export usb_device_match_id
Date:   Mon, 13 Dec 2021 19:35:18 +0200
Message-Id: <20211213173520.4387-2-heghedus.razvan@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211213173520.4387-1-heghedus.razvan@gmail.com>
References: <20211213173520.4387-1-heghedus.razvan@gmail.com>
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

