Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4D8561BFA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 15:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235598AbiF3NuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 09:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235456AbiF3NtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 09:49:11 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1618D340F0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 06:48:44 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id pk21so39185021ejb.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 06:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=REFGbYhE8dpEN5VkA7iNJtkkSRmeBAdrouvG3pc5rZ4=;
        b=rBpQMx9t2a7Q0FsOr1iUlU/2OoulDaYtNFW1OUkMnwtHNTf7jSX26b3IxPRpK60K5Y
         2hKXbGfNqCD37LLY5CnywjL8XDAAETYEt0HFlXfX4gfFjcg5PAAEruGnI97cYzDYhIHM
         n2HTSi8TaetQHcCrgH9rvA+8ake3xJszCfdCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=REFGbYhE8dpEN5VkA7iNJtkkSRmeBAdrouvG3pc5rZ4=;
        b=3Qj8KW6PAHUoAsCf2PGZtIIFBq7YB5DFAgr8KwrjIfi7nxlYNtiS3tKCVQxT4ERSo5
         PsuwsrMrKYwtOyS9mn6mXhzvhynZeqaPrza9XzijqNDV2qsmK45TH135Vo3wu304V0zL
         jTubg7Sl1U8WsPpOZ3B+BVmO2L7JBoUrJpkIyMPxGdLuO0CBaHh0jLW5XewZVH0QsWiu
         NwTRtlhL/W+YUw37vE9rIy2O5lsFmDhJC8O5KafAhyLj+XkHIyD9fYH2F0Qy2yytZ2f0
         uky7m2wLeI7WHJn4k7YeoF/j4GEeGW50Ka6K+TG2V8Y6AAlTESihuObjsMZpwlmw+Z7L
         BJPA==
X-Gm-Message-State: AJIora+XiRProMf9mIn862vQDx2cTkcejDDbkBaTfg/a9UaXwOmlX+6h
        rK+OrQF364KN1TDf2iwxSRFGHg==
X-Google-Smtp-Source: AGRyM1tGnzRXAdLJuMxqaj73mOg0FEdM9ZjdA9yVSlhCEgCOSyHf44ALTuvyynaborcTpEeBGUtK4Q==
X-Received: by 2002:a17:907:6d20:b0:728:46e4:dac6 with SMTP id sa32-20020a1709076d2000b0072846e4dac6mr8878018ejc.280.1656596922605;
        Thu, 30 Jun 2022 06:48:42 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i.station (net-188-217-58-216.cust.vodafonedsl.it. [188.217.58.216])
        by smtp.gmail.com with ESMTPSA id k5-20020a1709067ac500b006fee526ed72sm9130288ejo.217.2022.06.30.06.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 06:48:42 -0700 (PDT)
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     tommaso.merciai@amarulasolutions.com
Cc:     linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        quentin.schulz@theobroma-systems.com,
        Jacopo Mondi <jacopo@jmondi.org>,
        Daniel Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/6] media: ov5693: add dvdd into ov5693_supply_names array
Date:   Thu, 30 Jun 2022 15:48:31 +0200
Message-Id: <20220630134835.592521-3-tommaso.merciai@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630134835.592521-1-tommaso.merciai@amarulasolutions.com>
References: <20220630134835.592521-1-tommaso.merciai@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
Reviewed-by: Daniel Scally <djrscally@gmail.com>
---
Changes since v3:
 - Add reviewed-by tag, suggested by Jacopo, Krzysztof

Changes since v4:
 - Add Daniel reviewed-by tag

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

