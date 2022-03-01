Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3724C8F1B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 16:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbiCAPcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 10:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbiCAPcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:32:20 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5012B26C4;
        Tue,  1 Mar 2022 07:31:38 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id d3so21148426wrf.1;
        Tue, 01 Mar 2022 07:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E0v1/XoAfo8OiusawK2xptMevQgjSP/uOA1ylFEwvrk=;
        b=q6Gl7JqGRLJ0IZnenEDJZ/SUKFSNwODzYLrxYwlmeP0SmOiTSYPCOALs3UAeL5KFBo
         tqm+ucw3tVQoLNOZCvGiGAX9YCFeDMuAmrEdX2Ptln3sl1Vufdf3Cx3hqWAkv5Y2KKgE
         jbA53JJouHY3E/H3giRlhRK/cNIfxfwPPXLlY2Js8L+Pxi+ubQVMQhlK535HkuZMhsOL
         vLCJcGGldWV6BsziBqqUWvnc/r8yLuHOaQa0PWeuqOwYgOMcdmw/KwUmyYGYEUyQBX2v
         MYPoRpWMY+BkI1ET6F1pkuZu0BjvNT3JsIgaqgQQFMccUqG056bATPVPXZaW1UZU3VRC
         dJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E0v1/XoAfo8OiusawK2xptMevQgjSP/uOA1ylFEwvrk=;
        b=4Lsw4OSJ5MiozvJcG6IKDpQlZdJ4Hfk55kv3SqsiAWlr9DtTLKkX6HDA6Rs0NoIEBo
         EOnBNxv1e+DT7Toq8a0+iCyOLLVJxKxf3EP74C9P6Uul+PCko3MtYKn0IModz8V4sznf
         V9rsmxdTiJJjt0iOK0hRLT5o/ktE7ITywa/ej6OjyHCGVKSqPXLBFR2dumWdGzR/2CHT
         zOG85iSnFMEcBic1sdVVc5zlpzn9iKMilLIcBo9Aa2N458SYhP5NyKWdoTXq4hE0uC2z
         Qqh8MClzSzRtP5oWvflE7xxJBsLF85rhaieGiDhCPH5bGLAWao7JkmBTeCQlRtQm1xvp
         E16A==
X-Gm-Message-State: AOAM533xO/ZhOI+m/GNV3xckhANUgyQ/FGRmtwJqs9AFo6EFdPiGVxD6
        AkMVyIqHMCFoGBGHNPQnIao=
X-Google-Smtp-Source: ABdhPJwrbutttcQ3i7t0ZjlgCyEYXrdYj31hgKGBJUFAXym1YFapciH6fS5sP/jnS+a185+S7Qs4+A==
X-Received: by 2002:a05:6000:1b8a:b0:1e4:b3a3:4c1f with SMTP id r10-20020a0560001b8a00b001e4b3a34c1fmr20285634wru.202.1646148696732;
        Tue, 01 Mar 2022 07:31:36 -0800 (PST)
Received: from monk.home ([2a01:cb10:430:ec00:4737:d56e:186b:af1])
        by smtp.gmail.com with ESMTPSA id b13-20020a05600c4e0d00b003816cb4892csm5797377wmq.0.2022.03.01.07.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 07:31:36 -0800 (PST)
From:   Christophe Branchereau <cbranchereau@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v1 0/3] Ingenic DRM bridge_atomic_enable proposal
Date:   Tue,  1 Mar 2022 16:31:19 +0100
Message-Id: <20220301153122.20660-1-cbranchereau@gmail.com>
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

Hello, this is a set of patches to allow the upstreaming of the
NV3052C panel found in the Anbernic RG350M mips gaming handheld.

It was never upstreamed so far due to a longstanding graphical
bug, which I propose to solve by introducing ingenic_drm_bridge_atomic_enable
in the drm driver so the CRTC can be enabled after the panel itself slept
out, and not before as it used to.

After the drm change, 2 of the existing panels have to be modified accordingly 
to introduce missing .enable and .disable in their code.

Christophe Branchereau (3):
  drm/ingenic : add ingenic_drm_bridge_atomic_enable
  drm/panel: Add panel driver for NewVision NV3052C based LCDs
  drm/panel : innolux-ej030na and abt-y030xx067a : add .enable and
    .disable

 drivers/gpu/drm/ingenic/ingenic-drm-drv.c     |  19 +-
 drivers/gpu/drm/panel/Kconfig                 |   9 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-abt-y030xx067a.c  |  23 +-
 drivers/gpu/drm/panel/panel-innolux-ej030na.c |  31 +-
 .../gpu/drm/panel/panel-newvision-nv3052c.c   | 504 ++++++++++++++++++
 6 files changed, 575 insertions(+), 12 deletions(-)
 create mode 100644 drivers/gpu/drm/panel/panel-newvision-nv3052c.c

-- 
2.34.1

