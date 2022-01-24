Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5774498415
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243361AbiAXQBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243292AbiAXQBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:01:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACA6C06173B;
        Mon, 24 Jan 2022 08:01:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 848D6614DA;
        Mon, 24 Jan 2022 16:01:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA25C340E7;
        Mon, 24 Jan 2022 16:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643040074;
        bh=waUMKxOwOX7w/rUT+A2WgjAk79dSTHbN24muCUOw6W0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bezbq5R5pHJsZl3GebLs3aNaqcDKjTd0HyVtc87lJC68avnZgEHV0dCuzzusQ4Dq9
         EB+Nnw/8MMqDUYhLnyZAGyY8TMiVtY0en9T0PCQiJsvzI1jXXDFy5I95SMCzEYnYoN
         rp4fOLQrJaS2FbvwVGdVnpIDqVH/jka4dvEXjz2VQ3wnfm4UYFrRkv25NXxulWes09
         q2snLSzNedTqLVB6X1Zi7rIOvZS4G8EyUKorFV7Wgokk+U5Acd1dZWHi4HaT6XU+pN
         3Kp7tzWh6E7BmNYqP5vRuBwU1Tv8dbJI+ekH3nhKZNrq/odBrDTd7bCNHIzAjoa5pk
         Qq6h5MSnaXUGQ==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
        colyli@suse.de, arnd@arndb.de, Keith Busch <kbusch@kernel.org>
Subject: [RFC 5/7] asm-generic: introduce be48 unaligned accessors
Date:   Mon, 24 Jan 2022 08:01:05 -0800
Message-Id: <20220124160107.1683901-6-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20220124160107.1683901-1-kbusch@kernel.org>
References: <20220124160107.1683901-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NVMe protocol extended data integrity fields with unaligned 48-bit
reference tags. Provide some helper accessors in preparation for these.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/asm-generic/unaligned.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/asm-generic/unaligned.h b/include/asm-generic/unaligned.h
index 1c4242416c9f..8fc637379899 100644
--- a/include/asm-generic/unaligned.h
+++ b/include/asm-generic/unaligned.h
@@ -126,4 +126,30 @@ static inline void put_unaligned_le24(const u32 val, void *p)
 	__put_unaligned_le24(val, p);
 }
 
+static inline void __put_unaligned_be48(const u64 val, __u8 *p)
+{
+	*p++ = val >> 40;
+	*p++ = val >> 32;
+	*p++ = val >> 24;
+	*p++ = val >> 16;
+	*p++ = val >> 8;
+	*p++ = val;
+}
+
+static inline void put_unaligned_be48(const u64 val, void *p)
+{
+	__put_unaligned_be48(val, p);
+}
+
+static inline u64 __get_unaligned_be48(const u8 *p)
+{
+	return (u64)p[0] << 40 | (u64)p[1] << 32 | p[2] << 24 |
+		p[3] << 16 | p[4] << 8 | p[5];
+}
+
+static inline u64 get_unaligned_be48(const void *p)
+{
+	return __get_unaligned_be48(p);
+}
+
 #endif /* __ASM_GENERIC_UNALIGNED_H */
-- 
2.25.4

