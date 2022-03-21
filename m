Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863D54E27C3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 14:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiCUNie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 09:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235400AbiCUNic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 09:38:32 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D591BAC073;
        Mon, 21 Mar 2022 06:37:05 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l7-20020a05600c1d0700b0038c99618859so1295651wms.2;
        Mon, 21 Mar 2022 06:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rmkzVJ7lPDe71qmJ25R6AMfvf9UDRM65tLBzs5QDkYM=;
        b=iLBFeSWPiXwVdVcwIuy6GOVhOfiIEdNdnew2OVu/3VdMYmn8EQsGhB9nkOzeluNv/z
         5/JDptmKB6dyn23iR67L1w/jLfL7LdKBVWAE9DCyutz/J+ZVCfUBC9o6/FmZrvpqaXql
         kYosN3MKPCSp6LDw3idHShhSyfvHjg3Wd6AynVl9Hqs1jiuWRLZdQkNzD//C8RBbZjUY
         araiUUqGsKqbmkZP2yvCTLdzeOg2aMmq2ZvIwy6vRzxhxkf0LKrsD5D8+U1N76py2um1
         IM7LNnUbv2cTEuxsXoojjbM63dyDlpmu+nJZA+aV69samqFzU1Z21/O4b4OCp7naBn3H
         JYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rmkzVJ7lPDe71qmJ25R6AMfvf9UDRM65tLBzs5QDkYM=;
        b=Aa4GLi6zxmOTrdZLAmpkkZh5lL6EH2srauo0OgCkRSZrzmZmky6ZhtrXbMDYy1mw24
         lFggyOH7UEt/0yBVuLDwrtquVbk+XZFWLQT9Ik6O0+LPEoRM0AWmjF7Y8WuQKExee6Ks
         LNktunS4xxhNjyOWs03PWsv9qIUvbLlCAUeKcA/AUF4kowsCx3aXR+r2N/1lqIcLjgQw
         pS21aqzJLkNKg6VLK4c+pAWKGLbQVLFU6CUbbPnjj1XeAZdVDgc7TMBmeMpGlQRwBFpw
         dtrHDeyu541bGWHP/E+wVaFtgC1Pn1cdSoOTDgODYyLg3BKjqCZR4syAksOAX7EgDoIu
         OS1g==
X-Gm-Message-State: AOAM532A8uEgH5tkm+Y922YUXSWPxBDaMpn1zLF3YfRdM2jGaM/g6vmo
        71huYDZoILk19XP2j+T99yg=
X-Google-Smtp-Source: ABdhPJyJztpZEF5HTmRWNv59asHTB2LyorTcORvSou9IrxfnYCvCgsEFrP4Vw4TR0ml++AXeJuR0PQ==
X-Received: by 2002:a05:600c:a0a:b0:350:564b:d55e with SMTP id z10-20020a05600c0a0a00b00350564bd55emr19446726wmp.124.1647869824164;
        Mon, 21 Mar 2022 06:37:04 -0700 (PDT)
Received: from monk.home ([2a01:cb10:430:ec00:4737:d56e:186b:af1])
        by smtp.gmail.com with ESMTPSA id w5-20020a5d5445000000b00203f8c96bcesm7969426wrv.49.2022.03.21.06.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 06:37:03 -0700 (PDT)
From:   Christophe Branchereau <cbranchereau@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: [PATCH v5 0/3] Ingenic DRM bridge_atomic_enable proposal
Date:   Mon, 21 Mar 2022 14:36:48 +0100
Message-Id: <20220321133651.291592-1-cbranchereau@gmail.com>
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

Hello,

v5 :

- this set doesn't include the nv3052c bindings doc anymore,
  as it's already applied

- nv3052c panel driver : removed empty lines, proceed to turn it off
  even is sleeping in fails instead of stopping there

- abt panel : switched to REGCACHE_FLAT so we can disable sleep mode
  in .enable with regmap_set_bits() instead of doing it at init time

- ingenic-drm-drv : added ingenic_drm_bridge_atomic_disable to balance
  out ingenic_drm_bridge_atomic_enable

Tested working on the rg350m and rg280m

Christophe Branchereau (3):
  drm/ingenic : add ingenic_drm_bridge_atomic_enable and disable
  drm/panel: Add panel driver for NewVision NV3052C based LCDs
  drm/panel : innolux-ej030na and abt-y030xx067a : add .enable and
    .disable

 drivers/gpu/drm/ingenic/ingenic-drm-drv.c     |  34 +-
 drivers/gpu/drm/panel/Kconfig                 |   9 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-abt-y030xx067a.c  |  31 +-
 drivers/gpu/drm/panel/panel-innolux-ej030na.c |  31 +-
 .../gpu/drm/panel/panel-newvision-nv3052c.c   | 484 ++++++++++++++++++
 6 files changed, 572 insertions(+), 18 deletions(-)
 create mode 100644 drivers/gpu/drm/panel/panel-newvision-nv3052c.c

-- 
2.35.1

