Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE86E48D101
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 04:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbiAMDj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 22:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbiAMDjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 22:39:25 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CD0C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 19:39:24 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id l15so8656430uai.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 19:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yk7hr+8mozE34Qnh4GjZFonAE1UwnnupqqiEwnAP2IM=;
        b=aFRgaK1srflnCKthKFhp6SuO3pnOXmrdxi/5QCvVMysDFTJeHRGK0fhrztgAmXWg+n
         zQPZdHWz4quQ822jhts9BBgh8ZdqCc2mYHHQhMLeeoKWTpZm8jzcOv7vA4i7nAJ1sYd5
         m1aC6Hw7A3vwokmLAKumdKEKOJj+FpA0uPxs3N18H23XtJmawuS+mx4njlwefG3dy3HX
         9YrpB8n1of5eLgfRLDjhGzdBqXIkUko3kGAyhZvGgOFolTqR37EcjsX9yUBhC4s3rAZ3
         3vL4/cXJqn9T7nt5xKOSUZJTzh7Z75nvnvIoBsIIISNGYlGnl7roiU3jzlvzwmATWL8V
         U8Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yk7hr+8mozE34Qnh4GjZFonAE1UwnnupqqiEwnAP2IM=;
        b=ItlNKq+SZf8w+0O4ruArUX3tbMNEJFK0zIk3stbQKBzHDFzptUihIk9i0NkCoOwbKY
         g5m/eGzrvbbRgJPpqdSJneVlPvDeOtHzFTizo7lkl73nL6iQaqOJMRFPCUOJg1WjmRqa
         lUAgBQReMhrTBVjsJx/kjoVb4ZZg/NHSmZDx2xpDzykXCGecP3/XSaQquIjTgCrWOtVg
         YwOMWJzM9sAGgk0Q4kPSZ37vJyDAaf0eqgvs5+fAK4ROSPuh6JhmueybJdkjTK1c5OYY
         gpHtcwsExEcmOa+U5lUlvq35Yx8g5pERgj/QINNpas7kriowWqp/+OKzb55ztSaGMI2v
         3MpQ==
X-Gm-Message-State: AOAM531Kwg5rrX2ksM4CHHqT2Fbx5RWxgZA/Z7VLbdeysLfGQzzPZ0ZU
        5W739WgZRSemwvHmkrH/3ZeFpdPJh/zPt/TncZKPBM6rpsQ=
X-Google-Smtp-Source: ABdhPJy6PhUA/3Kp5Ifvt3ziMCAty9gs2W52PAuyvf/RcUSg2BHoMHZGKV4bPawNL04S4wwrXNNstvfqrPcQIDQ8pfI=
X-Received: by 2002:ab0:5e81:: with SMTP id y1mr1438657uag.23.1642045163804;
 Wed, 12 Jan 2022 19:39:23 -0800 (PST)
MIME-Version: 1.0
References: <20220111143046.14680-1-pmladek@suse.com> <20220111143046.14680-2-pmladek@suse.com>
 <996a7cf5-b047-5038-c86b-f10820364465@rasmusvillemoes.dk> <Yd7Fq6V1/Ynff6Qx@alley>
In-Reply-To: <Yd7Fq6V1/Ynff6Qx@alley>
From:   jim.cromie@gmail.com
Date:   Wed, 12 Jan 2022 20:38:57 -0700
Message-ID: <CAJfuBxzKZYBf_CGzHGjL_Jn2M=x_NH_j89kFX2UGxr8Sr4=fVw@mail.gmail.com>
Subject: Re: [RFC 1/2] printk/dynamic_debug: Remove cyclic dependency between
 printk.h and dynamic_debug.h
To:     Petr Mladek <pmladek@suse.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Chris Down <chris@chrisdown.name>,
        Marc Zyngier <maz@kernel.org>,
        Andrew Scull <ascull@google.com>,
        Will Deacon <will@kernel.org>, Jason Baron <jbaron@akamai.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jessica Yu <jeyu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 5:12 AM Petr Mladek <pmladek@suse.com> wrote:
>
> On Tue 2022-01-11 17:01:35, Rasmus Villemoes wrote:
> > On 11/01/2022 15.30, Petr Mladek wrote:


> > >  static inline int dynamic_debug_exec_queries(const char *query, const char *modname)
> > >  {
> > > -   pr_warn("kernel not built with CONFIG_DYNAMIC_DEBUG_CORE\n");
> > > +   /* Use raw _printk() to avoid cyclic dependency. */
> > > +   _printk(KERN_WARNING "kernel not built with CONFIG_DYNAMIC_DEBUG_CORE\n");
> > >     return 0;
> > >  }
> >
> > And for this one I think the solution is even simpler, as I can't find
> > any in-tree callers. Perhaps just nuke it entirely?
>
> Adding Jim into Cc whether he still has any plans to use this API.
>
> Best Regards,
> Petr

This EXPORT can go.

For the user I envisioned, DRM, Ive done it with a callback
provided by dynamic-debug, which maps bits in __drm_debug,
to calls to ddebug_exec_queries, without the export.

https://lore.kernel.org/lkml/20220107052942.1349447-19-jim.cromie@gmail.com/

This seems like a narrower/tighter interface,
and readily repeatable for other users, should they emerge.

Id welcome your inputs on the whole patchset.
Rasmus, I extend your Factory macros to add a .class_id
and use them to wrap __drm_dev_dbg etc

thanks
