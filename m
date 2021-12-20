Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6310A47A79A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 11:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbhLTKPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 05:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbhLTKPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 05:15:39 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6500C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 02:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=alHpGosBZG9KLUVJPord3i/tdWAv/gVYDukIQiUTKBI=;
        t=1639995339; x=1641204939; b=K07fhTRDuBz1XJ0BQMX22xmeqPl28GvDtHtKt9WB0hTdrAo
        TQp3rnz09ByihGkeoWRxCkipt7fOUOc36Dv3frJumpkZGk2t/U8btpW3q68sdsLsLj7VcA/NZBA+G
        woRcK0gQturTSw2pTWNoEZ1Yr9OuFZJRvIN2NTVAipc1FH8nH6RZYCFIZrkhMIC9uUeAAg4nx+nkv
        X75cVplkODtK5+HnMAElC7CcLW0CqG0Vy4263Tdpp5otfuUrWAIUjKL50yr65XHu1fHwFh1OvH/PQ
        +1fSGACfS/o7xwy8WlUBaPb7H4GD78DRAC353S0Mb5ylrCNjqOE671fb7h4N9xkg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mzFhf-00E3ko-Uu;
        Mon, 20 Dec 2021 11:15:36 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, linux-um@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] drm/ttm: fix compilation on ARCH=um
Date:   Mon, 20 Dec 2021 11:15:22 +0100
Message-Id: <20211220111519.a4c8c6eff702.Ie4cf4e68698f6a9f546b83379bc52c266504424f@changeid>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <CAMuHMdXTRYjtfyWTVN86pn4STO2EPR1B5+KHj=wAqguXt=hpHg@mail.gmail.com>
References: <CAMuHMdXTRYjtfyWTVN86pn4STO2EPR1B5+KHj=wAqguXt=hpHg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Even if it's probably not really useful, it can get selected
by e.g. randconfig builds, and then failing to compile is an
annoyance. Unfortunately, it's hard to fix in Kconfig, since
DRM_TTM is selected by many things that don't really depend
on any specific architecture, and just depend on PCI (which
is indeed now available in ARCH=um via simulation/emulation).

Fix this in the code instead by just ifdef'ing the relevant
two lines that depend on "real X86".

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/gpu/drm/ttm/ttm_module.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_module.c b/drivers/gpu/drm/ttm/ttm_module.c
index 0037eefe3239..a3ad7c9736ec 100644
--- a/drivers/gpu/drm/ttm/ttm_module.c
+++ b/drivers/gpu/drm/ttm/ttm_module.c
@@ -68,9 +68,11 @@ pgprot_t ttm_prot_from_caching(enum ttm_caching caching, pgprot_t tmp)
 #if defined(__i386__) || defined(__x86_64__)
 	if (caching == ttm_write_combined)
 		tmp = pgprot_writecombine(tmp);
+#ifndef CONFIG_UML
 	else if (boot_cpu_data.x86 > 3)
 		tmp = pgprot_noncached(tmp);
-#endif
+#endif /* CONFIG_UML */
+#endif /* __i386__ || __x86_64__ */
 #if defined(__ia64__) || defined(__arm__) || defined(__aarch64__) || \
 	defined(__powerpc__) || defined(__mips__)
 	if (caching == ttm_write_combined)
-- 
2.33.1

