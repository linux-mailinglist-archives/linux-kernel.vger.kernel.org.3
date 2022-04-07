Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4894F7FA7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 14:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245599AbiDGNAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 09:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245568AbiDGM7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 08:59:51 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2075748E73
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 05:57:52 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id k2so6283505edj.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 05:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rVriixE1hFWrvnWyNMXzhhhJoAGwV0Gp7mfloTuErI0=;
        b=LIT8gkh5Fv+rboebnujcnnCPp9yxRKeoMsaxvL1mt74CZk6/3lZaROVgwB3BmJ+JAy
         yUhmAjsmh5atl7fZLFpx0waC5SszuPS7luaMeiPuVZHp9Ut4uLPD3V9DsRPrNI0suEhJ
         F9j+6Wr79uFrfy3hJSG1bHPrN6j/PIgiQEGD7xaXg+ZLZB7m/+2LiZl1ML0fDDMYUoKW
         ZMpUBJro4pyzlB3lej7YY7rFB+Fgha32gpU+fIvKtBGk+QsSNgpyNnyYjrA2/OytOqmx
         4SdM9h9TXz/WMiAnu8ME3a9qi8uztoScI3wtyrH81eRRLbP2kY+SWU0kajig4QKGbljO
         +f9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rVriixE1hFWrvnWyNMXzhhhJoAGwV0Gp7mfloTuErI0=;
        b=NaAFu6/ML5dJTYgO9NvIpA6upH7dPrey1tfcF0SQJca7hYVxDQTDV24R5pnFS1ghMx
         wizak4goxEPkxUZ7NgnVfxRAOE2v4DchPcYmZxy0Y+VrkHCBup+YceDxLON59FeFcCfV
         VxUHJayhLOpYsBGSDM0grL9pd+98R2Iuaqpa85KY8Sbb/URyDTvV8/i407wSMyfXoPz4
         FJJrQTCLn61yee1O8ZdtfCOXgWTDJM7T4zQboxFziSpNaHt/d9goRwcyN530ciZTZf4+
         ler0KfIpbAb5l1/ZHX2OgKSngl2ssQQwMltAuImTuXkXiLELWnu5xcsfcAqpuzWh4EOz
         3Kdw==
X-Gm-Message-State: AOAM533a1r9tesECSkPpt1QTf1Ie1zPhbEh0M0ed2z5QIXoj2Euq53bk
        zRYISMASQp55PNZroGy78D8=
X-Google-Smtp-Source: ABdhPJz6SjaTr+DSYDiC7jF5NkGZEGFlDseahF8t18TQbSLrDfn+I+hjtWh6/Lxu7H3K+FYWyxYFOg==
X-Received: by 2002:a05:6402:1e8a:b0:41a:4242:7de9 with SMTP id f10-20020a0564021e8a00b0041a42427de9mr14069732edf.284.1649336270763;
        Thu, 07 Apr 2022 05:57:50 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id n13-20020a170906724d00b006cedd6d7e24sm7676764ejk.119.2022.04.07.05.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 05:57:50 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 4/5] staging: r8188eu: use round_up() instead of _RND128()
Date:   Thu,  7 Apr 2022 14:57:41 +0200
Message-Id: <20220407125742.7814-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407125742.7814-1-straube.linux@gmail.com>
References: <20220407125742.7814-1-straube.linux@gmail.com>
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

Use in-kernel round_up() instead of custom _RND128().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v3: no changes
v2: no changes

 drivers/staging/r8188eu/hal/usb_ops_linux.c     | 2 +-
 drivers/staging/r8188eu/include/osdep_service.h | 8 --------
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 6a65dcf57112..d5e674542a78 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -287,7 +287,7 @@ static int recvbuf2recvframe(struct adapter *adapt, struct sk_buff *pskb)
 
 		recvframe_put(precvframe, skb_len);
 
-		pkt_offset = (u16)_RND128(pkt_offset);
+		pkt_offset = (u16)round_up(pkt_offset, 128);
 
 		if (pattrib->pkt_rpt_type == NORMAL_RX) { /* Normal rx packet */
 			if (pattrib->physt)
diff --git a/drivers/staging/r8188eu/include/osdep_service.h b/drivers/staging/r8188eu/include/osdep_service.h
index ff44c4a37b9d..f6c55f6c9e1a 100644
--- a/drivers/staging/r8188eu/include/osdep_service.h
+++ b/drivers/staging/r8188eu/include/osdep_service.h
@@ -96,14 +96,6 @@ static inline void flush_signals_thread(void)
 
 #define _RND(sz, r) ((((sz)+((r)-1))/(r))*(r))
 
-static inline u32 _RND128(u32 sz)
-{
-	u32	val;
-
-	val = ((sz >> 7) + ((sz & 127) ? 1: 0)) << 7;
-	return val;
-}
-
 static inline u32 _RND256(u32 sz)
 {
 	u32	val;
-- 
2.35.1

