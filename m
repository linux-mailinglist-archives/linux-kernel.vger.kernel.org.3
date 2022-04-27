Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C9351222B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiD0TLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbiD0TL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:11:29 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3103226EF
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 12:01:11 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id fv2so2230118pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 12:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u0vK5DOioCsOu8Z5Tn39+iFk9MTYah9fv3mNsqNjdus=;
        b=VGuPkdx1C2SRHqVcIOD3NwOHKSTxdpr4/FzXdBdKcq2ZkJoaKu1TdlHaunnM1K3WWH
         ipIbve51Y5/tGawUbxvvl+Z+mfKq/RaIKffRWPl9r/XSXVtYV2QmHGLuzwN1agT47SDk
         MMoLN8/y5f60qTWzGTHdt/D/ZVrjYDvshq31rMp05SxQnyn39XUTplndeYoZ8y0830Hx
         IR89RPQj3m8xWVmzXLp0X6+QP22DYHuMYdOnIVUiSGJXQreK//f2PqS6EFoIojGFaqLE
         548thIYFnoXHMcqh013B8sJsZVFYHfYCCvks/RLoLFb1RYtTDW/yLhmpSZfjtDgR+qQx
         ykbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u0vK5DOioCsOu8Z5Tn39+iFk9MTYah9fv3mNsqNjdus=;
        b=hTxgYT/OBwJoiuKk/JXcSkd+QRws8/Qq4z7HZTgboaml+r7sAZ5z4+vby/PAanQQbr
         7WSYRAyZGJuhde+fOC6A4jT7QK9+3zrOCTCLZuuv6qn9Pw3u/S10/jL4h7UrPHYgNPui
         oFL4E0grgkowSc1/r0GVzjDF4eV1D6QowC4IKzQWjLOwf6f46FaMlqYFFL7oomZH/tYv
         SeeN5Hijsu2UKNXO5RtL77lRU4g+0cR1GEfAEXXdpRu1SRoyee+ITmFq8lzmjWDmOojh
         5R6ASwVG0ZDAhG3ZL12Tn+0+Q/wvED15kWA7eMbeewLZ7vjK/AptFK7YKqYvzvIkvhWQ
         UTeA==
X-Gm-Message-State: AOAM532MBzFJpPqLuGKQnUIqDrOEeZcZlQLUJe6V3ieJuFKuFISkqoVP
        aFvfpX+/8VUmro+Okb+I0hc=
X-Google-Smtp-Source: ABdhPJyEJ8yHmRhG5rBMwXHXYAHKMAwjdAhqOfNHguOBLZjVoCrmkuf7G/MW+zXsWCSaMhQB7WqVgA==
X-Received: by 2002:a17:903:290:b0:15c:1c87:e66c with SMTP id j16-20020a170903029000b0015c1c87e66cmr28402806plr.61.1651086070650;
        Wed, 27 Apr 2022 12:01:10 -0700 (PDT)
Received: from makvihas.localhost.com ([2405:201:202b:15:e0d6:603e:265d:6bf])
        by smtp.gmail.com with ESMTPSA id w129-20020a628287000000b0050d4246fbedsm11349661pfd.187.2022.04.27.12.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 12:01:10 -0700 (PDT)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH] staging: r8188eu: remove unused semaphore "allrxreturnevt"
Date:   Thu, 28 Apr 2022 00:30:54 +0530
Message-Id: <20220427190054.17841-1-makvihas@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        NO_RDNS_DOTCOM_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The semaphore allrxreturnevt of struct recv_priv is initialized but not 
used anywhere in the code.
Remove the initialization and the structure member.

Signed-off-by: Vihas Makwana <makvihas@gmail.com>
---
 Compile tested only.

 drivers/staging/r8188eu/core/rtw_recv.c    | 2 --
 drivers/staging/r8188eu/include/rtw_recv.h | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index c1005ddaa..4060c0457 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -80,8 +80,6 @@ int _rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter)
 	}
 	precvpriv->rx_pending_cnt = 1;
 
-	sema_init(&precvpriv->allrxreturnevt, 0);
-
 	res = rtl8188eu_init_recv_priv(padapter);
 
 	timer_setup(&precvpriv->signal_stat_timer, rtw_signal_stat_timer_hdl, 0);
diff --git a/drivers/staging/r8188eu/include/rtw_recv.h b/drivers/staging/r8188eu/include/rtw_recv.h
index e57e48a51..66d240a71 100644
--- a/drivers/staging/r8188eu/include/rtw_recv.h
+++ b/drivers/staging/r8188eu/include/rtw_recv.h
@@ -166,7 +166,6 @@ struct recv_priv {
 	uint  rx_largepacket_crcerr;
 	uint  rx_smallpacket_crcerr;
 	uint  rx_middlepacket_crcerr;
-	struct semaphore allrxreturnevt;
 	u8	rx_pending_cnt;
 
 	struct tasklet_struct recv_tasklet;
-- 
2.30.2

