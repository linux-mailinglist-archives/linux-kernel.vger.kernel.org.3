Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6C6584FB4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 13:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235976AbiG2Lon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 07:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbiG2Lol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 07:44:41 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC4E87C37;
        Fri, 29 Jul 2022 04:44:39 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id r1-20020a05600c35c100b003a326685e7cso4199340wmq.1;
        Fri, 29 Jul 2022 04:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=0Xuom7KeE+vMz3QTfrPBFOV2WYw8OpJ11e3qMimq20E=;
        b=dtLPVMC7KDC765z96MZ3Dx/IsGnSS6qj7JOAICOp6BYAiPitXOc4MUpaWpz9/73/S5
         c695iBMksI7+KIrOuahBWFLctSNA4h/FNq7sZ/n/4QXofTfLLvCtSVx74Lo8+mZi9Kgs
         BjzD8nvRLRQQt9SOgN6XrL4zito5COWpLx7/4WbRGxuX9WuzSBVnklTrF9NegCOxMd17
         aqfpCFm4yBv21AJmzMK2qEkHrNZHV2iVoylI2jfXQacKH7EnrfqNtNGhvVdFCSXoZhOy
         mpT8Rd0gIDX55NsMYLESwUaPE9rIH3ST3Tr/fPDgl8os7TH24R8ppRqiR2fLv0W3KGXw
         P1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=0Xuom7KeE+vMz3QTfrPBFOV2WYw8OpJ11e3qMimq20E=;
        b=LsJCgaqoIbiZRMf9vZW3u6gS6pJk3DXgPiq2b4Lrcexn7paEFSM7yHxCK4j9udKHeS
         7vWxaeGJmCt7D2L/GOkdYceKdlvB1rH5di7AIVGEfAEiJuWOiDv7k+17fCm4SOgfCGq/
         F3bxWqehLc96Yg63L6OPOiaw8+0gzM2gQqatwGpT40YQufqE3/H6TvmAy69QdNtV3X0d
         sUS28/rRGwf//PyqEIUpvj9Ja4OwDIsOZq1mWWHzkvkk+m1PBk1aMsQGOpOkjuyRrM/t
         Ze0KJKwixnO75XKkiwGP82/i4DX11is+T6tDnd2pkq1xXI0a4YFlfx//HSv4OVpWM9yu
         6Bbg==
X-Gm-Message-State: AJIora+stvv3JvmWAzQvUp+xEE017D4ZhTJ0hICAJuJGDRqYYe+H04jF
        8aabw1nOAQOFl6RFnMsmUyg=
X-Google-Smtp-Source: AGRyM1srqMApE0Lu5aCvEJ47f7JFvX9k90D5K2p4K7Hwk/cidjUr2p5va3KRsHYrNSOwsn90uvoXWA==
X-Received: by 2002:a05:600c:3786:b0:3a3:19d4:293f with SMTP id o6-20020a05600c378600b003a319d4293fmr2642663wmr.116.1659095077651;
        Fri, 29 Jul 2022 04:44:37 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id d3-20020adffbc3000000b0021e297d6850sm3275970wrs.110.2022.07.29.04.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 04:44:37 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 29 Jul 2022 13:44:34 +0200
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2] perf parse-events: Break out tracepoint and printing.
Message-ID: <YuPIIgJabRkPLvvn@krava>
References: <20220707191209.273065-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707191209.273065-1-irogers@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 12:12:09PM -0700, Ian Rogers wrote:
> Move print_*_events functions out of parse-events.c into a new
> print-events.c. Move tracepoint code into tracepoint.c or
> trace-event-info.c (sole user). This reduces the dependencies of

it seems like it'd be better to have those changes in separated
patches, at least for review

jirka

> parse-events.c and makes it more amenable to being a library in the
> future.
> Remove some unnecessary definitions from parse-events.h. Fix a
> checkpatch.pl warning on using unsigned rather than unsigned int.
> Fix some line length warnings too.
> 
> v2. Rebase in particular after hybrid PMU changes.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

SNIP
