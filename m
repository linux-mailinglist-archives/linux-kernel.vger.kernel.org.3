Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1506151E544
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 09:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358683AbiEGHkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 03:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235270AbiEGHkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 03:40:45 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27F051E71
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 00:36:59 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id w17-20020a17090a529100b001db302efed6so8689275pjh.4
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 00:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S3bMf6KI/XEu+cZ94oF3l21Vq/ap6LSo7SSEXejZTrA=;
        b=VD9lKISKceU89JkgvgZKQTZ85npaJ4QW1V2Agx9+TFJBq7TKm3nCq08V4VwOBf1hhQ
         X0raUitjiu449kwAS5DzmZ/nbX672al59fCynUH437gQ18y/tpJmBgcOTh3VuxXcFYDn
         bXnrfWPluLfxTBqLe7ukV4Ew4t/2JDxvZvbbLN/EJcbxjgEELpzwhK5GWFqQTNGLbtb/
         3M6DFCao5zDmUAiiD8GRdTJj+u4daLmHwk4UUKjb7O2kklA80MDAfc+fdUIywVV9CAbX
         NYkQPpMSrZIkRPyL231z5RvL2uu6aq/+hjfepNDn4VN9aztT4f/ceFSc+or0HalZHMMw
         kReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S3bMf6KI/XEu+cZ94oF3l21Vq/ap6LSo7SSEXejZTrA=;
        b=7SiLhNAcSiVKHcKuhV9nzgWWvHSYc3vEUS0/CsroeG4GswHj6EDLBpYA8W9Go1BvNZ
         i6gxIzLqVLbYKLUY/ewBunEGIzrAlqFlpIzQEPH7kcJ94y9W0NZIrwcIWOU6Fr5cOzvW
         CE+FztZe2se5/2oY8pF7ecdsYhHx7eoNjwiBXLRiLPB/fi7HwxK5DujPSxLYp/ckdptG
         b7fC4g1knA23wLwxZ2rxsVtg5yJZGaDCkR8PIeqejGVWDhODTmjNNt0bgeUNM7q1RQAy
         ko4soIxJ2VgCYTp0JZ/EdCuRghPwK7Uc5aSqfeRXJveT3xdlUb0YLjcYLxFfEVM2x5H2
         k9DQ==
X-Gm-Message-State: AOAM530/2zxLBlsYbb8O1+X25eKR1J8graFclYruqaEKMWlngmBPR03v
        IClwUrWgDxgA55gr8CT0YLw=
X-Google-Smtp-Source: ABdhPJy4pCAYNk70IH0PMXGPWeIMlNSl2szVRTuerPLgh9NVZ47TtfLlVKL1rBFPuj1JR7W8eAsiLA==
X-Received: by 2002:a17:902:7fc9:b0:15b:d408:5b19 with SMTP id t9-20020a1709027fc900b0015bd4085b19mr7442520plb.12.1651909019263;
        Sat, 07 May 2022 00:36:59 -0700 (PDT)
Received: from hyeyoo.. ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id y16-20020a62f250000000b0050dc76281b4sm4806541pfl.142.2022.05.07.00.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 00:36:58 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] MAINTAINERS: add myself as reviewer for slab
Date:   Sat,  7 May 2022 16:35:06 +0900
Message-Id: <20220507073506.241963-1-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently I was involved in slab subsystem (reviewing struct slab,
SLUB debugfs and etc). I would like to help maintainers and people
working on slab allocators by reviewing and testing their work.

Let me be Cc'd on patches related to slab.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index edc96cdb85e8..c21e6221513f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18103,6 +18103,7 @@ M:	Joonsoo Kim <iamjoonsoo.kim@lge.com>
 M:	Andrew Morton <akpm@linux-foundation.org>
 M:	Vlastimil Babka <vbabka@suse.cz>
 R:	Roman Gushchin <roman.gushchin@linux.dev>
+R:	Hyeonggon Yoo <42.hyeyoo@gmail.com>
 L:	linux-mm@kvack.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git
-- 
2.32.0

