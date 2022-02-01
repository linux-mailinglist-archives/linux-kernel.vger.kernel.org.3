Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437834A5FC5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 16:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239697AbiBAPM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 10:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiBAPMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 10:12:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549A5C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 07:12:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 228ACB82E40
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 15:12:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5544C340EB;
        Tue,  1 Feb 2022 15:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643728341;
        bh=i270dEkTJv5t4/J/okLhEZ/3ZKQGlqKsKjrGaTnjh/o=;
        h=Date:From:To:Cc:Subject:From;
        b=fyUuK6HpBeQbf6/6n34dLATSFYfzZVFjA0RWLkqzLgQ4SuvTjtfIkbiQnK9atE1lf
         UYbjk7BEmP9n+w8jzuLkxpqgOpSE5FJZDR8xR0jEF+aApRNOHSkkT1SIVsXiDrsd08
         qT+5CjNV6jvIctp3E/HaFKL7ICK+3PbluQDA/eAI57/hyCf36+VabWHzDxMo5yBunA
         pny823Lcod8/VCmBeCyazK3Qs+CtkBRct++IKU+CCQ4dUGJapdjcZ4YOYb4mf83pj9
         DBHBQ6PomcMonnGx2cG+doFpOg4cF30xH77xZ/u5yAUD1OkTO5y+ghZayPZczn5Mde
         YBvj6xDu6KEAA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 76A1040466; Tue,  1 Feb 2022 12:12:18 -0300 (-03)
Date:   Tue, 1 Feb 2022 12:12:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1 fyi] tools include UAPI: Sync sound/asound.h copy with
 the kernel sources
Message-ID: <YflN0j09T+6ODHIh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Picking the changes from:

  55b71f6c29f2a78a ("ALSA: uapi: use C90 comment style instead of C99 style")
  fb6723daf89083a0 ("ALSA: pcm: comment about relation between msbits hw parameter and [S|U]32 formats")
  b456abe63f60ad93 ("ALSA: pcm: introduce INFO_NO_REWINDS flag")
  5aec579e08e4f2be ("ALSA: uapi: Fix a C++ style comment in asound.h")

Which entails no changes in the tooling side as it doesn't introduce new
SNDRV_PCM_IOCTL_ ioctls.

To silence this perf tools build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/sound/asound.h' differs from latest version at 'include/uapi/sound/asound.h'
  diff -u tools/include/uapi/sound/asound.h include/uapi/sound/asound.h

Cc: Mark Brown <broonie@kernel.org>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/sound/asound.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/sound/asound.h b/tools/include/uapi/sound/asound.h
index 5fbb79e30819af91..ef0cafe295b28253 100644
--- a/tools/include/uapi/sound/asound.h
+++ b/tools/include/uapi/sound/asound.h
@@ -202,6 +202,11 @@ typedef int __bitwise snd_pcm_format_t;
 #define	SNDRV_PCM_FORMAT_S24_BE	((__force snd_pcm_format_t) 7) /* low three bytes */
 #define	SNDRV_PCM_FORMAT_U24_LE	((__force snd_pcm_format_t) 8) /* low three bytes */
 #define	SNDRV_PCM_FORMAT_U24_BE	((__force snd_pcm_format_t) 9) /* low three bytes */
+/*
+ * For S32/U32 formats, 'msbits' hardware parameter is often used to deliver information about the
+ * available bit count in most significant bit. It's for the case of so-called 'left-justified' or
+ * `right-padding` sample which has less width than 32 bit.
+ */
 #define	SNDRV_PCM_FORMAT_S32_LE	((__force snd_pcm_format_t) 10)
 #define	SNDRV_PCM_FORMAT_S32_BE	((__force snd_pcm_format_t) 11)
 #define	SNDRV_PCM_FORMAT_U32_LE	((__force snd_pcm_format_t) 12)
@@ -300,7 +305,7 @@ typedef int __bitwise snd_pcm_subformat_t;
 #define SNDRV_PCM_INFO_HAS_LINK_ESTIMATED_ATIME    0x04000000  /* report estimated link audio time */
 #define SNDRV_PCM_INFO_HAS_LINK_SYNCHRONIZED_ATIME 0x08000000  /* report synchronized audio/system time */
 #define SNDRV_PCM_INFO_EXPLICIT_SYNC	0x10000000	/* needs explicit sync of pointers and data */
-
+#define SNDRV_PCM_INFO_NO_REWINDS	0x20000000	/* hardware can only support monotonic changes of appl_ptr */
 #define SNDRV_PCM_INFO_DRAIN_TRIGGER	0x40000000		/* internal kernel flag - trigger in drain */
 #define SNDRV_PCM_INFO_FIFO_IN_FRAMES	0x80000000	/* internal kernel flag - FIFO size is in frames */
 
-- 
2.34.1

