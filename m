Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0CA535020
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 15:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345292AbiEZNmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 09:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344645AbiEZNll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 09:41:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C871713F
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 06:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653572498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RzJPqz0kjhM05tfVcWUDXOjhqjYpXjYlJDf77Kz4GBo=;
        b=HHjzBN5jXzKr2pmN142yBX7GhMl9n3/+hR7f1uvOQyAlSrIIzMtJcVye2RbWlya6svkzdc
        sOGX60j4tUebBbXM8nifjcsybXL9mZbaFmgGIqcPzmpw3WM/DQJpajTUVpMkTWGzahZ7ht
        s99I9MRrnsNI1uI46wjMGuT9s75FNNE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-56-Frp9R4PyO9CxYZH5gtBXaw-1; Thu, 26 May 2022 09:41:37 -0400
X-MC-Unique: Frp9R4PyO9CxYZH5gtBXaw-1
Received: by mail-wr1-f71.google.com with SMTP id q10-20020adfcd8a000000b0020ff96b68c2so267358wrj.19
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 06:41:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RzJPqz0kjhM05tfVcWUDXOjhqjYpXjYlJDf77Kz4GBo=;
        b=a6Au/F2gkNLvQosmeaE+MHm5Ov0Q3uO/X9E+mFDBqdYvQ+3GtF/Jrnjttyxl9uoFgL
         9YrzobgIqN/s5F7gg6YpFeZbDHgcZXt2xAIzeQ6k1AhRFNfomupZMXIZ9qN7W94/STfy
         5aAwltdRpBEsbxBjx5pemN0X8/yt8/HX5LBTGkq7UhYSb6ROr8jdoDdkM2zQKT5kU2iL
         XCXWKhhl5aDKRM1SyScYuP99ueBAVawQITJCcB/7bOBZYS4PIq0XxXA0OKOOs5uhwABv
         B0Mr14+D2QvX/xofvK1DrlueBKV2+qDVJ0X/dxceX2RaPs7NRFSb+Jn2Zd6gQSEPoVKR
         wasw==
X-Gm-Message-State: AOAM531erPlnD+1wMK1d6E46/kA+WKQWNFHBs5Vzo82IFbQ6XJ3tffs4
        F6fsDohb87H3h78EG1AbLI73GKrsP9KT4IFFUcL4p5GYftU1SwJxF9Xf7C1vV0z6UCxtS13VelK
        jcsfrZj7/YGUSC4k4Nh746mLYWE4pNvuf0dHwcROIYLRISA54fXcU+5CzvaCLOV3AHZ/mclgfKE
        k=
X-Received: by 2002:adf:d08a:0:b0:20d:1029:4957 with SMTP id y10-20020adfd08a000000b0020d10294957mr30009016wrh.55.1653572494670;
        Thu, 26 May 2022 06:41:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMQ9r3iwb05ARiit0mMex4XwxgHBvORhJCrt3DWHzbRI7/F8M6gDeuxisuXeST93eJMDcBcQ==
X-Received: by 2002:adf:d08a:0:b0:20d:1029:4957 with SMTP id y10-20020adfd08a000000b0020d10294957mr30008986wrh.55.1653572494274;
        Thu, 26 May 2022 06:41:34 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id h6-20020a5d5046000000b0020c547f75easm1765022wrt.101.2022.05.26.06.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 06:41:33 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christian Kellner <ckellner@redhat.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Alexander Larsson <alexl@redhat.com>,
        Alberto Ruiz <aruiz@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Lennart Poettering <lennart@poettering.net>,
        Colin Walters <walters@verbum.org>,
        Chung-Chiang Cheng <cccheng@synology.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH v3 3/3] selftests/filesystems: add a vfat RENAME_EXCHANGE test
Date:   Thu, 26 May 2022 15:41:19 +0200
Message-Id: <20220526134119.242182-4-javierm@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220526134119.242182-1-javierm@redhat.com>
References: <20220526134119.242182-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a test for the renameat2 RENAME_EXCHANGE support in vfat, but split it
in a tool that just does the rename exchange and a script that is run by
the kselftests framework on `make TARGETS="filesystems/fat" kselftest`.

That way the script can be easily extended to test other file operations.

The script creates a 1 MiB disk image, that is then formated with a vfat
filesystem and mounted using a loop device. That way all file operations
are done on an ephemeral filesystem.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

Changes in v3:
- Add a .gitignore for the rename_exchange binary (Muhammad Usama Anjum).
- Include $(KHDR_INCLUDES) instead of hardcoding a relative path in Makefile
  (Muhammad Usama Anjum).

Changes in v2:
- Call sync to flush the page cache before checking the file contents
  (Alex Larsson).

 MAINTAINERS                                   |  1 +
 tools/testing/selftests/Makefile              |  1 +
 .../selftests/filesystems/fat/.gitignore      |  2 +
 .../selftests/filesystems/fat/Makefile        |  7 ++
 .../testing/selftests/filesystems/fat/config  |  2 +
 .../filesystems/fat/rename_exchange.c         | 37 +++++++++
 .../filesystems/fat/run_fat_tests.sh          | 82 +++++++++++++++++++
 7 files changed, 132 insertions(+)
 create mode 100644 tools/testing/selftests/filesystems/fat/.gitignore
 create mode 100644 tools/testing/selftests/filesystems/fat/Makefile
 create mode 100644 tools/testing/selftests/filesystems/fat/config
 create mode 100644 tools/testing/selftests/filesystems/fat/rename_exchange.c
 create mode 100755 tools/testing/selftests/filesystems/fat/run_fat_tests.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index 4fdbbd6c1984..158771bb7755 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20841,6 +20841,7 @@ M:	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
 S:	Maintained
 F:	Documentation/filesystems/vfat.rst
 F:	fs/fat/
+F:	tools/testing/selftests/filesystems/fat/
 
 VFIO DRIVER
 M:	Alex Williamson <alex.williamson@redhat.com>
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 0aedcd76cf0f..fc59ad849a90 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -16,6 +16,7 @@ TARGETS += exec
 TARGETS += filesystems
 TARGETS += filesystems/binderfs
 TARGETS += filesystems/epoll
+TARGETS += filesystems/fat
 TARGETS += firmware
 TARGETS += fpu
 TARGETS += ftrace
diff --git a/tools/testing/selftests/filesystems/fat/.gitignore b/tools/testing/selftests/filesystems/fat/.gitignore
new file mode 100644
index 000000000000..b89920ed841c
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fat/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+rename_exchange
diff --git a/tools/testing/selftests/filesystems/fat/Makefile b/tools/testing/selftests/filesystems/fat/Makefile
new file mode 100644
index 000000000000..902033f6ef09
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fat/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+
+TEST_PROGS := run_fat_tests.sh
+TEST_GEN_PROGS_EXTENDED := rename_exchange
+CFLAGS += -O2 -g -Wall $(KHDR_INCLUDES)
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/filesystems/fat/config b/tools/testing/selftests/filesystems/fat/config
new file mode 100644
index 000000000000..6cf95e787a17
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fat/config
@@ -0,0 +1,2 @@
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_VFAT_FS=y
diff --git a/tools/testing/selftests/filesystems/fat/rename_exchange.c b/tools/testing/selftests/filesystems/fat/rename_exchange.c
new file mode 100644
index 000000000000..e488ad354fce
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fat/rename_exchange.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Program that atomically exchanges two paths using
+ * the renameat2() system call RENAME_EXCHANGE flag.
+ *
+ * Copyright 2022 Red Hat Inc.
+ * Author: Javier Martinez Canillas <javierm@redhat.com>
+ */
+
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+void print_usage(const char *program)
+{
+	printf("Usage: %s [oldpath] [newpath]\n", program);
+	printf("Atomically exchange oldpath and newpath\n");
+}
+
+int main(int argc, char *argv[])
+{
+	int ret;
+
+	if (argc != 3) {
+		print_usage(argv[0]);
+		exit(EXIT_FAILURE);
+	}
+
+	ret = renameat2(AT_FDCWD, argv[1], AT_FDCWD, argv[2], RENAME_EXCHANGE);
+	if (ret) {
+		perror("rename exchange failed");
+		exit(EXIT_FAILURE);
+	}
+
+	exit(EXIT_SUCCESS);
+}
diff --git a/tools/testing/selftests/filesystems/fat/run_fat_tests.sh b/tools/testing/selftests/filesystems/fat/run_fat_tests.sh
new file mode 100755
index 000000000000..7f35dc3d15df
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fat/run_fat_tests.sh
@@ -0,0 +1,82 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Run filesystem operations tests on an 1 MiB disk image that is formatted with
+# a vfat filesystem and mounted in a temporary directory using a loop device.
+#
+# Copyright 2022 Red Hat Inc.
+# Author: Javier Martinez Canillas <javierm@redhat.com>
+
+set -e
+set -u
+set -o pipefail
+
+BASE_DIR="$(dirname $0)"
+TMP_DIR="$(mktemp -d /tmp/fat_tests_tmp.XXXX)"
+IMG_PATH="${TMP_DIR}/fat.img"
+MNT_PATH="${TMP_DIR}/mnt"
+
+cleanup()
+{
+    mountpoint -q "${MNT_PATH}" && unmount_image
+    rm -rf "${TMP_DIR}"
+}
+trap cleanup SIGINT SIGTERM EXIT
+
+create_loopback()
+{
+    touch "${IMG_PATH}"
+    chattr +C "${IMG_PATH}" >/dev/null 2>&1 || true
+
+    truncate -s 1M "${IMG_PATH}"
+    mkfs.vfat "${IMG_PATH}" >/dev/null 2>&1
+}
+
+mount_image()
+{
+    mkdir -p "${MNT_PATH}"
+    sudo mount -o loop "${IMG_PATH}" "${MNT_PATH}"
+}
+
+rename_exchange_test()
+{
+    local rename_exchange="${BASE_DIR}/rename_exchange"
+    local old_path="${MNT_PATH}/old_file"
+    local new_path="${MNT_PATH}/new_file"
+
+    echo old | sudo tee "${old_path}" >/dev/null 2>&1
+    echo new | sudo tee "${new_path}" >/dev/null 2>&1
+    sudo "${rename_exchange}" "${old_path}" "${new_path}" >/dev/null 2>&1
+    sudo sync -f "${MNT_PATH}"
+    grep new "${old_path}" >/dev/null 2>&1
+    grep old "${new_path}" >/dev/null 2>&1
+}
+
+rename_exchange_subdir_test()
+{
+    local rename_exchange="${BASE_DIR}/rename_exchange"
+    local dir_path="${MNT_PATH}/subdir"
+    local old_path="${MNT_PATH}/old_file"
+    local new_path="${dir_path}/new_file"
+
+    sudo mkdir -p "${dir_path}"
+    echo old | sudo tee "${old_path}" >/dev/null 2>&1
+    echo new | sudo tee "${new_path}" >/dev/null 2>&1
+    sudo "${rename_exchange}" "${old_path}" "${new_path}" >/dev/null 2>&1
+    sudo sync -f "${MNT_PATH}"
+    grep new "${old_path}" >/dev/null 2>&1
+    grep old "${new_path}" >/dev/null 2>&1
+}
+
+unmount_image()
+{
+    sudo umount "${MNT_PATH}" &> /dev/null
+}
+
+create_loopback
+mount_image
+rename_exchange_test
+rename_exchange_subdir_test
+unmount_image
+
+exit 0
-- 
2.36.1

