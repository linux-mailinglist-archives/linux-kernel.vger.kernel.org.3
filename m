Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B6755CFF4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242274AbiF1Aco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 20:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240417AbiF1Acl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 20:32:41 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247B211C39
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 17:32:40 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id fd6so15331464edb.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 17:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8Q3mnW84jUqdgpykLDoSX2GKb3HxOWqoNxuuDWEfYTk=;
        b=aN8n/Ewk6msXQ/9qK+grUusqgi+DBFsyTdUqs+HaoMooD4AgjAqtDrFjAqFuNJCLmT
         vgQfk8zmvnDI4+T/yJhYyvj6uveVJhrnAP/rfXNsxSBKv19ZW7leWtr1ToERksnD7NBF
         kuy/+nPGZYkJOGigjxJNMbCyFk/Dc9bJhyugH4FYNPQaTFsmlKabASzJ1CYkey1rkqtL
         RqOkFCrRTpHOIFxklgG7LJrOKsjX4MiEH55eZCdbw4uGvkgMOQzZVxTwLANMkp83BheC
         2XLgmfqezKJ9HFVcjWHANJxx/kpoOqr310uFVy96m6SW8/MUA1iYN6L+O2Z9JmR+2YMU
         hS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8Q3mnW84jUqdgpykLDoSX2GKb3HxOWqoNxuuDWEfYTk=;
        b=I0jQCzasDFCKBGD58/rwk2mqIE11kd7LI4rhGzrdqjTcBcOo5A7x8RNr3QMFMc3sNb
         Nz9IhCY/gJOZidAGjyDbYfTsvgd0Skzp478pq7rr1bynvl0tc4qdphaoqKZ3sFFHLw6m
         /j+Hu+5g8LZJtmDamoTqkP7QxSWv1oYh/f1ftojl32eJqMAlRRnw3hxGbvvgZTTV5RTd
         LZ1HzNlT2nrA6kXNYXThmDSgq5Ew+Qnd6OmWZ1uHyT26xMDgCzZ6wANSEYJ3J8hpEFL8
         DF4TKNVGZ7rttpV6Hw9PpQlg8NuvWfzQDSp4dcGdc9NmgrXFCQDMNg9RJfmFcHWpMjHD
         /r1g==
X-Gm-Message-State: AJIora8WhClJOkKAkYUzzJ3ZB79wRrG98iWQXJufAvIFmo+Np/EMcbwn
        sc2ysOnZTnznNYDdGnxjIYJW
X-Google-Smtp-Source: AGRyM1tqCn8Fe1/4bgFm3vpkdRdORJ78GjESczmpnULUOJh4m6d3ktzRSG2FQW8G5SvIYFHeUACdTw==
X-Received: by 2002:a05:6402:510b:b0:437:28b0:8988 with SMTP id m11-20020a056402510b00b0043728b08988mr20709681edd.260.1656376358509;
        Mon, 27 Jun 2022 17:32:38 -0700 (PDT)
Received: from google.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id i13-20020a170906444d00b00722eeb368cesm5652978ejp.64.2022.06.27.17.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 17:32:37 -0700 (PDT)
Date:   Tue, 28 Jun 2022 00:32:33 +0000
From:   Wedson Almeida Filho <wedsonaf@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tejun Heo <tj@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <brauner@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 3/3] kthread: Stop abusing TASK_UNINTERRUPTIBLE
 (INCOMPLETE)
Message-ID: <YrpMIcECVOMPVpJN@google.com>
References: <CAHk-=wiutNT47oNhyk_WvMj2qp4pehYFptXCUzW=u_2STLQiww@mail.gmail.com>
 <CAHk-=whX_=BNZ4kVEAu2NV3CMnhwsuYTyE65FQXUMx8VPNOAOA@mail.gmail.com>
 <87ilonuti2.fsf_-_@email.froward.int.ebiederm.org>
 <871qvbutex.fsf_-_@email.froward.int.ebiederm.org>
 <CAHk-=wg9eqtrpYrjJ=yobkwkTimWFtiDd_JOfADttG0fyAJrqg@mail.gmail.com>
 <YrjAJN7dDJ9R7Ocu@mtj.duckdns.org>
 <Yrlavf4Ymnz4T3LM@hirez.programming.kicks-ass.net>
 <YrlmOA/Xd+U7+b2E@mtj.duckdns.org>
 <YrnxHBoi6sO0vqV0@google.com>
 <Yrop5Wzc72GIREVv@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yrop5Wzc72GIREVv@hirez.programming.kicks-ass.net>
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

On Tue, Jun 28, 2022 at 12:06:29AM +0200, Peter Zijlstra wrote:
> On Mon, Jun 27, 2022 at 06:04:12PM +0000, Wedson Almeida Filho wrote:
> 
> >   let new_thread = task::new_paused(|| pr_info!("Hello world\n"))?;
> 
> I'm still having a really hard time with this Rust stuff, the above
> looks like a syntax error and random characters to me :/

Peter, I meant to ask in my previous email: setting aside the syntax for
a moment, do you have an opinion on the sort of things that Rust allows
us to enforce at compile time (as exemplified in the new_paused()
fragment)?
