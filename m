Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEFD4F2078
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 02:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiDEA3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 20:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiDEA27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 20:28:59 -0400
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2F16D962;
        Mon,  4 Apr 2022 17:14:11 -0700 (PDT)
Received: by mail-pf1-f169.google.com with SMTP id bo5so10524517pfb.4;
        Mon, 04 Apr 2022 17:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=s770C6klEms02pbWlMqZ7qzWEPI+Uww/MfxHY8uG4vE=;
        b=k6QcTH5OFElnFZB5ywOcznLOBAhe2hCrgDB/1CE9hopXUamRctF7xzupaTGyjie+bU
         Dn1y4oT8iUNpCoz3f8ztUeKckAYsnOH0QxV2g98T2m1mDZ1q3AOfLyP281XJA2WLMWHo
         InfWaovMViHpeXzr5o2J+xGzUH95AOmFSgkSkgsTFVmb/F6kt/D+/pbRujyJbUKzrFdI
         QnTW8ZY3MbjUGDl2G6VJQagpZubmmTgHYgxAGPicE7OChrIognxcaiBJsL8vdAj33rQx
         D64RlwiAfYxJJm8gvmDF6yejWg8ArZDQ5ifmoeeGQj+lrQKGkEKRwh3qHV5//qg+hgKz
         Ftdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=s770C6klEms02pbWlMqZ7qzWEPI+Uww/MfxHY8uG4vE=;
        b=nYZgtDi4LelkKJzxyt1hF/CMkLJ4OIUT3zWF6dYpsMQkMz4okUvHr4aMnPhAvSCKjm
         BEvbxkn4JNevgRXEA0vgLtlZlp0aDrHlmdrBTj/PIOSsnCnqMif+EZvUDPc01mz/dKVF
         U2FRP46Z6NBKVckofxqsd/nC/+9Bjv9K4JF3f0MSiFR4iEkmDgKLU9BzEFaDb8G+ndHS
         rUtiwPpdWLONmKY5aw8XialqbQVkFVh/5lEsD1o0ZoDOxS7jT2/B2d4bdado74KRHIuJ
         v2c453su20mWHEFobsP2eADiQI8zk08oZJTFp+vOMlWFMcH1Yph1hZ+I9l+Noys/ydJo
         DXsg==
X-Gm-Message-State: AOAM533x82+XT6u5yovJ9NgJo53drMyWdDSRXtdY3Tcrt7cWlEsB6xb2
        yCofICyIKN8aCGaVjrJprxw=
X-Google-Smtp-Source: ABdhPJz/5mA1GYh+pRA7EsKULzQ3fpI3iy6RmHB1NtwIOZzyJvWaAc1pyBf/CpYdeq2hSsCw7Z1g1A==
X-Received: by 2002:a63:f147:0:b0:399:2b1f:7aff with SMTP id o7-20020a63f147000000b003992b1f7affmr594620pgk.341.1649117580338;
        Mon, 04 Apr 2022 17:13:00 -0700 (PDT)
Received: from localhost.localdomain ([183.156.181.188])
        by smtp.googlemail.com with ESMTPSA id q9-20020a056a00088900b004fe1a045e97sm3140138pfj.118.2022.04.04.17.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 17:12:59 -0700 (PDT)
From:   Xiaomeng Tong <xiam0nd.tong@gmail.com>
To:     jassisinghbrar@gmail.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        Xiaomeng Tong <xiam0nd.tong@gmail.com>
Subject: [RESEND][PATCH v2] myri10ge: remove an unneeded NULL check
Date:   Tue,  5 Apr 2022 08:12:53 +0800
Message-Id: <20220405001253.22120-1-xiam0nd.tong@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The define of skb_list_walk_safe(first, skb, next_skb) is:
  for ((skb) = (first), (next_skb) = (skb) ? (skb)->next : NULL; (skb);  \
     (skb) = (next_skb), (next_skb) = (skb) ? (skb)->next : NULL)

Thus, if the 'segs' passed as 'first' into the skb_list_walk_safe is NULL,
the loop will exit immediately. In other words, it can be sure the 'segs'
is non-NULL when we run inside the loop. So just remove the unnecessary
NULL check. Also remove the unneeded assignmnets.

Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
---
changes since v1:
 - remove the unneeded assignmnets.

v1: https://lore.kernel.org/lkml/20220319052350.26535-1-xiam0nd.tong@gmail.com/
---
 drivers/net/ethernet/myricom/myri10ge/myri10ge.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/myricom/myri10ge/myri10ge.c b/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
index 50ac3ee2577a..071657e3dba8 100644
--- a/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
+++ b/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
@@ -2903,12 +2903,8 @@ static netdev_tx_t myri10ge_sw_tso(struct sk_buff *skb,
 		status = myri10ge_xmit(curr, dev);
 		if (status != 0) {
 			dev_kfree_skb_any(curr);
-			if (segs != NULL) {
-				curr = segs;
-				segs = next;
-				curr->next = NULL;
-				dev_kfree_skb_any(segs);
-			}
+			segs->next = NULL;
+			dev_kfree_skb_any(next);
 			goto drop;
 		}
 	}
-- 
2.17.1

