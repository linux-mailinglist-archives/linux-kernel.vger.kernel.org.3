Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E18B6462ED5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 09:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239775AbhK3Iub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 03:50:31 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:55654 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239770AbhK3IuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 03:50:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 78D40CE1828;
        Tue, 30 Nov 2021 08:47:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A3FC53FC1;
        Tue, 30 Nov 2021 08:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638262021;
        bh=sKKgJm4IeJL19jVxGxafCC/+cpVZuuY5RM3ezPC40jo=;
        h=From:To:Cc:Subject:Date:From;
        b=byeOI0EMHN3rkdANUi0cCgpOHafWsUBW7mDP+rX7yVje97Jl38E+FhzzpiQZLHrpl
         LHqd+c0n99kjDbOCPdDp+oP08/R6o+328OuSp9mbi04WTCgo8o66gzDB4iazYRGcdG
         9p6w/ZfUPjQnys/bRgUDvpLNVlqSX41N7Y1Eg0kg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     tim@cyberelk.net, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] paride: fix up build warning on mips platforms
Date:   Tue, 30 Nov 2021 09:46:26 +0100
Message-Id: <20211130084626.3215987-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=861; h=from:subject; bh=sKKgJm4IeJL19jVxGxafCC/+cpVZuuY5RM3ezPC40jo=; b=owGbwMvMwCRo6H6F97bub03G02pJDIlLn9yPO6wUdO3CzAl3q6Rqbr15tVinImOj+ndVvUU1LFV3 P75V6IhlYRBkYpAVU2T5so3n6P6KQ4pehranYeawMoEMYeDiFICJhEYyzNM51+y9RyBk3u6ARzf8q8 8Vr727zI1hnkFDjPZ2/jvxpe90PE92HvzakeuWBgA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MIPS include files define "PC" so when building the paride driver the
following build warning shows up:

	rivers/block/paride/bpck.c:32: warning: "PC" redefined

Fix this by undefining PC before redefining it as is done for other
defines in this driver.

Cc: Tim Waugh <tim@cyberelk.net>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/paride/bpck.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/paride/bpck.c b/drivers/block/paride/bpck.c
index f5f63ca2889d..d880a9465e9b 100644
--- a/drivers/block/paride/bpck.c
+++ b/drivers/block/paride/bpck.c
@@ -28,6 +28,7 @@
 
 #undef r2
 #undef w2
+#undef PC
 
 #define PC			pi->private
 #define r2()			(PC=(in_p(2) & 0xff))
-- 
2.34.1

