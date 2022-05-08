Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809EA51F1B5
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 22:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbiEHUzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 16:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbiEHUzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 16:55:54 -0400
Received: from relay4.hostedemail.com (relay4.hostedemail.com [64.99.140.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975F9B84B
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 13:52:03 -0700 (PDT)
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay06.hostedemail.com (Postfix) with ESMTP id 5D82630341;
        Sun,  8 May 2022 20:52:02 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf16.hostedemail.com (Postfix) with ESMTPA id 0F54C20014;
        Sun,  8 May 2022 20:51:55 +0000 (UTC)
Message-ID: <b8feb625dd2ba0d0dfc298a2f39ca1d8368ba5c9.camel@perches.com>
Subject: Re: [PATCH mm] tracing: incorrect gfp_t conversion
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Vasily Averin <vvs@openvz.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date:   Sun, 08 May 2022 13:51:55 -0700
In-Reply-To: <20220507154835.4d4d737d8eed579969f15938@linux-foundation.org>
References: <e1c09bbb-2c58-a986-c704-1db538da905a@openvz.org>
         <331d88fe-f4f7-657c-02a2-d977f15fbff6@openvz.org>
         <20220507123728.f20d977eba9fbb66bddee722@linux-foundation.org>
         <8b1cfefa-da7d-3376-cf04-1ff77dab8170@openvz.org>
         <20220507154835.4d4d737d8eed579969f15938@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: er99cw5hspnhcj3yju1mp5g1ptmr9tsf
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 0F54C20014
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18Yu0PF9VUwVKahCSWHsG2R6SAcUhY02Eo=
X-HE-Tag: 1652043115-837159
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-05-07 at 15:48 -0700, Andrew Morton wrote:
> On Sun, 8 May 2022 01:28:58 +0300 Vasily Averin <vvs@openvz.org> wrote:
> 
> > On 5/7/22 22:37, Andrew Morton wrote:
> > > On Sat, 7 May 2022 22:02:05 +0300 Vasily Averin <vvs@openvz.org> wrote:
> > > > +	{(__force unsigned long)GFP_KERNEL,		"GFP_KERNEL"},		\
> > > > +	{(__force unsigned long)GFP_NOFS,		"GFP_NOFS"},		\
> > > 
> > > This got all repetitive, line-wrappy and ugly :(
> > > 
> > > What do we think of something silly like this?
> > 
> > > --- a/include/trace/events/mmflags.h~tracing-incorrect-gfp_t-conversion-fix
> > > +++ a/include/trace/events/mmflags.h
> > > @@ -13,53 +13,57 @@
> > >   * Thus most bits set go first.
> > >   */
> > >  
> > > +#define FUL __force unsigned long
> > > +
> > >  #define __def_gfpflag_names						\
> > > -	{(__force unsigned long)GFP_TRANSHUGE,		"GFP_TRANSHUGE"},	\
> > > -	{(__force unsigned long)GFP_TRANSHUGE_LIGHT,	"GFP_TRANSHUGE_LIGHT"}, \
> > ...
> > > +	{(FUL)GFP_TRANSHUGE,		"GFP_TRANSHUGE"},	\
> > > +	{(FUL)GFP_TRANSHUGE_LIGHT,	"GFP_TRANSHUGE_LIGHT"}, \
> > 
> > 
> > I think it's a good idea, and I regret it was your idea and not mine.
> 
> heh
> 
> > Should I resend my patch with these changes or would you prefer 
> > to keep your patch as a separate one?
> 
> I did the below.  I'll squash them together later.

Very repetitive indeed.

Why not use another stringifying macro?

Maybe something like:

#define gfpflag_string(GFP)	\
	{(__force unsigned long)GFP, #GFP)}

#define __def_gfpflag_names			\
	gfp_flag_string(GFP_TRANSHUGE),		\
	etc...


