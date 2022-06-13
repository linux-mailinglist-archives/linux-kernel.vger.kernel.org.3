Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D7D549D7E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349480AbiFMTWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348735AbiFMTVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:21:24 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E49B2870B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 10:17:51 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id x17so7975541wrg.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 10:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6oCYTzwjrLnxnxwyKEfz2WikcR75QzF1FKToWqyNR9I=;
        b=F51NTLAyPWUJmIcreJGh+nbImazQe30mXy0M1R9WGuNAFL7yNxovOd0I4dYt9TkOYq
         /oWo/kycfvrF+HhazbbB+32J5kUXFxWTWp/vY4D+6IQnS9UxELCYAXpL0uCnmEooiYw/
         RCtD58rL8tsaqMP5UfwZUdlFSlRaB9l24wQpgSQ+Xd+tUM1XqhqgqJeaSqNNshdgc4Ew
         m+HeNbiKr42hrb2k0Oq0nOUcg8m1PZxxM1h5MHZym3iDUnG+K86b3vq7GltcAY4VNmaN
         6KonpQUB3bGRBVD64qQb6DeuxfGJiRDnatmTER/KaMJDN699w5hJ13owDQtQ7QpBqLQU
         Iazg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6oCYTzwjrLnxnxwyKEfz2WikcR75QzF1FKToWqyNR9I=;
        b=EBJGh6U8TEaxP8zOzFPwtS7Nh2Xyjlk+vbzKDjUcyLAHS0r/hob1/Xh0voyxYJEj1n
         E4K1wIVFrw6acgtDstNuG2klS0FNXvd8Wc0sneWnVHeYGxHJHqtQiwySB3C8yjRBs88w
         FzIT1G873S5KnXq8euUqWhdeaSvHsGU/2pfP2VyHc2s3H7ikBHCy3uDxowS10E/KRSfb
         TPnQEpk/jd5qSBD/Y22dG4NVqA6J8mQPcr3Ppqaw6BhOEl3FxBN0Joh9sPkWY0VTJKhk
         CswcTUR4lOKkeTmiTISK92eHxdHogunl8t6Mi3hUQtLFUW7Gt/gj7qnpOG4NlDF658iz
         +5uA==
X-Gm-Message-State: AJIora/BQ3b70itzYmlEhhUlpESr8iqgXVGwxjDziw4PxLIzYHB3okMW
        FMgND/yMMUrP1stGOl5A+YI=
X-Google-Smtp-Source: AGRyM1ukqjdWNtJpNtXwbhf0Bf6agIHIexrRYS1P411Ex0OXC4BusGashejJsEd+0rc1FkF98C2bfg==
X-Received: by 2002:adf:f610:0:b0:213:b4e1:7276 with SMTP id t16-20020adff610000000b00213b4e17276mr808828wrp.712.1655140669679;
        Mon, 13 Jun 2022 10:17:49 -0700 (PDT)
Received: from localhost.localdomain ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id a10-20020a056000100a00b0020d106c0386sm9016129wrx.89.2022.06.13.10.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 10:17:49 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     javierm@redhat.com
Cc:     davidgow@google.com, dlatypov@google.com, tzimmermann@suse.de,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, jani.nikula@linux.intel.com,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v3 3/3] drm/doc: Add KUnit documentation
Date:   Mon, 13 Jun 2022 19:17:38 +0200
Message-Id: <20220613171738.111013-4-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220613171738.111013-1-jose.exposito89@gmail.com>
References: <20220613171738.111013-1-jose.exposito89@gmail.com>
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

