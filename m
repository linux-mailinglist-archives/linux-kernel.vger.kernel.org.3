Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDEB4EAB73
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 12:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbiC2KkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 06:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235244AbiC2Kjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 06:39:54 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190EBC1C95
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 03:38:10 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id pv16so34246622ejb.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 03:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LsMxFHOpT2A5HUis8VHCCczQTixH8ndtilKa6t51LrI=;
        b=Pq3ggJM3Rhl7SPfPzHmle6U9ZLOrNMFBynlGOnTYhnWdeWRFEFR9k5d0GC+wQ2k3BG
         CbXgwnDqAf6j3GK6U2PaQ87RBSfG2F7q+DxLCT5LwFyKzM5QXhsj9UldUsAPbwvUyVCL
         CCuoXg1PxryZlYsSHhthxfYHvFahI0f+UQHgCN/RGGMTxcosxnrOu0qnZKB5MG5WhEX4
         hp0kYFR94mptzFAPnduf1Oi9dMi0TfbOpwcYtM8PWRZp3Jz3k8EseLOYUs7lIrpHcRQY
         6QbKysFcmjBGyRxlRMaglVlR/sxVZ1TvhDqR2EcKuyI5LqwSCjkLvby9ANn4JXoUj9tG
         etIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LsMxFHOpT2A5HUis8VHCCczQTixH8ndtilKa6t51LrI=;
        b=nH79xdZ1Lx9mnbJhwSdaOzmsFgst5+ezXemjlZfgJoCjZAS8WyrtPXkxIdaEwRGeUz
         eouP8uxPwqGQLHrVZqbSmG8LTQ+RzAO373OBUrj0xeCxfIicUii/zhfkJm0H+w4USlbD
         Mn7IfQ32UdeDqgjNMPWaFBzVrJ0PpqPOZquhy7Ul2wsbf8jwijMEnMVIT8/JjAan9xuu
         Fe6Dp8ktfwW7Z/+G3YUyBee8No4nNAd7ZSiINXglkv4VtRk1cWK3KalFXLQMi8BGv/Wn
         xyg8bpTlW84S/A4449OB+uUPktKCKVjbnsWX5KzLtSpFv/RszxIoFvQS4+vPvuruZZS8
         LFNg==
X-Gm-Message-State: AOAM533gCqd83CUPF1aoUmaxwN8iGGUAUoAR5mSxvNbFYj+US9f+oP2x
        IbgHD/PsDJC8CG3jft+rnFo=
X-Google-Smtp-Source: ABdhPJz0xqUQqT3sUKGA15qsP14r3IAHkIFxcD0kHKW7MrHMOmtXEEJtDpooSpjRdDfVk+jHjyb69Q==
X-Received: by 2002:a17:906:434e:b0:6d0:ed9c:68bc with SMTP id z14-20020a170906434e00b006d0ed9c68bcmr32630418ejm.70.1648550288698;
        Tue, 29 Mar 2022 03:38:08 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id qw39-20020a1709066a2700b006e03017d60csm7058151ejc.54.2022.03.29.03.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 03:38:08 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/4] staging: r8188eu: convert rtw_usb_bulk_size_boundary() to bool
Date:   Tue, 29 Mar 2022 12:37:55 +0200
Message-Id: <20220329103756.6740-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220329103756.6740-1-straube.linux@gmail.com>
References: <20220329103756.6740-1-straube.linux@gmail.com>
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

Function rtw_usb_bulk_size_boundary() returns boolean values.
Change its return type from u8 to bool.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/usb_ops.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/include/usb_ops.h b/drivers/staging/r8188eu/include/usb_ops.h
index cfcf6f84d2cf..5ee1c8c7940d 100644
--- a/drivers/staging/r8188eu/include/usb_ops.h
+++ b/drivers/staging/r8188eu/include/usb_ops.h
@@ -46,7 +46,7 @@ static inline void rtw_reset_continual_urb_error(struct dvobj_priv *dvobj)
 #define USB_HIGH_SPEED_BULK_SIZE	512
 #define USB_FULL_SPEED_BULK_SIZE	64
 
-static inline u8 rtw_usb_bulk_size_boundary(struct adapter *padapter, int buf_len)
+static inline bool rtw_usb_bulk_size_boundary(struct adapter *padapter, int buf_len)
 {
 	struct dvobj_priv *pdvobjpriv = adapter_to_dvobj(padapter);
 
-- 
2.35.1

