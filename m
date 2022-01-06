Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64E6D485E78
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 03:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344637AbiAFCMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 21:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344590AbiAFCMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 21:12:30 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B43C061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 18:12:30 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id p65so1417337iof.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 18:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5W541yeY6h9LNYAVYccCNegR//FDlKfP/cMfx3hCby4=;
        b=OHfcO0hte2b/JJQ0SX0kqIBY/AKNJns72B/KhFPLwlVcb18QqsE24bm7l29z5rIasZ
         4ukQA6ZstWcim5rngeiS5XZ2uaAjvMUm+Z6mk/4N0VIq7t8tRyQVaGQhAnG23R6h8lnN
         Ouef1uno4ptPNbtULx5RtOV9Zi2qUOfF4KMj2YJOYWy9VY30Ip2RyZvI/af7WLsAGG6a
         EnD5tG44u/6KA/GIXLzNy2X7V3Hw3+rwy1acttmaDfPEx9IPOpS0wXyrhsXAbsSyrJ+T
         XX1zurXXfrowmPEGunB1JQcTYwpTZ8fCeMKWhaux3b/3zIzCdGBTZfF4MNbT9Aj0JcAA
         l41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5W541yeY6h9LNYAVYccCNegR//FDlKfP/cMfx3hCby4=;
        b=Lm8ntgrFt4K2n7Os0pTwmWt/83LTQmHN/QMv8AsA+9bZ3/ZO+rKznnNBEg+21DxoNH
         ekXW4AwI1CuiWBWBVxIdJANUrGQY/6/zXBixOp4R9Bhx0HI7M3hXFKONRfFE6T4+ph/u
         kgb3bWvGLdesdgl/tqIlNQpzwxc7+CniIY6r7+ySn/7LT44XqCgOpubHU7ExgEo58z6P
         hi+fBoRi0OupvSjqx/P/MvkwJhrWeGKXuj2BgZcd5wOY++F8wkc1V4yCmy8YA7eZJldk
         p6ynD7PwgdsEtBvPiQ9/SCJiOLz3Ka7eeb312VdH3ZI1Lq4OUkmg48u6PRvdIFvCa8Tb
         IZaQ==
X-Gm-Message-State: AOAM5321uaRaSW31ZRZE6Pg0CiycyU6XLIH6IUbUCF/v32foZV6t0Xr2
        1f/fhDm5g3F1fDtDklKinbVG0NVPhedh/Rdp9yo=
X-Google-Smtp-Source: ABdhPJwNIjplCRMMZ2Ovig6LEfzS1YvVfgLu5PgmVCZpgA9wmgshGFVoD3YMuVarMaSPLnk9NEdtjHPJlJ2+l27nafQ=
X-Received: by 2002:a05:6638:16ce:: with SMTP id g14mr28703586jat.160.1641435149655;
 Wed, 05 Jan 2022 18:12:29 -0800 (PST)
MIME-Version: 1.0
References: <20211211150032.7568-1-xyz.sun.ok@gmail.com> <20220105141556.12fb2ceb@gandalf.local.home>
 <20220105142208.1dbc20cc@gandalf.local.home> <20220106073203.123c4f7e38cc07eccd02aa9b@kernel.org>
 <20220105181029.4fa08f6a@gandalf.local.home>
In-Reply-To: <20220105181029.4fa08f6a@gandalf.local.home>
From:   xy zhang <xyz.sun.ok@gmail.com>
Date:   Thu, 6 Jan 2022 10:14:00 +0800
Message-ID: <CABhjEnwRudygp49_GDwC3uKVCSvHsF2gLDXo3qHUqarOXiDsWw@mail.gmail.com>
Subject: Re: [PATCH] tracing/kprobes: 'nmissed' not showed correctly for kretprobe
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, mingo@redhat.com,
        oleg@redhat.com, namhyung.kim@lge.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ok, I will send a v2 patch later

On Thu, Jan 6, 2022 at 7:10 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Thu, 6 Jan 2022 07:32:03 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> > OK, this is a good catch :), but there are 2 issues.
> >
> > 1. kretprobe can be skipped by 2 reasons, shortage of kretprobe_instance which
> > is counted by rp.nmissed, and kprobe itself is missed by some reason (this
> > can be happen if KPROBE_EVENTS_ON_NOTRACE=n. Thus, better solution is to show
> > 'tk->rp.nmissed + tk->rp.kp.nmissed'.
> >
> > 2. the commit c31ffb3ff633 is not actual commit which introduce this issue.
> >   this was introduced by 4a846b443b4e ("tracing/kprobes: Cleanup kprobe tracer code.")
> >
> > 'git blame' tells you the commit which changes that line, but that can be just
> > a refactoring (renaming). I recommend you to search the correct one by 'git log -p'.
>
> Masami, thanks for the review.
>
> Xiangyang, can you please send a v2 with Masami's suggestions?
>
> -- Steve
