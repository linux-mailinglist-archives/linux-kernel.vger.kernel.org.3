Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D71854B3F8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 16:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245755AbiFNOzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 10:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbiFNOzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 10:55:43 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7A0396A6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 07:55:41 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l126-20020a1c2584000000b0039c1a10507fso4944222wml.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 07:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5KHkhMQDGtwdstkjXWHFSVzBcaKYJ5m42cuKHcJ65sU=;
        b=SoI7Mcf1oXGzxGQl5wtTR1yuf5xfegapeLuu2vxweQ1MNbDBrN0/4xJ0k8k28wcz0T
         JRBrZSTsb9yZzz/Qm6LuXy9dx/hRWHBpDoyoOFrX3DvS2m0uftBq1iOsKIfwItBOHG1+
         iSklWvRcVwTvGRpTwS7uEx/qm63+0CLdlyV0uzwCnWR+qobnMwTXhLRAVEHBntY0ofn1
         oy107rSkyjyk87M0Mg15HoZvQwU4UwQiL6mE+CO+P6pQRDnuoW+PU5qfaz+o9pQF5x0o
         YHDU8UA3isL9evb4vZuWA8VADCmniAePOm41j74zhEl0Bc/Tq7HFGTTm+kwdBUiKTr7d
         1ScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5KHkhMQDGtwdstkjXWHFSVzBcaKYJ5m42cuKHcJ65sU=;
        b=35t60UkRQG7YlVRXz0prb5c/eMB14waGBNQTXi1bcwE19AicNNjSKnzqFEX/BKl23F
         wvpnPHel/+YuVWENEwWiTgaMZluOnbAONX3P2nsAwVgB/tojvwj/Bb+h050oDwz/wfB6
         3ydCS/4+kgJte/z87UdaYS1o6eqRrgbykIjjEonvjwVKtUiDhbHpDckI8BPnc6kV8Lz/
         lZCCRPufNwrFX/W3PXw4gqqz5pdz0i9N2lZ0WtfsGKl7dzRbkpfWryEQ+HetnOMbr4+0
         UP9GZ3Hp97jDMUIUcL3CmUy6H+tKR8XiUUJVWGnkKQkquQtsnQjSw5XMiKZDC232o2AK
         6YrQ==
X-Gm-Message-State: AOAM533k6cUmxHm4BtPOv2FPNzNB04c82VrQg+L1P9mU2mPhVvW84Onf
        gPVvPCS8KftYocpP3q7hrYaVFXvQTBtdbQG6994MIw==
X-Google-Smtp-Source: ABdhPJzwwH74QFl9IeV6nXihfvsYAVKHSsEA7ac0ej5VgQwxpvi+ySh55At8/TYrwsGW/8NED69S3B9WSxpW6HQP2GA=
X-Received: by 2002:a7b:c7da:0:b0:39c:5b34:3019 with SMTP id
 z26-20020a7bc7da000000b0039c5b343019mr4590428wmk.115.1655218540218; Tue, 14
 Jun 2022 07:55:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220610113316.6682-1-adrian.hunter@intel.com>
In-Reply-To: <20220610113316.6682-1-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 14 Jun 2022 07:55:28 -0700
Message-ID: <CAP-5=fVXgn3gT2qb9PSPBSV4X66DHBkFEdkZfOF=sKtoEco31Q@mail.gmail.com>
Subject: Re: [PATCH 0/5] perf record: Preparation for sideband injection
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

On Fri, Jun 10, 2022 at 4:33 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Hi
>
> Here are some small patches in preparation for "sideband injection".
>
> I hope to run perf record in a virtual machine to capture sideband events
> while simulataneously running perf record with Intel PT on the host, and
> then subsequently inject the sideband events from the guest perf.data file
> into the host perf.data file, so that decoding can decode the Intel PT
> trace for the periods when the guest is running user space (kernel space
> is already decodable).
>
> The patches are changes I have found so far that will be needed.
>

Except for a nit on the perf-record man page, everything looks good to me.
Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Adrian Hunter (5):
>       perf record: Always get text_poke events with --kcore option
>       perf record: Always record id index
>       perf record: Add new option to sample identifier
>       perf record: Add finished init event
>       perf script: Add some missing event dumps
>
>  tools/lib/perf/include/perf/event.h      |  1 +
>  tools/perf/Documentation/perf-record.txt |  3 +++
>  tools/perf/builtin-inject.c              |  1 +
>  tools/perf/builtin-record.c              | 44 +++++++++++++++++++++++++++-----
>  tools/perf/builtin-script.c              |  6 +++++
>  tools/perf/util/event.c                  |  1 +
>  tools/perf/util/header.c                 |  3 +++
>  tools/perf/util/record.c                 |  2 +-
>  tools/perf/util/record.h                 |  1 +
>  tools/perf/util/session.c                |  4 +++
>  tools/perf/util/synthetic-events.c       |  7 +++--
>  tools/perf/util/tool.h                   |  3 ++-
>  12 files changed, 65 insertions(+), 11 deletions(-)
>
>
> Regards
> Adrian
