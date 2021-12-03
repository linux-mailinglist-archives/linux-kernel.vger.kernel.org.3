Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A503467CCE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 18:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382417AbhLCRwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 12:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343541AbhLCRwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 12:52:21 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A0CC061751
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 09:48:57 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id o19-20020a1c7513000000b0033a93202467so2785430wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 09:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E0EgtD7kZKRl4dW18idg/FyrsF298tjyIxloV4FlQ/0=;
        b=cWJ8dhfOzgD3e0G2r7Cvl3CExYWK8m80NWrrli76jXLd7vjUHudVDg9O4L2ma1AgKt
         mZA/wlyccyE6uTHFd71hsBSASl5BqdCbKErTWn5meoFIBfti0hFjwazu5/ltsB/+h8Lp
         9bQXx4zTjAFxG9w7BA34lrW8mN0wih41MHJbZu+HaJbtHRGmEqvp+QD4WbUmtAU07ChZ
         /224GY1pY4gcip0fRXWkYJ7XXIiwKKUy1Qf2BjFjq7MkT4uW8vO04TjNpEQUHfTeaOLA
         E/5zK4CBC1GZ4GTjoLkY/dipwrVkKI4zbNWbYi80FCJioyQHYk9uq3aMD/mP5cyGVU8i
         TdSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E0EgtD7kZKRl4dW18idg/FyrsF298tjyIxloV4FlQ/0=;
        b=GLVKrEO8ZnEbIs1nQHkve1GYbKOgLz2DN1RIuR2qp0DWS4XDiA50F2vRJ8qAVP3NJ3
         iMP8Z79TMEvKvhS/BepFxsPEUnTAVndz3bXij0D20DPgYj9SJ7lmOGY6wDy7Tao/OazX
         jTJ5JGrcb14s+Vp2OsZoCJT0H/QnEKX8slK8i3AO1PtPheG8iUtsEdKLl71W/M/nASKf
         uw0biw53QhIwa/RJARtGnlBlISG2eRwMQKhy9MYKDpqHPeXmsME5r2qVFqfAAfKUkCaq
         SGp2TVuuMzi+vI91bTZwQOAq+a1RcCxua4sP1z3X4X56pYIzuvLDW8R4PCUcdrAcjI1u
         tmfQ==
X-Gm-Message-State: AOAM5311gmrrQllTlceZwcE6YE92ZNiSyzmk9WQ1uQ4HzkJxA5jxVQ9u
        kLdemzUPP/4KaVq/LW6SD7Q=
X-Google-Smtp-Source: ABdhPJyxFtCTU8EjoI1T39YLzAm09xnPHTAbc3J/rozWt7oOfCzvEKu/Ahmj+EWZ7fkBE/Nty5KLGw==
X-Received: by 2002:a05:600c:4f8f:: with SMTP id n15mr16478329wmq.70.1638553735522;
        Fri, 03 Dec 2021 09:48:55 -0800 (PST)
Received: from localhost.localdomain ([39.48.194.133])
        by smtp.gmail.com with ESMTPSA id d6sm3259764wrx.60.2021.12.03.09.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 09:48:54 -0800 (PST)
From:   Ameer Hamza <amhamza.mgc@gmail.com>
To:     jmaloy@redhat.com, ying.xue@windriver.com, davem@davemloft.net,
        kuba@kernel.org
Cc:     tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, amhamza.mgc@gmail.com
Subject: [PATCH] tipc: fixed possible memory leak issue
Date:   Fri,  3 Dec 2021 22:48:48 +0500
Message-Id: <20211203174848.43879-1-amhamza.mgc@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed coverity warning by freeing the memory before return

Addresses-Coverity: 1494433 ("Resource leak")

Signed-off-by: Ameer Hamza <amhamza.mgc@gmail.com>
---
 net/tipc/crypto.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
index b4d9419a015b..10e6d0e9ddbc 100644
--- a/net/tipc/crypto.c
+++ b/net/tipc/crypto.c
@@ -599,6 +599,7 @@ static int tipc_aead_init(struct tipc_aead **aead, struct tipc_aead_key *ukey,
 	tmp->key = kmemdup(ukey, tipc_aead_key_size(ukey), GFP_KERNEL);
 	if (!tmp->key) {
 		tipc_aead_free(&tmp->rcu);
+		kfree_sensitive(tmp);
 		return -ENOMEM;
 	}
 	memcpy(&tmp->salt, ukey->key + keylen, TIPC_AES_GCM_SALT_SIZE);
-- 
2.25.1

