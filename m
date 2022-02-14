Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C55E4B4358
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 09:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241601AbiBNIMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 03:12:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238522AbiBNIMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 03:12:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F26C6C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 00:12:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93E1761216
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:12:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17CBAC340E9;
        Mon, 14 Feb 2022 08:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644826335;
        bh=03Gzq0rrgUO8Mmaw7BUr+G8mCoEj93IZWAUJQNZeXT0=;
        h=From:To:Cc:Subject:Date:From;
        b=kmt/eZGv/+CC2+/Y3OPdDqLaE65Y+hNvtPGSnICwwrd66fZOb8bpV4RIhywocvdOE
         t0SVNKdaQ2igIIov755E4itrGj6TbF237BeILXpCk74qTwiOEvzGvaE5Fs05cPDxyC
         fNT6swEQPfHo1CpVOPyQ+8xHkZOdoiGSmCys1SHRsEUYJrSdwbVlH0fZPifPzzFIHK
         YMScB6EvbOYP16TjyqPtrB7FylBhuKmc0Nds0Lof1iKv38JgUnX13nqjW62R+seM6+
         6RDDzJirctVydoTRiSEHjR+KXpwrRFZwjUro5huCrd35dwArG/yZ0T2YK472bv/NHp
         B2Svxj/w2QSOA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 1/2] habanalabs: avoid using an uninitialized variable
Date:   Mon, 14 Feb 2022 10:12:09 +0200
Message-Id: <20220214081210.3999831-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

Fix the following compilation warning in
hl_cb_ioctl() @ command_buffer.c:
warning: ‘device_va’ may be used uninitialized in this function

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/command_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/command_buffer.c b/drivers/misc/habanalabs/common/command_buffer.c
index b9483a3cee91..a507110f6443 100644
--- a/drivers/misc/habanalabs/common/command_buffer.c
+++ b/drivers/misc/habanalabs/common/command_buffer.c
@@ -424,8 +424,8 @@ int hl_cb_ioctl(struct hl_fpriv *hpriv, void *data)
 {
 	union hl_cb_args *args = data;
 	struct hl_device *hdev = hpriv->hdev;
+	u64 handle = 0, device_va = 0;
 	enum hl_device_status status;
-	u64 handle = 0, device_va;
 	u32 usage_cnt = 0;
 	int rc;
 
-- 
2.25.1

