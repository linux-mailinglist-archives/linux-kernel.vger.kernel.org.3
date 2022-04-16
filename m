Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108FA5032F6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiDPFlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 01:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiDPFlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 01:41:40 -0400
Received: from dog.birch.relay.mailchannels.net (dog.birch.relay.mailchannels.net [23.83.209.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27737FCBE6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 22:39:09 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 4D9C38E0866;
        Sat, 16 Apr 2022 05:39:09 +0000 (UTC)
Received: from pdx1-sub0-mail-a254.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 6B1788E0A2D;
        Sat, 16 Apr 2022 05:39:08 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1650087548; a=rsa-sha256;
        cv=none;
        b=MEnOUgboGU+pBdhHmAjrwm1t+GnuY96RET8wgcs1uybtAGqFOhFf0px7NXjmiMKxcVEo6B
        6ssfrCv1r4KNEJ1fVI8lDgtAz2ulcmRAYfTjxG2K5FV0pLS00sbBwA9WdczoXsYwicohhl
        itzmbz+69dYviPe923SSUE8p6BtZtNZL11kAGRgTVd+BOjmyzGd+fyCAi/DZgAf6GQk0+I
        38/CN5LjTKGI3STGOQimHb/4jIxNtLocH2PuSTDjHtR7xuhvGTntzxHH+br4pJe7Kwwl/u
        pkegy2UYYQRcBN4C9AHgK5nhXMNBSNCytmII0abKX46sCiOOpc4u3CPAgpQ95w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1650087548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=o6IEbKvua02oTa9M00UzUl+jNfiR5q6pe5kpfgir4y8=;
        b=9wb1NxbfwZzQuQ41GZQL+zJuut45olZ9DquTQtw2Civ9s8/zGDtZJWNtP8KuIvu8aqlbFB
        1QFUKPcXByjX55f4Fdcz6IHCJPTXVsroKlcUxvf6AkqCKk3pfE3cWybVNnWfMMJ4P0ITW2
        eiNmTuTolTKcdcRb41gOUkCwUojscX/MZYrbetS5338Zv87MEPFB4DWJnhfDO0OU/W6CFs
        CdoyCSDZGvmbT9bwszF/0DNkk8roB7b2HZN9+xvGYPE0Yi1mJ1u2dIbOU6rIPiNG3WEIa4
        LpDGj4onyTZf0mnFNo4tJQ0o5BjTP5eE3I1QNzfTs381mvq9DeVXcm5XgfEKRw==
ARC-Authentication-Results: i=1;
        rspamd-b69d6888c-bbjgq;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a254.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.127.95.106 (trex/6.7.1);
        Sat, 16 Apr 2022 05:39:09 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Bottle-Society: 79e8c51671ba30ce_1650087548870_3045130971
X-MC-Loop-Signature: 1650087548870:2453292932
X-MC-Ingress-Time: 1650087548869
Received: from localhost.localdomain (unknown [104.36.29.107])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a254.dreamhost.com (Postfix) with ESMTPSA id 4KgMSq0Syxz1PX;
        Fri, 15 Apr 2022 22:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1650087548;
        bh=o6IEbKvua02oTa9M00UzUl+jNfiR5q6pe5kpfgir4y8=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=VGpJSw0EzAMU0y6a6KvMpV2wz+jg6tAye0rdHHJ+LrVetgpyc3WHVFQBWLSS3nImn
         XDjpSfV5OwoAKwBD1jPR5CMzNSmtEFagvLEqc9ovKkwotm83oJceLOMPJtI0WaWHyW
         zB/HwNfeWRfireGMH2SX/NoGuZRPXA47wfayuP4jLkqI36zLnfof0j3zRJk0vNOcKL
         WMIaBrc39S4szwXvRuUjqtOhzCr/e/YsxLE0a6Y6vE/00OJ9Fe/GCHhbZGLUfV8ipB
         6SwrYQUKP8ilY9ou0aHaA0LTIhRDSCxr/BbOaRbVAkvL4BNPBV09jZeoebje9dDkly
         GCZiTtes7rFew==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org, rientjes@google.com,
        yosryahmed@google.com, hannes@cmpxchg.org, shakeelb@google.com,
        dave.hansen@linux.intel.com, tim.c.chen@linux.intel.com,
        roman.gushchin@linux.dev, gthelen@google.com,
        a.manzanares@samsung.com, heekwon.p@samsung.com,
        gim.jongmin@samsung.com, dave@stgolabs.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] mm/vmscan: use node_is_toptier helper in node_reclaim
Date:   Fri, 15 Apr 2022 22:38:58 -0700
Message-Id: <20220416053902.68517-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220416053902.68517-1-dave@stgolabs.net>
References: <20220416053902.68517-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have helpers for a reason.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 1678802e03e7..cb583fcbf5bf 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4750,7 +4750,7 @@ int node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned int order)
 	 * over remote processors and spread off node memory allocations
 	 * as wide as possible.
 	 */
-	if (node_state(pgdat->node_id, N_CPU) && pgdat->node_id != numa_node_id())
+	if (node_is_toptier(pgdat->node_id) && pgdat->node_id != numa_node_id())
 		return NODE_RECLAIM_NOSCAN;
 
 	if (test_and_set_bit(PGDAT_RECLAIM_LOCKED, &pgdat->flags))
-- 
2.26.2

