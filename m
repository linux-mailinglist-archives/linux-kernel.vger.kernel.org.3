Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D494F8819
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 21:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbiDGTbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 15:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbiDGTav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 15:30:51 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB37629AE28
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 12:28:35 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id i27so12928501ejd.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 12:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TqnfFy/w5L8PNXWjZ8pBP5o6bpYqg195r5wJAqZzJso=;
        b=S0kjE+2qCuvEZ1CmUheOO7iZmHfj9QkPQUdmiTDhrKhsIXps+vyYg4r0AoAGJInCxi
         T5A1u37Etw4Vhc43pIa+rxhlK+cQ+qSl0jyDRPgVFYFkKSIg6aUtmfrT7kUZrSlu1Hvx
         tmRvmFG8KC0IrrhOpsK/6u4UeFIKMatBbftbDOvjZilcwLdL1TR207Syk1W4HfrQt7Sm
         WgnyQNilrGwsrX9f3pb81FPjl/jdrWpAtsrTkMfYL7ue9a/2YHdYVPfbpgzMjq8mePx4
         bg42CDN7Acs+axwkiSy4Ni5/4DyOy1SYs60CGaAznvrSUUThTg4crKZjScdSGEqnYQrv
         UwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TqnfFy/w5L8PNXWjZ8pBP5o6bpYqg195r5wJAqZzJso=;
        b=reYz9Ef9RUIMAr5sYN1ZnC/TBXgNYJoQP/hnIkSQRXJCAhDZHvfLz3jp+ffFU73ALN
         vBEuYqlMx/qst8Dh3SUblx3MM9ltj7zfQvT1lrj7XcNpmfqt59wsgv1cVLcusnCafwB8
         ZZry5CZVJoMBDBRmkSrkpfBrMN7OsDJBSpDds7rtQScPp2HJInY9icJX2WdP6an2mWVe
         1cys8IeHSoBGZy44qHxzwT6DtrMjQrKPwa3akEfkT1hLUNIOJngKwZ2JbqAHPzNINrQF
         gV0CQBCz1Myioh9AP7Tq0DKhvtO442kz/8hnQ+itf69tZL09HydH6966PWo99pAabPy2
         Hauw==
X-Gm-Message-State: AOAM532J812i5O41eZ77iG//Q9hKgHU3QyuTu6x46TFcTS+SnLdU0ZOM
        NACQqdwawK05HIYawkXRbDg=
X-Google-Smtp-Source: ABdhPJyJpZX0eq9WO/d5bSjQFmCX1ob68cON0CQmf4s3b3e0ce4GcXHLW2Gh1FUHL/wxwhKB6176CQ==
X-Received: by 2002:a17:906:2bd7:b0:6cd:f89d:c828 with SMTP id n23-20020a1709062bd700b006cdf89dc828mr15003377ejg.232.1649359704644;
        Thu, 07 Apr 2022 12:28:24 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id k14-20020a50e18e000000b0041b6f23f7f6sm9652798edl.22.2022.04.07.12.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 12:28:24 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/8] staging: r8188eu: move struct rt_firmware to rtw_fw.h
Date:   Thu,  7 Apr 2022 21:28:13 +0200
Message-Id: <20220407192819.10661-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407192819.10661-1-straube.linux@gmail.com>
References: <20220407192819.10661-1-straube.linux@gmail.com>
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

Move the rt_firmware structure to the header rtw_fw.h to have firmware
related things in one place.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/drv_types.h | 6 +-----
 drivers/staging/r8188eu/include/rtw_fw.h    | 5 +++++
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/include/drv_types.h b/drivers/staging/r8188eu/include/drv_types.h
index 09fc27082f7c..ffab2ee0848a 100644
--- a/drivers/staging/r8188eu/include/drv_types.h
+++ b/drivers/staging/r8188eu/include/drv_types.h
@@ -35,6 +35,7 @@
 #include "rtw_ap.h"
 #include "rtw_br_ext.h"
 #include "rtl8188e_hal.h"
+#include "rtw_fw.h"
 
 #define DRIVERVERSION	"v4.1.4_6773.20130222"
 
@@ -116,11 +117,6 @@ struct registry_priv {
 
 #define MAX_CONTINUAL_URB_ERR		4
 
-struct rt_firmware {
-	u8 *data;
-	u32 size;
-};
-
 struct dvobj_priv {
 	struct adapter *if1;
 
diff --git a/drivers/staging/r8188eu/include/rtw_fw.h b/drivers/staging/r8188eu/include/rtw_fw.h
index c4b1a8370b4a..8f74157ee9ac 100644
--- a/drivers/staging/r8188eu/include/rtw_fw.h
+++ b/drivers/staging/r8188eu/include/rtw_fw.h
@@ -4,6 +4,11 @@
 #ifndef __RTW_FW_H__
 #define __RTW_FW_H__
 
+struct rt_firmware {
+	u8 *data;
+	u32 size;
+};
+
 #include "drv_types.h"
 
 int rtl8188e_firmware_download(struct adapter *padapter);
-- 
2.35.1

