Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9171D487E84
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 22:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbiAGVux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 16:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiAGVut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 16:50:49 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA953C06173F
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 13:50:48 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id o3so13470589wrh.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 13:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zi3gM1/OmTLXRomRp3HhtI8qkjro02kWGCf0OSZWoVE=;
        b=KnaSrhV8B/eZKOnnkEZsU2xqmkruCSe1wFYtGui5kAtDTpeDimemW7GbGnZ/893rh3
         oQ4QFx0NKWKbujSFi6WeFTsF0Y8uOreKOzwf4dtBbypbt7NQFjx/+6xhEaeqhp2/XVVP
         gPTieud3kqj2eKtnFniVt+V7g60v5L4SHaMIBvLD7A1dxWMoCJWFl0TX7f0VoOvAo0IX
         gaSVunhZ7d2Gd9x7nz+r9WIY3IJYcevHm0ph78w/5n/HL3mRtIAIg7O8ioyPmat7lKyr
         Y7KRuDgUuThe+7OooxteyDPPrnmBduFOrr9un8mgBtkknf9pFuyWV7fe8wmUxarIR5GH
         +DqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zi3gM1/OmTLXRomRp3HhtI8qkjro02kWGCf0OSZWoVE=;
        b=TE1QAgrZIdzON9EwzM0KdtSJs+pALspOgvtVogE+hNGnARKIqobwyIB4TvhGXl/IIn
         5hq3/QS9CwcYchwRv1aK0AhUvrgawyKR3zmpOByqMJuRPE1AcC98EsmVV9Wvqm+hGqga
         Gzuw2H6GcQ0piIdDU5JMWe4djBedLp65tKkdN5CFd3UCUQEsPGwdvUz0JG9rp2co3sFR
         aU/9q6BCDh+iWWaSaEn7IxjT7Fs3Dm5+mR0/wN/Iab/VWGyrSG14zRL3KEhOtPAFUImC
         D8728Uymbx9xE1jU6TFdMtflWgRcti/iIufIphjLZm6m04wvCqVcr9l2seJegK/7SabX
         cWJA==
X-Gm-Message-State: AOAM531OvwDzh3f3ZKmFZ5LkxjzGtmkY6wL53jE03Ti0E4hXEMiNUFWL
        M65eapuFO55wLgVElj6m9x4=
X-Google-Smtp-Source: ABdhPJzFsj6o5eEUglkmlEp7yW3inw9d0Zk4DgnLEk+7iaV31h5QcJqP/twBH0j7MSaA/8hnKnC/tQ==
X-Received: by 2002:a5d:64cc:: with SMTP id f12mr55786468wri.145.1641592247345;
        Fri, 07 Jan 2022 13:50:47 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::51e2])
        by smtp.gmail.com with ESMTPSA id k14sm1729161wrn.59.2022.01.07.13.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 13:50:47 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/6] staging: r8188eu: remove HW_VAR_CURRENT_ANTENNA from GetHwReg8188EU()
Date:   Fri,  7 Jan 2022 22:50:30 +0100
Message-Id: <20220107215033.12257-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107215033.12257-1-straube.linux@gmail.com>
References: <20220107215033.12257-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GetHwReg8188EU() is never called with HW_VAR_CURRENT_ANTENNA. Remove
that case from the function.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_halinit.c  | 3 ---
 drivers/staging/r8188eu/include/hal_intf.h | 1 -
 2 files changed, 4 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 72b008a78d75..33523ca90ee5 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1614,9 +1614,6 @@ void GetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 			}
 		}
 		break;
-	case HW_VAR_CURRENT_ANTENNA:
-		val[0] = haldata->CurAntenna;
-		break;
 	case HW_VAR_EFUSE_BYTES: /*  To get EFUE total used bytes, added by Roger, 2008.12.22. */
 		*((u16 *)(val)) = haldata->EfuseUsedBytes;
 		break;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 77149eda7edf..37c2d2b82ea8 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -55,7 +55,6 @@ enum hw_variables {
 	HW_VAR_INITIAL_GAIN,
 	HW_VAR_BT_SET_COEXIST,
 	HW_VAR_BT_ISSUE_DELBA,
-	HW_VAR_CURRENT_ANTENNA,
 	HW_VAR_ANTENNA_DIVERSITY_LINK,
 	HW_VAR_ANTENNA_DIVERSITY_SELECT,
 	HW_VAR_SWITCH_EPHY_WoWLAN,
-- 
2.34.1

