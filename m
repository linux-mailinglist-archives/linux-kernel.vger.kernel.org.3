Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8BC467AB5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 16:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381927AbhLCQCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 11:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381930AbhLCQB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 11:01:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16B9C061D7F;
        Fri,  3 Dec 2021 07:58:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AAC662C25;
        Fri,  3 Dec 2021 15:58:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F28C56749;
        Fri,  3 Dec 2021 15:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638547110;
        bh=qJD2danQ3URRcIzZOzZCHOD8e3NiOVJf9PCw7v9jiOo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ori/ZGk47+C7oKVNvK8nvrqZilkaYX4hJMzPeZbO9/PA794ttpWuXs+GdstK8W3Uw
         iprj6d0aDSRA3Ve+f/r8oYR2MqVn28YPIdLEI3rUWv+U5vK6Nnx4Y1rJNrfX5WbUPy
         J0FjeJLwYpSg4EJOvuV8sfCoGRfNhDBe/p38PUR84jPQQQWQKsmLzmraVJd2q+O/6X
         obMA7/MRzdz/V/cDFhcOVSadSUTf2fIcbUgRKODtK43n6N/M1whSfOYZEWGy5bKl4d
         9WCNIZkIj6qfp8lhO7OpYVYiW6YRk6PbNoW3e13CIIW11ZapX0TjI2pC1tkZ4HB8M+
         dY9dFUUbss0+g==
Received: by mail-ed1-f50.google.com with SMTP id y13so13268384edd.13;
        Fri, 03 Dec 2021 07:58:30 -0800 (PST)
X-Gm-Message-State: AOAM530DIPMNkcYlutGCwyXiGREbYxR90ixGqxoY54QMtsPZkGjA01b8
        4JGbaO0WxRhzqOH52ttjhyCndisIo8Soq5lObQ==
X-Google-Smtp-Source: ABdhPJyv+1SOK4GHulPDylE33hTa9bzB6wGwF5kWEz0yW4prK9flpy66cDUS/NwpPf/gHONFOoLeme0BGX6swm4QNGM=
X-Received: by 2002:a17:907:a411:: with SMTP id sg17mr24193953ejc.84.1638547107328;
 Fri, 03 Dec 2021 07:58:27 -0800 (PST)
MIME-Version: 1.0
References: <20211027201641.2076427-1-robh@kernel.org> <20211027201641.2076427-3-robh@kernel.org>
 <87zgpl9rqq.ffs@tglx>
In-Reply-To: <87zgpl9rqq.ffs@tglx>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 3 Dec 2021 09:58:15 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ9kkch_SB6LT_fwxk9QS36zbwsj5wu+dtY7yWe6SEMug@mail.gmail.com>
Message-ID: <CAL_JsqJ9kkch_SB6LT_fwxk9QS36zbwsj5wu+dtY7yWe6SEMug@mail.gmail.com>
Subject: Re: [PATCH v12 2/5] perf: Add a counter for number of user access
 events in context
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 4:57 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Wed, Oct 27 2021 at 15:16, Rob Herring wrote:
> > For controlling user space counter access, we need to know if any event
> > in a context (currently scheduled or not) is using user space counters.
>
> Who is 'we'?
>
> Come on. How is someone without context supposed to figure out that 'we'
> means ARM64 when staring at that changelog a year later?
>
> Is it really that hard to write coherent changelogs which make sense on
> their own and actually follow Documentation/process/ which exists for a
> reason?

I've rewritten it like this:

On arm64, user space counter access will be controlled differently
compared to x86. On x86, access in the strictest mode is enabled for all
tasks in an MM when any event is mmap'ed. For arm64, access is
explicitly requested for an event and only enabled when the event's
context is active. This avoids hooks into the arch context switch code
and gives better control of when access is enabled.

In order to configure user space access when the PMU is enabled, it is
necessary to know if any event (currently active or not) in the current
context has user space accessed enabled. Add a counter similar to other
counters in the context to avoid walking the event list every time.
