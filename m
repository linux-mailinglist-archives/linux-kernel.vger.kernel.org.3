Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF6A4D2B9E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 10:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiCIJSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 04:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiCIJSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 04:18:14 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D775D16E7E5;
        Wed,  9 Mar 2022 01:17:16 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id b8so1770599pjb.4;
        Wed, 09 Mar 2022 01:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=aEzrS2PE1KETN7BwFBNCY3C6S3nrsSHP5KWZyXBcdRc=;
        b=aZZk2KpRZQqGz0PSLYzj/p5onyZm29EV1v0s/9N/ftYnkE3uZPvUbtwtSd8/KExEUL
         gJEHWQ5XoL8j3cHV+DwwY2HbvUMWLNAyAtL4b9n18bw94TDyAwS76dpfo1TL1gMSi8Bm
         X1OuhVD4ll92HZIi0PHVuaab1Ypc0VQSYDOI1JyiTF2bwBXBO+bvRLGNSYW7TYC+ZldX
         MtifsgnPTuFMMnM3fv5VxRdwykkn4UoWzopGxsDPQeLH0dA2UBayZVmguoBoMm94NnAX
         NeeGaA1+sDxu2e6Yf3JJrc1g9vekU2FM/tyNNNK3Il5ZLKdxInBx7eLDAkkslFFJYSm4
         4thA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aEzrS2PE1KETN7BwFBNCY3C6S3nrsSHP5KWZyXBcdRc=;
        b=QszoH/6Sgk2ZLqdw2jV0grP0extkGeS0g0pLeUle9+JNmi1D3oSMkh3B8Iim35Xn/D
         6dLIF+ZI60zXnHJ93YSsCwe2fYIxCseKls3O/UyT3g4xwOmYl9y+sAIX1iQK5E7dQ4oh
         WvbH8VZt+O2sbDyQVRYzYqA4rA002+rBcEzIIrs3TLNK2RP67BYudtsaAOcJtAMhw/dH
         GyCL374t99UIH6We8MPbtlrTehc4XWCInwyrAzpyRgbTq5IvW4/D7QxyNrTduAmEoZxy
         lYnzcbqBv01W1L/757DOob31IF0ykv8Ktgyu76IW59kkzBlOR8/SAF5UGVVW9LJ8hdZ0
         FLNw==
X-Gm-Message-State: AOAM533QpN7nO24iJJNaEpPkLRX1Y6B0meQtF2vsf1ASpjtJOFwl2K+V
        1HYL6KVKthhuR2TqFg+JlMt5bkPZ7cVcQtmU9GA=
X-Google-Smtp-Source: ABdhPJwEOC5WOrkJSmQNkYtXsu7npejbiABCxHhexU92EdsCQLpawdbqX16QC0seN3xuJyqr9XhBjg==
X-Received: by 2002:a17:903:40c7:b0:151:a640:d69e with SMTP id t7-20020a17090340c700b00151a640d69emr21228754pld.121.1646817436345;
        Wed, 09 Mar 2022 01:17:16 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id q21-20020a63e215000000b00373efe2cbcbsm1676461pgh.80.2022.03.09.01.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 01:17:16 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] mips: cdmm: Fix refcount leak in mips_cdmm_phys_base
Date:   Wed,  9 Mar 2022 09:17:10 +0000
Message-Id: <20220309091711.3850-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_find_compatible_node() function returns a node pointer with
refcount incremented, We should use of_node_put() on it when done
Add the missing of_node_put() to release the refcount.

Fixes: 2121aa3e2312 ("mips: cdmm: Add mti,mips-cdmm dtb node support")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/bus/mips_cdmm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bus/mips_cdmm.c b/drivers/bus/mips_cdmm.c
index 626dedd110cb..fca0d0669aa9 100644
--- a/drivers/bus/mips_cdmm.c
+++ b/drivers/bus/mips_cdmm.c
@@ -351,6 +351,7 @@ phys_addr_t __weak mips_cdmm_phys_base(void)
 	np = of_find_compatible_node(NULL, NULL, "mti,mips-cdmm");
 	if (np) {
 		err = of_address_to_resource(np, 0, &res);
+		of_node_put(np);
 		if (!err)
 			return res.start;
 	}
-- 
2.17.1

