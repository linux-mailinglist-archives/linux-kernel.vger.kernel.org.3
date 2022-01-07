Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9664875BB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 11:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347112AbiAGKhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 05:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346763AbiAGKgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 05:36:40 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153CCC034000
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 02:36:38 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id o6so20494161edc.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 02:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rhk/RIq8N8redhElMwVU53NrBizqJp1QMtudMdpPmpM=;
        b=ORdZbD1syTbIu6mJjN3S3GMwVeAFXU0NZGz9hArxSzG1ubraJGzzF6CuYhMqDDfKoH
         IO5tZIEOUR96VlbOxJyU0mjUdJJeg5eCb37z9ETmVLSDCaMSy20O434N4bRELigU34U7
         CEFIS/ArPy8/+NhKLDvRuoZmcy70yfYHcF1WjKStC8a7jjxDls57qnXqCjpbdK2at7uu
         q0H7HP7/TJWdolpdR/lofBBVbFPKRK757mlja2kLGXG3F86TANq9yhhhtZGBWuqlRsyC
         Ihg+3vHJz0qlb72GRgGziBDVxgNs6gITZETCgwVKepaP/752yPpNncYZzfbo3VEZ+bl9
         UPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rhk/RIq8N8redhElMwVU53NrBizqJp1QMtudMdpPmpM=;
        b=Y2QynWPPo50wCvn8grAdj93QduFk8c6g01ft/eKsWC6axwMcez8rSV3gTEbuU2C9hC
         U8KTjwSWBw/D52mq2pBDMJW1FvReUWxzyV0j4cWyE3ez8SVs/oVVm7W/zQk4gHgL2nLB
         zah/sNO0JOJcNvBe2OH6j9LcwIsqo9ZhvGYLmIRemhCcsFwxa6v1ZJ6epfobNfAvEbVV
         94yRMG2s2CQgpojP35c25UQAMdw3CVQPb6XIhRIZ8OLdv/KJcdp09m3jEshjBCT0PR9H
         TDZ/LLbVuAwp0zNlS2lbkh+0Q3bmn5Dv0+WAJW6HFcMzpuKyt93ECYnmB+t4BOBRMitR
         G0ng==
X-Gm-Message-State: AOAM5304DNVr2W/81eTucSnx/C9yhGnUNUT0I0PFNZUspo/IJqqdqnL3
        KQvq+oGGvQi7+SHYgR9QbKE=
X-Google-Smtp-Source: ABdhPJzCVdlFNRSiZiLnSKxbWk/jqyQfzQA4TzF2bHQZvmhfIq02kFr3gJcwfXr66PZL9/jFJDCH7g==
X-Received: by 2002:a17:906:150c:: with SMTP id b12mr48050752ejd.284.1641551796705;
        Fri, 07 Jan 2022 02:36:36 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::51e2])
        by smtp.gmail.com with ESMTPSA id v8sm1869857edt.10.2022.01.07.02.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 02:36:36 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 12/19] staging: r8188eu: convert two functions from s32 to int
Date:   Fri,  7 Jan 2022 11:36:13 +0100
Message-Id: <20220107103620.15648-13-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107103620.15648-1-straube.linux@gmail.com>
References: <20220107103620.15648-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the return type of fw_free_to_go() and
rtl8188e_firmware_download() from s32 to the more common int.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 6 +++---
 drivers/staging/r8188eu/include/rtl8188e_hal.h  | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index d219882fc4a2..f86b5cb2b6f9 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -467,7 +467,7 @@ void rtw_reset_8051(struct adapter *padapter)
 	rtw_write8(padapter, REG_SYS_FUNC_EN + 1, val8 | (BIT(2)));
 }
 
-static s32 fw_free_to_go(struct adapter *padapter)
+static int fw_free_to_go(struct adapter *padapter)
 {
 	u32	counter = 0;
 	u32	value32;
@@ -539,9 +539,9 @@ static int load_firmware(struct rt_firmware *rtfw, struct device *device)
 	return ret;
 }
 
-s32 rtl8188e_firmware_download(struct adapter *padapter)
+int rtl8188e_firmware_download(struct adapter *padapter)
 {
-	s32	rtStatus = _SUCCESS;
+	int rtStatus = _SUCCESS;
 	u8 writeFW_retry = 0;
 	u32 fwdl_start_time;
 	struct dvobj_priv *dvobj = adapter_to_dvobj(padapter);
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index 11d79606e120..4b67e11024a1 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -250,7 +250,7 @@ struct hal_data_8188e {
 };
 
 /*  rtl8188e_hal_init.c */
-s32 rtl8188e_firmware_download(struct adapter *padapter);
+int rtl8188e_firmware_download(struct adapter *padapter);
 void rtw_reset_8051(struct adapter *padapter);
 
 s32 InitLLTTable(struct adapter *padapter, u8 txpktbuf_bndy);
-- 
2.34.1

