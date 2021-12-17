Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47567479746
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 23:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhLQWlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 17:41:22 -0500
Received: from whuk3.redbackinternet.net ([109.203.107.222]:41028 "EHLO
        whuk3.redbackinternet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbhLQWlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 17:41:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=fbautosys.co.uk; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=T090J5GWkAQucJQ7sL3rRUigyVw/j2wBxWDDYEUvlP0=; b=GZuaVUPPNh0I5IivBjYJYT3wSj
        5Cyku2R9pxx4BzbCrTr0VJFNcH7MnRDjJKChhx//LRlNPVOaI4JFteSDV6gU905c41zuN3a3WccQb
        JtNeT6DCqLSJ8LqEl/aUjPILBjkn8h43DrsF1lb4eFOUCuDOqDNfGzS8TzpwMv+08B+zBLkZBdghg
        a0MmYQ4slYfCRS2jA5+UCHtWMFJayP5YKvAabmy9Ab1PmmMH5LpAJEd7fmgRigG+raVOfmGZiM0h5
        wFyclmo2ux4S37oPLU7X9WYG6sU2jDLzUMqqFfHh4DUK5CJRQXJ7vBf7Lst61LlFajPG7LrcZYK2m
        kJpg5wCQ==;
Received: from 24.54.187.81.in-addr.arpa ([81.187.54.24]:25991 helo=kernelcomp.corp.firebladeautomationsystems.co.uk)
        by whuk3.redbackinternet.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <linuxkernel@fbautosys.co.uk>)
        id 1myLue-000Dto-U9; Fri, 17 Dec 2021 22:41:17 +0000
From:   linuxkernel@fbautosys.co.uk
To:     linux-kernel@vger.kernel.org
Cc:     broonie@kernel.org
Subject: [RFC PATCH 3/5] regmap: Added setting of writemap to formatted write
Date:   Fri, 17 Dec 2021 22:41:02 +0000
Message-Id: <20211217224104.1747758-4-linuxkernel@fbautosys.co.uk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211217224104.1747758-1-linuxkernel@fbautosys.co.uk>
References: <20211217224104.1747758-1-linuxkernel@fbautosys.co.uk>
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

Added regmap_set_work_buf_flag_mask to _regmap_bus_formatted_write
to ensure correct write bit value set when writemask defined

	modified:   drivers/base/regmap/regmap.c

Signed-off-by: Christopher Tyerman <c.tyerman@firebladeautomationsystems.co.uk>
---
 drivers/base/regmap/regmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 07d6d804c4b9..ec91eff52465 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1964,6 +1964,9 @@ static int _regmap_bus_formatted_write(void *context, unsigned int reg,
 
 	map->format.format_write(map, reg, val);
 
+	regmap_set_work_buf_flag_mask(map, map->format.reg_bytes,
+					      map->write_flag_mask);
+
 	trace_regmap_hw_write_start(map, reg, 1);
 
 	ret = map->bus->write(map->bus_context, map->work_buf,
-- 
2.25.1

