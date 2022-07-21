Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41B557D19B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 18:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbiGUQdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 12:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbiGUQdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 12:33:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7024B89E98
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 09:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RhI3VCUzNHo5JklMmIqECqYQ6SyTPpDz3EAd2IXpnCc=; b=BBkvMnqQohd6YdtIM+p3u0mFPe
        E/h4AwZ7lEA/5Y8xtvIbzGvgnsQ+FNj4guVIegorCmbP5MBFp1kHxpemTERABuEqZ4J+T6nTXOP8r
        +zbgnboMaloQK6Jsb7IZMCf9fOJTn6xqhdyJHHC6fwJldazzKn5eN8AQlq8OKBOXxub0DtA13WpkP
        KMesSlG1Jiv3g7WQ9MkfnGGeOYl6POj7vOHgXKsJtpeI5YiIu/gqrCmn+9Ilr8CN85BUybrBHmFcN
        HpiYvHrU2IZfWFiAwCFzhy5BLLobYnR+0MAa4ELRT5DniZYFouSXRoEXrQLvT6GQ86CmgER+dYAtI
        aHKs3d0A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEZ6s-00A2Mo-7j; Thu, 21 Jul 2022 16:33:10 +0000
Date:   Thu, 21 Jul 2022 09:33:10 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Doug Anderson <dianders@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Khalid Masum <khalid.masum.92@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aaron Tomlin <atomlin@redhat.com>,
        kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH RESEND] scripts/gdb: Fix gdb 'lx-symbols' command
Message-ID: <Ytl/xkb9OC43dgJd@bombadil.infradead.org>
References: <20220721093042.9840-1-khalid.masum.92@gmail.com>
 <CAD=FV=UbRX194rDztr_=eoALg4kTmjzq=EXCX6RJSSq3vO=fbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=UbRX194rDztr_=eoALg4kTmjzq=EXCX6RJSSq3vO=fbw@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 09:24:31AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Thu, Jul 21, 2022 at 2:31 AM Khalid Masum <khalid.masum.92@gmail.com> wrote:
> >
> > Currently the command 'lx-symbols' in gdb exits with the error`Function
> > "do_init_module" not defined in "kernel/module.c"`. This occurs because
> > the file kernel/module.c was moved to kernel/module/main.c.
> >
> > Fix this breakage by changing the path to "kernel/module/main.c" in
> > LoadModuleBreakpoint.
> >
> > Signed-off-by: Khalid Masum <khalid.masum.92@gmail.com>
> > ---
> >  scripts/gdb/linux/symbols.py | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
> > index 46f7542db08c..dc07b6d12e30 100644
> > --- a/scripts/gdb/linux/symbols.py
> > +++ b/scripts/gdb/linux/symbols.py
> > @@ -180,7 +180,7 @@ lx-symbols command."""
> >                  self.breakpoint.delete()
> >                  self.breakpoint = None
> >              self.breakpoint = LoadModuleBreakpoint(
> > -                "kernel/module.c:do_init_module", self)
> > +                "kernel/module/main.c:do_init_module", self)
> 
> Fixes: cfc1d277891e ("module: Move all into module/")
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

This should go to Linus prior to the next rc.  Linus, I think this is
with picking up now as I smell a final release soon.

FWIW a git grep of "kernel/module\.c" reveals no other code users of
this path.

  Luis
