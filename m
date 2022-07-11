Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05D4570B67
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbiGKU0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbiGKUZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:25:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A903C8C4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 13:25:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D9E2B811B6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 20:25:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085C9C34115;
        Mon, 11 Jul 2022 20:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657571123;
        bh=gmUsOXoQJn4VasGdRabTn//YULN5ONt5Qo/z2YXpkw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=beVau9XqV6z2ujjPu0EBBrK1UT5fo0ZgcW+NtaZx5kIjL6ceFS2Ug1ZYg9OX0lcqt
         cBS4CgmZP+BQuezzkYcbT5jqvHnGFpKJwVmRuepSeWlG0OaakiJlmKd0wl7Ye8+uF5
         cXS/bbWtT5UmPYnxKbmH8vmyM2JchrKLjaexbtWKTGCQhovq7WqumRLsTI5A1UkXCY
         7rBLEeq+6TrLDeM7b4clTV4r+9AunCxQKKewspd+8wRqnPme+m/atqf9vQTtI9J2v0
         f3fYeETnnL29zuJNXaxM9M7HTyUzcaqQohuhBg39YKV0gvNL9Bspf6M65DXUuP7bIp
         biCUbjo4odRvw==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oAzy3-004e8A-Jz;
        Mon, 11 Jul 2022 21:25:19 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        "Lucas De Marchi" <lucas.demarchi@intel.com>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 15/32] drm/i915: intel_pm.c: fix some ascii artwork at kernel-doc
Date:   Mon, 11 Jul 2022 21:25:00 +0100
Message-Id: <eb7522b15921a505e88572b128e0caabf9574b2b.1657565224.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657565224.git.mchehab@kernel.org>
References: <cover.1657565224.git.mchehab@kernel.org>
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

followed by a blank line and indended lines.

But kernel-doc only works fine if the first and the last line
are indented with the same amount of spaces.

Also, a "\" at the end means that the next line should be merged
with the first one.

Change the ascii artwork to be on code-blocks, starting all
lines at the same characters and not ending with a backslash.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/32] at: https://lore.kernel.org/all/cover.1657565224.git.mchehab@kernel.org/

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

