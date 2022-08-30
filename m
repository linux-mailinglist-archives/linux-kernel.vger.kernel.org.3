Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0665A713A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 00:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbiH3W6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 18:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbiH3W6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 18:58:37 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0017D7BB
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 15:58:36 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id o4so12504311pjp.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 15:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=WK5uBdkvj+rzMOTx0eBPWRcJ3NkDpCrdfS9GYKxjc4Q=;
        b=K/Dv61fWG2RK5uP019ajuvWGOsaYy/JwPd+i+ycqaCclO2jktpeGBCOdGEJwue7Svf
         LFuue3Jw2/IhLPZzIDc+oSEoPyjT7Vv75KikMIlx3sZGkKcI1jfYCdnz+tXgxvZaTRUz
         mdDnW/OVw+tIn2VPx14agQ4ltazeNCRbuECis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=WK5uBdkvj+rzMOTx0eBPWRcJ3NkDpCrdfS9GYKxjc4Q=;
        b=3P39/wlrHxuBZtGt8JhWnfqTo5pgdeJLu/DmBX1pJcv0PoOAIgTp+d68HsPfqTTZFU
         BlpIPeEygpdLZBGoFKJl0cLuuWtXpikCzHRrTrlmKZsW+T0EdMUW19YdLJCrlj8Jiu7m
         Af0uaZV3YNAPSFWIhqmzw6fLY32IsAwYr4aFO+qvnbxIOGRk5zmNKFUbbQyjEbEpuI13
         0Xvv/sWIrpfUVwcseg9M7VWcFs89o+FlxFxEFfoxbk/+47/Wj/8TtgIIkysqiVGxRmML
         u5rThHqiJn5MlNZaClkREP4xWl3jXO0k3SCOPoXH0ifCYVgvuHVanAJFlRbqi/M6sCim
         KJpQ==
X-Gm-Message-State: ACgBeo1iY3xfMonAjTgyJOc2UtJN/x1ZWsxeq6hqgYM+EFPW7oepjDij
        +GUTpjldn14n3D9wTPtypLrizQ==
X-Google-Smtp-Source: AA6agR5BwgwGGR8CVgQETFRT37ajSM4Zq99RJV+txl3EQeraAhpPRS7nmypBzKJjaJBmUzqCHE10CA==
X-Received: by 2002:a17:902:8f87:b0:172:83b5:d771 with SMTP id z7-20020a1709028f8700b0017283b5d771mr23053534plo.159.1661900316268;
        Tue, 30 Aug 2022 15:58:36 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:5f34:2f6:2856:188e])
        by smtp.gmail.com with ESMTPSA id bf3-20020a170902b90300b001743be790b4sm10083539plb.215.2022.08.30.15.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 15:58:35 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        chrome-platform@lists.linux.dev, Tzung-Bi Shih <tzungbi@kernel.org>
Subject: [PATCH 3/4] platform/chrome: cros_typec_switch: Use PTR_ERR_OR_ZERO() to simplify
Date:   Tue, 30 Aug 2022 15:58:30 -0700
Message-Id: <20220830225831.2362403-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
In-Reply-To: <20220830225831.2362403-1-swboyd@chromium.org>
References: <20220830225831.2362403-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the standard error pointer macro to shorten the code and simplify.

Cc: Prashant Malani <pmalani@chromium.org>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/platform/chrome/cros_typec_switch.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/chrome/cros_typec_switch.c b/drivers/platform/chrome/cros_typec_switch.c
index 3381d842c307..09ad0d268f4b 100644
--- a/drivers/platform/chrome/cros_typec_switch.c
+++ b/drivers/platform/chrome/cros_typec_switch.c
@@ -185,10 +185,8 @@ static int cros_typec_register_mode_switch(struct cros_typec_port *port,
 	};
 
 	port->mode_switch = typec_mux_register(port->sdata->dev, &mode_switch_desc);
-	if (IS_ERR(port->mode_switch))
-		return PTR_ERR(port->mode_switch);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(port->mode_switch);
 }
 
 static int cros_typec_register_retimer(struct cros_typec_port *port, struct fwnode_handle *fwnode)
@@ -201,10 +199,8 @@ static int cros_typec_register_retimer(struct cros_typec_port *port, struct fwno
 	};
 
 	port->retimer = typec_retimer_register(port->sdata->dev, &retimer_desc);
-	if (IS_ERR(port->retimer))
-		return PTR_ERR(port->retimer);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(port->retimer);
 }
 
 static int cros_typec_register_switches(struct cros_typec_switch_data *sdata)
-- 
https://chromeos.dev

