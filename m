Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561CB507F69
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 05:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240024AbiDTDJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 23:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234346AbiDTDJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 23:09:50 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E459A2603
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 20:07:05 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id a186so350602qkc.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 20:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LM+R8F9f5IgEgs7eRlVM40Gk0INro2H615+Nbx4F7ZA=;
        b=AM0cmwEFMxtoHtYuPdZJHmPizAC3xPDy9MhGdcWzUknn/k1IAH1/CkfCBrwmMqMGU5
         Op9Zhr4loojsszKqfNWt4bDt3iTTGaKM9D9Cr/7M2u7KnTsX8LzACQsmUl5kwnPAjETn
         DiqvoCu7uatWoMKscC6RcE/9094nyKbknbu5JyhdzOzDRryDv/kp0+cX7okT0Cp1QG6W
         FV2ustpw+3X670x2N3ZHxaqNt5t2Go2E/jRIVSRzVzBZGkCfG36EpZSyw01CsvDPpBQA
         sX/XNqDnoqf+9TtrBud0Z3rClxNnCiFO7Geis+W3mixcT3rprV5sdMYqRjjeaaYuxFvD
         HJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LM+R8F9f5IgEgs7eRlVM40Gk0INro2H615+Nbx4F7ZA=;
        b=d+HMK3QD6toDYdCdICUBasZvyuzLfVYz4/b++7XC7oolpUmmaAJGOqPhyBvOI9Cex/
         JcHnV0ShoqHR6m2L8WlgGOP1t6JLZ5mNtqyuIQHz3KQiX+VW6M9iU4d/TC1JzNYWALrG
         8q0O3PB5dKXIPBYgNGzPqwSjJ3f4BDEOYobgiJzJDBPt4ZeDbT0vuNvCB/z97DufA844
         H0eiS+EgIiCTMnIpqusOb4kh3qThVi+d9r/rzvq4tE/Y42m933t2xYAETRlUCPhAfIMn
         KjsyRB4u4SY7bdRt4tSxAhdh9/Cm1ppMylU+zuCaBiDUPHzX49JotnnvVLd4wvC2Zuj5
         jYeQ==
X-Gm-Message-State: AOAM5309jFvmzKBE7rbs9NX0bz2iD7yjlIi5PgA6ngtsR8sCMoe/gkpp
        0e+hLa/PA5xJCKxBwUbckwY=
X-Google-Smtp-Source: ABdhPJzjCuHLUi3jZowxZwNoFfPIn/5TAOu8OYoPIQjIC007jckvE0naRuD1/7B5aS0+InQCz5/Q4w==
X-Received: by 2002:a37:b984:0:b0:67f:64a2:313e with SMTP id j126-20020a37b984000000b0067f64a2313emr11220711qkf.3.1650424025131;
        Tue, 19 Apr 2022 20:07:05 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id u13-20020a05622a010d00b002f0c6664db1sm1020726qtw.49.2022.04.19.20.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 20:07:04 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     johan@kernel.org
Cc:     elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] greybus: using pm_runtime_resume_and_get to simplify the code
Date:   Wed, 20 Apr 2022 03:06:58 +0000
Message-Id: <20220420030658.2575942-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Using pm_runtime_resume_and_get() to replace pm_runtime_get_sync and
pm_runtime_put_noidle. This change is just to simplify the code, no
actual functional changes.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/greybus/core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/greybus/core.c b/drivers/greybus/core.c
index e546c6431877..434aa5d9dd47 100644
--- a/drivers/greybus/core.c
+++ b/drivers/greybus/core.c
@@ -174,11 +174,9 @@ static int greybus_probe(struct device *dev)
 	if (!id)
 		return -ENODEV;
 
-	retval = pm_runtime_get_sync(&bundle->intf->dev);
-	if (retval < 0) {
-		pm_runtime_put_noidle(&bundle->intf->dev);
+	retval = pm_runtime_resume_and_get(&bundle->intf->dev);
+	if (retval < 0)
 		return retval;
-	}
 
 	retval = gb_control_bundle_activate(bundle->intf->control, bundle->id);
 	if (retval) {
-- 
2.25.1


