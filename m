Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720D24BFECB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbiBVQdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234095AbiBVQcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:32:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37914BB091;
        Tue, 22 Feb 2022 08:32:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8CA860A2B;
        Tue, 22 Feb 2022 16:32:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 709A5C340F6;
        Tue, 22 Feb 2022 16:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645547543;
        bh=r/bd83ebHmk3oq087sNFUNNVtBRYLznJSmRLMlpTbUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GCSf5tRNML33gIhC3sIrrGWNIgk5kvVblmBu4I3xUoYSfiBZQ7ehJCYaFMnjgfYrh
         OEya2ydwEKX3H3fD0dwoZ6w+H+uVTnLvXdVh13m4ZYJeOwoVOR8FpM5mREFIghRXun
         Hbo1Vj+fgL7RwAtA8rRkuMSwCelOJIR8YWHIIT259xvZllYv4OVf9/3czpEuPPVy05
         LfWvNjQZxOLoyJOF48fW/B6VWOY4CLWhcn4SoZpbDixEkczclmp/n15F/B5+EtU2/C
         QIy+oT0tinibuGXLKZUog8+xSn83qCPVsd+HVtOq+tDiYftWhlgYVwby4IeweuNnAO
         rEhXiElbv4AFg==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
        colyli@suse.de, Keith Busch <kbusch@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCHv3 04/10] linux/kernel: introduce lower_48_bits macro
Date:   Tue, 22 Feb 2022 08:31:38 -0800
Message-Id: <20220222163144.1782447-5-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20220222163144.1782447-1-kbusch@kernel.org>
References: <20220222163144.1782447-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent data integrity field enhancements allow 48-bit reference tags.
Introduce a helper macro since this will be a repeated operation.

Suggested-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/linux/kernel.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 33f47a996513..c1fa9fc2b5cd 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -63,6 +63,12 @@
 }					\
 )
 
+/**
+ * lower_48_bits - return bits 0-47 of a number
+ * @n: the number we're accessing
+ */
+#define lower_48_bits(n) ((u64)((n) & 0xffffffffffffull))
+
 /**
  * upper_32_bits - return bits 32-63 of a number
  * @n: the number we're accessing
-- 
2.25.4

