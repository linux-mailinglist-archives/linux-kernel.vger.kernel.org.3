Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5451488857
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 09:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbiAIIVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 03:21:34 -0500
Received: from srvc114.turhost.com ([109.232.216.117]:55955 "EHLO
        srvc114.turhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiAIIVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 03:21:33 -0500
X-Greylist: delayed 2528 seconds by postgrey-1.27 at vger.kernel.org; Sun, 09 Jan 2022 03:21:33 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=ercanersoy.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        Message-ID:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=G04Y8GSoLZmUnCgXdMDlJFKF6Vl2a2TJL3PA/6fHimM=; b=seqfPa+Mxw3r9SMlxxi+A7gZOh
        79/muAG+WWUuOk/HltZDQ5S6srOVxLypdl2CmivevITnhP6RRytWaxgzZLuHdv0mm3mb47Jf9ZZIU
        XWo+k32v7HBzMc15T664RjlLpH2qtnuGH2GOzxRePjpBZTCZdVOfjr2QvHDAnGlbq2XL6ROrXS5WC
        o7Mib6C0DNXqA4Lam88BjvOz/Il1+65H0wm7x9Pxp0qJYOkM6AnxRPLos+FaysLaxt1aGbweXq4Do
        38/AH9agLiTNzmVoac3IzrWkxBH6KYL5NrpSuQzakIn47DD3DLtDxHnCLgoszO8hXioRQlyrZxejP
        w7RN4G+w==;
Received: from [::1] (port=39612 helo=srvc114.turhost.com)
        by srvc114.turhost.com with esmtpa (Exim 4.94.2)
        (envelope-from <ercanersoy@ercanersoy.net>)
        id 1n6SnQ-008UXK-S9; Sun, 09 Jan 2022 10:39:21 +0300
MIME-Version: 1.0
Date:   Sun, 09 Jan 2022 10:39:19 +0300
From:   Ercan Ersoy <ercanersoy@ercanersoy.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org
Subject: [PATCH 2/2] Fix assgining cma_area_count
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <775ae3ba4f7034a78769559fa1a3542a@ercanersoy.net>
X-Sender: ercanersoy@ercanersoy.net
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - srvc114.turhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - ercanersoy.net
X-Get-Message-Sender-Via: srvc114.turhost.com: authenticated_id: ercanersoy@ercanersoy.net
X-Authenticated-Sender: srvc114.turhost.com: ercanersoy@ercanersoy.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I have patched "Contiguous Memory Allocator" of Linux kernel.

This fix of patch is for cma_init_reserved_mem function in
mm/cma.c source file as creating area without specific name.

Without fix may be a problem a lot of cma as next cma2147483647 naming.
Without fix may be a problem huge memory systems.

I think after "cma2147483647" naming is "cma-2147483648".

Thanks for interesting,
Ercan

--- START PATCH ---
 From 5d3d01a3a0f7339617d1df945c0bd0ec1ab91ae3 Mon Sep 17 00:00:00 2001
 From: Ercan Ersoy <ercanersoy@ercanersoy.net>
Date: Sun, 9 Jan 2022 10:01:14 +0300
Subject: [PATCH 2/2] Fix assgining cma_area_count

Fix assigning to cma->name in cma_init_reserved_mem function
in mm/cma.c source file.

Signed-off-by: Ercan Ersoy <ercanersoy@ercanersoy.net>
---
  mm/cma.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/cma.c b/mm/cma.c
index bc9ca8f3c487..03f01d1f1b57 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -199,7 +199,7 @@ int __init cma_init_reserved_mem(phys_addr_t base, 
phys_addr_t size,
  	if (name)
  		snprintf(cma->name, CMA_MAX_NAME, name);
  	else
-		snprintf(cma->name, CMA_MAX_NAME,  "cma%d\n", cma_area_count);
+		snprintf(cma->name, CMA_MAX_NAME,  "cma%u\n", cma_area_count);

  	cma->base_pfn = PFN_DOWN(base);
  	cma->count = size >> PAGE_SHIFT;
-- 
2.30.2


--- END PATCH ---
