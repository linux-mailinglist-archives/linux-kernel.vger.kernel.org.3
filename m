Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA085650D8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbiGDJau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233723AbiGDJaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:30:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDE9103D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 02:30:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E33AB80E03
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 09:30:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A22DC341CA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 09:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656927000;
        bh=Sv9TRzkv9C7vB1sjK/Rn4qpYK2yNxXClybsYASyoaJ8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ir8R7eIbh5G5droVwU/OnEsuByxVkP28ESA7A+8/Vc/htoXiZjLFW6PzNCbRVby4S
         z3puwV1g1Ltib0KFTYszQf/Bu0mPKVqoV/3wh+52ohIe6mlTRS46FNIgva5eckw8Bd
         AWpkOkPOJcBazrxMmhMwLWh3N2Qj1ebiGQBwA4ZUnx9m6DPscC8/Fuu/Jp++9TQkJy
         KT1JqGtWsmUEoKCwmbBPxyxbqzDmNHFnm3GZI5iLb7HZ2R46pkd1cs7+Z3UzhVFfc9
         wiowciPdAWP6F5M0iCslqUxgRmXd38sr3D2AOEzphzsPnvm4N/XUkM6sAA0YtnZD3X
         GlclnnBe6baUA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 11/12] habanalabs: make sure variable is set before used
Date:   Mon,  4 Jul 2022 12:29:40 +0300
Message-Id: <20220704092941.2237683-11-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220704092941.2237683-1-ogabbay@kernel.org>
References: <20220704092941.2237683-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

timestamp could be unset in both _hl_interrupt_wait_ioctl() and
_hl_interrupt_wait_ioctl_user_addr() so it is better to explicitly
initialize it to 0 when declaring it.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/command_submission.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 941f1ff190ae..90a4574cbe2d 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -3345,8 +3345,8 @@ static int hl_interrupt_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 	struct hl_user_interrupt *interrupt;
 	union hl_wait_cs_args *args = data;
 	u32 status = HL_WAIT_CS_STATUS_BUSY;
+	u64 timestamp = 0;
 	int rc, int_idx;
-	u64 timestamp;
 
 	prop = &hdev->asic_prop;
 
-- 
2.25.1

