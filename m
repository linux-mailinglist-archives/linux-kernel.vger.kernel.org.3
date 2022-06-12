Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3062C54792C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 09:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiFLHKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 03:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiFLHKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 03:10:46 -0400
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10BB606D5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 00:10:44 -0700 (PDT)
Received: by mail-pj1-f67.google.com with SMTP id e24so3019069pjt.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 00:10:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=575NP7awIhloB41yOKYfL1oPbvMoxjfZLNv5WIm33CA=;
        b=1IVVJqstUwN8h5BHqH+cb7iSc7tG7/rCLq7I06kcNvkg9k/oo168Cx4UFgJQaXcJwu
         wFRDKezUwIIfv5LHDVLcRn7s72C7fCfKqurKZ6cZPbASfhjomKEP4w8cpDnVdo01Sx5Y
         KlCwmxTtHQ+IU5VmGt6pnfoD78kfDbVlpWyxIjFaH0s4nUPm4nFqYNillrMjasaFDuok
         OgZeVkS13365XUEMWxpCM7oyLKy4UWxNAOlGCa9HCK8ObwqHroEe6DbMKj2Ic+MA48qq
         y9O96v/P8dkjCXGDs0dZVai7/CoHy5MmPni7r2IYxV5ZJRZy/bm1ukIuO0B4cNNhPy/R
         AImA==
X-Gm-Message-State: AOAM531fLCwyK7pUWpWGQtCGD7VGE6u1LlB8MrHwsvC8LXj8vZXjQAAg
        PqEyR202qW0QCGhTVeyT7w==
X-Google-Smtp-Source: ABdhPJzoE+CXw9vc1vid3JqssiUm4iIZU4qXVsrJmajlMKSoOEZug3tM5zxr9jo/zJKkgXwhkvws+Q==
X-Received: by 2002:a17:902:d103:b0:166:3e44:cfca with SMTP id w3-20020a170902d10300b001663e44cfcamr52298111plw.141.1655017844231;
        Sun, 12 Jun 2022 00:10:44 -0700 (PDT)
Received: from localhost.localdomain ([156.146.53.107])
        by smtp.gmail.com with ESMTPSA id z191-20020a6333c8000000b0040175983762sm2770428pgz.37.2022.06.12.00.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 00:10:43 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     noodles@fb.com, dave.hansen@linux.intel.com, bhe@redhat.com,
        robh+dt@kernel.org, frowand.list@gmail.com
Cc:     linux-kernel@vger.kernel.org, sunliming@kylinos.cn,
        kelulanainsley@gmail.com, kernel test robot <lkp@intel.com>
Subject: [PATCH] of: Add missing function declarations
Date:   Sun, 12 Jun 2022 15:10:35 +0800
Message-Id: <20220612071035.1178320-1-sunliming@kylinos.cn>
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

Fixes the following w1 warning:

drivers/of/kexec.c:126:5: warning: no previous prototype for 'ima_get_kexec_buffer' [-Wmissing-prototypes]
drivers/of/kexec.c:153:5: warning: no previous prototype for 'ima_free_kexec_buffer' [-Wmissing-prototypes

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 include/linux/of.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/of.h b/include/linux/of.h
index f0a5d6b10c5a..3a166a1c4ef6 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -844,6 +844,16 @@ static inline phys_addr_t of_dma_get_max_cpu_address(struct device_node *np)
 	return PHYS_ADDR_MAX;
 }
 
+static inline int ima_get_kexec_buffer(void **addr, size_t *size)
+{
+        return -ENOSYS;
+}
+
+static inline int ima_free_kexec_buffer(void **addr, size_t *size)
+{
+        return -ENOSYS;
+}
+
 #define of_match_ptr(_ptr)	NULL
 #define of_match_node(_matches, _node)	NULL
 #endif /* CONFIG_OF */
-- 
2.25.1

