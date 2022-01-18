Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F71492E55
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 20:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348675AbiARTTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 14:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348572AbiARTTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 14:19:00 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B512C061574;
        Tue, 18 Jan 2022 11:19:00 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id h11so49513uar.5;
        Tue, 18 Jan 2022 11:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RTtIokhsxNEKlwhkarhww6LL6UsgKRiayY8jPQeBEwY=;
        b=CTc9C58WpPdD8FXdGRlcnMWrMWNJpcK+y6Rj3zUyCWdwt9dQLqWVsqH1YHBewi6eXG
         TVXL54as5+fZwnP5csySA8G7bCIvcyKPvSiBUd+GrWLEV+MZfzm3C4f+itk1QZftidvg
         LJKU6yzS78/172cHFHccKLpzMhmscJwEjItec7F5xI6diRS+I880mydn8KGrrmaZceV3
         OZpCa9+CVwLnOjxUXVk7D8b0ObU0FO6PXWZJzdcxd8vNgfrVV11NYRvHxRLgRlTLBo4O
         Q0GLzBjotcSVxS8uqcxrk7IdG3QZri13dV+SSWWoVMHq30Z5wrhXzlDreWg6/pjBsKOo
         1Ffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RTtIokhsxNEKlwhkarhww6LL6UsgKRiayY8jPQeBEwY=;
        b=SjiRieCy84PugHVrcx4HX8psPdu2wAC3Jpm/wt7SBgM9pMhKmSh9iyWiimIjpwDxrU
         Z8AI7Rd3LQvnaTmv4ItZElZFf/brBpZGqZy+zFSrfCEVB02snN6nI2CO+DV63EEGRivC
         ErbZ5NZXNJkroaBx0yrOvyTNh/7H7xR1/zMwJDZceRAZU1hwriyEsRfvjNbLofeYxCQh
         egHSIOKAarePtTNd+MWsPwIw5Cx7/siogAMKJqfKj9VdCYq3qqNmb7nlG5DwDz3zOTFy
         5ddYxm8/nGUb2nA/9K1E8TpNYfYRiTGhahuJv749uQtMkpXKr5wcCmhwH5z4VAIAbqxn
         62jg==
X-Gm-Message-State: AOAM532CnIIRu4mYOXBh7rXlD0MoonQQ/krEVxV7j5+2x+uDLF2pVclE
        LeAb3WE6KV95N8tDvQjCG1p4xgwXekduOg5nuH0=
X-Google-Smtp-Source: ABdhPJxgTCdC9Z6jpp7wLDECuwoHlNTebzLVe83RZmXf5Re5kCwIRrubG/CS+W1/249WqUYsva2FLP9+ncT0xjegJbI=
X-Received: by 2002:a67:d903:: with SMTP id t3mr5929684vsj.42.1642533539591;
 Tue, 18 Jan 2022 11:18:59 -0800 (PST)
MIME-Version: 1.0
References: <20220107052942.1349447-1-jim.cromie@gmail.com>
 <20220107052942.1349447-4-jim.cromie@gmail.com> <20220114114654.GA23983@axis.com>
In-Reply-To: <20220114114654.GA23983@axis.com>
From:   jim.cromie@gmail.com
Date:   Tue, 18 Jan 2022 12:18:33 -0700
Message-ID: <CAJfuBxxKQK+X-5LW=ysPU-4mP25BnuCNxvo4xg-SgPwQsr7kXw@mail.gmail.com>
Subject: Re: [PATCH v11 03/19] dyndbg: add write-to-tracefs code
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     "jbaron@akamai.com" <jbaron@akamai.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "robdclark@gmail.com" <robdclark@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_saipraka@quicinc.com" <quic_saipraka@quicinc.com>,
        "will@kernel.org" <will@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "quic_psodagud@quicinc.com" <quic_psodagud@quicinc.com>,
        "maz@kernel.org" <maz@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 4:46 AM Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
>
> On Fri, Jan 07, 2022 at 06:29:26AM +0100, Jim Cromie wrote:
> >

> > Enabling debug-to-tracefs is 2 steps:
> >
> >   # event enable
> >   echo 1 > /sys/kernel/tracing/events/dyndbg/enable
> >   # callsite enable
> >   echo module foo +T > /proc/dynamic_debug/control
> >
> > This patch,~1,~2 are based upon:
> >   https://lore.kernel.org/lkml/20200825153338.17061-1-vincent.whitchurch@axis.com/
> >
> > .. with simplification of temporarily reusing trace_console() rather
> > than adding a new printk:dyndbg event.  Soon, add 2 new events
> > capturing the pr_debug & dev_dbg() args.
>
> The example above does not match the code in this patch since the
> dyndbg:* events are only added in a later patch.  Perhaps you could
> reorder this patch stack so that you don't use trace_console() in this
> patch just to replace it with the new events in the next patch?
>

good catch, thanks.
Ive just dropped the example, it seemed the simplest fix.
It seemed proper to commit your code as pristine as practical,
so that subsequent mistakes receive the blame.

and Ive fixed the spurious whitespace change you noted.
