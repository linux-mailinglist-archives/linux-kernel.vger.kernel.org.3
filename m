Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D55F576895
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 22:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiGOU5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 16:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiGOU5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 16:57:36 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC83463934
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 13:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657918655; x=1689454655;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TtuzAApJTU9hGEQXjVipEzK3N3TBAUeeSEWLjmWbJF8=;
  b=IYk+A3fd9IDbhSSlEhjlWtjnGrgwjwco6uN4sEp0vhfaJci1uzlKrIev
   hH29UQ8Dey68szHIUwo6FAlfOnZBL5LXrvoCNb/nw+vW1zaMbaogMyZj+
   E0e975OVCdnKh1fViy+6bovBVGG17NAgRsyq4wRrVmGq9Vqvf6y/BsqUW
   ToIZLrnxYfiAXZtx8PTQnGMS0BKbemPPyqGJ05DQZ8WUnqNOMpUHy85yi
   6i8WKI1xrYFuWRkOCW1RZAi5m79wGzEl6i9MaBJinO9zOtXynZnHRSzsS
   P80rBu7mK9LFVRuCPc41jZ72cmrDkC6q2y9mYFNEMwCII4Eca5hMiJUyL
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="268919561"
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="268919561"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 13:57:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="654496590"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 15 Jul 2022 13:57:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 06FFF1A0; Fri, 15 Jul 2022 23:57:41 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] ALSA: isa: Use INVALID_HWIRQ definition
Date:   Fri, 15 Jul 2022 23:57:37 +0300
Message-Id: <20220715205737.83076-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use specific definition for invalid IRQ. It makes the
code uniform in respect to the constant used for that.
No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/isa/sscape.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/isa/sscape.c b/sound/isa/sscape.c
index 0bc0025f7c19..9adaf91045e9 100644
--- a/sound/isa/sscape.c
+++ b/sound/isa/sscape.c
@@ -140,8 +140,7 @@ struct soundscape {
 	unsigned char midi_vol;
 };
 
-#define INVALID_IRQ  ((unsigned)-1)
-
+#define INVALID_IRQ  ((unsigned)INVALID_HWIRQ)
 
 static inline struct soundscape *get_card_soundscape(struct snd_card *c)
 {
-- 
2.35.1

