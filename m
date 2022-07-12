Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9823572109
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 18:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbiGLQeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 12:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234305AbiGLQeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 12:34:13 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A8813DC8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 09:34:11 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id a5so11933758wrx.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 09:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=REFGbYhE8dpEN5VkA7iNJtkkSRmeBAdrouvG3pc5rZ4=;
        b=AxwI3KThp/gT6ngSzdupUmlraPHHgO88D2ulxyRcgCNqTmHr9gW4EWQr3W5eatuZVQ
         wgXycyev3I6QJnrmslnno/F4DZTvXvNYDrBFiTLTpeyyl5p4OgWLL8/473drofkqxhSF
         jCZpM6MIsRpmFcToL/ZfyQ3aTqWJRBIFUJGfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=REFGbYhE8dpEN5VkA7iNJtkkSRmeBAdrouvG3pc5rZ4=;
        b=HEj/c/V4LMx+VVNj5iezB9XJF8c56jV2E80SZAQ7NcaQtYZl1lpBSBCjTLKFJCOEWN
         Cv5KT1MRIeAuh1glIKbt1zMeB039NX5xPDIfoo6Dxl6s0wlD1+VrUPJoFE2nUNiv9Jme
         qtKhAATF3dGuQ8bT3Oz+v6R0lmwTNoMJVKiMewdESQIyq06QydBRlGKBfnnfXeZazFgk
         lvbS5fOCHdk/W02mnyGSJjvx6FrTsiaG8IqQX767tzTlUsHOJtT2rzVKzM+mEy06+Jer
         8u7ZlQsX6o20DGOeGHVvcND43y9hL6fO8WVWecpqnlpjg9sZ254nK9BTOfGh5Z2SmQiI
         7HnQ==
X-Gm-Message-State: AJIora87GngA/vLYHrI3+NSLfljV06QQ/XaY44dSkv5kINzJPBQ8WxZe
        M0G4jmupaZ4FUIJh8wq/DN7QEg==
X-Google-Smtp-Source: AGRyM1vHPboZMisVMS1fT8WrToIQiqBcYZqcf07kkb5lOnlgAdFIQv2fOKox/6JGcVDSSMmUVfvigA==
X-Received: by 2002:a05:6000:2a4:b0:21d:8646:37f6 with SMTP id l4-20020a05600002a400b0021d864637f6mr22059252wry.661.1657643649501;
        Tue, 12 Jul 2022 09:34:09 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i.station (net-188-217-53-214.cust.vodafonedsl.it. [188.217.53.214])
        by smtp.gmail.com with ESMTPSA id j16-20020a5d6050000000b0021db2dcd0aasm2321052wrt.108.2022.07.12.09.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 09:34:09 -0700 (PDT)
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     tommaso.merciai@amarulasolutions.com
Cc:     linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        quentin.schulz@theobroma-systems.com,
        Jacopo Mondi <jacopo@jmondi.org>,
        Daniel Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/6] media: ov5693: add dvdd into ov5693_supply_names array
Date:   Tue, 12 Jul 2022 18:33:45 +0200
Message-Id: <20220712163349.1308540-3-tommaso.merciai@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220712163349.1308540-1-tommaso.merciai@amarulasolutions.com>
References: <20220712163349.1308540-1-tommaso.merciai@amarulasolutions.com>
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

