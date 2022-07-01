Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3FA563965
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 21:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbiGASxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 14:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiGASxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 14:53:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B4FC464E9
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 11:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656701591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TjW1zw6H6jOinbMWrIYyLw5n+NTsf3iSoa3+A/bO+5g=;
        b=RlBhYuAwFuGkq3mDMFuw+O3/Jp8gFtUYKazb1f8fXy4lQezp7Oy9rtOaLDbVPJPfYCCrT/
        4+y8H0C2cAk3QeN2nI3WnCLuqT5xGELm/YMSIi4rSw2u+NlUcLAHrSpPCB9kLPH462o9OL
        V1KeX6ilhc4/MVUFxR57VX4+4Oq1uE8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-jdF5Re4VPoSSulPxo1xszQ-1; Fri, 01 Jul 2022 14:53:10 -0400
X-MC-Unique: jdF5Re4VPoSSulPxo1xszQ-1
Received: by mail-ej1-f72.google.com with SMTP id s4-20020a170906500400b006feaccb3a0eso1078767ejj.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 11:53:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TjW1zw6H6jOinbMWrIYyLw5n+NTsf3iSoa3+A/bO+5g=;
        b=MWM3I+wP+uqPXMZUA1bmFgVbsuSYIkePkZieKFoNZjaRq0JfJuuxqNDUl0t5JGz3A6
         kiCpskLMAmWdFHifGqsz1ycbrWeApF5jJ+uzJcPOj1CQ10Nn2oOiLO7csfKN5hbH/syP
         yqAAEI2gLXJUB7gw59AEvIx0KeFr6KVJYmW3aMwS3hF5kT5zJcb4ZCrrxrsxVoEmZhQT
         ODofRj0sOVqAZo0dWSQicYtAGzMuQjI4Cc2hzHe1XtOZKfbpqtao+qfI2gNQlFPbqBwa
         TO4fJzohP07B7+966vlVizKn7c8Mx+QzaPivKaO2IUANtpDisYhyBLOdH1rw2a2YS0zg
         ZVgQ==
X-Gm-Message-State: AJIora85qCWQRnTl71XKwY3SN2Em9J8D4VHzjQlFGy42z5hTa1FtPdao
        svJ6xNXYFCzxqqhi+/jZZCPfUMZFfMbg8NFpa7CXzja6hXh/vV9byc4nTgLhhnKWr5bpnXe09BM
        /ss/t3mLDy6/7cTKMCBLigkGL
X-Received: by 2002:a17:907:94cf:b0:726:c81a:f30e with SMTP id dn15-20020a17090794cf00b00726c81af30emr15508805ejc.451.1656701589574;
        Fri, 01 Jul 2022 11:53:09 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uCFTdcknI/LBb46OKwHmmwto0OOxNT9KHI001+nWTLFNj1eQ2gou+pJdNe+XnTE2Hskb7Yhg==
X-Received: by 2002:a17:907:94cf:b0:726:c81a:f30e with SMTP id dn15-20020a17090794cf00b00726c81af30emr15508787ejc.451.1656701589424;
        Fri, 01 Jul 2022 11:53:09 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id cb25-20020a0564020b7900b004359dafe822sm15406658edb.29.2022.07.01.11.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 11:53:09 -0700 (PDT)
From:   dakr@redhat.com
To:     airlied@linux.ie, daniel@ffwll.ch, christian.koenig@amd.com,
        emma@anholt.net
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH 00/10] drm: use idr_init_base() over idr_init() if applicable
Date:   Fri,  1 Jul 2022 20:52:53 +0200
Message-Id: <20220701185303.284082-1-dakr@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Danilo Krummrich <dakr@redhat.com>

This patch series initializes IDRs with idr_init_base(&idr, 1) rather than
idr_init(&idr) in case for the particular IDR no IDs < 1 are ever requested -
this avoids unnecessary tree walks.

Danilo Krummrich (10):
  drm/amdgpu: use idr_init_base() to initialize mgr->ctx_handles
  drm/amdgpu: use idr_init_base() to initialize fpriv->bo_list_handles
  drm: use idr_init_base() to initialize master->magic_map
  drm: use idr_init_base() to initialize master->lessee_idr
  drm: use idr_init_base() to initialize mode_config.object_idr
  drm: use idr_init_base() to initialize mode_config.tile_idr
  drm/sis: use idr_init_base() to initialize dev_priv->object_idr
  drm/v3d: use idr_init_base() to initialize v3d_priv->perfmon.idr
  drm/via: use idr_init_base() to initialize dev_priv->object_idr
  drm/todo: remove task for idr_init_base()

 Documentation/gpu/todo.rst              | 12 ------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  2 +-
 drivers/gpu/drm/drm_auth.c              |  4 ++--
 drivers/gpu/drm/drm_mode_config.c       |  4 ++--
 drivers/gpu/drm/sis/sis_drv.c           |  2 +-
 drivers/gpu/drm/v3d/v3d_perfmon.c       |  2 +-
 drivers/gpu/drm/via/via_map.c           |  2 +-
 8 files changed, 9 insertions(+), 21 deletions(-)

-- 
2.36.1

