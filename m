Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA796561ACB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 14:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235134AbiF3Myj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 08:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbiF3Myh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 08:54:37 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306DC427FE
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 05:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1656593676;
  x=1688129676;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=00xPuIlNNMZ8E6p+AtWP/6zDNpgBkiHKeyoEzjO0F/o=;
  b=oxnbg2MquyZ0Epj7DQMA3e9GOAvS7pcQTtfkPtIexZrA9F51OU8gNGhH
   Ft2dXajP/ljTFcasdLqvq/UbbWRi/7Blpb0JRYShbzWcin3xes+Y4Gcmx
   N9JPwL3aycuYO+pGP7CuXKWFj3rAmU7HectGYb6o96bYW2eUWB3dVGu2+
   gw7R2QXiDULtBi3imc4Ebm7eVurTDqCf262wQKzyw1kmU0tgBKCCYwmj0
   W960Y4OM077TlkCkDzPtD6xEwePeyRMITZBI3xS+4nKCKECQuA8Bh1wAD
   BtbKnAGkBu5XqyYrL26igKrFbmOeZSinaRYqXI0/PRA+Hj1GxpqMYKGXs
   A==;
Date:   Thu, 30 Jun 2022 14:54:34 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Dmitry Vyukov <dvyukov@google.com>
CC:     David Gow <davidgow@google.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Patricia Alfonso <trishalfonso@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        "anton.ivanov@cambridgegreys.com" <anton.ivanov@cambridgegreys.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Latypov <dlatypov@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>
Subject: Re: [PATCH v4 2/2] UML: add support for KASAN under x86_64
Message-ID: <20220630125434.GA20153@axis.com>
References: <20220630080834.2742777-1-davidgow@google.com>
 <20220630080834.2742777-2-davidgow@google.com>
 <CACT4Y+ZahTu0pGNSdZmx=4ZJHt4=mVuhxQnH_7ykDA5_fBJZVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZahTu0pGNSdZmx=4ZJHt4=mVuhxQnH_7ykDA5_fBJZVQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 11:41:04AM +0200, Dmitry Vyukov wrote:
> On Thu, 30 Jun 2022 at 10:08, David Gow <davidgow@google.com> wrote:
> > diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
> > index 1c2d4b29a3d4..a089217e2f0e 100644
> > --- a/arch/um/kernel/Makefile
> > +++ b/arch/um/kernel/Makefile
> > @@ -27,6 +27,9 @@ obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
> >  obj-$(CONFIG_STACKTRACE) += stacktrace.o
> >  obj-$(CONFIG_GENERIC_PCI_IOMAP) += ioport.o
> >
> > +KASAN_SANITIZE_stacktrace.o := n
> > +KASAN_SANITIZE_sysrq.o := n
> 
> Why are these needed?
> It's helpful to leave some comments for any of *_SANITIZE:=n.
> Otherwise later it's unclear if it's due to some latent bugs, some
> inherent incompatibility, something that can be fixed, etc.

I believe I saw the stacktrace code itself triggering KASAN splats and
causing recursion when sanitization was not disabled on it.  I noticed
that other architectures disabled sanitization of their stacktrace code,
eg. ARM in commit 4d576cab16f57e1f87978f ("ARM: 9028/1: disable KASAN in
call stack capturing routines"), so I did not investigate it further.

(Note that despite the name, sysrq.c is also just stacktrace code.)
