Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3EDB5466ED
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 14:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345556AbiFJMww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 08:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345181AbiFJMwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 08:52:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A6144A16;
        Fri, 10 Jun 2022 05:52:44 -0700 (PDT)
Received: from whitebuilder.lan (192-222-136-102.qc.cable.ebox.net [192.222.136.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C48896601725;
        Fri, 10 Jun 2022 13:52:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654865563;
        bh=7hV4k2F2AcwF7i/toKo78FMa4mcKD+wvplQQ+zerGAg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gq+TSIpE7muF4e0VQ6gm9IBeHKeRk0p3UvL5q8/Hlw9KWXcr7fUnvdTyTxFscEY+h
         VadP8dTrHK0TvHj54DRwY/RfeE7XBYLAc4YgxqYZCqtvPuEBynUaDB/U2u1xAnv1IS
         BVQS31NtpUKWncLgIz5jstZLchQiG48exFZRnsZwzVjmI7S7W5Pru6pJTowxdG4vwz
         xEklqbHFWn039wGSNs9T6hATco5bsadsz4t3iE24I04bqo7wQFAHzwcEFC8cbaghjn
         WyPqHaEMfj3qsgJ4RV6hxFVFGyBxf/dvw23Ndg9MGuKrbOsVE0c22xJ0EoaFXZxgJG
         IGBYApMmLN67A==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     linux-media@vger.kernel.org,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        kernel@collabora.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/5] media: rkvdec: Fix RKVDEC_ERR_PKT_NUM macro
Date:   Fri, 10 Jun 2022 08:52:13 -0400
Message-Id: <20220610125215.240539-4-nicolas.dufresne@collabora.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610125215.240539-1-nicolas.dufresne@collabora.com>
References: <20220610125215.240539-1-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This information is expressed by bits [29:16], but the actual
implementation was reading bits [13:0] and shifting that 16
bits to the left.

Fixes: cd33c830448ba ("media: rkvdec: Add the rkvdec driver")
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 drivers/staging/media/rkvdec/rkvdec-regs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/rkvdec/rkvdec-regs.h b/drivers/staging/media/rkvdec/rkvdec-regs.h
index 15b9bee92016..14530b81560e 100644
--- a/drivers/staging/media/rkvdec/rkvdec-regs.h
+++ b/drivers/staging/media/rkvdec/rkvdec-regs.h
@@ -212,7 +212,7 @@
 #define RKVDEC_REG_H264_ERRINFO_NUM			0x130
 #define RKVDEC_SLICEDEC_NUM(x)				((x) & 0x3fff)
 #define RKVDEC_STRMD_DECT_ERR_FLAG			BIT(15)
-#define RKVDEC_ERR_PKT_NUM(x)				(((x) & 0x3fff) << 16)
+#define RKVDEC_ERR_PKT_NUM(x)				((x >> 16) & 0x3fff)
 
 #define RKVDEC_REG_H264_ERR_E				0x134
 #define RKVDEC_H264_ERR_EN_HIGHBITS(x)			((x) & 0x3fffffff)
-- 
2.36.1

