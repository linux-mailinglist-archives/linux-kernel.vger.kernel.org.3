Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C0D488252
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 09:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbiAHI1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 03:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233821AbiAHI1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 03:27:48 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E0BC06173E
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 00:27:47 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id h10so5473005wrb.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jan 2022 00:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I7FR9DbSMxpW/4g1B75rGPwrRCKNQS0S40gVywwIMUw=;
        b=T+sGF/NfDYcaTTi3wgMAYqHpYN6+x4K4I0nVKJRl7yphjDfk1LCdLtX+Iu4of5J+zk
         MhyyH7jIex1ZhXHx7XyRlR0Z/puuKL1PxUMHWW3q2ywYxEyZSnWbL4v1e/IPSNGgWEtc
         zlM1vP3AnD3vxpO6vtQNZoO7QbFkrHDNnHzxuwUYH9iq7uetawii7GGKeBnQY4AuIjZf
         m2WGZjjZgomiYGkclYXB209Bq9aSMq78Or8HvTrvXXuG1S1fzkKZkwlaKWsBnplcAO1/
         GNy8L0IJC+6e5GVNZ7WBAHGghreRQFJPM2BVRamMbyNSrnCc8yew2Gz2GGlDW1YUTpV0
         XLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I7FR9DbSMxpW/4g1B75rGPwrRCKNQS0S40gVywwIMUw=;
        b=pEblFXUcaePHrRVGuju9HuINcWN5FwwcaZB66wM05MkoYoSpjTMWfHgBYb+uUOmc8+
         QM4hKDLGh1DbnqhiCtNH40CaIT/m4y0EP7QPF13o60RZqSL2K6uzeA2ucAM0O7OUu5Zm
         o8hdh1TJXhwVOhV0jHHtc5uyYI5K/ZFoMLN4L1wQIqAK6aEx9UwwoyWDA3AR7JK6BthM
         8Te9X1cLES91Ocph8bNh1jsMQh/2psuOJ2FHaNMvjZo1imD8+WtAYD4UQvSRYUM4qp9t
         /HFlRjx5KD6TPnCI5ouQdl+2sCCT08sr1z6ziEASALAbMz3PNavnZwlW8fkn4g6fZAbS
         Hh1Q==
X-Gm-Message-State: AOAM532jTJmNcdtj0fPf7yUB1viwld8dJHS9eOmRW/XKlc4mxDNE86mr
        Mqbwuot08m74WYr+dS14AsI=
X-Google-Smtp-Source: ABdhPJykIxcCsSxPcm7p7uNAWAZNkv/dyVHiurYnHLsC2Q63x6Piv4J4GGGSUUTLlzNVPyNniTLgMQ==
X-Received: by 2002:a05:6000:16c9:: with SMTP id h9mr1704117wrf.508.1641630466600;
        Sat, 08 Jan 2022 00:27:46 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::51e2])
        by smtp.gmail.com with ESMTPSA id az1sm964536wrb.104.2022.01.08.00.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 00:27:46 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/5] staging: r8188eu: remove rtw_os_recv_resource_alloc()
Date:   Sat,  8 Jan 2022 09:27:36 +0100
Message-Id: <20220108082736.16788-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220108082736.16788-1-straube.linux@gmail.com>
References: <20220108082736.16788-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merge rtw_os_recv_resource_alloc() into _rtw_init_recv_priv() and
remove rtw_os_recv_resource_alloc().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_recv.c      | 3 ++-
 drivers/staging/r8188eu/include/recv_osdep.h | 2 --
 drivers/staging/r8188eu/os_dep/recv_linux.c  | 9 ---------
 3 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 26893f36d1ff..5438a73ba06b 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -70,7 +70,8 @@ int _rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter)
 
 		list_add_tail(&precvframe->list, &precvpriv->free_recv_queue.queue);
 
-		res = rtw_os_recv_resource_alloc(padapter, precvframe);
+		precvframe->pkt_newalloc = NULL;
+		precvframe->pkt = NULL;
 
 		precvframe->len = 0;
 
diff --git a/drivers/staging/r8188eu/include/recv_osdep.h b/drivers/staging/r8188eu/include/recv_osdep.h
index 71fe581fbc85..ca8a613508fd 100644
--- a/drivers/staging/r8188eu/include/recv_osdep.h
+++ b/drivers/staging/r8188eu/include/recv_osdep.h
@@ -19,8 +19,6 @@ void rtw_handle_tkip_mic_err(struct adapter *padapter, u8 bgroup);
 int rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter);
 void rtw_free_recv_priv(struct recv_priv *precvpriv);
 
-int rtw_os_recv_resource_alloc(struct adapter *adapt, struct recv_frame *recvfr);
-
 int rtw_os_recvbuf_resource_alloc(struct adapter *adapt, struct recv_buf *buf);
 int rtw_os_recvbuf_resource_free(struct adapter *adapt, struct recv_buf *buf);
 
diff --git a/drivers/staging/r8188eu/os_dep/recv_linux.c b/drivers/staging/r8188eu/os_dep/recv_linux.c
index da21490fe168..b205c50e9d75 100644
--- a/drivers/staging/r8188eu/os_dep/recv_linux.c
+++ b/drivers/staging/r8188eu/os_dep/recv_linux.c
@@ -12,15 +12,6 @@
 #include "../include/osdep_intf.h"
 #include "../include/usb_ops.h"
 
-/* alloc os related resource in struct recv_frame */
-int rtw_os_recv_resource_alloc(struct adapter *padapter,
-		struct recv_frame *precvframe)
-{
-	precvframe->pkt_newalloc = NULL;
-	precvframe->pkt = NULL;
-	return _SUCCESS;
-}
-
 /* alloc os related resource in struct recv_buf */
 int rtw_os_recvbuf_resource_alloc(struct adapter *padapter,
 		struct recv_buf *precvbuf)
-- 
2.34.1

