Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7584556C0B9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239133AbiGHQ0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 12:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239186AbiGHQ0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 12:26:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8A16572;
        Fri,  8 Jul 2022 09:25:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1123B828B2;
        Fri,  8 Jul 2022 16:25:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14792C341C0;
        Fri,  8 Jul 2022 16:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657297536;
        bh=BKl4huNE8jVGrPim1/fgS41hxUonFYA6ZShuRZJwXc0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l9GpU5g+sF7l0ZyZ65XeWahelXzSuNwiDE5IzxFaxKAItbX4Ooc0GsdjaxaYOLWbZ
         4a/Eg7NjGPF9zmArgmQnmQEycldbsjryYJuC8V/qkBeuJWmeTcpldx+B3qZMpuSFRb
         t0G/7uWU4dZhuplMjqi/0u1kqVjuT6QpPk5rxvtrSJ+LNoaU44Aam51x3SHMZXX9EJ
         yxEz+l+aVYMY02F1ZdCZ1e7AruR6bqZAbveA2dzDsAeQc68oXxBLTl3hwvGlxUD1Qy
         rmSeqj2vwvlBG192vy7fQH50FVlOK0WI/iThdZOCi1Ze8/tJJbDbQKXSftg8HLJdlw
         qvvBAlb3SSAzw==
Received: by pali.im (Postfix)
        id 178E97D1; Fri,  8 Jul 2022 18:25:33 +0200 (CEST)
Date:   Fri, 8 Jul 2022 18:25:32 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] serial: Fix support for UPF_SPD_* flags
Message-ID: <20220708162532.jefbmpokampkuahv@pali>
References: <CAHp75VddDG-ZJpbAb5ZhKaMpP0L+CMEx2pcYy3FOMiaxNydCWA@mail.gmail.com>
 <YmK7drS0XgnTQcaf@kroah.com>
 <20220707084840.jvsstvyx2ul5ltb6@pali>
 <YsgsH94PV/wAX0Vu@kroah.com>
 <20220708132621.4v2es73h52aq3izn@pali>
 <Ysg2RW0B/cLL3k+k@kroah.com>
 <20220708142001.7fciqnfckznlvsa4@pali>
 <CAHp75Vci1zeDV1axd_v_PLLPGfF5AzAzmmcegjD1djqnR6XUcA@mail.gmail.com>
 <20220708155413.rlc3iyf72tdwthfa@pali>
 <CAHp75Vf=JGbmydAaeA=81YDViVtj7cG91Sr4teJ8mhFNH8AhAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vf=JGbmydAaeA=81YDViVtj7cG91Sr4teJ8mhFNH8AhAw@mail.gmail.com>
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

On Friday 08 July 2022 18:09:07 Andy Shevchenko wrote:
> On Fri, Jul 8, 2022 at 5:54 PM Pali Rohár <pali@kernel.org> wrote:
> > On Friday 08 July 2022 17:42:03 Andy Shevchenko wrote:
> > > On Fri, Jul 8, 2022 at 4:20 PM Pali Rohár <pali@kernel.org> wrote:
> > > > On Friday 08 July 2022 15:51:01 Greg Kroah-Hartman wrote:
> > > > > On Fri, Jul 08, 2022 at 03:26:21PM +0200, Pali Rohár wrote:
> > > > > > On Friday 08 July 2022 15:07:43 Greg Kroah-Hartman wrote:
> > > > > > > On Thu, Jul 07, 2022 at 10:48:40AM +0200, Pali Rohár wrote:
> > > > > > > > On Friday 22 April 2022 16:28:06 Greg Kroah-Hartman wrote:
> > >
> > > ...
> > >
> > > > > > > I'm not saying remove them, I'm saying let us not add any more
> > > > > > > dependancies on them in order to keep new applications from ever wanting
> > > > > > > to use them.
> > > > > >
> > > > > > Last time you wrote to remove them. Now saying not to remove them. So I
> > > > > > do not understand you now.
> > >
> > > There was a _new_ addition of the ugly SPD_CUST, that's what I believe
> > > Greg opposes to. And I support that.
> >
> > Which addition? I do not understand you. There was not any new driver
> > with introduction of SPD support.
> 
> You stated that SPD_CUST is broken in some drivers, so you are trying
> to fix a broken ugly hack. Why? Instead of making it rot and be
> removed eventually, you pump life into frankenstein.

Firstly I got rejection of my other patches because they does not handle
SDP_CUST correctly. So I decided to look at those issues and fix it via
helper function which can be easily reused in all drivers. So helper
function wrap all "ugly" hacks. Then I got reaction that SDP should be
removed. Then I got another reaction that that "I'm not saying to remove
them" and another another reaction why to be removed eventually.

So how should I interpret this? I'm feeling that you are just trying to
annoy people with this "do this", "do opposite", "do again it", "do
again opposite"...

> > > > > I'm sorry, I am totally lost.
> > > >
> > > > So look what you have wrote? Who is lost here is me.
> > > >
> > > > > How about starting over and resubmitting
> > > > > the changes you want and we can go from there.
> > > >
> > > > What to resubmit? I do not understand you. In case you lost emails or
> > > > accidentally removed them, you can look at them in archive, not? I hope
> > > > that you do not want me to copy+paste all existing patches with all your
> > > > quotes on them which you wrote into new emails.
> > >
> > > That change that adds the new user of SPD_CUST?
> >
> > What you are talking about? Which user?
> 
> This I missed, I was thinking that you are talking about a new user,
> now I read briefly and it seems that it's about an existing user.
> Anyway, that change I suppose.
> 
> > > In any case the best summary about BOTHER I ever read is this [1] (and
> > > an initial steps in picocom [2]).
> >
> > Is not that example in manpage enough?
> 
> Dunno.
> Can you point it out to me? I can't find it quickly.

Argh... Have you read emails to which you wrote reply? So copy+paste
relevant part from my previous email just for you:

 "New version of tcsetattr and ioctl_tty manpages would have documented
  how to use BOTHER (it is currently in the manpages git)."

Plus in past I also pointed to the extended version of that example from
manpage which is currently in my repo on github:
https://github.com/pali/linux-baudrate.git

> > > And I believe that instead of
> > > SPD_CUST we should get rid (or at least minimize) the problems with
> > > BOTHER in user space.
> >
> > I looked into archives and seems that glibc people are not interested in
> > this area. And I'm not going to spend time on another project which seems
> > to be useless.
> 
> So why should the kernel suffer if it already provides something good
> for the user and user space ignores that?

Because it is unusable? API which standard linux userspace applications
cannot use is useless. And for application develop it does not matter if
issue is in kernel part of API or userspace part of API. At the end
would be use used.

With whole this discussion I have feeling that there correct way is just
to use SDP flags in userspace as there is no interest in fixing BOTHER's
c_ospeed and c_ispeed in kernel drivers and it was rejected just because
of not handling SDP flags correctly.

> > > [1]: https://github.com/npat-efault/picocom/blob/master/termios2.txt
> > > [2]: https://github.com/jmesmon/picocom/issues/2
> 
> -- 
> With Best Regards,
> Andy Shevchenko
