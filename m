Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C056D4ECEA3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 23:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348960AbiC3VVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 17:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348448AbiC3VVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 17:21:10 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D475D649
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 14:19:24 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id i5-20020a639d05000000b003822fae3e50so10995652pgd.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 14:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=fuRrXdsCRqzg+1qCb9I6FDwYnHbmBjFKNJzRCp889gI=;
        b=mSvbRLjZlEuNr3hOqr3SnLbD5VGTWYgzxgkDHx2f1FFZ6T5zX7WI78xnPd4g0+2gsj
         WNquXwnAoydST/zdOKhm1bdFeyEICKdGePtNaUzEP0chC/AG0WkV905CC6P/hyZWYF/b
         R+VJoci9IFfgaoYWdLCQg07mHyQY1SK7K9WIYGEB2jVfVuQXE9fYpQf1W4ugnmy0QAa/
         fb8Ns04udpQVrelCmrlxkhOq9vUaVbNY7Ne+qiCh2Mi4lfikP2PJIKSxgpdZAEQS1uYT
         oM2BSQAE2WqN5cmf4obYrTaorx2Vw3MPHIR8YgFtBRxorgRslAQ1rDomcsQc/GxcbiLg
         DA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=fuRrXdsCRqzg+1qCb9I6FDwYnHbmBjFKNJzRCp889gI=;
        b=tyZP/Tp2WVH/LU2e1ihquogNYToM8OTEFELPMpmnpcR0tCen5qOCGT7OGS22IBLO4k
         eXCENQUn0CuwEGX9UGXK3y3d0+DaVd80K3VTsI13ufTybcxsjmyeQq88qPGgODTF/qlO
         Y1SfINiChl+WbZ8CUX2LKBVItdB2uOPVq2N770dFfP08GVfOSvDOZW1OPAe9kb6UjSmP
         aTb5aqm5hwFLmKbJg5dHS8maO7AChHDS11wsOoP01K6vbG4ahvKSPGAV2RLWqKmdE3tC
         bFqip4VcdLEg9UgeyZ2Gypv2Wkl4ebetGbCimKPI0xqCEHP1+kuv0sbdFZXw5YyNEmua
         u7tg==
X-Gm-Message-State: AOAM533XuVOAA590aQgw0W23AO0+RM7H5xSIzV7VgzdQnaFptw4a2Y2b
        WpAs7KcoM0CmRq+77oD3As8ZvmkntehFRA==
X-Google-Smtp-Source: ABdhPJzdrVi0R47ZBI8ptCRS0efMitOQkIjBVNm4zsAF5CecIf1bXbm2Nj8afilXP7/k/A1qk0c0UqqxxzAs9g==
X-Received: from wonchungspecialist.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1440])
 (user=wonchung job=sendgmr) by 2002:a17:903:1104:b0:154:c628:e7c2 with SMTP
 id n4-20020a170903110400b00154c628e7c2mr1789861plh.54.1648675164072; Wed, 30
 Mar 2022 14:19:24 -0700 (PDT)
Date:   Wed, 30 Mar 2022 21:19:13 +0000
Message-Id: <20220330211913.2068108-1-wonchung@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v2] sound/hda: Add NULL check to component match callback function
From:   Won Chung <wonchung@google.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Won Chung <wonchung@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Component match callback function needs to check if expected data is
passed to it. Without this check, it can cause a NULL pointer
dereference when another driver registers a component before i915
drivers have their component master fully bind.

Fixes: 7b882fe3e3e8b ("ALSA: hda - handle multiple i915 device instances")
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Won Chung <wonchung@google.com>
---
- Add "Fixes" tag
- Send to stable@vger.kernel.org

 sound/hda/hdac_i915.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/hda/hdac_i915.c b/sound/hda/hdac_i915.c
index efe810af28c5..958b0975fa40 100644
--- a/sound/hda/hdac_i915.c
+++ b/sound/hda/hdac_i915.c
@@ -102,13 +102,13 @@ static int i915_component_master_match(struct device *dev, int subcomponent,
 	struct pci_dev *hdac_pci, *i915_pci;
 	struct hdac_bus *bus = data;
 
-	if (!dev_is_pci(dev))
+	if (!dev_is_pci(dev) || !bus)
 		return 0;
 
 	hdac_pci = to_pci_dev(bus->dev);
 	i915_pci = to_pci_dev(dev);
 
-	if (!strcmp(dev->driver->name, "i915") &&
+	if (dev->driver && !strcmp(dev->driver->name, "i915") &&
 	    subcomponent == I915_COMPONENT_AUDIO &&
 	    connectivity_check(i915_pci, hdac_pci))
 		return 1;
-- 
2.35.1.1021.g381101b075-goog

