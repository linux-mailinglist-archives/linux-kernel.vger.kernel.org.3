Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBB052D82F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 17:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241612AbiESPmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 11:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241272AbiESPlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:41:24 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C7215824
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 08:41:21 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id eg11so7443565edb.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 08:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WTUmXa/64n3GmqLH4t1zWSye8BWFqtPRackPhQ7O1Mc=;
        b=VBMGp6SVXaYYTIvTJUKNAo4dMzncK/sXtWR7zTwwI5Q+HXg3MZ8wUe4WmWpe4YbmlD
         AyJtYCkYNTFoE0SGz2LHCxEiVpN8XyoZrJLnMhkcDsUY0gyvL74gavd+Y68wmNU38cbh
         csz28gGPl/L0gVN8WnAda5weYezXGV2+j1Xjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WTUmXa/64n3GmqLH4t1zWSye8BWFqtPRackPhQ7O1Mc=;
        b=ekR0E1Vl0CazmgqAoN0zqQO+CsEv7ikZgd77ZnIUIrmIU6b2hlCPd0wWs9CA54iJlj
         s1m81LAjINlAFUZqrcO0XXUvIOjiuF5bdgjtUVrEm85gcL3uVq68MHF7FoFX7FHtYjLF
         +0HHUeDYVF7CkI7mfJCMPy9UVSHaiHOSB1pmVBAoYesWoPVaQ+dLefiFtkT9Fjgwjdqs
         c7Uxo7Iac71JEMl4196PZy9vMSBFw0tEVd6HqDCNAn9c0HlJTJwU3OgZdLgkcoNFZCGz
         7Gkpb7irVK2U22iaVP1iCGm4VjO0ZwWhGQWFQ+30A127shndX3421gmpCaK1M8CTrtqI
         9Qog==
X-Gm-Message-State: AOAM533o7sQd7vo6cwWdbWJFq/7DQgbq7SgQ4OYRnxK8wCKBhFBWq/nM
        A36NkyWMUNAx1m6yvA0hN2qDYw==
X-Google-Smtp-Source: ABdhPJwtcZFVm9eQrNgwy/WsrvMl+Wwfo9Bv7rvR756MF5Qp0e0McQcNdMF4Nw4haFAx6Z4I86ZZVg==
X-Received: by 2002:a05:6402:4414:b0:419:28bc:55dc with SMTP id y20-20020a056402441400b0041928bc55dcmr6138706eda.130.1652974879697;
        Thu, 19 May 2022 08:41:19 -0700 (PDT)
Received: from alco.corp.google.com ([100.104.168.197])
        by smtp.gmail.com with ESMTPSA id k24-20020a056402049800b0042aae307407sm2990092edv.21.2022.05.19.08.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 08:41:19 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomasz Figa <tfiga@chromium.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Yunke Cao <yunkec@google.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 1/4] media: uvcvideo: Add missing value for power_line_frequency
Date:   Thu, 19 May 2022 17:40:56 +0200
Message-Id: <20220519154100.333091-2-ribalda@chromium.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
In-Reply-To: <20220519154100.333091-1-ribalda@chromium.org>
References: <20220519154100.333091-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UVC 1.5 class defines 4 values for this control on:
4.2.2.3.6 Power Line Frequency Control

Add the missing value.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index b4f6edf968bc..13cad4aa7573 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -366,6 +366,7 @@ static const struct uvc_menu_info power_line_frequency_controls[] = {
 	{ 0, "Disabled" },
 	{ 1, "50 Hz" },
 	{ 2, "60 Hz" },
+	{ 3, "Auto" },
 };
 
 static const struct uvc_menu_info exposure_auto_controls[] = {
-- 
2.36.1.124.g0e6072fb45-goog

