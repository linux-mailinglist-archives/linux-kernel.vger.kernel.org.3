Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17B256BDFA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 18:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238448AbiGHPyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 11:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238231AbiGHPyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 11:54:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0453070E56;
        Fri,  8 Jul 2022 08:54:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8122D61627;
        Fri,  8 Jul 2022 15:54:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B32C341C0;
        Fri,  8 Jul 2022 15:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657295655;
        bh=iLR0PBjtzcQHZ8I6cmvlIl/1ubOtBKp214rW7GPgt0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g8m0mmGWAah9lT1Bsw24STNVGlhp7gkQ2Eh629fjj1zAjLGMz0QHdOb2vxpx0ZyBv
         EFqcjwUU+9g0Ob7BSm+TmldqNMHgTDcNBK0GCWApRieMZBcVYXLk34Bp+W6uySeAhg
         7ij9js5JyNVBin0F1DZI+cK8M+sDdCS+7Y7GdRBdEPvP8sYCIMz6oiBQZ6P5Rl2DWp
         UWMYA5JJcKI8QzVp/fgV/MFTzV4s7UnHlt0/RrPpSMAvYb+MzEwM/I+xNLDFqDtXsm
         VKttXAYj954bYMxYi9sZ6VsLQxoXM/GbBMzVAcph6AiIuBcrvWgRvHNxehNQ8Aemur
         JgLqoKawesxEg==
Received: by pali.im (Postfix)
        id 3E1577D1; Fri,  8 Jul 2022 17:54:13 +0200 (CEST)
Date:   Fri, 8 Jul 2022 17:54:13 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] serial: Fix support for UPF_SPD_* flags
Message-ID: <20220708155413.rlc3iyf72tdwthfa@pali>
References: <20220321163055.4058-1-pali@kernel.org>
 <CAHp75VddDG-ZJpbAb5ZhKaMpP0L+CMEx2pcYy3FOMiaxNydCWA@mail.gmail.com>
 <YmK7drS0XgnTQcaf@kroah.com>
 <20220707084840.jvsstvyx2ul5ltb6@pali>
 <YsgsH94PV/wAX0Vu@kroah.com>
 <20220708132621.4v2es73h52aq3izn@pali>
 <Ysg2RW0B/cLL3k+k@kroah.com>
 <20220708142001.7fciqnfckznlvsa4@pali>
 <CAHp75Vci1zeDV1axd_v_PLLPGfF5AzAzmmcegjD1djqnR6XUcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vci1zeDV1axd_v_PLLPGfF5AzAzmmcegjD1djqnR6XUcA@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 July 2022 17:42:03 Andy Shevchenko wrote:
> On Fri, Jul 8, 2022 at 4:20 PM Pali Rohár <pali@kernel.org> wrote:
> > On Friday 08 July 2022 15:51:01 Greg Kroah-Hartman wrote:
> > > On Fri, Jul 08, 2022 at 03:26:21PM +0200, Pali Rohár wrote:
> > > > On Friday 08 July 2022 15:07:43 Greg Kroah-Hartman wrote:
> > > > > On Thu, Jul 07, 2022 at 10:48:40AM +0200, Pali Rohár wrote:
> > > > > > On Friday 22 April 2022 16:28:06 Greg Kroah-Hartman wrote:
> 
> ...
> 
> > > > > I'm not saying remove them, I'm saying let us not add any more
> > > > > dependancies on them in order to keep new applications from ever wanting
> > > > > to use them.
> > > >
> > > > Last time you wrote to remove them. Now saying not to remove them. So I
> > > > do not understand you now.
> 
> There was a _new_ addition of the ugly SPD_CUST, that's what I believe
> Greg opposes to. And I support that.

Which addition? I do not understand you. There was not any new driver
with introduction of SPD support.

> > > I'm sorry, I am totally lost.
> >
> > So look what you have wrote? Who is lost here is me.
> >
> > > How about starting over and resubmitting
> > > the changes you want and we can go from there.
> >
> > What to resubmit? I do not understand you. In case you lost emails or
> > accidentally removed them, you can look at them in archive, not? I hope
> > that you do not want me to copy+paste all existing patches with all your
> > quotes on them which you wrote into new emails.
> 
> That change that adds the new user of SPD_CUST?

What you are talking about? Which user?

> In any case the best summary about BOTHER I ever read is this [1] (and
> an initial steps in picocom [2]).

Is not that example in manpage enough?

> And I believe that instead of
> SPD_CUST we should get rid (or at least minimize) the problems with
> BOTHER in user space.

I looked into archives and seems that glibc people are not interested in
this area. And I'm not going to spend time on another project which seems
to be useless.

> [1]: https://github.com/npat-efault/picocom/blob/master/termios2.txt
> [2]: https://github.com/jmesmon/picocom/issues/2
> 
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
