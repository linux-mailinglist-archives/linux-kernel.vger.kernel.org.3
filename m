Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981594AE862
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 05:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345236AbiBIEIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 23:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346335AbiBIDZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 22:25:20 -0500
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90527C061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 19:25:19 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1644377117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7zovqOcffeRe0mWCd/L89g+VpaojJDUdL7RhfRPn1rY=;
        b=TGawKcWR2FnR+bJKSghmE0pWFxvZFt2TYQ2bO5wk4LybtksVoRlpLJHA3UKHXcSGeihTJR
        oOfR/A4EBvXSZBuwhs8sY4sVRcDKqFSHjSsnW6UgScN2u/eFp83T2j/vPaWSDax3uimWet
        zJAcYKHJuQixdY8OAEZW0jm4aLWuqyw=
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     cai.huoqing@linux.dev
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/BSR: Make use of the helper macro LIST_HEAD()
Date:   Wed,  9 Feb 2022 11:24:50 +0800
Message-Id: <20220209032450.37849-1-cai.huoqing@linux.dev>
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
 drivers/char/bsr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/bsr.c b/drivers/char/bsr.c
index cce2af5df7b4..d5f943938427 100644
--- a/drivers/char/bsr.c
+++ b/drivers/char/bsr.c
@@ -60,7 +60,7 @@ struct bsr_dev {
 };
 
 static unsigned total_bsr_devs;
-static struct list_head bsr_devs = LIST_HEAD_INIT(bsr_devs);
+static LIST_HEAD(bsr_devs);
 static struct class *bsr_class;
 static int bsr_major;
 
-- 
2.25.1

