Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7274875AA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 11:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346825AbiAGKgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 05:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346758AbiAGKge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 05:36:34 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F0CC0611FD
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 02:36:34 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id a18so19432696edj.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 02:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xitO4xjFIv/zgFCqMdAhAS+m13rXCyic7Tt7PUde2/Q=;
        b=crItaRL2o606eFxIa6GQ6T4UBho6x/bvAICK5sfH5+O+uV9znymQMOjJ/3IoePhmHC
         G6QRtwXB2NCxYscflVJV3PNRZaSMBc5haRrdPnNJOYO3T+60y1T/idrlimhyoh/GeNVq
         HuNtYrQsCRU+s4U52FT/3t7IHMSbCJpIAOpSuEeNH11Cpne8AV1PFPmKOpBgxdy8tVEL
         HYOLx+kzdQHkGVsLVtR/BOS6pziMP4356R7LPWS97XeyScA9nLXLCWy0pmKq9Q9H/+o1
         vZjB0/ZNkajXJ/hX95TwKrKbkt20J2yQceFkFO9we/ln9Ky+RIvS2suVxcj7VvPOGanY
         TrdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xitO4xjFIv/zgFCqMdAhAS+m13rXCyic7Tt7PUde2/Q=;
        b=LiSaryChV+0kyW2bwhHBFeJEhL5Og/WC3q6bDnJtlI9Nu99o/tp7jfS0OTEO2EYewP
         yQFsAEetSFHOcfLYaG2oPGuYvZihKv31h4zQ6vG+69MW2/T7MzwZNweI7G76BfAH1of5
         bXwrmjISO41D3+lx/6r/LeMRCD/dozKXreFESEUQphbEJ87DQh7wdJ5pnfu22IPdb9Yd
         GKD0qkZBFkutKfF44/Sq3Tmz1DE8F9ZmKY07WmDGFrUKr88piZHrDweU7Sk9UhujXVbU
         d6/IboDLQsEwWSNCbtVBe/v2eoDAHXzRkE6WEI5IAxIwkGShiBhZLTp+jmZmxLxU3Y0Z
         8kfg==
X-Gm-Message-State: AOAM531CmHV16gWaXRrO5qW7AYG5aOqZ+ehmnUc8IpHTE2/R3iXsuD66
        BcUpi1uzeAi4Zy4XYI4CnFE=
X-Google-Smtp-Source: ABdhPJzstqK4gR59GtrXhCyRcl1bD9SbX/CSDn9IXU6/+QR0GpY++RI35dmLmRBJ6kEGmoC0djTbTw==
X-Received: by 2002:aa7:c7cf:: with SMTP id o15mr61624625eds.176.1641551792646;
        Fri, 07 Jan 2022 02:36:32 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::51e2])
        by smtp.gmail.com with ESMTPSA id v8sm1869857edt.10.2022.01.07.02.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 02:36:32 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 06/19] staging: r8188eu: convert type of return variable in load_firmware()
Date:   Fri,  7 Jan 2022 11:36:07 +0100
Message-Id: <20220107103620.15648-7-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107103620.15648-1-straube.linux@gmail.com>
References: <20220107103620.15648-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return type of load_firmware() is int. Change the type of the
return variable from s32 to int to match the function return type.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index edb56a9ae283..bd7f3dc5878b 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -510,7 +510,7 @@ static s32 _FWFreeToGo(struct adapter *padapter)
 
 static int load_firmware(struct rt_firmware *pFirmware, struct device *device)
 {
-	s32 ret = _SUCCESS;
+	int ret = _SUCCESS;
 	const struct firmware *fw;
 	const char *fw_name = "rtlwifi/rtl8188eufw.bin";
 	int err = request_firmware(&fw, fw_name, device);
-- 
2.34.1

