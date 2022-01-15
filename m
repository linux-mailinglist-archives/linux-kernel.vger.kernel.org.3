Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D123248F9C0
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 00:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbiAOXAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 18:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbiAOXAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 18:00:17 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1D2C061574
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 15:00:16 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id j7so212743edr.4
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 15:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=kjbaItt49HeNYKlAAvgAvUBakX33E0u6vY6bifOEKb4=;
        b=Uc9cRXojj+6mUIOsHJ+HkmjUfU30TXPHtGXyq8egGJ0VXpmuxOKiCiGo5b3txp8czg
         ZERq3R659QHGatFaPYjrVp8w3ScLYW3iScEcgRM2tdKk7ySAu34Ph1JSXHeOnypxnkX9
         yZFSttjGy5C42DP4SMliiBmABHmtdy776sKDmyoOSh7eO2l/Am814i1QMfZoyqs4aShV
         JKVN+nkoW8Zp5mgbKXSVy0ZULlwsLv57X4GmVRzvpyB/GTIo285VvIdgYWkXGfHJuvSO
         tccDpuoVXKpo0mI94FS2RMGA8ueXxt5TRamd8rUB0sINcJpHOd0ENlqLxbcVf+Ncvh+k
         V8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kjbaItt49HeNYKlAAvgAvUBakX33E0u6vY6bifOEKb4=;
        b=Gy2SkYJWaFIZ+AVhDnJBhlxUNTjJogXbZSQmn+gerG6Wsav/u6YdBNsFM3r5125kxM
         wrApbaM7iNSkW869+aDSF++r1j2Fq0QxfFTlocemq9RiAdCEyAQi1EBIpXhVnM1aAHt6
         UFMvCFWVDFa54E/PBktOX4cs3XE7GBDdd73i30ydVhCwsvrKJtXf8IRdn9R12Ozsf8W9
         8WXSG+eM++pPw8vrt0Nsr8d+4Xr6hlQi3SUnnbNYyE+1p1sVQHKlMf5Ce7+SOheludLF
         b9OtrjZJaUUn1yipZHrtHlGDd8/VR935WYc1rfwBvZr9pFTjE7JcKPPPfnTH5zwnm6yu
         /TiQ==
X-Gm-Message-State: AOAM532SuCE1KsOv35bxqF8IdU2H6ML4x/AHY22JGtiAz9lCNluPhb3q
        Ccwq0xqh1xqPB2A4Xps+8Kk=
X-Google-Smtp-Source: ABdhPJxT4Tv6oz52W08eKN9B+ubuMQ67i5hKP5HwoRtTuvxWcuu81WX0lvuLnZ7MtO8vTqH+PJ1J3Q==
X-Received: by 2002:a17:907:d11:: with SMTP id gn17mr11593470ejc.252.1642287615069;
        Sat, 15 Jan 2022 15:00:15 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 16sm2977557ejx.149.2022.01.15.15.00.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Jan 2022 15:00:14 -0800 (PST)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.com,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH] mm/page_alloc: clear node_load[] in function build_zonelists
Date:   Sat, 15 Jan 2022 23:00:02 +0000
Message-Id: <20220115230002.490-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

static variable node_load[] is a helper variable during build zonelist.
On each turn for building zonelist, node_load[] is cleared. So this is
proper to do this in function build_zonelist.

Another side effect is,  #ifdef CONFIG_NUMA could be removed since
node_load[] is only defined when CONFIG_NUMA is set.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 mm/page_alloc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c5952749ad40..8245f5a24aad 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6255,6 +6255,7 @@ static void build_zonelists(pg_data_t *pgdat)
 	prev_node = local_node;
 
 	memset(node_order, 0, sizeof(node_order));
+	memset(node_load, 0, sizeof(node_load));
 	while ((node = find_next_best_node(local_node, &used_mask)) >= 0) {
 		/*
 		 * We don't want to pressure a particular node.
@@ -6371,10 +6372,6 @@ static void __build_all_zonelists(void *data)
 
 	spin_lock(&lock);
 
-#ifdef CONFIG_NUMA
-	memset(node_load, 0, sizeof(node_load));
-#endif
-
 	/*
 	 * This node is hotadded and no memory is yet present.   So just
 	 * building zonelists is fine - no need to touch other nodes.
-- 
2.33.1

