Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0CF534650
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 00:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344883AbiEYWTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 18:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbiEYWTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 18:19:19 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3A5674F2
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 15:19:18 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id bo5so167247pfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 15:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wccjosb8wE1V/MYd73MboMsy8MfUDLYZI409lQYQVEM=;
        b=LEEEpCI1j7qkx0EGkLbiue2FsrBjxh2KwXKW6ZBOEkQKTEcF18Di/jMced8MbqFXcr
         6L3YQ+AiFlUNitJ8J6O6gjwMInwS7WSRrVwPJJf1HdjLVaLsES8Ehf0BwLCt+g3BWeYl
         7x7e+LIizvbSQco6C6eOVFKZV+VK7SUY2Jd/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wccjosb8wE1V/MYd73MboMsy8MfUDLYZI409lQYQVEM=;
        b=6XE422DCpdWmH+fo7GWnzZLHBEYN6Paep/VW5UpP6fn1JOSv+yrxj3vfBUZiYRIfgI
         StXY+YgPtu12ASX1oyrcRHC/GBQRogfqRgkPThLYDqWq1xLfVaiUdfVctCaJKY1VKDUN
         4M2GcwYZsbSWEsiLnLi3292kn12rJafqv8oSexw3pcl24VjJI8a9NOQN2mqIvhiYzvrR
         Bvd4So6UpqiBRMmo2kJWEQ2sCdBYb1YaX3fKgSekGArEk6OCmr1dfClr6VmoXSSiILMZ
         162xWR/NW33NYsFK0Gju4Pt6C2Ol111xTgSXQwb7thfvTh2blBYq40lkD/bKpeq026u1
         3Icg==
X-Gm-Message-State: AOAM532K9N0Y3DTidCU8dIgzn+92/qyFtPXPyfbogktai0sSCJQ5zlDA
        uV+eyfxizRhzFC1HNtKCzJIpLk96eWqhCw==
X-Google-Smtp-Source: ABdhPJyqH/pFtyzZN0+TTUQ5L+yo+rcr9UoI8vmlcIzhRSepo77v0l0tVNpTbVesHOThrvjl3mkPKw==
X-Received: by 2002:aa7:8390:0:b0:518:3f2d:1e2 with SMTP id u16-20020aa78390000000b005183f2d01e2mr34558419pfm.36.1653517157612;
        Wed, 25 May 2022 15:19:17 -0700 (PDT)
Received: from localhost (132.111.125.34.bc.googleusercontent.com. [34.125.111.132])
        by smtp.gmail.com with UTF8SMTPSA id w5-20020a170902e88500b0015e8d4eb1d3sm10003803plg.29.2022.05.25.15.19.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 15:19:17 -0700 (PDT)
From:   pso@chromium.org
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Dmitry Torokhov <dtor@chromium.org>,
        Paramjit Oberoi <pso@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH] pstore/ram: Fix pmsg address when per-cpu ftrace buffers are enabled
Date:   Wed, 25 May 2022 15:18:55 -0700
Message-Id: <20220525151809.1.I43128ef59eb08247ec093f8b19d05aa91f721afb@changeid>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paramjit Oberoi <pso@chromium.org>

When allocating ftrace pstore zones, there may be space left over at the
end of the region. The paddr pointer needs to be advanced to account for
this so that the next region (pmsg) ends up at the correct location.

Signed-off-by: Paramjit Oberoi <pso@chromium.org>
---

 fs/pstore/ram.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index fefe3d391d3af..3bca6cd34c02a 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -554,10 +554,12 @@ static int ramoops_init_przs(const char *name,
 			goto fail;
 		}
 		*paddr += zone_sz;
+		mem_sz -= zone_sz;
 		prz_ar[i]->type = pstore_name_to_type(name);
 	}
 
 	*przs = prz_ar;
+	*paddr += mem_sz;
 	return 0;
 
 fail:
-- 
2.36.1.124.g0e6072fb45-goog

