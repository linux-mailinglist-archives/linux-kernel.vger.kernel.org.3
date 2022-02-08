Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001BC4AE215
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 20:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385928AbiBHTRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 14:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344205AbiBHTRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 14:17:42 -0500
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917F6C0612C1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 11:17:41 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id e17so301236ljk.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 11:17:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4gTR/DRBE1sGBEwT+HvXaNZTxI8T8ZgTIn7NruLKD2M=;
        b=N8KOaSElYIdNTCWILwJF3Lff51V8hNgJBMZUMLi3POCJbZeXpC54du1VgZx9UchT5W
         w8Yg+yVLjOIUvHMl3u25wSe9nCFvu/PoRTcOST7Kt67F5h23CMIYrOmGLVzv+a6vbiui
         b6o3W67PBSR7S8rjo3/AsseAX92O44Az/S2Iokv1dfaWBxfQNoTTd+h6sGFP9Ip0/tfP
         iI/O9XNUJ/BBkI+WB45EDQP+w7671m4/Hf38R7c1XS5QTH/IpjrrzwFlVodYXzEn81Be
         Se9FTs6z4BfIucMlWwzr+5gKwZ4b3b5cBPV7AGnTtfcyAP3xE/XGKo6jmdBZC7QEPsA+
         txTg==
X-Gm-Message-State: AOAM531Q0AaPNBfOpqJpefmWDn75Fibu2AqbTd+/dRS8zPhnSPcZQ2NH
        Omqw5J7VGvbd/BOcFbxEYBEqsxJjRcWh0KIWJn4=
X-Google-Smtp-Source: ABdhPJwJ85uHhDxHa1Kblk5KPrjR6y3KnQMEUgL2BIfELGuTjhVAUFGc38I0J800j3Ln33YUb8bDmA0dNmv3sUIlPpE=
X-Received: by 2002:a05:651c:a04:: with SMTP id k4mr3758516ljq.180.1644347859917;
 Tue, 08 Feb 2022 11:17:39 -0800 (PST)
MIME-Version: 1.0
References: <20220208184208.79303-1-namhyung@kernel.org> <20220208184208.79303-5-namhyung@kernel.org>
 <YgK67dQabIMam8nc@slm.duckdns.org>
In-Reply-To: <YgK67dQabIMam8nc@slm.duckdns.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 8 Feb 2022 11:17:28 -0800
Message-ID: <CAM9d7ciswwMSdXhmsJbuf2jtrkUo=EXbYiWc2ZjA2PVPJz5rpw@mail.gmail.com>
Subject: Re: [PATCH 04/12] workqueue: Protect lockdep functions with #ifdef
To:     Tejun Heo <tj@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paul.mckenney@linaro.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Radoslaw Burny <rburny@google.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
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

On Tue, Feb 8, 2022 at 10:48 AM Tejun Heo <tj@kernel.org> wrote:
>
> On Tue, Feb 08, 2022 at 10:42:00AM -0800, Namhyung Kim wrote:
> > With upcoming lock tracepoints config, it'd define some of lockdep
> > functions without enabling CONFIG_LOCKDEP actually.  The existing code
> > assumes those functions will be removed by the preprocessor but it's
> > not the case anymore.  Let's protect the code with #ifdef's explicitly.
> >
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>
> Can you wrap them in inlines and add some comment?

Ok, will do.

Thanks,
Namhyung
