Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F105293BD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 00:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348726AbiEPWqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 18:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240965AbiEPWqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 18:46:45 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E663B54E
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 15:46:43 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id g17so4199530wrb.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 15:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lh2NE58HUp3+dx2zo/APxmvSgiWw0DhpDrtBDl4weqo=;
        b=og5ptlwnfLZjthK1xxE6OxhJo/p8z71qQPUppM7tBZ9x/bQouRP+H57IR+c0+WOuhi
         zM+iD3VbwPIbfQwv1yA834gO6QMrPPqVy9pxiNuwdFyGBIWa0964AHKagmliKtyy/hv/
         xRPZbkfm+op4cDNEBBrjIfNXvIK5nJgyr59As0C5Sa6zAiD2Nu8H744Vs6tzNA1A4e2H
         84LrepSvO8Apv+43F2KEyI5FhiZVnIlw5Hy6jkgDMbuJ3IOZmDe5fK2fblgOEDnFCtBg
         SGAstorLJxDQhRofOwGA3MIgADUA+Wk3r4fcPxY97udkKLzCUJoy49H8jq8mGueHLCBW
         3BmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lh2NE58HUp3+dx2zo/APxmvSgiWw0DhpDrtBDl4weqo=;
        b=oOUjqZk9j4O3XCxiIZMd4dSky3qf5OqIao5kOzTYus1YMQuhLz4cCK8figfF7frL4N
         0rXAHQLNQ2U3PxlNSjrgm9qInS1oyEPQ+cz3AYdbiusY1n7J+p/Y0arloM+K4/5GpTvi
         jE3CoUh9DFuoRHQ+0hdriBcvOlVdDpQmL58aavK5urRhzX0Gjf4aj+6XT3c99Yvmk/Oc
         qfNmzQL5/x1oWx15jBz7yOEu5bESLDi/Z4yyHZB3ADH7msH+kiG9krcWwEeLGOJKs/XP
         cScR0n85peMNWWiTaN1n/TL6BW7W/uo3VuHNPMweByK9EuKToNEj4cLbSPsAcq1oASMS
         DDZw==
X-Gm-Message-State: AOAM532zX5aCROJjYu9r4jKIJ+fKJt+IhDRHHzaEUJEZ0X1vS0GeH+qY
        W8yKy+H2dQHg4tsfmrRtqHstOQ==
X-Google-Smtp-Source: ABdhPJwFUVZ7umGIeVSc9HIFSGGuVIErhKoX55pyukPHyt9eB44vFmeAD96iOfnDjrxMM1WEf4N5lQ==
X-Received: by 2002:adf:ed07:0:b0:20d:e591:4ae8 with SMTP id a7-20020adfed07000000b0020de5914ae8mr530189wro.357.1652741202239;
        Mon, 16 May 2022 15:46:42 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id l27-20020adfa39b000000b0020dcea1be26sm345588wrb.97.2022.05.16.15.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 15:46:41 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, saurav.girepunje@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: r8188eu: remove _drv_ defines from include/rtw_debug.h
Date:   Mon, 16 May 2022 23:46:40 +0100
Message-Id: <20220516224640.90973-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the following defines:
_drv_always_
_drv_emerg_
_drv_alert_
_drv_crit_
_drv_err_
_drv_warning_
_drv_notice_
_drv_info_
_drv_debug_

from include/rtw_debug.h, as they are no longer used anywhere in the
driver, and are unlikely to be ever again with the removal of the old
debugging/logging code.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/include/rtw_debug.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtw_debug.h b/drivers/staging/r8188eu/include/rtw_debug.h
index 01a7d987d6cc..84ec068596e7 100644
--- a/drivers/staging/r8188eu/include/rtw_debug.h
+++ b/drivers/staging/r8188eu/include/rtw_debug.h
@@ -7,16 +7,6 @@
 #include "osdep_service.h"
 #include "drv_types.h"
 
-#define _drv_always_			1
-#define _drv_emerg_			2
-#define _drv_alert_			3
-#define _drv_crit_			4
-#define _drv_err_			5
-#define	_drv_warning_			6
-#define _drv_notice_			7
-#define _drv_info_			8
-#define	_drv_debug_			9
-
 #define _module_rtl871x_xmit_c_		BIT(0)
 #define _module_xmit_osdep_c_		BIT(1)
 #define _module_rtl871x_recv_c_		BIT(2)
-- 
2.35.3

