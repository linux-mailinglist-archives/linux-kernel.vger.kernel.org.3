Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5300748F931
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 21:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbiAOUWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 15:22:16 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:34166 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbiAOUWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 15:22:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 602BA60F59;
        Sat, 15 Jan 2022 20:22:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D6F4C36AE7;
        Sat, 15 Jan 2022 20:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642278134;
        bh=VbMPe2lie0zxRzOLKttT0Z3jfRARcv1C6Pq01zyjRpE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ozkDi7FXhYCGFkWqIFRzOYgqyWLl2gZHLJ+CAw0p3S+K1fnpdtWgpilVEI85HfZUn
         VZsOLV8sJxYiCW/UWmo++ARFsQLnZb0O7/lsHHzEfPbnt3iTPzHYTnFnMqz9SSxMhg
         GTpMtA4XJs7srxe1raOSwJ4sg5oRH6aN4cYXsSC+Ol5a23ccrEUK2MRjZTPcSpZvlv
         Zxf8KFNzHbtVO0Cc74bLmlgUp8efh1STmup/f9ojjyjnEJrgLFHEY4UNEts+1Y6bZj
         DD8TmRASbqVwJM1DZ5g7FdIgwkB/Eesi3Ctf7YNJvGgthQ/EOpJWhpjTJuUxD47sLQ
         8DSI8D891722Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5331740714; Sat, 15 Jan 2022 17:22:12 -0300 (-03)
Date:   Sat, 15 Jan 2022 17:22:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org,
        "Frank Ch. Eigler" <fche@redhat.com>
Subject: Re: [RFC] perf record: Disable debuginfod by default
Message-ID: <YeMs9OnWKosZ1+LH@kernel.org>
References: <20211209200425.303561-1-jolsa@kernel.org>
 <Yb8ubHK38NXDQE+O@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yb8ubHK38NXDQE+O@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Dec 19, 2021 at 02:06:52PM +0100, Jiri Olsa escreveu:
> On Thu, Dec 09, 2021 at 09:04:25PM +0100, Jiri Olsa wrote:
> > hi,
> > after migrating to fedora 35 I found perf record hanging on exit
> > and it's because fedora 35 sets DEBUGINFOD_URLS that triggers
> > debuginfod query which might take long time to process.
> > 
> > I discussed this briefly with Frank and I'm sending the change
> > to disable debuginfod by default in perf record.
> > 
> > Frank had other idea we could discuss here to fork or just spawn
> > "/usr/bin/debuginfod-find ...." into background after perf record.
> > 
> > Perhaps there are other ways as well, hence this is RFC ;-)
> > 
> > thanks,
> > jirka
> 
> Arnaldo,
> looks like there are no more comments, do you need me to repost
> it as normal patch? there's no change after rebasing on top of
> your perf/core branch

Applying now, after fixing up minor fuzzes.
 
> thanks,
> jirka
> 
> > 
> > 
> > ---
> > Fedora 35 sets by default DEBUGINFOD_URLS, which might lead
> > to unexpected stalls in perf record exit path, when we try
> > to cache profiled binaries.
> > 
> >   # DEBUGINFOD_PROGRESS=1 ./perf record -a
> >   ^C[ perf record: Woken up 1 times to write data ]
> >   Downloading from https://debuginfod.fedoraproject.org/ 447069
> >   Downloading from https://debuginfod.fedoraproject.org/ 1502175
> >   Downloading \^Z
> > 
> > Disabling DEBUGINFOD_URLS by default in perf record and adding
> > debuginfod option and .perfconfig variable support to enable id.
> > 
> >   Default without debuginfo processing:
> >   # perf record -a
> > 
> >   Using system debuginfod setup:
> >   # perf record -a --debuginfod
> > 
> >   Using custom debuginfd url:
> >   # perf record -a --debuginfod='https://evenbetterdebuginfodserver.krava'
> > 
> > Adding single perf_debuginfod_setup function and using
> > it also in perf buildid-cache command.
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  .../perf/Documentation/perf-buildid-cache.txt |  5 +++-
> >  tools/perf/Documentation/perf-config.txt      |  9 +++++++
> >  tools/perf/Documentation/perf-record.txt      |  9 +++++++
> >  tools/perf/builtin-buildid-cache.c            | 25 +++++++++++--------
> >  tools/perf/builtin-record.c                   | 13 ++++++++++
> >  tools/perf/util/util.c                        | 15 +++++++++++
> >  tools/perf/util/util.h                        |  6 +++++
> >  7 files changed, 70 insertions(+), 12 deletions(-)
> > 
> > diff --git a/tools/perf/Documentation/perf-buildid-cache.txt b/tools/perf/Documentation/perf-buildid-cache.txt
> > index cd8ce6e8ec12..7e44b419d301 100644
> > --- a/tools/perf/Documentation/perf-buildid-cache.txt
> > +++ b/tools/perf/Documentation/perf-buildid-cache.txt
> > @@ -74,12 +74,15 @@ OPTIONS
> >  	used when creating a uprobe for a process that resides in a
> >  	different mount namespace from the perf(1) utility.
> >  
> > ---debuginfod=URLs::
> > +--debuginfod[=URLs]::
> >  	Specify debuginfod URL to be used when retrieving perf.data binaries,
> >  	it follows the same syntax as the DEBUGINFOD_URLS variable, like:
> >  
> >  	  buildid-cache.debuginfod=http://192.168.122.174:8002
> >  
> > +	If the URLs is not specified, the value of DEBUGINFOD_URLS
> > +	system environment variable is used.
> > +
> >  SEE ALSO
> >  --------
> >  linkperf:perf-record[1], linkperf:perf-report[1], linkperf:perf-buildid-list[1]
> > diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
> > index 3bb75c1f25e8..0420e71698ee 100644
> > --- a/tools/perf/Documentation/perf-config.txt
> > +++ b/tools/perf/Documentation/perf-config.txt
> > @@ -587,6 +587,15 @@ record.*::
> >  		Use 'n' control blocks in asynchronous (Posix AIO) trace writing
> >  		mode ('n' default: 1, max: 4).
> >  
> > +	record.debuginfod::
> > +		Specify debuginfod URL to be used when cacheing perf.data binaries,
> > +		it follows the same syntax as the DEBUGINFOD_URLS variable, like:
> > +
> > +		  http://192.168.122.174:8002
> > +
> > +		If the URLs is 'system', the value of DEBUGINFOD_URLS system environment
> > +		variable is used.
> > +
> >  diff.*::
> >  	diff.order::
> >  		This option sets the number of columns to sort the result.
> > diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> > index 55df7b073a55..9ccc75935bc5 100644
> > --- a/tools/perf/Documentation/perf-record.txt
> > +++ b/tools/perf/Documentation/perf-record.txt
> > @@ -715,6 +715,15 @@ measurements:
> >  
> >  include::intel-hybrid.txt[]
> >  
> > +--debuginfod[=URLs]::
> > +	Specify debuginfod URL to be used when cacheing perf.data binaries,
> > +	it follows the same syntax as the DEBUGINFOD_URLS variable, like:
> > +
> > +	  http://192.168.122.174:8002
> > +
> > +	If the URLs is not specified, the value of DEBUGINFOD_URLS
> > +	system environment variable is used.
> > +
> >  SEE ALSO
> >  --------
> >  linkperf:perf-stat[1], linkperf:perf-list[1], linkperf:perf-intel-pt[1]
> > diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
> > index 0db3cfc04c47..cd381693658b 100644
> > --- a/tools/perf/builtin-buildid-cache.c
> > +++ b/tools/perf/builtin-buildid-cache.c
> > @@ -351,10 +351,14 @@ static int build_id_cache__show_all(void)
> >  
> >  static int perf_buildid_cache_config(const char *var, const char *value, void *cb)
> >  {
> > -	const char **debuginfod = cb;
> > +	struct perf_debuginfod *di = cb;
> >  
> > -	if (!strcmp(var, "buildid-cache.debuginfod"))
> > -		*debuginfod = strdup(value);
> > +	if (!strcmp(var, "buildid-cache.debuginfod")) {
> > +		di->urls = strdup(value);
> > +		if (!di->urls)
> > +			return -ENOMEM;
> > +		di->set = true;
> > +	}
> >  
> >  	return 0;
> >  }
> > @@ -373,8 +377,8 @@ int cmd_buildid_cache(int argc, const char **argv)
> >  		   *purge_name_list_str = NULL,
> >  		   *missing_filename = NULL,
> >  		   *update_name_list_str = NULL,
> > -		   *kcore_filename = NULL,
> > -		   *debuginfod = NULL;
> > +		   *kcore_filename = NULL;
> > +	struct perf_debuginfod debuginfod = { };
> >  	char sbuf[STRERR_BUFSIZE];
> >  
> >  	struct perf_data data = {
> > @@ -399,8 +403,10 @@ int cmd_buildid_cache(int argc, const char **argv)
> >  	OPT_BOOLEAN('f', "force", &force, "don't complain, do it"),
> >  	OPT_STRING('u', "update", &update_name_list_str, "file list",
> >  		    "file(s) to update"),
> > -	OPT_STRING(0, "debuginfod", &debuginfod, "debuginfod url",
> > -		    "set debuginfod url"),
> > +	OPT_STRING_OPTARG_SET(0, "debuginfod", &debuginfod.urls,
> > +			&debuginfod.set, "debuginfod urls",
> > +			"Enable debuginfod data retrieval from DEBUGINFOD_URLS or specified urls",
> > +			"system"),
> >  	OPT_INCR('v', "verbose", &verbose, "be more verbose"),
> >  	OPT_INTEGER(0, "target-ns", &ns_id, "target pid for namespace context"),
> >  	OPT_END()
> > @@ -425,10 +431,7 @@ int cmd_buildid_cache(int argc, const char **argv)
> >  	if (argc || !(list_files || opts_flag))
> >  		usage_with_options(buildid_cache_usage, buildid_cache_options);
> >  
> > -	if (debuginfod) {
> > -		pr_debug("DEBUGINFOD_URLS=%s\n", debuginfod);
> > -		setenv("DEBUGINFOD_URLS", debuginfod, 1);
> > -	}
> > +	perf_debuginfod_setup(&debuginfod);
> >  
> >  	/* -l is exclusive. It can not be used with other options. */
> >  	if (list_files && opts_flag) {
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index 0338b813585a..2da2a6acbb8c 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -111,6 +111,7 @@ struct record {
> >  	unsigned long long	samples;
> >  	struct mmap_cpu_mask	affinity_mask;
> >  	unsigned long		output_max_size;	/* = 0: unlimited */
> > +	struct perf_debuginfod	debuginfod;
> >  };
> >  
> >  static volatile int done;
> > @@ -2177,6 +2178,12 @@ static int perf_record_config(const char *var, const char *value, void *cb)
> >  			rec->opts.nr_cblocks = nr_cblocks_default;
> >  	}
> >  #endif
> > +	if (!strcmp(var, "record.debuginfod")) {
> > +		rec->debuginfod.urls = strdup(value);
> > +		if (!rec->debuginfod.urls)
> > +			return -ENOMEM;
> > +		rec->debuginfod.set = true;
> > +	}
> >  
> >  	return 0;
> >  }
> > @@ -2663,6 +2670,10 @@ static struct option __record_options[] = {
> >  		      parse_control_option),
> >  	OPT_CALLBACK(0, "synth", &record.opts, "no|all|task|mmap|cgroup",
> >  		     "Fine-tune event synthesis: default=all", parse_record_synth_option),
> > +	OPT_STRING_OPTARG_SET(0, "debuginfod", &record.debuginfod.urls,
> > +			  &record.debuginfod.set, "debuginfod urls",
> > +			  "Enable debuginfod data retrieval from DEBUGINFOD_URLS or specified urls",
> > +			  "system"),
> >  	OPT_END()
> >  };
> >  
> > @@ -2716,6 +2727,8 @@ int cmd_record(int argc, const char **argv)
> >  	if (err)
> >  		return err;
> >  
> > +	perf_debuginfod_setup(&record.debuginfod);
> > +
> >  	/* Make system wide (-a) the default target. */
> >  	if (!argc && target__none(&rec->opts.target))
> >  		rec->opts.target.system_wide = true;
> > diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
> > index df3c4671be72..fb4f6616b5fa 100644
> > --- a/tools/perf/util/util.c
> > +++ b/tools/perf/util/util.c
> > @@ -416,3 +416,18 @@ char *perf_exe(char *buf, int len)
> >  	}
> >  	return strcpy(buf, "perf");
> >  }
> > +
> > +void perf_debuginfod_setup(struct perf_debuginfod *di)
> > +{
> > +	/*
> > +	 * By default '!di->set' we clear DEBUGINFOD_URLS, so debuginfod
> > +	 * processing is not triggered, otherwise we set it to 'di->urls'
> > +	 * value. If 'di->urls' is "system" we keep DEBUGINFOD_URLS value.
> > +	 */
> > +	if (!di->set)
> > +		setenv("DEBUGINFOD_URLS", "", 1);
> > +	else if (di->urls && strcmp(di->urls, "system"))
> > +		setenv("DEBUGINFOD_URLS", di->urls, 1);
> > +
> > +	pr_debug("DEBUGINFOD_URLS=%s\n", getenv("DEBUGINFOD_URLS"));
> > +}
> > diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
> > index 9f0d36ba77f2..4359f5af2de7 100644
> > --- a/tools/perf/util/util.h
> > +++ b/tools/perf/util/util.h
> > @@ -68,4 +68,10 @@ void test_attr__init(void);
> >  struct perf_event_attr;
> >  void test_attr__open(struct perf_event_attr *attr, pid_t pid, int cpu,
> >  		     int fd, int group_fd, unsigned long flags);
> > +
> > +struct perf_debuginfod {
> > +	const char	*urls;
> > +	bool		 set;
> > +};
> > +void perf_debuginfod_setup(struct perf_debuginfod *di);
> >  #endif /* GIT_COMPAT_UTIL_H */
> > -- 
> > 2.33.1
> > 

-- 

- Arnaldo
