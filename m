Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5964622B5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 22:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbhK2VDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 16:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhK2VBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 16:01:43 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF064C11FA2D;
        Mon, 29 Nov 2021 10:26:38 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id r9-20020a7bc089000000b00332f4abf43fso11437795wmh.0;
        Mon, 29 Nov 2021 10:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GJz9RWbzi9C4eyOJNiBHCtQqCneeiBOlTZyVHZvdTbY=;
        b=JECIG/4l50bi1AFhIQiQVxZWiGpQP0WWOPoPhAO4/Ycnsrtqml9idfA0/lZWBjVxZB
         lGDKYV4R4DMiy8nkxFqyWVOffSJEglde8oGi4Z9SM7qmg8VKnHMUSgxa3qjvvac/1dkn
         cC+Ff3ZOSwFWFFgiZOC7CFf/z44mNMozJHLJqQPAYp3/fD/z6f1EfS9VVvBBntDlFfvj
         Dq+m5t/Rd+K8NoeoEUSdId8OWXLEhLs/28cSBrf53iEzMlNvoF+CkieMPOAzLggwA9VC
         CxCsOI5c2KpYsJRRvbDrTjFfpjA6izu1YkWjBulnkQs1kSvIy92EvgR8R7qNivQ9vWWg
         7WLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GJz9RWbzi9C4eyOJNiBHCtQqCneeiBOlTZyVHZvdTbY=;
        b=n6EGowy5YhLZQ7s3bCc1Vf9G0meJIg3jbJHTGjYbjrUTle7MkbvuKFdJfj36gZdi0j
         V5m6BExvCGCj74lo96DWhk4x/7LGKKnwnQCgIaDOhvLjo7dn3LzzJbusNiryIqDP+HHT
         /SnxXIesfuZcZYx3E5xxKKeA2OW5P1lj3n+F9WU6cOZpcgISEAxOb0SzRha8LcSwAAsJ
         lZ7H+8Ac9Gvn33NeXAW5tvxEkmy+vAS1JzjvkHTxlVKOu04g3TP7SWulaY5sKH/OcvVH
         lKJw+Csb7ZzJvNloi0hVypiLovk4Tq8lun/YymR8sZIxcsFHLMIyNv+SkOgTSCt3upfZ
         Y65A==
X-Gm-Message-State: AOAM533AeWG42QWl1ppOY72YPjCz3RANkr5+PBKG8UyVyFhQwRSMfhi/
        8Ei8cK0lCqAdoEShTVBLqlK3ONlwF+SXEQ==
X-Google-Smtp-Source: ABdhPJwVmS0SalFYLz6O8ewhDYaXtBZq+zhgghGAYTbCJPowe7PIeSLDtMw1cE7BD34HcoiBMnH3zw==
X-Received: by 2002:a05:600c:1549:: with SMTP id f9mr51796wmg.118.1638210397631;
        Mon, 29 Nov 2021 10:26:37 -0800 (PST)
Received: from kista.localdomain (cpe-86-58-29-253.static.triera.net. [86.58.29.253])
        by smtp.gmail.com with ESMTPSA id o12sm85907wmq.12.2021.11.29.10.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 10:26:37 -0800 (PST)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     ezequiel@vanguardiasur.com.ar, nicolas.dufresne@collabora.com,
        mchehab@kernel.org, robh+dt@kernel.org, mripard@kernel.org,
        wens@csie.org, p.zabel@pengutronix.de, andrzej.p@collabora.com,
        gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2 0/9] media: hantro: add Allwinner H6 support
Date:   Mon, 29 Nov 2021 19:26:24 +0100
Message-Id: <20211129182633.480021-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone!

Here is patchset which adds support for Hantro G2 core found in Allwinner
H6 SoC. It is slightly older core, so it needs few quirks to be
implemented:
1. It uses slightly different register layout in some cases. However, those
   differences are small, so it makes sense only to add quirks.
2. It doesn't use ring buffer for bitstream as newer variants.
3. It needs double buffering to be enabled in order to work correctly.
4. postproc must be enabled at the end of the job. It seems that core has
   some issues with latching register values if postproc registers are set
   at the beginning of the job

legacy_regs quirk could be split into 2, like legacy_regs, ring_buffer, but
I didn't see the need for that. I examined vendor sources at [1] and it
suggests that legacy_regs implies no ring buffer.

It's also unclear if core supports HEVC decoding or not. This can be
implemented later. VP9 10-bit decoding support is mentioned in manual, but
it doesn't work at the moment. This will be addressed later.

Based on top of:
https://www.spinics.net/lists/linux-media/msg202448.html

Please take a look.

Best regards,
Jernej

[1] https://github.com/CliveLau1990/imx-vpu-hantro

Changes from v1:
- fixed error path in probe function
- sorted register defines by bit number and rename some of them
- added late_postproc quirk and reversed order in condition
- factor out imx8m_vpu_g2_irq to a helper
- updated Allwinner platform code
- collected tags

Jernej Skrabec (9):
  media: hantro: Fix probe func error path
  media: hantro: add support for reset lines
  media: hantro: vp9: use double buffering if needed
  media: hantro: vp9: add support for legacy register set
  media: hantro: move postproc enablement for old cores
  media: hantro: Convert imx8m_vpu_g2_irq to helper
  media: dt-bindings: allwinner: document H6 Hantro G2 binding
  media: hantro: Add support for Allwinner H6
  arm64: dts: allwinner: h6: Add Hantro G2 node

 .../media/allwinner,sun50i-h6-vpu-g2.yaml     | 64 ++++++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  9 ++
 drivers/staging/media/hantro/Kconfig          | 10 ++-
 drivers/staging/media/hantro/Makefile         |  3 +
 drivers/staging/media/hantro/hantro.h         |  9 ++
 drivers/staging/media/hantro/hantro_drv.c     | 28 +++++-
 drivers/staging/media/hantro/hantro_g2.c      | 18 ++++
 drivers/staging/media/hantro/hantro_g2_regs.h | 17 ++++
 .../staging/media/hantro/hantro_g2_vp9_dec.c  | 76 ++++++++++++----
 drivers/staging/media/hantro/hantro_hw.h      |  2 +
 drivers/staging/media/hantro/imx8m_vpu_hw.c   | 20 +----
 drivers/staging/media/hantro/sunxi_vpu_hw.c   | 86 +++++++++++++++++++
 12 files changed, 303 insertions(+), 39 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/allwinner,sun50i-h6-vpu-g2.yaml
 create mode 100644 drivers/staging/media/hantro/sunxi_vpu_hw.c

-- 
2.34.1

