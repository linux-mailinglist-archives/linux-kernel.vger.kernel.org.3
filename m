Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942E459A799
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 23:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349884AbiHSVUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 17:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352426AbiHSVUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 17:20:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECBF104459
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 14:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660944021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=j2+ccIXOzc7ebn5TN2QLgICjqsh9inkfp4HMER57Oc4=;
        b=eB2mE0JaM7pfKivofMLzJEUR78j3zVc2+zqCZPVH4f0j/aw2kCSAWRDnVW67eFg9ZSldCH
        AgKChyrGCVXeRsIJqzCayVX4SCpuA0yhMAg2bu1TGDGJ1/m1GE5rspDUe0oRp7Z4pCKbV9
        SE8rD5Jjs8Fa4zLok8mJQZEv0Z33sY0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-152-LgNSxVsQMzyKkafv1qVKNQ-1; Fri, 19 Aug 2022 17:20:19 -0400
X-MC-Unique: LgNSxVsQMzyKkafv1qVKNQ-1
Received: by mail-ej1-f71.google.com with SMTP id g18-20020a1709065d1200b0073082300e1fso1906835ejt.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 14:20:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=j2+ccIXOzc7ebn5TN2QLgICjqsh9inkfp4HMER57Oc4=;
        b=a7MRmdYTVcmr90vlKQ1+R42sodPTc7AI5/pZaRsrgeuNMYnrrBZ/7I7nUeIoCLPQeo
         L0yEHDb1tT0tEBpfPHJ6NlC5heltQAqhluFUcmgUkoDcRwY/fJkpJSvLRaT4nHelhCQW
         k+Zz+G9PR5uVuR4txdZ+K5bBLNT6ZIlU5A/7+jTMGnskBoSAiw+PkYxEOB4LSGgtbI98
         3UBingyO9aD1k02G9J8uMfM+ePLEnJqERiiTi0C2iIUNxMC88VFee1bNAxxCNv0Ujavu
         6oGPdBlh+NGx6t6zelI7dxtAYysberB3qGisSX7FG9WLvUvYEVBs8RSKJ9RlaeaNnyui
         mMXg==
X-Gm-Message-State: ACgBeo0xHFjyvjtlFLcoL74KYvdVrVLBA437a4hNJKS+Gd+cMj7pwrYh
        xGgSMLAtp7ANaGCbB/I9/X25Qg2eJcHPUv6ERTflNmptUkXZA6q+GnFcoiEUE8Vd9q6KOrtC2JR
        zeCUvZL1UbmNih5RrGBc60zq+
X-Received: by 2002:a05:6402:400d:b0:446:6fe1:7663 with SMTP id d13-20020a056402400d00b004466fe17663mr392384eda.376.1660944018424;
        Fri, 19 Aug 2022 14:20:18 -0700 (PDT)
X-Google-Smtp-Source: AA6agR466OXqq6BVG/zJYaiyEpFRVqjwIYX750SN/UUM38RlWDntKPsBW4hHv9mrKyzs1ZBat73diA==
X-Received: by 2002:a05:6402:400d:b0:446:6fe1:7663 with SMTP id d13-20020a056402400d00b004466fe17663mr392366eda.376.1660944018228;
        Fri, 19 Aug 2022 14:20:18 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id y14-20020a1709063a8e00b0073a644ef803sm2777029ejd.101.2022.08.19.14.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 14:20:17 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next 0/8] drm/arm/malidp: use drm managed resources
Date:   Fri, 19 Aug 2022 23:20:07 +0200
Message-Id: <20220819212015.556220-1-dakr@redhat.com>
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


base-commit: 8869fa666a9e6782c3c896c1fa57d65adca23249
-- 
2.37.2

