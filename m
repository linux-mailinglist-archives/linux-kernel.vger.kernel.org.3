Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2027E482EF7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 09:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbiACIRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 03:17:52 -0500
Received: from mga18.intel.com ([134.134.136.126]:57712 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232140AbiACIRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 03:17:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641197871; x=1672733871;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=vx+Jv8e9lVsL1oPl0U5wGmyafcBU7KWH9XjJJZdewmU=;
  b=WnvgMYbtnxDCYEMBYAFXbu9tZUH5UhIv6S9DbArPcErtznHr7lAMkpYB
   Bkq/TjwNk3KjfiF9iXFNJjW+9nRLDey9HgSiTE0g8eJTiXGGGnbpFr96r
   bIhm0NVyDLVrbrI49ZXZpKW9MKndCJF/zl4UW7Kic60xle+ptr19hn0wE
   okzhaSCpO1AyjhNgqLgfqZDBnTattE8hFz6igFq2LhmzGNtqqdnT6fFEi
   hPlVdxN0/WF6ts32bFk2rWoQVSwsXdLky5PDSEDHDeJA8HCdEcfo94zlk
   aRP0bkEy2jA0hc+BA6+HjquKwFYkwZadWZ8EXysRL/3J41rB0+cFcwsva
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10215"; a="228851900"
X-IronPort-AV: E=Sophos;i="5.88,257,1635231600"; 
   d="scan'208";a="228851900"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 00:17:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,257,1635231600"; 
   d="scan'208";a="471581493"
Received: from inlubt0246.iind.intel.com ([10.67.198.165])
  by orsmga006.jf.intel.com with ESMTP; 03 Jan 2022 00:17:46 -0800
From:   vishakha.joshi@intel.com
To:     thierry.reding@gmail.com
Cc:     u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, jarkko.nikula@linux.intel.com,
        vijayakannan.ayyathurai@intel.com, bala.senthil@intel.com,
        tamal.saha@intel.com, lakshmi.bai.raja.subramanian@intel.com,
        vishakha.joshi@intel.com
Subject: [PATCH v1 2/2] pwm: Update the REPEAT_COUNT value
Date:   Mon,  3 Jan 2022 13:46:10 +0530
Message-Id: <20220103081610.6656-3-vishakha.joshi@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220103081610.6656-1-vishakha.joshi@intel.com>
References: <20220103081610.6656-1-vishakha.joshi@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vishakha Joshi <vishakha.joshi@intel.com>

Update the count value in the PWM_LEADIN register.

Signed-off-by: Vishakha Joshi <vishakha.joshi@intel.com>
---
 drivers/pwm/pwm-keembay.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-keembay.c b/drivers/pwm/pwm-keembay.c
index 733811b05721..4494e54e23b8 100644
--- a/drivers/pwm/pwm-keembay.c
+++ b/drivers/pwm/pwm-keembay.c
@@ -128,11 +128,14 @@ static int keembay_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (state->polarity != PWM_POLARITY_NORMAL)
 		return -EINVAL;
 
+	if (state->count > KMB_PWM_COUNT_MAX)
+		return -EINVAL;
+
 	/*
-	 * Configure the pwm repeat count as infinite at (15:0) and leadin
-	 * low time as 0 at (30:16), which is in terms of clock cycles.
+	 * Configure the PWM repeat count at (15:0) and LEADIN low time as 0 at
+	 * (30:16), which is in terms of clock cycles.
 	 */
-	keembay_pwm_update_bits(priv, KMB_PWM_LEADIN_MASK, 0,
+	keembay_pwm_update_bits(priv, KMB_PWM_LEADIN_MASK, state->count,
 				KMB_PWM_LEADIN_OFFSET(pwm->hwpwm));
 
 	keembay_pwm_get_state(chip, pwm, &current_state);
-- 
2.17.1

