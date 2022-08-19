Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573A659A982
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 01:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241363AbiHSXe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 19:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235036AbiHSXey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 19:34:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A8DC57AC
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 16:34:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30FF1B829A5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 23:34:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB439C433C1;
        Fri, 19 Aug 2022 23:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660952090;
        bh=5ezpqGMtjmIlcfSdKrdvj+9d1jz13XFCn3MQZJe3L2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tIGK5iXthVEYiYngzWv9PQqoBnaTG2nDj/qhANbOUd4j19y0mree68y0HdkN6cJ0o
         4+rUAuS+E1IMutJyM/UHNGy7TNQHeo6MIB0TPq8NdYzn1jmbtREOeNP2QiaxqZ3EvN
         paNBVrHegaFvjRNojs4n/anzpesbyRpmuuaK1LYWgynBqYZBmlfsBH8U1UaR1ij8/s
         n9A6VTQpuyHu7XKPdIY3p+tt1GRyJ5ycPc6ryAHwbiD1jafKiBLxIdReavl+ADBQa/
         QfOpcBRw2CmNztTxrU3otHh2e9T91WpUw2fgRq/c/4WU8qoui+MXLrPnEQpXVsQVpb
         t8SJPiheooVLw==
Date:   Fri, 19 Aug 2022 16:34:48 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     stable@kernel.org
Subject: Re: [PATCH v2] f2fs: fix wrong continue condition in GC
Message-ID: <YwAeGIszLrcNqNbE@google.com>
References: <20220813143709.11909-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220813143709.11909-1-jaegeuk@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should decrease the frozen counter.

Cc: stable@kernel.org
Fixes: 325163e9892b ("f2fs: add gc_urgent_high_remaining sysfs node")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---

Change log from v1:
 - fix by refactoring the flow

 fs/f2fs/gc.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 6da21d405ce1..45f90e3c46d4 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -97,14 +97,10 @@ static int gc_thread_func(void *data)
 		 */
 		if (sbi->gc_mode == GC_URGENT_HIGH) {
 			spin_lock(&sbi->gc_urgent_high_lock);
-			if (sbi->gc_urgent_high_limited) {
-				if (!sbi->gc_urgent_high_remaining) {
-					sbi->gc_urgent_high_limited = false;
-					spin_unlock(&sbi->gc_urgent_high_lock);
-					sbi->gc_mode = GC_NORMAL;
-					continue;
-				}
-				sbi->gc_urgent_high_remaining--;
+			if (sbi->gc_urgent_high_limited &&
+					!sbi->gc_urgent_high_remaining--) {
+				sbi->gc_urgent_high_limited = false;
+				sbi->gc_mode = GC_NORMAL;
 			}
 			spin_unlock(&sbi->gc_urgent_high_lock);
 		}
-- 
2.37.1.595.g718a3a8f04-goog

