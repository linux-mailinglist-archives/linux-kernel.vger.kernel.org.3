Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C3C47B44E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 21:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbhLTUZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 15:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhLTUZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 15:25:29 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723C1C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 12:25:29 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id j6so22437160edw.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 12:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2AYLI7JdI7TbMwlaYryTUxSOZm+WGuEnbMb6+8ROGO4=;
        b=Fnvq83+DsdfkVRSWhjEyhen1P7OhEyRFkwlKmJG3NrTis1dNBb6to4Sfn8+1TUPXzU
         Dz6FGj43pmiLx3wO9RgIijSOto5BUFBq6W5Te9HIBgQIsdd1A495IAeC57RayheM65y4
         cBzGxP1tEJxXhpKzFmlr6dcr6ErN5qkEaFhIUOXAyRDXFTN3yyuTh2gBJ5+JghBJO/6U
         mxF0HF6MIF5QB/TOYJtRdD4Imdmwhh/XqenKfTejRLMQpM3H7TqQQ16KMKNoTQlE+2pz
         14fcbQGRf6lY7ZeVUmippQ5kjB4eGH1d8Utt528KmWqLKH9XUYJTslI+DNvHxCdP/yCm
         Hhig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2AYLI7JdI7TbMwlaYryTUxSOZm+WGuEnbMb6+8ROGO4=;
        b=aSHwQHvH4uGj57j4xaiI/Uu7wx9Gt983CUhLmzmtguN363XSPKFBh3qfqPC+wUai8r
         vFHZCNqBFuXt19lQJ4vl1s05VtjpFvdp4J3C0S6VqMdeuc3tqU+lMRvi5DVgZkXB4Xnb
         RN8XC60GR9UV/hFUsw1GPKsuTHMNM7dcp2U4J0TCm9d64v3LYECyMTwKGZk+52TsgJDG
         bdzSKHFIzWxT304UhbWb9vx9cC92QjHxA1CXnXIGSpptXfeyZGdTA+ZtkiOH20Kmqjog
         7gv1Gxbuygu4XEFpSjMWiTXsHEuCINBShDT1n6pADCHIkw6u5LfuqWkJ7JTSuVhoFxht
         1KhQ==
X-Gm-Message-State: AOAM531pazLpWNbBHyTPqTCXIvt9JYdq5quPsRNLALfH3IQlHVkWCJmh
        cT+Mc4fMSo4xrkiWPqReW34=
X-Google-Smtp-Source: ABdhPJzDmYaOTUfFDV/rudT38TnvrnSN7mvowKXpxM4hKADww7K7BbIp+GIEo/E7ZI9cn0hSlEgGDA==
X-Received: by 2002:a17:907:60c9:: with SMTP id hv9mr5154325ejc.681.1640031928052;
        Mon, 20 Dec 2021 12:25:28 -0800 (PST)
Received: from tom-desktop.station (net-93-151-129-173.cust.dsl.teletu.it. [93.151.129.173])
        by smtp.gmail.com with ESMTPSA id ji16sm135681ejc.114.2021.12.20.12.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 12:25:27 -0800 (PST)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     tomm.merciai@gmail.com, linuxfancy@googlegroups.com,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        =?UTF-8?q?Aldas=20Tara=C5=A1kevi=C4=8Dius?= <aldas60@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: vt6655: drop off byRxMode var in device.h
Date:   Mon, 20 Dec 2021 21:25:20 +0100
Message-Id: <20211220202523.21805-1-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop off unused variable byRxMode in device.h, this fix following
checkpatch.pl check:
CHECK: Avoid CamelCase: <byRxMode>
131: FILE: drivers/staging/vt6655/device.h:131:
unsigned char byRxMode

Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
---
Changes since v1:
 - Remove trailing whitespace in changelog as suggested by gregkh

 drivers/staging/vt6655/device.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
index 4706bde1ec1d..84b1dcf80e47 100644
--- a/drivers/staging/vt6655/device.h
+++ b/drivers/staging/vt6655/device.h
@@ -128,8 +128,6 @@ struct vnt_private {
 	u32                         memaddr;
 	u32                         ioaddr;
 
-	unsigned char byRxMode;
-
 	spinlock_t                  lock;
 
 	volatile int                iTDUsed[TYPE_MAXTD];
-- 
2.25.1

