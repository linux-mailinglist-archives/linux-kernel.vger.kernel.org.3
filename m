Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFCB455D25D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345031AbiF1KzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 06:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbiF1KzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 06:55:10 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D71031939
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 03:55:09 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-3137316bb69so112352047b3.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 03:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bx+nn3bN9pkcTAPrSO8SXuVhJpjdYzH6Wim9ZDKKiAY=;
        b=SgjVnFGomlUOotY/gew1wOdWrD475NDkUK1mb2rUT0EFvD8XhhNOIIykcSWEEL6YxM
         jJinJuo/gJhCW+dtmxOqBXMPReGrI3zwNRZ+WxliSN7Qpbi3jNvVW6ZwIMhSLVwOZY6t
         ByNEzLBuoiVfE3KB4iqfCywFWucy1UDCjq2jhO+UJZFD+1vUpogEWe/tfIk+C9HEG//B
         dURvYRrCbZJjIctxYxYIMKq5CBmVom2p/kc915BHwbw1lCKYOEFZKDEsHmdfX9irHD7j
         F1llsAgUDsNOJIVYDHW7Qal7uXAZjI8v4vAgdaHAB1+k39/T1eUyg4VTTYoCAmCLSqV5
         va5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bx+nn3bN9pkcTAPrSO8SXuVhJpjdYzH6Wim9ZDKKiAY=;
        b=5VU1uupxEUSt/lD9GihmCQweDB6NwTxi4PWOUJygNfzOCqhDrnJqIriKbzXkLguGcb
         WQ7jw27NtueAB35A0wVmk7hojnAuEWnLhFcW1Dd6egprKGQw0nuczJOoapHEEHKauie6
         A/wqNF2X6HEO5cMBk4hBG9Mtc5LpEtgftlPdTg3AiXdsp7G0nGhPVZ+eb57V6qgxADLi
         h/5NalllIWoRe9PYZ2XP8nwUNTvjm68VKUJ87FlEuchaOG9/l7MTUFSAL0gaK0uPkcUS
         RlXcl5sEET5hnjb0WzDsEW4HM/6TH/S6eVuXr7/U2e/+gAcPi9rEmQGkY/lW1tcYipi6
         rUIg==
X-Gm-Message-State: AJIora/cADyD8dCnYyzvkfqRlTSQTAE0gX/QValWV7D7s5YOMxG3NcOB
        3ZDlsb3WsKnHKmAtb9mPpIlIhMXTEPkIuxwqujzLxQ==
X-Google-Smtp-Source: AGRyM1vz2ZG/AOoQ4vBN8VmbUXJLQvwRbaY4tA5etmPkx+EhZBLBb/NNp85KWwxKWmdK+O/VbOcVkqR614Ti4viQrKI=
X-Received: by 2002:a81:1a42:0:b0:318:3915:57d7 with SMTP id
 a63-20020a811a42000000b00318391557d7mr19561304ywa.327.1656413708510; Tue, 28
 Jun 2022 03:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220628095833.2579903-1-elver@google.com> <20220628095833.2579903-14-elver@google.com>
In-Reply-To: <20220628095833.2579903-14-elver@google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 28 Jun 2022 12:54:32 +0200
Message-ID: <CANpmjNPapZ9p3dSB1RC-cBoJ588XkRxJRzbhxx4THLZ9aWsx=A@mail.gmail.com>
Subject: Re: [PATCH v2 13/13] perf/hw_breakpoint: Optimize toggle_bp_slot()
 for CPU-independent task targets
To:     elver@google.com, Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jun 2022 at 11:59, Marco Elver <elver@google.com> wrote:
[...]
> +       /*
> +        * Update the pinned task slots, in per-CPU bp_cpuinfo and in the global
> +        * histogram. We need to take care of 5 cases:

This is a typo: "5 cases" -> "4 cases".
