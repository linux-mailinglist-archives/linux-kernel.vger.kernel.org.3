Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDBA59A613
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 21:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351159AbiHSTIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 15:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351114AbiHSTIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 15:08:30 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E414A48C80
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 12:08:28 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id y127so2138861pfy.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 12:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=NY3og6uVOGIRfydWAoiK8DTzipQrxXXqtzrWPkrx8rE=;
        b=VJQxFgKABXidqeK6PcYka/SLJnrMhsN5piLG5aBGrmKOX55QepEObQ88MWMkZXJH0H
         MiYLtWEBXs8MGcNVMdwZMFOJBshSIXYwtMBZzDrFt9ptpY6CdufVoVXJu16TZ0tajZkv
         YxXPq9YarjoNbmyvcRjmrlu7hctfeeWFP38yY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=NY3og6uVOGIRfydWAoiK8DTzipQrxXXqtzrWPkrx8rE=;
        b=TFkIhEj++Mhbl6cVY8o/BtpMhpwBNOedrwEyJB7LiSTlErXlLIDb8Jgm8kt0PcrBl9
         iFbQoHH/h+9JlpL//X0thEwZmXdS9e9wT/Rq0lDAqynWTPzpp6H3fRpekzpvW2CQ8ZfP
         xnbchgMv3KOpY0IdBYL/6+wB0/t5BaLqewUNbbUZi+vMovJGNMO7VAOvYDWJZOHhKA3o
         dq+N/d2ogUDPrMdU453pYZuxK3dw6gD8iVnsf++8Tx44WxHBmAQ0JYDJQjM08MDGn1vx
         37M76NcIg/yet2KnOGDqGowoSd5EQoDMPl4SlB5X/6NMXQvpeeyjw5/q9iRGKX/g+dcX
         HTrQ==
X-Gm-Message-State: ACgBeo38yPdLTX+h94qBZPLT+17L0edSvib3MxacoD6qsN/9QJeDNvNU
        M/ySamLtauYlHh89E8HkGXg+oThUMp4Xew==
X-Google-Smtp-Source: AA6agR4hHW67M1U75F44AWEu1mn0JI3XHNB4+7SKR0ssNvQHD9p15ZaaWOD10jBLMG5e8LtgM67xsg==
X-Received: by 2002:a63:6b02:0:b0:422:7cf8:4bf with SMTP id g2-20020a636b02000000b004227cf804bfmr7501437pgc.92.1660936108315;
        Fri, 19 Aug 2022 12:08:28 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id b14-20020a170903228e00b00172a567d910sm3499775plh.289.2022.08.19.12.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 12:08:28 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Cc:     bleung@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 2/4] platform/chrome: cros_ec_typec: Correct alt mode index
Date:   Fri, 19 Aug 2022 19:08:03 +0000
Message-Id: <20220819190807.1275937-3-pmalani@chromium.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
In-Reply-To: <20220819190807.1275937-1-pmalani@chromium.org>
References: <20220819190807.1275937-1-pmalani@chromium.org>
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

Alt mode indices used by USB PD (Power Delivery) start with 1, not 0.

Update the alt mdoe registration code to factor this in to the alt mode
descriptor.

Fixes: de0f49487db3 ("platform/chrome: cros_ec_typec: Register partner altmodes")
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 4d81d8d45b73..dc5722db2066 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -698,7 +698,7 @@ static int cros_typec_register_altmodes(struct cros_typec_data *typec, int port_
 		for (j = 0; j < sop_disc->svids[i].mode_count; j++) {
 			memset(&desc, 0, sizeof(desc));
 			desc.svid = sop_disc->svids[i].svid;
-			desc.mode = j;
+			desc.mode = j + 1;
 			desc.vdo = sop_disc->svids[i].mode_vdo[j];
 
 			if (is_partner)
-- 
2.37.1.595.g718a3a8f04-goog

