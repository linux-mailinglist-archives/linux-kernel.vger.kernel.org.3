Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732EF59FEAB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 17:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239935AbiHXPnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 11:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239944AbiHXPnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 11:43:14 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E0F8E9BA
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 08:42:21 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id h5so20453052wru.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 08:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Ea0aUnS9aRyq1YnrkoEMZKPYyCD80EXoe550IbvtW0k=;
        b=kQ3TnPom6kAHKFLObqwZYvCmKyyI3rjukpnieic1InUWxCPrL2PMK1VmusmTmzAUWD
         2VB8C8tB433vPGjKw3LkTbY6yr45mxuxSUmMQsYNa+5B16M/46hnbmS1okxpC2lRjfcq
         cGTClaYp+FQNwDfWTYR7JJGeLP/7xlPT+rVSqB/oEKejOY4315PqbPgVudXWfwhATx0u
         l20frKZr/c133XWM1LjeDsl0YPBmYPCeN4qEn5unv2ytYdpEBrQUfHOJZw3/JnMv2G8L
         dSwN06tBDLlXHgeqXdWHx4vGuYuFtYvxW9oYY3Z/PqHheAh7s+2HTJ/a8tWax4kXQ302
         SdRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Ea0aUnS9aRyq1YnrkoEMZKPYyCD80EXoe550IbvtW0k=;
        b=3ONCkTffShnY/WKx/e96kVvknKuKsGoX4zVCMuBcG18APVysWv7CjUn9dgx5HWAyNv
         DTxM4SXHJtK8T+EKVvS1ZPGOBWkC66pioFsABlI2UDKf6oDa4/BCD//yLfryO9K791HM
         fy/RTM4CoCdw/qRITwofN9ZdknwjoSHflp/Mbi5HHhKbIxefWAo8Qx5JtR7KSfDkglaQ
         bOg2DPrRSt66h5bIBQtEKO+M+uEjH3E9iw90/pVMdgHjRlD609quhyVxaYVfINQ2KsxO
         qvv8i7PS2gm2OMJH3IdVXdU1tASKbqLG8W3mR6LOCwIvtcrvlCQzckmWQKmLcqRpICYw
         yo+g==
X-Gm-Message-State: ACgBeo0oUU2mdRlId75Ea+rNUcupGe9p0P8rW4oeoCillyuRiPx4LsvC
        96wbNfG93YGIsitaLaXSExQdEhKYuJviKB1vQdi22g==
X-Google-Smtp-Source: AA6agR7ANYxvdssAK+K3nTjE+1hP5mnsBd27RcutjwPmS45a0R2o0nOeI386FlBdKSG2yye9BVlzbzq5U7qtAZNTGfQ=
X-Received: by 2002:a05:6000:1a87:b0:222:2c85:2f5b with SMTP id
 f7-20020a0560001a8700b002222c852f5bmr17083474wry.654.1661355740325; Wed, 24
 Aug 2022 08:42:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220824072814.16422-1-adrian.hunter@intel.com> <20220824072814.16422-4-adrian.hunter@intel.com>
In-Reply-To: <20220824072814.16422-4-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 24 Aug 2022 08:42:08 -0700
Message-ID: <CAP-5=fUsg7xSvcFBt7f8rUfCEKizFpndy9Ax3pL1AvEOnDRUhw@mail.gmail.com>
Subject: Re: [PATCH 3/5] perf record: Change evlist->ctl_fd to use fdarray_flag__non_perf_event
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
> Patch "perf record: Fix way of handling non-perf-event pollfds" added a
> generic way to handle non-perf-event file descriptors like evlist->ctl_fd.
> Use it instead of handling evlist->ctl_fd separately.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-record.c | 15 +--------------
>  tools/perf/util/evlist.c    | 19 ++-----------------
>  tools/perf/util/evlist.h    |  1 -
>  3 files changed, 3 insertions(+), 32 deletions(-)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index e0be48c47f65..cefb3028f565 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1198,18 +1198,7 @@ static int record__alloc_thread_data(struct record *rec, struct evlist *evlist)
>                         if (ret < 0)
>                                 goto out_free;
>
> -                       if (evlist->ctl_fd.pos == -1)
> -                               continue;
> -                       ret = fdarray__dup_entry_from(&thread_data[t].pollfd, evlist->ctl_fd.pos,
> -                                                     &evlist->core.pollfd);
> -                       if (ret < 0) {
> -                               pr_err("Failed to duplicate descriptor in main thread pollfd\n");
> -                               goto out_free;
> -                       }
> -                       thread_data[t].ctlfd_pos = ret;
> -                       pr_debug2("thread_data[%p]: pollfd[%d] <- ctl_fd=%d\n",
> -                                thread_data, thread_data[t].ctlfd_pos,
> -                                evlist->core.pollfd.entries[evlist->ctl_fd.pos].fd);
> +                       thread_data[t].ctlfd_pos = -1; /* Not used */
>                 }
>         }
>
> @@ -2610,8 +2599,6 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>                         err = record__update_evlist_pollfd_from_thread(rec, rec->evlist, thread);
>                         if (err)
>                                 goto out_child;
> -                       evlist__ctlfd_update(rec->evlist,
> -                               &thread->pollfd.entries[thread->ctlfd_pos]);
>                 }
>
>                 if (evlist__ctlfd_process(rec->evlist, &cmd) > 0) {
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 0b2222d05577..4c5e6e9f8d11 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -1898,7 +1898,8 @@ int evlist__initialize_ctlfd(struct evlist *evlist, int fd, int ack)
>         }
>
>         evlist->ctl_fd.pos = perf_evlist__add_pollfd(&evlist->core, fd, NULL, POLLIN,
> -                                                    fdarray_flag__nonfilterable);
> +                                                    fdarray_flag__nonfilterable |
> +                                                    fdarray_flag__non_perf_event);
>         if (evlist->ctl_fd.pos < 0) {
>                 evlist->ctl_fd.pos = -1;
>                 pr_err("Failed to add ctl fd entry: %m\n");
> @@ -2148,22 +2149,6 @@ int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
>         return err;
>  }
>
> -int evlist__ctlfd_update(struct evlist *evlist, struct pollfd *update)
> -{
> -       int ctlfd_pos = evlist->ctl_fd.pos;
> -       struct pollfd *entries = evlist->core.pollfd.entries;
> -
> -       if (!evlist__ctlfd_initialized(evlist))
> -               return 0;
> -
> -       if (entries[ctlfd_pos].fd != update->fd ||
> -           entries[ctlfd_pos].events != update->events)
> -               return -1;
> -
> -       entries[ctlfd_pos].revents = update->revents;
> -       return 0;
> -}
> -
>  struct evsel *evlist__find_evsel(struct evlist *evlist, int idx)
>  {
>         struct evsel *evsel;
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index 351ba2887a79..3a464585d397 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -418,7 +418,6 @@ void evlist__close_control(int ctl_fd, int ctl_fd_ack, bool *ctl_fd_close);
>  int evlist__initialize_ctlfd(struct evlist *evlist, int ctl_fd, int ctl_fd_ack);
>  int evlist__finalize_ctlfd(struct evlist *evlist);
>  bool evlist__ctlfd_initialized(struct evlist *evlist);
> -int evlist__ctlfd_update(struct evlist *evlist, struct pollfd *update);
>  int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd);
>  int evlist__ctlfd_ack(struct evlist *evlist);
>
> --
> 2.25.1
>
