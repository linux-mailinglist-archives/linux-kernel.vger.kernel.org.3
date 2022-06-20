Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB1A5521D9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 18:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243624AbiFTQHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 12:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240728AbiFTQG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 12:06:56 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F16201BE
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 09:06:55 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id c21so15345452wrb.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 09:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/TPehAEJHEHlrkHOvcoYy5pHwjMYobws3cEljVGCCv4=;
        b=BCSuOE12OhP9mTHrQ71bY0c6dF+TNJEyuAAzb9DF9CpKL9f99Q05BPSHQMNU9lGV+f
         kbG+AXp1B8zxKOlqE4t2B8EGzK9l5zJXHJ6aC64Nydnl8i6kR1apyv5/9vOMUCye9jrd
         ixTS0t5AUr5yy7GZ4qXa9CdtaQFBtW60qgccslYepVEEcqem0wMtIwrp92jD9cEU/sPA
         NoRAqpfrhN/hsd35AKhWVN1CJxBdmu/lDeQbj1NM1o96ppgKT8+03xxhVfA6Qf+nrJA6
         XCnla7Q+zbo//QOGIcgGPkRIVpXsocQYdvOAKpXecTnqdfLiRsCU8dMo5qH8maeCjx7J
         t9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/TPehAEJHEHlrkHOvcoYy5pHwjMYobws3cEljVGCCv4=;
        b=10AGknYtt/XMt1h6nCBk+72msAm2nzYy0SsKJ6fQSnp2B/Cb1w4ciZL83lKU5xb3Vd
         UNS5GjiyExvpoONm79TwWfuk6pI+lkJgfCIkMmr5Q9YWgzhB1Wah+2JZ9JCpT1793tw3
         8EmULOOScIUXWWp400Bt20700RbKNk9URxYkiZIIy7UQUcSf8FMSX/mUfvyuUF0KAw1R
         kPhfwHwOmJP4vJyP+uILbrYg5hVAnVVh6881PLzm2aiUGXZf8BJOY6MG+nPaBl1e0ZiG
         bo4CWRKs2VqDiLEBBbd02L/y+jm0wAGduxt1QVniqrpN8ieC/+Qa0302vG3YjZWFFZLe
         r5rQ==
X-Gm-Message-State: AJIora9mOD5zF0tkbhmEjLWJxVqc9sf8fiylBwINI9KGMSm/12CyM4P9
        yViHwMqf/LJ/Ee4w8QnzAgc=
X-Google-Smtp-Source: AGRyM1uG8UV4dMYLoidsr7Hd4yy2qf09uau+6C6r3lbUcAXOfVd7XmAndQ/+Bbnw3uSgY7ukvZgPKw==
X-Received: by 2002:a5d:4246:0:b0:21b:8ed0:51c with SMTP id s6-20020a5d4246000000b0021b8ed0051cmr6132380wrr.62.1655741214061;
        Mon, 20 Jun 2022 09:06:54 -0700 (PDT)
Received: from localhost.localdomain ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id h14-20020a5d430e000000b0021b90cc66a1sm2986096wrq.2.2022.06.20.09.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 09:06:53 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     javierm@redhat.com
Cc:     davidgow@google.com, dlatypov@google.com, tzimmermann@suse.de,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, jani.nikula@linux.intel.com,
        maira.canal@usp.br, isabbasso@riseup.net, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v4 3/3] drm/doc: Add KUnit documentation
Date:   Mon, 20 Jun 2022 18:06:40 +0200
Message-Id: <20220620160640.3790-4-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220620160640.3790-1-jose.exposito89@gmail.com>
References: <20220620160640.3790-1-jose.exposito89@gmail.com>
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
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/drm-internals.rst | 32 +++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/gpu/drm-internals.rst b/Documentation/gpu/drm-internals.rst
index 38afed24a75c..5fd20a306718 100644
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
+in ``drivers/gpu/drm/tests/.kunitconfig``. It can be used by ``kunit.py`` as
+follows:
+
+.. code-block:: bash
+
+	$ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/gpu/drm/tests \
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

