Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 476C649F8CF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 12:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348290AbiA1LzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 06:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348272AbiA1Ly6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 06:54:58 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837CCC06173B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 03:54:58 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id j2so9306516edj.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 03:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rYcKKUC0DJ5U+UFpd0rarJw3mrhHuo/xI2TduGQquMw=;
        b=pMdRF4HTSskGIzaus8V13bLzXZuJL2KoBZQ/pdp6ALyTY94SQgDU0Or+bmjMttfb7f
         6Q/YECi1w/de6nfTyKQ/UMXtQgOPjqDVjKzBkPYCMwILSTDAyRtNuOMBOxuEL3H61c2a
         iGKSECzCTwusQCgLGseyhOW30+F4qNjXcV5IBwBio9Y3am0yyYNEvWxxQhIb0W7sSrWS
         rOGdT4MsIegJms7SSA7/e+o9vg2K+Dn6Evb0PEf+LYpZA9li2JWh+i5vMTOxIdwDFPqq
         3MIexsLTj9beqUCo+Aal1BuS0mTKcftexgoZNdPDS8zQW69dUOI9/O0AYzBn7fLTMFpj
         7Bfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rYcKKUC0DJ5U+UFpd0rarJw3mrhHuo/xI2TduGQquMw=;
        b=SSG9ZeeG9fF30HPftO4aQRXL27vxmtivBzJovxN4PN+AHTBc5dddvJdIqBpaCHCaSW
         gYWNOyhmA6VLroJ/6PLRtIi5YwMNHBAiVTmwQ5X0Qen/jwSYtl9xihAHC1PiTVFRxwKT
         XwLlnjulli8KGUrbloid6VwPpKEX+A7rqDOGdcD7gZO451rdzxpeKFMINOB0GlWA14w4
         IxAc1Ax95jOcRoahJRpkPRxUfLQ19rZP+UdkHZSs9TMaITg49mOW6tFH8HZH5DzN2eP/
         uDIsWhPz5UocLIC3gqKEIfbyoEAOabyO6/QCOtbfhX71wz01nblT04f0NrOvcnLNygHm
         oxJw==
X-Gm-Message-State: AOAM530HBPID1owtLNEJ+6HFyRpcv2FzopfbBWxD0Xp5UXicWNtfEVO5
        ZM4zX6bXQ2bBQJSVj7vwTao=
X-Google-Smtp-Source: ABdhPJzG99Lv0g65i4LcvY/9roHxtf/XxjYMUpzCuBbthShAEZARuQR+/kGBhVY2FjUmVqlRw9So9A==
X-Received: by 2002:a05:6402:3585:: with SMTP id y5mr7921099edc.104.1643370897115;
        Fri, 28 Jan 2022 03:54:57 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb9e.dynamic.kabel-deutschland.de. [95.90.187.158])
        by smtp.gmail.com with ESMTPSA id h20sm12494261eds.9.2022.01.28.03.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 03:54:56 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/6] staging: r8188eu: convert GetHalDefVar8188EUsb() to void
Date:   Fri, 28 Jan 2022 12:54:43 +0100
Message-Id: <20220128115445.6606-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128115445.6606-1-straube.linux@gmail.com>
References: <20220128115445.6606-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of GetHalDefVar8188EUsb() is not used. Convert the
function to void.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_halinit.c  | 6 +-----
 drivers/staging/r8188eu/include/hal_intf.h | 2 +-
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 87382806774b..7a640fbaaca6 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1600,10 +1600,9 @@ void GetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 }
 
 /* Query setting of specified variable. */
-u8 GetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eVariable, void *pValue)
+void GetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eVariable, void *pValue)
 {
 	struct hal_data_8188e *haldata = &Adapter->haldata;
-	u8 bResult = _SUCCESS;
 
 	switch (eVariable) {
 	case HAL_DEF_UNDERCORATEDSMOOTHEDPWDB:
@@ -1647,11 +1646,8 @@ u8 GetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eVariable
 		*((u8 *)pValue) = haldata->bDumpTxPkt;
 		break;
 	default:
-		bResult = _FAIL;
 		break;
 	}
-
-	return bResult;
 }
 
 /* Change default setting of specified variable. */
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index f382b7fefb4a..96016e175cb5 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -102,7 +102,7 @@ int rtl8188e_IOL_exec_cmds_sync(struct adapter *adapter,
 				struct xmit_frame *xmit_frame, u32 max_wating_ms, u32 bndy_cnt);
 
 u8 SetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eVariable, void *pValue);
-u8 GetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eVariable, void *pValue);
+void GetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eVariable, void *pValue);
 
 unsigned int rtl8188eu_inirp_init(struct adapter *Adapter);
 
-- 
2.34.1

