Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65CEE537813
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbiE3IzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 04:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234726AbiE3IzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 04:55:07 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C6213EA9
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 01:55:06 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id h1so550903plf.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 01:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0H0zQuhfwBWace/gM3VoJC+BnbGdiHLKJagjl3jEq3M=;
        b=EF62q7Q3oMoO+z+5RDfg5gzwDGy+5Mgc/CpZLLiKi1NmzSAIj9SUkUvNAi21n+ZC9S
         wWWwckJXijLwzTsX8uhvvVGKmJh35ObrgG7uVpZS1dh5ICCLGZx2b3juck9uVa/WyUv+
         r2FENoYuRXuzLnhZTGF2X1Dqhdoq2/YbhZJPMf0p0gWI4mf06Wjia6n1PPtFuvRGW1ZJ
         jK+EfuDmO7YrxPj1zk4iP+4qu6UAMLJ8OUR4AIWH6u7FTPZvc6RTH00cCF9cqZ83p3UZ
         JAZSlmOQ3JOkaxjHgdS1lF/E5ja19txVvaJI0JOYr/OYpxDzuZClmCfe/soEsca1mqqo
         3Now==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0H0zQuhfwBWace/gM3VoJC+BnbGdiHLKJagjl3jEq3M=;
        b=CaWtyW+Vjk07y5Dy1qHi0tYtHPxHppLZJE7Pm8vZOsm9swerYYuX8UFEkXsliPnKwG
         xadX04TaX7PjcNICCWKcr3T6C273KOa1ZrDxeboF03Hwuv/wVNe0uPRQ4YHLSnRAWF1h
         REJ/ExRDhzp7O9UbH6QNkGH2zHj5rkKs+W3W9w6J41EPlq5slkxT2PFl4g94JtwECtRH
         GATXlsVsWIvTxnbFbJgzuaZB7GMUMN/yhCFAFjjf6NYlvxaiUhHwDZk+3ujjHV/qE3uO
         jqEbDHvP7JwxGJjnNidLov4XS90dgk0m4Pt2TbEIVeFpKG3M5ZjM15cEr4TSEAm6WwA3
         F8DQ==
X-Gm-Message-State: AOAM533YCt+/k78ENUEkvcVi7ddIsV/hUSeeqrpxmXV1zzG/0iiXtpsg
        qbkKb/eoezqV2k/iUZ7eJYM=
X-Google-Smtp-Source: ABdhPJxrSACZi1MuyKXlNpU+Vh3dNJjQEQRDTaVFDuE5Gs9VXiolOOXmJWa12DeQhlyIbREinPT43Q==
X-Received: by 2002:a17:90b:2782:b0:1e2:97d4:53d7 with SMTP id pw2-20020a17090b278200b001e297d453d7mr13009781pjb.53.1653900905911;
        Mon, 30 May 2022 01:55:05 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id 71-20020a17090a09cd00b001e25e3ba05csm9977319pjo.2.2022.05.30.01.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 01:55:05 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Alexey Brodkin <abrodkin@synopsys.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] drm/arc: Fix refcount leak in arcpgu_load
Date:   Mon, 30 May 2022 12:54:57 +0400
Message-Id: <20220530085458.44265-1-linmq006@gmail.com>
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

of_graph_get_remote_port_parent() returns a node pointer with refcount
incremented, we should use of_node_put() on it when done.
Add missing of_node_put() to avoid refcount leak.

Fixes: 3ea66a794fdc ("drm/arc: Inline arcpgu_drm_hdmi_init")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpu/drm/tiny/arcpgu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/tiny/arcpgu.c b/drivers/gpu/drm/tiny/arcpgu.c
index f0fa3b15c341..6cbc4e9d382e 100644
--- a/drivers/gpu/drm/tiny/arcpgu.c
+++ b/drivers/gpu/drm/tiny/arcpgu.c
@@ -310,6 +310,7 @@ static int arcpgu_load(struct arcpgu_drm_private *arcpgu)
 
 		/* Locate drm bridge from the hdmi encoder DT node */
 		bridge = of_drm_find_bridge(encoder_node);
+		of_node_put(encoder_node);
 		if (!bridge)
 			return -EPROBE_DEFER;
 
-- 
2.25.1

