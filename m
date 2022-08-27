Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE625A3357
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 03:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238664AbiH0BKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 21:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbiH0BKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 21:10:12 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC6A4B4B2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 18:10:07 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id s5so1136724uar.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 18:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=aiXjSA13WPgAPgKh7tM/zQRSomp+DQxma2fUgKyiYTA=;
        b=CHH3TpYZeHHoZQo5vDtO9cBAcWR65YEtTcknzN0diMBVDU1hE0wx6nWmfYLGO5qdiC
         4Int3FfaTf8w9EkJ10zfxlXAaUP4ltDsgASxownP57CEsSdM1OPwAVHMUzDMtZRFjWM4
         JWYz+sKeGH7giVNC2G2e/4L8yxEnoAlgqKhtLvTMorEbJKfSSkATO96mL+AIaSo/kqO4
         2Sc5I8Knt5bRnIFwLxOx2yfYlkRHvgc3UukD/JG2/7doElBXcn5uwAO4Rm811aeRogW+
         7dZDCueKUFE/iOypt6y+qfhCYBMPMMHT2tE/sIhHlJS9lSLtKNoMFB+uLDIVqv+6WKCC
         YOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=aiXjSA13WPgAPgKh7tM/zQRSomp+DQxma2fUgKyiYTA=;
        b=5F1LWWlcmIe7EaDk8iEomzdtKg3sPq8R4OwZYNl03003KMT6SpVvSGvD5860r8b60O
         dG5fCB9vzaYPWR7w4GuuZAJJRuf7PHOFHOPrqpgC5eQrofSzjEdtxGeryMxltonJXenC
         2vee3yrUQbE09kUDp2PP6bQ6ttIW9PcvBDz0b7GsacwvWyI4Bk6VFLZ/cNAgKbZilZr4
         M9Ob69ww+Uyq4w2BcM/Hg9XxBAbaKAGPAfVXmhboLOiqRHTe+Z2qMwEQ/N5W1XVYkJfc
         qSIO+zIj4B3d0TPMM5j/4Cyplin3WPujTR7Q2P/97DxwSpttwfPdrg+oEfQArqrK3rpq
         Kg6A==
X-Gm-Message-State: ACgBeo0png6dMn+BtBdJzqUQcAA1D/IDbc7STbnSEBivwKwR+3Cc7Oia
        ytBmim0z5mpUIcTaeRil8P9hfhMN5g56OIX4GxQJHA==
X-Google-Smtp-Source: AA6agR48YHpjMmVrgshnD9gYygPhOH6EkRxMkk7dzB/R5x4NHW8gOjjrhmAjH66vLnRPNSgwRWbmq3VRTI7OQWx8UKw=
X-Received: by 2002:ab0:14ad:0:b0:39f:255c:2ea9 with SMTP id
 d42-20020ab014ad000000b0039f255c2ea9mr756082uae.52.1661562606818; Fri, 26 Aug
 2022 18:10:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220826223511.170256-1-alison.schofield@intel.com> <Ywle+96kZr5Y6Kn/@aschofie-mobl2>
In-Reply-To: <Ywle+96kZr5Y6Kn/@aschofie-mobl2>
From:   David Gow <davidgow@google.com>
Date:   Sat, 27 Aug 2022 09:09:54 +0800
Message-ID: <CABVgOSkdXPw3yx=J+=YLxgu=0kpBGD5MvPJr0=_VO4jgrSBpPw@mail.gmail.com>
Subject: Re: [PATCH] tracepoint: Allow trace events in modules with TAINT_TEST
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 27, 2022 at 8:02 AM Alison Schofield
<alison.schofield@intel.com> wrote:
>
> + David Gow - Submitter of the new taint type
>
> On Fri, Aug 26, 2022 at 03:35:11PM -0700, alison.schofield@intel.com wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> >
> > Commit 2852ca7fba9f ("panic: Taint kernel if tests are run")
> > introduced a new taint type, TAINT_TEST, to signal that an
> > in-kernel test has been run.
> >
> > TAINT_TEST taint type defaults into a 'bad_taint' list for
> > kernel tracing and blocks the creation of trace events. This
> > causes a problem for CXL testing where loading the cxl_test
> > module makes all CXL modules out-of-tree, blocking any trace
> > events.
> >
> > Trace events are in development for CXL at the moment and this
> > issue was found in test with v6.0-rc1.
> >
> > Reported-by: Ira Weiny <ira.weiny@intel.com>
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---

This seems fine to me: thanks for catching it. Test modules should be
safe enough to load for this.

Does the comment in tracepoint_module_coming() need updating as well?
https://elixir.bootlin.com/linux/v6.0-rc2/source/kernel/tracepoint.c#L650

Regardless, this is
Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

> >  kernel/tracepoint.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> > index 64ea283f2f86..5f17378c9dc2 100644
> > --- a/kernel/tracepoint.c
> > +++ b/kernel/tracepoint.c
> > @@ -571,7 +571,8 @@ static void for_each_tracepoint_range(
> >  bool trace_module_has_bad_taint(struct module *mod)
> >  {
> >       return mod->taints & ~((1 << TAINT_OOT_MODULE) | (1 << TAINT_CRAP) |
> > -                            (1 << TAINT_UNSIGNED_MODULE));
> > +                            (1 << TAINT_UNSIGNED_MODULE) |
> > +                            (1 << TAINT_TEST));
> >  }
> >
> >  static BLOCKING_NOTIFIER_HEAD(tracepoint_notify_list);
> >
> > base-commit: 4c612826bec1441214816827979b62f84a097e91
> > --
> > 2.31.1
> >
