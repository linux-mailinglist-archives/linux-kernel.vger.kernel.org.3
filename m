Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F2159AF84
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 20:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbiHTSRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 14:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbiHTSQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:16:44 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DF631DE2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 11:16:43 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id t5so9131356edc.11
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 11:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=+p+/p6KYk7k3LZ2p6BJMyqG+n93UeRxNU/hjU7tSF4s=;
        b=D3jOoPFLSWHyqBKWqPcy07BrdDFj+btHZBVi72MNmRufXF90atV2oUGdcZ0I7w9jEZ
         XU57n6TaqEDoEZmNd76ciNhmAFPvWQXDIwNcS33TQFi8NRIiFN8BC61By2GGXkLQNbve
         vL56OO1c3y341trKkufktZCQQ7YMzXJ/oVdSrXlqmvKOz5acN/T7uNq1QvzxYRgIKzRW
         /6O4FHZ2xTQFlRoT+kbKbG+XJE9OLbw0UbatEjBj3zHCagGB7WjzS0AgjWHVtPGPjH2d
         s6kp1E8roqLYPtMQZZ1WPTe/KEYs78t2jGp4P5zJvr12ZnTTULezJEmdjwqrklkOpnzp
         Ac5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=+p+/p6KYk7k3LZ2p6BJMyqG+n93UeRxNU/hjU7tSF4s=;
        b=ZJrm6LjyA9jvpll2NLNzSSubtq2QF6EbLBLgRev3Ta9jZKQ2esf0LMct2KPplxXvJj
         dDqGvQVZfDLt4glrc1A7KCtYJHXXIf+YSwH+zwVcwgKn3w/mL6tiqadNbzUJrDeAIFDd
         1ZrjX/hwcp6T5UBYvMA0wu3eM7aLcer6dEz46Rat6QFzFGmBiBQ5oGGMp2Z0e++hq1EH
         95Fr7c1ilBDEJUiXQP2vBe+pX3SMEhFLU0YGc9NUBbMlnnWXFT22tyZTKcIMgwzTT8AM
         I0FpSC3u9CbTQj87lyM0WbLnpoScj3Ie3hdC77c8MefWFHdyuJHfQRUl+QlbFox1eDYl
         lBdA==
X-Gm-Message-State: ACgBeo2nNtbBpNuRjAmr/nLXBIv7ETwMWlllQHzlE5nVcg5UR/EKP0To
        vB3o5FiWPlvYP1SOJC4If3U=
X-Google-Smtp-Source: AA6agR4l7Rg0O7B+/EcNEM3BgwwyFTot6LkvhHoV7dmhSZN3TF+RSCplyzVTJUZ4qLaBdmQhvPvvzA==
X-Received: by 2002:a05:6402:4313:b0:446:7ce9:c2a1 with SMTP id m19-20020a056402431300b004467ce9c2a1mr2395547edc.288.1661019403067;
        Sat, 20 Aug 2022 11:16:43 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb77.dynamic.kabel-deutschland.de. [95.90.187.119])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090604c200b0072af890f52dsm3887833eja.88.2022.08.20.11.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 11:16:42 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 10/19] staging: r8188eu: make _rtw_pktfile_read() static
Date:   Sat, 20 Aug 2022 20:16:14 +0200
Message-Id: <20220820181623.12497-11-straube.linux@gmail.com>
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

The function _rtw_pktfile_read() is only used in rtw_xmit.c.
Make it static.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_xmit.c      | 22 ++++++++++++++++++++
 drivers/staging/r8188eu/include/xmit_osdep.h |  2 --
 drivers/staging/r8188eu/os_dep/xmit_linux.c  | 22 --------------------
 3 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index caacf35485dd..26bf300e672b 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -421,6 +421,28 @@ static void rtw_open_pktfile(struct sk_buff *pktptr, struct pkt_file *pfile)
 	pfile->cur_buffer = pfile->buf_start;
 }
 
+static uint rtw_remainder_len(struct pkt_file *pfile)
+{
+	return pfile->buf_len - ((size_t)(pfile->cur_addr) -
+	       (size_t)(pfile->buf_start));
+}
+
+static uint _rtw_pktfile_read(struct pkt_file *pfile, u8 *rmem, uint rlen)
+{
+	uint	len = 0;
+
+	len =  rtw_remainder_len(pfile);
+	len = (rlen > len) ? len : rlen;
+
+	if (rmem)
+		skb_copy_bits(pfile->pkt, pfile->buf_len - pfile->pkt_len, rmem, len);
+
+	pfile->cur_addr += len;
+	pfile->pkt_len -= len;
+
+	return len;
+}
+
 static void set_qos(struct pkt_file *ppktfile, struct pkt_attrib *pattrib)
 {
 	struct ethhdr etherhdr;
diff --git a/drivers/staging/r8188eu/include/xmit_osdep.h b/drivers/staging/r8188eu/include/xmit_osdep.h
index 2ecbe3f01aa8..bcecf0bb2b18 100644
--- a/drivers/staging/r8188eu/include/xmit_osdep.h
+++ b/drivers/staging/r8188eu/include/xmit_osdep.h
@@ -30,8 +30,6 @@ struct xmit_buf;
 
 int rtw_xmit_entry(struct sk_buff *pkt, struct  net_device *pnetdev);
 
-uint _rtw_pktfile_read(struct pkt_file *pfile, u8 *rmem, uint rlen);
-
 void rtw_os_pkt_complete(struct adapter *padapter, struct sk_buff *pkt);
 void rtw_os_xmit_complete(struct adapter *padapter,
 			  struct xmit_frame *pxframe);
diff --git a/drivers/staging/r8188eu/os_dep/xmit_linux.c b/drivers/staging/r8188eu/os_dep/xmit_linux.c
index c917024843a2..e216ada44055 100644
--- a/drivers/staging/r8188eu/os_dep/xmit_linux.c
+++ b/drivers/staging/r8188eu/os_dep/xmit_linux.c
@@ -11,28 +11,6 @@
 #include "../include/osdep_intf.h"
 #include "../include/usb_osintf.h"
 
-static uint rtw_remainder_len(struct pkt_file *pfile)
-{
-	return pfile->buf_len - ((size_t)(pfile->cur_addr) -
-	       (size_t)(pfile->buf_start));
-}
-
-uint _rtw_pktfile_read(struct pkt_file *pfile, u8 *rmem, uint rlen)
-{
-	uint	len = 0;
-
-	len =  rtw_remainder_len(pfile);
-	len = (rlen > len) ? len : rlen;
-
-	if (rmem)
-		skb_copy_bits(pfile->pkt, pfile->buf_len - pfile->pkt_len, rmem, len);
-
-	pfile->cur_addr += len;
-	pfile->pkt_len -= len;
-
-	return len;
-}
-
 #define WMM_XMIT_THRESHOLD	(NR_XMITFRAME * 2 / 5)
 
 void rtw_os_pkt_complete(struct adapter *padapter, struct sk_buff *pkt)
-- 
2.37.2

