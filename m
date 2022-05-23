Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8836F530BA2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 11:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbiEWIOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 04:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbiEWIOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 04:14:08 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA1A1AF0A
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:14:06 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n124-20020a1c2782000000b003972dfca96cso6234335wmn.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F6KcD1PJVV651OHbadDhTTwGh57iEt1ZA0A/vLUP8H8=;
        b=boxCIFm4cLrqz23LV3WS6nPPYpGwWflN9d7rpa4KqScm27wlVhYQVX1jkEHWTHsELW
         94NAhUhQb01EiTUjtBzxoHiLLRccD9CtCS0o2Lyw3MpkQZDTFp8+6B3e6KXZFtkLuLIc
         pvMswPyPPsCn+UGF4xhHwdXHQVvrawiQMl9kunHEUtGcsWf+nAZ/jaXEPi0bJbf5J/Al
         /J/TyAZ4KoIsMhWGkL8OiVUQdWJimHGaHN9ndWiUEA6JxXG40S6DstliM5ssKZj3qPt5
         zcHbBlj1Ufm4CVdgqffyYgo3raE1CngqrTWFN3IS+wn9AGbxyFfP7QrEaBi+u0hPCWgT
         ZxmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F6KcD1PJVV651OHbadDhTTwGh57iEt1ZA0A/vLUP8H8=;
        b=BSGhrVrVyd+k2ddSS3AExuUTTcon6xRM0X2vTE+oIZOPGsfGfgd9s1QMTzOx/xlstN
         LaY/0bOe6BUvFumsUa7v0VjK6VY0yRRE7Wa8ATfJMRtLMo7jVT1/oWemjL+2UemGAKlL
         ghjs7ghGa8gzHOPq2RhYZOi+WO+zH7YCYM4EQJizvY0DHx6WoNBl+b644SVy8dNnhSTb
         afDYwmE3R1VxDwZQZCjxjOUw96xxoXwsodOdrpcttF5D28gIdr44DIQRs5p2Vw3jQ9BJ
         PSJE6+ZevBMCI8yf+PS9etznzWZYtNWTxbgj4kjCPd8FIHqm6+E5x5oDS29HSQYq2xkb
         TR9Q==
X-Gm-Message-State: AOAM531AP4i3IBgmJFhoV5sEPUY9qxo/vCs1SSMNCOEpGjbRkb9WMXoK
        3LKZU0VOXP2lkpKpW7ecfvTVWawv+WVsIA==
X-Google-Smtp-Source: ABdhPJyURQCXsvTiFEqwoS4aMKCopjgk8iKEFp/wyS8kHAWSFGDzI7Q3FHR8MD5HiPfPXdTVOqscfQ==
X-Received: by 2002:a05:600c:285:b0:395:b9bf:57 with SMTP id 5-20020a05600c028500b00395b9bf0057mr19542787wmk.21.1653293644768;
        Mon, 23 May 2022 01:14:04 -0700 (PDT)
Received: from krava (net-93-65-240-241.cust.vodafonedsl.it. [93.65.240.241])
        by smtp.gmail.com with ESMTPSA id l8-20020a7bc448000000b003942a244f2esm8211221wmi.7.2022.05.23.01.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 01:14:04 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 23 May 2022 10:14:00 +0200
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] perf inject: Keep some features sections from input
 file
Message-ID: <YotCSDje68aEyFRD@krava>
References: <20220520132404.25853-1-adrian.hunter@intel.com>
 <20220520132404.25853-4-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520132404.25853-4-adrian.hunter@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 04:24:02PM +0300, Adrian Hunter wrote:
> perf inject overwrites feature sections with information from the current
> machine. It makes more sense to keep original information that describes
> the machine or software when perf record was run.
> 
> Example: perf.data from "Desktop" injected on "nuc11"
> 
>  Before:
> 
>   $ perf script --header-only -i perf.data-from-desktop | head -15
>   # ========
>   # captured on    : Thu May 19 09:55:50 2022
>   # header version : 1
>   # data offset    : 1208
>   # data size      : 837480
>   # feat offset    : 838688
>   # hostname : Desktop
>   # os release : 5.13.0-41-generic
>   # perf version : 5.18.rc5.gac837f7ca7ed
>   # arch : x86_64
>   # nrcpus online : 28
>   # nrcpus avail : 28
>   # cpudesc : Intel(R) Core(TM) i9-9940X CPU @ 3.30GHz
>   # cpuid : GenuineIntel,6,85,4
>   # total memory : 65548656 kB
> 
>   $ perf inject -i perf.data-from-desktop -o injected-perf.data
> 
>   $ perf script --header-only -i injected-perf.data | head -15
>   # ========
>   # captured on    : Fri May 20 15:06:55 2022
>   # header version : 1
>   # data offset    : 1208
>   # data size      : 837480
>   # feat offset    : 838688
>   # hostname : nuc11
>   # os release : 5.17.5-local
>   # perf version : 5.18.rc5.g0f828fdeb9af
>   # arch : x86_64
>   # nrcpus online : 8
>   # nrcpus avail : 8
>   # cpudesc : 11th Gen Intel(R) Core(TM) i7-1165G7 @ 2.80GHz
>   # cpuid : GenuineIntel,6,140,1
>   # total memory : 16012124 kB
> 
>  After:
> 
>   $ perf inject -i perf.data-from-desktop -o injected-perf.data
> 
>   $ perf script --header-only -i injected-perf.data | head -15
>   # ========
>   # captured on    : Fri May 20 15:08:54 2022

too bad date is not in separate feature right?

jirka

>   # header version : 1
>   # data offset    : 1208
>   # data size      : 837480
>   # feat offset    : 838688
>   # hostname : Desktop
>   # os release : 5.13.0-41-generic
>   # perf version : 5.18.rc5.gac837f7ca7ed
>   # arch : x86_64
>   # nrcpus online : 28
>   # nrcpus avail : 28
>   # cpudesc : Intel(R) Core(TM) i9-9940X CPU @ 3.30GHz
>   # cpuid : GenuineIntel,6,85,4
>   # total memory : 65548656 kB
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/builtin-inject.c | 129 +++++++++++++++++++++++++++++++++++-
>  tools/perf/util/header.c    |   8 +++
>  tools/perf/util/header.h    |   5 ++
>  3 files changed, 141 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 5b50a4abf95f..71b6eafe4c19 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -27,6 +27,8 @@
>  #include "util/namespaces.h"
>  #include "util/util.h"
>  
> +#include <internal/lib.h>
> +
>  #include <linux/err.h>
>  #include <subcmd/parse-options.h>
>  #include <uapi/linux/mman.h> /* To get things like MAP_HUGETLB even on older libc headers */
> @@ -55,6 +57,7 @@ struct perf_inject {
>  	struct list_head	samples;
>  	struct itrace_synth_opts itrace_synth_opts;
>  	char			event_copy[PERF_SAMPLE_MAX_SIZE];
> +	struct perf_file_section secs[HEADER_FEAT_BITS];
>  };
>  
>  struct event_entry {
> @@ -763,6 +766,120 @@ static int parse_vm_time_correlation(const struct option *opt, const char *str,
>  	return inject->itrace_synth_opts.vm_tm_corr_args ? 0 : -ENOMEM;
>  }
>  
> +static int save_section_info_cb(struct perf_file_section *section,
> +				struct perf_header *ph __maybe_unused,
> +				int feat, int fd __maybe_unused, void *data)
> +{
> +	struct perf_inject *inject = data;
> +
> +	inject->secs[feat] = *section;
> +	return 0;
> +}
> +
> +static int save_section_info(struct perf_inject *inject)
> +{
> +	struct perf_header *header = &inject->session->header;
> +	int fd = perf_data__fd(inject->session->data);
> +
> +	return perf_header__process_sections(header, fd, inject, save_section_info_cb);
> +}
> +
> +static bool keep_feat(int feat)
> +{
> +	switch (feat) {
> +	/* Keep original information that describes the machine or software */
> +	case HEADER_TRACING_DATA:
> +	case HEADER_HOSTNAME:
> +	case HEADER_OSRELEASE:
> +	case HEADER_VERSION:
> +	case HEADER_ARCH:
> +	case HEADER_NRCPUS:
> +	case HEADER_CPUDESC:
> +	case HEADER_CPUID:
> +	case HEADER_TOTAL_MEM:
> +	case HEADER_CPU_TOPOLOGY:
> +	case HEADER_NUMA_TOPOLOGY:
> +	case HEADER_PMU_MAPPINGS:
> +	case HEADER_CACHE:
> +	case HEADER_MEM_TOPOLOGY:
> +	case HEADER_CLOCKID:
> +	case HEADER_BPF_PROG_INFO:
> +	case HEADER_BPF_BTF:
> +	case HEADER_CPU_PMU_CAPS:
> +	case HEADER_CLOCK_DATA:
> +	case HEADER_HYBRID_TOPOLOGY:
> +	case HEADER_HYBRID_CPU_PMU_CAPS:
> +		return true;
> +	/* Information that can be updated */
> +	case HEADER_BUILD_ID:
> +	case HEADER_CMDLINE:
> +	case HEADER_EVENT_DESC:
> +	case HEADER_BRANCH_STACK:
> +	case HEADER_GROUP_DESC:
> +	case HEADER_AUXTRACE:
> +	case HEADER_STAT:
> +	case HEADER_SAMPLE_TIME:
> +	case HEADER_DIR_FORMAT:
> +	case HEADER_COMPRESSED:
> +	default:
> +		return false;
> +	};
> +}
> +
> +static int read_file(int fd, u64 offs, void *buf, size_t sz)
> +{
> +	ssize_t ret = preadn(fd, buf, sz, offs);
> +
> +	if (ret < 0)
> +		return -errno;
> +	if ((size_t)ret != sz)
> +		return -EINVAL;
> +	return 0;
> +}
> +
> +static int feat_copy(struct perf_inject *inject, int feat, struct feat_writer *fw)
> +{
> +	int fd = perf_data__fd(inject->session->data);
> +	u64 offs = inject->secs[feat].offset;
> +	size_t sz = inject->secs[feat].size;
> +	void *buf = malloc(sz);
> +	int ret;
> +
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	ret = read_file(fd, offs, buf, sz);
> +	if (ret)
> +		goto out_free;
> +
> +	ret = fw->write(fw, buf, sz);
> +out_free:
> +	free(buf);
> +	return ret;
> +}
> +
> +struct inject_fc {
> +	struct feat_copier fc;
> +	struct perf_inject *inject;
> +};
> +
> +static int feat_copy_cb(struct feat_copier *fc, int feat, struct feat_writer *fw)
> +{
> +	struct inject_fc *inj_fc = container_of(fc, struct inject_fc, fc);
> +	struct perf_inject *inject = inj_fc->inject;
> +	int ret;
> +
> +	if (!inject->secs[feat].offset ||
> +	    !keep_feat(feat))
> +		return 0;
> +
> +	ret = feat_copy(inject, feat, fw);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 1; /* Feature section copied */
> +}
> +
>  static int output_fd(struct perf_inject *inject)
>  {
>  	return inject->in_place_update ? -1 : perf_data__fd(&inject->output);
> @@ -848,6 +965,11 @@ static int __cmd_inject(struct perf_inject *inject)
>  		return ret;
>  
>  	if (!inject->is_pipe && !inject->in_place_update) {
> +		struct inject_fc inj_fc = {
> +			.fc.copy = feat_copy_cb,
> +			.inject = inject,
> +		};
> +
>  		if (inject->build_ids)
>  			perf_header__set_feat(&session->header,
>  					      HEADER_BUILD_ID);
> @@ -872,7 +994,7 @@ static int __cmd_inject(struct perf_inject *inject)
>  		}
>  		session->header.data_offset = output_data_offset;
>  		session->header.data_size = inject->bytes_written;
> -		perf_session__write_header(session, session->evlist, fd, true);
> +		perf_session__inject_header(session, session->evlist, fd, &inj_fc.fc);
>  	}
>  
>  	return ret;
> @@ -1037,6 +1159,11 @@ int cmd_inject(int argc, const char **argv)
>  	if (zstd_init(&(inject.session->zstd_data), 0) < 0)
>  		pr_warning("Decompression initialization failed.\n");
>  
> +	/* Save original section info before feature bits change */
> +	ret = save_section_info(&inject);
> +	if (ret)
> +		goto out_delete;
> +
>  	if (!data.is_pipe && inject.output.is_pipe) {
>  		ret = perf_header__write_pipe(perf_data__fd(&inject.output));
>  		if (ret < 0) {
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index b0c57a130d1e..53332da100e8 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -3686,6 +3686,14 @@ int perf_session__write_header(struct perf_session *session,
>  	return perf_session__do_write_header(session, evlist, fd, at_exit, NULL);
>  }
>  
> +int perf_session__inject_header(struct perf_session *session,
> +				struct evlist *evlist,
> +				int fd,
> +				struct feat_copier *fc)
> +{
> +	return perf_session__do_write_header(session, evlist, fd, true, fc);
> +}
> +
>  static int perf_header__getbuffer64(struct perf_header *header,
>  				    int fd, void *buf, size_t size)
>  {
> diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
> index e76ab02d5541..08563c1f1bff 100644
> --- a/tools/perf/util/header.h
> +++ b/tools/perf/util/header.h
> @@ -131,6 +131,11 @@ struct feat_copier {
>  	int (*copy)(struct feat_copier *fc, int feat, struct feat_writer *fw);
>  };
>  
> +int perf_session__inject_header(struct perf_session *session,
> +				struct evlist *evlist,
> +				int fd,
> +				struct feat_copier *fc);
> +
>  void perf_header__set_feat(struct perf_header *header, int feat);
>  void perf_header__clear_feat(struct perf_header *header, int feat);
>  bool perf_header__has_feat(const struct perf_header *header, int feat);
> -- 
> 2.25.1
> 
