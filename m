Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812C953B3BE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 08:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbiFBGkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 02:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiFBGkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 02:40:08 -0400
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883DF2A1412;
        Wed,  1 Jun 2022 23:40:06 -0700 (PDT)
Received: by mail-pl1-f193.google.com with SMTP id d22so3733761plr.9;
        Wed, 01 Jun 2022 23:40:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zLPxQsb3PCndRUmUZRmCzH68VaNogXUV5kan2s/llbY=;
        b=007eLhPR9LEgBpwFCcadv0reVcbBw/lkhtBfTFJT6zsjE2I0G+WfFQXMtoJCxwOxwY
         mM4Z0XsG3BRnx448UVXjHrBV5n8/4DRwDUQPJRo3VX9oyXbGe/UxwU3GQsK2WDuOz9dM
         Iue/TF5MwJianCYOVCKrQw7cs4cT1II/07iF/p97dWystVtRWTVMP4ESdTq7jm03NbzW
         WpmD/0Qgj7pe7PIAiNJg7JY4YqdQvbj8Q8T+FjgixE9oiUe6EszPP8e0MAAOtLI7R6xL
         rdZHQYnGa0wYip2kVWG9uUZUJhMcO4zxux1jspmKplijrUH+tfa6Z/nI02dB8LD075OI
         C9JQ==
X-Gm-Message-State: AOAM530H3d9gmHF7DGzNOEaJzVBsxykewA0u4LhG9l9ylS9Tj4vCjoTv
        OznE9/8eru0EiQC8rx5yRA==
X-Google-Smtp-Source: ABdhPJxBkU9NJC7MTGevv0kjPBA0Cad/4iSKEaZVuaJmMBYtriHhArgxGxx/fbNol5aDBsWR/3m9MQ==
X-Received: by 2002:a17:903:240f:b0:158:b871:33ac with SMTP id e15-20020a170903240f00b00158b87133acmr3220825plo.135.1654152005988;
        Wed, 01 Jun 2022 23:40:05 -0700 (PDT)
Received: from localhost.localdomain (ns1003916.ip-51-81-154.us. [51.81.154.37])
        by smtp.gmail.com with ESMTPSA id e15-20020a056a001a8f00b0050dc762818dsm2625119pfv.103.2022.06.01.23.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 23:40:05 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        sunliming@kylinos.cn, kelulanainsley@gmail.com,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] xfs: Fix build error for implicit function declaration
Date:   Thu,  2 Jun 2022 14:39:58 +0800
Message-Id: <20220602063958.527493-1-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

   fs/xfs/libxfs/xfs_btree.c: In function '__xfs_btree_check_lblock':
>> fs/xfs/libxfs/xfs_btree.c:140:23: error: implicit declaration of function 'xfs_daddr_to_xfo'; did you mean 'xfs_daddr_to_agno'? [-Werror=implicit-function-declaration]
     140 |                 fsb = xfs_daddr_to_xfo(xfs_buf_daddr(bp));
         |                       ^~~~~~~~~~~~~~~~
         |                       xfs_daddr_to_agno
   cc1: some warnings being treated as errors

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 fs/xfs/scrub/xfile.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/xfs/scrub/xfile.h b/fs/xfs/scrub/xfile.h
index 973b0641b88a..a7ae99d32b5d 100644
--- a/fs/xfs/scrub/xfile.h
+++ b/fs/xfs/scrub/xfile.h
@@ -122,6 +122,13 @@ static inline loff_t xfile_size(struct xfile *xf)
 {
 	return 0;
 }
+
+static inline loff_t xfo_to_b(xfileoff_t xfoff) {}
+static inline xfileoff_t b_to_xfo(loff_t pos) {}
+static inline xfileoff_t b_to_xfot(loff_t pos) {}
+static inline xfs_daddr_t xfo_to_daddr(xfileoff_t xfoff) {}
+static inline xfileoff_t xfs_daddr_to_xfo(xfs_daddr_t bb) {}
+static inline xfileoff_t xfs_daddr_to_xfot(xfs_daddr_t bb) {}
 #endif /* CONFIG_XFS_IN_MEMORY_FILE */
 
 #endif /* __XFS_SCRUB_XFILE_H__ */
-- 
2.25.1

