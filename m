Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5CD539C43
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 06:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346538AbiFAEZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 00:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240934AbiFAEZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 00:25:25 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3169E9E1;
        Tue, 31 May 2022 21:25:24 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id a10so850732pju.3;
        Tue, 31 May 2022 21:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qV/kQWWE5TCXDtwtIihkerreiew7iWC6lBTWJeucJIg=;
        b=ReFoyD6+1Lqkr/R2pf+8AKWuf/SU8Gfa83eXY5S/LG50yi/hKWMyX/3OPwn6aJ1F59
         ib9E9yb2Y+S9tgbMqi2DzZfsCNhEUZGbxD4oOkub/0tFfsfKT9wVkM86/SQIFsLo3BVz
         e5cJitqsmzcKoJtU0zDAoJXxB/Z2c3YRZcfczyZeN6rgZiFxc0z9YfjrHcMfrDOIzBxV
         u+rLPDPpIMOH6r2OBg5TTdGimLpRzbSuCskm47LvrMHkT2LLciV2MPVfHVIrOC8nH7HR
         MEYS9/U+HJ6ikAALq2hyIwzab4ExehXGsmHSgM3JQxIvPbHiKj0rK4M0VnW+6Qi4/aq1
         vRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qV/kQWWE5TCXDtwtIihkerreiew7iWC6lBTWJeucJIg=;
        b=1gJ7emSOgzsu5MHw1jXlb2eYKy2oTyMZIGlkaEgkRGi7vj2PYQKErkU8G18zIYPSAz
         87YYHPomCIi4kS+blzK/S5OtphQm+jxkh+8Z411Z9GSo7kcP5SUudiRrjQCQ8PjdlqpB
         5d9o2Kf+UBZZkSqsKEwr91lSSZrHQFdvvHtJxple+rpOn0n1/oQKAff7RoVEG+oTY6fK
         mF+lZBv+Dfu3TeiHU04LFRbCFfkT0bYzgX+W1gPgbl5th7gqQEUerW26Z+KMD0rysz7x
         8ovo/VraERsobG77GBndy5dw3u0A5javWcKJ2ckgKYJj2E3sxNxD7nylU5T42i+iiQmH
         OsFw==
X-Gm-Message-State: AOAM531ErYb6T1iAFg/QI24HQu1Qq2Ex+TsO/FFo7ITmeMw+Vdc/nYyQ
        Q52IkR8g0mtDOyQKJYwdzu8=
X-Google-Smtp-Source: ABdhPJzhh0v5mf83CiChYoplV/aivC7HiUkv4hOQhbwi4NqjR/XvCvK6+eyWrEazVoETOiYVO01X8A==
X-Received: by 2002:a17:902:e54e:b0:162:4b8b:f2be with SMTP id n14-20020a170902e54e00b001624b8bf2bemr38630727plf.5.1654057524096;
        Tue, 31 May 2022 21:25:24 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id fz21-20020a17090b025500b001df51e34036sm337111pjb.0.2022.05.31.21.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 21:25:23 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Hyun Kwon <hyun.kwon@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Radhey Shyam Pandey <radheys@xilinx.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] v4l: xilinx-vipp: Fix refcount leak in xvip_graph_dma_init
Date:   Wed,  1 Jun 2022 08:25:14 +0400
Message-Id: <20220601042514.61780-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_get_child_by_name() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: df3305156f98 ("[media] v4l: xilinx: Add Xilinx Video IP core")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/media/platform/xilinx/xilinx-vipp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/xilinx/xilinx-vipp.c b/drivers/media/platform/xilinx/xilinx-vipp.c
index f34f8b077e03..415579b63737 100644
--- a/drivers/media/platform/xilinx/xilinx-vipp.c
+++ b/drivers/media/platform/xilinx/xilinx-vipp.c
@@ -483,10 +483,12 @@ static int xvip_graph_dma_init(struct xvip_composite_device *xdev)
 		ret = xvip_graph_dma_init_one(xdev, port);
 		if (ret < 0) {
 			of_node_put(port);
+			of_node_put(ports);
 			return ret;
 		}
 	}
 
+	of_node_put(ports);
 	return 0;
 }
 
-- 
2.25.1

