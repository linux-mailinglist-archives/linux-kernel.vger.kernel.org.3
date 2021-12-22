Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35E447CD7D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 08:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242960AbhLVHXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 02:23:37 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:33891 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbhLVHXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 02:23:36 -0500
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JJlCz3NgMzcc6Z;
        Wed, 22 Dec 2021 15:23:11 +0800 (CST)
Received: from huawei.com (10.67.189.167) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Wed, 22 Dec
 2021 15:23:34 +0800
From:   Jiangfeng Xiao <xiaojiangfeng@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <james.clark@arm.com>,
        <leo.yan@linaro.org>, <shaolexi@huawei.com>, <qiuxi1@huawei.com>,
        <wangbing6@huawei.com>, <nixiaoming@huawei.com>,
        <xiaojiangfeng@huawei.com>
CC:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] perf dso: Avoid copying redundant kallsyms in th buildid_dir
Date:   Wed, 22 Dec 2021 15:23:23 +0800
Message-ID: <1640157803-106978-1-git-send-email-xiaojiangfeng@huawei.com>
X-Mailer: git-send-email 1.8.5.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.167]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The issue is occurs in following step:
(1)copy the kernel module (such as test.ko) to /root directory
(2)load the kernel module (such as insmod test.ko)
(3)run perf-record as: perf record sleep 1
Then /proc/kallsyms will be copied not only to
/root/.debug/[kernel.kallsyms]/<buildid>/kallsyms,
but also be copied to
/root/.debug/[test]/<buildid>/kallsyms(this is redundant).

Say a kallsyms file content takes 5MB memory,
100 out-of-tree kernel modules will take 500MB,
which is not bearable on embedded environment.

__cmd_record():
  __perf_session__new():
    perf_session__create_kernel_maps():
      machine__create_kernel_maps():
        machine__create_modules():
          machine__set_modules_path(): perf will only search for kernel
                                      modules in "/lib/modules/`uname -r`/"
                                      /root/test.ko is not in scope.
            maps__set_modules_path_dir():
              maps__set_module_path():
                dso__set_long_name(): the dso->long_name of test.ko has
                                      not changed, it is still [test].

record__finish_output():
  perf_session__write_header():
    [...]
      dso__cache_build_id():
        bool is_kallsyms = dso__is_kallsyms(dso);
          dso__is_kallsyms(): return dso->kernel&&dso->long_name[0] != '/';
                              [test] will be wrongly judged as kallsyms,
                              and then the value of is_kallsyms is true.
        build_id_cache__add_b(, is_kallsyms,):
          build_id_cache__add_s(, is_kallsyms,):
            build_id_cache__add(, is_kallsyms,):
              if (is_kallsyms)
                copyfile("/proc/kallsyms", filename): /proc/kallsyms will
                be copied to /root/.debug/[test]/<buildid>/kallsyms.

Why can this modification can avoid the redundancy of kallsyms:
  if (dso->kernel == DSO_SPACE__KERNEL) there are only two possibilities,
  one is dso__is_kallsyms, and the other is dso__is_kmod. After
  modification, [test] is no longer incorrectly judged as kallsyms.
Why can dso__is_kmod judge correctly?
  __cmd_record():
    __perf_session__new():
      perf_session__create_kernel_maps():
        machine__create_kernel_maps():
          machine__create_modules():
            modules__parse(): for each line in /proc/modules,
                              not just in "/lib/modules/`uname -r`/".
              machine__create_module():
                machine__addnew_module_map():
                  machine__findnew_module_dso():
                    dso__set_module_info(): assign dso->symtab_type to
                    DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE and so on.

Reported-by: Lexi Shao <shaolexi@huawei.com>
Signed-off-by: Jiangfeng Xiao <xiaojiangfeng@huawei.com>
---
 tools/perf/util/dso.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 011da39..57a6ab5 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -380,9 +380,17 @@ static inline bool dso__is_kcore(struct dso *dso)
 	       dso->binary_type == DSO_BINARY_TYPE__GUEST_KCORE;
 }
 
+static inline bool dso__is_kmod(struct dso *dso)
+{
+	return dso->symtab_type == DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE ||
+		dso->symtab_type == DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE_COMP ||
+		dso->symtab_type == DSO_BINARY_TYPE__GUEST_KMODULE ||
+		dso->symtab_type == DSO_BINARY_TYPE__GUEST_KMODULE_COMP;
+}
+
 static inline bool dso__is_kallsyms(struct dso *dso)
 {
-	return dso->kernel && dso->long_name[0] != '/';
+	return dso->kernel && !dso__is_kmod(dso);
 }
 
 void dso__free_a2l(struct dso *dso);
-- 
1.8.5.6

