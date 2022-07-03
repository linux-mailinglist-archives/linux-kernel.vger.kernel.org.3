Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8D8564791
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 15:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbiGCNqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 09:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiGCNqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 09:46:40 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEED35F8E;
        Sun,  3 Jul 2022 06:46:38 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id u12so12272912eja.8;
        Sun, 03 Jul 2022 06:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lkeSK1wur92Huo7LAm5a1dgfHH2mLSfIatsm7Qde9ks=;
        b=Ph9vKD19wOE71I2ciuH039CcM6Pklf+g/2rdNbhQhjBxDceRf2vji/Zm10//9ze1qC
         +EScACebsKwpotQozQxj6x0blHMYNaPw4a4egaUsz9OXlbafDeig9/tpPKJCHvch8Iwc
         eMc2F5vLwerJKCF6vONp1TSahs2TyyR5mbp8p8NzLohPCuS3c9logeBFyTfZ+BFRJXYG
         F1tDT0X9ETQE0M66/rMZghwYkVwPpBCP6K20uAIET6RsLeBhlC8hWznowMpfzB8kzlXF
         XAu5cClji9AGIERpJDkSX2U/c5IWFvCnXWhgWsmZDxM0ALv3LoUOILKGKSSHf8kRVZVn
         RV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lkeSK1wur92Huo7LAm5a1dgfHH2mLSfIatsm7Qde9ks=;
        b=0wrZtbUAURYKSClDcLy2zjSha0W6NkdgbtK0xxUx3QddyT2vNuozkjyAfh0BsN1wTY
         fSOsDu0Itnf9xSnmSBr5LuY0IuSqQ60IehX4MKbERhflo4O9h/u6VaEfjygtnxQtmszN
         qFo004a8gHPWNUAaHoTn7swOmXnUcYPC0NiGku7WqKuDUa7DkrkTlBGXpb6fz5zRqolb
         1HPRR6UOxpRGxNxPwRuEBQIvtUED6zmU8NuxhSfYoPkM1qjojH6yNA++JFWnSARh9jJI
         8rRgdg2sgW6LA4sR+/4IjLbHfjHkTFI5C3oOSGvQP+//nKb8AJHyj06UkSb41KdHFoaQ
         aW5A==
X-Gm-Message-State: AJIora8qu2OIXbRCT3pxFE7L10LjwNa+TyhD4v8igpu9cpIY59YZMRV1
        Z4ETAqSs5LnOWJppWJSP8n8=
X-Google-Smtp-Source: AGRyM1tw0URDlaWeffZcU8c0ZLda9Jl5iTlyJ8tzd/1dwtrUqVrKuRQn8K5/x9M+vbxtMZkD+9CxEQ==
X-Received: by 2002:a17:907:2ce4:b0:722:df67:12cc with SMTP id hz4-20020a1709072ce400b00722df6712ccmr24176058ejc.715.1656855997319;
        Sun, 03 Jul 2022 06:46:37 -0700 (PDT)
Received: from krava ([151.70.14.154])
        by smtp.gmail.com with ESMTPSA id jp1-20020a170906f74100b006fe0abb00f0sm12981538ejb.209.2022.07.03.06.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 06:46:36 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Sun, 3 Jul 2022 15:46:33 +0200
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf parse: Allow names to start with digits
Message-ID: <YsGduWiTvkM2/tHv@krava>
References: <20220612061508.1449636-1-asmadeus@codewreck.org>
 <YsAUqwzeO8U6cIJA@codewreck.org>
 <YsA4+A7TSjzUKDWK@kernel.org>
 <YsBosxs9TVB0aLrf@krava>
 <YsDZ8mTnCQzpejOM@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsDZ8mTnCQzpejOM@codewreck.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 03, 2022 at 08:51:14AM +0900, Dominique Martinet wrote:
> Jiri Olsa wrote on Sat, Jul 02, 2022 at 05:48:03PM +0200:
> > > > > -name		[a-zA-Z_*?\[\]][a-zA-Z0-9_*?.\[\]!]*
> > > > > +name		[a-zA-Z0-9_*?\[\]][a-zA-Z0-9_*?.\[\]!]*
> > 
> > I thought it'd clash with events like cpu/event=3/,
> > but lexer check numbers first, so we're fine there
> > 
> > it smells like it could break some events, but I couldn't
> > find any case of that
> > 
> > could you please at least add tests to tests/parse-events.c
> > for such case?
> 
> hmm, I'd love to but on my system I have no events that start with a
> number unless I manually modprobe 9pnet (or 802154 stuff), so tests
> would start failing for most people and I don't think we want that...
> 
> I have confirmed the following 'perf test "event parsing"' works iff
> patch is applied and 9pnet loaded:
> ---- 
> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
> index 459afdb256a1..3d069fe9eb79 100644
> --- a/tools/perf/tests/parse-events.c
> +++ b/tools/perf/tests/parse-events.c
> @@ -1941,6 +1941,11 @@ static const struct evlist_test test__events[] = {
>  		.check = test__exclusive_group,
>  		/* 7 */
>  	},
> +	{
> +		.name  = "9p:9p_client_req",
> +		.check = test__checkevent_tracepoint,
> +		/* 8 */
> +	},
>  };
>  
>  static const struct evlist_test test__events_pmu[] = {
> ----
> 
> not sure if there'd be any other way of testing, there's nothing else in
> 'perf list' that starts with a number.

maybe we could do it same way we did for fake pmu events like below

jirka


---
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 3d069fe9eb79..0dc1fbc80447 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -2058,7 +2058,7 @@ static int test_event(const struct evlist_test *e)
 		return TEST_FAIL;
 	}
 	parse_events_error__init(&err);
-	ret = parse_events(evlist, e->name, &err);
+	ret = __parse_events(evlist, e->name, &err, NULL, true);
 	if (ret) {
 		pr_debug("failed to parse event '%s', err %d, str '%s'\n",
 			 e->name, ret, err.str);
@@ -2087,7 +2087,7 @@ static int test_event_fake_pmu(const char *str)
 
 	parse_events_error__init(&err);
 	perf_pmu__test_parse_init();
-	ret = __parse_events(evlist, str, &err, &perf_pmu__fake);
+	ret = __parse_events(evlist, str, &err, &perf_pmu__fake, false);
 	if (ret) {
 		pr_debug("failed to parse event '%s', err %d, str '%s'\n",
 			 str, ret, err.str);
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index f13368569d8b..27541d4d6025 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -812,7 +812,7 @@ static int check_parse_id(const char *id, struct parse_events_error *error,
 	for (cur = strchr(dup, '@') ; cur; cur = strchr(++cur, '@'))
 		*cur = '/';
 
-	ret = __parse_events(evlist, dup, error, fake_pmu);
+	ret = __parse_events(evlist, dup, error, fake_pmu, false);
 	free(dup);
 
 	evlist__delete(evlist);
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ce499c5da8d7..73771e22cb39 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -476,7 +476,7 @@ struct evsel *evsel__clone(struct evsel *orig)
 /*
  * Returns pointer with encoded error via <linux/err.h> interface.
  */
-struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx)
+struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx, bool format)
 {
 	struct evsel *evsel = zalloc(perf_evsel__object.size);
 	int err = -ENOMEM;
@@ -493,14 +493,18 @@ struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx)
 		if (asprintf(&evsel->name, "%s:%s", sys, name) < 0)
 			goto out_free;
 
-		evsel->tp_format = trace_event__tp_format(sys, name);
-		if (IS_ERR(evsel->tp_format)) {
-			err = PTR_ERR(evsel->tp_format);
-			goto out_free;
+		if (format) {
+			evsel->tp_format = trace_event__tp_format(sys, name);
+			if (IS_ERR(evsel->tp_format)) {
+				err = PTR_ERR(evsel->tp_format);
+				goto out_free;
+			}
+			attr.config = evsel->tp_format->id;
+		} else {
+			attr.config = (__u64) -1;
 		}
 
 		event_attr_init(&attr);
-		attr.config = evsel->tp_format->id;
 		attr.sample_period = 1;
 		evsel__init(evsel, &attr, idx);
 	}
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 73ea48e94079..255919658b57 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -224,7 +224,7 @@ static inline struct evsel *evsel__new(struct perf_event_attr *attr)
 }
 
 struct evsel *evsel__clone(struct evsel *orig);
-struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx);
+struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx, bool format);
 
 int copy_config_terms(struct list_head *dst, struct list_head *src);
 void free_config_terms(struct list_head *config_terms);
@@ -234,7 +234,7 @@ void free_config_terms(struct list_head *config_terms);
  */
 static inline struct evsel *evsel__newtp(const char *sys, const char *name)
 {
-	return evsel__newtp_idx(sys, name, 0);
+	return evsel__newtp_idx(sys, name, 0, true);
 }
 
 struct evsel *evsel__new_cycles(bool precise, __u32 type, __u64 config);
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 8f7baeabc5cf..8b066a0058f3 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1417,7 +1417,7 @@ static int parse_ids(bool metric_no_merge, struct perf_pmu *fake_pmu,
 	}
 	pr_debug("Parsing metric events '%s'\n", events.buf);
 	parse_events_error__init(&parse_error);
-	ret = __parse_events(parsed_evlist, events.buf, &parse_error, fake_pmu);
+	ret = __parse_events(parsed_evlist, events.buf, &parse_error, fake_pmu, false);
 	if (ret) {
 		parse_events_error__print(&parse_error, events.buf);
 		goto err_out;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 7ed235740431..914d87fbad5b 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -576,12 +576,14 @@ static void tracepoint_error(struct parse_events_error *e, int err,
 	parse_events_error__handle(e, 0, strdup(str), strdup(help));
 }
 
-static int add_tracepoint(struct list_head *list, int *idx,
+static int add_tracepoint(struct parse_events_state *parse_state,
+			  struct list_head *list,
 			  const char *sys_name, const char *evt_name,
 			  struct parse_events_error *err,
 			  struct list_head *head_config)
 {
-	struct evsel *evsel = evsel__newtp_idx(sys_name, evt_name, (*idx)++);
+	struct evsel *evsel = evsel__newtp_idx(sys_name, evt_name, parse_state->idx++,
+					       !parse_state->fake_tp);
 
 	if (IS_ERR(evsel)) {
 		tracepoint_error(err, PTR_ERR(evsel), sys_name, evt_name);
@@ -600,7 +602,8 @@ static int add_tracepoint(struct list_head *list, int *idx,
 	return 0;
 }
 
-static int add_tracepoint_multi_event(struct list_head *list, int *idx,
+static int add_tracepoint_multi_event(struct parse_events_state *parse_state,
+				      struct list_head *list,
 				      const char *sys_name, const char *evt_name,
 				      struct parse_events_error *err,
 				      struct list_head *head_config)
@@ -634,7 +637,7 @@ static int add_tracepoint_multi_event(struct list_head *list, int *idx,
 
 		found++;
 
-		ret = add_tracepoint(list, idx, sys_name, evt_ent->d_name,
+		ret = add_tracepoint(parse_state, list, sys_name, evt_ent->d_name,
 				     err, head_config);
 	}
 
@@ -648,19 +651,21 @@ static int add_tracepoint_multi_event(struct list_head *list, int *idx,
 	return ret;
 }
 
-static int add_tracepoint_event(struct list_head *list, int *idx,
+static int add_tracepoint_event(struct parse_events_state *parse_state,
+				struct list_head *list,
 				const char *sys_name, const char *evt_name,
 				struct parse_events_error *err,
 				struct list_head *head_config)
 {
 	return strpbrk(evt_name, "*?") ?
-	       add_tracepoint_multi_event(list, idx, sys_name, evt_name,
+	       add_tracepoint_multi_event(parse_state, list, sys_name, evt_name,
 					  err, head_config) :
-	       add_tracepoint(list, idx, sys_name, evt_name,
+	       add_tracepoint(parse_state, list, sys_name, evt_name,
 			      err, head_config);
 }
 
-static int add_tracepoint_multi_sys(struct list_head *list, int *idx,
+static int add_tracepoint_multi_sys(struct parse_events_state *parse_state,
+				    struct list_head *list,
 				    const char *sys_name, const char *evt_name,
 				    struct parse_events_error *err,
 				    struct list_head *head_config)
@@ -686,7 +691,7 @@ static int add_tracepoint_multi_sys(struct list_head *list, int *idx,
 		if (!strglobmatch(events_ent->d_name, sys_name))
 			continue;
 
-		ret = add_tracepoint_event(list, idx, events_ent->d_name,
+		ret = add_tracepoint_event(parse_state, list, events_ent->d_name,
 					   evt_name, err, head_config);
 	}
 
@@ -723,7 +728,7 @@ static int add_bpf_event(const char *group, const char *event, int fd, struct bp
 	pr_debug("add bpf event %s:%s and attach bpf program %d\n",
 		 group, event, fd);
 
-	err = parse_events_add_tracepoint(&new_evsels, &parse_state->idx, group,
+	err = parse_events_add_tracepoint(parse_state, &new_evsels, group,
 					  event, parse_state->error,
 					  param->head_config);
 	if (err) {
@@ -1420,7 +1425,8 @@ static int get_config_chgs(struct perf_pmu *pmu, struct list_head *head_config,
 	return 0;
 }
 
-int parse_events_add_tracepoint(struct list_head *list, int *idx,
+int parse_events_add_tracepoint(struct parse_events_state *parse_state,
+				struct list_head *list,
 				const char *sys, const char *event,
 				struct parse_events_error *err,
 				struct list_head *head_config)
@@ -1434,10 +1440,10 @@ int parse_events_add_tracepoint(struct list_head *list, int *idx,
 	}
 
 	if (strpbrk(sys, "*?"))
-		return add_tracepoint_multi_sys(list, idx, sys, event,
+		return add_tracepoint_multi_sys(parse_state, list, sys, event,
 						err, head_config);
 	else
-		return add_tracepoint_event(list, idx, sys, event,
+		return add_tracepoint_event(parse_state, list, sys, event,
 					    err, head_config);
 }
 
@@ -2332,7 +2338,8 @@ static int parse_events__with_hybrid_pmu(struct parse_events_state *parse_state,
 }
 
 int __parse_events(struct evlist *evlist, const char *str,
-		   struct parse_events_error *err, struct perf_pmu *fake_pmu)
+		   struct parse_events_error *err,
+		   struct perf_pmu *fake_pmu, bool fake_tp)
 {
 	struct parse_events_state parse_state = {
 		.list	  = LIST_HEAD_INIT(parse_state.list),
@@ -2341,6 +2348,7 @@ int __parse_events(struct evlist *evlist, const char *str,
 		.evlist	  = evlist,
 		.stoken	  = PE_START_EVENTS,
 		.fake_pmu = fake_pmu,
+		.fake_tp  = fake_tp,
 	};
 	int ret;
 
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index a38b8b160e80..bd2fb9a354b4 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -34,12 +34,12 @@ const char *event_type(int type);
 int parse_events_option(const struct option *opt, const char *str, int unset);
 int parse_events_option_new_evlist(const struct option *opt, const char *str, int unset);
 int __parse_events(struct evlist *evlist, const char *str, struct parse_events_error *error,
-		   struct perf_pmu *fake_pmu);
+		   struct perf_pmu *fake_pmu, bool fake_tp);
 
 static inline int parse_events(struct evlist *evlist, const char *str,
 			       struct parse_events_error *err)
 {
-	return __parse_events(evlist, str, err, NULL);
+	return __parse_events(evlist, str, err, NULL, false);
 }
 
 int parse_events_terms(struct list_head *terms, const char *str);
@@ -140,6 +140,7 @@ struct parse_events_state {
 	struct list_head	  *terms;
 	int			   stoken;
 	struct perf_pmu		  *fake_pmu;
+	bool			   fake_tp;
 	char			  *hybrid_pmu_name;
 };
 
@@ -163,7 +164,8 @@ void parse_events__clear_array(struct parse_events_array *a);
 int parse_events__modifier_event(struct list_head *list, char *str, bool add);
 int parse_events__modifier_group(struct list_head *list, char *event_mod);
 int parse_events_name(struct list_head *list, const char *name);
-int parse_events_add_tracepoint(struct list_head *list, int *idx,
+int parse_events_add_tracepoint(struct parse_events_state *parse_state,
+				struct list_head *list,
 				const char *sys, const char *event,
 				struct parse_events_error *error,
 				struct list_head *head_config);
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index be8c51770051..83ccbf433482 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -625,7 +625,7 @@ tracepoint_name opt_event_config
 	if (error)
 		error->idx = @1.first_column;
 
-	err = parse_events_add_tracepoint(list, &parse_state->idx, $1.sys, $1.event,
+	err = parse_events_add_tracepoint(parse_state, list, $1.sys, $1.event,
 					error, $2);
 
 	parse_events_terms__delete($2);
