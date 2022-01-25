Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22EB449A868
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1318532AbiAYDGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3415997AbiAYBxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 20:53:55 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A29C046E37
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 16:31:17 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id m6so56671312ybc.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 16:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=93SQc4Tl/JWybIwI62dfNMnzDWuRQfWaA9+g/v1rj7M=;
        b=lsJekgDbRNlLuo/YxbZWVWXVamDLmOe4ov4KcsQXtoKeC9A6qzCOypbMjErscac52k
         L9hUF1ZObhuxBufOclO8I6V25tsedAOXQyKyxu6tgS8arOCphWj6QZigKEaN9vpr4k/6
         TOPXBNAVqURtWd7Gwi6IN4ueAnwNohjQ71IwXJcwV3WZBwqJOGvjNmqgX7caewkstyCP
         097fk3I17DKTgF0uaAkbE+l7Ymz5Oxv3NZmOGwHmuvJer8+mg+WoY3mCmVe63KU5pCww
         79Uc4d8MZENKw0qX7Orn570AMhDSSp+Z9gOXXs0N0SxUW5GBp5tQVqcp17GdQ290haEw
         az/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=93SQc4Tl/JWybIwI62dfNMnzDWuRQfWaA9+g/v1rj7M=;
        b=VQWA4QbCs1p8l+PW9LVy799HwdMnp1+KY143/RwPqpIDVE+Fw4YUShONoezCVFSfQV
         4/fYlOL8lJY5qAHyfuDYeRPZs6Sy+Z50XfLQTBAsvCEudvQdOOntX92a6U0Fn+v2zt2o
         JLr6RTF7HgRPyw8OqAcv8tu0v7Tji+Kg3dN8/zWeOIiiLGju4sW1qyNCRIcqQzZRXGmH
         /jLQC5lTgMuwipTc0aBf676OO66iRq1N+/hZyMbyXmPJ2ihkfrfiPMsO6OU2ITe3ylBE
         kbbBjxdeR3MEkJo8YEjftGvXLcNGndI7nOYMK8b1CmbUkW5p6eGsjHreHkvfWk3ruy5A
         O/Mg==
X-Gm-Message-State: AOAM530XTB+aITJBmpfJykE7BbaCAqB3QFfNuv5mO5BhO3EAqWTCHdul
        Kym5nEbuVVBNPg101xgMGLa2VZF69/BXorq1p51e6uzoNAuUTw==
X-Google-Smtp-Source: ABdhPJzs0cTkYj0j3B+cYgCXNhFbR9tmvMzmtySH3aKbceEYTXHZ9j5Hut9O0cVbohLq2c4MqiITaN3vzm5st35vLis=
X-Received: by 2002:a05:6902:1244:: with SMTP id t4mr702006ybu.192.1643070676164;
 Mon, 24 Jan 2022 16:31:16 -0800 (PST)
MIME-Version: 1.0
References: <20220124105247.2118990-1-brauner@kernel.org> <20220124105247.2118990-3-brauner@kernel.org>
In-Reply-To: <20220124105247.2118990-3-brauner@kernel.org>
From:   Josh Don <joshdon@google.com>
Date:   Mon, 24 Jan 2022 16:31:05 -0800
Message-ID: <CABk29NtFnswO3iaQobbijV1-FwCJd06prm2UMq7S8Tt736hYMA@mail.gmail.com>
Subject: Re: [resend RFC 2/3] sched/prctl: add PR_SCHED_CORE_SHARE command
To:     Christian Brauner <brauner@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Chris Hyser <chris.hyser@oracle.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Balbir Singh <sblbir@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Christian,

This seems like a reasonable extension of the interface to me.

> @@ -200,6 +212,20 @@ int sched_core_share_pid(unsigned int cmd, pid_t pid, enum pid_type type,
>                 __sched_core_set(current, cookie);
>                 goto out;
>
> +       case PR_SCHED_CORE_SHARE:
> +               rcu_read_lock();
> +               p = task_by_pid(pid_share);
> +               if (!p)
> +                       err = -ESRCH;
> +               else if (!ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS))
> +                       err = -EPERM;
> +               if (!err)
> +                       cookie = sched_core_clone_cookie(p);
> +               rcu_read_unlock();
> +               if (err)
> +                       goto out;
> +               break;
> +

Did you consider folding this into SCHED_CORE_SHARE_TO? SHARE_TO isn't
using the last arg right now; it could use it as an override for the
task we copy the cookie from instead of always choosing 'current'.
Since the code currently rejects any SCHED_CORE prctl calls with a
non-zero last arg for commands other than SCHED_CORE_GET, this would
be a safe change for userspace.
