Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C625347959D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 21:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240886AbhLQUnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 15:43:09 -0500
Received: from whuk3.redbackinternet.net ([109.203.107.222]:55078 "EHLO
        whuk3.redbackinternet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240846AbhLQUnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 15:43:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=fbautosys.co.uk; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xfDM7Zoh3k2w7pboTuXYaSG72r1f0Jq/VzTvWlPVZHE=; b=cEoIWVeJ76YZj/JyGcSsluA0rX
        l3UkYPHFQJxYKursK8HjEz9IdUVXJzColrqlXhThnHl+/lngp8atVfmN7FSm2bPRWm3ejiJftwpLP
        +QDkTxtOa9IbRVw5WgInca5bf1KO0+8EguIiX1MAXVTNjfed+/jMz1i2yBXrxfbGK96ugo2c9slU7
        4+E1mzQl4GzV14LFj7G2QLL/nnP5Xc3znEpysF6gTBnYJsUrcW68ZrjXuJ1GDb0OnT5gIiqvwuhpR
        kAgRG7ysVnuK2XcVZduFutWw0O8BXLzDUwEyijfc0bMhdbgA/mHGZH6doM/QGAZxypjN4KsnumlDo
        E2dkgmig==;
Received: from 24.54.187.81.in-addr.arpa ([81.187.54.24]:28253 helo=kernelcomp.corp.firebladeautomationsystems.co.uk)
        by whuk3.redbackinternet.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <linuxkernel@fbautosys.co.uk>)
        id 1myJgO-0001AJ-7D; Fri, 17 Dec 2021 20:18:24 +0000
From:   linuxkernel@fbautosys.co.uk
To:     linux-kernel@vger.kernel.org
Cc:     broonie@kernel.org
Subject: [RFC PATCH 4/5] Add Parity Calculation to formatted write
Date:   Fri, 17 Dec 2021 20:17:57 +0000
Message-Id: <20211217201758.1743750-5-linuxkernel@fbautosys.co.uk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211217201758.1743750-1-linuxkernel@fbautosys.co.uk>
References: <20211217201758.1743750-1-linuxkernel@fbautosys.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - whuk3.redbackinternet.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - fbautosys.co.uk
X-Get-Message-Sender-Via: whuk3.redbackinternet.net: authenticated_id: linuxkernel@fbautosys.co.uk
X-Authenticated-Sender: whuk3.redbackinternet.net: linuxkernel@fbautosys.co.uk
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christopher Tyerman <c.tyerman@firebladeautomationsystems.co.uk>

Altered formated write to set parity bit according to parity_write_mask

	modified:   drivers/base/regmap/regmap.c

Signed-off-by: Christopher Tyerman <c.tyerman@firebladeautomationsystems.co.uk>
---
 drivers/base/regmap/regmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index ec91eff52465..ea1664fa4c60 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1967,6 +1967,10 @@ static int _regmap_bus_formatted_write(void *context, unsigned int reg,
 	regmap_set_work_buf_flag_mask(map, map->format.reg_bytes,
 					      map->write_flag_mask);
 
+	regmap_set_work_buf_parity_mask(map, map->format.reg_bytes,
+						map->parity_write_mask, map->write_flag_mask, reg,
+						&val, sizeof(val));
+
 	trace_regmap_hw_write_start(map, reg, 1);
 
 	ret = map->bus->write(map->bus_context, map->work_buf,
-- 
2.25.1

