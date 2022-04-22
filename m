Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF7E50BD3D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449767AbiDVQlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244740AbiDVQk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:40:59 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47625EDE1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:38:05 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id d3so5367158ilr.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ex8Ac6t4IC/CcdfgDoOsXQjs2IkSPswG9D7lBtUum84=;
        b=f7HE4sJHt5AarQXH3mU+D3R+kG1lGhqSLZBtdjAf0EHeAglvh8bhx6zCceZieUAAhO
         msBSJcHbpUgozTcJtsciOPQCBP1Fn6hPjFOgPNrokVLp698DujRnFeZIjy6goBjpAbBt
         5j8QJVYI/cIg4VXc6Vm1TxbZYmXMbc2Vut733QtVGoDNP34xMExpuiXwQxgw2Aec2WIF
         goP/gKOiWmXRLZ+/swCglBYPZGi5+2rYJzNivajgoyxpGhfPNz5pP5LqtKy5rdUOsPqh
         Unvcbs74VT8ZQvWEAnIg/gm9QQzdwtn/wqfg38FOFw2FV916mxokrFSpEVhvnZRQTtUv
         1++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ex8Ac6t4IC/CcdfgDoOsXQjs2IkSPswG9D7lBtUum84=;
        b=xYKOEJahfbRJ6SGAnRktikMUiO+9ZPMEOk77Y77bPTPNijQHmEs93hK7cfBwCXHExh
         YzDAi7WChusZaq69DjvKB4UG5bTj+pWMQ2YeVvFA1Me0/WvqMQF9P79r0LIPU0K/6E5o
         LGmby+HiZ9YlWwAK0GSKVS7n2jF2CZrAhHvMDWnh9Rr6+f6x60xnSKzkI4RrvVEjQIGv
         jC31lgFycZcecE+1LJmqcbF/k0GZEZaPVeDOVQ9jXc332/h25PjwxP/NahlZHJ3OK1I7
         dgfxKlhIsUpsnjCADpkyb1oka730qPgO6Fm6XR1RVVGEGkai7cy7AI122bounhtjAyWx
         yVXw==
X-Gm-Message-State: AOAM533H/Abdl9rMKjRLu/vqVojsW0YaCzbedIGj0JUELCyArhDFL5qm
        snTEJDhgVW2uDv23AG6CbrhYfRt0qQR4V36AOkI=
X-Google-Smtp-Source: ABdhPJwyNz+wO0aoycoPyyTuvfxTG6pCUw34HumAn2M/Y4i6PvZ9xj8uVxlJZSJrLZHzw5yEaF/tOCorN5VhYRuHUsM=
X-Received: by 2002:a92:6406:0:b0:2bb:f1de:e13e with SMTP id
 y6-20020a926406000000b002bbf1dee13emr2271828ilb.305.1650645485158; Fri, 22
 Apr 2022 09:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220120162520.570782-1-valentin.schneider@arm.com>
 <93a20759600c05b6d9e4359a1517c88e06b44834.camel@fb.com> <20220422110903.GW2731@worktop.programming.kicks-ass.net>
In-Reply-To: <20220422110903.GW2731@worktop.programming.kicks-ass.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 22 Apr 2022 09:37:54 -0700
Message-ID: <CAEf4BzaEcjOC9gG6rCs95JK==ONV3aYhbQay9o9Liw8apE1HXQ@mail.gmail.com>
Subject: Re: [PATCH] sched/tracing: append prev_state to tp args instead
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Delyan Kratunov <delyank@fb.com>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Kenta.Tada@sony.com" <Kenta.Tada@sony.com>,
        "adharmap@quicinc.com" <adharmap@quicinc.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "legion@kernel.org" <legion@kernel.org>,
        "ed.tsai@mediatek.com" <ed.tsai@mediatek.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 4:09 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Apr 21, 2022 at 10:12:25PM +0000, Delyan Kratunov wrote:
> > Hi folks,
> >
> > While working on bpf tooling, we noticed that the sched_switch tracepoint
> > signature recently changed in an incompatible manner. This affects the
> > runqslower tools in the kernel tree, as well as multiple libbpf tools in iovisor/bcc.
> >
> > It would be a fair amount of churn to fix all these tools, not to mention any
> > non-public tools people may be using.
>
> So on the one hand, too bad, deal with it. None of this is ABI.
>
> > If you are open to it, here's a
> > description and a patch that moves the new argument to the end,
> > so existing tools can continue working without change (the new argument
> > just won't be extracted in existing programs):
>
> And on the other hand; those users need to be fixed anyway, right?
> Accessing prev->__state is equally broken.
>
> Yes, the proposed hack is cute, but I have very little sympathy for any
> of this. These are in-kernel interfaces, they change, there must not be
> any impediment to change.
>
> If bpf wants to ride on them, it needs to suffer the pain of doing so.

Right, none of this is ABI and BPF users community is prepared to deal
with this, no one is claiming otherwise. And we did deal with __state
field rename already, see [0] for one example.

This function argument reordering is much harder to deal with in a
"contained" way like we did it for __state rename, unfortunately. So
given it doesn't have to require so much work for multiple people to
work around and is just a simple reordering of arguments to add a new
argument at the end of a function prototype, is there a big downside
to doing this?

  [0] https://github.com/iovisor/bcc/commit/8b350fd51b004d4eddd7caa410e274e2807904f9
