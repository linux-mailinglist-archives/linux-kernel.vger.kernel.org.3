Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F1547435A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 14:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbhLNNYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 08:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbhLNNYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 08:24:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709E7C061574;
        Tue, 14 Dec 2021 05:24:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 113DD614D8;
        Tue, 14 Dec 2021 13:24:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10F5C34601;
        Tue, 14 Dec 2021 13:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639488241;
        bh=2S74gn7u7PuWik2kpPjlH1SoUisH+72JMDuC0K0kPhs=;
        h=From:To:Cc:Subject:Date:From;
        b=VjZrWCHtm7QDcAG69RpSxJWayTP2do7OraInWl7qNS4pULeobTdzZwhtpXYt3Zq54
         EuGjAfsvb51bo0vL2zCg+DSmJNO/2bGFgtobr+lm9hPemF451EwehxotTG/6zyU459
         t1k7n0cC7c6/N1SasNx28qTLsIf5qjOmejG/7HhPxWcjfitGQ7+H2uIP57h/ca9CnB
         GWNcGTfnqMghfOIbr7KO+vlrkfwkvdch+oFIWxvnDASv5ehc0C/KoIhImn6UZatTXC
         K1TIdd43k/UXtkJrXoM4pH+XTFKYdy/K+J3oaDkR9MkZjXVCRDeL5PUTwv7ARF+cH1
         LMaJpLtBHMT8w==
From:   broonie@kernel.org
To:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Ramalingam C <ramalingam.c@intel.com>,
        Stuart Summers <stuart.summers@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>
Subject: linux-next: manual merge of the drm-intel-gt tree with the drm-intel tree
Date:   Tue, 14 Dec 2021 13:23:56 +0000
Message-Id: <20211214132356.2833931-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the drm-intel-gt tree got a conflict in:

  drivers/gpu/drm/i915/i915_pci.c

between commit:

  6678916dfa012 ("drm/i915: Move pipe/transcoder/abox masks under intel_device_info.display")

from the drm-intel tree and commit:

  c83125bb2199b ("drm/i915: Add has_64k_pages flag")

from the drm-intel-gt tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc drivers/gpu/drm/i915/i915_pci.c
index ae36dfd77dcfa,332cb8b25e494..0000000000000
--- a/drivers/gpu/drm/i915/i915_pci.c
+++ b/drivers/gpu/drm/i915/i915_pci.c
@@@ -1027,6 -1015,8 +1027,7 @@@ static const struct intel_device_info x
  	DGFX_FEATURES,
  	PLATFORM(INTEL_XEHPSDV),
  	.display = { },
+ 	.has_64k_pages = 1,
 -	.pipe_mask = 0,
  	.platform_engine_mask =
  		BIT(RCS0) | BIT(BCS0) |
  		BIT(VECS0) | BIT(VECS1) | BIT(VECS2) | BIT(VECS3) |
