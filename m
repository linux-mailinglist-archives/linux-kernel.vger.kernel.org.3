Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903F253EDA4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 20:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiFFSK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 14:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbiFFSJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 14:09:49 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7106B329371
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 11:09:46 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k16so20915474wrg.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 11:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tCYZwzCVdZ6wVDocKg/5gFZzksm/d5GDUpBKZN9UWJM=;
        b=hJTRzt5eI6lwU2NYGJNW7/inkfglbXLnSlLWurfAAJspK66rpNis2ApDm8VMTUKtCl
         291daY3KHI3tuYIRQUXJOyV8JgvvCNr+m79efaLJplCT6nsjVLK1P4Cw2o1WUee+g7Ij
         hL+kYkccEt800lzno5Lphehcg2RjKNstaCTxlGZ4luTnRCfItlezvVC23dt3briQNFmZ
         gF0HY5Y/chuBKF69KtC+o4vVyYsjmV6/QYpUnJb5qsNcQTH+bjqhYGnjhgjx/8x0iv5w
         UKvnTglYP7jWFW4zPzrZyCarncHvrHFEwfZU1GRKDPPuCLTfSAdD8eVvF/KEdwCaPFck
         PopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tCYZwzCVdZ6wVDocKg/5gFZzksm/d5GDUpBKZN9UWJM=;
        b=pJGWWLw1dXrmn2W970yeY4iLmPlzLORo4XvlglRMq5G3ALq1WuUwegUQCEKK79Y+Ad
         0aEELcOGDskJSyK9803wZQVyrTutAsUMDFcWBDAhUhqIvlB8YAo3TLUvJvsbZfr5zBoU
         P6nrgOy9k5OHOFZ5etkutKtNmZQewDi0T8sAebHOg5zi75CTl8mIri71T1nOs8s6Rg9O
         31m9vtCmXtymcfBBJGCeiGWxSYSQgDOc+eqmg7x2RiySn7q4C5uKwC3fkHPATPWVqiKK
         G1QVu73ojZPzmlnUgYyILSUbQtNo+D8feyqtvloxMfRJk706b9Bnw1yuEagFsO5Rw9/B
         El9g==
X-Gm-Message-State: AOAM531WKcJdO+zBZ0IwgLv83ZL2fVQY/bYb7Bz352u5kJ34UDWAgzxE
        mwaA1g8E9NUijPaVJEV/MpQ=
X-Google-Smtp-Source: ABdhPJzGMHflGxxR8RN7X7m0FPxaI+9qGxcVDUq0BaJwRW9ffdAtkUO4v+/00+b/FOSmS988We2rvA==
X-Received: by 2002:a5d:4811:0:b0:213:bab0:64f3 with SMTP id l17-20020a5d4811000000b00213bab064f3mr19222823wrq.499.1654538984919;
        Mon, 06 Jun 2022 11:09:44 -0700 (PDT)
Received: from localhost.localdomain ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600c2cad00b00397623ff335sm19785050wmc.10.2022.06.06.11.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 11:09:44 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     javierm@redhat.com
Cc:     davidgow@google.com, dlatypov@google.com, tzimmermann@suse.de,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH] drm/doc: Add KUnit documentation
Date:   Mon,  6 Jun 2022 20:09:40 +0200
Message-Id: <20220606180940.43371-1-jose.exposito89@gmail.com>
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

Explain how to run the KUnit tests present in the DRM subsystem and
clarify why the UML-only options were not added to the configuration
file present in drivers/gpu/drm/.kunitconfig [1] [2].

[1] https://lore.kernel.org/dri-devel/CABVgOSn8i=LO5p7830h2XU1Jgg0KrN0qTnxkOMhf1oTgxjaKKw@mail.gmail.com/
[2] https://lore.kernel.org/dri-devel/CAGS_qxqpiCim_sy1LDK7PLwVgWf-LKW+uNFTGM=T7ydk-dYcEw@mail.gmail.com/

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/drm-internals.rst | 31 +++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/gpu/drm-internals.rst b/Documentation/gpu/drm-internals.rst
index 38afed24a75c..08f115417381 100644
--- a/Documentation/gpu/drm-internals.rst
+++ b/Documentation/gpu/drm-internals.rst
@@ -207,6 +207,37 @@ Utilities
    :internal:
 
 
+Unit testing
+============
+
+KUnit
+-----
+
+KUnit (Kernel unit testing framework) provides a common framework for unit tests
+within the Linux kernel.
+
+This section covers the specifics for the DRM subsystem. For general information
+about KUnit, please refer to Documentation/dev-tools/kunit/start.rst.
+
+How to run the tests?
+~~~~~~~~~~~~~~~~~~~~~
+
+In order to facilitate running the test suite, a configuration file is present
+in ``drivers/gpu/drm/.kunitconfig``. It can be used by ``kunit.py`` as follows:
+
+.. code-block:: bash
+
+	$ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/gpu/drm \
+		--kconfig_add CONFIG_VIRTIO_UML=y \
+		--kconfig_add CONFIG_UML_PCI_OVER_VIRTIO=y
+
+.. note::
+	The configuration included in ``.kunitconfig`` should be as generic as
+	possible.
+	``CONFIG_VIRTIO_UML`` and ``CONFIG_UML_PCI_OVER_VIRTIO`` are not
+	included in it because they are only required for User Mode Linux.
+
+
 Legacy Support Code
 ===================
 
-- 
2.25.1

