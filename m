Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1F3584444
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 18:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiG1Qhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 12:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiG1Qhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 12:37:47 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419E93A4AF
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 09:37:46 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id bn9so2922839wrb.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 09:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N+zLZ68jPdsuV8kFRBtjgcPpirHKM1P6CnnyplyyLyI=;
        b=DDTQuRELXLh1k4gyHA8vFZ8znx7BXomr3wiMDHCERPtV4ZNv5f9E24HkaWlHX+GtQC
         7Ff7SBHctIQbgAsAz25N65Z3pkeFSit/NoaLj981hc+uMIpGJPEPZ+5nseVnO4WMGQ7R
         pLqXWcUAtJNBUcSdxVXpsQqf18WlvNV8G0slJ5IjT6/1tcLOGzD70dD/5JF9m5BGUFL0
         zzjC867fRnlSqSaw6CQ5J+58f6NwGfUyHNdjZuP0yVI9Ts+wJ2qH+5Eg0REIf5echHgW
         30TafkiHcqU++AMKVczpSDYMana6W7Ikw2DeX56ltcaZ0pAD8Z+hOmTHtCJJ+F/hqcEZ
         unDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N+zLZ68jPdsuV8kFRBtjgcPpirHKM1P6CnnyplyyLyI=;
        b=pFpWvGLxi7YlZKhIYwChlqsj4mV6KQnaj808nd1TgBX053viKmvAsDj3W/INVcJ7gJ
         TaNrdl8qhAnv6r87bbv6my3gAYv0nkqzW8lp+DM+gX9WRhtEcql1PJLuOUbpuckja4tF
         U9+9N9UC7tEHNYstHWhNqlvigBg4B3lqBGrEtvke0XB7yBCFyxTV3AkQ2dAp+oBanfPF
         4/WJ0EzJWb8ykZzMexnRG71DwVlA2ySOdb47e/bQqUf0SMSDpwvYcuQDLY8ToDLlLX7T
         cGL5ym3UCtBgxfSw7+BMNwWVbqBrePcHgIf+ccnC/3ZQusbhRheEtNnATbaw15cQ56HS
         07Yg==
X-Gm-Message-State: AJIora90Fkbx8mxnxvyZlaRzIHWxasfvUcr6vGEq4fs5baBcO9DAfJC/
        qrJhn1GXM/4FAS2VxKPnse+cSXg3mdk+L4HhdDuN/A==
X-Google-Smtp-Source: AGRyM1smna+ZfJhYTIWoof3XK54TZmaXaOEPdOqkur2Wi27qoVSejJOVtZaYEmitwiOoUssoWrSdAG85317+Uh0Zl70=
X-Received: by 2002:adf:e28d:0:b0:21e:4c3b:b446 with SMTP id
 v13-20020adfe28d000000b0021e4c3bb446mr17491154wri.300.1659026264488; Thu, 28
 Jul 2022 09:37:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220728093946.1337642-1-james.clark@arm.com>
In-Reply-To: <20220728093946.1337642-1-james.clark@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 28 Jul 2022 09:37:32 -0700
Message-ID: <CAP-5=fXnR=LSk-bO02V7HzWTTCrsbnM1w63_YYqSMEgy0vM-PQ@mail.gmail.com>
Subject: Re: [PATCH] perf: python: Fix build when PYTHON_CONFIG is user supplied
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, acme@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 2:40 AM James Clark <james.clark@arm.com> wrote:
>
> The previous change to Python autodetection had a small mistake where
> the auto value was used to determine the Python binary, rather than the
> user supplied value. The Python binary is only used for one part of the
> build process, rather than the final linking, so it was producing
> correct builds in most scenarios, especially when the auto detected
> value matched what the user wanted, or the system only had a valid set
> of Pythons.
>
> Change it so that the Python binary path is derived from either the
> PYTHON_CONFIG value or PYTHON value, depending on what is specified by
> the user. This was the original intention.
>
> This error was spotted in a build failure an odd cross compilation
> environment after commit 4c41cb46a732fe82 ("perf python: Prefer
> python3") was merged.
>
> Fixes: 630af16eee495f58 ("perf tools: Use Python devtools for version autodetection rather than runtime")
> Signed-off-by: James Clark <james.clark@arm.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/Makefile.config | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index d3c254c0f5c6..a69da9f34486 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -265,7 +265,7 @@ endif
>  # defined. get-executable-or-default fails with an error if the first argument is supplied but
>  # doesn't exist.
>  override PYTHON_CONFIG := $(call get-executable-or-default,PYTHON_CONFIG,$(PYTHON_AUTO))
> -override PYTHON := $(call get-executable-or-default,PYTHON,$(subst -config,,$(PYTHON_AUTO)))
> +override PYTHON := $(call get-executable-or-default,PYTHON,$(subst -config,,$(PYTHON_CONFIG)))
>
>  grep-libs  = $(filter -l%,$(1))
>  strip-libs  = $(filter-out -l%,$(1))
> --
> 2.28.0
>
