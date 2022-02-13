Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6F04B3D92
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 21:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238293AbiBMUu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 15:50:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235607AbiBMUuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 15:50:23 -0500
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50FE53711;
        Sun, 13 Feb 2022 12:50:16 -0800 (PST)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 4813A2010EB;
        Sun, 13 Feb 2022 20:50:15 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 1F21880727; Sun, 13 Feb 2022 21:47:58 +0100 (CET)
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH 0/4] hw_random: introduce rng_quality sysfs attribute
Date:   Sun, 13 Feb 2022 21:46:27 +0100
Message-Id: <20220213204631.354247-1-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the hw_random core exposes a module parameter "current_quality".
However, that is fundamentally broken: If it is set at boot time, it is
overwritten once the first hw rng device is loaded. If it is set at
runtime, it is without effect if the hw rng device had its quality value
set to 0 (and no default_quality was set). If a new rng is selected, it
gets overwritten.

Therefore, let's mark it as obsolete, and replace it with a new sysfs
attribute named "rng_quality". This sets the quality setting of the
hw rng device currently loaded and active, and starts/stops the hwrng
kernel thread as required.

Dominik Brodowski (4):
  hw_random: do not bother to order list of devices by quality
  hw_random: start and stop in-kernel rngd in separate function
  hw_random: use per-rng quality value instead of global setting
  hw_random: introduce rng_quality sysfs attribute

 drivers/char/hw_random/core.c | 145 +++++++++++++++++++++++++---------
 1 file changed, 107 insertions(+), 38 deletions(-)

---
If preferred, the "current_quality" module parameter can be removed
altogether.

-- 
2.35.1

