Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0717050DB95
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 10:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiDYIuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 04:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbiDYIuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:50:39 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669898BE1D;
        Mon, 25 Apr 2022 01:47:32 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id ay11so9832596qtb.4;
        Mon, 25 Apr 2022 01:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cfi2DfsNBfOqYWS0WCIY5y0dPTfSuxSkjNj7oMojevU=;
        b=qlwLQXMpULHF9yQgY0567DZVhOWPvw9UizzZ4vKxCNBqyYPXZikTwElxLPmm/z5xow
         7FduAZ2bkbRFsfIv2pEZT0HAZqbrevPRRMfIyLGmokp2s8sVFOocynTgAdTW6+q51hTw
         MCA87jYpkYc05yDfmjpO3yIc+fhUKfNNwCODSXqsyBu16x5FoqGE7eXNmAi7yijNGT+p
         /jAUZLn0lqt5x2xTuPDHVA0stZ1rerY0Nr1cRcGSXq+7FiwpCik14jjLvIPa/M2z0bC/
         JRhA+dxWxHzxOj3BR/G30HWOlgpxk4koBQpEFhgvAYwCC8eYEHCu9BdC7mj6idgG5Z83
         Ui/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cfi2DfsNBfOqYWS0WCIY5y0dPTfSuxSkjNj7oMojevU=;
        b=Vp4oerA3rJRazYU9WMCg95yPVeTrgiGMzOy6KFojqxkkFrENeccqzecZ2ZSPmSB/54
         X4g5bKr3yQQpK/oO98b4DxoepTlMHSiVdi9kmp8mCXOS/9RVZPYPYwGFJmLnMz8Ck4iG
         R9jt2qQe3QqVkZPo0i4OXoJycojkrgUvzryLvgVT6PeUa2BwYnW9NADX80FLKHUURDO+
         Mo4a6J20sT0PQF54xQHDIvdqqgxrCc6a3S2bvyuiImJSbHSvQTjdgk0D27i3ebT1PLR8
         izUd5vNJXGJaAAqzMu+iLWDBSvfcD5nRCnvAxh1lGMxZo7T7yLztBk6fx8dfHv9qPUZJ
         p4pQ==
X-Gm-Message-State: AOAM530KK2a7i0ixKhuzoT4Zgzj0CpHLIvYhwtsrEzcpCmE/EE/OO5HN
        52CfVI+PvgyF8RShZrTpJ5Y=
X-Google-Smtp-Source: ABdhPJyG7+E1LhB90Tk9cRLtz6MOxaSYSUEcsCec5XnIgx+gfKirQutnzp6ekkGVjUWBJgAWNBxPrQ==
X-Received: by 2002:a05:622a:5d1:b0:2f3:5e7f:6c6f with SMTP id d17-20020a05622a05d100b002f35e7f6c6fmr8171460qtb.255.1650876451445;
        Mon, 25 Apr 2022 01:47:31 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id l8-20020ac84cc8000000b002f3638c32c7sm3145177qtv.7.2022.04.25.01.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 01:47:31 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] power: supply: remove unnecessary return in switch statement
Date:   Mon, 25 Apr 2022 08:47:23 +0000
Message-Id: <20220425084723.3495323-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Since there's a return immediately after the 'break', there's no need for
this extra 'return'.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/power/supply/bq256xx_charger.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/power/supply/bq256xx_charger.c b/drivers/power/supply/bq256xx_charger.c
index 01ad84fd147c..66d432958c84 100644
--- a/drivers/power/supply/bq256xx_charger.c
+++ b/drivers/power/supply/bq256xx_charger.c
@@ -878,8 +878,6 @@ static int bq256xx_set_charger_property(struct power_supply *psy,
 	switch (prop) {
 	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
 		ret = bq->chip_info->bq256xx_set_iindpm(bq, val->intval);
-		if (ret)
-			return ret;
 		break;
 
 	case POWER_SUPPLY_PROP_STATUS:
@@ -887,32 +885,22 @@ static int bq256xx_set_charger_property(struct power_supply *psy,
 
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
 		ret = bq->chip_info->bq256xx_set_vbatreg(bq, val->intval);
-		if (ret)
-			return ret;
 		break;
 
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
 		ret = bq->chip_info->bq256xx_set_ichg(bq, val->intval);
-		if (ret)
-			return ret;
 		break;
 
 	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
 		ret = bq->chip_info->bq256xx_set_iprechg(bq, val->intval);
-		if (ret)
-			return ret;
 		break;
 
 	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
 		ret = bq->chip_info->bq256xx_set_iterm(bq, val->intval);
-		if (ret)
-			return ret;
 		break;
 
 	case POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT:
 		ret = bq->chip_info->bq256xx_set_vindpm(bq, val->intval);
-		if (ret)
-			return ret;
 		break;
 
 	default:
-- 
2.25.1

