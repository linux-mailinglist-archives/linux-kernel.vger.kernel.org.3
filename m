Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495ED5AD62B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 17:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238021AbiIEPTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 11:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238813AbiIEPTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:19:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4834A39F
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 08:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662391159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=txJ7rH0HcdmbXZEFY4EaZQQpLp+37J+9klKnKTy/C5g=;
        b=EPsLxAL7kL4KxlFthKSakY5Gu8oJugVr2IdI7ts2xDuQUBzx12ipSMA81zSj8mrfmSEcVG
        yoWGNCaKsEzlIaEJHsgI0m+dKjasoX0twL3HT3VENJVMrWjh4jfL8r1ut7k34iRpESHHHz
        jM8gShX+bv0xQhkaKi04us+cRI8sa1c=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-664-EMXaoe97Ole-MZcLQV4r7g-1; Mon, 05 Sep 2022 11:19:18 -0400
X-MC-Unique: EMXaoe97Ole-MZcLQV4r7g-1
Received: by mail-ed1-f71.google.com with SMTP id dz16-20020a0564021d5000b004489f04cc2cso5953111edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 08:19:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=txJ7rH0HcdmbXZEFY4EaZQQpLp+37J+9klKnKTy/C5g=;
        b=mt9zOZR8Dly8bKrFV0dLjpZLQJKuKGxGG4W6c9/fURhs2akRExtWGxa/tJ+C2SYRAW
         dgC6r9o3MWLI+e4vEPRZ9EP53pxVH2yW8vUxOJImx/Ff9KQ9gmNcDMX7LAYFGMsOD00Q
         q/tArLOdw9zRle+HTkYJkoKCrlWcPdeEgm/BG0fvODBuViPdD/godp19HAPlFnqzTI8G
         UKUjcK38HT5cT5Hbp/p/9wyAZlGIdkNeMbexN0eDHkZNoWKEqAmsGazxRo+gyNpHqXS2
         Q53cfGHFIL2lRyo/lCTChRyXvRbcH+cPdJhj2Ingm0yh78XoQZnmLoyBMVocsfvtHxIG
         sWdA==
X-Gm-Message-State: ACgBeo3TB4kvi4SAhM03XijIGleXUDdzRrr7rQoyoQJKzpsar53cN0Mb
        Xh/tOfVmdB6j8QFg/V+jpg5hGXTs1DbEwrwe8OBrAmCEHaGXe51xar4l9Zb6dolGuoOHVPc8YsK
        f0RHIJTdAQnKMaznSXjUs2+hN
X-Received: by 2002:a50:fc15:0:b0:44e:4895:b290 with SMTP id i21-20020a50fc15000000b0044e4895b290mr6857414edr.394.1662391157459;
        Mon, 05 Sep 2022 08:19:17 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5FJUgNZbo1aOl4CuBy5cBZqK3JuAHiQxIYNAOSEEgNofU1OxE/Luv0TkpD6CSznKVWTYq1Qg==
X-Received: by 2002:a50:fc15:0:b0:44e:4895:b290 with SMTP id i21-20020a50fc15000000b0044e4895b290mr6857409edr.394.1662391157316;
        Mon, 05 Sep 2022 08:19:17 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id n12-20020aa7d04c000000b0044e702cd712sm2741485edo.41.2022.09.05.08.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 08:19:17 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH RESEND drm-misc-next 0/8] drm/arm/malidp: use drm managed resources
Date:   Mon,  5 Sep 2022 17:19:02 +0200
Message-Id: <20220905151910.98279-1-dakr@redhat.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series converts the driver to use drm managed resources to prevent
potential use-after-free issues on driver unbind/rebind and to get rid of the
usage of deprecated APIs.

Danilo Krummrich (8):
  drm/arm/malidp: use drmm_* to allocate driver structures
  drm/arm/malidp: replace drm->dev_private with drm_to_malidp()
  drm/arm/malidp: crtc: use drmm_crtc_init_with_planes()
  drm/arm/malidp: plane: use drm managed resources
  drm/arm/malidp: use drm_dev_unplug()
  drm/arm/malidp: plane: protect device resources after removal
  drm/arm/malidp: crtc: protect device resources after removal
  drm/arm/malidp: drv: protect device resources after removal

 drivers/gpu/drm/arm/malidp_crtc.c   | 48 +++++++++++++++++++++---
 drivers/gpu/drm/arm/malidp_drv.c    | 58 ++++++++++++++---------------
 drivers/gpu/drm/arm/malidp_drv.h    |  2 +
 drivers/gpu/drm/arm/malidp_hw.c     | 10 ++---
 drivers/gpu/drm/arm/malidp_mw.c     |  6 +--
 drivers/gpu/drm/arm/malidp_planes.c | 45 +++++++++++-----------
 6 files changed, 100 insertions(+), 69 deletions(-)


base-commit: 8fe444eb326869823f3788a4b4da5dca03339d10
-- 
2.37.2

