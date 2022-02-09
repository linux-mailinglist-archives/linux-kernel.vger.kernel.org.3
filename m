Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616984AE85D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 05:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347124AbiBIEJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 23:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344537AbiBID1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 22:27:15 -0500
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF2BC061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 19:27:13 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1644377232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9YwsFwtEcmjTi9CsSJ4k8hjx9mqr5i/yrmHmuczKgmU=;
        b=tuX5hphIy3FFGOukx8I0voHwS0fJuzeS+KDfFy4dcjEEPXfnhgmhX5UKeSqRhtf8Zlz8RE
        WMTOdh8fAfRxWvrc+Df5TiNNZvZx1mb2ea5gKpsjq08QlJz8Gr8MVzcIJCg1VpVSPz9eie
        GsdzzPBSDZjljXxTQfsrDqDqDm354SY=
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     cai.huoqing@linux.dev
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: most: net: Make use of the helper macro LIST_HEAD()
Date:   Wed,  9 Feb 2022 11:26:43 +0800
Message-Id: <20220209032645.38305-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,TO_EQ_FM_DIRECT_MX,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace "struct list_head head = LIST_HEAD_INIT(head)" with
"LIST_HEAD(head)" to simplify the code.

Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
---
 drivers/staging/most/net/net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/most/net/net.c b/drivers/staging/most/net/net.c
index 47039f0d262f..1d1fe8bff7ee 100644
--- a/drivers/staging/most/net/net.c
+++ b/drivers/staging/most/net/net.c
@@ -67,7 +67,7 @@ struct net_dev_context {
 	struct list_head list;
 };
 
-static struct list_head net_devices = LIST_HEAD_INIT(net_devices);
+static LIST_HEAD(net_devices);
 static DEFINE_MUTEX(probe_disc_mt); /* ch->linked = true, most_nd_open */
 static DEFINE_SPINLOCK(list_lock); /* list_head, ch->linked = false, dev_hold */
 static struct most_component comp;
-- 
2.25.1

