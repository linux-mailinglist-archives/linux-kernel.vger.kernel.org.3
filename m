Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845EA4F5ADE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 12:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1585587AbiDFJiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 05:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573147AbiDFJe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 05:34:57 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3482123BC8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 23:19:16 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id d10so1419409edj.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 23:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dnqi2X3VqKcJXFMBrImVZdG4X888h8cJCwQ8yMk/hyQ=;
        b=EJMyMYzIZC1Io2eWJ1YOIP3IOiSYClaGwyinQHYVALb3GKd21ey4O3XwMx8UATe0zC
         uZEH4Uvxhh5tQFk1B3db2jaD9FxYVSvlMOuVICWR7fkXm1wxcAZJck9tiEyDnR89drM9
         vAn4cK/rDfxeYMiOMLo+jzy4quD3/r56fXmSsjUwHN6iyqOU6xeZUaws6qxeDnk7aSAe
         vU4supMeCkcH/s7uuvDPAILaxv4M1vYRsatV6jM9wm4EOmyLFGqVGAGRlBkX9Qy8N2Pw
         fBAjNPMng5rAMs7OEwaPhxIjwHEo7FhHpoh8ak7crnkuD6/b8dt6iT/lCnsfeVVuiYYH
         cUnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dnqi2X3VqKcJXFMBrImVZdG4X888h8cJCwQ8yMk/hyQ=;
        b=ihVMPluGYzpBGGSp0Nlf8pigSk31pHzIGijv1VEQF0VcFeIzIUWEHtzHHZ42S+IqY0
         c1dygSuMYMRVtzjw780JwbKs2HDGzk/y3SW1mMzb0I05OnNWMb3OxbSkWORPEiF5arny
         HMzk4rKwMjQLUqt1x1vlqqLZJpcuQ+ua0/ru5CSeA6cgWVw6sLX92eE93iFEiqUY3iD0
         rLqHbK3BUNlxwdITNxsh6XeTBZar/z+PN4U7gOQ1Nbm41IVBYTw/MrlPGY08TXkN0jyK
         6H4nxjtMEPD3BNsA4pLryfsQHW189WSNzIcqHWXZwOG+RX/IFTmnAsPvFk6At6q7QQu1
         mKXQ==
X-Gm-Message-State: AOAM530hapT/8iOk34BdgXWG/Jrk/FeRefmLMyOdTaGhrK97Q6bASn6g
        CMg4ltuT6Xp3urpuStXDkSk=
X-Google-Smtp-Source: ABdhPJyqAXpogB2imN4UMPk+9i4abNKV4LekV/pZO+b6CjE5Firicrj3bqXI4+6oKiZF8Yt44obGOA==
X-Received: by 2002:a05:6402:1d55:b0:419:992b:9286 with SMTP id dz21-20020a0564021d5500b00419992b9286mr7158021edb.235.1649225955363;
        Tue, 05 Apr 2022 23:19:15 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id q3-20020a50da83000000b0041cdd6e92b1sm2475251edj.27.2022.04.05.23.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 23:19:14 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/5] staging: r8188eu: use round_up() instead of _RND128()
Date:   Wed,  6 Apr 2022 08:18:58 +0200
Message-Id: <20220406061859.9011-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406061859.9011-1-straube.linux@gmail.com>
References: <20220406061859.9011-1-straube.linux@gmail.com>
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

