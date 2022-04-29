Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02EBE515390
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 20:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379989AbiD2SYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 14:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379953AbiD2SYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 14:24:06 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F274E51E52
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 11:20:47 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id y38so7584786pfa.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 11:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wslry1R5bdUpJUavzlBpF5vlXqV0PAn4Lq3cXrzKpPY=;
        b=FmCks5NcpzpThewGRhqXd390ERLh+Ej3sl/zL7F2La/EKtFEj+O6ipQDuzfWBjJVvc
         UQ7134+lqi2v0KtVDCKkohCbeHBwcHpqPyDxFGpwyxmI9EjUiv7ScFctGMSzUOYkvQBN
         7ZfBmB/5I6eX3og6wAC1PklxmvEEI13+UhJzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wslry1R5bdUpJUavzlBpF5vlXqV0PAn4Lq3cXrzKpPY=;
        b=ajN0kqTwjn4e8y9VNsW0bt6gCHB0H6Ag6OmDv1DDMGcsjVGnI7xa21Dcuq6AQrwE6+
         zWzC32lyqBOaPNNVm10oQb67q9JUygILjc8Mo7ZHfA7XxUpO9ffebXViK79CIm40Bc7I
         2K3OtVxFItVYLbnDDrCpb2MK0EMnHneZ1Kf1UyPFW3mvg76pVnoTngzWE/fXOXnSVQN3
         jrh0fMXVhqrpZj8A92TmPr1RuZzbh+n9PbyI/h0EhS8SmmggMVhbMdYU7ehG9vXJME5D
         I4/lJUlTMfhPfrgiGxB/C48af7q+GCjrN645KIRZPQoVvyvAVJUdbP7Y0WDLM4UCJD7K
         PjFQ==
X-Gm-Message-State: AOAM5308y1yR9u2ib4Ox3FG9sMX2cEy0a769HU/vJwLfR8vq7ceof4bO
        LvmjOTwqCVf/j1lc2GEfE5tHhA==
X-Google-Smtp-Source: ABdhPJx4rNrDd2yoQUGY47nYl8Nqg+8LDGgJFTSrthoyKbJguRDIjFWd5ndLhqs6MjPCWKyjHh5CRA==
X-Received: by 2002:a65:62d0:0:b0:381:d38:c7b0 with SMTP id m16-20020a6562d0000000b003810d38c7b0mr519075pgv.186.1651256447529;
        Fri, 29 Apr 2022 11:20:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 1-20020a17090a1a0100b001dbe11be891sm6170057pjk.44.2022.04.29.11.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 11:20:47 -0700 (PDT)
Date:   Fri, 29 Apr 2022 11:20:46 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Rodrigo Campos <rodrigo@kinvolk.io>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Will Drewry <wad@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Alban Crequy <alban@kinvolk.io>
Subject: Re: [PATCH v3 1/2] seccomp: Add wait_killable semantic to seccomp
 user notifier
Message-ID: <202204291120.428EB85@keescook>
References: <20220429023113.74993-1-sargun@sargun.me>
 <20220429023113.74993-2-sargun@sargun.me>
 <CACaBj2bW8XkENHoLNXEprQ_d8=_aLT_XQdjCZtSOiPJis8G_pQ@mail.gmail.com>
 <20220429171437.GA1267404@ircssh-3.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429171437.GA1267404@ircssh-3.c.rugged-nimbus-611.internal>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 05:14:37PM +0000, Sargun Dhillon wrote:
> On Fri, Apr 29, 2022 at 11:42:15AM +0200, Rodrigo Campos wrote:
> > On Fri, Apr 29, 2022 at 4:32 AM Sargun Dhillon <sargun@sargun.me> wrote:
> > > the concept is searchable. If the notifying process is signaled prior
> > > to the notification being received by the userspace agent, it will
> > > be handled as normal.
> > 
> > Why is that? Why not always handle in the same way (if wait killable
> > is set, wait like that)
> > 
> 
> The goal is to avoid two things:
> 1. Unncessary work - Often times, we see workloads that implement techniques
>    like hedging (Also known as request racing[1]). In fact, RFC3484
>    (destination address selection) gets implemented where the DNS library
>    will connect to many backend addresses and whichever one comes back first
>    "wins".
> 2. Side effects - We don't want a situation where a syscall is in progress
>    that is non-trivial to rollback (mount), and from user space's perspective
>    this syscall never completed.
> 
> Blocking before the syscall even starts is excessive. When we looked at this
> we found that with runtimes like Golang, they can get into a bad situation
> if they have many (1000s) of threads that are in the middle of a syscall
> because all of them need to elide prior to GC. In this case the runtime
> prioritizes the liveness of GC vs. the syscalls.
> 
> That being said, there may be some syscalls in a filter that need the suggested 
> behaviour. I can imagine introducing a new flag
> (say SECCOMP_FILTER_FLAG_WAIT_KILLABLE) that applies to all states.
> Alternatively, in one implementation, I put the behaviour in the data
> field of the return from the BPF filter.

I'd add something like the above to the commit log, just to have it
around.

-- 
Kees Cook
