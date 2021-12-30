Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B077D481B31
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 10:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238344AbhL3Jjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 04:39:42 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45530 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234584AbhL3Jjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 04:39:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A44E2B81B0F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 09:39:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61B3C36AE9;
        Thu, 30 Dec 2021 09:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640857179;
        bh=IuYX8FYuPvNqeoYeaP3HqgCl1qG7AnlbzSayGOaqZEM=;
        h=From:To:Cc:Subject:Date:From;
        b=jlSeKtbK8B4wLE5JSmQqdSMBJAxr1llkbVUu0NTP4vkIT6e+Hh+xQK792TrYWNhUD
         hhr7bv5vxN2Yx/Nz35Dt5SIRxmwz9ZTQAy9ZVw3fBf6q84EMOTqjoWouPtJ6WNWwPE
         US089zk0wlrxv4RBD9VG8nE2ND64BG7CACUqh9mA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH] firmware: remove old CONFIG_FW_LOADER_MODULE test
Date:   Thu, 30 Dec 2021 10:39:32 +0100
Message-Id: <20211230093932.2747587-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=963; h=from:subject; bh=IuYX8FYuPvNqeoYeaP3HqgCl1qG7AnlbzSayGOaqZEM=; b=owGbwMvMwCRo6H6F97bub03G02pJDIln6wKzoh1Pdc1tWGajFMeVc3Ca0EvGm/Y7hZk81lVOur35 m2JcRywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAEykKJdhwZr220tnfhJ+tUC1/6n/K7 3E51pcxxjmJyWEr3L44/ByrmrZ9SXTzA6qan+8DgA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CONFIG_FW_LOADER_MODULE check in firmware.h is very obsolete given
that this symbol went away decades ago, so it should be removed.

Reported-by: Borislav Petkov <bp@alien8.de>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/firmware.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/firmware.h b/include/linux/firmware.h
index 3b057dfc8284..0b1c4d9c5465 100644
--- a/include/linux/firmware.h
+++ b/include/linux/firmware.h
@@ -34,7 +34,7 @@ static inline bool firmware_request_builtin(struct firmware *fw,
 }
 #endif
 
-#if defined(CONFIG_FW_LOADER) || (defined(CONFIG_FW_LOADER_MODULE) && defined(MODULE))
+#if defined(CONFIG_FW_LOADER)
 int request_firmware(const struct firmware **fw, const char *name,
 		     struct device *device);
 int firmware_request_nowarn(const struct firmware **fw, const char *name,
-- 
2.34.1

