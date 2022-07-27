Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCBC15822CD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 11:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbiG0JIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 05:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbiG0JHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 05:07:16 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DDB43E46
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 02:07:07 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d10so15559936pfd.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 02:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=2Sl2t8r1ZUfe8lzmXAHqvujfGWqYPzoD6dESsmixId8=;
        b=jjJ8BeO4eC8mXVDiID2bspJ1p6dBYwNpZawCx7rWSN/pqy2FJOuzecozYhRBwoldNn
         f/t3D/gjmmb6JJJVhf7hcdfnOiDsB8dgoCMy0I6+H4NVV09QkCfNmXE0SyB442KdPbXl
         U5tJwou8ONIH1L7pnBUVHQoRnG+lMCkD47QcG3oPqTY61VSiaHuMJer+EKmOCof9BoJH
         O+wkFKCEWTKHyIxLtAjISdk0ZIBIcEemJ/buJxMinEfqW+P9dcx2wKe0mpz+t5SABFiQ
         KfxUzMpbF2z6NcV3Ern1UjZyV9OFIx+BgAHkXcg4hjgvTQUB427AFWAXFbmMzLCuUMRX
         uDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2Sl2t8r1ZUfe8lzmXAHqvujfGWqYPzoD6dESsmixId8=;
        b=e1abb1+7FF9enUSR7L2ST1g2V5xZgnmU2lBBKKPZRXw0a3PSw0PYie4Mgua64Vckwl
         IIrqcA4Omjz8spEe/YMcKdZDuRy0BTqZSVE7k3CB2MQltNDU5c6Jc1x+PBwjb6jvlvgV
         DadJwXTR3Hiun09Ot003r1mOqUqg4WIIKFcI7X5SIH1TTMkHmLIzlCD6PlB0Fh1sgs+v
         LgDIBtyWzHcu3lzxpAksYPDQZsp02RUu4OSjamz+PN7ssI98YpvLYiRBEgq2/MDj5+tD
         99HaEusqVdC8u4OdaSju2c271588P7J7o2jUdqaKPGdy3oESmsvRIKByF0L2FWespQjP
         kAAw==
X-Gm-Message-State: AJIora87CbggCU/pgGMWRWh2s4+2sz8RBMQ5SRBU0fKLtoGTY6OytP2W
        c5dYZWdXaYWsnkKXLYxbqov6Dg==
X-Google-Smtp-Source: AGRyM1vtuT/ZYh9CUtmNfGXr7qX1Z6Jxa2DeJOGGWDtXWejTkzZSlxUordVbZUp7hABJPSZZiRQ9AA==
X-Received: by 2002:a63:4c0d:0:b0:41a:77fe:2bc8 with SMTP id z13-20020a634c0d000000b0041a77fe2bc8mr17722286pga.82.1658912827076;
        Wed, 27 Jul 2022 02:07:07 -0700 (PDT)
Received: from n131-251-112.byted.org ([121.30.179.125])
        by smtp.gmail.com with ESMTPSA id x8-20020a170902a38800b0016c46ff1973sm13131587pla.228.2022.07.27.02.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 02:07:06 -0700 (PDT)
From:   tujinjiang@bytedance.com
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jinjiang Tu <tujinjiang@bytedance.com>
Subject: [PATCH] vmscan: fix potential arbitrary pointer passed to kfree in unregister_shrinker
Date:   Wed, 27 Jul 2022 17:07:00 +0800
Message-Id: <20220727090700.3238-1-tujinjiang@bytedance.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jinjiang Tu <tujinjiang@bytedance.com>

when shrinker is registered with SHRINKER_MEMCG_AWARE flag,
register_shrinker will not initialize shrinker->nr_deferred,
but the pointer will be passed to kfree in unregister_shrinker
when the shrinker is unregistered. This leads to kernel crash
when the shrinker object is dynamically allocated.

To fix it, this patch initialize shrinker->nr_deferred at the
beginning of prealloc_shrinker.

Signed-off-by: Jinjiang Tu <tujinjiang@bytedance.com>
---
 mm/vmscan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index f7d9a683e3a7..06ab5a398971 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -613,6 +613,7 @@ int prealloc_shrinker(struct shrinker *shrinker)
 	unsigned int size;
 	int err;
 
+	shrinker->nr_deferred = NULL;
 	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
 		err = prealloc_memcg_shrinker(shrinker);
 		if (err != -ENOSYS)
-- 
2.17.1

