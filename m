Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032D456D118
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 21:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiGJTjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 15:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiGJTjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 15:39:46 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE8D14D39;
        Sun, 10 Jul 2022 12:39:44 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id f73so5685601yba.10;
        Sun, 10 Jul 2022 12:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jHig/kgCW9rPtBLTmyT6ZlPMMNP9pICXSeKn7E/q6GU=;
        b=Fk+voQovmCT95EZAP5dIwBiWwpfksM05+vO7WNxv4z+jWewvoGKeW9BYnwYiAL3Lt5
         NnKHpGsMR34gyvz0OO1QmecK0S26n3Lbbfuur3tSz1YU28eKxeJFMosnSrxe1+nbbgwc
         QFBaFLyPSiIzVDDa0U0ird0Yh9YUmFZjXEYjCnzHWkuh2ESgkivGydZ5m3fl7qhrlQL/
         30wS0ZQ9vjRsK3a3yG4AkgYFTozRA7rUpoEyZJMY0LET8xkV9fWy8Dn1RHalweG9Kb2S
         9oBMPy6/5t05e37OjTkLU+azjYy9IPD/CCxAJo9/OxXi3QFpXzkcpB74GM5lqaxhIC2n
         hUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jHig/kgCW9rPtBLTmyT6ZlPMMNP9pICXSeKn7E/q6GU=;
        b=WrB3O8fuJ8P2GUfOoExIxuiZlRiK/ciuQReS6tIBpHH/71KvSEuM5toOZUuTbSXlP0
         lGtca5fSNVXcFLYSJEFn1jjBsmd4pHIG3G3WgTRYBPKWzt8/NjFyzcPf7f3ebUGE2K5Z
         PjbQp365+yPzpqwY60wC5hUAdfUSNeXvR234zf447spzLkPxS51yU5cX7p50a4eTRqwK
         MoAyST+EDlOesxO8V1e50yq6CH1RloYnJ/zNF//F/At1b15wG4XNpq3qtrPXl8QmSPYc
         RSxU68+UoshklmSe6ix01KAHMuQIT85UhNvRMZseP4e2eVzXq7bXwrgYsV2b30YBWVqZ
         SiKg==
X-Gm-Message-State: AJIora+PrfgKFbVCYnmGennVQbbhv01mkSGm65AbUjuorp5PVhyhKMeX
        GJ9LZ8EHfZUael7XdIESnjszkPXkGndqg+uRa28=
X-Google-Smtp-Source: AGRyM1ueLrKTNFu8t419Verj8miOH/Kb/uR9xKk9ctJSVPuuKbdaLbhj10023Cfq3Ol7WXK26dXTYxFflLklyu8e0mA=
X-Received: by 2002:a05:6902:686:b0:66e:627f:4d29 with SMTP id
 i6-20020a056902068600b0066e627f4d29mr13182800ybt.385.1657481983485; Sun, 10
 Jul 2022 12:39:43 -0700 (PDT)
MIME-Version: 1.0
References: <12fb98fe27e23e3f74a139e5e8eb83a97a343372.camel@linux.intel.com>
 <51b9e2cc3baf61a604bd239b736ec2d12f1f6695.camel@linux.intel.com>
 <87czegxccb.fsf@jogness.linutronix.de> <045ebee30af2b80aaeace1dab18ecd113e3f17c7.camel@linux.intel.com>
 <87tu7qvx1q.fsf@jogness.linutronix.de>
In-Reply-To: <87tu7qvx1q.fsf@jogness.linutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 10 Jul 2022 21:39:07 +0200
Message-ID: <CAHp75VfyzMNMO2NRwXwSjAmQqBbdRG3+SzyFDG+90dmvmg1xLQ@mail.gmail.com>
Subject: Re: PNP0501 serial driver takes almost 2 seconds to suspend/resume
 (printk issue)
To:     John Ogness <john.ogness@linutronix.de>
Cc:     todd.e.brandt@linux.intel.com, Petr Mladek <pmladek@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 9, 2022 at 10:48 PM John Ogness <john.ogness@linutronix.de> wrote:
>
> On 2022-07-08, Todd Brandt <todd.e.brandt@linux.intel.com> wrote:
> > The dmesg logs are in the html timelines themselves, just click the
> > "dmesg" button in the upper right hand corner. The log button shows
> > all kinds of system info as well.
>
> Since the beginning of the kernel log is missing, I still do not see
> information about which serial driver you are using. But since it is
> x86, I'll assume it is an 8250.
>
> Looking at freeze-5.19.0-rc1-bad.html, at 3431.221039 we see that
> suspend_console() was called. The additional 1-second delay you are
> referring to would be 3432.436187, where serial is suspended. pr_flush()
> would have been satisfied when the message at 3431.221039 was
> printed. So the question is, why is there still printing going on?

It might be no_console_suspend hack. Are you, btw, aware of this ugly
hack in the kernel?

-- 
With Best Regards,
Andy Shevchenko
