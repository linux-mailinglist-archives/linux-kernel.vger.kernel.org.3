Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B32547B01
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 18:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbiFLQNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 12:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbiFLQNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 12:13:05 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABDB4A93F
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 09:13:02 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id s1so4385680wra.9
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 09:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6oCYTzwjrLnxnxwyKEfz2WikcR75QzF1FKToWqyNR9I=;
        b=EhGLCkTkonmCMTQ167DXhA1weWmaXnTSuHbeSYgX94Bbnt8e/zuyEaBLQCXuOeqGwQ
         ljluV5fPNJ4XJuR94rWf/pVYkcKS8/FQCfSNil9UILvam9R84Q1db9f0oeTUhDtWSGYw
         VC+Hm8xmx3gUMWVhqhj3Ewzw92irbBXqKmjG0fjRdyRQN2iU7PfmXb1VpWFK4+a/iABo
         vwLhdBeB0k+F0ISucP0eWTEJnjCvXtZy1rFdBrrM8XlB1N+Uop5m/DCVzyks4qAeAsGC
         b4J30utrAbopEdfxenAjg0KQbPMPI/0bSl9+l4j9P8SZlGBE/4Z7/iFQC9Zum6G4NLXJ
         5ZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6oCYTzwjrLnxnxwyKEfz2WikcR75QzF1FKToWqyNR9I=;
        b=sLAdd6MHuwGvF35s1LZLhIAevq34707L+QlggeNHAekGYYPPKP0Hho43tRaaKdDQLL
         1iHmTpIdIrqER5Hktnan1A/3XCneKYjTNdAdsiRR0CIiSCx5J85SdZIm/NPfhZBr5Npo
         0VxaXRW7cq2bmjLuR4L9iIH1E8FOjYfb3st/oX1b0pXESI/Q8hQ9p6KMXMqj7IDmSnJh
         ouTcTM7l42Qnz94kG9OM7bO6/Dcpw7SjKz8OyHwRq92XKhnTWS5LeYSd/Xe5b9VKytZh
         +4kakXajDxxQcYnr+bHHdA6VUFW3CDNn8OMNpxW88MDYIHKrHR/MbqGPVw5lcKICsMnC
         H/Vg==
X-Gm-Message-State: AOAM530f58XDpz1D2tYG8boJeL3yE8o3Z09rDLOVqvmWaHBzDCmNF5B2
        1Ypv0e6EdV3oAHfqlFqmVcQ=
X-Google-Smtp-Source: ABdhPJz4mnmDUV4NLZknyHhTuGTurRoWbSWWgj8MlotV/lRDkKmaHLhTFIcWx+peDflYV5kyeC4q7w==
X-Received: by 2002:a05:6000:1849:b0:219:be72:177e with SMTP id c9-20020a056000184900b00219be72177emr16450441wri.150.1655050381282;
        Sun, 12 Jun 2022 09:13:01 -0700 (PDT)
Received: from localhost.localdomain ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id y8-20020a5d6208000000b0020d0f111241sm6015925wru.24.2022.06.12.09.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 09:13:00 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     javierm@redhat.com
Cc:     davidgow@google.com, dlatypov@google.com, tzimmermann@suse.de,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v2 3/3] drm/doc: Add KUnit documentation
Date:   Sun, 12 Jun 2022 18:12:48 +0200
Message-Id: <20220612161248.271590-4-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220612161248.271590-1-jose.exposito89@gmail.com>
References: <20220612161248.271590-1-jose.exposito89@gmail.com>
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

Reviewed-by: Maxime Ripard <maxime@cerno.tech>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/drm-internals.rst | 32 +++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/gpu/drm-internals.rst b/Documentation/gpu/drm-internals.rst
index 38afed24a75c..f1d97e80ca29 100644
--- a/Documentation/gpu/drm-internals.rst
+++ b/Documentation/gpu/drm-internals.rst
@@ -207,6 +207,38 @@ Utilities
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
+in ``drivers/gpu/drm/kunit/.kunitconfig``. It can be used by ``kunit.py`` as
+follows:
+
+.. code-block:: bash
+
+	$ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/gpu/drm/kunit \
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

