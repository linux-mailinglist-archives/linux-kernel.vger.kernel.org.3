Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2117468F18
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 03:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbhLFC3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 21:29:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44474 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233372AbhLFC3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 21:29:23 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B60kjdc010677;
        Mon, 6 Dec 2021 02:24:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=KGHD/ZliAYdeUpnbguV1MAJFYU2IxnrYeWDnqwEQJDM=;
 b=paY4OwLDwu1f7J78vIdhG+60U0bAjd/c9I8yUSYhAR7VXxeQ7TXCSjU6A6ObfAvM+16x
 znoxQqikqMg35Q9Bsuy+VrU/UV+JR69Uqb/LvKLwgYiNXhofxV/aFMNGSfKM9vwPh1eU
 mSokw0DIZ1oQytgclfmMEjp04Dgu6EH7/+pC2l/2mNiXkLLQB/PeuydcWVAi2ZoPi9ic
 2QJMyUPdPP8bggEKrGmL6e58mTKswf21CuxBI1tX1MADtzh9uYpdnbIE9e1GA35Uts89
 w3S5mtfpCW1DOpYO5CettHMXruCU8GxHXrnKVU3vc5BjVMDub9i2YW8UsU2InYJqCbvP Ew== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cs89996f2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 02:24:43 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B62MHcZ017433;
        Mon, 6 Dec 2021 02:24:43 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cs89996em-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 02:24:42 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B62J4JN000544;
        Mon, 6 Dec 2021 02:24:40 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 3cqyy8y67y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 02:24:40 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B62Obfi26345948
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Dec 2021 02:24:37 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02EF3AE055;
        Mon,  6 Dec 2021 02:24:37 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D5B42AE051;
        Mon,  6 Dec 2021 02:24:31 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.163.31.98])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  6 Dec 2021 02:24:31 +0000 (GMT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH 4/5] perf ftrace: Add -b/--use-bpf option for latency
 subcommand
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20211129231830.1117781-5-namhyung@kernel.org>
Date:   Mon, 6 Dec 2021 07:54:27 +0530
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Song Liu <songliubraving@fb.com>,
        Changbin Du <changbin.du@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <011B6FDF-15F0-411F-98F2-155E95BE7047@linux.vnet.ibm.com>
References: <20211129231830.1117781-1-namhyung@kernel.org>
 <20211129231830.1117781-5-namhyung@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RWHqtffso1ws4q6P-0MqMn_gtFEHMmX2
X-Proofpoint-ORIG-GUID: xwCpMEWgciTVJ_oSl3sl80cLxHrHfT14
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-05_12,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 clxscore=1011 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112060011
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 30-Nov-2021, at 4:48 AM, Namhyung Kim <namhyung@kernel.org> wrote:
>=20
> The -b/--use-bpf option is to use BPF to get latency info of kernel
> functions.  It'd have better performance impact and I observed that
> latency of same function is smaller than before when using BPF.
>=20
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
> tools/perf/Makefile.perf                    |   2 +-
> tools/perf/builtin-ftrace.c                 | 156 +++++++++++---------
> tools/perf/util/Build                       |   1 +
> tools/perf/util/bpf_ftrace.c                | 113 ++++++++++++++
> tools/perf/util/bpf_skel/func_latency.bpf.c |  92 ++++++++++++
> tools/perf/util/ftrace.h                    |  81 ++++++++++
> 6 files changed, 378 insertions(+), 67 deletions(-)
> create mode 100644 tools/perf/util/bpf_ftrace.c
> create mode 100644 tools/perf/util/bpf_skel/func_latency.bpf.c
> create mode 100644 tools/perf/util/ftrace.h
>=20
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 80522bcfafe0..a861b92ac6f9 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -1041,7 +1041,7 @@ SKEL_OUT :=3D $(abspath $(OUTPUT)util/bpf_skel)
> SKEL_TMP_OUT :=3D $(abspath $(SKEL_OUT)/.tmp)
> SKELETONS :=3D $(SKEL_OUT)/bpf_prog_profiler.skel.h
> SKELETONS +=3D $(SKEL_OUT)/bperf_leader.skel.h =
$(SKEL_OUT)/bperf_follower.skel.h
> -SKELETONS +=3D $(SKEL_OUT)/bperf_cgroup.skel.h
> +SKELETONS +=3D $(SKEL_OUT)/bperf_cgroup.skel.h =
$(SKEL_OUT)/func_latency.skel.h
>=20
> $(SKEL_TMP_OUT) $(LIBBPF_OUTPUT):
> 	$(Q)$(MKDIR) -p $@
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 8fd3c9c44c69..cde1e87032a1 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -30,36 +30,12 @@
> #include "strfilter.h"
> #include "util/cap.h"
> #include "util/config.h"
> +#include "util/ftrace.h"
> #include "util/units.h"
> #include "util/parse-sublevel-options.h"
>=20
> #define DEFAULT_TRACER  "function_graph"
>=20
> -struct perf_ftrace {
> -	struct evlist		*evlist;
> -	struct target		target;
> -	const char		*tracer;
> -	struct list_head	filters;
> -	struct list_head	notrace;
> -	struct list_head	graph_funcs;
> -	struct list_head	nograph_funcs;
> -	int			graph_depth;
> -	unsigned long		percpu_buffer_size;
> -	bool			inherit;
> -	int			func_stack_trace;
> -	int			func_irq_info;
> -	int			graph_nosleep_time;
> -	int			graph_noirqs;
> -	int			graph_verbose;
> -	int			graph_thresh;
> -	unsigned int		initial_delay;
> -};
> -
> -struct filter_entry {
> -	struct list_head	list;
> -	char			name[];
> -};
> -
> static volatile int workload_exec_errno;
> static bool done;
>=20
> @@ -704,8 +680,6 @@ static int __cmd_ftrace(struct perf_ftrace =
*ftrace)
> 	return (done && !workload_exec_errno) ? 0 : -1;
> }
>=20
> -#define NUM_BUCKET  22  /* 20 + 2 (for outliers in both direction) */
> -
> static void make_histogram(int buckets[], char *buf, size_t len, char =
*linebuf)
> {
> 	char *p, *q;
> @@ -816,69 +790,116 @@ static void display_histogram(int buckets[])
>=20
> }
>=20
> -static int __cmd_latency(struct perf_ftrace *ftrace)
> +static int prepare_func_latency(struct perf_ftrace *ftrace)
> {
> 	char *trace_file;
> -	int trace_fd;
> -	char buf[4096];
> -	char line[256];
> -	struct pollfd pollfd =3D {
> -		.events =3D POLLIN,
> -	};
> -	int buckets[NUM_BUCKET] =3D { };
> +	int fd;
>=20
> -	if (!(perf_cap__capable(CAP_PERFMON) ||
> -	      perf_cap__capable(CAP_SYS_ADMIN))) {
> -		pr_err("ftrace only works for %s!\n",
> -#ifdef HAVE_LIBCAP_SUPPORT
> -		"users with the CAP_PERFMON or CAP_SYS_ADMIN capability"
> -#else
> -		"root"
> -#endif
> -		);
> -		return -1;
> -	}
> +	if (ftrace->target.use_bpf)
> +		return perf_ftrace__latency_prepare_bpf(ftrace);
>=20
> 	if (reset_tracing_files(ftrace) < 0) {
> 		pr_err("failed to reset ftrace\n");
> -		goto out;
> +		return -1;
> 	}
>=20
> 	/* reset ftrace buffer */
> 	if (write_tracing_file("trace", "0") < 0)
> -		goto out;
> +		return -1;
>=20
> 	if (set_tracing_options(ftrace) < 0)
> -		goto out_reset;
> +		return -1;
>=20
> 	/* force to use the function_graph tracer to track duration */
> 	if (write_tracing_file("current_tracer", "function_graph") < 0) =
{
> 		pr_err("failed to set current_tracer to =
function_graph\n");
> -		goto out_reset;
> +		return -1;
> 	}
>=20
> 	trace_file =3D get_tracing_file("trace_pipe");
> 	if (!trace_file) {
> 		pr_err("failed to open trace_pipe\n");
> -		goto out_reset;
> +		return -1;
> 	}
>=20
> -	trace_fd =3D open(trace_file, O_RDONLY);
> +	fd =3D open(trace_file, O_RDONLY);
> +	if (fd < 0)
> +		pr_err("failed to open trace_pipe\n");
>=20
> 	put_tracing_file(trace_file);
> +	return fd;
> +}
>=20
> -	if (trace_fd < 0) {
> -		pr_err("failed to open trace_pipe\n");
> -		goto out_reset;
> +static int start_func_latency(struct perf_ftrace *ftrace)
> +{
> +	if (ftrace->target.use_bpf)
> +		return perf_ftrace__latency_start_bpf(ftrace);
> +
> +	if (write_tracing_file("tracing_on", "1") < 0) {
> +		pr_err("can't enable tracing\n");
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int stop_func_latency(struct perf_ftrace *ftrace)
> +{
> +	if (ftrace->target.use_bpf)
> +		return perf_ftrace__latency_stop_bpf(ftrace);
> +
> +	write_tracing_file("tracing_on", "0");
> +	return 0;
> +}
> +
> +static int read_func_latency(struct perf_ftrace *ftrace, int =
buckets[])
> +{
> +	if (ftrace->target.use_bpf)
> +		return perf_ftrace__latency_read_bpf(ftrace, buckets);
> +
> +	return 0;
> +}
> +
> +static int cleanup_func_latency(struct perf_ftrace *ftrace)
> +{
> +	if (ftrace->target.use_bpf)
> +		return perf_ftrace__latency_cleanup_bpf(ftrace);
> +
> +	reset_tracing_files(ftrace);
> +	return 0;
> +}
> +
> +static int __cmd_latency(struct perf_ftrace *ftrace)
> +{
> +	int trace_fd;
> +	char buf[4096];
> +	char line[256];
> +	struct pollfd pollfd =3D {
> +		.events =3D POLLIN,
> +	};
> +	int buckets[NUM_BUCKET] =3D { };
> +
> +	if (!(perf_cap__capable(CAP_PERFMON) ||
> +	      perf_cap__capable(CAP_SYS_ADMIN))) {
> +		pr_err("ftrace only works for %s!\n",
> +#ifdef HAVE_LIBCAP_SUPPORT
> +		"users with the CAP_PERFMON or CAP_SYS_ADMIN capability"
> +#else
> +		"root"
> +#endif
> +		);
> +		return -1;
> 	}
>=20
> +	trace_fd =3D prepare_func_latency(ftrace);
> +	if (trace_fd < 0)
> +		goto out;
> +
> 	fcntl(trace_fd, F_SETFL, O_NONBLOCK);
> 	pollfd.fd =3D trace_fd;
>=20
> -	if (write_tracing_file("tracing_on", "1") < 0) {
> -		pr_err("can't enable tracing\n");
> -		goto out_close_fd;
> -	}
> +	if (start_func_latency(ftrace) < 0)
> +		goto out;
>=20
> 	evlist__start_workload(ftrace->evlist);
>=20
> @@ -896,29 +917,30 @@ static int __cmd_latency(struct perf_ftrace =
*ftrace)
> 		}
> 	}
>=20
> -	write_tracing_file("tracing_on", "0");
> +	stop_func_latency(ftrace);
>=20
> 	if (workload_exec_errno) {
> 		const char *emsg =3D str_error_r(workload_exec_errno, =
buf, sizeof(buf));
> 		pr_err("workload failed: %s\n", emsg);
> -		goto out_close_fd;
> +		goto out;
> 	}
>=20
> 	/* read remaining buffer contents */
> -	while (true) {
> +	while (!ftrace->target.use_bpf) {
> 		int n =3D read(trace_fd, buf, sizeof(buf) - 1);
> 		if (n <=3D 0)
> 			break;
> 		make_histogram(buckets, buf, n, line);
> 	}
>=20
> +	read_func_latency(ftrace, buckets);
> +
> 	display_histogram(buckets);
>=20
> -out_close_fd:
> -	close(trace_fd);
> -out_reset:
> -	reset_tracing_files(ftrace);
> out:
> +	close(trace_fd);
> +	cleanup_func_latency(ftrace);
> +
> 	return (done && !workload_exec_errno) ? 0 : -1;
> }
>=20
> @@ -1144,6 +1166,8 @@ int cmd_ftrace(int argc, const char **argv)
> 	const struct option latency_options[] =3D {
> 	OPT_CALLBACK('T', "trace-funcs", &ftrace.filters, "func",
> 		     "Show latency of given function", =
parse_filter_func),
> +	OPT_BOOLEAN('b', "use-bpf", &ftrace.target.use_bpf,
> +		    "Use BPF to measure function latency"),


Hi Namhyung,

Can this be inside BPF_SKEL check, similar to how we have =E2=80=9Cbpf-pro=
g=E2=80=9D and other options in builtin-stat.c ?

#ifdef HAVE_BPF_SKEL
<<OPT_BOOLEAN for use-bpf>>
#endif

Otherwise when using =E2=80=9C-b=E2=80=9D and if perf is not built with =
BPF_SKEL, we will just return in perf_ftrace__latency_prepare_bpf =
without any error messages.

Thanks
Athira
> 	OPT_PARENT(common_options),
> 	};
> 	const struct option *options =3D ftrace_options;
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 2e5bfbb69960..294b12430d73 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -144,6 +144,7 @@ perf-$(CONFIG_LIBBPF) +=3D bpf-loader.o
> perf-$(CONFIG_LIBBPF) +=3D bpf_map.o
> perf-$(CONFIG_PERF_BPF_SKEL) +=3D bpf_counter.o
> perf-$(CONFIG_PERF_BPF_SKEL) +=3D bpf_counter_cgroup.o
> +perf-$(CONFIG_PERF_BPF_SKEL) +=3D bpf_ftrace.o
> perf-$(CONFIG_BPF_PROLOGUE) +=3D bpf-prologue.o
> perf-$(CONFIG_LIBELF) +=3D symbol-elf.o
> perf-$(CONFIG_LIBELF) +=3D probe-file.o
> diff --git a/tools/perf/util/bpf_ftrace.c =
b/tools/perf/util/bpf_ftrace.c
> new file mode 100644
> index 000000000000..1975a6fe73c9
> --- /dev/null
> +++ b/tools/perf/util/bpf_ftrace.c
> @@ -0,0 +1,113 @@
> +#include <stdio.h>
> +#include <fcntl.h>
> +#include <stdint.h>
> +#include <stdlib.h>
> +
> +#include <linux/err.h>
> +
> +#include "util/ftrace.h"
> +#include "util/debug.h"
> +#include "util/bpf_counter.h"
> +
> +#include "util/bpf_skel/func_latency.skel.h"
> +
> +static struct func_latency_bpf *skel;
> +
> +int perf_ftrace__latency_prepare_bpf(struct perf_ftrace *ftrace)
> +{
> +	int fd, err;
> +	struct filter_entry *func;
> +	struct bpf_link *begin_link, *end_link;
> +
> +	if (!list_is_singular(&ftrace->filters)) {
> +		pr_err("ERROR: %s target function(s).\n",
> +		       list_empty(&ftrace->filters) ? "No" : "Too =
many");
> +		return -1;
> +	}
> +
> +	func =3D list_first_entry(&ftrace->filters, struct filter_entry, =
list);
> +
> +	skel =3D func_latency_bpf__open();
> +	if (!skel) {
> +		pr_err("Failed to open func latency skeleton\n");
> +		return -1;
> +	}
> +
> +	set_max_rlimit();
> +
> +	err =3D func_latency_bpf__load(skel);
> +	if (err) {
> +		pr_err("Failed to load func latency skeleton\n");
> +		goto out;
> +	}
> +
> +	begin_link =3D =
bpf_program__attach_kprobe(skel->progs.func_begin,
> +						 false, func->name);
> +	if (IS_ERR(begin_link)) {
> +		pr_err("Failed to attach fentry program\n");
> +		err =3D PTR_ERR(begin_link);
> +		goto out;
> +	}
> +
> +	end_link =3D bpf_program__attach_kprobe(skel->progs.func_end,
> +					      true, func->name);
> +	if (IS_ERR(end_link)) {
> +		pr_err("Failed to attach fexit program\n");
> +		err =3D PTR_ERR(end_link);
> +		bpf_link__destroy(begin_link);
> +		goto out;
> +	}
> +
> +	/* XXX: we don't actually use this fd - just for poll() */
> +	return open("/dev/null", O_RDONLY);
> +
> +out:
> +	return err;
> +}
> +
> +int perf_ftrace__latency_start_bpf(struct perf_ftrace *ftrace =
__maybe_unused)
> +{
> +	skel->bss->enabled =3D 1;
> +	return 0;
> +}
> +
> +int perf_ftrace__latency_stop_bpf(struct perf_ftrace *ftrace =
__maybe_unused)
> +{
> +	skel->bss->enabled =3D 0;
> +	return 0;
> +}
> +
> +int perf_ftrace__latency_read_bpf(struct perf_ftrace *ftrace =
__maybe_unused,
> +				  int buckets[])
> +{
> +	int i, fd, err;
> +	u32 idx;
> +	u64 *hist;
> +	int ncpus =3D cpu__max_cpu();
> +
> +	fd =3D bpf_map__fd(skel->maps.latency);
> +
> +	hist =3D calloc(ncpus, sizeof(*hist));
> +	if (hist =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	for (idx =3D 0; idx < NUM_BUCKET; idx++) {
> +		err =3D bpf_map_lookup_elem(fd, &idx, hist);
> +		if (err) {
> +			buckets[idx] =3D 0;
> +			continue;
> +		}
> +
> +		for (i =3D 0; i < ncpus; i++)
> +			buckets[idx] +=3D hist[i];
> +	}
> +
> +	free(hist);
> +	return 0;
> +}
> +
> +int perf_ftrace__latency_cleanup_bpf(struct perf_ftrace *ftrace =
__maybe_unused)
> +{
> +	func_latency_bpf__destroy(skel);
> +	return 0;
> +}
> diff --git a/tools/perf/util/bpf_skel/func_latency.bpf.c =
b/tools/perf/util/bpf_skel/func_latency.bpf.c
> new file mode 100644
> index 000000000000..d7d31cfeabf8
> --- /dev/null
> +++ b/tools/perf/util/bpf_skel/func_latency.bpf.c
> @@ -0,0 +1,92 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +// Copyright (c) 2021 Google
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +#define NUM_BUCKET  22
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_HASH);
> +	__uint(key_size, sizeof(__u64));
> +	__uint(value_size, sizeof(__u64));
> +	__uint(max_entries, 10000);
> +} functime SEC(".maps");
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_HASH);
> +	__uint(key_size, sizeof(__u32));
> +	__uint(value_size, sizeof(__u8));
> +	__uint(max_entries, 1);
> +} cpu_filter SEC(".maps");
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_HASH);
> +	__uint(key_size, sizeof(__u32));
> +	__uint(value_size, sizeof(__u8));
> +	__uint(max_entries, 1);
> +} task_filter SEC(".maps");
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> +	__uint(key_size, sizeof(__u32));
> +	__uint(value_size, sizeof(__u64));
> +	__uint(max_entries, NUM_BUCKET);
> +} latency SEC(".maps");
> +
> +
> +int enabled =3D 0;
> +
> +SEC("kprobe/func")
> +int BPF_PROG(func_begin)
> +{
> +	__u64 key, now;
> +
> +	if (!enabled)
> +		return 0;
> +
> +	key =3D bpf_get_current_pid_tgid();
> +	now =3D bpf_ktime_get_ns();
> +
> +	// overwrite timestamp for nested functions
> +	bpf_map_update_elem(&functime, &key, &now, BPF_ANY);
> +	return 0;
> +}
> +
> +SEC("kretprobe/func")
> +int BPF_PROG(func_end)
> +{
> +	__u64 tid;
> +	__u64 *start;
> +
> +	if (!enabled)
> +		return 0;
> +
> +	tid =3D bpf_get_current_pid_tgid();
> +
> +	start =3D bpf_map_lookup_elem(&functime, &tid);
> +	if (start) {
> +		__s64 delta =3D bpf_ktime_get_ns() - *start;
> +		__u32 key;
> +		__u64 *hist;
> +
> +		bpf_map_delete_elem(&functime, &tid);
> +
> +		if (delta < 0)
> +			return 0;
> +
> +		// calculate index using delta in usec
> +		for (key =3D 0; key < (NUM_BUCKET - 1); key++) {
> +			if (delta < ((1000UL) << key))
> +				break;
> +		}
> +
> +		hist =3D bpf_map_lookup_elem(&latency, &key);
> +		if (!hist)
> +			return 0;
> +
> +		*hist +=3D 1;
> +	}
> +
> +	return 0;
> +}
> diff --git a/tools/perf/util/ftrace.h b/tools/perf/util/ftrace.h
> new file mode 100644
> index 000000000000..887f68a185f7
> --- /dev/null
> +++ b/tools/perf/util/ftrace.h
> @@ -0,0 +1,81 @@
> +#ifndef __PERF_FTRACE_H__
> +#define __PERF_FTRACE_H__
> +
> +#include <linux/list.h>
> +
> +#include "target.h"
> +
> +struct evlist;
> +
> +struct perf_ftrace {
> +	struct evlist		*evlist;
> +	struct target		target;
> +	const char		*tracer;
> +	struct list_head	filters;
> +	struct list_head	notrace;
> +	struct list_head	graph_funcs;
> +	struct list_head	nograph_funcs;
> +	unsigned long		percpu_buffer_size;
> +	bool			inherit;
> +	int			graph_depth;
> +	int			func_stack_trace;
> +	int			func_irq_info;
> +	int			graph_nosleep_time;
> +	int			graph_noirqs;
> +	int			graph_verbose;
> +	int			graph_thresh;
> +	unsigned int		initial_delay;
> +};
> +
> +struct filter_entry {
> +	struct list_head	list;
> +	char			name[];
> +};
> +
> +#define NUM_BUCKET  22  /* 20 + 2 (for outliers in both direction) */
> +
> +#ifdef HAVE_BPF_SKEL
> +
> +int perf_ftrace__latency_prepare_bpf(struct perf_ftrace *ftrace);
> +int perf_ftrace__latency_start_bpf(struct perf_ftrace *ftrace);
> +int perf_ftrace__latency_stop_bpf(struct perf_ftrace *ftrace);
> +int perf_ftrace__latency_read_bpf(struct perf_ftrace *ftrace,
> +				  int buckets[]);
> +int perf_ftrace__latency_cleanup_bpf(struct perf_ftrace *ftrace);
> +
> +#else  /* !HAVE_BPF_SKEL */
> +
> +static inline int
> +perf_ftrace__latency_prepare_bpf(struct perf_ftrace *ftrace =
__maybe_unused)
> +{
> +	return -1;
> +}
> +
> +static inline int
> +perf_ftrace__latency_start_bpf(struct perf_ftrace *ftrace =
__maybe_unused)
> +{
> +	return -1;
> +}
> +
> +static inline int
> +perf_ftrace__latency_stop_bpf(struct perf_ftrace *ftrace =
__maybe_unused)
> +{
> +	return -1;
> +}
> +
> +static inline int
> +perf_ftrace__latency_read_bpf(struct perf_ftrace *ftrace =
__maybe_unused,
> +			      int buckets[] __maybe_unused)
> +{
> +	return -1;
> +}
> +
> +static inline int
> +perf_ftrace__latency_cleanup_bpf(struct perf_ftrace *ftrace =
__maybe_unused)
> +{
> +	return -1;
> +}
> +
> +#endif  /* HAVE_BPF_SKEL */
> +
> +#endif  /* __PERF_FTRACE_H__ */
> --=20
> 2.34.0.rc2.393.gf8c9666880-goog
>=20
>=20

