Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0EED488CB5
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 22:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237234AbiAIVyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 16:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234709AbiAIVyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 16:54:33 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2419EC06173F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 13:54:33 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id t28so16489394wrb.4
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jan 2022 13:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z/xQgPdF4pLZ7rSZV7wFE+mDlaQQE7y+ojmrtCNp2S0=;
        b=mtH68rJeTi1TCPm8g4SR/TY0WUCwPBzeSVXMbAf1eSEUkBL7UC6voDIyjPs+H2bweC
         Mj0SwpyaSvyEBT+HJdTbrFvfP5JD4hLxF/vTG3/77qPB0DMd0hypZRDvDwgOFIuu/HBR
         Sd2Rsy4ieJ90ew392xiVLXJnSHnrjU08kRVgzXF5i+ppzRHLM/0zHgPRtqJhSPCc9u35
         r9qP+IUqZa9+Z+vIcXB6juEHd8rak25RiuNnTYWyQdh/ZPVMzoocbOqRMutPduN+q9Gu
         MLxisPEyWtarAnE6Nm/hnBL4hP3P8RPRg1HCbNQANANg88FsBnOezs/ZVT/N64cPBffD
         Kgww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z/xQgPdF4pLZ7rSZV7wFE+mDlaQQE7y+ojmrtCNp2S0=;
        b=rxHKDWpmfgLyIc+gp+EZXfiakcPy4wFAZGuDOviSYA/AD4vLN4zwDIsQNFwgCztEno
         462CYuxhvoDGRSYAEMzviHXASATW6oeNVk7d0vBjmLtpiqy2gVsN3MyQDgSZnweZIXyS
         uqXYO2gX08AhDmSdzQEftHAZsSUyb2CLiyg9oqewPJe8kZU7R0oyQPlJNF3LxenmdEBX
         3xTs0iNoGXCknsbXG8AaFm7zwZdm5ZxS4PwvAWO5iKD0dJjJfGtn8x65omFCUaopNX4M
         Ug5/n6z0r7CYVAQX6XKuUhnVgeKwy+Opo9OUVIefas/KbetQF/Jjw5DIqTi+4yiqq08u
         r1Eg==
X-Gm-Message-State: AOAM5338mZ1BYgggyQDLktGbXquVegszEECHatKurrr5Wqns+jJXwp4z
        WYCA5lLgPLmWJW/4RQIIuI282w==
X-Google-Smtp-Source: ABdhPJyvbrJiyg+WkmzDY0n4DUHVXi0xtNTepHogOuVbyWf7jbsxCDl8Q0KKy1GDTYe3iJ0wj+n90g==
X-Received: by 2002:a5d:584e:: with SMTP id i14mr6157958wrf.255.1641765271791;
        Sun, 09 Jan 2022 13:54:31 -0800 (PST)
Received: from localhost.localdomain (d.f.5.e.6.6.b.1.e.6.2.7.e.5.c.8.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:8c5e:726e:1b66:e5fd])
        by smtp.gmail.com with ESMTPSA id r13sm5065650wmq.28.2022.01.09.13.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 13:54:31 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] staging: r8188eu: convert DBG_88E calls in core/rtw_iol.c
Date:   Sun,  9 Jan 2022 21:54:23 +0000
Message-Id: <20220109215427.887-4-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220109215427.887-1-phil@philpotter.co.uk>
References: <20220109215427.887-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the DBG_88E macro calls in core/rtw_iol.c to use pr_debug
or netdev_dbg appropriately, as their information may be useful to
observers, and this gets the driver closer to the point of being
able to remove DBG_88E itself.

Some calls are at points in the call chain where use of dev_dbg or
netdev_dbg isn't possible due to lack of device pointer, so plain
pr_debug is appropriate here.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_iol.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_iol.c b/drivers/staging/r8188eu/core/rtw_iol.c
index 7e78b47c1284..923da2a9f6ae 100644
--- a/drivers/staging/r8188eu/core/rtw_iol.c
+++ b/drivers/staging/r8188eu/core/rtw_iol.c
@@ -12,13 +12,15 @@ struct xmit_frame	*rtw_IOL_accquire_xmit_frame(struct adapter  *adapter)
 
 	xmit_frame = rtw_alloc_xmitframe(pxmitpriv);
 	if (!xmit_frame) {
-		DBG_88E("%s rtw_alloc_xmitframe return null\n", __func__);
+		netdev_dbg(adapter->pnetdev,
+			   "rtw_alloc_xmitframe return null\n");
 		return NULL;
 	}
 
 	xmitbuf = rtw_alloc_xmitbuf(pxmitpriv);
 	if (!xmitbuf) {
-		DBG_88E("%s rtw_alloc_xmitbuf return null\n", __func__);
+		netdev_dbg(adapter->pnetdev,
+			   "rtw_alloc_xmitbuf return null\n");
 		rtw_free_xmitframe(pxmitpriv, xmit_frame);
 		return NULL;
 	}
@@ -49,8 +51,8 @@ int rtw_IOL_append_cmds(struct xmit_frame *xmit_frame, u8 *IOL_cmds, u32 cmd_len
 
 	/* check if the io_buf can accommodate new cmds */
 	if (ori_len + cmd_len + 8 > MAX_XMITBUF_SZ) {
-		DBG_88E("%s %u is large than MAX_XMITBUF_SZ:%u, can't accommodate new cmds\n",
-			__func__, ori_len + cmd_len + 8, MAX_XMITBUF_SZ);
+		pr_debug("%u is larger than MAX_XMITBUF_SZ:%u, can't accommodate new cmds\n",
+			 ori_len + cmd_len + 8, MAX_XMITBUF_SZ);
 		return _FAIL;
 	}
 
-- 
2.33.1

