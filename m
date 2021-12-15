Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 709FA476036
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 19:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238675AbhLOSFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 13:05:54 -0500
Received: from mail-lf1-f44.google.com ([209.85.167.44]:36797 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238548AbhLOSFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 13:05:53 -0500
Received: by mail-lf1-f44.google.com with SMTP id k37so44803393lfv.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 10:05:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n7N1XRDHlKO7jxKQOX2Rii5HYs5LX8csVthUgjpFZH8=;
        b=E8Yl7LgTMu+RrDvFDNWW24HFlRR+X3q/cMGsOMfN62vPX1HZFruRNV8KbkLvDpEsU3
         FiFNhEH9bTi3CMuj+pkpxBwCM2HzYETsLOiNShsntpK9hf5Ax62D8MtRx0FLzKsoZ1jm
         KLRx7ujM6d/Uw02P+L4ECi+sJn8wtgWAcpRDCv/28yJH+0cS368HJWTLJgpP9xR7NMYu
         jZgxCgZTPbwArDP6M/YUtEtwkf1yojbkz9LYSzXS3gsXGXu89HQQE+e5e7doNLzRzqef
         GPWrMwmHJOoKRlV+YtUPUUKGr8pFcIZcLcbV42yZx8EfhOh8wm6Siekz7ysvzIml4Plm
         KPEw==
X-Gm-Message-State: AOAM533Cz0X1k7YNlDDuRH9+XJELBLzbbWMcizInJiiiCD5Jky2VQs2L
        CsWyhxZAcCFAEqlSAcy8pevzBwelUkVUYqOVLLycrii9XVQ=
X-Google-Smtp-Source: ABdhPJz61CI+5nVEFmtH+y/e1HEx/g2XnlMy3hSL3teizwRM6pS5NDAukaD1OBrEVXA/rWie09SHFpr7yo70L5c65sI=
X-Received: by 2002:a05:6512:220f:: with SMTP id h15mr11184761lfu.454.1639591551789;
 Wed, 15 Dec 2021 10:05:51 -0800 (PST)
MIME-Version: 1.0
References: <20211215080636.149562-1-adrian.hunter@intel.com> <20211215080636.149562-3-adrian.hunter@intel.com>
In-Reply-To: <20211215080636.149562-3-adrian.hunter@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 15 Dec 2021 10:05:40 -0800
Message-ID: <CAM9d7cirFVsiRmqCSnzM3Q22nvq+WBkiKrYZ21FZ4Pa4trnZrQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf script: Fix CPU filtering of a script's switch events
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 12:07 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> CPU filtering was not being applied to a script's switch events.
>
> Fixes: 5bf83c29a0ad2 ("perf script: Add scripting operation process_switch()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/builtin-script.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 9434367af166..c82b033e8942 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -2473,7 +2473,7 @@ static int process_switch_event(struct perf_tool *tool,
>         if (perf_event__process_switch(tool, event, sample, machine) < 0)
>                 return -1;
>
> -       if (scripting_ops && scripting_ops->process_switch)
> +       if (scripting_ops && scripting_ops->process_switch && !filter_cpu(sample))
>                 scripting_ops->process_switch(event, sample, machine);
>
>         if (!script->show_switch_events)
> --
> 2.25.1
>
