Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7653559E99
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 18:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbiFXQcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 12:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbiFXQc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 12:32:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F7650E00;
        Fri, 24 Jun 2022 09:32:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 709F4B82941;
        Fri, 24 Jun 2022 16:32:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B68C34114;
        Fri, 24 Jun 2022 16:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656088344;
        bh=yYCDrZO0o9uhyNyz750MA0oHLA7lMWV6M8OXBfI793Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mG+KkjhRLrCqXzpQ1w1zNcJtX6wNjzH8HMPfvrqxfU3xCVoru7cdiJVTsoj2k5o7O
         z0fH5v81gmqqgTlrpg6PeQnsky74KrcAYo3juKmgf7PjD7UKyjIXJf5HpsQooOdoaX
         6HJ/LNdCDlNhxIXFpiBHBExmVl1N73Z+bxHsf+acjE6sYQo5/WPa/Rm3OWYeFkJvP2
         DTgi/G+Yy8NW1LYBNXiwfCbTcV968thbnv/LsvD7EPoBvCYE9H6w9D5lgI9bRUcdLv
         1FindllO1I0ZqTGesWwm0sd3SciDPsJ4y5qmaH6wwFPfgydfcKfShoF5VskWyof3VX
         P9ydyJOe+IgZA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F00184096F; Fri, 24 Jun 2022 13:32:20 -0300 (-03)
Date:   Fri, 24 Jun 2022 13:32:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        =?iso-8859-1?Q?Jo=E3o_M=E1rio?= Domingos 
        <joao.mario@tecnico.ulisboa.pt>, linux@yadro.com,
        Nikita Shubin <n.shubin@yadro.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 2/5] perf tools riscv: Add support for get_cpuid_str
 function
Message-ID: <YrXnFAaT/B1In/+t@kernel.org>
References: <20220624160117.3206-1-nikita.shubin@maquefel.me>
 <20220624160117.3206-3-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624160117.3206-3-nikita.shubin@maquefel.me>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jun 24, 2022 at 07:00:52PM +0300, Nikita Shubin escreveu:
> From: Nikita Shubin <n.shubin@yadro.com>
> 
> The get_cpuid_str function returns the string that
> contains values of MVENDORID, MARCHID and MIMPID in
> hex format separated by coma.
> 
> The values themselves are taken from first cpu entry
> in "/proc/cpuid" that contains "mvendorid", "marchid"
> and "mimpid".
> 
> Signed-off-by: Nikita Shubin <n.shubin@yadro.com>
> ---
>  tools/perf/arch/riscv/util/Build    |   1 +
>  tools/perf/arch/riscv/util/header.c | 109 ++++++++++++++++++++++++++++
>  2 files changed, 110 insertions(+)
>  create mode 100644 tools/perf/arch/riscv/util/header.c
> 
> diff --git a/tools/perf/arch/riscv/util/Build b/tools/perf/arch/riscv/util/Build
> index 7d3050134ae0..603dbb5ae4dc 100644
> --- a/tools/perf/arch/riscv/util/Build
> +++ b/tools/perf/arch/riscv/util/Build
> @@ -1,4 +1,5 @@
>  perf-y += perf_regs.o
> +perf-y += header.o
>  
>  perf-$(CONFIG_DWARF) += dwarf-regs.o
>  perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
> diff --git a/tools/perf/arch/riscv/util/header.c b/tools/perf/arch/riscv/util/header.c
> new file mode 100644
> index 000000000000..53e8ddf7990b
> --- /dev/null
> +++ b/tools/perf/arch/riscv/util/header.c
> @@ -0,0 +1,109 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Implementation of get_cpuid().
> + *
> + * Author: Nikita Shubin <n.shubin@yadro.com>
> + */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <api/fs/fs.h>
> +#include <errno.h>
> +#include "../../util/debug.h"
> +#include "../../util/header.h"
> +
> +#define CPUINFO_MVEN	"mvendorid"
> +#define CPUINFO_MARCH	"marchid"
> +#define CPUINFO_MIMP	"mimpid"
> +#define CPUINFO		"/proc/cpuinfo"
> +
> +static char *_get_field(const char *line)
> +{
> +	char *line2, *nl;
> +
> +	line2 = strrchr(line, ' ');
> +	if (!line2)
> +		return NULL;
> +
> +	line2++;
> +	nl = strrchr(line, '\n');
> +	if (!nl)
> +		return NULL;
> +
> +	return strndup(line2, nl - line2);
> +}
> +
> +static char *_get_cpuid(void)
> +{
> +	char *line = NULL;
> +	char *mvendorid = NULL;
> +	char *marchid = NULL;
> +	char *mimpid = NULL;
> +	char *cpuid = NULL;
> +	int read;
> +	unsigned long line_sz;
> +	FILE *cpuinfo;
> +
> +	cpuinfo = fopen(CPUINFO, "r");
> +	if (cpuinfo == NULL)
> +		return cpuid;
> +
> +	while ((read = getline(&line, &line_sz, cpuinfo)) != -1) {
> +		if (!strncmp(line, CPUINFO_MVEN, strlen(CPUINFO_MVEN))) {
> +			mvendorid = _get_field(line);
> +			if (!mvendorid)
> +				goto free;
> +		} else if (!strncmp(line, CPUINFO_MARCH, strlen(CPUINFO_MARCH))) {
> +			marchid = _get_field(line);
> +			if (!marchid)
> +				goto free;
> +		} else if (!strncmp(line, CPUINFO_MIMP, strlen(CPUINFO_MIMP))) {
> +			mimpid = _get_field(line);
> +			if (!mimpid)
> +				goto free;
> +
> +			break;
> +		}
> +	}
> +
> +	if (!mvendorid || !marchid || !mimpid) {
> +		cpuid = NULL;
> +		goto free;
> +	}
> +
> +	if (asprintf(&cpuid, "%s-%s-%s", mvendorid, marchid, mimpid) < 0)
> +		cpuid = NULL;
> +
> +free:
> +	fclose(cpuinfo);
> +
> +	if (mvendorid)
> +		free(mvendorid);
> +
> +	if (marchid)
> +		free(marchid);
> +
> +	if (mimpid)
> +		free(mimpid);

just use:

	
	free(mvendorid);
	free(marchid);
	free(mimpid);

fewer lines, free() accepts NULL.

> +
> +	return cpuid;
> +}
> +
> +int get_cpuid(char *buffer, size_t sz)
> +{
> +	char *cpuid = _get_cpuid();
> +
> +	if (sz < strlen(cpuid)) {
> +		free(cpuid);
> +		return -EINVAL;
> +	}
> +
> +	scnprintf(buffer, sz, "%s", cpuid);

You're leaking cpuid here.

> +	return 0;
> +}
> +
> +char *
> +get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
> +{
> +	return _get_cpuid();
> +}
> -- 
> 2.35.1

-- 

- Arnaldo
