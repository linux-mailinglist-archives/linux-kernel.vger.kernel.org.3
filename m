Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1294ECE71
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 23:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346381AbiC3U5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 16:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbiC3U5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 16:57:38 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E11140E4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 13:55:52 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id y27-20020aa79afb000000b004fa7883f756so12646480pfp.18
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 13:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=fuRrXdsCRqzg+1qCb9I6FDwYnHbmBjFKNJzRCp889gI=;
        b=M10w2f7BstD7C/YkxqdBqK5uM+YHXdt7cblQWQ+ryWqUdSnZQPYYCoT9drOuZdMz5g
         YFTUE70bG+zoEU32ySLAFgCYe+4fwMmSQDlAwvoqlpOaK0aZh4ftlk2OeK3LAS2EKyKZ
         AgbqW1yHnwjI5N1/3M4CAU+5+9umeunbgq0FlA5cLHKEZgKD12jO4iIR+7l6mjq601mI
         73lpN/8RZ4seREOX6M/D3WFKP7ysHdrmLI6jbzQk3RsOS+P/6DGsZ3a2+FOsBrQRmWdJ
         2zo1882YSKNtv2UbbrWqSRfzntQlOUv6eI6Sn+eRHOGC7mm+ejJWsq+JRC4K9Mu0cty9
         JYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=fuRrXdsCRqzg+1qCb9I6FDwYnHbmBjFKNJzRCp889gI=;
        b=Bni4Dao9tTyAO1nJtc5vXRZU20FQK9t4e3gxxOQSXYWZE3zLOCL9bQN4HTDINUyldv
         k0/spexYtHqU6ceTWlrwvnPaBV006+2BX4qaoG3/V7iY9wEXfNSsDpHp94zpSCCFdBo0
         AUzSc81myqPX4YBlD1qYUWBlWjVukBtQSlqdt7/phAD2+D99m7i2WowNAzkkjI82vxlj
         I0gdMulJfD8psn8iy11ANn85cxe8pkKjYrDyM2KXEm7romoEPwVqYxR4T1yHnfio7/gN
         vMlAu5DOgceQvb922M8MZzFZY7YcICNyvZkmwnWPNt6kMe/tcDOpoxJ3IxdN8uBCogWV
         zr+A==
X-Gm-Message-State: AOAM532QLpo77oMLXC3Sir4yi2SrxwqQf/JvKPVzMfxdY9gDW57L/ylV
        zhW0D9CQrQ4gZuLpgoZq3j0upyRXy9X0jg==
X-Google-Smtp-Source: ABdhPJxOidzSbO2lGNLqW0nT6Qnr1sDRUAC84FarjkZhbKNtYjCY7NQ/XunZAORsrxJd/TuPX7/l1UPcf9uJdQ==
X-Received: from wonchungspecialist.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1440])
 (user=wonchung job=sendgmr) by 2002:a05:6a00:1702:b0:4fd:aae0:84a1 with SMTP
 id h2-20020a056a00170200b004fdaae084a1mr1516689pfc.12.1648673752216; Wed, 30
 Mar 2022 13:55:52 -0700 (PDT)
Date:   Wed, 30 Mar 2022 20:55:43 +0000
Message-Id: <20220330205543.2064615-1-wonchung@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v2] sound/hda: Add NULL check to component match callback function
From:   Won Chung <wonchung@google.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benson Leung <bleung@google.com>,
        Prashant Malani <pmalani@google.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Won Chung <wonchung@google.com>
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

