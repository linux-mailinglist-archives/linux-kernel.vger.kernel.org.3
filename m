Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BD14E8C97
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 05:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237804AbiC1D2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 23:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiC1D2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 23:28:35 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7C74757F;
        Sun, 27 Mar 2022 20:26:56 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id 85so10443454qkm.9;
        Sun, 27 Mar 2022 20:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ombNCD2E1kEOXTkZKzTdQw3vNkWsQV7mKFpn1lZyTEI=;
        b=SA+QodpcnT05y1Q3fra3dhwNhB5oa8XXxXp177wHxv62DDPf0lxVNfC3nqX0y10d4P
         ScPYBqJBgRhxEv4kt94nQ2yCx9UOq3zmEp9vSN+lzrsD2Gba8fEJrIUZk9sX3OrFAy6r
         F5a9hsDS4xxdDIyWp3edvlmnSzLg14fI4fovUHRo9oBNtc56VUzZuGlLezuINbaYE+rb
         CYPPJ3AQos+lJMtwCQEnIKAQ3y7WovNkOidmZb0z8xs0xcBNYITH+L8s9/eVDFAKO4I0
         CzKFNeHNFf6gGH4htfL8HqAx3xE7wEpxwtf8T96qO3W/EI0vrc5VRBlt+Q0DoY943cBM
         Pd+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ombNCD2E1kEOXTkZKzTdQw3vNkWsQV7mKFpn1lZyTEI=;
        b=TN5fmP5Pthr1CPGB1vApnAcwIBhic3cLj5IO8COlTRomFNq/z7IHyQ9Mhp2wx27Fap
         HfxrtrkMSSWosGKS8ONpKfYOrockGYAqZx82M3z9e9g1+ukK1V8hBnJP8EeCBFVJTKWo
         hfRN0jGK1VcKAb28/cHCKju79gCoTAvmxTBca2hEe37JYJlcqj+wS9l4FD1SW6nSwh7n
         SUbCCtvQ3v2u8ZXloAgtcNqkmoeWxkAUifkMmksV5FMItbxpF8icvh/kNjh7spXL20vk
         m+wb99bS8yCMOfzQPhBbq0/tW/X8uXTfF8W3GXk9eryVl04fHOrfq7CeTM1EW8ixjkG8
         7jhg==
X-Gm-Message-State: AOAM532+UBSRiOlCcyjcnIHeXnoWjWCyj4s9jYV9MGSXKTEP9DJYVHBE
        pfep734rzFbHzb8vGnzL4RY=
X-Google-Smtp-Source: ABdhPJy/L7PFrjNbdwwgtuKWMOX1nrqMWZtt0khYNk3KIrOLULqso6Jmx6gi3k1y1UqBfjdWvTv2Vw==
X-Received: by 2002:a05:620a:2904:b0:67d:db5a:b27f with SMTP id m4-20020a05620a290400b0067ddb5ab27fmr13451964qkp.529.1648438014399;
        Sun, 27 Mar 2022 20:26:54 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id s15-20020a05620a29cf00b00680ca4b3755sm2533193qkp.119.2022.03.27.20.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 20:26:53 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, dchinner@redhat.com,
        chandan.babu@oracle.com, bfoster@redhat.com,
        allison.henderson@oracle.com, lv.ruyi@zte.com.cn,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] fs: xfs: add NULL pointer check
Date:   Mon, 28 Mar 2022 03:26:42 +0000
Message-Id: <20220328032642.2371596-1-lv.ruyi@zte.com.cn>
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

From: Lv Ruyi <lv.ruyi@zte.com.cn>

kmem_zalloc() is a memory allocation function which can return NULL when
some internal memory errors happen. It is safer to check NULL pointer.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 fs/xfs/libxfs/xfs_attr_leaf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/xfs/libxfs/xfs_attr_leaf.c b/fs/xfs/libxfs/xfs_attr_leaf.c
index 014daa8c542d..e6694f49f563 100644
--- a/fs/xfs/libxfs/xfs_attr_leaf.c
+++ b/fs/xfs/libxfs/xfs_attr_leaf.c
@@ -1571,6 +1571,8 @@ xfs_attr3_leaf_compact(
 	trace_xfs_attr_leaf_compact(args);
 
 	tmpbuffer = kmem_alloc(args->geo->blksize, 0);
+	if (!tmpbuffer)
+		return;
 	memcpy(tmpbuffer, bp->b_addr, args->geo->blksize);
 	memset(bp->b_addr, 0, args->geo->blksize);
 	leaf_src = (xfs_attr_leafblock_t *)tmpbuffer;
@@ -2290,6 +2292,8 @@ xfs_attr3_leaf_unbalance(
 		struct xfs_attr3_icleaf_hdr tmphdr;
 
 		tmp_leaf = kmem_zalloc(state->args->geo->blksize, 0);
+		if (!tmp_leaf)
+			return;
 
 		/*
 		 * Copy the header into the temp leaf so that all the stuff
-- 
2.25.1

