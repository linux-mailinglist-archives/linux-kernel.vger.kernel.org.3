Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0F158DC73
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 18:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245010AbiHIQvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 12:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240111AbiHIQvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 12:51:11 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330AB15818
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 09:51:10 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id v131-20020a1cac89000000b003a4bb3f786bso9225595wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 09:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=yYCv0OKA2ajdhMJMO4esrDPhNHey8x/seGR5xnjCqgE=;
        b=FdIX9XwCtK5TKHCKTBgwpmHKJctp/7eDebFj+oObyrLCHUhZ9fTeKD7D0aesJXTmgz
         ZvAB/vwrY/Q2qD7lhmKp64MgauzR1mUG/tYvpqSfNC5f+gl9L+jQChfE6rq3qqo5R1y2
         g9rAwvpCK5n6aFZcYSqFTgcsoity64BDneKSVAG8YoVxf0DYCpHQKoDGH8+zUTEmeq6Q
         a0v88jc+XXnZM9X9a5n2GvbzdlI6ZKYz0kKFE7FvKhZyuxgiDZFP5ebEGHGbrItC3J5X
         LY726pmwHNd0f5zG818xPSdovxjStYFjVxODP2Tb6mqygLO5or+d9IUCzDUMGmkspcBF
         Njwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=yYCv0OKA2ajdhMJMO4esrDPhNHey8x/seGR5xnjCqgE=;
        b=DKkGVTlE+2BjEBVgPbZ/WKpch4YW9KJbUdStxddgupxEUwj1blE5K5rnlIRE0rVP9k
         YBzQnQa8mRrNY6kC3EtWTuNQIGDThlm9p9Ur/UHdQZm640vIYSVWPb+mjl0XF6xdLEPO
         dTcu26bRV9N4p+CyQf25ypgCy8mtdKMfYPPnsRbkvKv6GBzYe40RGhVDS3yWntaKCqkT
         2hpKlR4u21Xti+IqeQ6CLUKl2GRN0nv5Ux3UAW7G0Q8qE4ELmZoPFrw/UwUrQFgg1JlL
         xhukK+M8m1N6UTEyt/DIVjTfv5bRqlxRIvHkb+ZcMqxcmQvO/Dgp2pPlOffQ4WiIySf/
         YErQ==
X-Gm-Message-State: ACgBeo3zfywz93zb/W9SHDockklibievTvLCOQLwREUUmdGR8DW1WMex
        sLajMAUxIgLbcOmzZUKYV36c12jah1piwFqhehb7bQ==
X-Google-Smtp-Source: AA6agR6HXY9wjRXiu6nQR54Iobw8KWuHhbi7gJWP3/YGhTQoXiLwAWrpCkxShb4/U8nTRiBihrfOiS2XvUiADoXuPwE=
X-Received: by 2002:a7b:cb44:0:b0:3a4:e8c7:59a2 with SMTP id
 v4-20020a7bcb44000000b003a4e8c759a2mr16568739wmj.67.1660063868529; Tue, 09
 Aug 2022 09:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220809123258.9086-1-adrian.hunter@intel.com>
In-Reply-To: <20220809123258.9086-1-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 9 Aug 2022 09:50:55 -0700
Message-ID: <CAP-5=fVBHQby5+BxA4T7V9iH9edsCJ6i6cfJS62j275Q7ZXuTw@mail.gmail.com>
Subject: Re: [PATCH] perf script: Fix reference to perf insert instead of perf inject
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
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

On Tue, Aug 9, 2022 at 5:33 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Amend "perf insert" to "perf inject".
>
> Fixes: e28fb159f116 ("perf script: Add machine_pid and vcpu")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/Documentation/perf-script.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
> index c09cc44e50ee..4c95e79e2c39 100644
> --- a/tools/perf/Documentation/perf-script.txt
> +++ b/tools/perf/Documentation/perf-script.txt
> @@ -228,7 +228,7 @@ OPTIONS
>         Instruction Trace decoding.
>
>         The machine_pid and vcpu fields are derived from data resulting from using
> -       perf insert to insert a perf.data file recorded inside a virtual machine into
> +       perf inject to insert a perf.data file recorded inside a virtual machine into
>         a perf.data file recorded on the host at the same time.
>
>         Finally, a user may not set fields to none for all event types.
> --
> 2.25.1
>
