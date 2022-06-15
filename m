Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83DD454CC85
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 17:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243121AbiFOPSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 11:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241916AbiFOPSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:18:00 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2891BEB9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 08:17:59 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id e66so11649914pgc.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 08:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yW6NkFpJik+3SrdmNZi54Xr/3MC0mxPIBOSiFthGTNE=;
        b=ugBE1vRMX3u9Xhm9TU3rvuixmLiTd8/ZwHOw7EUFGFlY44FCYKLVQxC0eLFC2lZXCq
         eaC9tsO/y8+VEXRs0TIaBi2jOmm8wg9OfRycvPemolg7GoOFjCBFi0jAkGWL1py4eTPE
         PjSDqcHWA2CeLJfJ1urmGFLiHPx7nQQjt3Jj+ac/3GZJVDR7FeoyaaALDP+gECNJGvXL
         FRuE0Rj7vYnOpUeq6rvPyf507tGp4fPVHymer/JsO73G7ekG21NR9u6l72uZ2XwzgIaN
         TN3gpR+L97xQ/aWVYI27Ad0MLWXpyAGINJeH9F8MVZGvpZ5sMljyRC47rytpPhCpF0p9
         0qYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yW6NkFpJik+3SrdmNZi54Xr/3MC0mxPIBOSiFthGTNE=;
        b=0/BXhL2/Ywh4LWhOQ51qXAkNFG6Ut2KHm0s0J+haOlQ1QVMBz7jklov5VZr1DgXqEA
         bnLt6bKydfDs/ghjyiWqcpK/PlWvPUZm6j9thE6wBTfoTMb5y94C69+Toy9HUTyU7IU4
         9NQBGScHxkyIobxoNer/KRf+8a9XF6kgqV+mq+/2R2ftdtI5uEqenbFeFfR0D6wrypN6
         5V601qxTpM7DFZ3o276n+iLXXsqGXVRaYguQYATEpQx9ITTsa2rGjsSCjMZr9Gbky4kz
         KEDi02QFwpk/irE08kndBLFP4Wp0rmgYKbBbEP2shQEwb78vR9qCLkHXxiYeB9PX82lL
         QTBA==
X-Gm-Message-State: AJIora9p6daEUH1ecLLu13PKl6hJouVnDDm4wIi90mixTKwNeB4JCDOR
        jO6QV9Bqg9GSOxrMtuUq/rsfmA==
X-Google-Smtp-Source: AGRyM1vDFxi+osxlykT7Evu3Ect5uLDOFq3p51CX6y/2TV3zHt6O2LvDg4lG76dW8FOvSvxqFIfyBA==
X-Received: by 2002:a63:9547:0:b0:408:be53:b599 with SMTP id t7-20020a639547000000b00408be53b599mr232147pgn.463.1655306279029;
        Wed, 15 Jun 2022 08:17:59 -0700 (PDT)
Received: from n131-251-240.byted.org ([121.30.179.88])
        by smtp.gmail.com with ESMTPSA id cd6-20020a056a00420600b0050dc7628162sm9916231pfb.60.2022.06.15.08.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 08:17:58 -0700 (PDT)
From:   Zhi Song <zhi.song@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, Zhi Song <zhi.song@bytedance.com>
Subject: [PATCH v3] node: put_device after failing to device_register
Date:   Wed, 15 Jun 2022 23:17:38 +0800
Message-Id: <20220615151738.1766206-1-zhi.song@bytedance.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

device_register() is used to register a device with the system.
We need to call put_device() to give up the reference initialized
in device_register() when it returns an error and this will clean
up correctly.

Fixes: 08d9dbe72b1f ("node: Link memory nodes to their compute nodes")
Signed-off-by: Zhi Song <zhi.song@bytedance.com>
---
V1 -> V2: Fix up the changelog text correct.
V2 -> V3: Add a fixes tag line specifying the commit where this bug was
introduced.
---
 drivers/base/node.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 0ac6376ef7a1..88a3337c546e 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -154,6 +154,7 @@ static struct node_access_nodes *node_init_node_access(struct node *node,
 	list_add_tail(&access_node->list_node, &node->access_list);
 	return access_node;
 free_name:
+	put_device(dev);
 	kfree_const(dev->kobj.name);
 free:
 	kfree(access_node);
-- 
2.30.2

