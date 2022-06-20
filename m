Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5AB551436
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 11:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239987AbiFTJY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 05:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbiFTJYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:24:23 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A037D11814
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:24:22 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id hv24-20020a17090ae41800b001e33eebdb5dso11728528pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=szD84NW83cVtv82n5OVU6Bl02EDL48mPjF9aZDZgfQ0=;
        b=hKoNa3smMjr3Cp/1VKLsnoYUtQ8+HULkfzWUN/+B9vHKdAS09tXTG4QiudHlCorN77
         y6d6ugEWIdyXJHaBge9HAmMopS6lQUgj/RggPhMK2og+Ie1qOdzUne1MkzazXSCCTc4J
         7MTY31EcD38O9NEexFqJrGqAIW2XdIVPdlcI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=szD84NW83cVtv82n5OVU6Bl02EDL48mPjF9aZDZgfQ0=;
        b=XrYLDQE1YGyXk2dr9XZSQE26AMFmDFvGJQgi35fx1UrWEnXepgBORrx7AbvFi0EA73
         rBmbffCEIBsExU/KGMCKvDnsSLAzN8Xd8IYIylPmNCrGT65JUoH39AB0BaWGX/zVERky
         uJ1OsYl4e0DeLhALano2xLVr1CPLoBqj5wqJ5O7n/MmZ//g5npQKeFEGRtRwrkGwhiv3
         j5jKM58KEvsd10ZMRAAlszVKk+QMMykOU8KgnKNLGdsjvQpC5zpPCoVhWXvyCzcA87NE
         dpnnEbVvtI76YDmQLHBYnvHSuWTyTT851npKgLMHdVr1ZCnsfok8xccbJ1BbgCUIlzV4
         VkAg==
X-Gm-Message-State: AJIora+RQaokRPUSXm6RfNETtohilW1jsaaY9IxbdM8BRVB5jvcXIlGQ
        sZa5IipTMTCp6KK1T/+ehCIqGJtkzwtRIA==
X-Google-Smtp-Source: AGRyM1tM0BOvsvYZnqUzt6qkw0KDqrbe+a0xJSkBjPzhfBacxW6h+Kji+ZNJJbrTSlvA1vUv0fPzQQ==
X-Received: by 2002:a17:90b:48cf:b0:1e8:9438:ce13 with SMTP id li15-20020a17090b48cf00b001e89438ce13mr25758776pjb.235.1655717062022;
        Mon, 20 Jun 2022 02:24:22 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:7080:f919:392f:bc5c])
        by smtp.gmail.com with ESMTPSA id l4-20020a170903120400b001638a171558sm8205254plh.202.2022.06.20.02.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 02:24:21 -0700 (PDT)
Date:   Mon, 20 Jun 2022 18:24:15 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        syzbot <syzbot+3cc1054e15babd5f4cd2@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, glider@google.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        john.ogness@linutronix.de, linux-kernel@vger.kernel.org,
        npiggin@gmail.com, pmladek@suse.com, rdunlap@infradead.org,
        rostedt@goodmis.org, swboyd@chromium.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] possible deadlock in console_lock_spinning_enable (2)
Message-ID: <YrA8vzVjxJIrZFBz@google.com>
References: <0000000000007ba8cd05d0c1c3b0@google.com>
 <00000000000071951f05e1c4d7c8@google.com>
 <YrAJNuGg8n6f9Fcw@google.com>
 <CACT4Y+aFArPDsyvpNko+_eZi=1UTd2NxfejiyawRA0aKScWmJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+aFArPDsyvpNko+_eZi=1UTd2NxfejiyawRA0aKScWmJA@mail.gmail.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/06/20 10:16), Dmitry Vyukov wrote:
> On Mon, 20 Jun 2022 at 07:44, Sergey Senozhatsky
> <senozhatsky@chromium.org> wrote:
> >
> > On (22/06/18 20:47), syzbot wrote:
> > > syzbot suspects this issue was fixed by commit:
> > >
> > > commit faebd693c59387b7b765fab64b543855e15a91b4
> > > Author: John Ogness <john.ogness@linutronix.de>
> > > Date:   Thu Apr 21 21:22:36 2022 +0000
> > >
> > >     printk: rename cpulock functions
> >
> > I'd rather guess that it was console kthread patch that fixed the problem.
> 
> Hi Sergey,
> 
> Do you mean this commit:
> 
> author: John Ogness 2022-04-21 23:28:48 +0206
> printk: add kthread console printers
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=09c5ba0aa2fcfdadb17d045c3ee6f86d69270df7

Yes, I'd assume so. The patch removes

	tty -> printk -> tty

which re-enters tty in unsafe manner, and replaces it with

	tty -> printk -> wake_up console printer
