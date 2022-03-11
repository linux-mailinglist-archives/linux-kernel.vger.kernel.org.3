Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F4F4D6130
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 13:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348484AbiCKMGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 07:06:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236467AbiCKMGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 07:06:03 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59FF1AEEF1;
        Fri, 11 Mar 2022 04:05:00 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id p9so12581005wra.12;
        Fri, 11 Mar 2022 04:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CluZnJvaFq+gv5SsBEdks07J31iiWkZ5fHpUB0bqBcM=;
        b=qw+ajJ3bas5PbBQI9GqAWDJtr1KHk5lF7RWDvKeZSUWN09yo6r3mVvLnJt7yrUnGGW
         gsvPxknVOA7c9SgZrcdZQk/3ro/18kya2vr/H64cqmcHGXQxwOO4zMEPhYObRUfdsU+B
         BHF2jjdpfoYCSQx+Y5G5ae/u1KXY38+LZrSmg00Q1P9Bhp1G2Fv5zTxiLOTs8MV1fkQf
         tzMlShgQCn6RUx1pGONYHEq+GJV35waRSt1OKKqg69RAF76pyKUdhkHcQFWeNm5ZDGpG
         lW3UVnxzzisq8e4IUJqjB6M3XKZfiAyg0y5Ad1BEA9nbtytriaHHdFj7HFv5BN/nN+yU
         Eqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CluZnJvaFq+gv5SsBEdks07J31iiWkZ5fHpUB0bqBcM=;
        b=kexN5pIfER/MqNFmTT0rMq5I7Nts5ZYItAT5TdnRC9wiOwpmWXIeG4lyG8Nl34Ceua
         r71n/f+06kHjafrl8qhO6UWT5dlIGUAeWgCO8JknymxnObttLtK12+8Q+8gKsufptgdR
         FRqKahUPAcdvmJEuIcsWmRPZKqVNnSSf/r/Z8y/9a8dc/641IIkTO2JiPPuetmsGD7gD
         N0dmbRexuTxJOF9eaULO/SFnK5K0Bgr2PALvbMrT5HTYmUWUcMVpkM0GU1az4H6XVHAo
         DmUhrL2WmKQuB4p26ZxlanPd9rOnTjLTP9EMzFPDjDXQOBLA4zlwQJ96kLgcpJpwuc6j
         qEqw==
X-Gm-Message-State: AOAM533bNNriM92sEnChpKBY1tADLEOfjPfcHwOz3cIIo1v/U6OUXHKo
        7yxJLWmnO1Q/4/FKALoLkBk=
X-Google-Smtp-Source: ABdhPJw60L/wNBZRfT4SbS1AbolE9XQ7lQrIbYwPi4ZXCq4AAqHgcxz8c6qE8LDV5dRnQfyrKPmEMg==
X-Received: by 2002:a05:6000:184e:b0:1f0:3569:ccac with SMTP id c14-20020a056000184e00b001f03569ccacmr7235289wri.680.1647000299064;
        Fri, 11 Mar 2022 04:04:59 -0800 (PST)
Received: from monk.home ([2a01:cb10:430:ec00:4737:d56e:186b:af1])
        by smtp.gmail.com with ESMTPSA id r20-20020adfa154000000b001f0326a23e1sm6595223wrr.88.2022.03.11.04.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 04:04:58 -0800 (PST)
From:   Christophe Branchereau <cbranchereau@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: [PATCH v3 0/4] Ingenic DRM bridge_atomic_enable proposal
Date:   Fri, 11 Mar 2022 13:04:49 +0100
Message-Id: <20220311120453.163297-1-cbranchereau@gmail.com>
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

