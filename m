Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA544D18B2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 14:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233629AbiCHNHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 08:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiCHNHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 08:07:51 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39E248316;
        Tue,  8 Mar 2022 05:06:54 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id j26so18086040wrb.1;
        Tue, 08 Mar 2022 05:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QVUkiMBPzb0V6Lwr/lYCzPY0l/r9IyoIGkL0psVfcQI=;
        b=qzXZpTAo/WJaeuIoQBRD5jTnhWiPQOyDSdWnCQNbzQThVGfJFRmQDwh9PK25ZJkk7W
         dAPsQXTWgokt3vcoJV8Ag+/tPVYRe62tIzAwPd89fyCg9GhgKmpmkyKl/E/NiP2PnGf7
         3aWMEuqfAAecFDBaeFqphSe028pjKKm0S8rRPCTjqlhVu69JhfijMUdsfkTHnqwyDSRb
         PeVozssOnR+3OEmnVziuR+OyNTBqLjoBNyrO/X/898eW6r7wRwL/F7U8uoWuvWiz3Sp0
         AIrJjFX6FgTBL2t2hpFvzTFyaWdVv2/ZclGogNMZBd4WFhGZ8Xj3N+fg07LhYwqItCz3
         B+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QVUkiMBPzb0V6Lwr/lYCzPY0l/r9IyoIGkL0psVfcQI=;
        b=068LgPt1nbdeYj6zFjyFy+hUa2MJd8BmDKGbg3vNNBSUrdYlRUqEZGdnFf0qsyfh7n
         aAUCAM4Kq7zIKJHOSl706Q9h8t9hZjRQjQv/S5f63Edjo4MJdJ1MuNVMugKJ7P7K+h5K
         YvN/AAzKt/sMAg5TxNLcM7AjReIYWHAbfwHiyZ923rLCaGeXikzzpWEq8ZeRO6/l9qAk
         7SbB5oaaHWe9oZm2O/84OXMJd45p3hhbdneVUm3VYWan3Z9fwNdMJQK1HwmK5gIZV08+
         4EKzA2QuOtrBmBIPFyjWWTjGwJ7U7zENgRNbmwLrYxVlj9807UeqTO1HfagoVdqtki/c
         sErw==
X-Gm-Message-State: AOAM531PJgLSR1gGP5IR96xgJd9qrG5K2s4Rj0lrzTqmFqoiSK2bmeK+
        zKEZWnATXVaqNq5enLHHnVE=
X-Google-Smtp-Source: ABdhPJwEXW2eoxeiOUY7hBK48npDtQn6u2AmK1ULMUO0dMBQUJaUo2G2MAIrO/TZM9EuRy0f2RfUWQ==
X-Received: by 2002:a5d:6985:0:b0:1f0:4916:4d00 with SMTP id g5-20020a5d6985000000b001f049164d00mr12099481wru.461.1646744813267;
        Tue, 08 Mar 2022 05:06:53 -0800 (PST)
Received: from monk.home ([2a01:cb10:430:ec00:4737:d56e:186b:af1])
        by smtp.gmail.com with ESMTPSA id p15-20020a05600c1d8f00b003899d50f01csm2129159wms.6.2022.03.08.05.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 05:06:52 -0800 (PST)
From:   Christophe Branchereau <cbranchereau@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: [PATCH v2 0/4] Ingenic DRM bridge_atomic_enable proposal
Date:   Tue,  8 Mar 2022 14:06:39 +0100
Message-Id: <20220308130643.260683-1-cbranchereau@gmail.com>
X-Mailer: git-send-email 2.34.1
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

 .../panel/leadtek,ltk035c5444t-spi.yaml       |  59 +++
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c     |  19 +-
 drivers/gpu/drm/panel/Kconfig                 |   9 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-abt-y030xx067a.c  |  23 +-
 drivers/gpu/drm/panel/panel-innolux-ej030na.c |  31 +-
 .../gpu/drm/panel/panel-newvision-nv3052c.c   | 497 ++++++++++++++++++
 7 files changed, 627 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/leadtek,ltk035c5444t-spi.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-newvision-nv3052c.c

-- 
2.34.1

