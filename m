Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD1853E9F1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbiFFJze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 05:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbiFFJzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 05:55:31 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E496111BAD
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 02:55:27 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id c5-20020a1c3505000000b0038e37907b5bso9747650wma.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 02:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bvF3M+uYRlSr3a5KCLyADnsjEKpxlfPHpuUaTqCte5k=;
        b=TMLYk3P5KEeYKrnQQoCZUXZVPwB2mbU7alH5Gx4k/19pdn3njqwEFTMI+7m8VKErN6
         TyOXzpHBdLR0Kt3x1tROE5OXVWNksjfmAQxhr3HUQi/pjx7V5dSmeVRXKTzOcN7Hg/qQ
         mjVY8F8yOQ1tfO/CSoQ6FzRT5Rf55hvOnRoozHGfV4IP8maZVO0DxJiSVaXHmrPfY3GT
         wQpGeV5A2/Dy510LdMvlPlWFMB/7/yJOz7Tup27ELisnmIXT5KkFNZwhHLO4o6Bx3onR
         MQArlYX11jqdswVBqYmZSvONbiMv0eqZfDkd1nSO6+Ox+7wufKpxu+RiuZ1mCaA85CV5
         vCZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bvF3M+uYRlSr3a5KCLyADnsjEKpxlfPHpuUaTqCte5k=;
        b=TFRdIM2fAK8usmTiuJG7Sp/cA6EXVQvya8zXV8vonqJ9aAGkP+mlCKdj+VIJXSEy4d
         /gZz6XiDEoEzSuninVTDL9C5CKdHfJ4hipIVq/98E9IUc8c0XTQl0QtH9dsZvZ2sIKWy
         YyO/CLLgODnzzq980p0rwX9kzEafLyvUyVaWGERa4eQj34MeKKmSHnwekRAvrfnRIjQg
         lAzCIb30+GxkjptEPWknVnR/oXcmFpgHM0nnDcCqGDMgnTZnD5n2mispSGWmEZ6ekuHg
         lgz6xJLO95XbELUz9VaO6jrH3BoECzBZSHo4T7uGGPGVYaRvhh4YgCXf31nCWk8w9UUn
         SZmA==
X-Gm-Message-State: AOAM532lNjki5YQkRTsxkaZcjhbsMV+p4PbC9VerhVUrdfmhtu63hW9U
        zJWm8LxboG6t46cHSudWknw=
X-Google-Smtp-Source: ABdhPJweK6O54b1wrPEaEYBA76q/aE6w57fAhWpEqGNMnJj5PnHBvLp+W+RHTDNJYZJcvI32S5M60A==
X-Received: by 2002:a05:600c:1992:b0:397:8d3b:8a9b with SMTP id t18-20020a05600c199200b003978d3b8a9bmr46251245wmq.20.1654509326115;
        Mon, 06 Jun 2022 02:55:26 -0700 (PDT)
Received: from localhost.localdomain ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id n8-20020a05600c4f8800b0039c325eaff2sm13654326wmq.26.2022.06.06.02.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 02:55:25 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     javierm@redhat.com
Cc:     davidgow@google.com, dlatypov@google.com, tzimmermann@suse.de,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 0/1] KUnit tests for drm_format_helper
Date:   Mon,  6 Jun 2022 11:55:15 +0200
Message-Id: <20220606095516.938934-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

Recently Javier added a new task in the ToDo list [1] to create KUnit
tests for the functions present in "drm_format_helper".

This patch includes the changes suggested in the RFC version [2].

Best wishes,
José Expósito

[1] https://cgit.freedesktop.org/drm/drm-misc/commit/?id=596c35b1440e
[2] https://lore.kernel.org/dri-devel/20220530102017.471865-1-jose.exposito89@gmail.com/T/

José Expósito (1):
  drm/format-helper: Add KUnit tests for drm_fb_xrgb8888_to_rgb332()

 drivers/gpu/drm/.kunitconfig             |   3 +
 drivers/gpu/drm/Kconfig                  |  16 +++
 drivers/gpu/drm/Makefile                 |   2 +
 drivers/gpu/drm/drm_format_helper_test.c | 166 +++++++++++++++++++++++
 4 files changed, 187 insertions(+)
 create mode 100644 drivers/gpu/drm/.kunitconfig
 create mode 100644 drivers/gpu/drm/drm_format_helper_test.c

-- 
2.25.1

