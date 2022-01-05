Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B704852A7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 13:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240191AbiAEMgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 07:36:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240082AbiAEMfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 07:35:34 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDF6C0617A0
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 04:35:03 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id l15so14429621pls.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 04:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=itfac-mrt-ac-lk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iDo5rGiooZ54e0YvK6yFC83j7B4kNsMB4P6R7oVhpes=;
        b=YLYxnLBnAXng8FeUNtZ6JD6R8eNeo/NZHpxcxsKqocfbY0WGTC5BoFN0vVomu0l3Ri
         XrxPzQzdTysGLzN9XD56TbeZgWf+98uC0wSCd+ugGkQd+AFTkWta2fim1RP84P4OsVmu
         NMzmN4Ji4C0w7prkPHCibVQ+6a9XUG0JP1fnG1aJbZ9ejINWGDykIpFM28R+5fDGeulv
         oQ5JgdSvdNS4w6/RMXd3GdIk4YIV3ekCKTNhGXnHaS6fZI5JyEzDZNQv7bD1K5p/8UDO
         xSt0R/bQbhRHojiGYFyD8ezGJef+mqN8slJT2mo8Rsh2ovK9x22oNSn0pu4y/0Nr/zl9
         96Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iDo5rGiooZ54e0YvK6yFC83j7B4kNsMB4P6R7oVhpes=;
        b=3wpAyCxyeLnTK4DyoMQgnoQlrEhJgMh6xJqhTQ9AJt3Bo+aciSILev/DxQTCEI4qQ1
         IwfyPw12ge+t4NQ58CRNdX0lGJscEKDpvEO+VWKnbeZewFnzZP4oTdmwJW0VGXCKLEKF
         vzkLvd3sILpyG4dMJQFADlMVrqlSMDZ36BUaqB8nbVUJLfFy3mQguDK9JvVxfLIzA+Df
         U3kUF2qCoLhQrU9nzS2+JAfATlcrQsOq+aJPpQvvpbmLLLEnkJDIflgQdkcJ5suWltNI
         X4MtWz4VKwq5Q+Ww4O6aqWHURVYxBY+AEhzz9nHsmIQTyw5dubBPHh8VfBGib5y1DRLl
         259A==
X-Gm-Message-State: AOAM532vybMdhLathvPVAK9hMyjhkiO1dk/PLOA3hO6WAVQZPdBuL3te
        CByWvs8rxFvIksdEqLaIJXs5
X-Google-Smtp-Source: ABdhPJzIp6LSUQWMzFLj9p88FP24McTlSAJvX0/+EXcWcO0WS+mA+GQzWVn4Rb+QxKvlPBnNe6w4Tg==
X-Received: by 2002:a17:90b:4c8c:: with SMTP id my12mr3952357pjb.50.1641386103420;
        Wed, 05 Jan 2022 04:35:03 -0800 (PST)
Received: from localhost.localdomain ([112.134.210.219])
        by smtp.gmail.com with ESMTPSA id l11sm12265291pfu.115.2022.01.05.04.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 04:35:03 -0800 (PST)
From:   "F.A.Sulaiman" <asha.16@itfac.mrt.ac.lk>
To:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        marcocesati@gmail.com, dan.carpenter@oracle.com,
        hdegoede@redhat.com
Cc:     "F.A.Sulaiman" <asha.16@itfac.mrt.ac.lk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] rtl8723bs: fix memory leak error
Date:   Wed,  5 Jan 2022 18:04:47 +0530
Message-Id: <20220105123447.24674-1-asha.16@itfac.mrt.ac.lk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210830193355.11338-1-asha.16@itfac.mrt.ac.lk>
References: <20210830193355.11338-1-asha.16@itfac.mrt.ac.lk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch reported memory leak bug in rtl8723b_FirmwareDownload function.
The problem is pFirmware memory is not released in 'release_fw1'.
Instead of redirecting to 'release_fw1', we can turn it into 'exit'
and free the memory.

Signed-off-by: F.A. SULAIMAN <asha.16@itfac.mrt.ac.lk>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index f1fc077ed29c..5f09b3ef9459 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -361,7 +361,7 @@ s32 rtl8723b_FirmwareDownload(struct adapter *padapter, bool  bUsedWoWLANFw)
 		netdev_emerg(padapter->pnetdev,
 			     "Firmware size:%u exceed %u\n",
 			     pFirmware->fw_length, FW_8723B_SIZE);
-		goto release_fw1;
+		goto exit;
 	}
 
 	pFirmwareBuf = pFirmware->fw_buffer_sz;
-- 
2.17.1

