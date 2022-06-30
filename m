Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6145856137B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 09:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbiF3Hpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 03:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbiF3Hpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 03:45:34 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B5E3B298
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 00:45:33 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id o9so25365506edt.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 00:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VNYYioEE6eRAWTo799NfZ03VtyHU0+m847tUVl43Yck=;
        b=YLjiXgvt9WepSmT9ZWnR5NUIPpyCbwSk9tCnGGCA2MfRQJ/JQiQv3MrwkZKcd/ANyt
         95Z1mmWkFJRAhnXMGxLr6usLtWiqEogLMVG0Gh96jm1DsCvDisP9v1JOYJGkUo0qCeW6
         skVfivMIR2LzuOFje+9s9oRNrsyjTks2W1Guo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VNYYioEE6eRAWTo799NfZ03VtyHU0+m847tUVl43Yck=;
        b=QcdN5p1+3T2cYtBD4MZhU2D7lWDx24kIpL9tFcNKsqSLpOFkcT/3m3lWKgMAF6Y4X0
         erLfQ9NTsu/aZ6Mzh8E5KPNkeslKR58gBMDDJ4JHUkWrFGMo0m/+0hPdvrq5QxGWRysI
         pZc/NEZ47P17XBi3ETw+p8bE95SsDugT/NeVLI/KnfaSEG+oh1O8L0Su4/I0O2WNvUmy
         M2JSdl3RCELu8mphYNDAx9MuSRGvkrFqNV0reICJZOytIzCBmQq7LLvlPYSQ4ZURNtWN
         BLkUjbQtE2J5m1XbZ/I1EXIuLjoB9Vce3jNhWmJZLZzS2qSdDSyIfbjRhwQxq7gUA76H
         Tqag==
X-Gm-Message-State: AJIora9IrO7OksBDMnvN1Nsla+ZLuGo9RX1vpsRPK7VrmnBufjLmCm8t
        6tNNoajGutvDZsSLRUx4kfTpoA==
X-Google-Smtp-Source: AGRyM1sFj8MoQk6ICrYzIG/7k4fYwLARHuMRDZqT7YjTSOwCdeamIUesx/jFGg0+IMSxYVgWyznfWg==
X-Received: by 2002:a05:6402:4408:b0:435:9ed2:9be with SMTP id y8-20020a056402440800b004359ed209bemr9590051eda.81.1656575131548;
        Thu, 30 Jun 2022 00:45:31 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i.station (net-188-217-58-216.cust.vodafonedsl.it. [188.217.58.216])
        by smtp.gmail.com with ESMTPSA id b13-20020aa7c90d000000b0043564320274sm12594731edt.19.2022.06.30.00.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 00:45:31 -0700 (PDT)
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     tommaso.merciai@amarulasolutions.com
Cc:     linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        quentin.schulz@theobroma-systems.com,
        Jacopo Mondi <jacopo@jmondi.org>,
        Daniel Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/6] media: ov5693: add dvdd into ov5693_supply_names array
Date:   Thu, 30 Jun 2022 09:45:21 +0200
Message-Id: <20220630074525.481790-3-tommaso.merciai@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630074525.481790-1-tommaso.merciai@amarulasolutions.com>
References: <20220630074525.481790-1-tommaso.merciai@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing "dvdd" (Digital circuit power) entry into ov5693_supply_names
array

Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
---
Changes since v3:
 - Add reviewed-by tag, suggested by Jacopo, Krzysztof

 drivers/media/i2c/ov5693.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/i2c/ov5693.c b/drivers/media/i2c/ov5693.c
index f410333c4c67..9e84468d920e 100644
--- a/drivers/media/i2c/ov5693.c
+++ b/drivers/media/i2c/ov5693.c
@@ -132,6 +132,7 @@
 static const char * const ov5693_supply_names[] = {
 	"avdd",		/* Analog power */
 	"dovdd",	/* Digital I/O power */
+	"dvdd",		/* Digital circuit power */
 };
 
 #define OV5693_NUM_SUPPLIES	ARRAY_SIZE(ov5693_supply_names)
-- 
2.25.1

