Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0621D514262
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 08:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354557AbiD2Ge6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 02:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354492AbiD2Ger (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 02:34:47 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE6A7629A
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 23:31:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DAE35CE306A
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 06:31:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21056C385AF;
        Fri, 29 Apr 2022 06:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651213887;
        bh=gGK7/gBcj48QlxuUQ6aLxtWNQgyWkYr7fybLKh0KD5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MbmY5wfpkIXYzVOY7GrWXGECIEPh4shZM0RuPaXg/0Pj3b62Ok4OxUHJfO1disdc6
         v/aNccc7zhdMTWUjzv5GKqeWAEITIiynZ6Aq6cIGLE+EBCAx5+L476WZThSPpLXa6t
         93I/1eyw5mATjnSM7HXiPsJTeYs7BRTIDy+YKdEK0lfz70yTYjYuZudGITkfd12rPj
         4lgICGJ6SnFQQabh9SmD4Y5XX1+q+ES4gWn9BshAcmn1NlMVOiDEhdEBaY1ksWxClF
         c+WWMHte6ENzDZX0deLkyoqvooI1c0bqPgRHYQWbVS/NqRZTJerGzZEl3CfpyzrvSW
         g26ODSGzqn1EA==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nkK9z-001Qml-NN; Fri, 29 Apr 2022 07:31:23 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     mauro.chehab@intel.com, Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Kai Vehmanen" <kai.vehmanen@intel.com>,
        "Lucas De Marchi" <lucas.demarchi@intel.com>,
        "Pierre-Louis Bossart" <pierre-louis.bossart@intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
Subject: [PATCH 2/2] ALSA: hda - identify when audio is provided by a video driver
Date:   Fri, 29 Apr 2022 07:31:16 +0100
Message-Id: <5c3a968858a05c27e299eadf2a925d4aa91ac17a.1651212016.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1651212016.git.mchehab@kernel.org>
References: <cover.1651212016.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some devices, the hda driver needs to hook into a video driver,
in order to be able to properly access the audio hardware and/or
the power management function.

That's the case of several snd_hda_intel devices that depends on
i915 driver.

Currently, this dependency is hidden from /proc/modules and
from lsmod, making harder to identify the need to unbind the
audio driver before being able to unbind the i915 driver.

Add a reference for it at the module dependency, in order to
allow userspace to identify it, and print a message on such
cases.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

See [PATCH 0/2] at: https://lore.kernel.org/all/cover.1651212016.git.mchehab@kernel.org/

 sound/hda/hdac_component.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/hda/hdac_component.c b/sound/hda/hdac_component.c
index bb37e7e0bd79..103c6be8be1e 100644
--- a/sound/hda/hdac_component.c
+++ b/sound/hda/hdac_component.c
@@ -211,6 +211,14 @@ static int hdac_component_master_bind(struct device *dev)
 	}
 
 	complete_all(&acomp->master_bind_complete);
+
+	if (acomp->ops->owner && acomp->ops->owner->name) {
+		dev_info(dev, "audio component provided by %s driver\n",
+			 acomp->ops->owner->name);
+		module_add_named_dependency(acomp->ops->owner->name,
+					    dev->driver->owner);
+	}
+
 	return 0;
 
  module_put:
-- 
2.35.1

