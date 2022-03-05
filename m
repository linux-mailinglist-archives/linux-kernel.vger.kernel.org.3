Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81EE4CE633
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 18:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbiCERPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 12:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbiCERPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 12:15:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C161387B2
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 09:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646500497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0l403f5Mr+eL7bpML0lL2OSBYrG2pVDxEyNmYkFEjMU=;
        b=ZrLOQ39zUA1OsULq3OPnGomhu1HUfv+rs+CaZPTSDAG3oG+yrMgno1i8gnOGC0uSITSFeX
        9ngOZesZWjDTi+Cze/qwfC/KNF1C06lOCia9bcBZMqXW4SHigQ7DBfSu/Im5eqOMbViLUj
        O/GONhJSZjEmFW5tyarvoC/EpCHyPWg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-352-8HD2YO2-N6W3GnoROdu2qw-1; Sat, 05 Mar 2022 12:14:54 -0500
X-MC-Unique: 8HD2YO2-N6W3GnoROdu2qw-1
Received: by mail-qv1-f70.google.com with SMTP id k6-20020ad45be6000000b0042c82bd64deso9521863qvc.22
        for <linux-kernel@vger.kernel.org>; Sat, 05 Mar 2022 09:14:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0l403f5Mr+eL7bpML0lL2OSBYrG2pVDxEyNmYkFEjMU=;
        b=1ZVXFxjUfyGh+V6FPqY5qp/Ai959ZsFHT3G0HpvwpJ/+q/aJQaMEEwXQlNWKi0JT+W
         hUuvC6z6tYXo7Hurii15AOEQBISVVfUnAxFq+JeRgkOyYyKpPx2hgZIqLhNzNGQFGwXP
         AnYet6AqyfWXZyk4f1U2HRG9ntBE8UlHTakQvswgXpLnJrgcYbtiAbDobSA0FiUL3l/p
         ehcH3em3kWy2/I2JIZ4Nl+IKwdYgbgzjcFfTToaXS7jkBE2RKqKBV6AWZZvRMzHeN5LR
         scdRn33QD9ToKiWhp9vloM1NYXvgAfPwlNicLbZLeDopzoHPWGtSt7v8HQYlIwe2n1j+
         1kSA==
X-Gm-Message-State: AOAM530IiIza82tHgfTxwvSBPPyWa2DZ/RT3vHvhdX+VBm7TMPs0/Y3F
        q6ZxIO3YLvQ9tKdI2qnZ4S0A/lqnTfXInEhpjrrdSxQ3sUVwvIwVZs8w4orWc/bisKHFbuZ7uON
        WeacB8vqKHlWDuWutZSqxy3xf
X-Received: by 2002:a05:620a:4006:b0:67a:f431:dbfb with SMTP id h6-20020a05620a400600b0067af431dbfbmr1687586qko.733.1646500494092;
        Sat, 05 Mar 2022 09:14:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy/CSIyOclA3zgRSv8u7wpyWf8o7WbJ+0Kc40wi5YWUyKIdoknnxnBkCjzOU1XHq7D0/kOm0Q==
X-Received: by 2002:a05:620a:4006:b0:67a:f431:dbfb with SMTP id h6-20020a05620a400600b0067af431dbfbmr1687578qko.733.1646500493882;
        Sat, 05 Mar 2022 09:14:53 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id g7-20020a376b07000000b006492f19ae76sm3908647qkc.27.2022.03.05.09.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 09:14:53 -0800 (PST)
From:   trix@redhat.com
To:     andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com,
        olteanv@gmail.com, davem@davemloft.net, kuba@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] net: dsa: return success if there was nothing to do
Date:   Sat,  5 Mar 2022 09:14:48 -0800
Message-Id: <20220305171448.692839-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this representative issue
dsa.c:486:2: warning: Undefined or garbage value
  returned to caller
  return err;
  ^~~~~~~~~~

err is only set in the loop.  If the loop is empty,
garbage will be returned.  So initialize err to 0
to handle this noop case.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 net/dsa/dsa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index 06d5de28a43ea..fe971a2c15cd1 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -471,7 +471,7 @@ int dsa_port_walk_fdbs(struct dsa_switch *ds, int port, dsa_fdb_walk_cb_t cb)
 {
 	struct dsa_port *dp = dsa_to_port(ds, port);
 	struct dsa_mac_addr *a;
-	int err;
+	int err = 0;
 
 	mutex_lock(&dp->addr_lists_lock);
 
@@ -491,7 +491,7 @@ int dsa_port_walk_mdbs(struct dsa_switch *ds, int port, dsa_fdb_walk_cb_t cb)
 {
 	struct dsa_port *dp = dsa_to_port(ds, port);
 	struct dsa_mac_addr *a;
-	int err;
+	int err = 0;
 
 	mutex_lock(&dp->addr_lists_lock);
 
-- 
2.26.3

