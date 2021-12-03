Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2284679AD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 15:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381570AbhLCOuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 09:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381599AbhLCOuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 09:50:10 -0500
Received: from mail-il1-x149.google.com (mail-il1-x149.google.com [IPv6:2607:f8b0:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A46C061D60
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 06:46:46 -0800 (PST)
Received: by mail-il1-x149.google.com with SMTP id y3-20020a056e021be300b0029f6c440695so2186970ilv.19
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 06:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=n9U31kqgJhRjTrQuE7/WsUbjvo3IuvChEsgfsakfCtM=;
        b=rd8pvcG1vzx/DDDuvYSdtXAbva5Itbs/PnhB2WR1urv/bO8ZPp1DXeuDB3jbK7bmyf
         75UG+udWEFJy8HARO2Hsjt7/V3HgxUa5q1tD2eb8FUez3UnZ16pl+I/xkf7mtyqUuOWt
         StHChCjRJ3LEGPKWX2cyCvF60W7tn6tWuesxf6QVhunXkJ+oNLShrPBUJEpKRu7ZjJY8
         oCWpUPIlDcJhu/dtw1NSeEGwFwHripXIlJChpleBS6lUg4pa7uYJjaJDZzyrOGgCZBjt
         1mLvnBInioIoe2BKwg2LFcr+6Su5RMkhn5riAysWBEMbCplY2a2MUSLSZuLL3uTQqeEa
         LEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=n9U31kqgJhRjTrQuE7/WsUbjvo3IuvChEsgfsakfCtM=;
        b=P48RstNrkPXg8G5lquuGAHbr3j20VzeLfQhs3mdYe/6rI6UcQjgDVwBHuJEZBIRrro
         xnHa9AlpWIU9Gal9NAegMDjtKfz2FwXIQQlCCY698nRpzzO03Amxo0kMZGha+KDs4A4w
         fUnRUvtsmWyqsgoUGIPKPhLPc2HedyStEkT+LxaRRMbqAod1UM4w6g4gih9WEknkqK+t
         sKu+OqAYgcAIC+HoVZiTJHWgBXhq/znEQPAgXVYfJ6PPwANvA9kf7x4eIjvlloQnTbum
         eXdJEAy/+2R0iRiebTeX1RbgrypiocgskltVVup1VDET6vk4GV0MQ/9kLZpg4TZrpZAw
         7nhg==
X-Gm-Message-State: AOAM530ADhn2Jl3jwkKstZoBkEnI5x19l1MSMTzVKDMQUWP/OsU6YkWx
        +cqNGIsADSWYRAIqu0NPgbEsv5sIsMI=
X-Google-Smtp-Source: ABdhPJzrzQYwNY4O2vuTS5sr2ZpqPQQ+UCFOGbe72sin34/pwiPQ5VQ0RpEhgLuzb96y4borqsRF0Z6nWwI=
X-Received: from pgonda2.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:ac9])
 (user=pgonda job=sendgmr) by 2002:a6b:700e:: with SMTP id l14mr20659616ioc.20.1638542805449;
 Fri, 03 Dec 2021 06:46:45 -0800 (PST)
Date:   Fri,  3 Dec 2021 14:46:38 +0000
In-Reply-To: <20211203144642.3460447-1-pgonda@google.com>
Message-Id: <20211203144642.3460447-2-pgonda@google.com>
Mime-Version: 1.0
References: <20211203144642.3460447-1-pgonda@google.com>
X-Mailer: git-send-email 2.34.0.384.gca35af8252-goog
Subject: [PATCH V5 1/5] crypto: ccp - Add SEV_INIT rc error logging on init
From:   Peter Gonda <pgonda@google.com>
To:     thomas.lendacky@amd.com
Cc:     Peter Gonda <pgonda@google.com>, Marc Orr <marcorr@google.com>,
        David Rientjes <rientjes@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        John Allen <john.allen@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently only the firmware error code is printed. This is incomplete
and also incorrect as error cases exists where the firmware is never
called and therefore does not set an error code.

Signed-off-by: Peter Gonda <pgonda@google.com>
Reviewed-by: Marc Orr <marcorr@google.com>
Acked-by: David Rientjes <rientjes@google.com>
Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: Marc Orr <marcorr@google.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David Rientjes <rientjes@google.com>
Cc: John Allen <john.allen@amd.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/crypto/ccp/sev-dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index e09925d86bf3..f527e5f9ed1f 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -1104,7 +1104,8 @@ void sev_pci_init(void)
 	}
 
 	if (rc) {
-		dev_err(sev->dev, "SEV: failed to INIT error %#x\n", error);
+		dev_err(sev->dev, "SEV: failed to INIT error %#x, rc %d\n",
+			error, rc);
 		return;
 	}
 
-- 
2.34.0.384.gca35af8252-goog

