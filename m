Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477B64AE22F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 20:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386006AbiBHTXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 14:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385664AbiBHTXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 14:23:03 -0500
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED16C0613CB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 11:23:02 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id z19so35168219lfq.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 11:23:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9sSfgT86JcKQPWiMNvf5KHjTqBzNxqi7RBJOXA+G3TE=;
        b=S+VvBB0dW5cb5Dm0jzEgTkKzeOo+pQlJ/wllYMQyWNJzWWzCSUUzkjmdBMVaQHuAC/
         /MAP+R+sSTUHwcB6aRWkz6LsSmDlGw8kalU0rEzxzbrumm4JE990oTXrF8qeaM/9bnJw
         OEwVBRXihE9Jsb7d4FfQSkNLeo3W88xQHa2l2xe+v1RyFAWlRQnlALGwmp3xUtN9hHR/
         Ax0g2hOlN53dH2TvDOAZTf7jQDGlR9RJVciWXozkgBRaySkVJERpaQ+6/EY2ifL0tsPq
         fMMOzeuZvclZ63t+QjH0dqTTD8sQ/pOfbonanbLfyoeLvJhL+/Q9NAHFbmXbBEyY03nA
         kYcw==
X-Gm-Message-State: AOAM530LWqETWEDMU+GC4jEXQU85R3G42B9CEy6/svB9c/gyT7tukskR
        ZVLCCwAoGf030X4cG1zIjgPM9hxL1+WtiUx3jT4=
X-Google-Smtp-Source: ABdhPJxve+fxMKUvDyRcbmdBUiIcUAyvGHG3kB5ITldtDXvXawwZV+SlujecrlCMkz0uentli5h8X+/mURHHPWB1aYY=
X-Received: by 2002:ac2:46ed:: with SMTP id q13mr3857031lfo.99.1644348180690;
 Tue, 08 Feb 2022 11:23:00 -0800 (PST)
MIME-Version: 1.0
References: <20220208184208.79303-1-namhyung@kernel.org> <20220208184208.79303-6-namhyung@kernel.org>
 <87y22lp4xx.fsf@intel.com>
In-Reply-To: <87y22lp4xx.fsf@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 8 Feb 2022 11:22:49 -0800
Message-ID: <CAM9d7ci0By5zioo+52+14RuFrTqZfzbupJuP-908HhYB2Ovc9A@mail.gmail.com>
Subject: Re: [PATCH 05/12] drm/i915: Protect lockdep functions with #ifdef
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Radoslaw Burny <rburny@google.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Feb 8, 2022 at 10:51 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
>
> On Tue, 08 Feb 2022, Namhyung Kim <namhyung@kernel.org> wrote:
> > With upcoming lock tracepoints config, it'd define some of lockdep
> > functions without enabling CONFIG_LOCKDEP actually.  The existing code
> > assumes those functions will be removed by the preprocessor but it's
> > not the case anymore.  Let's protect the code with #ifdef's explicitly.
>
> I don't understand why you can't keep the no-op stubs for
> CONFIG_LOCKDEP=n.

Because I want to use the lockdep annotation for other purposes.
But the workqueue lockdep_map was defined under LOCKDEP
only.  Please see the description in the cover letter.

https://lore.kernel.org/all/20220208184208.79303-1-namhyung@kernel.org/

Thanks,
Namhyung
