Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3710F46A91F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350067AbhLFVLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhLFVLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:11:51 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145A3C0613F8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 13:08:22 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id k37-20020a05600c1ca500b00330cb84834fso250751wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 13:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YX3z1j0kzxdvMhDSejpCHfZc5AO9HN6Aa+IgB+x/Zhc=;
        b=o1bTX+KHRMpwsOkiIqgpUIjvyUmvD53mDXlD+vGqffgVmm8qJ7Cf6HWOJLDXxM/95l
         /aYPybuvQecvUySKNdXWctZGD/eV4GYgJ96bLmmhZNbyopw1FesRDiGpPndIT5WDh1VJ
         YfNSt+f8NAonf0G5HVeqcq2/OrYWwADIW/k5OK3PBE4M5DbeK3EyMibyAbnOpw4qaLoc
         ype84W++66UlcV7pG1+aXsZXpSRthM/jZuMU7EQPAyEdWYWUhahVbmzReMdYpGXAMX0e
         4SrgOmaM8sBbPI4ktE1ZiUngws1yL/Q683qmB8st6ONL8wsSE3Q5W60w/HWQTtZ3F6Wr
         BM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YX3z1j0kzxdvMhDSejpCHfZc5AO9HN6Aa+IgB+x/Zhc=;
        b=IhMOp/ZujlWghfG60MkImQqIBZ+Ct+RoIzg9W7B3XJhiDde3KKHNOfRIYMWR6B+NmO
         phQBifd3TOGQLVe85a5bLhBsCaAH+jpo7KGoH4Ori9urX2bUbpFvtVhBn+lKqyc3+SEi
         oygIfqPjTXDotC95YBpm5D4InfR6JHx474Dd1HROb4Vw6q8nCii7l4SBrN36UkjVFppm
         jS0YGZWmmcof8CCtZmGxdHaqg1Z3jJybud0y0y2nYBmtRQlJdQiAQ1X1uGFVLx9m0PDo
         fB8uPBpMymsWzPDIYtV6/gahA/MyOIIMNf9rGH6FInWw+to8+spyhQjwYbYYlmVQeLRW
         Jd0w==
X-Gm-Message-State: AOAM533+vgTN7hwmRAHP5FAOvpmPa0/cjdzhmtrHH1wdtECAUDA9MU+V
        ySj1FwYsLpiZcjZa6/bZ4DY=
X-Google-Smtp-Source: ABdhPJx4RP8hbzwbyl65YVzTdgXZhHlULJsQKpP1erTYrNto/KFeKGG2NxVTACIVfiteVBnE6EANyA==
X-Received: by 2002:a05:600c:17c3:: with SMTP id y3mr1277188wmo.136.1638824900455;
        Mon, 06 Dec 2021 13:08:20 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c23-c0cf-f800-f22f-74ff-fe21-0725.c23.pool.telefonica.de. [2a01:c23:c0cf:f800:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id p13sm511195wmi.0.2021.12.06.13.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 13:08:19 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, alsa-devel@alsa-project.org
Cc:     jbrunet@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, broonie@kernel.org,
        lgirdwood@gmail.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 0/2] ASoC: meson: aiu: two fixes (for 5.16)
Date:   Mon,  6 Dec 2021 22:08:02 +0100
Message-Id: <20211206210804.2512999-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this series I am proposing two fixes for the "aiu" driver, used on
Amlogic Meson8, Meson8b, Meson8m2, GXBB, GXL and GXM SoCs.

The first patch is the result of me trying to understand the way how
we get the DMA buffer and address for the audio data. I'm not an expert
in terms of DMA. From what I understand we need to inform DMA core
about the limitations of the hardware. In case of AIU it's DMA address
registers only take 32 bits, so DMA core should be aware of this.

The second patch is what I could come up with to fix the infamous I2S
buffer underrun issue, also called the "machine gun noise" (MGN) bug.
After a lot of testing, debugging and comparing vendor code with the
upstream "aiu" driver I have come up with this fix. I have written down
my thoughts in the description of that patch. To be clear: these are my
thoughts, unfortunately I have no way of proving this other than asking
other people to test this patch (off-list I have already received
positive feedback along with confirmation that both 2-ch and 6-ch audio
are still working fine. Even with Kodi's menu - which is an easy way to
reproduce the MGN bug - sound output is fine with this patch).

@Mark, @Liam: It would be great if at least the second patch could be
queued as a fix for "for-5.16" as this solves a long standing buffer
underrun.
This issue is nasty because it can occur at any time and it can even
loop forever. Christian provided an example with the speakers on low
volume: [1]. Imagine the same sound on "medium" volume after playing
a movie.


Changes since v1 at [0]:
- Dropped a paragraph about FIFO IRQs from the second patch because
  Jerome has a valid point that this behavior can either mean that
  AIU_I2S_MISC is related to the FIFO or the FIFO consumer (= encoder)
- Add a bit of documentation explaining why we set the
  AIU_I2S_MISC_FORCE_LEFT_RIGHT bit (affects patch #2)
- Collect Christian's and Geraldo's Tested-by as well as Jerome's
  Acked-by for patch #2 (thanks to all three of you!)
- Cc linux-stable for the second patch
- Dropped RFC prefix


[0] https://chewitt.libreelec.tv/testing/wp2_audio_noise.mov
[1] https://patchwork.kernel.org/project/linux-amlogic/cover/20211205180816.2083864-1-martin.blumenstingl@googlemail.com/


Martin Blumenstingl (2):
  ASoC: meson: aiu: fifo: Add missing dma_coerce_mask_and_coherent()
  ASoC: meson: aiu: Move AIU_I2S_MISC hold setting to aiu-fifo-i2s

 sound/soc/meson/aiu-encoder-i2s.c | 33 -------------------------------
 sound/soc/meson/aiu-fifo-i2s.c    | 19 ++++++++++++++++++
 sound/soc/meson/aiu-fifo.c        |  6 ++++++
 3 files changed, 25 insertions(+), 33 deletions(-)

-- 
2.34.1

