Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3499C55804A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 18:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbiFWQs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 12:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbiFWQrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 12:47:14 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DAE448E74;
        Thu, 23 Jun 2022 09:47:13 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k22so22336533wrd.6;
        Thu, 23 Jun 2022 09:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LoGByHoinwWKmK7sKKr5zQ+TOBzY+lDROmS+zPuNPuQ=;
        b=qb+HzyVV6rzz0uzZEAwhfY2wMX1sIDClwtbrpGTwx5r6PcFBeSY3Xkh3ea0Rkz4woU
         t7qi7aUVfcTiLHzjvMIiBoFebHIbnLCcWqSq6RofKoNLiu+oKzb74oZrPVo0X1VWUOOH
         Ooqsxh9ArStzoR5aOb2jrFgP82FAVCRmz4FzY1Mqtn8hWTozzo5iR9WnmGGuIpWcpS5t
         GA80Y5Hoq3SPwXReg66RGRIPjonKyoBRYC5Ft6pGfn1fRXFstkm83vmlN2NcetW8bGM3
         3ooNGpzLWVS/WObq54t/yKiElB/Hv7bRMH7pixGq+1nkNSulMyJG+6YgoJsDQ0uFU6ZK
         h6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LoGByHoinwWKmK7sKKr5zQ+TOBzY+lDROmS+zPuNPuQ=;
        b=W+m3M0/ln0api/sn3MBvEmoyYk6DZzOv5lv/o/fKN1LX1V0+m12rTwbF4MyGSqYyIl
         L2ZrMK4J4wQ+tGbh4KomTrivL63qSYuMuJwJIlhdWDIpuce96VG2ZFBZugngacGh51Ww
         PxMm5+t1LQLPCzVP55c/OjL/RXNBi5U4BfGzGK1hgxlnFkyt+R37W3WS8mTcmUXab7P3
         PGSDgVKbM97KWGm7EsSRLg7TjP9IVW5F44tzUihQ9nJ+hW56BDV6iNesRPLdsr2Zpzkj
         0cbS5olaM7udAsFTAnX7TIwuj02MsDAmik3QihteodtwP2DtmOVu/SN+vDQ4vmpF/hHJ
         1KLw==
X-Gm-Message-State: AJIora8GcZFF4Opg9ChRIjXwFzKh9dJ5Oq+/0XEqmazEkPH231kIsS7Q
        Nzn9U45oA6Yw0xu7okrr1OQ=
X-Google-Smtp-Source: AGRyM1tPybK6ZDZa9VdKMulI3WNE9tB5TDYMgoeNQAhJ5kJav+ER8mtHt/DBUyR6iX6ft1HyFReJEA==
X-Received: by 2002:a5d:64aa:0:b0:218:4287:3c98 with SMTP id m10-20020a5d64aa000000b0021842873c98mr9084399wrp.453.1656002831560;
        Thu, 23 Jun 2022 09:47:11 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id o1-20020adfeac1000000b0021b8c554196sm13786318wrn.29.2022.06.23.09.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 09:47:10 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Hannes Reinecke <hare@suse.de>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: fcoe: remove redundant assignment to variable wlen
Date:   Thu, 23 Jun 2022 17:47:10 +0100
Message-Id: <20220623164710.76831-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Variable wlen is being assigned a value that is never read, it is
being re-assigned with a different value later on. The assignment
is redundant and can be removed.

Cleans up clang scan build warning:
drivers/scsi/fcoe/fcoe.c:1491:2: warning: Value stored to 'wlen'
is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/scsi/fcoe/fcoe.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/fcoe/fcoe.c b/drivers/scsi/fcoe/fcoe.c
index c2a59109857a..6ec296321ffc 100644
--- a/drivers/scsi/fcoe/fcoe.c
+++ b/drivers/scsi/fcoe/fcoe.c
@@ -1488,7 +1488,6 @@ static int fcoe_xmit(struct fc_lport *lport, struct fc_frame *fp)
 
 	fh = fc_frame_header_get(fp);
 	skb = fp_skb(fp);
-	wlen = skb->len / FCOE_WORD_TO_BYTE;
 
 	if (!lport->link_up) {
 		kfree_skb(skb);
-- 
2.35.3

