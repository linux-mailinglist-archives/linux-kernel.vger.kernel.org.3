Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A714A57308D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235228AbiGMIOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235035AbiGMIMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:12:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61B8EA149
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:12:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0DE46B81D5D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:12:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17757C341D1;
        Wed, 13 Jul 2022 08:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657699952;
        bh=Y+j9h2/Gg05L5+/jOiZctvjKtqK2vTBsMQQXHDXjeyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n05rtdWWv9LVuNm8ELboHpiSAnHTTxuuFoWOd7TJNVsltIVey4kiqY7aYJP0G0Irt
         iwanK7JOY+9tOq66ykvoHKyITQTlvO63Nvzw4Ydb6eZAhJPYQKaQ5W9LhuXYKp7o8+
         KGLZbkvdYYHeXuGZAQ/N8lfaCd6H6gDKyaoYI40x10QdAmgRVcCyxP5gLr+E2Plojd
         D6G9g3n/N34EGAMZKSWQTrZNfh5ycSkyMUWV1imw1V5CTYERyDAxUk1ag2hIgdBmq0
         W2bDtXznFKYUWgl4wNzgKmO7yGvlDp1f0fT7PyLz1QwvOoRemqpLF4tT/Q2c8PBRYJ
         jPlmWxltQ9PsA==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oBXTx-004ztU-Lv;
        Wed, 13 Jul 2022 09:12:29 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 18/39] drm/i915: intel_pm.c: fix some ascii artwork at kernel-doc
Date:   Wed, 13 Jul 2022 09:12:06 +0100
Message-Id: <b3657e96ea87a5803ed27d1cc0d9fa44b2f164cf.1657699522.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657699522.git.mchehab@kernel.org>
References: <cover.1657699522.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Preserving ascii artwork on kernel-docs is tricky, as it needs
to respect both the Sphinx rules and be properly parsed by
kernel-doc script.

The Sphinx syntax require code-blocks, which is:

	::

followed by a blank line and indented lines.

But kernel-doc only works fine if the first and the last line
are indented with the same amount of spaces.

Also, a "\" at the end means that the next line should be merged
with the first one.

Change the ascii artwork to be on code-blocks, starting all
lines at the same characters and not ending with a backslash.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/39] at: https://lore.kernel.org/all/cover.1657699522.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/intel_pm.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_pm.c b/drivers/gpu/drm/i915/intel_pm.c
index f06babdb3a8c..d3393752b04b 100644
--- a/drivers/gpu/drm/i915/intel_pm.c
+++ b/drivers/gpu/drm/i915/intel_pm.c
@@ -684,18 +684,20 @@ static const struct intel_watermark_params i845_wm_info = {
  * FIFO is relatively small compared to the amount of data
  * fetched.
  *
- * The FIFO level vs. time graph might look something like:
+ * The FIFO level vs. time graph might look something like::
  *
- *   |\   |\
- *   | \  | \
- * __---__---__ (- plane active, _ blanking)
- * -> time
+ *   ^
+ *   |   |\   |\      (                          )
+ *   |   | \  | \     (                          )
+ *   |   __---__---__ (- plane active, _ blanking)
+ *   +-------------------> time
  *
- * or perhaps like this:
+ * or perhaps like this::
  *
- *   |\|\  |\|\
- * __----__----__ (- plane active, _ blanking)
- * -> time
+ *   ^
+ *   |     |\|\  |\|\   (                          )
+ *   |   __----__----__ (- plane active, _ blanking)
+ *   +-------------------> time
  *
  * Returns:
  * The watermark in bytes
@@ -731,13 +733,14 @@ static unsigned int intel_wm_method1(unsigned int pixel_rate,
  * FIFO is relatively large compared to the amount of data
  * fetched.
  *
- * The FIFO level vs. time graph might look something like:
+ * The FIFO level vs. time graph might look something like::
  *
- *    |\___       |\___
- *    |    \___   |    \___
- *    |        \  |        \
- * __ --__--__--__--__--__--__ (- plane active, _ blanking)
- * -> time
+ *   ^
+ *   |     |\___       |\___        (                          )
+ *   |     |    \___   |    \___    (                          )
+ *   |     |        \  |        \   (                          )
+ *   |  __ --__--__--__--__--__--__ (- plane active, _ blanking)
+ *   +---------------------------------> time
  *
  * Returns:
  * The watermark in bytes
-- 
2.36.1

