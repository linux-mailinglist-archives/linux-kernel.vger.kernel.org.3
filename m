Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24F552C9A9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 04:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbiESCNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 22:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbiESCNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 22:13:49 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF62527D7
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 19:13:47 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id bh5so3503770plb.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 19:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=iR1vyDMBro9x6LnGfqGQlvzCYtDWr1sZHPHxpHQE8Rs=;
        b=oSrhapKLlz7CT4Nz8DBVB2RpdyAiWXZ9b39FRnhHiwBYkY2Egmam3PdnUeYea7RMUi
         4LpZt0zpH+l1AKsBkh+u1Pxtyec/JEDEPry7vYMGoNtev/Iw1j0zvZBDD0gmmTjpAfxn
         1MmTWHfRN14FBo4QUg4BR41+HrqDnSfTxHdkEfPL4xuUjdxLgYEc9IwrpUGcV9qcEzxr
         nT8ENp30Z57KwJdzaaRRMoA7oTMFNCH1qIGAyl8Wqn9MDyHGq142lX/P+PxegFMhfiD7
         0YtjTmB+Ud+8erDfxkaiLPXKzo6LAzBsqfDPIX/cHDjvLSE6qIyI58h4YIj3Lgh0gj8j
         ITyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iR1vyDMBro9x6LnGfqGQlvzCYtDWr1sZHPHxpHQE8Rs=;
        b=aGmPE1JSa4ewyfgQRE74k3qWfaU+UI8Fb/JMa7S3Y05Iu3TXko6hUEeNqUUSDtokH2
         m2bbyVOWQ5KnXSOIEz1SVzV8dHmyLNsmaD5eUufnFs2+oQ8AKKV4OLlx/GZatdzsaa0+
         PsygOTwJGx8wpcMSYYuVPUlJ0JxO4jKVLLA9lK1OLdlc1v+GHyenMwy3EbEVji7iWSGE
         mlGsW64/EFF8Rhvb9FFy4hW//Bzn3JIkD+0otzOWgC0zIQE6RVsCaYW++1hPptMkAKCK
         E0QNCaf9MERXY61/yvVwnkS4fsHM2qNpW2bTm0Iw9VFxXLzjYZoNfgICiXmwNXSLcAro
         Y8ow==
X-Gm-Message-State: AOAM533YW2CN2mJvMDRsHZxOg7+VNOdcwxB5H2RO7VqYpFIYW7J52Fvl
        pe0DNTec9xjJazSgLAGvznGICRYi/h0=
X-Google-Smtp-Source: ABdhPJxQMraZkaMnNRxglh/xUJ7JPSQMu6PA95nusyOA4sVUz+UJRi/+eh4oZ+526V/Wh2wce02DNw==
X-Received: by 2002:a17:902:7296:b0:151:62b1:e2b0 with SMTP id d22-20020a170902729600b0015162b1e2b0mr2575134pll.165.1652926427058;
        Wed, 18 May 2022 19:13:47 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:568:8697:c74:ab15:730:f5f3])
        by smtp.gmail.com with ESMTPSA id je4-20020a170903264400b0015ebb3bf277sm2366603plb.238.2022.05.18.19.13.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 May 2022 19:13:46 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc:     oder_chiou@realtek.com, lgirdwood@gmail.com,
        ritchie_hsieh@richtek.com, allen_lin@richtek.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        ChiYuan Huang <cy_huang@richtek.com>
Subject: [PATCH 0/2] ASoC: rt9120: Fix 3byte read logic and optimize 'PWDN' control
Date:   Thu, 19 May 2022 10:13:36 +0800
Message-Id: <1652926418-8519-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Hi,

This patch series try to fix two things.
- 3byte read logic bug
- Use regcache and pm_runtime to optimize 'PWDN' control

ChiYuan Huang (2):
  ASoC: rt9120: Fix 3byte read, valule offset typo
  ASoC: rt9120: Use pm_runtime and regcache to optimize 'pwdnn' logic

 sound/soc/codecs/rt9120.c | 113 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 106 insertions(+), 7 deletions(-)

-- 
2.7.4

