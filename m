Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0D250C101
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 23:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiDVVS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 17:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiDVVS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 17:18:56 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12FF27AAA1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:14:08 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id a15so8944820pfv.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A1ANqscgWrr+i9qXJ4NjdbCbnC9Em60ZXs/L6LLEDPQ=;
        b=hee5401YfY3mM159bKwgJ4bIEqeQkj173uXYT7dPpJ5azX964g02koFtEcAuIfLTj+
         rlpNWNBUKof8UwQvg817MhGdA8by3djJRqMt/pdn1mjkj/FmSb+irGhbmhWU0wc6tnCu
         0Pf70dD6VTbb/cnJZGxrY7M6wH4w/6WjkeYsqAtKl9xDrlijhoquGWF+F4uhCxQk1Lw3
         vfLCi8oqj72wZJN0S4ZzitmGgeBa/4r7zsSRYM5D6K5KmYuqJnuGTwFJxGeTQW7YE4rO
         me/rRwHzVCHcoJppCgl5ncYeL2fKRs4DIST51lgeMzb51bDZKWngVFa9r78l1TrH00PT
         kKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=A1ANqscgWrr+i9qXJ4NjdbCbnC9Em60ZXs/L6LLEDPQ=;
        b=1C2mzpZu4GHCejhJyUlqp6RaN1bxleaVd1Rj0Hvvo/33AeLVoNFaK32LUYhMlhn68u
         DKJUMo+e/F3/pGK+jN5oW2u2say5GfLWSixi2LXM9xBULfV7Oy2L+6s/s+0K3sRT6tGk
         lcoofFX5PXqkv+zctZHf8zo8bao6VppOXJ289f+q/EZTynxpeR261QUg4+GQ8lTZATXy
         dtQSH2sL3FgftDORu5rAn5STgys8zHdVY/Ir/f5hD6TERHkTuI0F6KfM160J59bPDitO
         q9dbUrMv2J7cMq34+WdwptBMLAz3mDPcZ7//PpeES04RltO4QAUQR0GTnImxZ8nRUWTI
         Wohw==
X-Gm-Message-State: AOAM533gtdHdRIglWKbhceya7mlH3Q9nDQwVD1YNGouZmqvrYWAndoXI
        UfjLUxECLhYCWb2BFDypRm4LJvNRFsA=
X-Google-Smtp-Source: ABdhPJx+WS6Nuywl3yCzbvZFN3i8d1cDPEY8/qA+T8UpuC+zaV8L0Hp+W3He9um9IFbfbECC1bs4XQ==
X-Received: by 2002:a05:6a00:1307:b0:4b0:b1c:6fd9 with SMTP id j7-20020a056a00130700b004b00b1c6fd9mr6559976pfu.27.1650658179194;
        Fri, 22 Apr 2022 13:09:39 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:2194:db4:85a8:b0df])
        by smtp.gmail.com with ESMTPSA id i22-20020a17090a7e1600b001b917d4a1a6sm6789977pjl.2.2022.04.22.13.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 13:09:38 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 22 Apr 2022 13:09:36 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Jirka Hladky <jhladky@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev,
        Justin Forbes <jforbes@fedoraproject.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: PANIC: "Oops: 0000 [#1] PREEMPT SMP PTI" starting from 5.17 on
 dual socket Intel Xeon Gold servers
Message-ID: <YmMLgHnxoTC1idCE@google.com>
References: <YkTxox8ZQIDtojfU@google.com>
 <CAFxkdAq6r2WnwML-pPfdZiajaYZCEcUU3GrXW=+wsA7CxGnJdQ@mail.gmail.com>
 <CAE4VaGBchOMWeHQ8GKiGFv_aCaNGLEvSdLWXZTpE+qC=0bgM3A@mail.gmail.com>
 <YkY6W1NS+1RTw0VB@google.com>
 <CAE4VaGDAMZqjwumyvbityzEiK30=5a5vuDMjaS+UHM39R-oPRw@mail.gmail.com>
 <YkstxbC3OfzYnSRw@google.com>
 <CAE4VaGAQZcQzN8D+iwcBnP5vY=Ctmbh+oTikvONHir6JjTgpsw@mail.gmail.com>
 <YmGKrd1BR9HSEy6q@slm.duckdns.org>
 <YmLznjFdpblHzZiM@google.com>
 <56ac17fd-5f13-840c-09d8-03363af94520@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56ac17fd-5f13-840c-09d8-03363af94520@leemhuis.info>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 08:44:17PM +0200, Thorsten Leemhuis wrote:
> On 22.04.22 20:27, Minchan Kim wrote:
> > On Thu, Apr 21, 2022 at 06:47:41AM -1000, Tejun Heo wrote:
> > [...]
> 
> Many thx for looking into this.
> 
> > Jirka, Could you test the patch? Once it's confirmed, I need to resend
> > it with Ccing stable.
> 
> When you do so, could you please include a proper "Link:" tag pointing
> to all reports of the regression, as explained in the Linux kernels
> documentation (see 'Documentation/process/submitting-patches.rst' and
> 'Documentation/process/5.Posting.rst'). E.g. in this case:
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215696
> Link:
> https://lore.kernel.org/lkml/CAE4VaGDZr_4wzRn2___eDYRtmdPaGGJdzu_LCSkJYuY9BEO3cw@mail.gmail.com/

Sure. Will do that.

> 
> This concept is not new (Linus and quite a few other developers use them
> like this for a long time), I just recently improved those documents to
> clarify things, as my regression tracking efforts rely on this (and
> there might be other people and software out there that does) -- that's
> why it's making my work a lot harder if such tags are missing. :-/
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> 
> P.S.: As the Linux kernel's regression tracker I'm getting a lot of
> reports on my table. I can only look briefly into most of them and lack
> knowledge about most of the areas they concern. I thus unfortunately
> will sometimes get things wrong or miss something important. I hope
> that's not the case here; if you think it is, don't hesitate to tell me
> in a public reply, it's in everyone's interest to set the public record
> straight.
> 
> > [...]
