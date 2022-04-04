Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2BB4F116D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 10:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244363AbiDDIyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 04:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243677AbiDDIyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 04:54:35 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435EE3BA43
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 01:52:40 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id a16-20020a17090a6d9000b001c7d6c1bb13so8358893pjk.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 01:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=xlHjLLOVwRUqhlaz5vObd+BHxTCeh9876m0MJ4plEHE=;
        b=Z5BXWahL9LpaA7nWiUvu8PqG+5HSYpzdGEiKyLW77ffarw7YOcDbNXZOsUemLdSigr
         T6bPNyJUB2HNue/0Am+3CVMd0e3Wk9qIQZfunRT9f04OyDVGJLjC0ixoTxLJ4JzecuSq
         fyzQRXzTMZc2cfwocXeappvvbAguwUPsjDRx2LKE5Y7JJREfxUKOXNSaq4JUGT3ZFK5X
         ktL9fZrxrSxp0Fl6KBxgXHKGOO1HhNkTLWAc/G5d3TnYIOEYuYUQZFOinvSkNshVDo4c
         ir2ha3KdzUyZn6qe6xVAY4mZI219jVJfXwA/Vf49fOw5B05JtP4j1JYpek+Hotl/r6/6
         VG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=xlHjLLOVwRUqhlaz5vObd+BHxTCeh9876m0MJ4plEHE=;
        b=m0wnbE8GklcR8IMKs7h6wdoo4xLS2PQHLSblPXD4EFYQD3U7JmjFqtdh0T1qlr/Mvk
         a18h3ZB4p7BeSQZqzm8SQA0A7RP4rYvCQbXpG/2btkW6rRu+Sd0j70o253uhKwYDjTO3
         U8v9wThSNBceKDaL1xzFDKgNClIczQLkMTwPcrUq3F8564Gh4y527rHuthvxEZlrdylA
         Q5hS/frVeRXeXGYJKaFYMzgc+A0duzZLRQOaXMWt9Asx22UhkbYoQvZ2QUGcQdtIR+5u
         Fa3gmv7S5Gptc9SV6sHCIgb2TEkEO6WQEP+RBqFlN6krtPJS3TfqOyLwHCsyQk7dAVLJ
         st1g==
X-Gm-Message-State: AOAM530I/yO6QIqvOSNP0U2auXNZKGHTUQQYdW9WzAy3logCXV38owav
        o86HxQ6/fuoi+8q4erK7uvFaVck7C1HqeJgy
X-Google-Smtp-Source: ABdhPJz0Z1qUa9OFZtx80FV26N1iGq5kihOMR2UARB7sUduCPL4jglhVwL6Bb2L8oCFp8gyTxqIZZg==
X-Received: by 2002:a17:902:d714:b0:153:a902:e544 with SMTP id w20-20020a170902d71400b00153a902e544mr58215245ply.17.1649062359647;
        Mon, 04 Apr 2022 01:52:39 -0700 (PDT)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id d16-20020a056a00245000b004f7728a4346sm11820745pfj.79.2022.04.04.01.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 01:52:39 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Carlos Chinea <carlos.chinea@nokia.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] HSI: omap_ssi: Fix refcount leak in ssi_probe
Date:   Mon,  4 Apr 2022 08:52:32 +0000
Message-Id: <20220404085234.11435-1-linmq006@gmail.com>
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

When returning or breaking early from a
for_each_available_child_of_node() loop, we need to explicitly call
of_node_put() on the child node to possibly release the node.

Fixes: b209e047bc74 ("HSI: Introduce OMAP SSI driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/hsi/controllers/omap_ssi_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hsi/controllers/omap_ssi_core.c b/drivers/hsi/controllers/omap_ssi_core.c
index 44a3f5660c10..eb9820158318 100644
--- a/drivers/hsi/controllers/omap_ssi_core.c
+++ b/drivers/hsi/controllers/omap_ssi_core.c
@@ -524,6 +524,7 @@ static int ssi_probe(struct platform_device *pd)
 		if (!childpdev) {
 			err = -ENODEV;
 			dev_err(&pd->dev, "failed to create ssi controller port\n");
+			of_node_put(child);
 			goto out3;
 		}
 	}
-- 
2.17.1

