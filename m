Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17D2748D3BD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 09:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbiAMIlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 03:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiAMIlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 03:41:21 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D483C061748
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 00:41:21 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id n30-20020a17090a5aa100b001b2b6509685so10062592pji.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 00:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igorinstitute-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:from:date:subject:to:cc;
        bh=NeKX+1gLQKYhB0X8obuHvvXl9+4b5UGzNCpMXUeeI7M=;
        b=EuLWrAWWL34z4THDqjvCl+hOYXkOn4Y5dAt7+FsPmXSAAtt7fvtA0K9qX2/Zhu/K1U
         qN8uNswHkHpRoHcIKEEzRELN+WTMlpQtgSSB9IWcCUmFsNCLPz4pMZEyMNuUBvXFWmwa
         GQ8vIGSdEsHkGGEY4Fgq3YwbU0dci8bJNJ9MyKGMWa7UUm5EOs8oNH4r1GGLw2DbJUr3
         bGLGpEWsJYar+oW9NmdrRj+8W+wYcpGGrLOgX5PGe9JHc/ZydYXStXZEIHmA1zzfUpex
         3BcpfNKiCSZv+R1fXILlooiT0mhqhPuc4yOmOOyISxcfnEIs8cIPvTkT5GKR3M+Q6vzX
         EJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:to:cc;
        bh=NeKX+1gLQKYhB0X8obuHvvXl9+4b5UGzNCpMXUeeI7M=;
        b=gyTi0AuYyFQEZh/lppWd9dHik2IjhZ83bd9AoDJLopHoPyIq+err8JMDt4aU9m8Uuc
         NZBTBcpVI+K3ulr/I4XyyLQtW+3cDwdsgtGQfqfrHJvAdYW1qOQexlQJT50P/Ij5UUQS
         oyga9rQ978pACerjnWVlOtOLCMN6AoM2QFPGJWM+cD+39xnoDoYfPSXiG8oOgEIlQLae
         ucISWJ1S3rHvLHzaxt+dCtbuGtc5cXRKDff3C8LNwzWrx2IXSxWslUv5Si6vTiorFo7w
         kGC18pJBKB/VvXOvMxsVBN30KQ230QDVkmnIWqhOx3Bn00jUkpwm7Zl2Y0i8Z7Q5OcKt
         qxtg==
X-Gm-Message-State: AOAM531zkDH/hBdzemfmTzNCyu8KaspylHju1arVjA0q0XG5UdBbhMHp
        Vw6rrv9ksY9+h7tQx2Nt3R0+4g==
X-Google-Smtp-Source: ABdhPJwk9ggoW0sH7LTM1lwbSOp4qCilmpuUzLoJ9HMp9f+NS1JYqbfKLULFnY4W/+uAfyCibfdT8A==
X-Received: by 2002:a17:90b:33d0:: with SMTP id lk16mr2452797pjb.45.1642063280574;
        Thu, 13 Jan 2022 00:41:20 -0800 (PST)
Received: from localhost ([121.99.145.49])
        by smtp.gmail.com with ESMTPSA id 6sm1704902pgr.88.2022.01.13.00.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 00:41:20 -0800 (PST)
Message-Id: <cover.1642063121.git.daniel.beer@igorinstitute.com>
From:   Daniel Beer <daniel.beer@igorinstitute.com>
Date:   Thu, 13 Jan 2022 21:38:41 +1300
Subject: [PATCH v2 0/2] ASoC: add support for TAS5805M digital amplifier
To:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Andy Liu <andy-liu@ti.com>,
        Daniel Beer <daniel.beer@igorinstitute.com>,
        Derek Simkowiak <derek.simkowiak@igorinstitute.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This pair of patches implements support for the TAS5805M class D audio
amplifier. This driver, and the example configuration in the device-tree
file, were originally based on a 4.19 series kernel and have been
modified slightly from the tested version.

This resubmission differs from the first as follows:

  - Some explanatory comments and constants have been introduced
  - The volume control allows L/R to be set independently
  - gpiod is used, and regmap is used directly
  - .trigger is used instead of DAPM to coordinate DSP boot
  - The component is manually registered after power-on, and explicitly
    deregistered prior to power-off
  - Corrections have been made to the bindings file

Daniel Beer (2):
  ASoC: add support for TAS5805M digital amplifier
  ASoC: dt-bindings: add bindings for TI TAS5805M.

 .../devicetree/bindings/sound/tas5805m.yaml   | 204 +++++++
 sound/soc/codecs/Kconfig                      |   9 +
 sound/soc/codecs/Makefile                     |   2 +
 sound/soc/codecs/tas5805m.c                   | 554 ++++++++++++++++++
 4 files changed, 769 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tas5805m.yaml
 create mode 100644 sound/soc/codecs/tas5805m.c

-- 
2.30.2

