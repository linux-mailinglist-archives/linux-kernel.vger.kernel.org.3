Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEE14AE456
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387646AbiBHW2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386423AbiBHU3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 15:29:46 -0500
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0EFC0613CB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 12:29:45 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id j14so552176lja.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 12:29:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=atITRJU41fTqhaKxq/8QmwHxREfuvI3xR+qm2eVMnVQ=;
        b=0bUOwReI0gSml+ChpQdxxTSWHRdQ7qc283IRrAk3ea4im0CKEu735qtQT1VqwdpqsJ
         fP95H/4G0UmsfxxG8SI1ZMmVOKaX8MqNzz48CP+qdiR8Q/EzoC25HuHgYFhn2H78bCHk
         UTtAFfJGGEjugjO02gM62/CxEi2QjiisKQrxwOvwA9QzaHcTr+xNubaBuUx/kHH6xe1e
         709BjOvV82qgtnrXg1XEWOVjpAeoNjapOvEK/fIJ41x/LHqSROXTspmk24qApeWR7AbW
         MipeRUDI1vrZJ6kV+KaEaabzDEahYro5w30FuOnY8e+ujMFVWMKmnsQVtieixTB53OS4
         i3mA==
X-Gm-Message-State: AOAM533M1cdo5HywNdfLsuoul43cfqyLWdvFoT9bSWOZuQkSOliiN9Rb
        Y5JL5/lDBn1A0l5CJ+WoRfl6oQ1OEH0Zm1BsYvw=
X-Google-Smtp-Source: ABdhPJw8tE/avmlvMaM7ky0xK80KvTDExwZg5JqDe5vk5pEjZ+1CjWB5CQ168CO0yoAgdS/6yZg+tfOczu5dXOWSlTk=
X-Received: by 2002:a2e:7219:: with SMTP id n25mr3651814ljc.204.1644352183755;
 Tue, 08 Feb 2022 12:29:43 -0800 (PST)
MIME-Version: 1.0
References: <20220208184208.79303-1-namhyung@kernel.org> <20220208184208.79303-4-namhyung@kernel.org>
 <20220208143641.7850bbc6@gandalf.local.home>
In-Reply-To: <20220208143641.7850bbc6@gandalf.local.home>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 8 Feb 2022 12:29:32 -0800
Message-ID: <CAM9d7cgdauVW+HdpQS_FNG4e3SRR1JP74N1Z-SX+hXZ-yDM5DQ@mail.gmail.com>
Subject: Re: [PATCH 03/12] timer: Protect lockdep functions with #ifdef
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Byungchul Park <byungchul.park@lge.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Radoslaw Burny <rburny@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
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

Hi Steve,

On Tue, Feb 8, 2022 at 11:36 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue,  8 Feb 2022 10:41:59 -0800
> Namhyung Kim <namhyung@kernel.org> wrote:
>
> > With upcoming lock tracepoints config, it'd define some of lockdep
> > functions without enabling CONFIG_LOCKDEP actually.  The existing code
> > assumes those functions will be removed by the preprocessor but it's
> > not the case anymore.  Let's protect the code with #ifdef's explicitly.
>
> I wonder if it would be cleaner to have another macro name for these
> locations to keep out the ugly #ifdef in the code.
>
> lockdep_init_map_raw() ?

Yeah, I like that..  Then I also need to add the _raw variants
for acquire, release and so on.  Is that ok?

Thanks,
Namhyung
