Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B267C5454E0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 21:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344949AbiFITXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 15:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344809AbiFITXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 15:23:36 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DEAD01F4291;
        Thu,  9 Jun 2022 12:23:33 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 259JN8D5010797;
        Thu, 9 Jun 2022 21:23:08 +0200
Date:   Thu, 9 Jun 2022 21:23:08 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, keyrings@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Salvatore Bonaccorso <carnil@debian.org>,
        David Woodhouse <dwmw2@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [Linux v5.17.9] -Wdeprecated-declarations warnings with LLVM-14
 and OpenSSL v3.0.x
Message-ID: <20220609192308.GB10732@1wt.eu>
References: <CA+icZUUFdsEyNybVORm4x7_bAyoc0zTnudtNdgnTqjvbYXJRYA@mail.gmail.com>
 <CA+icZUWxyNeZnEBDpDWxGc-qJ-jHwR0rJMBhk1a8StPHRgC6qA@mail.gmail.com>
 <CA+icZUW7y3JxQ3dCB8Wy83EjEyYj7z55nFUw-kZ+V4We22HZZg@mail.gmail.com>
 <CA+icZUVyp2CdX7m72GY-=DtK9J+64uHeWPr5-cvo8haQm_4hUw@mail.gmail.com>
 <CA+icZUWiYYQbAav7VxVsT0ikqCeLckym08Au8oSeyYjvJHcNbg@mail.gmail.com>
 <CA+icZUUOQcc4uiVbv+tJzPr_ED7e4tD0u9tC8mcn2BRe3sdPAg@mail.gmail.com>
 <CAHk-=wiOrXUr0wqHL+hfkzGg_+b7UvtLeB=59KsX8W939bTY-A@mail.gmail.com>
 <CA+icZUUma1B8KFWF-ed9sjXH4QpCRZ+B2pON3uAFkTUs77tMzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUUma1B8KFWF-ed9sjXH4QpCRZ+B2pON3uAFkTUs77tMzw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 09:19:20PM +0200, Sedat Dilek wrote:
> On Thu, Jun 9, 2022 at 9:05 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Thu, Jun 9, 2022 at 11:41 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > >
> > > Why go back and forth... do it like Alexander the Great and the Gordian knot.
> > >
> > > Sword - Swash - Done.
> > >
> > > commit 6bfb56e93bcef41859c2d5ab234ffd80b691be35
> > > "cert host tools: Stop complaining about deprecated OpenSSL functions"
> >
> > Well, it's not like that is the *right* fix.
> >
> > But I think for now, the answer is "leave it like that until we can
> > just get rid of the ENGINE API entirely".
> >
> > I absolutely detest the "deprecation" warnings. We used to do that in
> > the kernel too, and it was a complete disaster. The warnings are very
> > noisy, and nobody ever cares about them, so it's simply not worth it.
> >
> > So we deprecated "__deprecated" in the kernel itself:
> >
> >   771c035372a0 deprecate the '__deprecated' attribute warnings
> > entirely and for good
> >
> > and I don't think we should care about it when it comes to OpenSSL either.
> >
> > Eventually, that deprecated interface will go away entirely, and by
> > then we hopefully don't care about really old openssl implementations
> > and will have gotten rid of the uses.
> >
> > But for now, I think putting our head in the sand is actually the
> > _better_ model rather than fighting some battle over old vs new
> > libraries.
> >
> > Because sometimes, if you ignore a problem, it really does just go away.
> >
> 
> To be honest: I like your approach, Linus.
> Very pragma-tic.
> That's why you use pragma's in your patch :-).
> 
> I invested too much of my lifetime in making things work "correctly".
> And yes, it's post-rc1...
> 
> Most of the apps in the Debian world passed the OpenSSL-v3 transition.

IIRC you can also disable the deprecation warnings by defining the
OPENSSL_SUPPRESS_DEPRECATED macro. It doesn't require to change the
compiler's options and allows us to put our head in the sand.

Willy
