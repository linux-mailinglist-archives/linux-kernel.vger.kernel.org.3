Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB814ECB86
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 20:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349828AbiC3SPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 14:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349883AbiC3SPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 14:15:23 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C4C38BFD
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 11:13:34 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id e12-20020a63544c000000b003985d5888a8so4924803pgm.15
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 11:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=AjhARMzQL0Dz2caZ6eH2qC8gHB5UHTkecFAhF8mtRwA=;
        b=ZljIC8cv2Svvv2yZGesXGMC+9DFWAF2YLvz0S57zqy+LDjREvs7+4A/ZvCANVBUvWV
         Put4tkMFC7k/hwHDjyW/3LGORVs4U24tPPH9ePDKa1gx1+5Uqhp6FYpljJDo47wrMkn9
         QdoDx3Ell9RTAZy2kvPYJta6vmRwWeSWTt9fllohNBolSU190kAoyKBXje69uv/FSnk7
         YymVdmSk4V52dSSXnDTNpUW0wICGqQ7F5IV6jkhnUx3mQ4N+QPYBHC7+BeVT9s7exAOw
         r05aOze5ddP8eA1/o2AGNDQq1lgZ6Mnj1AqOOeGocjxdzyrLHg7y1CYUFzaQHdO3goJL
         aqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=AjhARMzQL0Dz2caZ6eH2qC8gHB5UHTkecFAhF8mtRwA=;
        b=G5nzELGm584T6O9tYtg1BnMpETeTkAb4kupnmIb3zQgaW+VcWLkUTRwfyeGAbXRYcv
         VS4bjLRd6NNIJjwjQmrJTWYmlwc34iEqduNHHsHHhufwzQNgury/GRUggVLw/F6jC/Nq
         2QXiB2vTx+2I+NOxCvQBLjX4phYfd3UrZ5oUFXSrhtdA9jgKjJW4HmKpkTeyXHjIouBd
         xdws4KTYccA0sePT7wIzZ1usvoMC9bfxRh2oXLlHh7GCDqAEFY1jTsk3AUZIwHXftGGn
         ER4bmIaegMQRGTxAt183KBcXnthuPIxZ9zj9qyTKKwP5wSKsXsrhhaRsTwiKkj05pO0o
         EOyw==
X-Gm-Message-State: AOAM533QFr/8Aqm9syEdmy6Pzf5lmJ/8dgshxdz4AlpN1zScDSuYS16L
        pFkwbnF5mzgnREE7sGaaLj/MxVU0EZJ47Q==
X-Google-Smtp-Source: ABdhPJxvmeFlDmbAYjOYwo8BReE8wTDosyVOpFTfeoM9IcZElYFnjr7n0JuuABxUSoc42b0yUcOO3UODFdaPJQ==
X-Received: from wonchungspecialist.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1440])
 (user=wonchung job=sendgmr) by 2002:a17:90a:858b:b0:1c6:5bc8:781a with SMTP
 id m11-20020a17090a858b00b001c65bc8781amr121147pjn.0.1648664013526; Wed, 30
 Mar 2022 11:13:33 -0700 (PDT)
Date:   Wed, 30 Mar 2022 18:13:30 +0000
Message-Id: <20220330181330.2046874-1-wonchung@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH] sound/hda: Add NULL check to component match callback function
From:   Won Chung <wonchung@google.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benson Leung <bleung@google.com>,
        Prashant Malani <pmalani@google.com>,
        linux-kernel@vger.kernel.org, Won Chung <wonchung@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Component match callback function needs to check if expected data is
passed to it. Without this check, it can cause a NULL pointer
dereference when another driver registers a component before i915
drivers have their component master fully bind.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Won Chung <wonchung@google.com>
---
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

