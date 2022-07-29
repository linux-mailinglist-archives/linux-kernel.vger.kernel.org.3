Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35FB5851B0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 16:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236075AbiG2Oje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 10:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiG2Oja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 10:39:30 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321BC7E01B
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 07:39:28 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id m13so2295998wrq.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 07:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ccyQEp70PgUTExpVZ+kylw0PAR4mA5YvPy+or/e3ado=;
        b=pYb7soAL2U25017/5t6iFxmWqARIP39Py1vHsfQp+rQTGn5GwApCdx4/v7N5CBMJqR
         n/wXxr8NQBMg9bhOrilxKSQtHkWSVLX98YEMMLVG8o2Qlh7hauM4BK6s5UAZBxoqzdtO
         wlmBiz26vaLcgZNbyNHO3Aj14ZvK5/Z1kdUQ1R1Rev9j54KJ0afJbD+JOy0ZaYHYjdk1
         rLV+t2dIMwSLm3EAPcp5M/WqqWong7KzXBwXL6cD5qgwfTKz13X4omBmD9qg0OqNcAVD
         YkKomrjx2mcfP4wtuAbADyVUdwRUPsc85tees66PJd4xuG+2qgmcBQNYx8jRAYRblEQ3
         9r0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ccyQEp70PgUTExpVZ+kylw0PAR4mA5YvPy+or/e3ado=;
        b=5w577O5PigBQQkMHa0OnaSuxg+BdMo8tFUw4YHES8Wc7ITPJOPH3F4lPIfuD3FT13M
         VtLCfA1K4r59kKfEDZOYJOy6e165jv+Vx1XWvFP7RNiHAJWI2IsmZfovV8Fv5/YKx1A3
         rYHjh5s9CBOutObMTqpSTd6N3V8bANpELcAXvLEQNKwdqe+XG4XVDZxBDpuDJVvJ3QoD
         4TXQ5CIZ3OlTUitUmamgQHZN2dWHxpMSypsXrMz7uU85F/m4ao8fKhuyT43knDQkGp3x
         +xApcbYniSzuXt73FP2+ytNzTE7mfOfGuNfuqY6MCe5YMkkzVe4CeuqEciNoEl3FdCs4
         H+5w==
X-Gm-Message-State: ACgBeo057Q4H0Zlj/J9Prq/oIeV73hpoUcPKKTXk5R+g536oiONfJNdU
        EIhydjbA3h1dBndbmOa/H0VsG+T0RMxvk8aLoeVZIQ==
X-Google-Smtp-Source: AA6agR6azsiUOCd6hqvIYIcu93cG1wUj06gQB5edVSSZxI53u6BuJLo2aLac7oDdvR39BuhQX82KIEhxTpsQYQa83nc=
X-Received: by 2002:a5d:6d4e:0:b0:21e:660e:55bf with SMTP id
 k14-20020a5d6d4e000000b0021e660e55bfmr2521559wri.343.1659105566496; Fri, 29
 Jul 2022 07:39:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220707191209.273065-1-irogers@google.com> <YuPIIgJabRkPLvvn@krava>
In-Reply-To: <YuPIIgJabRkPLvvn@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 29 Jul 2022 07:39:14 -0700
Message-ID: <CAP-5=fUyzrahbkBj5_WN1=pB8E=5YitOn=RvBjZE-zcsnmuLmg@mail.gmail.com>
Subject: Re: [PATCH v2] perf parse-events: Break out tracepoint and printing.
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 4:44 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Thu, Jul 07, 2022 at 12:12:09PM -0700, Ian Rogers wrote:
> > Move print_*_events functions out of parse-events.c into a new
> > print-events.c. Move tracepoint code into tracepoint.c or
> > trace-event-info.c (sole user). This reduces the dependencies of
>
> it seems like it'd be better to have those changes in separated
> patches, at least for review

Agreed. I'll follow up with a v3.

Thanks,
Ian

> jirka
>
> > parse-events.c and makes it more amenable to being a library in the
> > future.
> > Remove some unnecessary definitions from parse-events.h. Fix a
> > checkpatch.pl warning on using unsigned rather than unsigned int.
> > Fix some line length warnings too.
> >
> > v2. Rebase in particular after hybrid PMU changes.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> SNIP
