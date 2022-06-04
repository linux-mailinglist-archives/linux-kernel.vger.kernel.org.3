Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2DC553D41F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 02:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349831AbiFDAnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 20:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbiFDAna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 20:43:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7287B222AD;
        Fri,  3 Jun 2022 17:43:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A56D60F1B;
        Sat,  4 Jun 2022 00:43:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11C97C385A9;
        Sat,  4 Jun 2022 00:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654303407;
        bh=F/7tG3AfY4gxUo4vwXg4EDogcdpmyXjXiWT5c2u2dCA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CkP/EXTojeoZMqUP6WS+EqxSwP421kb1mEWFdRdtFY2YiO+Z3Y9PB9iv/BSG6uqXP
         XeX9ykb+5vSSHtXDft9wqrvw6J2VRURyYBTrGX95ONov5u4cisLmkL5yhjOts4OgGL
         8XfnNjiVYzbc9Vgee84VdumklF557aJXEFm0npkDPlDNoMcQkf0sbTlBxil23swsyT
         78jF/HURa7NouGjM5LQapF7NQYdS3e/BJIEcXd+NGL+4JW0xzywakfGtTsBACjE27n
         Ld1LJYK8UmzrM3DtBUVv7jy/kZ/F6QkpO3oBuH8UUbMlJ+k3P0TYQbsO+7yaztFLI2
         iIjS+cE5D2n+w==
Date:   Sat, 4 Jun 2022 01:43:17 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Shah <aams@amazon.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Solar Designer <solar@openwall.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Will Deacon <will@kernel.org>, Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH] Documentation/security-bugs: overhaul
Message-ID: <20220604014317.79eb23db@sal.lan>
In-Reply-To: <87fsko48xh.fsf@meer.lwn.net>
References: <20220531230309.9290-1-vegard.nossum@oracle.com>
        <87fsko48xh.fsf@meer.lwn.net>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 01 Jun 2022 10:58:50 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Vegard Nossum <vegard.nossum@oracle.com> writes:
> 
> > The current instructions for reporting security vulnerabilities in the
> > kernel are not clear enough, in particular the process of disclosure
> > and requesting CVEs, and what the roles of the different lists are and
> > how exactly to report to each of them.
> >
> > Let's give this document an overhaul. Goals are stated as a comment at
> > the top of the document itself (these will not appear in the rendered
> > document).  
> 
> OK, some other thoughts...
> 
> [...]
> 
> > +Linux kernel security team at security@kernel.org, henceforth "the
> > +security list". This is a closed list of trusted developers who will
> > +help verify the bug report and develop a patch.
> > +
> > +While the security list is closed, the security team may bring in
> > +extra help from the relevant maintainers to understand and fix the
> > +security vulnerability.
> > +
> > +Note that the main interest of the kernel security list is in getting
> > +bugs fixed; CVE assignment, disclosure to distributions, and public
> > +disclosure happens on different lists with different people.  
> 
> Adding "as described below" or some such might be helpful for readers
> who are mostly interested in those things.  
> 
> > +Here is a quick overview of the various lists:
> > +
> > +.. list-table::
> > +   :widths: 35 10 20 35
> > +   :header-rows: 1
> > +
> > +   * - List address
> > +     - Open?
> > +     - Purpose
> > +     - Members
> > +   * - security@kernel.org
> > +     - Closed
> > +     - Reporting; patch development
> > +     - Trusted kernel developers
> > +   * - linux-distros@vs.openwall.org
> > +     - Closed
> > +     - Coordination; CVE assignment; patch development, testing, and backporting
> > +     - Linux distribution representatives
> > +   * - oss-security@lists.openwall.com
> > +     - Public
> > +     - Disclosure
> > +     - General public  
> 
> Please don't use list-table, that's totally unreadable in the plain-text
> format.  How about something like:
> 
>  =============================== ===== ================= ===============
>  List address                    Open? Purpose           Members
>  =============================== ===== ================= ===============
>  security@kernel.org                no Reporting         Trusted kernel
>                                                          developers
>                                        Patch development
>  linux-distros@vs.openwall.org      no Coordination      Distribution 
>                                                          representatives
>                                        CVE assignment
>                                        Patch development
>                                        Testing
>                                        Backporting
>  oss-security@lists.openwall.com   yes Disclosure        General public
>  =============================== ===== ================= ===============
> 
> (Note I haven't tried to format this, there's probably an error in there
> somewhere). 

Yeah, I guess the right syntax is something like:

  =============================== ===== ================= ===============
  List address                    Open? Purpose           Members
  ------------------------------- ----- ----------------- ---------------
  security@kernel.org                no Reporting         Trusted kernel
                                                          developers
                                        Patch development
  linux-distros@vs.openwall.org      no Coordination      Distribution 
                                                          representatives
                                        CVE assignment

                                        Patch development

                                        Testing

                                        Backporting
  oss-security@lists.openwall.com   yes Disclosure        General public
  =============================== ===== ================= ===============

Regards,
Mauro
