Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416E94BA597
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 17:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242999AbiBQQUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 11:20:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242997AbiBQQUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 11:20:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34D027019C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 08:19:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6FAD6B822C0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 16:19:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A2DC340E9;
        Thu, 17 Feb 2022 16:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645114789;
        bh=ByqICwRC78hF+OVa1i8FtpczDlPGoJKesouvh34GZ3o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RB2Y70pWaGFKMD4kiFjKstoMd3D8Nm3shVBsYlu4kPBzGuFPUjabi7ZFiQpK4NYQJ
         JPVrWTPBPpdqJSklmW8CwxhQM5WcLNWj6qMGR+o38B59T2YGLWw9TdicHrWJJqBpB2
         4C4yS0ULi1K9J9saRRUoaUHHTYh/O0m1Y8Jcnr0Ef61DDrDj53cWQ2c8ga+YHOmXRd
         tPKZnYjfat+MWNabYHw3kxhuU8JI3kUEhSDEceSzZZDTjDUfewVuZsdErqaVwGErip
         Z4WkKtliIdbwkVjGeAJgoT4kSL8iV4+oCBTF1pEYpGChI+cootFZnBmExqOMhzbr7W
         LdxPCnmf2P2tg==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     rientjes@google.com, xhao@linux.alibaba.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [RFC PATCH 4/4] selftests/damon: Add a test for DAMON sysfs interface
Date:   Thu, 17 Feb 2022 16:19:38 +0000
Message-Id: <20220217161938.8874-5-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220217161938.8874-1-sj@kernel.org>
References: <20220217161938.8874-1-sj@kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds a selftest for DAMON sysfs interface.  It tests
functionality of 'nr' files and existence of files in each directory of
the hierarchy.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/Makefile |   1 +
 tools/testing/selftests/damon/sysfs.sh | 200 +++++++++++++++++++++++++
 2 files changed, 201 insertions(+)
 create mode 100755 tools/testing/selftests/damon/sysfs.sh

diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/selftests/damon/Makefile
index 937d36ae9a69..0470c5f3e690 100644
--- a/tools/testing/selftests/damon/Makefile
+++ b/tools/testing/selftests/damon/Makefile
@@ -6,5 +6,6 @@ TEST_GEN_FILES += huge_count_read_write
 TEST_FILES = _chk_dependency.sh _debugfs_common.sh
 TEST_PROGS = debugfs_attrs.sh debugfs_schemes.sh debugfs_target_ids.sh
 TEST_PROGS += debugfs_empty_targets.sh debugfs_huge_count_read_write.sh
+TEST_PROGS += sysfs.sh
 
 include ../lib.mk
diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
new file mode 100755
index 000000000000..280fd6fabcd7
--- /dev/null
+++ b/tools/testing/selftests/damon/sysfs.sh
@@ -0,0 +1,200 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# Kselftest frmework requirement - SKIP code is 4.
+ksft_skip=4
+
+ensure_write_succ()
+{
+	file=$1
+	content=$2
+	reason=$3
+
+	if ! echo "$content" > "$file"
+	then
+		echo "writing $content to $file failed"
+		echo "expected success because $reason"
+		exit 1
+	fi
+}
+
+ensure_write_fail()
+{
+	file=$1
+	content=$2
+	reason=$3
+
+	if echo "$content" > "$file"
+	then
+		echo "writing $content to $file succeed ($fail_reason)"
+		echo "expected failure because $reason"
+		exit 1
+	fi
+}
+
+ensure_dir()
+{
+	dir=$1
+	to_ensure=$2
+	if [ "$to_ensure" = "exist" ] && [ ! -d "$dir" ]
+	then
+		echo "$dir dir is expected but not found"
+		exit 1
+	elif [ "$to_ensure" = "not_exist" ] && [ -d "$dir" ]
+	then
+		echo "$dir dir is not expected but found"
+		exit 1
+	fi
+}
+
+ensure_file()
+{
+	file=$1
+	to_ensure=$2
+	permission=$3
+	if [ "$to_ensure" = "exist" ]
+	then
+		if [ ! -f "$file" ]
+		then
+			echo "$file is expected but not found"
+			exit 1
+		fi
+		perm=$(stat -c "%a" "$file")
+		if [ ! "$perm" = "$permission" ]
+		then
+			echo "$file permission: expected $permission but $perm"
+			exit 1
+		fi
+	elif [ "$to_ensure" = "not_exist" ] && [ -f "$dir" ]
+	then
+		echo "$file is not expected but found"
+		exit 1
+	fi
+}
+
+test_range()
+{
+	range_dir=$1
+	ensure_dir "$range_dir" "exist"
+	ensure_file "$range_dir/min" "exist" 600
+	ensure_file "$range_dir/max" "exist" 600
+}
+
+test_target()
+{
+	target_dir=$1
+	ensure_dir "$target_dir" "exist"
+	ensure_file "$target_dir/pid" "exist" "600"
+}
+
+test_targets()
+{
+	targets_dir=$1
+	ensure_dir "$targets_dir" "exist"
+	ensure_file "$targets_dir/nr" "exist" 600
+
+	ensure_write_succ  "$targets_dir/nr" "1" "valid input"
+	test_target "$targets_dir/0"
+
+	ensure_write_succ  "$targets_dir/nr" "2" "valid input"
+	test_target "$targets_dir/0"
+	test_target "$targets_dir/1"
+
+	ensure_write_succ "$targets_dir/nr" "0" "valid input"
+	ensure_dir "$targets_dir/0" "not_exist"
+	ensure_dir "$targets_dir/1" "not_exist"
+}
+
+test_intervals()
+{
+	intervals_dir=$1
+	ensure_dir "$intervals_dir" "exist"
+	ensure_file "$intervals_dir/aggr_us" "exist" "600"
+	ensure_file "$intervals_dir/sample_us" "exist" "600"
+	ensure_file "$intervals_dir/update_us" "exist" "600"
+}
+
+test_monitoring_attrs()
+{
+	monitoring_attrs_dir=$1
+	ensure_dir "$monitoring_attrs_dir" "exist"
+	test_intervals "$monitoring_attrs_dir/intervals"
+	test_range "$monitoring_attrs_dir/nr_regions"
+}
+
+test_context()
+{
+	context_dir=$1
+	ensure_dir "$context_dir" "exist"
+	ensure_file "$context_dir/operations" "exist" 600
+	test_monitoring_attrs "$context_dir/monitoring_attrs"
+	test_targets "$context_dir/targets"
+}
+
+test_contexts()
+{
+	contexts_dir=$1
+	ensure_dir "$contexts_dir" "exist"
+	ensure_file "$contexts_dir/nr" "exist" 600
+
+	ensure_write_succ  "$contexts_dir/nr" "1" "valid input"
+	test_context "$contexts_dir/0"
+
+	ensure_write_fail "$contexts_dir/nr" "2" "only 0/1 are supported"
+	test_context "$contexts_dir/0"
+
+	ensure_write_succ "$contexts_dir/nr" "0" "valid input"
+	ensure_dir "$contexts_dir/0" "not_exist"
+}
+
+test_kdamond()
+{
+	kdamond_dir=$1
+	ensure_dir "$kdamond_dir" "exist"
+	ensure_file "$kdamond_dir/state" "exist" "600"
+	ensure_file "$kdamond_dir/pid" "exist" 400
+	test_contexts "$kdamond_dir/contexts"
+}
+
+test_kdamonds()
+{
+	kdamonds_dir=$1
+	ensure_dir "$kdamonds_dir" "exist"
+
+	ensure_file "$kdamonds_dir/nr" "exist" "600"
+
+	ensure_write_succ  "$kdamonds_dir/nr" "1" "valid input"
+	test_kdamond "$kdamonds_dir/0"
+
+	ensure_write_succ  "$kdamonds_dir/nr" "2" "valid input"
+	test_kdamond "$kdamonds_dir/0"
+	test_kdamond "$kdamonds_dir/1"
+
+	ensure_write_succ "$kdamonds_dir/nr" "0" "valid input"
+	ensure_dir "$kdamonds_dir/0" "not_exist"
+	ensure_dir "$kdamonds_dir/1" "not_exist"
+}
+
+test_damon_sysfs()
+{
+	damon_sysfs=$1
+	if [ ! -d "$damon_sysfs" ]
+	then
+		echo "$damon_sysfs not found"
+		exit $ksft_skip
+	fi
+
+	test_kdamonds "$damon_sysfs/kdamonds"
+}
+
+check_dependencies()
+{
+	if [ $EUID -ne 0 ]
+	then
+		echo "Run as root"
+		exit $ksft_skip
+	fi
+}
+
+check_dependencies
+test_damon_sysfs "/sys/kernel/mm/damon/admin"
-- 
2.17.1

