Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D521557282
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 07:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiFWFPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 01:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiFWFOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 01:14:37 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39A8199
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 22:14:36 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id k14so5698710plh.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 22:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ls9hvwuUqtcL6CqYob/ByEfPEYjTHPxmgj5hdQsgzm4=;
        b=kyfmQSmCpsjYYdL7jn90nALrRXSCuqzIsFH3u2VRXfKfeCKSf7QIvbbq3cus2lYWd5
         8jvQ1JU+g1AcrYhHP7TgB5k2LO7jlQ6Gkt9oI/AKK5nfD307Uv7hkm1hVwQsNP0Ael8P
         P+nAYmmb+4MulutY3BZ/fLsAM1nrnfWJ2cbS3qdvUxKV+eXxigVxA7vQbjW6CjFpJpkB
         QI0KyfnoZOZEivz324whZRrj4bJxjzFZreYfV5SX5qkNlzaeYeWHreuoFvHpHVGhHmxJ
         nmuNOXEEONtBu2wtDUlPZJeVWNFdSc0/RDb9/rqJPVJq7IMG/75zSAZTd2fiXWiZW9i0
         uwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ls9hvwuUqtcL6CqYob/ByEfPEYjTHPxmgj5hdQsgzm4=;
        b=mDp6b0EYkq7MYjttRa7UTVjOZYG4U+vlHeyapLE43oloJTU4l0eHvsGUwTRC3Ywf2I
         +TS09Xq4WMzi8+DCUurS1UwOAtYcLSZd4IlCI34CdG3GUcZ4C8hW+Ll4IrS++Q7kPKj5
         OmHU31RcE8PHAn34VxZo46LkRXyllF02YlGuvSOim+qnuinfrwJ0e7BBAGsVYBx59Spe
         MF6xk8+sk25qD4J+uU3Ao5Uy8N+q7qb7mx8iagInD7bqRR+4vYYRoWW5JA/0mJ4BRNfB
         4gCvHkQjul/TT1pCjl5Pajnjr1AZ2Z1zv+tWqV1vQo3r1mqD+5ZSiDJGSMFIWm0eWGEn
         q3Pw==
X-Gm-Message-State: AJIora+ZW8R5qy/aLlhploecBwnej435x7J4y85qrQS1dnGCQvpHTN2y
        JU08UQMXCtwYzuVpziNXox8=
X-Google-Smtp-Source: AGRyM1uAxPHhfCJYCgRNEaq5XQtzwprlgYiOK6tmeNSOFsF0j8QXUgWcrmWLJtU8glJWlEDWMSrpzg==
X-Received: by 2002:a17:903:2347:b0:16a:33cd:5308 with SMTP id c7-20020a170903234700b0016a33cd5308mr13824497plh.122.1655961276305;
        Wed, 22 Jun 2022 22:14:36 -0700 (PDT)
Received: from localhost (c-67-180-87-133.hsd1.ca.comcast.net. [67.180.87.133])
        by smtp.gmail.com with ESMTPSA id w22-20020a1709026f1600b001676f87473fsm13735730plk.302.2022.06.22.22.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 22:14:35 -0700 (PDT)
From:   Chang Yu <marcus.yu.56@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Chang Yu <marcus.yu.56@gmail.com>
Subject: [PATCH v2] staging: r8188eu: combine nested if statements into one
Date:   Wed, 22 Jun 2022 22:14:04 -0700
Message-Id: <20220623051404.410632-1-marcus.yu.56@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220623031515.402691-1-marcus.yu.56@gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Combine two nested if statements into a single one

Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
---
Changes in v2:
Added a pair of parentheses to make operator precedence explicit.

 drivers/staging/r8188eu/core/rtw_recv.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 6564e82ddd66..020bc212532f 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -166,10 +166,8 @@ int rtw_free_recvframe(struct recv_frame *precvframe, struct __queue *pfree_recv
 
 	list_add_tail(&precvframe->list, get_list_head(pfree_recv_queue));
 
-	if (padapter) {
-		if (pfree_recv_queue == &precvpriv->free_recv_queue)
-				precvpriv->free_recvframe_cnt++;
-	}
+	if (padapter && (pfree_recv_queue == &precvpriv->free_recv_queue))
+		precvpriv->free_recvframe_cnt++;
 
 	spin_unlock_bh(&pfree_recv_queue->lock);
 
-- 
2.36.1

