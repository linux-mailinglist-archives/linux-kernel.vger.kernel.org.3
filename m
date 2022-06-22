Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D21554105
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 05:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356629AbiFVDxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 23:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356388AbiFVDxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 23:53:37 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFE2338A7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 20:53:35 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id r6-20020a5b06c6000000b006693f6a6d67so4529415ybq.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 20:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=iwk6opCsv4rch8cOLk7rLA4pRpTqnI7lX1MqEKmLDxo=;
        b=jvavznh0cp68Y71XtKyHHUb1a1IbsXDqLyI9l6AZPSugBW0v14ZN7p8nppjz2lVDMD
         2I+wN01Qp8I2gV+6O/1D9WNaYlCSVDGtLXgpGUUpgsvWgYIG7mKqLtsVSIwQdMlIUEJD
         o+S1fM6rp0RPLbUNAKiMwCvsvs05ueljZZFXBm6Me0HsHbFu3Pg1pp3kb+dcn40DskMI
         H5N9skt3Md0eTYkG4asMaNyYVwOnCqWAiEOWgNm+uofZ/wXshEzEUiSKz/5XTe96mOk0
         pizhmimC3lJo1UJ7KkcNpUB8OrOUIQCP9kZr9hjRSsNrS+t5C7OTVKNwz6p90iusxweD
         o/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=iwk6opCsv4rch8cOLk7rLA4pRpTqnI7lX1MqEKmLDxo=;
        b=rLievu5kAmbfgOBssMuNRRj9ILvrP/GRyeUTH1IGDfLyCq51Fjfii+GzNZL/LV4ijH
         uoQecwOq3XwKlkRB5zA2tqe+44pB/xocaY7fLuHiCLebFUZlBKlWFvr52R+9b1KVl6p6
         vwJlW7mQlmCUzvbRE7qYvPOcuoNvK4+LBbZwpEHOc/HI/3vDepIUuUldWq/hFSE3QoNR
         uX+wGSDtpdCGqI0wQgZ9I2/I2td7OOiWJ47h2bo4BmuJHS/3rZSx3VCOYeGqWuLGm0bs
         9rqQRjvhUDJ11wg/jlhPWsFsyCECYo3ef5cqofZgylfREDPD1BXS+u5GRzsvoK4ClUJS
         tgaw==
X-Gm-Message-State: AJIora9QC3gI+Wf5B0NvGxMvB/Px4qIx8L4lSIHsY5TS64FveWTFQMHY
        PSkxSoQX4sNxmiFOm71w1XhFkA8RK/MUpg==
X-Google-Smtp-Source: AGRyM1vcFnqYSpCrlY49fkah+U80qc6Y9C7Ozo3wtzCut4wcNNU+NbVo5kf2UZf5RwDS98oX/vKfHX54FDd5xA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:d18f:0:b0:668:f385:737 with SMTP id
 i137-20020a25d18f000000b00668f3850737mr1565616ybg.205.1655870014788; Tue, 21
 Jun 2022 20:53:34 -0700 (PDT)
Date:   Wed, 22 Jun 2022 11:53:26 +0800
Message-Id: <20220622035326.759935-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
Subject: [RFC PATCH] kunit: tool: Enable virtio/PCI by default on UML
From:   David Gow <davidgow@google.com>
To:     Daniel Latypov <dlatypov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        "=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?=" <jose.exposito89@gmail.com>,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several tests which depend on PCI, and hence need a bunch of
extra options to run under UML. This makes it awkward to give
configuration instructions (whether in documentation, or as part of a
.kunitconfig file), as two separate, incompatible sets of config options
are required for UML and "most other architectures".

For non-UML architectures, it's possible to add default kconfig options
via the qemu_config python files, but there's no equivalent for UML. Add
a new tools/testing/kunit/configs/arch_uml.config file containing extra
kconfig options to use on UML.

Signed-off-by: David Gow <davidgow@google.com>
---

It's really ugly to have to type:
	--kconfig_add CONFIG_VIRTIO_UML=y
	--kconfig_add CONFIG_UML_PCI_OVER_VIRTIO=y
when running many tests under UML, particularly since it isn't required
on other architectures.

This came up in discussion with Daniel this morning, and while the
ability to repeat the --kunitconfig flag would go some way to alleviate
this, having to add:
	--kunitconfig ./tools/testing/kunit/config/uml_pci.kunitconfig
isn't all that much better.

So it seems like adding something by default would be nice.

This implementation is not perfect (in particular, there's no easy way
of _disabling_ these options now, though [1] probably will help). The
'arch_uml.config' filename can be bikeshedded, too.

Thoughts?

---
 tools/testing/kunit/configs/arch_uml.config |  5 +++++
 tools/testing/kunit/kunit_kernel.py         | 11 ++++++++---
 2 files changed, 13 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/kunit/configs/arch_uml.config

diff --git a/tools/testing/kunit/configs/arch_uml.config b/tools/testing/kunit/configs/arch_uml.config
new file mode 100644
index 000000000000..e824ce43b05a
--- /dev/null
+++ b/tools/testing/kunit/configs/arch_uml.config
@@ -0,0 +1,5 @@
+# Config options which are added to UML builds by default
+
+# Enable virtio/pci, as a lot of tests require it.
+CONFIG_VIRTIO_UML=y
+CONFIG_UML_PCI_OVER_VIRTIO=y
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 3539efaf99ba..05e7b1e188d7 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -26,6 +26,7 @@ KUNITCONFIG_PATH = '.kunitconfig'
 OLD_KUNITCONFIG_PATH = 'last_used_kunitconfig'
 DEFAULT_KUNITCONFIG_PATH = 'tools/testing/kunit/configs/default.config'
 BROKEN_ALLCONFIG_PATH = 'tools/testing/kunit/configs/broken_on_uml.config'
+UML_KCONFIG_PATH = 'tools/testing/kunit/configs/arch_uml.config'
 OUTFILE_PATH = 'test.log'
 ABS_TOOL_PATH = os.path.abspath(os.path.dirname(__file__))
 QEMU_CONFIGS_DIR = os.path.join(ABS_TOOL_PATH, 'qemu_configs')
@@ -53,7 +54,7 @@ class LinuxSourceTreeOperations:
 		except subprocess.CalledProcessError as e:
 			raise ConfigError(e.output.decode())
 
-	def make_arch_qemuconfig(self, base_kunitconfig: kunit_config.Kconfig) -> None:
+	def make_arch_config(self, base_kunitconfig: kunit_config.Kconfig) -> None:
 		pass
 
 	def make_allyesconfig(self, build_dir: str, make_options) -> None:
@@ -109,7 +110,7 @@ class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
 		self._kernel_command_line = qemu_arch_params.kernel_command_line + ' kunit_shutdown=reboot'
 		self._extra_qemu_params = qemu_arch_params.extra_qemu_params
 
-	def make_arch_qemuconfig(self, base_kunitconfig: kunit_config.Kconfig) -> None:
+	def make_arch_config(self, base_kunitconfig: kunit_config.Kconfig) -> None:
 		kconfig = kunit_config.parse_from_string(self._kconfig)
 		base_kunitconfig.merge_in_entries(kconfig)
 
@@ -137,6 +138,10 @@ class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
 	def __init__(self, cross_compile=None):
 		super().__init__(linux_arch='um', cross_compile=cross_compile)
 
+	def make_arch_config(self, base_kunitconfig: kunit_config.Kconfig) -> None:
+		kconfig = kunit_config.parse_file(UML_KCONFIG_PATH)
+		base_kunitconfig.merge_in_entries(kconfig)
+
 	def make_allyesconfig(self, build_dir: str, make_options) -> None:
 		kunit_parser.print_with_timestamp(
 			'Enabling all CONFIGs for UML...')
@@ -313,7 +318,7 @@ class LinuxSourceTree:
 			return self.build_config(build_dir, make_options)
 
 		existing_kconfig = kunit_config.parse_file(kconfig_path)
-		self._ops.make_arch_qemuconfig(self._kconfig)
+		self._ops.make_arch_config(self._kconfig)
 		if self._kconfig.is_subset_of(existing_kconfig) and not self._kunitconfig_changed(build_dir):
 			return True
 		print('Regenerating .config ...')
-- 
2.37.0.rc0.104.g0611611a94-goog

