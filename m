Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D705C4A647E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 20:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240764AbiBATBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 14:01:41 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:52062 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242227AbiBATBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 14:01:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDDEF61615;
        Tue,  1 Feb 2022 19:01:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 683C7C340F1;
        Tue,  1 Feb 2022 19:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643742097;
        bh=I5Ksu7TSv5OlmgMa0WaJLxD3mrYm2dJm/MON3Czbzb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jQ82qm84m11Nng41jofXckgW27OfA/w2Hm4edQErKgZLb4z6UpZyBy+n5cVpzibpp
         Abi8XyCVEp2+PtlRd+6iNXAh9Yvs9mQjFJcnANc9zg/XJVm7BcFu60Ga68e0YiZ/Xi
         ngxXYR5CsuKYtPtG0lr+hvr5D+s5ZbFCe6/STaqkdtEnqyzdxPP5A3tk1sFZOuUdXv
         Cke9uxy8QG9Fm8Tkeyw+HUQdaPc+DoZvrdE0oQN/K5jfvjdm/3kWUQwA99uaUJqL5E
         6hczOpd6kOuAYY5gmz0QKjT1Wx5Vu0pixs4oHmuqrDS6Gzg49FiAJ4uNa03yKrfgMx
         bCm5frnH6HIgQ==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
        colyli@suse.de, Keith Busch <kbusch@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCHv2 5/7] asm-generic: introduce be48 unaligned accessors
Date:   Tue,  1 Feb 2022 11:01:26 -0800
Message-Id: <20220201190128.3075065-6-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20220201190128.3075065-1-kbusch@kernel.org>
References: <20220201190128.3075065-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NVMe protocol extended the data integrity fields with unaligned
48-bit reference tags. Provide some helper accessors in
preparation for these.

Acked-by: Arnd Bergmann <arnd@arndb.de>
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

