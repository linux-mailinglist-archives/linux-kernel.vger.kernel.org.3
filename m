Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA1346742B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 10:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351454AbhLCJmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 04:42:17 -0500
Received: from foss.arm.com ([217.140.110.172]:46298 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351418AbhLCJmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 04:42:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2DBD1435;
        Fri,  3 Dec 2021 01:38:51 -0800 (PST)
Received: from [10.57.82.187] (unknown [10.57.82.187])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 25C633F5A1;
        Fri,  3 Dec 2021 01:38:49 -0800 (PST)
Subject: Re: [PATCH v1 4/4] perf tools: Support register names from all
 architectures
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20211201123334.679131-1-german.gomez@arm.com>
 <20211201123334.679131-5-german.gomez@arm.com>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <c78b2533-6960-99c9-543a-965d669d1ece@arm.com>
Date:   Fri, 3 Dec 2021 09:38:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211201123334.679131-5-german.gomez@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01/12/2021 12:33, German Gomez wrote:
> [...]
>
> diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
> index eeac181eb..a201181fc 100644
> --- a/tools/perf/util/perf_regs.h
> +++ b/tools/perf/util/perf_regs.h
> @@ -27,15 +27,42 @@ uint64_t arch__user_reg_mask(void);
>  #ifdef HAVE_PERF_REGS_SUPPORT
>  extern const struct sample_reg sample_reg_masks[];
>  
> +#include <string.h>
>  #include <perf_regs.h>
>  
>  #define DWARF_MINIMAL_REGS ((1ULL << PERF_REG_IP) | (1ULL << PERF_REG_SP))
>  
>  int perf_reg_value(u64 *valp, struct regs_dump *regs, int id);
>  
> -static inline const char *perf_reg_name(int id)
> +#include "perf_regs_csky.h"
> +#include "perf_regs_mips.h"
> +#include "perf_regs_powerpc.h"
> +#include "perf_regs_riscv.h"
> +#include "perf_regs_s390.h"
> +#include "perf_regs_x86.h"
> +#include "perf_regs_arm.h"
> +#include "perf_regs_arm64.h"

Something that slipped through: this is failing to compile perf on ARM32
due to the order of the imports:

util/../../arch/arm64/include/uapi/asm/perf_regs.h:5:6: error: nested redefinition of ‘enum perf_event_arm_regs’
    5 | enum perf_event_arm_regs {
      |      ^~~~~~~~~~~~~~~~~~~

Both #import <perf_regs.h> and "perf_regs_arm.h" are importing the same
header (/tools/arch/arm/include/uapi/asm/perf_regs.h) so this part of
the [PATCH 3/4] isn't doing anything:

diff --git a/tools/perf/util/perf_regs_arm.h b/tools/perf/util/perf_regs_arm.h
new file mode 100644
index 000000000..779b40d6c
--- /dev/null
+++ b/tools/perf/util/perf_regs_arm.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef __PERF_REGS_ARM_H
+#define __PERF_REGS_ARM_H
+
+/*
+ * ARM and ARM64 registers are grouped under enums of the same name.
+ * Temporarily rename the name of the enum to prevent the naming collision.
+ */
+#define perf_event_arm_regs perf_event_arm_regs_workaround
+
+#include "../../arch/arm/include/uapi/asm/perf_regs.h"

There is a similar workaround in the csky version. Although it should
compile, I think some of the register names might be missing (the ones
under #if defined(__CSKYABIV2__)).

I'm wondering if it would be wiser to update this changeset to only
consider a small number of platforms (maybe x86 and arm64) and see how
it goes.

