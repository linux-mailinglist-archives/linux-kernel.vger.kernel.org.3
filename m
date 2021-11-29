Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 301944611D3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 11:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352269AbhK2KL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 05:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237431AbhK2KJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 05:09:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5ACBC0698CA;
        Mon, 29 Nov 2021 01:47:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3105B80E29;
        Mon, 29 Nov 2021 09:47:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E90C53FCF;
        Mon, 29 Nov 2021 09:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638179276;
        bh=rzDLCKSxsaxbNkqeAch3s8qyQjDd6iwHRnT2T+rfJhg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tbxD8oa5Sg6I8rmBkL1nzKCY+Z87YxDK1bnmirgGiJEY2oJspfGWfpNzs+Y0hzyqo
         ET0hwq9SmZL2t3f5bK9NX6nz0TMxYX3vJzn8dykWZnvEZSUYvP2KpLEW7noAYb1s/F
         v15Yol4e9CJ20HMB7w/zHhDi9mxgZnOwDTOg5+o13VBcIW6dErEKTtTREpqhZOKNkv
         QyDxCN7/tgobF+UC8v2H+BF22563JGFnu5Igd44nZib/l1EOdHdxZLsotNEfJjaPGk
         5bMdeZLQ7iIWsfWPlLt16jgxFG5KYXLssqFgNETy4q/EtMvNRUkvTYdjc9pFXmHihO
         FklT4Naj5t4NQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mrdGM-000RB2-7U; Mon, 29 Nov 2021 10:47:54 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 03/20] media: davinci: get rid of an unused function
Date:   Mon, 29 Nov 2021 10:47:35 +0100
Message-Id: <7447911ef26de9ac73265df6aee306fbe59691a0.1638179135.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1638179135.git.mchehab+huawei@kernel.org>
References: <cover.1638179135.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vpif_get_default_field() seems to be some left-over from a
past code that sets the field order.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH v2 00/20] at: https://lore.kernel.org/all/cover.1638179135.git.mchehab+huawei@kernel.org/

 drivers/media/platform/davinci/vpif_capture.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/media/platform/davinci/vpif_capture.c b/drivers/media/platform/davinci/vpif_capture.c
index ae92e2c206d0..aba105fa7ef9 100644
--- a/drivers/media/platform/davinci/vpif_capture.c
+++ b/drivers/media/platform/davinci/vpif_capture.c
@@ -618,17 +618,6 @@ static void vpif_calculate_offsets(struct channel_obj *ch)
 	ch->vpifparams.video_params.stdid = vpifparams->std_info.stdid;
 }
 
-/**
- * vpif_get_default_field() - Get default field type based on interface
- * @iface: ptr to vpif interface
- */
-static inline enum v4l2_field vpif_get_default_field(
-				struct vpif_interface *iface)
-{
-	return (iface->if_type == VPIF_IF_RAW_BAYER) ? V4L2_FIELD_NONE :
-						V4L2_FIELD_INTERLACED;
-}
-
 /**
  * vpif_config_addr() - function to configure buffer address in vpif
  * @ch: channel ptr
-- 
2.33.1

