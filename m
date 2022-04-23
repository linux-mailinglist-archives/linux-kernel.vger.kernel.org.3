Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC79C50CA4E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 15:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235646AbiDWNF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 09:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235633AbiDWNFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 09:05:19 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73151F0419
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 06:02:21 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id c1so3977594pfo.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 06:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=idFLEuhhRBrIFoG+4fgFrk263hwBaKFKAvkJX1uSpV4=;
        b=CLTrwpUjDt+EKT+A/MFKftljZ9OzVlZE2pp2sby4IndormmslmJ5PLAJN0UOFDtsEM
         Npa1g78QMW3mZXiJPRcPffpGQ0b0kutjXFtRLwM1+aDJzN8IY0EcFeRHrm733GGxL9Lh
         /JrljX9pSLx0N6TYE9pvD64LrOH+nTRea4kah5f0wuBJ9yk5+sDmfGXOVW5ZVNrEtiBA
         icbEtpH+QSgeiUzPFdJz8WCXTGTsZ2dF9Q2jLqoSt5f7QmCtYfTVCRxz8UwVoVLtaSGi
         xYempN0Y0tFejWmxD69oF0aKJMcT8M0Bak9JPyLLr/xPiLPaFrQe2kIJz+rAaql98T+7
         ztAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=idFLEuhhRBrIFoG+4fgFrk263hwBaKFKAvkJX1uSpV4=;
        b=AVvLjJXbDfbm8dG/TgJ2xGg4iNNVNqrKQnsUZghP35sWY9mLIXR1+zfCa/+k1RMEGY
         ie1Sf7QjgcchKC4j99yqQHDELLEuj6B3Zc7yxcC6dKoN4/EUQeeaJZHAVrn6gKaf/G1R
         TTD4bymNtmuMY40iApDP52GxA+arQlc4BW0TpYBmCIytjO4z+Pt6ajZhwcA/MH8EGn+6
         hyUb87d2RJw83s7IPsQ0AnepfXdpLwP2yhJuf1GRXvBj87Ou7phLbrdz8y4egiyx/ylM
         2bbsCtwX8U4Ohw98goY91f7Li2UY96lU/krqmXYlRfgH+6czSsh/qONp4UnBRECX3vtM
         3sCQ==
X-Gm-Message-State: AOAM533y1EtUgChD1ZG1qsP7qJVRoLo3ceN8ls8oMrejHNdi6PX+3Sug
        Mg+zcTJXu5hjKhLs/un+cH1MPS7cvmFv2w==
X-Google-Smtp-Source: ABdhPJwTT7gagDiYTgzLspQB+d5xn7GjsnscQCajwVcnKJALZvPy3m2pmp1QV5tQ7VYSXk31mXQYFQ==
X-Received: by 2002:a05:6a00:a0e:b0:4fd:fa6e:95fc with SMTP id p14-20020a056a000a0e00b004fdfa6e95fcmr10043915pfh.17.1650718941187;
        Sat, 23 Apr 2022 06:02:21 -0700 (PDT)
Received: from localhost.localdomain ([14.100.36.163])
        by smtp.gmail.com with ESMTPSA id c139-20020a624e91000000b005060cdff4ffsm5808994pfb.129.2022.04.23.06.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 06:02:20 -0700 (PDT)
From:   Solomon Tan <wjsota@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com
Subject: [PATCH 4/7] staging: rtl8192e: Remove unnecessary u16 assignment cast
Date:   Sat, 23 Apr 2022 21:01:47 +0800
Message-Id: <20220423130150.161903-5-wjsota@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220423130150.161903-1-wjsota@gmail.com>
References: <20220423130150.161903-1-wjsota@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the explicit casts in assignment statements for u16 variables.
Because these variables are declared as u16, there is implicit
conversion to u16 during the assignment, so an explicit cast is
unnecessary.

Signed-off-by: Solomon Tan <wjsota@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c | 2 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c    | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c
index c5e44bbe997c..cd8bbc358d01 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c
@@ -58,7 +58,7 @@ bool rtl92e_send_cmd_pkt(struct net_device *dev, u32 type, const void *data,
 			memset(pTxFwInfo, 0, sizeof(struct tx_fwinfo_8190pci));
 			memset(pTxFwInfo, 0x12, 8);
 		} else {
-			tcb_desc->txbuf_size = (u16)frag_length;
+			tcb_desc->txbuf_size = frag_length;
 		}
 
 		seg_ptr = skb_put(skb, frag_length);
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index b608540c036c..feddb15bccbe 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1225,7 +1225,7 @@ void  rtl92e_fill_tx_desc(struct net_device *dev, struct tx_desc *pdesc,
 	pdesc->LINIP = 0;
 	pdesc->CmdInit = 1;
 	pdesc->Offset = sizeof(struct tx_fwinfo_8190pci) + 8;
-	pdesc->PktSize = (u16)skb->len-sizeof(struct tx_fwinfo_8190pci);
+	pdesc->PktSize = skb->len - sizeof(struct tx_fwinfo_8190pci);
 
 	pdesc->SecCAMID = 0;
 	pdesc->RATid = cb_desc->RATRIndex;
@@ -1298,8 +1298,7 @@ void  rtl92e_fill_tx_cmd_desc(struct net_device *dev, struct tx_desc_cmd *entry,
 
 		entry_tmp->CmdInit = DESC_PACKET_TYPE_NORMAL;
 		entry_tmp->Offset = sizeof(struct tx_fwinfo_8190pci) + 8;
-		entry_tmp->PktSize = (u16)(cb_desc->pkt_size +
-				      entry_tmp->Offset);
+		entry_tmp->PktSize = cb_desc->pkt_size + entry_tmp->Offset;
 		entry_tmp->QueueSelect = QSLT_CMD;
 		entry_tmp->TxFWInfoSize = 0x08;
 		entry_tmp->RATid = DESC_PACKET_TYPE_INIT;
-- 
2.36.0

