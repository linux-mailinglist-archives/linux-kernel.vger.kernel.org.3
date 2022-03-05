Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB1F4CE1D4
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 02:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbiCEBQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 20:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiCEBQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 20:16:12 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CB322759F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 17:15:23 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id kx1-20020a17090b228100b001bf2dd26729so2190199pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 17:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pDUo/7OLNspJPt+q9wCyTkpV25XABw+87crNkHjSYi4=;
        b=C3lCTsC/bfyuq86SbVC+rK79KAZEraU9a44bPNjFKuh9u8vHSRpMXelfIsGSyCEc03
         h5vjg929+64A/+/yhEH/ke8o073QUxUT/m06xmuSeIpUkt2mzuGMKnKa8NW1fkRLsaTo
         JCVN7cJj9TH5oTt5ZkiZb/hp28Suq2oVKLk+4niiDFCBlOV8ebaJUdKcpWWza3lRs1HJ
         dt4I5PPMhM15pWnEUaxW6dHUxi33POe7PwMFgHuFkHs3Q5a5ZJYivNzfaQ4L3pRbNhXo
         FNrOriTGtS7Xc0jPQRS9tuMLxHsk9wPO6nWUcb3VtjVmqbzIvo2xeHx6M4/v64hMF+tq
         FppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pDUo/7OLNspJPt+q9wCyTkpV25XABw+87crNkHjSYi4=;
        b=4vFqFM7XtPo6hI8kZrqLhV2n4l3TzQV/Ie/yAHT84O5DYdoyppDN4H7mFyDfmjJTi8
         PxH3GQkKxb2ofaZb6THYlFKZQjzaKyDucWLK8I/AIt1eyJYyBtUOaFRYcvao+CV9MrFV
         M1XeBCDF/Zd4AEGQR8K4tEKHsPBXCSYLC0NMVePrlL9EjO1JJdqoF2OF0Zkt9FtCzndi
         JF73SQiABDXn3KgfqEzgUXbRzugqAD8mjNSCvsSRsaGQRhgZlOhK2Xa3YGbm0TFVVHCI
         rHa6N9KHseyoyznzIaB4hTGUuFOl5TtseQCBu6Fh8MSSDHJ4gIlyadfGJKY1yt5yuwYM
         p10w==
X-Gm-Message-State: AOAM531NNXxZNDaySvVPMzRZs0/NPXju1aU20kmeccrShJZkdXzhumOo
        VCOOkjsxbcq9qvUOLMeSU205D8zSIk29XFtk
X-Google-Smtp-Source: ABdhPJwVTW6WEC8IlAK0tLrTl7jF+dij85k0L+uQfQ20wBTOLJ1+bdEaixcZuMhfyFJi+utqfb1YjA==
X-Received: by 2002:a17:903:2285:b0:151:4b38:298e with SMTP id b5-20020a170903228500b001514b38298emr1309053plh.36.1646442922468;
        Fri, 04 Mar 2022 17:15:22 -0800 (PST)
Received: from localhost.localdomain ([119.3.102.56])
        by smtp.gmail.com with ESMTPSA id mq17-20020a17090b381100b001bf355e964fsm1040491pjb.0.2022.03.04.17.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 17:15:21 -0800 (PST)
From:   Bang Li <libang.linuxer@gmail.com>
To:     akpm@linux-foundation.org
Cc:     urezki@gmail.com, lpf.vector@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, libang.linuxer@gmail.com
Subject: [PATCH] mm/vmalloc: fix comments about vmap_area struct
Date:   Sat,  5 Mar 2022 09:15:10 +0800
Message-Id: <20220305011510.33596-1-libang.linuxer@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the vmap_area_root should be in the "busy" tree and the free_vmap_area_root
should be in the "free" tree.

Fixes: 688fcbfc06e4 ("mm/vmalloc: modify struct vmap_area to reduce its size")
Signed-off-by: Bang Li <libang.linuxer@gmail.com>
---
 include/linux/vmalloc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 880227b9f044..05065915edd7 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -80,8 +80,8 @@ struct vmap_area {
 	/*
 	 * The following two variables can be packed, because
 	 * a vmap_area object can be either:
-	 *    1) in "free" tree (root is vmap_area_root)
-	 *    2) or "busy" tree (root is free_vmap_area_root)
+	 *    1) in "free" tree (root is free_vmap_area_root)
+	 *    2) or "busy" tree (root is vmap_area_root)
 	 */
 	union {
 		unsigned long subtree_max_size; /* in "free" tree */
-- 
2.25.1

