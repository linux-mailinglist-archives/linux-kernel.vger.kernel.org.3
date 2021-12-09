Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6901746F48D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 21:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbhLIUIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 15:08:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:31498 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231337AbhLIUID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 15:08:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639080269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=XKNKPNQHNFK85xGb7B2xcOayyMLHBFP9uxFYZmJkZLs=;
        b=KrARt9Hxn30vqJgtrFv9DsYHA8QWVQoNCNXUyg4IluKgZ25JGWUOlqyxmj9rebGS8Lj/Jj
        6cJ6n6CyqDO047rMPfhEZVaIFtTBiLXutXlkia9JhUFKRktI8uO9fFHuM/t34lcYtJtFBw
        KqVEHvuuh3pBu9miQGiZk4WkrqEzmfM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-esSvaN-MP8uOUNs5WSzu4Q-1; Thu, 09 Dec 2021 15:04:28 -0500
X-MC-Unique: esSvaN-MP8uOUNs5WSzu4Q-1
Received: by mail-wm1-f69.google.com with SMTP id g81-20020a1c9d54000000b003330e488323so2326673wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 12:04:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XKNKPNQHNFK85xGb7B2xcOayyMLHBFP9uxFYZmJkZLs=;
        b=elFpI64N48g2t4ttPkAlrIqd4z8nPtaKKpX40+9kOwnB1zka4KVhgHIphqZRRy2iK7
         8ugAH+yb4XpmnRyTCZrygJeB29e47QP9/gcSp3gJto9yVlf+C7pQUK5ENRy4/ramqeQu
         F47+iaLh+yyrhqvLt+esgIXKYKH9Yy/JrQt7MQ2RBgUuK/gZrELrCTmvL5sW2crj38mf
         sau8Fp04YFdSq2U9mAV8GC+HQfkLY3HEXnItvBSfE9dQgrXlMeNy/7Dhpuf9DNGG7Kd2
         J0vrc/NDFOTSPlRhr5mEJGj1+tvMh0raKglaymp1C1XPpSpp2RdVqYqyyXclJbhhOvPv
         giow==
X-Gm-Message-State: AOAM530CPWRQVkd4HNRf6xwVkt+hcwEstenjf7PbtmmhNTxBA9u/FxMp
        GzgFfOsLKa5wHiy2cpYfr2rsNa4UzslJ9tWVLQp4C/lwo0akCHduVqV/lvZSPwZtS2Quec/MJNW
        uSQ3l/awMgMMU9s0sx3hOHUa+
X-Received: by 2002:a5d:64ea:: with SMTP id g10mr9047074wri.242.1639080267308;
        Thu, 09 Dec 2021 12:04:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzfnOLJrw+N34/dyFdE5rAHXuPY36Ibu+t1aauhb9/YF96gRZ7Bmlhieg4Ejdw6WPbWWLPtzw==
X-Received: by 2002:a5d:64ea:: with SMTP id g10mr9047039wri.242.1639080267000;
        Thu, 09 Dec 2021 12:04:27 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id i15sm10883553wmq.18.2021.12.09.12.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 12:04:26 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
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
Subject: [RFC] perf record: Disable debuginfod by default
Date:   Thu,  9 Dec 2021 21:04:25 +0100
Message-Id: <20211209200425.303561-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
after migrating to fedora 35 I found perf record hanging on exit
and it's because fedora 35 sets DEBUGINFOD_URLS that triggers
debuginfod query which might take long time to process.

I discussed this briefly with Frank and I'm sending the change
to disable debuginfod by default in perf record.

Frank had other idea we could discuss here to fork or just spawn
"/usr/bin/debuginfod-find ...." into background after perf record.

Perhaps there are other ways as well, hence this is RFC ;-)

thanks,
jirka


---
Fedora 35 sets by default DEBUGINFOD_URLS, which might lead
to unexpected stalls in perf record exit path, when we try
to cache profiled binaries.

  # DEBUGINFOD_PROGRESS=1 ./perf record -a
  ^C[ perf record: Woken up 1 times to write data ]
  Downloading from https://debuginfod.fedoraproject.org/ 447069
  Downloading from https://debuginfod.fedoraproject.org/ 1502175
  Downloading \^Z

Disabling DEBUGINFOD_URLS by default in perf record and adding
debuginfod option and .perfconfig variable support to enable id.

  Default without debuginfo processing:
  # perf record -a

  Using system debuginfod setup:
  # perf record -a --debuginfod

  Using custom debuginfd url:
  # perf record -a --debuginfod='https://evenbetterdebuginfodserver.krava'

Adding single perf_debuginfod_setup function and using
it also in perf buildid-cache command.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../perf/Documentation/perf-buildid-cache.txt |  5 +++-
 tools/perf/Documentation/perf-config.txt      |  9 +++++++
 tools/perf/Documentation/perf-record.txt      |  9 +++++++
 tools/perf/builtin-buildid-cache.c            | 25 +++++++++++--------
 tools/perf/builtin-record.c                   | 13 ++++++++++
 tools/perf/util/util.c                        | 15 +++++++++++
 tools/perf/util/util.h                        |  6 +++++
 7 files changed, 70 insertions(+), 12 deletions(-)

diff --git a/tools/perf/Documentation/perf-buildid-cache.txt b/tools/perf/Documentation/perf-buildid-cache.txt
index cd8ce6e8ec12..7e44b419d301 100644
--- a/tools/perf/Documentation/perf-buildid-cache.txt
+++ b/tools/perf/Documentation/perf-buildid-cache.txt
@@ -74,12 +74,15 @@ OPTIONS
 	used when creating a uprobe for a process that resides in a
 	different mount namespace from the perf(1) utility.
 
---debuginfod=URLs::
+--debuginfod[=URLs]::
 	Specify debuginfod URL to be used when retrieving perf.data binaries,
 	it follows the same syntax as the DEBUGINFOD_URLS variable, like:
 
 	  buildid-cache.debuginfod=http://192.168.122.174:8002
 
+	If the URLs is not specified, the value of DEBUGINFOD_URLS
+	system environment variable is used.
+
 SEE ALSO
 --------
 linkperf:perf-record[1], linkperf:perf-report[1], linkperf:perf-buildid-list[1]
diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 3bb75c1f25e8..0420e71698ee 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -587,6 +587,15 @@ record.*::
 		Use 'n' control blocks in asynchronous (Posix AIO) trace writing
 		mode ('n' default: 1, max: 4).
 
+	record.debuginfod::
+		Specify debuginfod URL to be used when cacheing perf.data binaries,
+		it follows the same syntax as the DEBUGINFOD_URLS variable, like:
+
+		  http://192.168.122.174:8002
+
+		If the URLs is 'system', the value of DEBUGINFOD_URLS system environment
+		variable is used.
+
 diff.*::
 	diff.order::
 		This option sets the number of columns to sort the result.
diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 55df7b073a55..9ccc75935bc5 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -715,6 +715,15 @@ measurements:
 
 include::intel-hybrid.txt[]
 
+--debuginfod[=URLs]::
+	Specify debuginfod URL to be used when cacheing perf.data binaries,
+	it follows the same syntax as the DEBUGINFOD_URLS variable, like:
+
+	  http://192.168.122.174:8002
+
+	If the URLs is not specified, the value of DEBUGINFOD_URLS
+	system environment variable is used.
+
 SEE ALSO
 --------
 linkperf:perf-stat[1], linkperf:perf-list[1], linkperf:perf-intel-pt[1]
diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
index 0db3cfc04c47..cd381693658b 100644
--- a/tools/perf/builtin-buildid-cache.c
+++ b/tools/perf/builtin-buildid-cache.c
@@ -351,10 +351,14 @@ static int build_id_cache__show_all(void)
 
 static int perf_buildid_cache_config(const char *var, const char *value, void *cb)
 {
-	const char **debuginfod = cb;
+	struct perf_debuginfod *di = cb;
 
-	if (!strcmp(var, "buildid-cache.debuginfod"))
-		*debuginfod = strdup(value);
+	if (!strcmp(var, "buildid-cache.debuginfod")) {
+		di->urls = strdup(value);
+		if (!di->urls)
+			return -ENOMEM;
+		di->set = true;
+	}
 
 	return 0;
 }
@@ -373,8 +377,8 @@ int cmd_buildid_cache(int argc, const char **argv)
 		   *purge_name_list_str = NULL,
 		   *missing_filename = NULL,
 		   *update_name_list_str = NULL,
-		   *kcore_filename = NULL,
-		   *debuginfod = NULL;
+		   *kcore_filename = NULL;
+	struct perf_debuginfod debuginfod = { };
 	char sbuf[STRERR_BUFSIZE];
 
 	struct perf_data data = {
@@ -399,8 +403,10 @@ int cmd_buildid_cache(int argc, const char **argv)
 	OPT_BOOLEAN('f', "force", &force, "don't complain, do it"),
 	OPT_STRING('u', "update", &update_name_list_str, "file list",
 		    "file(s) to update"),
-	OPT_STRING(0, "debuginfod", &debuginfod, "debuginfod url",
-		    "set debuginfod url"),
+	OPT_STRING_OPTARG_SET(0, "debuginfod", &debuginfod.urls,
+			&debuginfod.set, "debuginfod urls",
+			"Enable debuginfod data retrieval from DEBUGINFOD_URLS or specified urls",
+			"system"),
 	OPT_INCR('v', "verbose", &verbose, "be more verbose"),
 	OPT_INTEGER(0, "target-ns", &ns_id, "target pid for namespace context"),
 	OPT_END()
@@ -425,10 +431,7 @@ int cmd_buildid_cache(int argc, const char **argv)
 	if (argc || !(list_files || opts_flag))
 		usage_with_options(buildid_cache_usage, buildid_cache_options);
 
-	if (debuginfod) {
-		pr_debug("DEBUGINFOD_URLS=%s\n", debuginfod);
-		setenv("DEBUGINFOD_URLS", debuginfod, 1);
-	}
+	perf_debuginfod_setup(&debuginfod);
 
 	/* -l is exclusive. It can not be used with other options. */
 	if (list_files && opts_flag) {
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 0338b813585a..2da2a6acbb8c 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -111,6 +111,7 @@ struct record {
 	unsigned long long	samples;
 	struct mmap_cpu_mask	affinity_mask;
 	unsigned long		output_max_size;	/* = 0: unlimited */
+	struct perf_debuginfod	debuginfod;
 };
 
 static volatile int done;
@@ -2177,6 +2178,12 @@ static int perf_record_config(const char *var, const char *value, void *cb)
 			rec->opts.nr_cblocks = nr_cblocks_default;
 	}
 #endif
+	if (!strcmp(var, "record.debuginfod")) {
+		rec->debuginfod.urls = strdup(value);
+		if (!rec->debuginfod.urls)
+			return -ENOMEM;
+		rec->debuginfod.set = true;
+	}
 
 	return 0;
 }
@@ -2663,6 +2670,10 @@ static struct option __record_options[] = {
 		      parse_control_option),
 	OPT_CALLBACK(0, "synth", &record.opts, "no|all|task|mmap|cgroup",
 		     "Fine-tune event synthesis: default=all", parse_record_synth_option),
+	OPT_STRING_OPTARG_SET(0, "debuginfod", &record.debuginfod.urls,
+			  &record.debuginfod.set, "debuginfod urls",
+			  "Enable debuginfod data retrieval from DEBUGINFOD_URLS or specified urls",
+			  "system"),
 	OPT_END()
 };
 
@@ -2716,6 +2727,8 @@ int cmd_record(int argc, const char **argv)
 	if (err)
 		return err;
 
+	perf_debuginfod_setup(&record.debuginfod);
+
 	/* Make system wide (-a) the default target. */
 	if (!argc && target__none(&rec->opts.target))
 		rec->opts.target.system_wide = true;
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index df3c4671be72..fb4f6616b5fa 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -416,3 +416,18 @@ char *perf_exe(char *buf, int len)
 	}
 	return strcpy(buf, "perf");
 }
+
+void perf_debuginfod_setup(struct perf_debuginfod *di)
+{
+	/*
+	 * By default '!di->set' we clear DEBUGINFOD_URLS, so debuginfod
+	 * processing is not triggered, otherwise we set it to 'di->urls'
+	 * value. If 'di->urls' is "system" we keep DEBUGINFOD_URLS value.
+	 */
+	if (!di->set)
+		setenv("DEBUGINFOD_URLS", "", 1);
+	else if (di->urls && strcmp(di->urls, "system"))
+		setenv("DEBUGINFOD_URLS", di->urls, 1);
+
+	pr_debug("DEBUGINFOD_URLS=%s\n", getenv("DEBUGINFOD_URLS"));
+}
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 9f0d36ba77f2..4359f5af2de7 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -68,4 +68,10 @@ void test_attr__init(void);
 struct perf_event_attr;
 void test_attr__open(struct perf_event_attr *attr, pid_t pid, int cpu,
 		     int fd, int group_fd, unsigned long flags);
+
+struct perf_debuginfod {
+	const char	*urls;
+	bool		 set;
+};
+void perf_debuginfod_setup(struct perf_debuginfod *di);
 #endif /* GIT_COMPAT_UTIL_H */
-- 
2.33.1

