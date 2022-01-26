Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E146049D29D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 20:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244483AbiAZTmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 14:42:03 -0500
Received: from linux.microsoft.com ([13.77.154.182]:33272 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbiAZTmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 14:42:02 -0500
Received: from kbox (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id F31F520B6C61;
        Wed, 26 Jan 2022 11:42:01 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F31F520B6C61
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1643226122;
        bh=GQsjA0Zi3xGMLtKkvPmpas2no5KqOyzZf6JJLTyRjcA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sLyHbYBUphkL/qvthcOZh3zJEMIZLZw9vAHuW8dNKIYzapXzwhVYEG3iR4pr99JcV
         YZ56i2/YBJzJmTmWokxp91i0ihULT+NAf3GIV9ocFdApKIUa8VH1LgJWr0ENHx4rnC
         ITqNbRoEJwYq+qI3YGHFzLBDKAEy2yXT+exyXRy8=
Date:   Wed, 26 Jan 2022 11:41:38 -0800
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the kspp tree
Message-ID: <20220126194138.GA4298@kbox>
References: <20220125233154.dac280ed36944c0c2fe6f3ac@kernel.org>
 <202201251256.CCCBE9851E@keescook>
 <20220125162326.3d1ca960@gandalf.local.home>
 <20220125162859.2b3cc8a0@gandalf.local.home>
 <202201251402.0FB08DB@keescook>
 <20220125172114.6807ed8f@gandalf.local.home>
 <20220126093538.893fb44a7cb0a7cd840c7fdb@kernel.org>
 <20220125201634.698cc777@gandalf.local.home>
 <202201251917.18361B4F6@keescook>
 <20220125222545.353fa400@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125222545.353fa400@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 10:26:11PM -0500, Steven Rostedt wrote:
> On Tue, 25 Jan 2022 19:18:53 -0800
> Kees Cook <keescook@chromium.org> wrote:
> 
> > On Tue, Jan 25, 2022 at 08:16:34PM -0500, Steven Rostedt wrote:
> > > On Wed, 26 Jan 2022 09:35:38 +0900
> > > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > >   
> > > > I think Kees' idea seems better. If you and Beau are good, I will update
> > > > the macros for __rel_loc. (This requires to change some user-space
> > > > application which Beau is making too.)  

I like the simplicity of using offset from the start of data, however,
we would have to save the start of data somewhere for this. The user
trace processing side won't know the size of the common header (unless I
missed something elsewhere got added).

Due to this, I would *prefer* to have the offset still be the offset
from the __rel_loc entry. That makes it absolutely clear to both user and
kernel without requiring any additional information where to find it.

> > > 
> > > If Beau is OK with it, I'm OK with it too. I need to release a new version
> > > of libtraceevent anyway, and I can make the update for that too.
> > > 
> > > Who's adding the patch (if Beau says it's OK), you or Kees?  
> > 
> > I don't know anything about libtraceevent, so hopefully not me! :) The
> > patches Masami and I already sent fix the warning, so I leave it you
> > y'all to decide if you want to make the internals a bit simpler.
> > 
> 
> 
> Thinking about this more. I may just take both your patches, and leave it
> as an offset from the location of the descriptor. It's closer to the
> meaning of "relative" than doing it as a fixed offset from data.
> 
> And then no other patches or user space needs to be changed.
> 

Right, and on the user side we will not know the start of the "data" /
fixed offset without carrying back that information somehow, due to the
common header size not being a fixed length forever.

> Thanks,
> 
> -- Steve

Thanks,
-Beau
