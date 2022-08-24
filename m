Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47AD559FEA2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 17:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239913AbiHXPlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 11:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239822AbiHXPlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 11:41:17 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280E74B0C1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 08:41:07 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id z16so2459514wrh.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 08:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=qkCnAgKksn4yy7c/f+u9SZxxjpxk06D/ZgjlZLfZ9D8=;
        b=HXvkUd7fstbzpAm/5nB7pSutCYT241lXTDRVqK8dL6QHzrzJEClUX5GC5o2+4wpKCQ
         DPTvVGuOKQ1AAXhd90/BNbp2vg2Ehrfm/fhE+AMjSQn3U6sy5FJTPsjyQt0LZUZIuCkR
         0oU3566qa5+jQ+YnDEGp+Qbv2Gazp2QVXiaTZxCJ6Zpd5fd+KvEaS7ftN8FgTjwg78XK
         AQT3AGfTID931mSOdyhIQkb8iLisGN4OoV7pzPWRj9bHJIqZeSq33C41apMFxVbj9Di6
         kikfB0p4IL+e8qdlRFDTwJgs1g+Kkq3/czZZiGHI4XW7Qr0Nrrwe2zFog3YL+B7L/C2N
         dOiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=qkCnAgKksn4yy7c/f+u9SZxxjpxk06D/ZgjlZLfZ9D8=;
        b=jhrno7NUqWz5IiaQlR1Tpnsl/Hy4RCExzjTvvgL8eqDwngXrqEAvz53CtZXsDDcwPo
         oUH5KNcgSkGvyemqb0RODCMeTeaMkigUq5akwhPlplxtq0HbANSdQsWKWN3GaoWrtPtd
         Ks1/PCteyiRCFFc15ks3MbVkIsboDIisgIcPuZnsrA78A4zrlqwYBoXjZ2DIuro02I97
         50YAvN/64z1w7q4/cUt02Gti4xs4IDMbWWXzDH9ZYgj7tsG6E1ZAj577x1IR1WY4tl6x
         FjyegiJ1/Aav99tAw77OnZq8ZLicF7byQDVd8hjkYF6iURHMjXZRXASdMVYZl/hpLyft
         az+g==
X-Gm-Message-State: ACgBeo1tX6Gyvh8hWhPWxnthcZ3b/+883F2I4pT+WV0H7Wcds3wx8MMp
        gBmjNyhQHL+LiVqzKpvtws1b+5D+qreakqWH/aR6r4dn7DlULA==
X-Google-Smtp-Source: AA6agR72Q7Fv/g2o5VkARbLhzxu47V9z9QL51rC0K6pFJMYrF9QaFNt7Z65OIdJLByyiDTuviBxTe2BKg0pXri0NFho=
X-Received: by 2002:adf:e28d:0:b0:21e:4c3b:b446 with SMTP id
 v13-20020adfe28d000000b0021e4c3bb446mr16035051wri.300.1661355665577; Wed, 24
 Aug 2022 08:41:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220824072814.16422-1-adrian.hunter@intel.com> <20220824072814.16422-2-adrian.hunter@intel.com>
In-Reply-To: <20220824072814.16422-2-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 24 Aug 2022 08:40:53 -0700
Message-ID: <CAP-5=fUsWcxivcG0M6bju2YaiNmO1d9SPFDviJWm7kdqSxx2Qg@mail.gmail.com>
Subject: Re: [PATCH 1/5] perf record: Fix way of handling non-perf-event pollfds
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 12:28 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> perf record __cmd_record() does not poll evlist pollfds. Instead it polls
> thread_data[0].pollfd. That happens whether or not threads are being used.
>
> perf record duplicates evlist mmap pollfds as needed for separate threads.
> The non-perf-event represented by evlist->ctl_fd has to handled separately,
> which is done explicitly, duplicating it into the thread_data[0] pollfds.
> That approach neglects any other non-perf-event file descriptors. Currently
> there is also done_fd which needs the same handling.
>
> Add a new generalized approach.
>
> Add fdarray_flag__non_perf_event to identify the file descriptors that
> need the special handling. For those cases, also keep a mapping of the
> evlist pollfd index and thread pollfd index, so that the evlist revents
> can be updated.
>
> Although this patch adds the new handling, it does not take it into use.
> There is no functional change, but it is the precursor to a fix, so is
> marked as a fix.
>
> Fixes: 415ccb58f68a ("perf record: Introduce thread specific data array")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/lib/api/fd/array.h    |  5 ++-
>  tools/perf/builtin-record.c | 80 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 83 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/api/fd/array.h b/tools/lib/api/fd/array.h
> index 60ad197c8ee9..5c01f7b05dfb 100644
> --- a/tools/lib/api/fd/array.h
> +++ b/tools/lib/api/fd/array.h
> @@ -31,8 +31,9 @@ struct fdarray {
>  };
>
>  enum fdarray_flags {
> -       fdarray_flag__default       = 0x00000000,
> -       fdarray_flag__nonfilterable = 0x00000001
> +       fdarray_flag__default           = 0x00000000,
> +       fdarray_flag__nonfilterable     = 0x00000001,
> +       fdarray_flag__non_perf_event    = 0x00000002,
>  };
>
>  void fdarray__init(struct fdarray *fda, int nr_autogrow);
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 4713f0f3a6cf..e0be48c47f65 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -143,6 +143,11 @@ static const char *thread_spec_tags[THREAD_SPEC__MAX] = {
>         "undefined", "cpu", "core", "package", "numa", "user"
>  };
>
> +struct pollfd_index_map {
> +       int evlist_pollfd_index;
> +       int thread_pollfd_index;
> +};
> +
>  struct record {
>         struct perf_tool        tool;
>         struct record_opts      opts;
> @@ -171,6 +176,9 @@ struct record {
>         int                     nr_threads;
>         struct thread_mask      *thread_masks;
>         struct record_thread    *thread_data;
> +       struct pollfd_index_map *index_map;
> +       size_t                  index_map_sz;
> +       size_t                  index_map_cnt;
>  };
>
>  static volatile int done;
> @@ -1074,6 +1082,70 @@ static void record__free_thread_data(struct record *rec)
>         zfree(&rec->thread_data);
>  }
>
> +static int record__map_thread_evlist_pollfd_indexes(struct record *rec,
> +                                                   int evlist_pollfd_index,
> +                                                   int thread_pollfd_index)
> +{
> +       size_t x = rec->index_map_cnt;
> +
> +       if (realloc_array_as_needed(rec->index_map, rec->index_map_sz, x, NULL))
> +               return -ENOMEM;
> +       rec->index_map[x].evlist_pollfd_index = evlist_pollfd_index;
> +       rec->index_map[x].thread_pollfd_index = thread_pollfd_index;
> +       rec->index_map_cnt += 1;
> +       return 0;
> +}
> +
> +static int record__update_evlist_pollfd_from_thread(struct record *rec,
> +                                                   struct evlist *evlist,
> +                                                   struct record_thread *thread_data)
> +{
> +       struct pollfd *e_entries = evlist->core.pollfd.entries;
> +       struct pollfd *t_entries = thread_data->pollfd.entries;
> +       int err = 0;
> +       size_t i;
> +
> +       for (i = 0; i < rec->index_map_cnt; i++) {
> +               int e_pos = rec->index_map[i].evlist_pollfd_index;
> +               int t_pos = rec->index_map[i].thread_pollfd_index;
> +
> +               if (e_entries[e_pos].fd != t_entries[t_pos].fd ||
> +                   e_entries[e_pos].events != t_entries[t_pos].events) {
> +                       pr_err("Thread and evlist pollfd index mismatch\n");
> +                       err = -EINVAL;
> +                       continue;
> +               }
> +               e_entries[e_pos].revents = t_entries[t_pos].revents;
> +       }
> +       return err;
> +}
> +
> +static int record__dup_non_perf_events(struct record *rec,
> +                                      struct evlist *evlist,
> +                                      struct record_thread *thread_data)
> +{
> +       struct fdarray *fda = &evlist->core.pollfd;
> +       int i, ret;
> +
> +       for (i = 0; i < fda->nr; i++) {
> +               if (!(fda->priv[i].flags & fdarray_flag__non_perf_event))
> +                       continue;
> +               ret = fdarray__dup_entry_from(&thread_data->pollfd, i, fda);
> +               if (ret < 0) {
> +                       pr_err("Failed to duplicate descriptor in main thread pollfd\n");
> +                       return ret;
> +               }
> +               pr_debug2("thread_data[%p]: pollfd[%d] <- non_perf_event fd=%d\n",
> +                         thread_data, ret, fda->entries[i].fd);
> +               ret = record__map_thread_evlist_pollfd_indexes(rec, i, ret);
> +               if (ret < 0) {
> +                       pr_err("Failed to map thread and evlist pollfd indexes\n");
> +                       return ret;
> +               }
> +       }
> +       return 0;
> +}
> +
>  static int record__alloc_thread_data(struct record *rec, struct evlist *evlist)
>  {
>         int t, ret;
> @@ -1121,6 +1193,11 @@ static int record__alloc_thread_data(struct record *rec, struct evlist *evlist)
>                                  thread_data[t].pipes.msg[0]);
>                 } else {
>                         thread_data[t].tid = gettid();
> +
> +                       ret = record__dup_non_perf_events(rec, evlist, &thread_data[t]);
> +                       if (ret < 0)
> +                               goto out_free;
> +
>                         if (evlist->ctl_fd.pos == -1)
>                                 continue;
>                         ret = fdarray__dup_entry_from(&thread_data[t].pollfd, evlist->ctl_fd.pos,
> @@ -2530,6 +2607,9 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>                                             record__thread_munmap_filtered, NULL) == 0)
>                                 draining = true;
>
> +                       err = record__update_evlist_pollfd_from_thread(rec, rec->evlist, thread);
> +                       if (err)
> +                               goto out_child;
>                         evlist__ctlfd_update(rec->evlist,
>                                 &thread->pollfd.entries[thread->ctlfd_pos]);
>                 }
> --
> 2.25.1
>
