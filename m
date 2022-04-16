Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B84503425
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiDPFlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 01:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiDPFlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 01:41:39 -0400
Received: from insect.birch.relay.mailchannels.net (insect.birch.relay.mailchannels.net [23.83.209.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E58FCBC6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 22:39:08 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id D48B480877;
        Sat, 16 Apr 2022 05:39:07 +0000 (UTC)
Received: from pdx1-sub0-mail-a254.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 3A30A8081C;
        Sat, 16 Apr 2022 05:39:07 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1650087547; a=rsa-sha256;
        cv=none;
        b=cGRLvoSTg+bqcskZ3kmeLRHpaP4ZS+CX1ePnaDZt9BUVFOeU2R3uIhN2HdwoLcBqocv6yN
        PpG67ZZwEHom5CANZ5RKBzOW+Yk5zglgBbn87yleZcD06UTp/LEbooGgNd03Ao97O62Bm0
        yl5WRVFUnvtHRDYjiFQtaifEObBlmzb7n8ki6ZB5BRhG/mWPr+IkFqD/sS4QPsdtFrlPHI
        qfOvCTXUkPT4oZztirSUkHx0Az2WbCwZViQE+Km+PCnoDzSqwSohNieZ7Pw0PZ1xvTFhje
        6eqqadD8C6PGPlI94945pZep8aoSTSmnYNmr0hoUuqjebtJtQmKPuWEM8R9khw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1650087547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=6i5ewlPlZcpl0U53ReVtxqDV6akyDEkpkhvA2ApaQDM=;
        b=RcKea6IbTdk+/u3AVWCe5VLH/E2+psKqcpcBIcFipQ1LSQG/k+EqAXd3kQGLiFPVHVbA9N
        Mruhd7Er5TDPBPP+RV3JuZxGjP3KmP+c2rfSExypN1KiOEhw2M1/SBwnrcsBWjF0+v+nJr
        MNU5plebEvUvB8xSkpGk8soSNsr7zqemwQrcC/bSoD1ra7d4C8qNbK5t2jI07sF9U/mIeo
        sLO88WXkkYoCNJhAHSS22v3Bw4zkKf48eU2pxzEMwcjOwx3GJRnU9WwtAc+lV5NPVbgMZZ
        Q7QM1jvZs6/AxszTuQWHXS+j+xKzsEQFtN+s28spPgJszFNfdbDZj+KgEHUJZA==
ARC-Authentication-Results: i=1;
        rspamd-b69d6888c-k22hh;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a254.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.125.123.25 (trex/6.7.1);
        Sat, 16 Apr 2022 05:39:07 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Trail-Eight: 702c94657123f1e4_1650087547719_2608661820
X-MC-Loop-Signature: 1650087547719:1342454741
X-MC-Ingress-Time: 1650087547719
Received: from localhost.localdomain (unknown [104.36.29.107])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a254.dreamhost.com (Postfix) with ESMTPSA id 4KgMSn6r2Rz2x;
        Fri, 15 Apr 2022 22:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1650087546;
        bh=6i5ewlPlZcpl0U53ReVtxqDV6akyDEkpkhvA2ApaQDM=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=AjdzWRn8Jfh8MVjXZjilJ+tQi0Xt6YBrmAL/Y6diDSVFVfobB+o/NlRj7JWsu+66Y
         qcdR9F4+GtPHmZ+JvH2JFyJoP0CLPcYZpB3h+J4z6Pj2b1R26Wzg+0hU7cbHIzgpHd
         cFOn1RG9ziICZLhz1FaF92ex7wLWEjwmc4WuwAC8K5WdjrzipVqMYYbZ1cwnuMJO34
         0opMS0YlDqa45fWbNSJesrC4WSF4N7jMFmBQ2so2qxy+k87sOz+Z6kAfyj7u/NpgOw
         u+3YMKo0UuNZeBMdWXpqNEndn8DPUf14ZMlSvcF1u95/NQ+JWTX1Xnh5tOP+2g0WaC
         KLEr4tGPZnXPQ==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org, rientjes@google.com,
        yosryahmed@google.com, hannes@cmpxchg.org, shakeelb@google.com,
        dave.hansen@linux.intel.com, tim.c.chen@linux.intel.com,
        roman.gushchin@linux.dev, gthelen@google.com,
        a.manzanares@samsung.com, heekwon.p@samsung.com,
        gim.jongmin@samsung.com, dave@stgolabs.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] drivers/base/node: cleanup register_node()
Date:   Fri, 15 Apr 2022 22:38:57 -0700
Message-Id: <20220416053902.68517-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220416053902.68517-1-dave@stgolabs.net>
References: <20220416053902.68517-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trivially get rid of some unnecessary indentation.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/base/node.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index ec8bb24a5a22..6cdf25fd26c3 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -661,16 +661,16 @@ static int register_node(struct node *node, int num)
 	node->dev.bus = &node_subsys;
 	node->dev.release = node_device_release;
 	node->dev.groups = node_dev_groups;
-	error = device_register(&node->dev);
 
-	if (error)
+	error = device_register(&node->dev);
+	if (error) {
 		put_device(&node->dev);
-	else {
-		hugetlb_register_node(node);
-
-		compaction_register_node(node);
+		return error;
 	}
-	return error;
+
+	hugetlb_register_node(node);
+	compaction_register_node(node);
+	return 0;
 }
 
 /**
-- 
2.26.2

