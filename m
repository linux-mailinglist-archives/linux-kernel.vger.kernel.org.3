Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620C450EBF3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 00:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237295AbiDYW1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 18:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343576AbiDYViV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 17:38:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6BC2F344F3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 14:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650922511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pqkpreHZ3ia1bBtuPwaW+iRirP2OMqrmhar4b0pBnO4=;
        b=MECXLQl96irprC7EnDVPWC4EeTR3TzYmlrjVKKTt61bjpiYtsj8xMydQNkITM6ZnZqn9s2
        EYmH+g1b4mgsZTN32R8j4CXxsahLvvNpM4tQeG1TyTEvvah85N7dN6bpk2I0W20hmpInCR
        aBwui69w8fN27Th2E2poBz02/Lik6SI=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-29-FAd9y9HOMEK_w7fMhA8VdA-1; Mon, 25 Apr 2022 17:35:09 -0400
X-MC-Unique: FAd9y9HOMEK_w7fMhA8VdA-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-2f4dfd09d7fso97135107b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 14:35:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pqkpreHZ3ia1bBtuPwaW+iRirP2OMqrmhar4b0pBnO4=;
        b=YJvcucUyrkL6/HMK6y70uc3/6Vka5F1scKqerg10jEBbx71mDSifjS5CPeFvpX0GjP
         smK4JzTkcl2AKj8S1TbvzdNsvLcIyJbhA/1wvXZiSVCIFaDhJ1K2135hq+P0j7pyeSd6
         le89CLimDY/8+edMVUZbBzMsoUK/eueGULfIi1QWLK3Kpv4GYb00PuaHYhXkenlI0ESn
         FDbCTUvBv4YwmiY7P3H2DXBdd8L+i6X80qB+FeL/+K6YlFe5YfnsJO2E+OiS7hgdj4GE
         6qn9fGdR1aUcxgadCAwgl4ct53c+1P4IbuuIB70RkfmYVjI0Zr2KzvcgG7Z+iUR7wHR0
         WEqg==
X-Gm-Message-State: AOAM532sji1pU6Vgqsu8ns7f2d2U8XUvvHnGwfnYmQQgO1OkFzPsTNq4
        Ev30UNCyLZIDNg8NdNnxf5lRAn1ZRO4vAHPb2xPoXhDTchtJ3e585f+eqtKWkgS/xr7cxlJ4JDe
        s2qgHVo1cqh4KfHSEILpVDQBA6zQLSnnKEqLS2CMH
X-Received: by 2002:a25:7c05:0:b0:644:dec5:6d6e with SMTP id x5-20020a257c05000000b00644dec56d6emr17770530ybc.598.1650922509383;
        Mon, 25 Apr 2022 14:35:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFgLItvHe1URsoiUCW7gsLEswPF2tcX6tz2ZSc39w9QlWCPdTn6wn183MkClVVeDddMYBNafGT9araXdpeh00=
X-Received: by 2002:a25:7c05:0:b0:644:dec5:6d6e with SMTP id
 x5-20020a257c05000000b00644dec56d6emr17770516ybc.598.1650922509168; Mon, 25
 Apr 2022 14:35:09 -0700 (PDT)
MIME-Version: 1.0
References: <YkTxox8ZQIDtojfU@google.com> <CAFxkdAq6r2WnwML-pPfdZiajaYZCEcUU3GrXW=+wsA7CxGnJdQ@mail.gmail.com>
 <CAE4VaGBchOMWeHQ8GKiGFv_aCaNGLEvSdLWXZTpE+qC=0bgM3A@mail.gmail.com>
 <YkY6W1NS+1RTw0VB@google.com> <CAE4VaGDAMZqjwumyvbityzEiK30=5a5vuDMjaS+UHM39R-oPRw@mail.gmail.com>
 <YkstxbC3OfzYnSRw@google.com> <CAE4VaGAQZcQzN8D+iwcBnP5vY=Ctmbh+oTikvONHir6JjTgpsw@mail.gmail.com>
 <YmGKrd1BR9HSEy6q@slm.duckdns.org> <YmLznjFdpblHzZiM@google.com>
 <56ac17fd-5f13-840c-09d8-03363af94520@leemhuis.info> <YmMLgHnxoTC1idCE@google.com>
In-Reply-To: <YmMLgHnxoTC1idCE@google.com>
From:   Jirka Hladky <jhladky@redhat.com>
Date:   Mon, 25 Apr 2022 23:34:58 +0200
Message-ID: <CAE4VaGBnrfU09WU=VCqge8cN49wA31eF9=OYniE3PUrfbNyLsQ@mail.gmail.com>
Subject: Re: PANIC: "Oops: 0000 [#1] PREEMPT SMP PTI" starting from 5.17 on
 dual socket Intel Xeon Gold servers
To:     Minchan Kim <minchan@kernel.org>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev,
        Justin Forbes <jforbes@fedoraproject.org>,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Minchan,

I have tested the proposed patch and it fixes the issue!

Thanks a lot for your help!
Jirka


On Fri, Apr 22, 2022 at 10:09 PM Minchan Kim <minchan@kernel.org> wrote:
>
> On Fri, Apr 22, 2022 at 08:44:17PM +0200, Thorsten Leemhuis wrote:
> > On 22.04.22 20:27, Minchan Kim wrote:
> > > On Thu, Apr 21, 2022 at 06:47:41AM -1000, Tejun Heo wrote:
> > > [...]
> >
> > Many thx for looking into this.
> >
> > > Jirka, Could you test the patch? Once it's confirmed, I need to resend
> > > it with Ccing stable.
> >
> > When you do so, could you please include a proper "Link:" tag pointing
> > to all reports of the regression, as explained in the Linux kernels
> > documentation (see 'Documentation/process/submitting-patches.rst' and
> > 'Documentation/process/5.Posting.rst'). E.g. in this case:
> >
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=215696
> > Link:
> > https://lore.kernel.org/lkml/CAE4VaGDZr_4wzRn2___eDYRtmdPaGGJdzu_LCSkJYuY9BEO3cw@mail.gmail.com/
>
> Sure. Will do that.
>
> >
> > This concept is not new (Linus and quite a few other developers use them
> > like this for a long time), I just recently improved those documents to
> > clarify things, as my regression tracking efforts rely on this (and
> > there might be other people and software out there that does) -- that's
> > why it's making my work a lot harder if such tags are missing. :-/
> >
> > Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> >
> > P.S.: As the Linux kernel's regression tracker I'm getting a lot of
> > reports on my table. I can only look briefly into most of them and lack
> > knowledge about most of the areas they concern. I thus unfortunately
> > will sometimes get things wrong or miss something important. I hope
> > that's not the case here; if you think it is, don't hesitate to tell me
> > in a public reply, it's in everyone's interest to set the public record
> > straight.
> >
> > > [...]
>


-- 
-Jirka

