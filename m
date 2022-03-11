Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1C04D6709
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 18:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350496AbiCKREA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 12:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346488AbiCKRD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 12:03:56 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4E19A4E8;
        Fri, 11 Mar 2022 09:02:52 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id v2-20020a7bcb42000000b0037b9d960079so7896674wmj.0;
        Fri, 11 Mar 2022 09:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b4tMgDVBFnehXL1pb03Ti258/q2uZML0ebzleqv3Ixc=;
        b=HvaUH62WX6pUIJOi+/a29vKAhOLeIKnRopbrO4JJKhz3QmzZe6muG+Y/BEVFEy8Fse
         KAMZTnkj+diNGxkXEJswNHG4PaeViCUgUcsX58aeK9YXfjMicxgf7X1wCIZy6XIzUuxF
         IQwjY434BYdRUFTZcRveJ9kQIFhD1JeozqEl1VcafA89VELNfHMPbT5H/9eEf/XFA36i
         gG2Z0t2ecvYST3P8KuSYSKkI9npMTbzx+SwwU7cB0AUIU6mLqjcOXjPqsXzDm3U/insT
         Mz8TusuJ8GMP/wWrZAlqtKp1EBRc1TYDa96pDKOC5IKD82IfvgNRf2jq9SytW27A6ZUL
         /BSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b4tMgDVBFnehXL1pb03Ti258/q2uZML0ebzleqv3Ixc=;
        b=B0faFh2keXUBdPbc3aMwv9TieB3lfcyhZPl4xD7EyxHJRqY040E4rWPINGyDLx3x/i
         qWrQ9iE8DA7mLMEl46TaRH4Xq6xvLzIYF4IIkmWRUtXs4x3qP56DDBq+VRcj7vivdTyB
         wOmfR7koBlfRbDmgXbKA1gUr7Dnp+xAGjG4Wq0KliqW5sFVb9iMqP+XsiUUj1lrbU9i7
         y2k3y1Z0UY3zfQnOWZ2gMsybwuEE2sHIIcwEhDmcXHjHRzEp8q5Fosy17RrRVU9ZCeAd
         wPYHYhWw9FXU+SUBiLJmGo7XqIdegtnQzUkwXy5ogtHYA39pdWLb4n75z2cSZiEOAvek
         R24A==
X-Gm-Message-State: AOAM530jyuT5oBN7FnTRe2JO3rqxJX42Njb567yY9pEIfecxnKgoimJ4
        eZf9UUh0SXYeBqiw8T1+ruI=
X-Google-Smtp-Source: ABdhPJxj3jVOz/Q7IbMLbCLuZKT16k+r+6pniCJkraCXFGPsIUcmDCYdhxcNOthvBDG08MXtT0TOqQ==
X-Received: by 2002:a05:600c:3590:b0:389:f1c5:fd10 with SMTP id p16-20020a05600c359000b00389f1c5fd10mr2509465wmq.76.1647018171025;
        Fri, 11 Mar 2022 09:02:51 -0800 (PST)
Received: from monk.home ([2a01:cb10:430:ec00:4737:d56e:186b:af1])
        by smtp.gmail.com with ESMTPSA id z5-20020a05600c0a0500b0037bb8df81a2sm14067733wmp.13.2022.03.11.09.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 09:02:50 -0800 (PST)
From:   Christophe Branchereau <cbranchereau@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: [PATCH v4 0/4] Ingenic DRM bridge_atomic_enable proposal
Date:   Fri, 11 Mar 2022 18:02:36 +0100
Message-Id: <20220311170240.173846-1-cbranchereau@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4: fix the bindings license

KR
Christophe

-----------------------

Hello, v3 :

Drop -spi in the compatible string, adjust bindings doc accordingly

KR
Christophe

------------------------

Hello, this is the v2 for my set of patches :

- use dev_err_probe() instead of dev_err() in the newvision panel
driver probe function

- add bindings documentation for the Leadtek ltk035c5444t

Cheers - Christophe

------------------------

Hello, this is a set of patches to allow the upstreaming of the
NV3052C panel found in the Anbernic RG350M mips gaming handheld.

It was never upstreamed so far due to a longstanding graphical
bug, which I propose to solve by introducing ingenic_drm_bridge_atomic_enable
in the drm driver so the CRTC can be enabled after the panel itself slept
out, and not before as it used to.

After the drm change, 2 of the existing panels have to be modified accordingly
to introduce missing .enable and .disable in their code.

Christophe Branchereau (4):
  drm/ingenic : add ingenic_drm_bridge_atomic_enable
  drm/panel: Add panel driver for NewVision NV3052C based LCDs
  drm/panel : innolux-ej030na and abt-y030xx067a : add .enable and
    .disable
  dt-bindings: display/panel: Add Leadtek ltk035c5444t

 .../display/panel/leadtek,ltk035c5444t.yaml   |  59 +++
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c     |  19 +-
 drivers/gpu/drm/panel/Kconfig                 |   9 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-abt-y030xx067a.c  |  23 +-
 drivers/gpu/drm/panel/panel-innolux-ej030na.c |  31 +-
 .../gpu/drm/panel/panel-newvision-nv3052c.c   | 497 ++++++++++++++++++
 7 files changed, 627 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/leadtek,ltk035c5444t.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-newvision-nv3052c.c

-- 
2.35.1

