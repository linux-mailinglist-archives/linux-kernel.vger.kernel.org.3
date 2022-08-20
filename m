Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B538659AF82
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 20:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234217AbiHTSRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 14:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbiHTSQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:16:51 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983DE31DCB
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 11:16:46 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id a22so9134499edj.5
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 11:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=+gbZ+oN4SNG8rEc+ME/YtcZCnc3X1ePwf/x65RNZ3kM=;
        b=BYZya6PP+0hwGkgRVKYMSNMHtfJxzJNgNXJCkJuXFR/ELJZ2PgABp0Sn/DYTU+7NGW
         GT9/YKIWzsuWjUVvjCLL2FJA+/k5ZHuxAG8DsVdz+/Ba95l93eWcJ6pfyW5RLDQ+dD+h
         dI0NjeplNbn7qM9Ql4RasukxulLInv5PjQ0LHO7R3zxyp262TxKAjJQSLBVDmpanG++U
         Y6lBSuFzdo7jejWgwxHwY5AXE+KZtIcd43Dh4v+3gQ471Ggxx3ElwfCSW6DLbddHFKwd
         SC7c/XhPoDGMUKa1ULhXhBRdmxS7j4nRrdNXZ5GQ6uN81aVHA4J26HnCm6tm2VJAjNz9
         7WxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=+gbZ+oN4SNG8rEc+ME/YtcZCnc3X1ePwf/x65RNZ3kM=;
        b=FedY9WVNvj3+EgatMYZz0zPgi/ZzHlr97pXtmsnsnjqcjXGUB0QyojsPev+NJPWu10
         BU3aX34/A+OGMzyL1SN5z6UEAiXNgeSVza8AgC8AVrooZEuw/XqzzHeusK7yjdo6BxP3
         1MTc0n3W7JTuGfBUOQrURsa2NPF0TNn687F+vDVK35APLOFGAveUW8q82lWvhYzfAP2w
         pjQNSPxtfGFffYMB/EH134CImI1sZY7mn09UTY3sFob+5NYOsJfcqNwefLQ877Kx48zb
         VLJVTfMfEmsX3ny4rxH2KffY3W55RIeYkvb9/yUi5dWcTpnQyBt3RArWOnBN/6YNJXdt
         rYvw==
X-Gm-Message-State: ACgBeo04HTgDb06TIIRAwWtkZ+L0ggNjOH0t5M6u9achZzhAt9QMHqCc
        buFPLaJsyB866xBNx5MWEjI=
X-Google-Smtp-Source: AA6agR51MlTVkECMOkCcfSBY/eKRePWM2JMEl8QhB9bsKxUbI9ainFG0dFWvrfWTo1X0qGZRso32ow==
X-Received: by 2002:a05:6402:451:b0:446:7349:f9e8 with SMTP id p17-20020a056402045100b004467349f9e8mr3043070edw.180.1661019405215;
        Sat, 20 Aug 2022 11:16:45 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb77.dynamic.kabel-deutschland.de. [95.90.187.119])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090604c200b0072af890f52dsm3887833eja.88.2022.08.20.11.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 11:16:44 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 13/19] staging: r8188eu: move struct pkt_file to rtw_xmit.h
Date:   Sat, 20 Aug 2022 20:16:17 +0200
Message-Id: <20220820181623.12497-14-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220820181623.12497-1-straube.linux@gmail.com>
References: <20220820181623.12497-1-straube.linux@gmail.com>
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

The code that uses struct pkt_file has been moved to rtw_xmit.c.
Move the structure definition to rtw_xmit.h.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/rtw_xmit.h   | 9 +++++++++
 drivers/staging/r8188eu/include/xmit_osdep.h | 9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtw_xmit.h b/drivers/staging/r8188eu/include/rtw_xmit.h
index 034a9f8f51c9..0e9471fb19e4 100644
--- a/drivers/staging/r8188eu/include/rtw_xmit.h
+++ b/drivers/staging/r8188eu/include/rtw_xmit.h
@@ -304,6 +304,15 @@ struct	xmit_priv {
 	struct submit_ctx ack_tx_ops;
 };
 
+struct pkt_file {
+	struct sk_buff *pkt;
+	size_t pkt_len;	 /* the remainder length of the open_file */
+	unsigned char *cur_buffer;
+	u8 *buf_start;
+	u8 *cur_addr;
+	size_t buf_len;
+};
+
 struct xmit_buf *rtw_alloc_xmitbuf_ext(struct xmit_priv *pxmitpriv);
 s32 rtw_free_xmitbuf_ext(struct xmit_priv *pxmitpriv,
 			 struct xmit_buf *pxmitbuf);
diff --git a/drivers/staging/r8188eu/include/xmit_osdep.h b/drivers/staging/r8188eu/include/xmit_osdep.h
index bcecf0bb2b18..612cdab52a9f 100644
--- a/drivers/staging/r8188eu/include/xmit_osdep.h
+++ b/drivers/staging/r8188eu/include/xmit_osdep.h
@@ -7,15 +7,6 @@
 #include "osdep_service.h"
 #include "drv_types.h"
 
-struct pkt_file {
-	struct sk_buff *pkt;
-	size_t pkt_len;	 /* the remainder length of the open_file */
-	unsigned char *cur_buffer;
-	u8 *buf_start;
-	u8 *cur_addr;
-	size_t buf_len;
-};
-
 extern int rtw_ht_enable;
 extern int rtw_cbw40_enable;
 extern int rtw_ampdu_enable;/* for enable tx_ampdu */
-- 
2.37.2

